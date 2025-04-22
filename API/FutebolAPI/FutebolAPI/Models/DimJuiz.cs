using System;
using System.Collections.Generic;

namespace FutebolAPI.Models;

public partial class DimJuiz
{
    public int JuizId { get; set; }

    public string? Nome { get; set; }

    public string? Nivel { get; set; }

    public virtual ICollection<Fatopartidum> Fatopartida { get; set; } = new List<Fatopartidum>();
}
