namespace FutebolAPI.DTOs
{
    public class JogadorDTO
    {
        public int JogadorId { get; set; }
        public string Nome { get; set; }
        public string Posicao { get; set; }
        public DateOnly? Nascimento { get; set; }
        public int? TimeId { get; set; }
        public string TimeNome { get; set; }  // Apenas o nome do time, não o objeto inteiro
        public int? NumeroGols { get; set; }  // Apenas o número de gols, não o objeto AggArtilharium
    }
}