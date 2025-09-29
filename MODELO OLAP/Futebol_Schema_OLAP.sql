-- SQL Server Schema for Football Database
-- Create Database
CREATE DATABASE futebol_OLAP_db;
GO

USE futebol_OLAP_db;
GO

-- ============================================
-- AUTHENTICATION TABLES
-- ============================================

-- Users Table
CREATE TABLE [Users] (
    [Id] uniqueidentifier NOT NULL DEFAULT NEWID(),
    [Username] nvarchar(50) NOT NULL,
    [Email] nvarchar(100) NOT NULL,
    [PasswordHash] nvarchar(max) NOT NULL,
    [Role] nvarchar(20) NOT NULL,
    [CreatedAt] datetime2 NOT NULL DEFAULT GETDATE(),
    [IsActive] bit NOT NULL DEFAULT 1,
    CONSTRAINT [PK_Users] PRIMARY KEY ([Id])
);
GO

-- RefreshTokens Table
CREATE TABLE [RefreshTokens] (
    [Id] uniqueidentifier NOT NULL DEFAULT NEWID(),
    [UserId] uniqueidentifier NOT NULL,
    [Token] nvarchar(128) NOT NULL,
    [ExpiresAt] datetime2 NOT NULL,
    [CreatedAt] datetime2 NOT NULL DEFAULT GETDATE(),
    [IsRevoked] bit NOT NULL DEFAULT 0,
    CONSTRAINT [PK_RefreshTokens] PRIMARY KEY ([Id]),
    CONSTRAINT [FK_RefreshTokens_Users_UserId] FOREIGN KEY ([UserId]) REFERENCES [Users] ([Id]) ON DELETE CASCADE
);
GO

-- ============================================
-- DIMENSION TABLES
-- ============================================

-- Dim Data Table
CREATE TABLE DimData (
    DataID INT PRIMARY KEY IDENTITY(1,1),
    Data DATE NULL,
    Ano INT NULL,
    Mes INT NULL,
    Dia INT NULL,
    DiaSemana CHAR(3) NULL,
    CHECK(DiaSemana IN('DOM','SEG','TER','QUA','QUI','SEX','SAB'))
);
GO

-- Dim Stadium Table
CREATE TABLE DimEstadio (
    EstadioID INT PRIMARY KEY IDENTITY(1,1),
    Nome NVARCHAR(45) NULL,
    Capacidade INT NULL,
    Cidade NVARCHAR(45) NULL,
    Latitude FLOAT NULL,
    Longitude FLOAT NULL
);
GO

-- Dim Team Table
CREATE TABLE DimClube (
    TimeID INT PRIMARY KEY IDENTITY(1,1),
    Nome NVARCHAR(45) NOT NULL,
    Titulos INT NOT NULL, --da competição em disputa
    Participacoes INT NOT NULL, --da competição em disputa
    Fundacao DATE NOT NULL,
    Sede NVARCHAR(30) NOT NULL,
    Escudo NVARCHAR(1000) NULL
);
GO

-- Dim Player Table
CREATE TABLE DimJogador (
    JogadorID INT PRIMARY KEY IDENTITY(1,1),
    Nome NVARCHAR(45) NULL,
    Posicao NVARCHAR(45) NULL,
    Nascimento DATE NULL,
    TimeID INT NULL,
    FOREIGN KEY (TimeID) REFERENCES DimClube(TimeID)
);
GO

-- Aggregate Artilharia Table
CREATE TABLE AggArtilharia(
    JogadorID INT NOT NULL,
    Gols INT,
    FOREIGN KEY (JogadorID) REFERENCES DimJogador(JogadorID),
    PRIMARY KEY(JogadorID)
);
GO

-- Dim Referee Table
CREATE TABLE DimJuiz (
    JuizID INT PRIMARY KEY IDENTITY(1,1),
    Nome NVARCHAR(45) NULL,
    Nivel NVARCHAR(45) NULL,
    CHECK(Nivel IN('ESTADUAL','NACIONAL','INTERNACIONAL'))
);
GO

-- ============================================
-- FACT TABLES
-- ============================================

