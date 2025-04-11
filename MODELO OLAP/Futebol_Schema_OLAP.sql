-- SQL Server Schema for Football Database
-- Create Database
CREATE DATABASE futebol_OLAP_db;
GO
USE futebol_OLAP_db;
GO
-- Dimension Tables
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

-- Dim Stadium Table
CREATE TABLE DimEstadio (
    EstadioID INT PRIMARY KEY IDENTITY(1,1),
    Nome NVARCHAR(45) NULL,
    Capacidade INT NULL,
    Cidade NVARCHAR(45) NULL,
    Latitude FLOAT NULL,
    Longitude FLOAT NULL
);

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


-- Dim Player Table
CREATE TABLE DimJogador (
    JogadorID INT PRIMARY KEY IDENTITY(1,1),
    Nome NVARCHAR(45) NULL,
    Posicao NVARCHAR(45) NULL,
    Nascimento DATE NULL,
    TimeID INT NULL,
    FOREIGN KEY (TimeID) REFERENCES DimClube(TimeID)
);

CREATE TABLE AggArtilharia(
    JogadorID INT not null ,
    Gols INT,
    FOREIGN KEY (JogadorID) REFERENCES DimJogador(JogadorID),
    primary key(jogadorID)
)

-- Dim Referee Table
CREATE TABLE DimJuiz (
    JuizID INT PRIMARY KEY IDENTITY(1,1),
    Nome NVARCHAR(45) NULL,
    Nivel NVARCHAR(45) NULL,
    CHECK(Nivel IN('ESTADUAL','NACIONAL','INTERNACIONAL'))
);

-- Fact Tables
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
    FOREIGN KEY (JuizID) REFERENCES dimjuiz(JuizID),
);

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
)

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

-- Fact Classification Table
CREATE TABLE fatoclassificacao (
    RodadaID INT not null,
    TimeID INT not null,
    Pontos INT NULL,
    Jogos INT NULL,
    Vitorias INT NULL,
    Empates INT NULL,
    Derrotas INT NULL,
    GolsPro INT NULL,
    GolsContra INT NULL,
    Saldo as GolsPro - GolsContra,
    primary key (RodadaID,TimeID),
    FOREIGN KEY (TimeID) REFERENCES DimClube(TimeID)
);

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

SELECT
    dj.Nome AS 'Nome do Jogador',
    COUNT(fg.GolID) AS 'Número de Gols',
    dc.Nome AS 'Clube'
FROM fatogol fg
JOIN DimJogador dj ON dj.JogadorID = fg.JogadorID
JOIN DimClube dc ON dc.TimeID = dj.TimeID
GROUP BY dj.Nome, dc.Nome
ORDER BY COUNT(fg.GolID) DESC



