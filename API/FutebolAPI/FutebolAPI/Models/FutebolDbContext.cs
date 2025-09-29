using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;

namespace FutebolAPI.Models;

public partial class FutebolDbContext : DbContext
{
    public FutebolDbContext(DbContextOptions<FutebolDbContext> options)
        : base(options)
    {
    }

    public virtual DbSet<User> Users { get; set; }
 
    public virtual DbSet<AggArtilharium> AggArtilharia { get; set; }

    public virtual DbSet<DimClube> DimClubes { get; set; }

    public virtual DbSet<DimDatum> DimData { get; set; }

    public virtual DbSet<DimEstadio> DimEstadios { get; set; }

    public virtual DbSet<DimJogador> DimJogadors { get; set; }

    public virtual DbSet<DimJuiz> DimJuizs { get; set; }

    public virtual DbSet<Fatocartao> Fatocartaos { get; set; }

    public virtual DbSet<Fatoclassificacao> Fatoclassificacaos { get; set; }

    public virtual DbSet<Fatogol> Fatogols { get; set; }

    public virtual DbSet<Fatopartidum> Fatopartida { get; set; }

    public virtual DbSet<PontePartidaTime> PontePartidaTimes { get; set; }

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.Entity<AggArtilharium>(entity =>
        {
            entity.HasKey(e => e.JogadorId).HasName("PK__AggArtil__E3B690731349D8CE");

            entity.Property(e => e.JogadorId)
                .ValueGeneratedNever()
                .HasColumnName("JogadorID");

            entity.HasOne(d => d.Jogador).WithOne(p => p.AggArtilharium)
                .HasForeignKey<AggArtilharium>(d => d.JogadorId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK__AggArtilh__Jogad__412EB0B6");
        });

        modelBuilder.Entity<DimClube>(entity =>
        {
            entity.HasKey(e => e.TimeId).HasName("PK__DimClube__E04ED96701F744D7");

            entity.ToTable("DimClube");

            entity.Property(e => e.TimeId).HasColumnName("TimeID");
            entity.Property(e => e.Escudo).HasMaxLength(1000);
            entity.Property(e => e.Nome).HasMaxLength(45);
            entity.Property(e => e.Sede).HasMaxLength(30);
        });

        modelBuilder.Entity<DimDatum>(entity =>
        {
            entity.HasKey(e => e.DataId).HasName("PK__DimData__9D05305DD7FE0131");

            entity.Property(e => e.DataId).HasColumnName("DataID");
            entity.Property(e => e.DiaSemana)
                .HasMaxLength(3)
                .IsUnicode(false)
                .IsFixedLength();
        });

        modelBuilder.Entity<DimEstadio>(entity =>
        {
            entity.HasKey(e => e.EstadioId).HasName("PK__DimEstad__CC2D0FD8AB4B33EF");

            entity.ToTable("DimEstadio");

            entity.Property(e => e.EstadioId).HasColumnName("EstadioID");
            entity.Property(e => e.Cidade).HasMaxLength(45);
            entity.Property(e => e.Nome).HasMaxLength(45);
        });

        modelBuilder.Entity<DimJogador>(entity =>
        {
            entity.HasKey(e => e.JogadorId).HasName("PK__DimJogad__E3B690734503BF7E");

            entity.ToTable("DimJogador");

            entity.Property(e => e.JogadorId).HasColumnName("JogadorID");
            entity.Property(e => e.Nome).HasMaxLength(45);
            entity.Property(e => e.Posicao).HasMaxLength(45);
            entity.Property(e => e.TimeId).HasColumnName("TimeID");

            entity.HasOne(d => d.Time).WithMany(p => p.DimJogadors)
                .HasForeignKey(d => d.TimeId)
                .HasConstraintName("FK__DimJogado__TimeI__3E52440B");
        });

        modelBuilder.Entity<DimJuiz>(entity =>
        {
            entity.HasKey(e => e.JuizId).HasName("PK__DimJuiz__A39816900826A564");

            entity.ToTable("DimJuiz");

            entity.Property(e => e.JuizId).HasColumnName("JuizID");
            entity.Property(e => e.Nivel).HasMaxLength(45);
            entity.Property(e => e.Nome).HasMaxLength(45);
        });

        modelBuilder.Entity<Fatocartao>(entity =>
        {
            entity.HasKey(e => e.CartaoId).HasName("PK__fatocart__91510D018CF402E4");

            entity.ToTable("fatocartao");

            entity.Property(e => e.CartaoId).HasColumnName("CartaoID");
            entity.Property(e => e.Cor)
                .HasMaxLength(1)
                .IsUnicode(false)
                .IsFixedLength();
            entity.Property(e => e.JogadorId).HasColumnName("JogadorID");
            entity.Property(e => e.PartidaId).HasColumnName("PartidaID");
            entity.Property(e => e.TimeId).HasColumnName("TimeID");

            entity.HasOne(d => d.Jogador).WithMany(p => p.Fatocartaos)
                .HasForeignKey(d => d.JogadorId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK__fatocarta__Jogad__52593CB8");

            entity.HasOne(d => d.Partida).WithMany(p => p.Fatocartaos)
                .HasForeignKey(d => d.PartidaId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK__fatocarta__Parti__5165187F");

            entity.HasOne(d => d.Time).WithMany(p => p.Fatocartaos)
                .HasForeignKey(d => d.TimeId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK__fatocarta__TimeI__534D60F1");
        });

        modelBuilder.Entity<Fatoclassificacao>(entity =>
        {
            entity.HasKey(e => new { e.RodadaId, e.TimeId }).HasName("PK__fatoclas__C452F29F67EE04B6");

            entity.ToTable("fatoclassificacao");

            entity.Property(e => e.RodadaId).HasColumnName("RodadaID");
            entity.Property(e => e.TimeId).HasColumnName("TimeID");
            entity.Property(e => e.Saldo).HasComputedColumnSql("([GolsPro]-[GolsContra])", false);

            entity.HasOne(d => d.Time).WithMany(p => p.Fatoclassificacaos)
                .HasForeignKey(d => d.TimeId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK__fatoclass__TimeI__5629CD9C");
        });

        modelBuilder.Entity<Fatogol>(entity =>
        {
            entity.HasKey(e => e.GolId).HasName("PK__fatogol__E344E4C011E39039");

            entity.ToTable("fatogol", tb => tb.HasTrigger("trg_UpdateArtilharia"));

            entity.Property(e => e.GolId).HasColumnName("GolID");
            entity.Property(e => e.Golcontra)
                .HasDefaultValue(0)
                .HasColumnName("GOLCONTRA");
            entity.Property(e => e.JogadorId).HasColumnName("JogadorID");
            entity.Property(e => e.PartidaId).HasColumnName("PartidaID");
            entity.Property(e => e.TimeId).HasColumnName("TimeID");

            entity.HasOne(d => d.Jogador).WithMany(p => p.Fatogols)
                .HasForeignKey(d => d.JogadorId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK__fatogol__Jogador__5BE2A6F2");

            entity.HasOne(d => d.Partida).WithMany(p => p.Fatogols)
                .HasForeignKey(d => d.PartidaId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK__fatogol__Partida__5AEE82B9");

            entity.HasOne(d => d.Time).WithMany(p => p.Fatogols)
                .HasForeignKey(d => d.TimeId)
                .HasConstraintName("FK__fatogol__TimeID__5CD6CB2B");
        });

        modelBuilder.Entity<Fatopartidum>(entity =>
        {
            entity.HasKey(e => e.PartidaId).HasName("PK__fatopart__E63E1FC34600D184");

            entity.ToTable("fatopartida");

            entity.Property(e => e.PartidaId).HasColumnName("PartidaID");
            entity.Property(e => e.DataId).HasColumnName("DataID");
            entity.Property(e => e.EstadioId).HasColumnName("EstadioID");
            entity.Property(e => e.JuizId).HasColumnName("JuizID");
            entity.Property(e => e.Renda).HasColumnType("decimal(10, 2)");
            entity.Property(e => e.Resultado).HasMaxLength(10);

            entity.HasOne(d => d.Data).WithMany(p => p.Fatopartida)
                .HasForeignKey(d => d.DataId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK__fatoparti__DataI__46E78A0C");

            entity.HasOne(d => d.Estadio).WithMany(p => p.Fatopartida)
                .HasForeignKey(d => d.EstadioId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK__fatoparti__Estad__47DBAE45");

            entity.HasOne(d => d.Juiz).WithMany(p => p.Fatopartida)
                .HasForeignKey(d => d.JuizId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK__fatoparti__JuizI__48CFD27E");
        });

        modelBuilder.Entity<PontePartidaTime>(entity =>
        {
            entity.HasKey(e => new { e.Timeid, e.Partidaid }).HasName("PK__PontePar__823FDF50538ABE16");

            entity.ToTable("PontePartidaTime");

            entity.Property(e => e.Timeid).HasColumnName("TIMEID");
            entity.Property(e => e.Partidaid).HasColumnName("PARTIDAID");
            entity.Property(e => e.ChutesAgol).HasColumnName("ChutesAGol");

            entity.HasOne(d => d.Partida).WithMany(p => p.PontePartidaTimes)
                .HasForeignKey(d => d.Partidaid)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK__PontePart__PARTI__4CA06362");

            entity.HasOne(d => d.Time).WithMany(p => p.PontePartidaTimes)
                .HasForeignKey(d => d.Timeid)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK__PontePart__TIMEI__4BAC3F29");
        });

        modelBuilder.Entity<User>(entity =>
        {
            entity.HasKey(e => e.Id);
            entity.HasIndex(e => e.Username).IsUnique();
            entity.HasIndex(e => e.Email).IsUnique();
            entity.Property(e => e.Username).IsRequired().HasMaxLength(50);
            entity.Property(e => e.Email).IsRequired().HasMaxLength(100);
            entity.Property(e => e.PasswordHash).IsRequired();
            entity.Property(e => e.Role).IsRequired().HasMaxLength(20);
            entity.Property(e => e.CreatedAt).IsRequired();
        });

        OnModelCreatingPartial(modelBuilder);
    }

    partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
}
