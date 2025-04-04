USE futebol_OLAP_db;

-- Extract unique stadiums
INSERT INTO DimEstadio (Nome, Capacidade, Cidade) VALUES
('Arena Batistão', 15575, 'Aracaju'),
('Aristron Azevedo', 3000, 'N.Sra das Dores'),
('Paulo Barreto', 8000, 'Lagarto'),
('Etelvino Mendonça', 10000, 'Itabaiana'),
('Durval Feitosa', 2000, 'Propriá'),
('Caio Feitosa', 3000, 'Porto da Folha');

-- Extract unique clubs
INSERT INTO DimClube (Nome, Titulos, Fundacao, Sede, participacao) VALUES
('Sergipe', 37, '19091017', 'Aracaju', 102),
('Barra', 0, '20140321', 'Barra dos Coqueiros', 1),
('Dorense', 0, '19480530', 'Nossa Senhora das Dores', 16),
('Falcon', 0, '20201123', 'Aracaju', 4),
('Lagarto', 0, '20090420', 'Lagarto', 14),
('América', 2, '19420808', 'Propriá', 19),
('Confiança', 23, '19360501', 'Aracaju', 74),
('Guarany', 0, '19400101', 'Porto da Folha', 18),
('Itabaiana', 11, '19380710', 'Itabaiana', 72),
('Carmópolis', 0, '20220612', 'Carmópolis', 2);

-- Insert dates - converting from DD-MMM format to proper dates (assuming 2024 year)
INSERT INTO DimData (Data, Ano, Mes, Dia, DiaSemana) VALUES
('2024-01-11', 2024, 1, 11, 'SAB'),
('2024-01-13', 2024, 1, 13, 'SEG'),
('2024-01-14', 2024, 1, 14, 'TER'),
('2024-01-15', 2024, 1, 15, 'QUA'),
('2024-01-16', 2024, 1, 16, 'QUI'),
('2024-01-19', 2024, 1, 19, 'DOM'),
('2024-01-20', 2024, 1, 20, 'SEG'),
('2024-01-22', 2024, 1, 22, 'QUA'),
('2024-01-23', 2024, 1, 23, 'QUI'),
('2024-01-25', 2024, 1, 25, 'SAB'),
('2024-01-26', 2024, 1, 26, 'DOM'),
('2024-01-29', 2024, 1, 29, 'QUA'),
('2024-02-01', 2024, 2, 1, 'SAB'),
('2024-02-02', 2024, 2, 2, 'DOM'),
('2024-02-03', 2024, 2, 3, 'SEG'),
('2024-02-08', 2024, 2, 8, 'SAB'),
('2024-02-09', 2024, 2, 9, 'DOM'),
('2024-02-10', 2024, 2, 10, 'SEG'),
('2024-02-15', 2024, 2, 15, 'SAB'),
('2024-02-16', 2024, 2, 16, 'DOM'),
('2024-02-22', 2024, 2, 22, 'SAB'),
('2024-02-23', 2024, 2, 23, 'DOM'),
('2024-02-24', 2024, 2, 24, 'SEG'),
('2024-03-01', 2024, 3, 1, 'SAB');

-- Map matches to fact table - using variables to get the IDs from dimension tables
-- For simplicity, using positions that correspond to the ordering above
-- In a real scenario, you'd use SELECT statements to get the exact IDs

--Juiz generico temporario
INSERT INTO DimJuiz (NOME,NIVEL)
VALUES('GENERICO','ESTADUAL')

-- Rodada 1
INSERT INTO fatopartida (DataID, EstadioID, JuizID, Publico, Renda, RESULTADO)
VALUES (1, 1, 1, NULL, NULL, '1 X 1'); -- Sergipe x Barra

INSERT INTO fatopartida (DataID, EstadioID, JuizID, Publico, Renda, RESULTADO)
VALUES (1, 2, 1, NULL, NULL, '0 X 2'); -- Dorense x Falcon

INSERT INTO fatopartida (DataID, EstadioID, JuizID, Publico, Renda, RESULTADO)
VALUES (1, 3, 1, NULL, NULL, '2 X 1'); -- Lagarto x América

INSERT INTO fatopartida (DataID, EstadioID, JuizID, Publico, Renda, RESULTADO)
VALUES (2, 1, 1, NULL, NULL, '5 X 1'); -- Confiança x Guarany

INSERT INTO fatopartida (DataID, EstadioID, JuizID, Publico, Renda, RESULTADO)
VALUES (1, 4, 1, NULL, NULL, '2 X 1'); -- Itabaiana x Carmópolis

-- Rodada 2
INSERT INTO fatopartida (DataID, EstadioID, JuizID, Publico, Renda, RESULTADO)
VALUES (3, 5, 1, NULL, NULL, '1 X 0'); -- América x Dorense

INSERT INTO fatopartida (DataID, EstadioID, JuizID, Publico, Renda, RESULTADO)
VALUES (9, 3, 1, NULL, NULL, '0 X 5'); -- Barra x Lagarto

