USE futebol_OLAP_db;
-- Now populate the bridge table PontePartidaTime
-- For rodada 1
-- Sergipe x Barra (1x1)
INSERT INTO PontePartidaTime (TIMEID, PARTIDAID, PosseDeBola, Escanteios, ChutesAGol, Impedimentos)
VALUES (1, 1, 65, 9, 6, 1), (2, 1, 35, 0, 2, 0);

-- Dorense x Falcon (0x2)
INSERT INTO PontePartidaTime (TIMEID, PARTIDAID, PosseDeBola, Escanteios, ChutesAGol, Impedimentos)
VALUES (3, 2, 55, 4, 1, 1), (4, 2, 45, 3, 5, 1);

-- Lagarto x América (2x1)
INSERT INTO PontePartidaTime (TIMEID, PARTIDAID, PosseDeBola, Escanteios, ChutesAGol, Impedimentos)
VALUES (5, 3, 55, 2, 5, 0), (6, 3, 45, 1, 2, 0);

-- Confiança x Guarany (5x1)
INSERT INTO PontePartidaTime (TIMEID, PARTIDAID, PosseDeBola, Escanteios, ChutesAGol, Impedimentos)
VALUES (7, 4, 60, 6, 10, 2), (8, 4, 40, 5, 6, 3);

-- Itabaiana x Carmópolis (2x1)
INSERT INTO PontePartidaTime (TIMEID, PARTIDAID, PosseDeBola, Escanteios, ChutesAGol, Impedimentos)
VALUES (9, 5, 54, 8, 3, 1), (10, 5, 46, 1, 4, 1);

-- For rodada 2
-- América x Dorense (1x0)
INSERT INTO PontePartidaTime (TIMEID, PARTIDAID, PosseDeBola, Escanteios, ChutesAGol, Impedimentos)
VALUES (6, 6, 55, 5, 2, 2), (3, 6, 45, 1, 0, 2);

-- Barra x Lagarto (0x5)
INSERT INTO PontePartidaTime (TIMEID, PARTIDAID, PosseDeBola, Escanteios, ChutesAGol, Impedimentos)
VALUES (2, 7, 43, 0, 1, 0), (5, 7, 57, 2, 6, 0);

-- Carmópolis x Sergipe (1x2)
INSERT INTO PontePartidaTime (TIMEID, PARTIDAID, PosseDeBola, Escanteios, ChutesAGol, Impedimentos)
VALUES (10, 8, 53, 4, 5, 1), (1, 8, 47, 8, 2, 1);

-- Guarany x Itabaiana (1x1)
INSERT INTO PontePartidaTime (TIMEID, PARTIDAID, PosseDeBola, Escanteios, ChutesAGol, Impedimentos)
VALUES (8, 9, 46, 7, 3, 1), (9, 9, 54, 9, 6, 1);

-- Falcon x Confiança (1x3)
INSERT INTO PontePartidaTime (TIMEID, PARTIDAID, PosseDeBola, Escanteios, ChutesAGol, Impedimentos)
VALUES (4, 10, 53, 3, 6, 0), (7, 10, 47, 6, 8, 0);

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