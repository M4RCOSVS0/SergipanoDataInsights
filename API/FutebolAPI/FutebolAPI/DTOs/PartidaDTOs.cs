namespace FutebolAPI.DTOs
{
    public class PartidaDTOs
    {
        public int PartidaId { get; set; }
        public string Estadio { get; set; } = string.Empty;
        public string Juiz { get; set; } = string.Empty;
        public DateOnly Data { get; set; }
        public int? Publico { get; set; }
        public decimal? Renda { get; set; }
        public string? Resultado { get; set; }
        public string? TimeMandante { get; set; }
        public string? TimeVisitante { get; set; }
        public List<GolDTOs> Gols { get; set; } = new List<GolDTOs>();
    }
}
