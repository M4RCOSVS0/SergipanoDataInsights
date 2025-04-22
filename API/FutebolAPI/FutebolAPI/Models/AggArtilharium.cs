using System;
using System.Collections.Generic;

namespace FutebolAPI.Models;

public partial class AggArtilharium
{
    public int JogadorId { get; set; }

    public int? Gols { get; set; }

    public virtual DimJogador Jogador { get; set; } = null!;
}