INSERT INTO fatopartida (DataID, EstadioID, JuizID, Publico, Renda, RESULTADO)
VALUES (4, 1, 1, NULL, NULL, '1 X 2'); -- Carmópolis x Sergipe

INSERT INTO fatopartida (DataID, EstadioID, JuizID, Publico, Renda, RESULTADO)
VALUES (8, 6, 1, NULL, NULL, '1 X 1'); -- Guarany x Itabaiana

INSERT INTO fatopartida (DataID, EstadioID, JuizID, Publico, Renda, RESULTADO)
VALUES (5, 1, 1, NULL, NULL, '1 X 3'); -- Falcon x Confiança

-- Rodada 3
INSERT INTO fatopartida (DataID, EstadioID, JuizID, Publico, Renda, RESULTADO)
VALUES (12, 5, 1, NULL, NULL, '1 X 1'); -- América x Confiança

INSERT INTO fatopartida (DataID, EstadioID, JuizID, Publico, Renda, RESULTADO)
VALUES (7, 1, 1, NULL, NULL, '4 X 0'); -- Falcon x Barra

INSERT INTO fatopartida (DataID, EstadioID, JuizID, Publico, Renda, RESULTADO)
VALUES (7, 2, 1, NULL, NULL, '0 X 0'); -- Dorense x Carmópolis

INSERT INTO fatopartida (DataID, EstadioID, JuizID, Publico, Renda, RESULTADO)
VALUES (6, 3, 1, NULL, NULL, '4 X 0'); -- Lagarto x Guarany

INSERT INTO fatopartida (DataID, EstadioID, JuizID, Publico, Renda, RESULTADO)
VALUES (6, 4, 1, NULL, NULL, '1 X 1'); -- Itabaiana x Sergipe

-- Rodada 4
INSERT INTO fatopartida (DataID, EstadioID, JuizID, Publico, Renda, RESULTADO)
VALUES (11, 1, 1, NULL, NULL, '1 X 2'); -- Carmópolis x Confiança

INSERT INTO fatopartida (DataID, EstadioID, JuizID, Publico, Renda, RESULTADO)
VALUES (11, 6, 1, NULL, NULL, '1 X 0'); -- Guarany x Barra

INSERT INTO fatopartida (DataID, EstadioID, JuizID, Publico, Renda, RESULTADO)
VALUES (10, 5, 1, NULL, NULL, '1 X 1'); -- América x Itabaiana

INSERT INTO fatopartida (DataID, EstadioID, JuizID, Publico, Renda, RESULTADO)
VALUES (10, 1, 1, NULL, NULL, '0 X 1'); -- Sergipe x Falcon

INSERT INTO fatopartida (DataID, EstadioID, JuizID, Publico, Renda, RESULTADO)
VALUES (11, 3, 1, NULL, NULL, '1 X 1'); -- Lagarto x Dorense

-- Rodada 5
INSERT INTO fatopartida (DataID, EstadioID, JuizID, Publico, Renda, RESULTADO)
VALUES (14, 1, 1, NULL, NULL, '4 X 0'); -- Confiança x Lagarto

INSERT INTO fatopartida (DataID, EstadioID, JuizID, Publico, Renda, RESULTADO)
VALUES (13, 2, 1, NULL, NULL, '0 X 1'); -- Dorense x Sergipe

INSERT INTO fatopartida (DataID, EstadioID, JuizID, Publico, Renda, RESULTADO)
VALUES (14, 5, 1, NULL, NULL, '3 X 0'); -- América x Guarany

INSERT INTO fatopartida (DataID, EstadioID, JuizID, Publico, Renda, RESULTADO)
VALUES (13, 4, 1, NULL, NULL, '4 X 0'); -- Itabaiana x Falcon

INSERT INTO fatopartida (DataID, EstadioID, JuizID, Publico, Renda, RESULTADO)
VALUES (15, 3, 1, NULL, NULL, '3 X 2'); -- Barra x Carmópolis

-- Rodada 6
INSERT INTO fatopartida (DataID, EstadioID, JuizID, Publico, Renda, RESULTADO)
VALUES (17, 1, 1, NULL, NULL, '2 X 1'); -- Confiança x Sergipe

INSERT INTO fatopartida (DataID, EstadioID, JuizID, Publico, Renda, RESULTADO)
VALUES (16, 3, 1, NULL, NULL, '0 X 1'); -- Lagarto x Itabaiana

INSERT INTO fatopartida (DataID, EstadioID, JuizID, Publico, Renda, RESULTADO)
VALUES (16, 2, 1, NULL, NULL, '1 X 2'); -- Dorense x Guarany

INSERT INTO fatopartida (DataID, EstadioID, JuizID, Publico, Renda, RESULTADO)
VALUES (18, 1, 1, NULL, NULL, '3 X 2'); -- Falcon x Carmópolis

INSERT INTO fatopartida (DataID, EstadioID, JuizID, Publico, Renda, RESULTADO)
VALUES (17, 3, 1, NULL, NULL, '1 X 0'); -- Barra x América

-- Rodada 7
INSERT INTO fatopartida (DataID, EstadioID, JuizID, Publico, Renda, RESULTADO)
VALUES (19, 1, 1, NULL, NULL, '8 X 1'); -- Confiança x Barra

