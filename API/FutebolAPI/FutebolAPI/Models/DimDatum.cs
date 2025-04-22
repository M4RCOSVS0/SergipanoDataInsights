using System;
using System.Collections.Generic;

namespace FutebolAPI.Models;

public partial class DimDatum
{
    public int DataId { get; set; }

    public DateOnly? Data { get; set; }

    public int? Ano { get; set; }

    public int? Mes { get; set; }

    public int? Dia { get; set; }

    public string? DiaSemana { get; set; }

    public virtual ICollection<Fatopartidum> Fatopartida { get; set; } = new List<Fatopartidum>();
}
