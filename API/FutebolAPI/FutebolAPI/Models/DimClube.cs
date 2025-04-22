using System;
using System.Collections.Generic;

namespace FutebolAPI.Models;

public partial class DimClube
{
    public int TimeId { get; set; }

    public string Nome { get; set; } = null!;

    public int Titulos { get; set; }

    public int Participacoes { get; set; }

    public DateOnly Fundacao { get; set; }

    public string Sede { get; set; } = null!;

    public string? Escudo { get; set; }

    public virtual ICollection<DimJogador> DimJogadors { get; set; } = new List<DimJogador>();

    public virtual ICollection<Fatocartao> Fatocartaos { get; set; } = new List<Fatocartao>();

    public virtual ICollection<Fatoclassificacao> Fatoclassificacaos { get; set; } = new List<Fatoclassificacao>();

    public virtual ICollection<Fatogol> Fatogols { get; set; } = new List<Fatogol>();

    public virtual ICollection<PontePartidaTime> PontePartidaTimes { get; set; } = new List<PontePartidaTime>();
}