INSERT INTO fatopartida (DataID, EstadioID, JuizID, Publico, Renda, RESULTADO)
VALUES (19, 2, 1, NULL, NULL, '1 X 1'); -- Carmópolis x América

INSERT INTO fatopartida (DataID, EstadioID, JuizID, Publico, Renda, RESULTADO)
VALUES (19, 6, 1, NULL, NULL, '2 X 0'); -- Guarany x Falcon

INSERT INTO fatopartida (DataID, EstadioID, JuizID, Publico, Renda, RESULTADO)
VALUES (20, 4, 1, NULL, NULL, '4 X 1'); -- Itabaiana x Dorense

INSERT INTO fatopartida (DataID, EstadioID, JuizID, Publico, Renda, RESULTADO)
VALUES (20, 1, 1, NULL, NULL, '0 X 4'); -- Sergipe x Lagarto

-- Rodada 8
INSERT INTO fatopartida (DataID, EstadioID, JuizID, Publico, Renda, RESULTADO)
VALUES (22, 1, 1, NULL, NULL, '0 X 0'); -- Confiança x Itabaiana

INSERT INTO fatopartida (DataID, EstadioID, JuizID, Publico, Renda, RESULTADO)
VALUES (21, 1, 1, NULL, NULL, '4 X 0'); -- Sergipe x Guarany

INSERT INTO fatopartida (DataID, EstadioID, JuizID, Publico, Renda, RESULTADO)
VALUES (21, 2, 1, NULL, NULL, '1 X 1'); -- Carmópolis x Lagarto

INSERT INTO fatopartida (DataID, EstadioID, JuizID, Publico, Renda, RESULTADO)
VALUES (21, 3, 1, NULL, NULL, '0 X 2'); -- Barra x Dorense

INSERT INTO fatopartida (DataID, EstadioID, JuizID, Publico, Renda, RESULTADO)
VALUES (23, 1, 1, NULL, NULL, '0 X 1'); -- Falcon x América

-- Rodada 9
INSERT INTO fatopartida (DataID, EstadioID, JuizID, Publico, Renda, RESULTADO)
VALUES (24, 4, 1, NULL, NULL, '4 X 2'); -- Itabaiana x Barra

INSERT INTO fatopartida (DataID, EstadioID, JuizID, Publico, Renda, RESULTADO)
VALUES (24, 2, 1, NULL, NULL, '2 X 1'); -- Dorense x Confiança

INSERT INTO fatopartida (DataID, EstadioID, JuizID, Publico, Renda, RESULTADO)
VALUES (24, 3, 1, NULL, NULL, '3 X 0'); -- Lagarto x Falcon

INSERT INTO fatopartida (DataID, EstadioID, JuizID, Publico, Renda, RESULTADO)
VALUES (24, 1, 1, NULL, NULL, '0 X 1'); -- Sergipe x América

INSERT INTO fatopartida (DataID, EstadioID, JuizID, Publico, Renda, RESULTADO)
VALUES (24, 6, 1, NULL, NULL, '2 X 1'); -- Guarany x Carmópolis


-- Now populate the bridge table PontePartidaTime
-- For rodada 1
-- Sergipe x Barra (1x1)
INSERT INTO PontePartidaTime (TIMEID, PARTIDAID, PosseDeBola, Escanteios, ChutesAGol, Impedimentos)
VALUES (1, 1, NULL, NULL, NULL, NULL), (2, 1, NULL, NULL, NULL, NULL);

-- Dorense x Falcon (0x2)
INSERT INTO PontePartidaTime (TIMEID, PARTIDAID, PosseDeBola, Escanteios, ChutesAGol, Impedimentos)
VALUES (3, 2, NULL, NULL, NULL, NULL), (4, 2, NULL, NULL, NULL, NULL);

-- Lagarto x América (2x1)
INSERT INTO PontePartidaTime (TIMEID, PARTIDAID, PosseDeBola, Escanteios, ChutesAGol, Impedimentos)
VALUES (5, 3, NULL, NULL, NULL, NULL), (6, 3, NULL, NULL, NULL, NULL);

-- Confiança x Guarany (5x1)
INSERT INTO PontePartidaTime (TIMEID, PARTIDAID, PosseDeBola, Escanteios, ChutesAGol, Impedimentos)
VALUES (7, 4, NULL, NULL, NULL, NULL), (8, 4, NULL, NULL, NULL, NULL);

-- Itabaiana x Carmópolis (2x1)
INSERT INTO PontePartidaTime (TIMEID, PARTIDAID, PosseDeBola, Escanteios, ChutesAGol, Impedimentos)
VALUES (9, 5, NULL, NULL, NULL, NULL), (10, 5, NULL, NULL, NULL, NULL);

-- For rodada 2
-- América x Dorense (1x0)
INSERT INTO PontePartidaTime (TIMEID, PARTIDAID, PosseDeBola, Escanteios, ChutesAGol, Impedimentos)
VALUES (6, 6, NULL, NULL, NULL, NULL), (3, 6, NULL, NULL, NULL, NULL);

