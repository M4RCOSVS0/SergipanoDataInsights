using FutebolAPI.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace FutebolAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class JogadoresController : ControllerBase
    {
        private readonly FutebolDbContext _context;

        public JogadoresController(FutebolDbContext context)
        {
            _context = context;
        }

        // GET: api/Jogadores
        [HttpGet]
        public async Task<ActionResult<IEnumerable<DimJogador>>> GetJogadores()
        {
            return await _context.DimJogadors.ToListAsync();
        }

        // GET: api/Jogadores/5
        [HttpGet("{id}")]
        public async Task<ActionResult<DimJogador>> GetJogador(int id)
        {
            var jogador = await _context.DimJogadors.FindAsync(id);

            if (jogador == null)
            {
                return NotFound();
            }

            return jogador;
        }

        // GET: api/Jogadores/time/5
        [HttpGet("time/{timeId}")]
        public async Task<ActionResult<IEnumerable<DimJogador>>> GetJogadoresByTime(int timeId)
        {
            var jogadores = await _context.DimJogadors
                .Where(j => j.TimeId == timeId)
                .ToListAsync();

            if (jogadores == null || !jogadores.Any())
            {
                return NotFound();
            }

            return jogadores;
        }

        // GET: api/Jogadores/posicao/atacante
        [HttpGet("posicao/{posicao}")]
        public async Task<ActionResult<IEnumerable<DimJogador>>> GetJogadoresByPosicao(string posicao)
        {
            var jogadores = await _context.DimJogadors
                .Where(j => j.Posicao.Contains(posicao))
                .ToListAsync();

            if (jogadores == null || !jogadores.Any())
            {
                return NotFound();
            }

            return jogadores;
        }

        // GET: api/Jogadores/artilharia
        [HttpGet("artilharia")]
        public async Task<ActionResult<IEnumerable<object>>> GetArtilharia()
        {
            var artilheiros = await _context.AggArtilharia
                .Join(_context.DimJogadors,
                    art => art.JogadorId,
                    jog => jog.JogadorId,
                    (art, jog) => new { Jogador = jog, Gols = art.Gols })
                .Join(_context.DimClubes,
                    j => j.Jogador.TimeId,
                    c => c.TimeId,
                    (j, c) => new {
                        JogadorId = j.Jogador.JogadorId,
                        NomeJogador = j.Jogador.Nome,
                        Clube = c.Nome,
                        Gols = j.Gols
                    })
                .OrderByDescending(a => a.Gols)
                .ToListAsync();

            if (artilheiros == null || !artilheiros.Any())
            {
                return NotFound();
            }

            return artilheiros;
        }
    }
}