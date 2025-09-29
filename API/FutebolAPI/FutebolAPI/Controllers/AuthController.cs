using FutebolAPI.DTOs;
using FutebolAPI.Models;
using FutebolAPI.Services;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace FutebolAPI.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class AuthController : ControllerBase
    {
        private readonly FutebolDbContext _context;
        private readonly IJwtService _jwtService;
        private readonly IPasswordHasher<User> _passwordHasher;

        public AuthController(
            FutebolDbContext context,
            IJwtService jwtService,
            IPasswordHasher<User> passwordHasher)
        {
            _context = context;
            _jwtService = jwtService;
            _passwordHasher = passwordHasher;
        }

        [HttpPost("register")]
        [AllowAnonymous]
        public async Task<IActionResult> Register([FromBody] RegisterRequest request)
        {
            if (!ModelState.IsValid)
                return BadRequest(ModelState);

            // Verifica se username ou email já existem
            if (await _context.Users.AnyAsync(u => u.Username == request.Username))
                return BadRequest(new { message = "Nome de usuário já existe" });

            if (await _context.Users.AnyAsync(u => u.Email == request.Email))
                return BadRequest(new { message = "Email já existe" });

            // Cria o novo usuário
            var user = new User
            {
                Id = Guid.NewGuid(),
                Username = request.Username,
                Email = request.Email,
                Role = "user", // Por padrão, novos usuários são "user"
                CreatedAt = DateTime.UtcNow,
                IsActive = true
            };

            // Hash da senha
            user.PasswordHash = _passwordHasher.HashPassword(user, request.Password);

            // Adiciona o usuário ao banco
            _context.Users.Add(user);
            await _context.SaveChangesAsync();

            return Ok(new { message = "Usuário registrado com sucesso" });
        }

        [HttpPost("login")]
        [AllowAnonymous]
        public async Task<IActionResult> Login([FromBody] LoginRequest request)
        {
            if (!ModelState.IsValid)
                return BadRequest(ModelState);

            // Busca o usuário pelo username
            var user = await _context.Users
                .FirstOrDefaultAsync(u => u.Username == request.Username);

            // Mensagem genérica para não revelar se o usuário existe
            if (user == null || !user.IsActive)
                return Unauthorized(new { message = "Nome de usuário ou senha inválidos" });

            // Verifica a senha
            var result = _passwordHasher.VerifyHashedPassword(user, user.PasswordHash, request.Password);
            if (result != PasswordVerificationResult.Success)
                return Unauthorized(new { message = "Nome de usuário ou senha inválidos" });

            // Gera token de acesso 
            var accessToken = _jwtService.GenerateToken(user);

            // Retorna a resposta de autenticação
            return Ok(new AuthResponse
            {
                AccessToken = accessToken,
                ExpiresIn = 7 * 24 * 60 * 60, // 7 dias em segundos
                User = new UserResponse
                {
                    Id = user.Id,
                    Username = user.Username,
                    Email = user.Email,
                    Role = user.Role
                }
            });
        }
    }
}