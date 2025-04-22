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
        public async Task<ActionResult<IEnumerable<DimClube>>> GetClubes()
        {
            return await _context.DimClubes.ToListAsync();
        }

        // GET: api/Clubes/5
        [HttpGet("{id}")]
        public async Task<ActionResult<DimClube>> GetClube(int id)
        {
            var clube = await _context.DimClubes.FindAsync(id);

            if (clube == null)
            {
                return NotFound();
            }

            return clube;
        }

        // GET: api/Clubes/nome/Flamengo
        [HttpGet("nome/{nome}")]
        public async Task<ActionResult<IEnumerable<DimClube>>> GetClubesByNome(string nome)
        {
            var clubes = await _context.DimClubes
                .Where(c => c.Nome.Contains(nome))
                .ToListAsync();

            if (clubes == null || !clubes.Any())
            {
                return NotFound();
            }

            return clubes;
        }

        // GET: api/Clubes/titulos/10
        [HttpGet("titulos/{minTitulos}")]
        public async Task<ActionResult<IEnumerable<DimClube>>> GetClubesByTitulos(int minTitulos)
        {
            var clubes = await _context.DimClubes
                .Where(c => c.Titulos >= minTitulos)
                .OrderByDescending(c => c.Titulos)
                .ToListAsync();

            if (clubes == null || !clubes.Any())
            {
                return NotFound();
            }

            return clubes;
        }
    }
}