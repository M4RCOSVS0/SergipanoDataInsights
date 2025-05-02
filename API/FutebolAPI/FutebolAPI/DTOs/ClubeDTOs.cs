namespace FutebolAPI.DTOs
{
    public class ClubeDTOs
    {
        public int TimeId { get; set; }

        public string Nome { get; set; } = null!;

        public int Titulos { get; set; }

        public int Participacoes { get; set; }

        public DateOnly Fundacao { get; set; }

        public string Sede { get; set; } = null!;

        public string? Escudo { get; set; }
    }
}
