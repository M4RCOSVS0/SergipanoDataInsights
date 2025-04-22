using System;
using System.Collections.Generic;

namespace FutebolAPI.Models;

public partial class DimJogador
{
    public int JogadorId { get; set; }

    public string? Nome { get; set; }

    public string? Posicao { get; set; }

    public DateOnly? Nascimento { get; set; }

    public int? TimeId { get; set; }

    public virtual AggArtilharium? AggArtilharium { get; set; }

    public virtual ICollection<Fatocartao> Fatocartaos { get; set; } = new List<Fatocartao>();

    public virtual ICollection<Fatogol> Fatogols { get; set; } = new List<Fatogol>();

    public virtual DimClube? Time { get; set; }
}