-- Fact Match Table
CREATE TABLE fatopartida (
    PartidaID INT NOT NULL IDENTITY(1,1),
    DataID INT NOT NULL,
    EstadioID INT NOT NULL,
    JuizID INT NOT NULL,
    Publico INT NULL,
    Renda DECIMAL(10,2) NULL,
    Resultado NVARCHAR(10),
    PRIMARY KEY (PartidaID),
    FOREIGN KEY (DataID) REFERENCES dimdata(DataID),
    FOREIGN KEY (EstadioID) REFERENCES dimestadio(EstadioID),
    FOREIGN KEY (JuizID) REFERENCES dimjuiz(JuizID)
);
GO

-- Bridge Table Match-Team
CREATE TABLE PontePartidaTime(
    TIMEID INT NOT NULL,
    PARTIDAID INT NOT NULL,
    PosseDeBola INT NULL,
    Escanteios INT NULL,
    ChutesAGol INT NULL,
    Impedimentos INT NULL,
    FOREIGN KEY (TIMEID) REFERENCES DimClube(TIMEID),
    FOREIGN KEY (PARTIDAID) REFERENCES fatopartida(PartidaID),
    PRIMARY KEY(TIMEID,PARTIDAID)
);
GO

-- Fact Card Table
CREATE TABLE fatocartao (
    CartaoID INT IDENTITY(1,1) PRIMARY KEY,
    PartidaID INT NOT NULL,
    JogadorID INT NOT NULL,
    TimeID INT NOT NULL,
    Minuto INT NULL,
    Tempo INT NULL CHECK (TEMPO IN (1, 2)),
    Cor CHAR(1) NULL CHECK (Cor IN ('A', 'V')),
    FOREIGN KEY (PartidaID) REFERENCES fatopartida(PartidaID),
    FOREIGN KEY (JogadorID) REFERENCES dimjogador(JogadorID),
    FOREIGN KEY (TimeID) REFERENCES DimClube(TimeID)
);
GO

-- Fact Classification Table
CREATE TABLE fatoclassificacao (
    RodadaID INT NOT NULL,
    TimeID INT NOT NULL,
    Pontos INT NULL,
    Jogos INT NULL,
    Vitorias INT NULL,
    Empates INT NULL,
    Derrotas INT NULL,
    GolsPro INT NULL,
    GolsContra INT NULL,
    Saldo AS GolsPro - GolsContra,
    PRIMARY KEY (RodadaID,TimeID),
    FOREIGN KEY (TimeID) REFERENCES DimClube(TimeID)
);
GO

-- Fact Goal Table
CREATE TABLE fatogol (
    GolID INT NOT NULL IDENTITY(1,1),
    PartidaID INT NOT NULL,
    JogadorID INT NOT NULL,
    TimeID INT NULL,
    Minuto INT NULL,
    Tempo INT NULL,
    GOLCONTRA INT NULL DEFAULT 0,
    CHECK(GOLCONTRA = 1 OR GOLCONTRA = 0),
    FOREIGN KEY (PartidaID) REFERENCES fatopartida(PartidaID),
    FOREIGN KEY (JogadorID) REFERENCES dimjogador(JogadorID),
    FOREIGN KEY (TimeID) REFERENCES DimClube(TimeID),
    PRIMARY KEY(GolID)
);
GO

-- ============================================
-- TRIGGERS
-- ============================================

CREATE OR ALTER TRIGGER trg_UpdateArtilharia
ON fatogol
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;

    -- Primeiro tratamos inserções para jogadores que JÁ existem na tabela AggArtilharia
    -- Agrupamos por JogadorID para lidar com múltiplos gols do mesmo jogador em um único INSERT
    UPDATE a
    SET a.Gols = a.Gols + i.NovosTotais
    FROM AggArtilharia a
    INNER JOIN (
        SELECT JogadorID, COUNT(*) AS NovosTotais
        FROM inserted
        WHERE ISNULL(GOLCONTRA, 0) = 0
        GROUP BY JogadorID
    ) i ON a.JogadorID = i.JogadorID;

    -- Depois inserimos registros para jogadores que ainda NÃO existem na tabela AggArtilharia
    INSERT INTO AggArtilharia (JogadorID, Gols)
    SELECT i.JogadorID, COUNT(*) AS Gols
    FROM inserted i
    LEFT JOIN AggArtilharia a ON i.JogadorID = a.JogadorID
    WHERE a.JogadorID IS NULL -- Apenas jogadores que não existem na tabela AggArtilharia
    AND ISNULL(i.GOLCONTRA, 0) = 0 -- Não conta gols contra
    GROUP BY i.JogadorID; -- Agrupa para contar múltiplos gols do mesmo jogador
