using FutebolAPI.DTOs;
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
        public async Task<ActionResult<IEnumerable<JogadorDTO>>> GetJogadores()
        {
            var jogadoresDTO = await _context.DimJogadors
                .Include(j => j.Time)
                .Include(j => j.AggArtilharium)
                .Select(j => new JogadorDTO
                {
                    JogadorId = j.JogadorId,
                    Nome = j.Nome,
                    Posicao = j.Posicao,
                    Nascimento = j.Nascimento,
                    TimeId = j.TimeId,
                    TimeNome = j.Time != null ? j.Time.Nome : null,
                    NumeroGols = j.AggArtilharium != null ? j.AggArtilharium.Gols : null
                })
                .ToListAsync();

            return jogadoresDTO;
        }

        // GET: api/Jogadores/5
        [HttpGet("{id}")]
        public async Task<ActionResult<JogadorDTO>> GetJogador(int id)
        {
            var jogadorDTO = await _context.DimJogadors
                .Include(j => j.Time)
                .Include(j => j.AggArtilharium)
                .Where(j => j.JogadorId == id)
                .Select(j => new JogadorDTO
                {
                    JogadorId = j.JogadorId,
                    Nome = j.Nome,
                    Posicao = j.Posicao,
                    Nascimento = j.Nascimento,
                    TimeId = j.TimeId,
                    TimeNome = j.Time != null ? j.Time.Nome : null,
                    NumeroGols = j.AggArtilharium != null ? j.AggArtilharium.Gols : null
                })
                .FirstOrDefaultAsync();

            if (jogadorDTO == null)
            {
                return NotFound();
            }

            return jogadorDTO;
        }

        // GET: api/Jogadores/ByTime/1
        [HttpGet("ByTime/{timeId}")]
        public async Task<ActionResult<IEnumerable<JogadorDTO>>> GetJogadoresByTime(int timeId)
        {
            var jogadoresDTO = await _context.DimJogadors
                .Include(j => j.Time)
                .Include(j => j.AggArtilharium)
                .Where(j => j.TimeId == timeId)
                .Select(j => new JogadorDTO
                {
                    JogadorId = j.JogadorId,
                    Nome = j.Nome,
                    Posicao = j.Posicao,
                    Nascimento = j.Nascimento,
                    TimeId = j.TimeId,
                    TimeNome = j.Time != null ? j.Time.Nome : null,
                    NumeroGols = j.AggArtilharium != null ? j.AggArtilharium.Gols : null
                })
                .ToListAsync();

            return jogadoresDTO;
        }

        // GET: api/Jogadores/posicao/atacante
        [HttpGet("posicao/{posicao}")]
        public async Task<ActionResult<IEnumerable<JogadorDTO>>> GetJogadoresByPosicao(string posicao)
        {
            var jogadoresDTO = await _context.DimJogadors
                .Include(j => j.Time)
                .Include(j => j.AggArtilharium)
                .Where(j => j.Posicao == posicao)
                .Select(j => new JogadorDTO
                {
                    JogadorId = j.JogadorId,
                    Nome = j.Nome,
                    Posicao = j.Posicao,
                    Nascimento = j.Nascimento,
                    TimeId = j.TimeId,
                    TimeNome = j.Time != null ? j.Time.Nome : null,
                    NumeroGols = j.AggArtilharium != null ? j.AggArtilharium.Gols : null
                })
                .ToListAsync();

            if (jogadoresDTO == null || !jogadoresDTO.Any())
            {
                return NotFound();
            }

            return jogadoresDTO;
        }

        // GET: api/Jogadores/nome/neymar
        [HttpGet("nome/{nome}")]
        public async Task<ActionResult<IEnumerable<JogadorDTO>>> GetJogadoresByNome(string nome)
        {
            var jogadoresDTO = await _context.DimJogadors
                .Include(j => j.Time)
                .Include(j => j.AggArtilharium)
                .Where(j => j.Nome.Contains(nome))
                .Select(j => new JogadorDTO
                {
                    JogadorId = j.JogadorId,
                    Nome = j.Nome,
                    Posicao = j.Posicao,
                    Nascimento = j.Nascimento,
                    TimeId = j.TimeId,
                    TimeNome = j.Time != null ? j.Time.Nome : null,
                    NumeroGols = j.AggArtilharium != null ? j.AggArtilharium.Gols : null
                })
                .ToListAsync();

            if (jogadoresDTO == null || !jogadoresDTO.Any())
            {
                return NotFound();
            }

            return jogadoresDTO;
        }

        // GET: api/Jogadores/artilharia
        [HttpGet("artilharia")]
        public async Task<ActionResult<IEnumerable<JogadorDTO>>> GetArtilharia([FromQuery] int? minGols)
        {
            var query = _context.DimJogadors
                .Include(j => j.Time)
                .Include(j => j.AggArtilharium)
                .AsQueryable();//controí a query em etapas  

            // Lógica para aplicar o filtro se o parâmetro for fornecido
            if (minGols.HasValue)
            {
                query = query.Where(j => j.AggArtilharium != null && j.AggArtilharium.Gols >= minGols.Value);
            }

            var jogadoresDTO = await query
                .Select(j => new JogadorDTO
                {
                    JogadorId = j.JogadorId,
                    Nome = j.Nome!,
                    Posicao = j.Posicao!,
                    Nascimento = j.Nascimento,
                    TimeId = j.TimeId,
                    TimeNome = j.Time != null ? j.Time.Nome! : null,
                    NumeroGols = j.AggArtilharium != null ? j.AggArtilharium.Gols : null
                })
                .OrderByDescending(a => a.NumeroGols)
                .ToListAsync();

            return jogadoresDTO;
        }
    }
}