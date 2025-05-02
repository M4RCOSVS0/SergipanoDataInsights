namespace FutebolAPI.DTOs
{
    public class CartaoDTOs
    {
        public int CartaoId { get; set; }
        public int JogadorId { get; set; }
        public string JogadorNome { get; set; } = null!;
        public int TimeId { get; set; }
        public string TimeNome { get; set; } = null!;
        public int Minuto { get; set; }
        public string TipoCartao { get; set; } = null!; // "Amarelo" ou "Vermelho"
        public int Tempo { get; set; } // 1 ou 2
        public List<JogadorDTO> jogadores { get; set; } = new List<JogadorDTO>();
        public List<ClubeDTOs> times { get; set; } = new List<ClubeDTOs>();
        public List<PartidaDTOs> partidas { get; set; } = new List<PartidaDTOs>();
    }
}