-- Barra x Lagarto (0x5)
INSERT INTO PontePartidaTime (TIMEID, PARTIDAID, PosseDeBola, Escanteios, ChutesAGol, Impedimentos)
VALUES (2, 7, NULL, NULL, NULL, NULL), (5, 7, NULL, NULL, NULL, NULL);

-- Carmópolis x Sergipe (1x2)
INSERT INTO PontePartidaTime (TIMEID, PARTIDAID, PosseDeBola, Escanteios, ChutesAGol, Impedimentos)
VALUES (10, 8, NULL, NULL, NULL, NULL), (1, 8, NULL, NULL, NULL, NULL);

-- Guarany x Itabaiana (1x1)
INSERT INTO PontePartidaTime (TIMEID, PARTIDAID, PosseDeBola, Escanteios, ChutesAGol, Impedimentos)
VALUES (8, 9, NULL, NULL, NULL, NULL), (9, 9, NULL, NULL, NULL, NULL);

-- Falcon x Confiança (1x3)
INSERT INTO PontePartidaTime (TIMEID, PARTIDAID, PosseDeBola, Escanteios, ChutesAGol, Impedimentos)
VALUES (4, 10, NULL, NULL, NULL, NULL), (7, 10, NULL, NULL, NULL, NULL);

-- For rodada 3
-- América x Confiança (1x1)
INSERT INTO PontePartidaTime (TIMEID, PARTIDAID, PosseDeBola, Escanteios, ChutesAGol, Impedimentos)
VALUES (6, 11, NULL, NULL, NULL, NULL), (7, 11, NULL, NULL, NULL, NULL);

-- Falcon x Barra (4x0)
INSERT INTO PontePartidaTime (TIMEID, PARTIDAID, PosseDeBola, Escanteios, ChutesAGol, Impedimentos)
VALUES (4, 12, NULL, NULL, NULL, NULL), (2, 12, NULL, NULL, NULL, NULL);

-- Dorense x Carmópolis (0x0)
INSERT INTO PontePartidaTime (TIMEID, PARTIDAID, PosseDeBola, Escanteios, ChutesAGol, Impedimentos)
VALUES (3, 13, NULL, NULL, NULL, NULL), (10, 13, NULL, NULL, NULL, NULL);

-- Lagarto x Guarany (4x0)
INSERT INTO PontePartidaTime (TIMEID, PARTIDAID, PosseDeBola, Escanteios, ChutesAGol, Impedimentos)
VALUES (5, 14, NULL, NULL, NULL, NULL), (8, 14, NULL, NULL, NULL, NULL);

-- Itabaiana x Sergipe (1x1)
INSERT INTO PontePartidaTime (TIMEID, PARTIDAID, PosseDeBola, Escanteios, ChutesAGol, Impedimentos)
VALUES (9, 15, NULL, NULL, NULL, NULL), (1, 15, NULL, NULL, NULL, NULL);

-- For rodada 4
-- Carmópolis x Confiança (1x2)
INSERT INTO PontePartidaTime (TIMEID, PARTIDAID, PosseDeBola, Escanteios, ChutesAGol, Impedimentos)
VALUES (10, 16, NULL, NULL, NULL, NULL), (7, 16, NULL, NULL, NULL, NULL);

-- Guarany x Barra (1x0)
INSERT INTO PontePartidaTime (TIMEID, PARTIDAID, PosseDeBola, Escanteios, ChutesAGol, Impedimentos)
VALUES (8, 17, NULL, NULL, NULL, NULL), (2, 17, NULL, NULL, NULL, NULL);

-- América x Itabaiana (1x1)
INSERT INTO PontePartidaTime (TIMEID, PARTIDAID, PosseDeBola, Escanteios, ChutesAGol, Impedimentos)
VALUES (6, 18, NULL, NULL, NULL, NULL), (9, 18, NULL, NULL, NULL, NULL);

-- Sergipe x Falcon (0x1)
INSERT INTO PontePartidaTime (TIMEID, PARTIDAID, PosseDeBola, Escanteios, ChutesAGol, Impedimentos)
VALUES (1, 19, NULL, NULL, NULL, NULL), (4, 19, NULL, NULL, NULL, NULL);

-- Lagarto x Dorense (1x1)
INSERT INTO PontePartidaTime (TIMEID, PARTIDAID, PosseDeBola, Escanteios, ChutesAGol, Impedimentos)
VALUES (5, 20, NULL, NULL, NULL, NULL), (3, 20, NULL, NULL, NULL, NULL);

-- For rodada 5
-- Confiança x Lagarto (4x0)
INSERT INTO PontePartidaTime (TIMEID, PARTIDAID, PosseDeBola, Escanteios, ChutesAGol, Impedimentos)
VALUES (7, 21, NULL, NULL, NULL, NULL), (5, 21, NULL, NULL, NULL, NULL);

-- Dorense x Sergipe (0x1)
INSERT INTO PontePartidaTime (TIMEID, PARTIDAID, PosseDeBola, Escanteios, ChutesAGol, Impedimentos)
VALUES (3, 22, NULL, NULL, NULL, NULL), (1, 22, NULL, NULL, NULL, NULL);

