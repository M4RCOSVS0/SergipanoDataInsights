using System;
using System.Collections.Generic;

namespace FutebolAPI.Models;

public partial class Fatoclassificacao
{
    public int RodadaId { get; set; }

    public int TimeId { get; set; }

    public int? Pontos { get; set; }

    public int? Jogos { get; set; }

    public int? Vitorias { get; set; }

    public int? Empates { get; set; }

    public int? Derrotas { get; set; }

    public int? GolsPro { get; set; }

    public int? GolsContra { get; set; }

    public int? Saldo { get; set; }

    public virtual DimClube Time { get; set; } = null!;
}
