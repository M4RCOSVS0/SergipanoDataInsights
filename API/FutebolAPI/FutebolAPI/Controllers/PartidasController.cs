using FutebolAPI.DTOs;
using FutebolAPI.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Microsoft.AspNetCore.Authorization;

namespace FutebolAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class PartidasController : ControllerBase
    {
        private readonly FutebolDbContext _context;

        public PartidasController(FutebolDbContext context)
        {
            _context = context;
        }

        // GET: api/Partidas
        //[Authorize(Roles = "user")]
        [HttpGet]
        public async Task<ActionResult<IEnumerable<PartidaDTOs>>> GetPartidas()
        {
            var partidaDTO = await _context.Fatopartida
              .Include(p => p.Estadio)
              .Include(p => p.Juiz)
              .Include(p => p.Data)
              .Include(p => p.PontePartidaTimes)
              .Select(p => new PartidaDTOs
              {
                  PartidaId = p.PartidaId,
                  Estadio = p.Estadio.Nome,
                  Juiz = p.Juiz.Nome,
                  Data = (DateOnly)p.Data.Data,
                  Publico = p.Publico,
                  Renda = p.Renda,
                  Resultado = p.Resultado,
                  TimeMandante = p.PontePartidaTimes
                        .OrderBy(pt => pt.Timeid)
                        .Join(_context.DimClubes,
                            pt => pt.Timeid,
                            c => c.TimeId,
                            (pt, c) => c.Nome)
                        .FirstOrDefault(),
                  TimeVisitante = p.PontePartidaTimes
                        .OrderBy(pt => pt.Timeid)
                        .Join(_context.DimClubes,
                            pt => pt.Timeid,
                            c => c.TimeId,
                            (pt, c) => c.Nome)
                        .Skip(1)
                        .FirstOrDefault(),
                  Gols = p.Fatogols
                        .Join(_context.DimClubes,
                            g => g.TimeId,
                            c => c.TimeId,
                            (g, c) => new { Gol = g, Clube = c })
                        .Join(_context.DimJogadors,
                            gc => gc.Gol.JogadorId,
                            j => j.JogadorId,
                            (gc, j) => new GolDTOs
                            {
                                Minuto = gc.Gol.Minuto,
                                Tempo = gc.Gol.Tempo,
                                JogadorNome = j.Nome,
                                TimeNome = gc.Clube.Nome
                            })
                        .ToList()
              }).ToListAsync();

            if (partidaDTO == null || partidaDTO.Count == 0)
            {
                return NotFound();
            }

            return partidaDTO;
        }

        // GET: api/Partidas/5
        [Authorize(Roles = "user")]
        [HttpGet("{id}")]
        public async Task<ActionResult<Fatopartidum>> GetPartida(int id)
        {
            var partida = await _context.Fatopartida.FindAsync(id);

            if (partida == null)
            {
                return NotFound();
            }

            return partida;
        }

        // GET: api/Partidas/estadio/5
        [Authorize(Roles = "user")]
        [HttpGet("estadio/{estadioId}")]
        public async Task<ActionResult<IEnumerable<Fatopartidum>>> GetPartidasByEstadio(int estadioId)
        {
            var partidas = await _context.Fatopartida
                .Where(p => p.EstadioId == estadioId)
                .ToListAsync();

            if (partidas == null || !partidas.Any())
            {
                return NotFound();
            }

            return partidas;
        }

        // GET: api/Partidas/detalhes/5
        [Authorize(Roles = "user")]
        [HttpGet("detalhes/{id}")]
        public async Task<ActionResult<object>> GetPartidaDetalhes(int id)
        {
            var partida = await _context.Fatopartida
                .Where(p => p.PartidaId == id)
                .Join(_context.DimData,
                    p => p.DataId,
                    d => d.DataId,
                    (p, d) => new { Partida = p, Data = d })
                .Join(_context.DimEstadios,
                    pd => pd.Partida.EstadioId,
                    e => e.EstadioId,
                    (pd, e) => new { pd.Partida, pd.Data, Estadio = e })
                .Join(_context.DimJuizs,
                    pde => pde.Partida.JuizId,
                    j => j.JuizId,
                    (pde, j) => new
                    {
                        PartidaId = pde.Partida.PartidaId,
                        Data = pde.Data.Data,
                        Estadio = pde.Estadio.Nome,
                        Cidade = pde.Estadio.Cidade,
                        Arbitro = j.Nome,
                        Publico = pde.Partida.Publico,
                        Renda = pde.Partida.Renda,
                        Resultado = pde.Partida.Resultado
                    })
                .FirstOrDefaultAsync();

            if (partida == null)
            {
                return NotFound();
            }

            // Buscar detalhes dos times na partida
            var timesPartida = await _context.PontePartidaTimes
                .Where(p => p.Partidaid == id)
                .Join(_context.DimClubes,
                    p => p.Timeid,
                    c => c.TimeId,
                    (p, c) => new
                    {
                        TimeId = c.TimeId,
                        Nome = c.Nome,
                        PosseDeBola = p.PosseDeBola,
                        Escanteios = p.Escanteios,
                        ChutesAGol = p.ChutesAgol,
                        Impedimentos = p.Impedimentos
                    })
                .ToListAsync();

            // Buscar gols da partida
            var gols = await _context.Fatogols
                .Where(g => g.PartidaId == id)
                .Join(_context.DimJogadors,
                    g => g.JogadorId,
                    j => j.JogadorId,
                    (g, j) => new
                    {
                        JogadorNome = j.Nome,
                        Minuto = g.Minuto,
                        Tempo = g.Tempo,
                        GolContra = g.Golcontra == 1,
                        TimeId = g.TimeId
                    })
                .Join(_context.DimClubes,
                    g => g.TimeId,
                    c => c.TimeId,
                    (g, c) => new
                    {
                        g.JogadorNome,
                        g.Minuto,
                        g.Tempo,
                        g.GolContra,
                        TimeNome = c.Nome
                    })
                .ToListAsync();

            return new
            {
                partida,
                Times = timesPartida,
                Gols = gols
            };
        }
    }
}