-- América x Guarany (3x0)
INSERT INTO PontePartidaTime (TIMEID, PARTIDAID, PosseDeBola, Escanteios, ChutesAGol, Impedimentos)
VALUES (6, 23, NULL, NULL, NULL, NULL), (8, 23, NULL, NULL, NULL, NULL);

-- Itabaiana x Falcon (4x0)
INSERT INTO PontePartidaTime (TIMEID, PARTIDAID, PosseDeBola, Escanteios, ChutesAGol, Impedimentos)
VALUES (9, 24, NULL, NULL, NULL, NULL), (4, 24, NULL, NULL, NULL, NULL);

-- Barra x Carmópolis (3x2)
INSERT INTO PontePartidaTime (TIMEID, PARTIDAID, PosseDeBola, Escanteios, ChutesAGol, Impedimentos)
VALUES (2, 25, NULL, NULL, NULL, NULL), (10, 25, NULL, NULL, NULL, NULL);

-- For rodada 6
-- Confiança x Sergipe (2x1)
INSERT INTO PontePartidaTime (TIMEID, PARTIDAID, PosseDeBola, Escanteios, ChutesAGol, Impedimentos)
VALUES (7, 26, NULL, NULL, NULL, NULL), (1, 26, NULL, NULL, NULL, NULL);

-- Lagarto x Itabaiana (0x1)
INSERT INTO PontePartidaTime (TIMEID, PARTIDAID, PosseDeBola, Escanteios, ChutesAGol, Impedimentos)
VALUES (5, 27, NULL, NULL, NULL, NULL), (9, 27, NULL, NULL, NULL, NULL);

-- Dorense x Guarany (1x2)
INSERT INTO PontePartidaTime (TIMEID, PARTIDAID, PosseDeBola, Escanteios, ChutesAGol, Impedimentos)
VALUES (3, 28, NULL, NULL, NULL, NULL), (8, 28, NULL, NULL, NULL, NULL);

-- Falcon x Carmópolis (3x2)
INSERT INTO PontePartidaTime (TIMEID, PARTIDAID, PosseDeBola, Escanteios, ChutesAGol, Impedimentos)
VALUES (4, 29, NULL, NULL, NULL, NULL), (10, 29, NULL, NULL, NULL, NULL);

-- Barra x América (1x0)
INSERT INTO PontePartidaTime (TIMEID, PARTIDAID, PosseDeBola, Escanteios, ChutesAGol, Impedimentos)
VALUES (2, 30, NULL, NULL, NULL, NULL), (6, 30, NULL, NULL, NULL, NULL);

-- For rodada 7
-- Confiança x Barra (8x1)
INSERT INTO PontePartidaTime (TIMEID, PARTIDAID, PosseDeBola, Escanteios, ChutesAGol, Impedimentos)
VALUES (7, 31, NULL, NULL, NULL, NULL), (2, 31, NULL, NULL, NULL, NULL);

-- Carmópolis x América (1x1)
INSERT INTO PontePartidaTime (TIMEID, PARTIDAID, PosseDeBola, Escanteios, ChutesAGol, Impedimentos)
VALUES (10, 32, NULL, NULL, NULL, NULL), (6, 32, NULL, NULL, NULL, NULL);

-- Guarany x Falcon (2x0)
INSERT INTO PontePartidaTime (TIMEID, PARTIDAID, PosseDeBola, Escanteios, ChutesAGol, Impedimentos)
VALUES (8, 33, NULL, NULL, NULL, NULL), (4, 33, NULL, NULL, NULL, NULL);

-- Itabaiana x Dorense (4x1)
INSERT INTO PontePartidaTime (TIMEID, PARTIDAID, PosseDeBola, Escanteios, ChutesAGol, Impedimentos)
VALUES (9, 34, NULL, NULL, NULL, NULL), (3, 34, NULL, NULL, NULL, NULL);

-- Sergipe x Lagarto (0x4)
INSERT INTO PontePartidaTime (TIMEID, PARTIDAID, PosseDeBola, Escanteios, ChutesAGol, Impedimentos)
VALUES (1, 35, NULL, NULL, NULL, NULL), (5, 35, NULL, NULL, NULL, NULL);

-- For rodada 8
-- Confiança x Itabaiana (0x0)
INSERT INTO PontePartidaTime (TIMEID, PARTIDAID, PosseDeBola, Escanteios, ChutesAGol, Impedimentos)
VALUES (7, 36, NULL, NULL, NULL, NULL), (9, 36, NULL, NULL, NULL, NULL);

-- Sergipe x Guarany (4x0)
INSERT INTO PontePartidaTime (TIMEID, PARTIDAID, PosseDeBola, Escanteios, ChutesAGol, Impedimentos)
VALUES (1, 37, NULL, NULL, NULL, NULL), (8, 37, NULL, NULL, NULL, NULL);

-- Carmópolis x Lagarto (1x1)
INSERT INTO PontePartidaTime (TIMEID, PARTIDAID, PosseDeBola, Escanteios, ChutesAGol, Impedimentos)
VALUES (10, 38, NULL, NULL, NULL, NULL), (5, 38, NULL, NULL, NULL, NULL);

