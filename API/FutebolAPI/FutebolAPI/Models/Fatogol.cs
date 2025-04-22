using System;
using System.Collections.Generic;

namespace FutebolAPI.Models;

public partial class Fatogol
{
    public int GolId { get; set; }

    public int PartidaId { get; set; }

    public int JogadorId { get; set; }

    public int? TimeId { get; set; }

    public int? Minuto { get; set; }

    public int? Tempo { get; set; }

    public int? Golcontra { get; set; }

    public virtual DimJogador Jogador { get; set; } = null!;

    public virtual Fatopartidum Partida { get; set; } = null!;

    public virtual DimClube? Time { get; set; }
}
