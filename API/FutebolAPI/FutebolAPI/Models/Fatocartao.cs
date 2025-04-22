using System;
using System.Collections.Generic;

namespace FutebolAPI.Models;

public partial class Fatocartao
{
    public int CartaoId { get; set; }

    public int PartidaId { get; set; }

    public int JogadorId { get; set; }

    public int TimeId { get; set; }

    public int? Minuto { get; set; }

    public int? Tempo { get; set; }

    public string? Cor { get; set; }

    public virtual DimJogador Jogador { get; set; } = null!;

    public virtual Fatopartidum Partida { get; set; } = null!;

    public virtual DimClube Time { get; set; } = null!;
}