-- Barra x Dorense (0x2)
INSERT INTO PontePartidaTime (TIMEID, PARTIDAID, PosseDeBola, Escanteios, ChutesAGol, Impedimentos)
VALUES (2, 39, NULL, NULL, NULL, NULL), (3, 39, NULL, NULL, NULL, NULL);

-- Falcon x América (0x1)
INSERT INTO PontePartidaTime (TIMEID, PARTIDAID, PosseDeBola, Escanteios, ChutesAGol, Impedimentos)
VALUES (4, 40, NULL, NULL, NULL, NULL), (6, 40, NULL, NULL, NULL, NULL);

-- For rodada 9
-- Itabaiana x Barra (4x2)
INSERT INTO PontePartidaTime (TIMEID, PARTIDAID, PosseDeBola, Escanteios, ChutesAGol, Impedimentos)
VALUES (9, 41, NULL, NULL, NULL, NULL), (2, 41, NULL, NULL, NULL, NULL);

-- Dorense x Confiança (2x1)
INSERT INTO PontePartidaTime (TIMEID, PARTIDAID, PosseDeBola, Escanteios, ChutesAGol, Impedimentos)
VALUES (3, 42, NULL, NULL, NULL, NULL), (7, 42, NULL, NULL, NULL, NULL);

-- Lagarto x Falcon (3x0)
INSERT INTO PontePartidaTime (TIMEID, PARTIDAID, PosseDeBola, Escanteios, ChutesAGol, Impedimentos)
VALUES (5, 43, NULL, NULL, NULL, NULL), (4, 43, NULL, NULL, NULL, NULL);

-- Sergipe x América (0x1)
INSERT INTO PontePartidaTime (TIMEID, PARTIDAID, PosseDeBola, Escanteios, ChutesAGol, Impedimentos)
VALUES (1, 44, NULL, NULL, NULL, NULL), (6, 44, NULL, NULL, NULL, NULL);

-- Guarany x Carmópolis (2x1)
INSERT INTO PontePartidaTime (TIMEID, PARTIDAID, PosseDeBola, Escanteios, ChutesAGol, Impedimentos)
VALUES (8, 45, NULL, NULL, NULL, NULL), (10, 45, NULL, NULL, NULL, NULL);

-- Rodada 1
-- Sergipe x Barra (1x1)
INSERT INTO fatogol(PartidaID, JogadorID, TimeID, Minuto, Tempo)
VALUES (1, NULL, 1, NULL, NULL), (1, NULL, 2, NULL, NULL);

-- Dorense x Falcon (0x2)
INSERT INTO fatogol(PartidaID, JogadorID, TimeID, Minuto, Tempo)
VALUES (2, NULL, 4, NULL, NULL), (2, NULL, 4, NULL, NULL);

-- Lagarto x América (2x1)
INSERT INTO fatogol(PartidaID, JogadorID, TimeID, Minuto, Tempo)
VALUES (3, NULL, 5, NULL, NULL), (3, NULL, 5, NULL, NULL), (3, NULL, 6, NULL, NULL);

-- Confiança x Guarany (5x1)
INSERT INTO fatogol(PartidaID, JogadorID, TimeID, Minuto, Tempo)
VALUES (4, NULL, 7, NULL, NULL), (4, NULL, 7, NULL, NULL), (4, NULL, 7, NULL, NULL),
       (4, NULL, 7, NULL, NULL), (4, NULL, 7, NULL, NULL), (4, NULL, 8, NULL, NULL);

-- Itabaiana x Carmópolis (2x1)
INSERT INTO fatogol(PartidaID, JogadorID, TimeID, Minuto, Tempo)
VALUES (5, NULL, 9, NULL, NULL), (5, NULL, 9, NULL, NULL), (5, NULL, 10, NULL, NULL);

-- Rodada 2
-- América x Dorense (1x0)
INSERT INTO fatogol(PartidaID, JogadorID, TimeID, Minuto, Tempo)
VALUES (6, NULL, 6, NULL, NULL);

-- Barra x Lagarto (0x5)
INSERT INTO fatogol(PartidaID, JogadorID, TimeID, Minuto, Tempo)
VALUES (7, NULL, 5, NULL, NULL), (7, NULL, 5, NULL, NULL), (7, NULL, 5, NULL, NULL),
       (7, NULL, 5, NULL, NULL), (7, NULL, 5, NULL, NULL);

-- Carmópolis x Sergipe (1x2)
INSERT INTO fatogol(PartidaID, JogadorID, TimeID, Minuto, Tempo)
VALUES (8, NULL, 10, NULL, NULL), (8, NULL, 1, NULL, NULL), (8, NULL, 1, NULL, NULL);

-- Guarany x Itabaiana (1x1)
INSERT INTO fatogol(PartidaID, JogadorID, TimeID, Minuto, Tempo)
VALUES (9, NULL, 8, NULL, NULL), (9, NULL, 9, NULL, NULL);

