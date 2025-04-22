using System;
using System.Collections.Generic;

namespace FutebolAPI.Models;

public partial class PontePartidaTime
{
    public int Timeid { get; set; }

    public int Partidaid { get; set; }

    public int? PosseDeBola { get; set; }

    public int? Escanteios { get; set; }

    public int? ChutesAgol { get; set; }

    public int? Impedimentos { get; set; }

    public virtual Fatopartidum Partida { get; set; } = null!;

    public virtual DimClube Time { get; set; } = null!;
}
