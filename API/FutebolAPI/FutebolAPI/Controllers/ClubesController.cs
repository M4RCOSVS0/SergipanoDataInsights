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

        // GET: api/Clubes
        [HttpGet]
        public async Task<ActionResult<IEnumerable<ClubeDTOs>>> GetClubes()
        {
            var clubesDTO = await _context.DimClubes
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

            return clubesDTO;
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

        // GET: api/Clubes/titulos/10
        [HttpGet("titulos/{minTitulos}")]
        public async Task<ActionResult<IEnumerable<ClubeDTOs>>> GetClubesByTitulos(int minTitulos)
        {
            var clubes = await _context.DimClubes
                .Where(c => c.Titulos >= minTitulos)
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