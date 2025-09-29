IF OBJECT_ID(N'[__EFMigrationsHistory]') IS NULL
BEGIN
    CREATE TABLE [__EFMigrationsHistory] (
        [MigrationId] nvarchar(150) NOT NULL,
        [ProductVersion] nvarchar(32) NOT NULL,
        CONSTRAINT [PK___EFMigrationsHistory] PRIMARY KEY ([MigrationId])
    );
END;
GO

BEGIN TRANSACTION;
GO

CREATE TABLE [DimClube] (
    [TimeID] int NOT NULL IDENTITY,
    [Nome] nvarchar(45) NOT NULL,
    [Titulos] int NOT NULL,
    [Participacoes] int NOT NULL,
    [Fundacao] date NOT NULL,
    [Sede] nvarchar(30) NOT NULL,
    [Escudo] nvarchar(1000) NULL,
    CONSTRAINT [PK__DimClube__E04ED96701F744D7] PRIMARY KEY ([TimeID])
);
GO

CREATE TABLE [DimData] (
    [DataID] int NOT NULL IDENTITY,
    [Data] date NULL,
    [Ano] int NULL,
    [Mes] int NULL,
    [Dia] int NULL,
    [DiaSemana] char(3) NULL,
    CONSTRAINT [PK__DimData__9D05305DD7FE0131] PRIMARY KEY ([DataID])
);
GO

CREATE TABLE [DimEstadio] (
    [EstadioID] int NOT NULL IDENTITY,
    [Nome] nvarchar(45) NULL,
    [Capacidade] int NULL,
    [Cidade] nvarchar(45) NULL,
    [Latitude] float NULL,
    [Longitude] float NULL,
    CONSTRAINT [PK__DimEstad__CC2D0FD8AB4B33EF] PRIMARY KEY ([EstadioID])
);
GO

CREATE TABLE [DimJuiz] (
    [JuizID] int NOT NULL IDENTITY,
    [Nome] nvarchar(45) NULL,
    [Nivel] nvarchar(45) NULL,
    CONSTRAINT [PK__DimJuiz__A39816900826A564] PRIMARY KEY ([JuizID])
);
GO

CREATE TABLE [Users] (
    [Id] uniqueidentifier NOT NULL,
    [Username] nvarchar(50) NOT NULL,
    [Email] nvarchar(100) NOT NULL,
    [PasswordHash] nvarchar(max) NOT NULL,
    [Role] nvarchar(20) NOT NULL,
    [CreatedAt] datetime2 NOT NULL,
    [IsActive] bit NOT NULL,
    CONSTRAINT [PK_Users] PRIMARY KEY ([Id])
);
GO

CREATE TABLE [DimJogador] (
    [JogadorID] int NOT NULL IDENTITY,
    [Nome] nvarchar(45) NULL,
    [Posicao] nvarchar(45) NULL,
    [Nascimento] date NULL,
    [TimeID] int NULL,
    CONSTRAINT [PK__DimJogad__E3B690734503BF7E] PRIMARY KEY ([JogadorID]),
    CONSTRAINT [FK__DimJogado__TimeI__3E52440B] FOREIGN KEY ([TimeID]) REFERENCES [DimClube] ([TimeID])
);
GO

CREATE TABLE [fatoclassificacao] (
    [RodadaID] int NOT NULL,
    [TimeID] int NOT NULL,
    [Pontos] int NULL,
    [Jogos] int NULL,
    [Vitorias] int NULL,
    [Empates] int NULL,
    [Derrotas] int NULL,
    [GolsPro] int NULL,
    [GolsContra] int NULL,
    [Saldo] AS ([GolsPro]-[GolsContra]),
    CONSTRAINT [PK__fatoclas__C452F29F67EE04B6] PRIMARY KEY ([RodadaID], [TimeID]),
    CONSTRAINT [FK__fatoclass__TimeI__5629CD9C] FOREIGN KEY ([TimeID]) REFERENCES [DimClube] ([TimeID])
);
GO

CREATE TABLE [fatopartida] (
    [PartidaID] int NOT NULL IDENTITY,
    [DataID] int NOT NULL,
    [EstadioID] int NOT NULL,
    [JuizID] int NOT NULL,
    [Publico] int NULL,
    [Renda] decimal(10,2) NULL,
    [Resultado] nvarchar(10) NULL,
    CONSTRAINT [PK__fatopart__E63E1FC34600D184] PRIMARY KEY ([PartidaID]),
    CONSTRAINT [FK__fatoparti__DataI__46E78A0C] FOREIGN KEY ([DataID]) REFERENCES [DimData] ([DataID]),
    CONSTRAINT [FK__fatoparti__Estad__47DBAE45] FOREIGN KEY ([EstadioID]) REFERENCES [DimEstadio] ([EstadioID]),
    CONSTRAINT [FK__fatoparti__JuizI__48CFD27E] FOREIGN KEY ([JuizID]) REFERENCES [DimJuiz] ([JuizID])
);
GO

CREATE TABLE [RefreshTokens] (
    [Id] uniqueidentifier NOT NULL,
    [UserId] uniqueidentifier NOT NULL,
    [Token] nvarchar(128) NOT NULL,
    [ExpiresAt] datetime2 NOT NULL,
    [CreatedAt] datetime2 NOT NULL,
    [IsRevoked] bit NOT NULL,
    CONSTRAINT [PK_RefreshTokens] PRIMARY KEY ([Id]),
    CONSTRAINT [FK_RefreshTokens_Users_UserId] FOREIGN KEY ([UserId]) REFERENCES [Users] ([Id]) ON DELETE CASCADE
);
GO