END;
GO

-- ============================================
-- INDEXES
-- ============================================

-- Authentication Indexes
CREATE UNIQUE INDEX [IX_Users_Email] ON [Users] ([Email]);
GO
CREATE UNIQUE INDEX [IX_Users_Username] ON [Users] ([Username]);
GO
CREATE UNIQUE INDEX [IX_RefreshTokens_Token] ON [RefreshTokens] ([Token]);
GO
CREATE INDEX [IX_RefreshTokens_UserId_ExpiresAt] ON [RefreshTokens] ([UserId], [ExpiresAt]);
GO

-- Football Database Indexes
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

-- ============================================
-- EXAMPLE QUERIES
-- ============================================

-- Artilharia Query
/*
SELECT
    dj.Nome AS 'Nome do Jogador',
    COUNT(fg.GolID) AS 'Número de Gols',
    dc.Nome AS 'Clube'
FROM fatogol fg
JOIN DimJogador dj ON dj.JogadorID = fg.JogadorID
JOIN DimClube dc ON dc.TimeID = dj.TimeID
GROUP BY dj.Nome, dc.Nome
ORDER BY COUNT(fg.GolID) DESC;
*/

-- Base para mineração
/*
SELECT
    d.Nome AS NomeTime,
    ppt.PosseDeBola,
    ppt.Escanteios,
    ppt.ChutesAGol,
    ppt.Impedimentos,
    COALESCE(COUNT(fg.GolID), 0) AS Gols,
    CASE
        WHEN COALESCE(COUNT(fg.GolID), 0) > (
            SELECT MAX(gols_adversario.total_gols)
            FROM (
                SELECT COUNT(fg2.GolID) as total_gols
                FROM PontePartidaTime ppt2
                LEFT JOIN fatogol fg2 ON fg2.PartidaID = ppt2.PARTIDAID
                                       AND fg2.TimeID = ppt2.TIMEID
                                       AND fg2.GOLCONTRA = 0
                WHERE ppt2.PARTIDAID = ppt.PARTIDAID
                  AND ppt2.TIMEID != ppt.TIMEID
                GROUP BY ppt2.TIMEID
            ) gols_adversario
        ) THEN 'VITORIA'
        WHEN COALESCE(COUNT(fg.GolID), 0) = (
            SELECT MAX(gols_adversario.total_gols)
            FROM (
                SELECT COUNT(fg2.GolID) as total_gols
                FROM PontePartidaTime ppt2
                LEFT JOIN fatogol fg2 ON fg2.PartidaID = ppt2.PARTIDAID
                                       AND fg2.TimeID = ppt2.TIMEID
                                       AND fg2.GOLCONTRA = 0
                WHERE ppt2.PARTIDAID = ppt.PARTIDAID
                  AND ppt2.TIMEID != ppt.TIMEID
                GROUP BY ppt2.TIMEID
            ) gols_adversario
        ) THEN 'EMPATE'
        ELSE 'DERROTA'
    END AS Resultado
FROM
    PontePartidaTime ppt
LEFT JOIN
    DimClube d ON d.TimeID = ppt.TimeID
LEFT JOIN
    fatogol fg ON fg.PartidaID = ppt.PARTIDAID
                 AND fg.TimeID = ppt.TIMEID
                 AND fg.GOLCONTRA = 0  -- Excluir gols contra
GROUP BY
    ppt.TIMEID, ppt.PARTIDAID, d.Nome, ppt.PosseDeBola, ppt.Escanteios, ppt.ChutesAGol, ppt.Impedimentos
ORDER BY
    ppt.PARTIDAID;
*/