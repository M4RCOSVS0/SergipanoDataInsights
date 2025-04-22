using System;
using System.Collections.Generic;

namespace FutebolAPI.Models;

public partial class Fatopartidum
{
    public int PartidaId { get; set; }

    public int DataId { get; set; }

    public int EstadioId { get; set; }

    public int JuizId { get; set; }

    public int? Publico { get; set; }

    public decimal? Renda { get; set; }

    public string? Resultado { get; set; }

    public virtual DimDatum Data { get; set; } = null!;

    public virtual DimEstadio Estadio { get; set; } = null!;

    public virtual ICollection<Fatocartao> Fatocartaos { get; set; } = new List<Fatocartao>();

    public virtual ICollection<Fatogol> Fatogols { get; set; } = new List<Fatogol>();

    public virtual DimJuiz Juiz { get; set; } = null!;

    public virtual ICollection<PontePartidaTime> PontePartidaTimes { get; set; } = new List<PontePartidaTime>();
}
