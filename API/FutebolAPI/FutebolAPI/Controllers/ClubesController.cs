using FutebolAPI.DTOs;
using FutebolAPI.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace FutebolAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ClubesController : ControllerBase
    {
        private readonly FutebolDbContext _context;

        public ClubesController(FutebolDbContext context)
        {
            _context = context;
        }

        // GET: api/Clubes?minTitulos=10 (opcional)
        [HttpGet]
        public async Task<ActionResult<IEnumerable<ClubeDTOs>>> GetClubes([FromQuery] int? minTitulos)
        {
            var query = _context.DimClubes.AsQueryable();

            // Se minTitulos foi fornecido, filtra os clubes
            if (minTitulos.HasValue)
            {
                query = query.Where(c => c.Titulos >= minTitulos);
            }

            var clubes = await query
                .Select(c => new ClubeDTOs
                {
                    TimeId = c.TimeId,
                    Nome = c.Nome,
                    Titulos = c.Titulos,
                    Participacoes = c.Participacoes,
                    Fundacao = c.Fundacao,
                    Sede = c.Sede,
                    Escudo = c.Escudo
                })
                .ToListAsync();

            if (clubes == null || !clubes.Any())
            {
                return NotFound();
            }

            return clubes;
        }

        // GET: api/Clubes/5
        [HttpGet("{id}")]
        public async Task<ActionResult<ClubeDTOs>> GetClube(int id)
        {
            var clubesDTO = await _context.DimClubes
                .Where(c => c.TimeId == id)
                .Select(c => new ClubeDTOs
                {
                    TimeId = c.TimeId,
                    Nome = c.Nome,
                    Titulos = c.Titulos,
                    Participacoes = c.Participacoes,
                    Fundacao = c.Fundacao,
                    Sede = c.Sede,
                    Escudo = c.Escudo
                })
                .FirstOrDefaultAsync();

            if (clubesDTO == null)
            {
                return NotFound();
            }

            return clubesDTO;
        }

        // GET: api/Clubes/nome/Itabaiana
        [HttpGet("nome/{nome}")]
        public async Task<ActionResult<IEnumerable<ClubeDTOs>>> GetClubesByNome(string nome)
        {
            var clubes = await _context.DimClubes
                .Where(c => c.Nome.Contains(nome))
                .Select(c => new ClubeDTOs
                {
                    TimeId = c.TimeId,
                    Nome = c.Nome,
                    Titulos = c.Titulos,
                    Participacoes = c.Participacoes,
                    Fundacao = c.Fundacao,
                    Sede = c.Sede,
                    Escudo = c.Escudo
                })
                .ToListAsync();

            if (clubes == null || !clubes.Any())
            {
                return NotFound();
            }

            return clubes;
        }

        
    }
}