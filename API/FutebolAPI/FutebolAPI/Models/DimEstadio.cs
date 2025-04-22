using System;
using System.Collections.Generic;

namespace FutebolAPI.Models;

public partial class DimEstadio
{
    public int EstadioId { get; set; }

    public string? Nome { get; set; }

    public int? Capacidade { get; set; }

    public string? Cidade { get; set; }

    public double? Latitude { get; set; }

    public double? Longitude { get; set; }

    public virtual ICollection<Fatopartidum> Fatopartida { get; set; } = new List<Fatopartidum>();
}
