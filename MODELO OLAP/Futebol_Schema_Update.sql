-- ============================================
-- ALTERAÇÃO DA TABELA fatopartida
-- Adicionar colunas MataMata e ResultadoPosPenalti
-- ============================================

USE futebol_OLAP_db;
GO

-- Adicionar coluna MataMata (booleana/bit)
ALTER TABLE fatopartida
ADD MataMata BIT NOT NULL DEFAULT 0;
GO

-- Adicionar coluna ResultadoPosPenalti
-- (apenas para jogos de mata-mata que foram para os pênaltis)
ALTER TABLE fatopartida
ADD ResultadoPosPenalti NVARCHAR(10) NULL;
GO

-- ============================================
-- CONSTRAINT para garantir regra de negócio
-- ResultadoPosPenalti só pode ter valor se MataMata = 1
-- ============================================

ALTER TABLE fatopartida
ADD CONSTRAINT CK_ResultadoPosPenalti_MataMata
CHECK (
    (MataMata = 1) OR
    (MataMata = 0 AND ResultadoPosPenalti IS NULL)
);
GO

-- ============================================
-- ATUALIZAR DADOS EXISTENTES
-- Partidas até ID 48: MataMata = 0 (fase de grupos)
-- Partidas acima de ID 48: MataMata = 1 (fase eliminatória)
-- ============================================

-- Atualizar partidas da fase de grupos (ID <= 48)
UPDATE fatopartida
SET MataMata = 0
WHERE PartidaID <= 45;
GO

-- Atualizar partidas da fase mata-mata (ID > 48)
UPDATE fatopartida
SET MataMata = 1
WHERE PartidaID > 45;
GO

-- ============================================
-- CRIAR ÍNDICE para melhorar performance em consultas
-- ============================================

CREATE INDEX IX_fatopartida_MataMata ON fatopartida(MataMata);
GO

-- ============================================
-- EXEMPLO DE USO
-- ============================================

/*
-- Consultar partidas de mata-mata
SELECT
    p.PartidaID,
    p.Resultado,
    p.ResultadoPosPenalti,
    p.MataMata,
    e.Nome AS Estadio,
    d.Data
FROM fatopartida p
JOIN DimEstadio e ON p.EstadioID = e.EstadioID
JOIN DimData d ON p.DataID = d.DataID
WHERE p.MataMata = 1
ORDER BY p.PartidaID;

-- Atualizar resultado pós-pênalti de uma partida específica
-- (exemplo: partida 49 terminou empatada mas teve vencedor nos pênaltis)
UPDATE fatopartida
SET ResultadoPosPenalti = '2x1'
WHERE PartidaID = 49 AND MataMata = 1;

-- Consultar estatísticas de mata-mata vs fase de grupos
SELECT
    MataMata,
    COUNT(*) AS TotalPartidas,
    AVG(Publico) AS MediaPublico,
    AVG(Renda) AS MediaRenda,
    COUNT(ResultadoPosPenalti) AS PartidasComPenaltis
FROM fatopartida
GROUP BY MataMata;
*/