-- Falcon x Confiança (1x3)
INSERT INTO fatogol(PartidaID, JogadorID, TimeID, Minuto, Tempo)
VALUES (10, NULL, 4, NULL, NULL), (10, NULL, 7, NULL, NULL), (10, NULL, 7, NULL, NULL),
       (10, NULL, 7, NULL, NULL);

-- Rodada 3
-- América x Confiança (1x1)
INSERT INTO fatogol(PartidaID, JogadorID, TimeID, Minuto, Tempo)
VALUES (11, NULL, 6, NULL, NULL), (11, NULL, 7, NULL, NULL);

-- Falcon x Barra (4x0)
INSERT INTO fatogol(PartidaID, JogadorID, TimeID, Minuto, Tempo)
VALUES (12, NULL, 4, NULL, NULL), (12, NULL, 4, NULL, NULL), (12, NULL, 4, NULL, NULL),
       (12, NULL, 4, NULL, NULL);

-- Dorense x Carmópolis (0x0)
-- Não há gols para inserir

-- Lagarto x Guarany (4x0)
INSERT INTO fatogol(PartidaID, JogadorID, TimeID, Minuto, Tempo)
VALUES (14, NULL, 5, NULL, NULL), (14, NULL, 5, NULL, NULL), (14, NULL, 5, NULL, NULL),
       (14, NULL, 5, NULL, NULL);

-- Itabaiana x Sergipe (1x1)
INSERT INTO fatogol(PartidaID, JogadorID, TimeID, Minuto, Tempo)
VALUES (15, NULL, 9, NULL, NULL), (15, NULL, 1, NULL, NULL);

-- Rodada 4
-- Carmópolis x Confiança (1x2)
INSERT INTO fatogol(PartidaID, JogadorID, TimeID, Minuto, Tempo)
VALUES (16, NULL, 10, NULL, NULL), (16, NULL, 7, NULL, NULL), (16, NULL, 7, NULL, NULL);

-- Guarany x Barra (1x0)
INSERT INTO fatogol(PartidaID, JogadorID, TimeID, Minuto, Tempo)
VALUES (17, NULL, 8, NULL, NULL);

-- América x Itabaiana (1x1)
INSERT INTO fatogol(PartidaID, JogadorID, TimeID, Minuto, Tempo)
VALUES (18, NULL, 6, NULL, NULL), (18, NULL, 9, NULL, NULL);

-- Sergipe x Falcon (0x1)
INSERT INTO fatogol(PartidaID, JogadorID, TimeID, Minuto, Tempo)
VALUES (19, NULL, 4, NULL, NULL);

-- Lagarto x Dorense (1x1)
INSERT INTO fatogol(PartidaID, JogadorID, TimeID, Minuto, Tempo)
VALUES (20, NULL, 5, NULL, NULL), (20, NULL, 3, NULL, NULL);

-- Rodada 5
-- Confiança x Lagarto (4x0)
INSERT INTO fatogol(PartidaID, JogadorID, TimeID, Minuto, Tempo)
VALUES (21, NULL, 7, NULL, NULL), (21, NULL, 7, NULL, NULL), (21, NULL, 7, NULL, NULL),
       (21, NULL, 7, NULL, NULL);

-- Dorense x Sergipe (0x1)
INSERT INTO fatogol(PartidaID, JogadorID, TimeID, Minuto, Tempo)
VALUES (22, NULL, 1, NULL, NULL);

-- América x Guarany (3x0)
INSERT INTO fatogol(PartidaID, JogadorID, TimeID, Minuto, Tempo)
VALUES (23, NULL, 6, NULL, NULL), (23, NULL, 6, NULL, NULL), (23, NULL, 6, NULL, NULL);

-- Itabaiana x Falcon (4x0)
INSERT INTO fatogol(PartidaID, JogadorID, TimeID, Minuto, Tempo)
VALUES (24, NULL, 9, NULL, NULL), (24, NULL, 9, NULL, NULL), (24, NULL, 9, NULL, NULL),
       (24, NULL, 9, NULL, NULL);

-- Barra x Carmópolis (3x2)
INSERT INTO fatogol(PartidaID, JogadorID, TimeID, Minuto, Tempo)
VALUES (25, NULL, 2, NULL, NULL), (25, NULL, 2, NULL, NULL), (25, NULL, 2, NULL, NULL),
       (25, NULL, 10, NULL, NULL), (25, NULL, 10, NULL, NULL);

-- Rodada 6
-- Confiança x Sergipe (2x1)
INSERT INTO fatogol(PartidaID, JogadorID, TimeID, Minuto, Tempo)
VALUES (26, NULL, 7, NULL, NULL), (26, NULL, 7, NULL, NULL), (26, NULL, 1, NULL, NULL);

-- Lagarto x Itabaiana (0x1)
INSERT INTO fatogol(PartidaID, JogadorID, TimeID, Minuto, Tempo)
VALUES (27, NULL, 9, NULL, NULL);

-- Dorense x Guarany (1x2)
INSERT INTO fatogol(PartidaID, JogadorID, TimeID, Minuto, Tempo)
VALUES (28, NULL, 3, NULL, NULL), (28, NULL, 8, NULL, NULL), (28, NULL, 8, NULL, NULL);

