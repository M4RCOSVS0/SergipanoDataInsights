namespace FutebolAPI.DTOs
{
    public class PartidaDTOs
    {
        public int PartidaId { get; set; }
        public DateOnly? Data { get; set; }
        public string Estadio { get; set; } = null!;
        public string Juiz { get; set; } = null!;
        public int? Publico { get; set; }
        public decimal? Renda { get; set; }
        public string? Resultado { get; set; }
        public List<ClubeDTOs> Times { get; set; } = new List<ClubeDTOs>();
        public List<GolDTOs> Gols { get; set; } = new List<GolDTOs>();
        public List<CartaoDTOs> Cartoes { get; set; } = new List<CartaoDTOs>();
    }
}