CREATE TABLE [AggArtilharia] (
    [JogadorID] int NOT NULL,
    [Gols] int NULL,
    CONSTRAINT [PK__AggArtil__E3B690731349D8CE] PRIMARY KEY ([JogadorID]),
    CONSTRAINT [FK__AggArtilh__Jogad__412EB0B6] FOREIGN KEY ([JogadorID]) REFERENCES [DimJogador] ([JogadorID])
);
GO

CREATE TABLE [fatocartao] (
    [CartaoID] int NOT NULL IDENTITY,
    [PartidaID] int NOT NULL,
    [JogadorID] int NOT NULL,
    [TimeID] int NOT NULL,
    [Minuto] int NULL,
    [Tempo] int NULL,
    [Cor] char(1) NULL,
    CONSTRAINT [PK__fatocart__91510D018CF402E4] PRIMARY KEY ([CartaoID]),
    CONSTRAINT [FK__fatocarta__Jogad__52593CB8] FOREIGN KEY ([JogadorID]) REFERENCES [DimJogador] ([JogadorID]),
    CONSTRAINT [FK__fatocarta__Parti__5165187F] FOREIGN KEY ([PartidaID]) REFERENCES [fatopartida] ([PartidaID]),
    CONSTRAINT [FK__fatocarta__TimeI__534D60F1] FOREIGN KEY ([TimeID]) REFERENCES [DimClube] ([TimeID])
);
GO

CREATE TABLE [fatogol] (
    [GolID] int NOT NULL IDENTITY,
    [PartidaID] int NOT NULL,
    [JogadorID] int NOT NULL,
    [TimeID] int NULL,
    [Minuto] int NULL,
    [Tempo] int NULL,
    [GOLCONTRA] int NULL DEFAULT 0,
    CONSTRAINT [PK__fatogol__E344E4C011E39039] PRIMARY KEY ([GolID]),
    CONSTRAINT [FK__fatogol__Jogador__5BE2A6F2] FOREIGN KEY ([JogadorID]) REFERENCES [DimJogador] ([JogadorID]),
    CONSTRAINT [FK__fatogol__Partida__5AEE82B9] FOREIGN KEY ([PartidaID]) REFERENCES [fatopartida] ([PartidaID]),
    CONSTRAINT [FK__fatogol__TimeID__5CD6CB2B] FOREIGN KEY ([TimeID]) REFERENCES [DimClube] ([TimeID])
);
GO

CREATE TABLE [PontePartidaTime] (
    [TIMEID] int NOT NULL,
    [PARTIDAID] int NOT NULL,
    [PosseDeBola] int NULL,
    [Escanteios] int NULL,
    [ChutesAGol] int NULL,
    [Impedimentos] int NULL,
    CONSTRAINT [PK__PontePar__823FDF50538ABE16] PRIMARY KEY ([TIMEID], [PARTIDAID]),
    CONSTRAINT [FK__PontePart__PARTI__4CA06362] FOREIGN KEY ([PARTIDAID]) REFERENCES [fatopartida] ([PartidaID]),
    CONSTRAINT [FK__PontePart__TIMEI__4BAC3F29] FOREIGN KEY ([TIMEID]) REFERENCES [DimClube] ([TimeID])
);
GO

CREATE INDEX [IX_DimJogador_TimeID] ON [DimJogador] ([TimeID]);
GO

CREATE INDEX [IX_fatocartao_JogadorID] ON [fatocartao] ([JogadorID]);
GO

CREATE INDEX [IX_fatocartao_PartidaID] ON [fatocartao] ([PartidaID]);
GO

CREATE INDEX [IX_fatocartao_TimeID] ON [fatocartao] ([TimeID]);
GO

CREATE INDEX [IX_fatoclassificacao_TimeID] ON [fatoclassificacao] ([TimeID]);
GO

CREATE INDEX [IX_fatogol_JogadorID] ON [fatogol] ([JogadorID]);
GO

CREATE INDEX [IX_fatogol_PartidaID] ON [fatogol] ([PartidaID]);
GO

CREATE INDEX [IX_fatogol_TimeID] ON [fatogol] ([TimeID]);
GO

CREATE INDEX [IX_fatopartida_DataID] ON [fatopartida] ([DataID]);
GO

CREATE INDEX [IX_fatopartida_EstadioID] ON [fatopartida] ([EstadioID]);
GO

CREATE INDEX [IX_fatopartida_JuizID] ON [fatopartida] ([JuizID]);
GO

CREATE INDEX [IX_PontePartidaTime_PARTIDAID] ON [PontePartidaTime] ([PARTIDAID]);
GO

CREATE UNIQUE INDEX [IX_RefreshTokens_Token] ON [RefreshTokens] ([Token]);
GO

CREATE INDEX [IX_RefreshTokens_UserId_ExpiresAt] ON [RefreshTokens] ([UserId], [ExpiresAt]);
GO

CREATE UNIQUE INDEX [IX_Users_Email] ON [Users] ([Email]);
GO

CREATE UNIQUE INDEX [IX_Users_Username] ON [Users] ([Username]);
GO

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20250929210220_AddAuthModels', N'8.0.3');
GO

COMMIT;
GO