-- Falcon x Carmópolis (3x2)
INSERT INTO fatogol(PartidaID, JogadorID, TimeID, Minuto, Tempo)
VALUES (29, NULL, 4, NULL, NULL), (29, NULL, 4, NULL, NULL), (29, NULL, 4, NULL, NULL),
       (29, NULL, 10, NULL, NULL), (29, NULL, 10, NULL, NULL);

-- Barra x América (1x0)
INSERT INTO fatogol(PartidaID, JogadorID, TimeID, Minuto, Tempo)
VALUES (30, NULL, 2, NULL, NULL);

-- Rodada 7
-- Confiança x Barra (8x1)
INSERT INTO fatogol(PartidaID, JogadorID, TimeID, Minuto, Tempo)
VALUES (31, NULL, 7, NULL, NULL), (31, NULL, 7, NULL, NULL), (31, NULL, 7, NULL, NULL),
       (31, NULL, 7, NULL, NULL), (31, NULL, 7, NULL, NULL), (31, NULL, 7, NULL, NULL),
       (31, NULL, 7, NULL, NULL), (31, NULL, 7, NULL, NULL), (31, NULL, 2, NULL, NULL);

-- Carmópolis x América (1x1)
INSERT INTO fatogol(PartidaID, JogadorID, TimeID, Minuto, Tempo)
VALUES (32, NULL, 10, NULL, NULL), (32, NULL, 6, NULL, NULL);

-- Guarany x Falcon (2x0)
INSERT INTO fatogol(PartidaID, JogadorID, TimeID, Minuto, Tempo)
VALUES (33, NULL, 8, NULL, NULL), (33, NULL, 8, NULL, NULL);

-- Itabaiana x Dorense (4x1)
INSERT INTO fatogol(PartidaID, JogadorID, TimeID, Minuto, Tempo)
VALUES (34, NULL, 9, NULL, NULL), (34, NULL, 9, NULL, NULL), (34, NULL, 9, NULL, NULL),
       (34, NULL, 9, NULL, NULL), (34, NULL, 3, NULL, NULL);

-- Sergipe x Lagarto (0x4)
INSERT INTO fatogol(PartidaID, JogadorID, TimeID, Minuto, Tempo)
VALUES (35, NULL, 5, NULL, NULL), (35, NULL, 5, NULL, NULL), (35, NULL, 5, NULL, NULL),
       (35, NULL, 5, NULL, NULL);

-- Rodada 8
-- Confiança x Itabaiana (0x0)
-- Não há gols para inserir

-- Sergipe x Guarany (4x0)
INSERT INTO fatogol(PartidaID, JogadorID, TimeID, Minuto, Tempo)
VALUES (37, NULL, 1, NULL, NULL), (37, NULL, 1, NULL, NULL), (37, NULL, 1, NULL, NULL),
       (37, NULL, 1, NULL, NULL);

-- Carmópolis x Lagarto (1x1)
INSERT INTO fatogol(PartidaID, JogadorID, TimeID, Minuto, Tempo)
VALUES (38, NULL, 10, NULL, NULL), (38, NULL, 5, NULL, NULL);

-- Barra x Dorense (0x2)
INSERT INTO fatogol(PartidaID, JogadorID, TimeID, Minuto, Tempo)
VALUES (39, NULL, 3, NULL, NULL), (39, NULL, 3, NULL, NULL);

-- Falcon x América (0x1)
INSERT INTO fatogol(PartidaID, JogadorID, TimeID, Minuto, Tempo)
VALUES (40, NULL, 6, NULL, NULL);

-- Rodada 9
-- Itabaiana x Barra (4x2)
INSERT INTO fatogol(PartidaID, JogadorID, TimeID, Minuto, Tempo)
VALUES (41, NULL, 9, NULL, NULL), (41, NULL, 9, NULL, NULL), (41, NULL, 9, NULL, NULL),
       (41, NULL, 9, NULL, NULL), (41, NULL, 2, NULL, NULL), (41, NULL, 2, NULL, NULL);

-- Dorense x Confiança (2x1)
INSERT INTO fatogol(PartidaID, JogadorID, TimeID, Minuto, Tempo)
VALUES (42, NULL, 3, NULL, NULL), (42, NULL, 3, NULL, NULL), (42, NULL, 7, NULL, NULL);

-- Lagarto x Falcon (3x0)
INSERT INTO fatogol(PartidaID, JogadorID, TimeID, Minuto, Tempo)
VALUES (43, NULL, 5, NULL, NULL), (43, NULL, 5, NULL, NULL), (43, NULL, 5, NULL, NULL);

-- Sergipe x América (0x1)
INSERT INTO fatogol(PartidaID, JogadorID, TimeID, Minuto, Tempo)
VALUES (44, NULL, 6, NULL, NULL);

-- Guarany x Carmópolis (2x1)
INSERT INTO fatogol(PartidaID, JogadorID, TimeID, Minuto, Tempo)
VALUES (45, NULL, 8, NULL, NULL), (45, NULL, 8, NULL, NULL), (45, NULL, 10, NULL, NULL);