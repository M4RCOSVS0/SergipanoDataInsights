USE futebol_OLAP_db;


-- Extract unique clubs
INSERT INTO DimClube (Nome, Titulos, Fundacao, Sede, Participacoes) VALUES
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
VALUES (1, 1, 1, 903, 9020, '1 X 1'); -- Sergipe x Barra

INSERT INTO fatopartida (DataID, EstadioID, JuizID, Publico, Renda, RESULTADO)
VALUES (1, 2, 1, 335, 11250, '0 X 2'); -- Dorense x Falcon

INSERT INTO fatopartida (DataID, EstadioID, JuizID, Publico, Renda, RESULTADO)
VALUES (1, 3, 1, 178, 1990, '2 X 1'); -- Lagarto x América

INSERT INTO fatopartida (DataID, EstadioID, JuizID, Publico, Renda, RESULTADO)
VALUES (2, 1, 1, 2928, 58568, '5 X 1'); -- Confiança x Guarany

INSERT INTO fatopartida (DataID, EstadioID, JuizID, Publico, Renda, RESULTADO)
VALUES (1, 4, 1, 1019, 10662, '2 X 1'); -- Itabaiana x Carmópolis

-- Rodada 2
INSERT INTO fatopartida (DataID, EstadioID, JuizID, Publico, Renda, RESULTADO)
VALUES (3, 5, 1, 317, 2578, '1 X 0'); -- América x Dorense

INSERT INTO fatopartida (DataID, EstadioID, JuizID, Publico, Renda, RESULTADO)
VALUES (9, 3, 1, 688, 10480, '0 X 5'); -- Barra x Lagarto

INSERT INTO fatopartida (DataID, EstadioID, JuizID, Publico, Renda, RESULTADO)
VALUES (4, 1, 1, 728, 12580, '1 X 2'); -- Carmópolis x Sergipe

INSERT INTO fatopartida (DataID, EstadioID, JuizID, Publico, Renda, RESULTADO)
VALUES (8, 6, 1, 515, 10300, '1 X 1'); -- Guarany x Itabaiana

INSERT INTO fatopartida (DataID, EstadioID, JuizID, Publico, Renda, RESULTADO)
VALUES (5, 1, 1, 2080, 58065, '1 X 3'); -- Falcon x Confiança

-- Rodada 3
INSERT INTO fatopartida (DataID, EstadioID, JuizID, Publico, Renda, RESULTADO)
VALUES (12, 5, 1, 562, 7500, '1 X 1'); -- América x Confiança

INSERT INTO fatopartida (DataID, EstadioID, JuizID, Publico, Renda, RESULTADO)
VALUES (7, 1, 1, 168, 500, '4 X 0'); -- Falcon x Barra

INSERT INTO fatopartida (DataID, EstadioID, JuizID, Publico, Renda, RESULTADO)
VALUES (7, 2, 1, 295, 4000, '0 X 0'); -- Dorense x Carmópolis

INSERT INTO fatopartida (DataID, EstadioID, JuizID, Publico, Renda, RESULTADO)
VALUES (6, 3, 1, 706, 6370, '4 X 0'); -- Lagarto x Guarany

INSERT INTO fatopartida (DataID, EstadioID, JuizID, Publico, Renda, RESULTADO)
VALUES (6, 4, 1, 3250, 51182, '1 X 1'); -- Itabaiana x Sergipe

-- Rodada 4
INSERT INTO fatopartida (DataID, EstadioID, JuizID, Publico, Renda, RESULTADO)
VALUES (11, 1, 1, 1081, 24150, '1 X 2'); -- Carmópolis x Confiança

INSERT INTO fatopartida (DataID, EstadioID, JuizID, Publico, Renda, RESULTADO)
VALUES (11, 6, 1, 354, 7080, '1 X 0'); -- Guarany x Barra

INSERT INTO fatopartida (DataID, EstadioID, JuizID, Publico, Renda, RESULTADO)
VALUES (10, 5, 1, 347, 3200, '1 X 1'); -- América x Itabaiana

INSERT INTO fatopartida (DataID, EstadioID, JuizID, Publico, Renda, RESULTADO)
VALUES (10, 1, 1, 1167, 13436, '0 X 1'); -- Sergipe x Falcon

INSERT INTO fatopartida (DataID, EstadioID, JuizID, Publico, Renda, RESULTADO)
VALUES (11, 3, 1, 1226, 11520, '1 X 1'); -- Lagarto x Dorense

-- Rodada 5
INSERT INTO fatopartida (DataID, EstadioID, JuizID, Publico, Renda, RESULTADO)
VALUES (14, 1, 1, 2737, 49650, '4 X 0'); -- Confiança x Lagarto

INSERT INTO fatopartida (DataID, EstadioID, JuizID, Publico, Renda, RESULTADO)
VALUES (13, 2, 1, 637, 16130, '0 X 1'); -- Dorense x Sergipe

INSERT INTO fatopartida (DataID, EstadioID, JuizID, Publico, Renda, RESULTADO)
VALUES (14, 5, 1, 306, 2055, '3 X 0'); -- América x Guarany

INSERT INTO fatopartida (DataID, EstadioID, JuizID, Publico, Renda, RESULTADO)
VALUES (13, 4, 1, 1735, 28290, '4 X 0'); -- Itabaiana x Falcon

INSERT INTO fatopartida (DataID, EstadioID, JuizID, Publico, Renda, RESULTADO)
VALUES (15, 3, 1, 12, 120, '3 X 2'); -- Barra x Carmópolis

-- Rodada 6
INSERT INTO fatopartida (DataID, EstadioID, JuizID, Publico, Renda, RESULTADO)
VALUES (17, 1, 1, 8579, 245557, '2 X 1'); -- Confiança x Sergipe

INSERT INTO fatopartida (DataID, EstadioID, JuizID, Publico, Renda, RESULTADO)
VALUES (16, 3, 1, 1819, 34555, '0 X 1'); -- Lagarto x Itabaiana

INSERT INTO fatopartida (DataID, EstadioID, JuizID, Publico, Renda, RESULTADO)
VALUES (16, 2, 1, 283, 1860, '1 X 2'); -- Dorense x Guarany

INSERT INTO fatopartida (DataID, EstadioID, JuizID, Publico, Renda, RESULTADO)
VALUES (18, 1, 1, 131, 150, '3 X 2'); -- Falcon x Carmópolis

INSERT INTO fatopartida (DataID, EstadioID, JuizID, Publico, Renda, RESULTADO)
VALUES (17, 3, 1, 15, 210, '1 X 0'); -- Barra x América

-- Rodada 7
INSERT INTO fatopartida (DataID, EstadioID, JuizID, Publico, Renda, RESULTADO)
VALUES (19, 1, 1, 1585, 18464, '8 X 1'); -- Confiança x Barra

INSERT INTO fatopartida (DataID, EstadioID, JuizID, Publico, Renda, RESULTADO)
VALUES (19, 2, 1, 15, 330, '1 X 1'); -- Carmópolis x América

INSERT INTO fatopartida (DataID, EstadioID, JuizID, Publico, Renda, RESULTADO)
VALUES (19, 6, 1, 533, 8400, '2 X 0'); -- Guarany x Falcon

INSERT INTO fatopartida (DataID, EstadioID, JuizID, Publico, Renda, RESULTADO)
VALUES (20, 4, 1, 2107, 32965, '4 X 1'); -- Itabaiana x Dorense

INSERT INTO fatopartida (DataID, EstadioID, JuizID, Publico, Renda, RESULTADO)
VALUES (20, 1, 1, 1251, 20358, '0 X 4'); -- Sergipe x Lagarto

-- Rodada 8
INSERT INTO fatopartida (DataID, EstadioID, JuizID, Publico, Renda, RESULTADO)
VALUES (22, 1, 1, 3650, 77393, '0 X 0'); -- Confiança x Itabaiana

INSERT INTO fatopartida (DataID, EstadioID, JuizID, Publico, Renda, RESULTADO)
VALUES (21, 1, 1, 713, 10537, '4 X 0'); -- Sergipe x Guarany

INSERT INTO fatopartida (DataID, EstadioID, JuizID, Publico, Renda, RESULTADO)
VALUES (21, 2, 1, 57, 1520, '1 X 1'); -- Carmópolis x Lagarto

INSERT INTO fatopartida (DataID, EstadioID, JuizID, Publico, Renda, RESULTADO)
VALUES (21, 3, 1, 29, 550, '0 X 2'); -- Barra x Dorense

INSERT INTO fatopartida (DataID, EstadioID, JuizID, Publico, Renda, RESULTADO)
VALUES (23, 1, 1, 137, 300, '0 X 1'); -- Falcon x América

-- Rodada 9
INSERT INTO fatopartida (DataID, EstadioID, JuizID, Publico, Renda, RESULTADO)
VALUES (24, 4, 1, 1020, 18000, '4 X 2'); -- Itabaiana x Barra

INSERT INTO fatopartida (DataID, EstadioID, JuizID, Publico, Renda, RESULTADO)
VALUES (24, 2, 1, 683, 8570, '2 X 1'); -- Dorense x Confiança

INSERT INTO fatopartida (DataID, EstadioID, JuizID, Publico, Renda, RESULTADO)
VALUES (24, 3, 1, 1145, 17030, '3 X 0'); -- Lagarto x Falcon

INSERT INTO fatopartida (DataID, EstadioID, JuizID, Publico, Renda, RESULTADO)
VALUES (24, 1, 1, 563, 8823, '0 X 1'); -- Sergipe x América

INSERT INTO fatopartida (DataID, EstadioID, JuizID, Publico, Renda, RESULTADO)
VALUES (24, 6, 1, 596, 9570, '2 X 1'); -- Guarany x Carmópolis



-- Rodada 1
-- Sergipe x Barra (1x1)
INSERT INTO fatogol(PartidaID, JogadorID, TimeID, Minuto, Tempo)
VALUES (1, 1, 1, 86, 2), (1, 6, 2, 30, 1);

-- Dorense x Falcon (0x2)
INSERT INTO fatogol(PartidaID, JogadorID, TimeID, Minuto, Tempo)
VALUES (2, 16, 4, 54, 2), (2, 15, 4, 48, 1);

-- Lagarto x América (2x1)
INSERT INTO fatogol(PartidaID, JogadorID, TimeID, Minuto, Tempo)
VALUES (3, 22, 5, 49, 1), (3, 27, 6, 76, 2), (3, 23, 6, 62, 2);

-- Confiança x Guarany (5x1)
INSERT INTO fatogol(PartidaID, JogadorID, TimeID, Minuto, Tempo)
VALUES (4, 32, 7, 14, 1), (4, 33, 7, 22, 1), (4, 34, 7, 63, 1),
       (4, 35, 7, 85, 2), (4, 36, 7, 91, 2), (4, 42, 8, 1, 1);

-- Itabaiana x Carmópolis (2x1)
INSERT INTO fatogol(PartidaID, JogadorID, TimeID, Minuto, Tempo)
VALUES (5, 49, 9, 5, 1), (5, 50, 9, 30, 1), (5, 57, 10, 44, 1);

-- Rodada 2
-- América x Dorense (1x0)
INSERT INTO fatogol(PartidaID, JogadorID, TimeID, Minuto, Tempo)
VALUES (6, 27, 6, 69, 2);

-- Barra x Lagarto (0x5)
INSERT INTO fatogol(PartidaID, JogadorID, TimeID, Minuto, Tempo)
VALUES (7, 11, 2, 15, 1), (7, 23, 5, 27, 1), (7, 24, 5, 38, 1),
       (7, 22, 5, 40, 1), (7, 25, 5, 86, 2);

-- Carmópolis x Sergipe (1x2)
INSERT INTO fatogol(PartidaID, JogadorID, TimeID, Minuto, Tempo)
VALUES (8, 58, 10, 45, 1), (8, 3, 1, 34, 1), (8, 3, 1, 44, 1);

-- Guarany x Itabaiana (1x1)
INSERT INTO fatogol(PartidaID, JogadorID, TimeID, Minuto, Tempo)
VALUES (9, 51, 8, 6, 1), (9, 43, 9, 24, 1);

-- Falcon x Confiança (1x3)
INSERT INTO fatogol(PartidaID, JogadorID, TimeID, Minuto, Tempo)
VALUES (10, 32, 7, 14, 1), (10, 17, 4, 32, 1), (10, 37, 7, 24, 1),
       (10, 38, 7, 60, 2);

-- Rodada 3
-- América x Confiança (1x1)
INSERT INTO fatogol(PartidaID, JogadorID, TimeID, Minuto, Tempo)
VALUES (11, 29, 6, 80, 2), -- Aldair Birimbau aos 80' do 2º tempo
       (11, 39, 7, 86, 2); -- Valdir aos 86' do 2º tempo

-- Falcon x Barra (4x0)
INSERT INTO fatogol(PartidaID, JogadorID, TimeID, Minuto, Tempo)
VALUES (12, 18, 4, 2, 1),  -- Everson aos 2' do 1º tempo
       (12, 19, 4, 49, 2), -- Palominha aos 49' do 2º tempo
       (12, 19, 4, 61, 2), -- Izaldo Braz aos 61' do 2º tempo (jogador não está na lista)
       (12, 20, 4, 87, 2); -- Dandan aos 87' do 2º tempo

-- Itabaiana x Sergipe (1x1)
INSERT INTO fatogol(PartidaID, JogadorID, TimeID, Minuto, Tempo)
VALUES (15, NULL, 9, 29, 1), -- Wendel Júnior aos 29' do 1º tempo (jogador não está na lista ou é Wendel ID 51)
       (15, 4, 1, 57, 2);    -- Reny Max aos 57' do 2º tempo

-- Lagarto x Guarany (4x0)
INSERT INTO fatogol(PartidaID, JogadorID, TimeID, Minuto, Tempo)
VALUES (14, 24, 5, 37, 1),   -- Rhuan aos 37' do 1º tempo
       (14, 22, 5, 55, 2),   -- Ronan aos 55' do 2º tempo
       (14, 43, 8, 74, 2),   -- João Marcos aos 74' do 2º tempo (gol contra - símbolo vermelho)
       (14, 25, 5, 79, 2);   -- Nael aos 79' do 2º tempo

-- Rodada 4
-- Sergipe x Falcon (0x1)
INSERT INTO fatogol(PartidaID, JogadorID, TimeID, Minuto, Tempo)
VALUES (16, 21, 4, 31, 1); -- Lucas Lopes aos 31' do 1º tempo

-- América de Propriá x Itabaiana (1x1)
INSERT INTO fatogol(PartidaID, JogadorID, TimeID, Minuto, Tempo)
VALUES (17, 29, 6, 12, 1), -- Aldair aos 12' do 1º tempo (jogador não está na lista)
       (17, 52, 9, 56, 2);  -- João Vitor aos 56' do 2º tempo

-- Lagarto x Dorense (1x1)
INSERT INTO fatogol(PartidaID, JogadorID, TimeID, Minuto, Tempo)
VALUES (18, 26, 5, 70, 2), -- Bruno Gonçalves aos 70' do 2º tempo
       (18, 12, 3, 64, 2); -- Jeferson aos 64' do 2º tempo

-- Carmópolis x Confiança (1x2)
INSERT INTO fatogol(PartidaID, JogadorID, TimeID, Minuto, Tempo)
VALUES (19, 59, 10, 24, 1), -- Nixon aos 24' do 1º tempo
       (19, 40, 7, 74, 2),  -- Neto Oliveira aos 74' do 2º tempo
       (19, 37, 7, 79, 2);  -- Fábio Silva aos 79' do 2º tempo

-- Guarany x Barra (1x0)
INSERT INTO fatogol(PartidaID, JogadorID, TimeID, Minuto, Tempo)
VALUES (20, 44, 8, 64, 2); -- Palhinha aos 64' do 2º tempo

-- Rodada 5
-- Itabaiana x Falcon (4x0)
INSERT INTO fatogol(PartidaID, JogadorID, TimeID, Minuto, Tempo)
VALUES (21, 52, 9, 17, 1),    -- João Vitor aos 17' do 1º tempo
       (21, 53, 9, 54, 2),  -- Gabriel Miranda aos 54' do 2º tempo (não está na lista)
       (21, 54, 9, 64, 2),    -- Neném aos 64' do 2º tempo
       (21, 51, 9, 71, 2);  -- Wendel Júnior aos 71' do 2º tempo (pode ser o Wendel ID: 51)

-- Dorense x Sergipe (0x1)
INSERT INTO fatogol(PartidaID, JogadorID, TimeID, Minuto, Tempo)
VALUES (22, 5, 1, 93, 2);     -- Adriano Júnior aos 90'+3 do 2º tempo

-- Confiança x Lagarto (4x0)
INSERT INTO fatogol(PartidaID, JogadorID, TimeID, Minuto, Tempo)
VALUES (23, 32, 7, 7, 1),     -- André Lima aos 7' do 1º tempo
       (23, 33, 7, 44, 1),    -- Rodriguinho aos 44' do 1º tempo
       (23, 34, 7, 69, 2),    -- Breyner Camilo aos 69' do 2º tempo
       (23, 40, 7, 91, 2);    -- Neto Oliveira aos 90'+1 do 2º tempo

-- América de Propriá x Guarany (3x0)
INSERT INTO fatogol(PartidaID, JogadorID, TimeID, Minuto, Tempo)
VALUES (24, 28, 6, 55, 2),    -- Michel Chuva aos 55' do 2º tempo (assumindo que Chuva = JogadorID 31)
       (24, 29, 6, 64, 2),    -- Aldair Birimbau aos 64' do 2º tempo (cartão amarelo)
       (24, 29, 6, 68, 2);    -- Aldair Birimbau aos 68' do 2º tempo

-- Barra x Carmópolis (3x2)
INSERT INTO fatogol(PartidaID, JogadorID, TimeID, Minuto, Tempo)
VALUES (25, 7, 2, 62, 2),  -- Rony aos 62' do 2º tempo (não está na lista)
       (25, 8, 2, 78, 2),     -- Helber aos 78' do 2º tempo
       (25, 7, 2, 82, 2),  -- Rony aos 82' do 2º tempo (não está na lista)
       (25, 60, 10, 46, 2),   -- Felipe aos 46' do 2º tempo
       (25, 61, 10, 70, 2);   -- Felipe aos 70' do 2º tempo
-- Rodada 6
-- Falcon x Carmópolis (3x2)
INSERT INTO fatogol(PartidaID, JogadorID, TimeID, Minuto, Tempo)
VALUES (26, 16, 4, 10, 1),   -- Arthur Caculé aos 10' do 1º tempo
       (26, 21, 4, 87, 2),   -- Lucas Lopes aos 87' do 2º tempo
       (26, 21, 4, 92, 2),   -- Lucas Lopes aos 90'+2 do 2º tempo
       (26, 62, 10, 51, 2),  -- Thierry aos 51' do 2º tempo
       (26, 10, 10, 63, 2); -- Sorriso aos 63' do 2º tempo (não está na lista)

-- Barra x América de Propriá (1x0)
INSERT INTO fatogol(PartidaID, JogadorID, TimeID, Minuto, Tempo)
VALUES (27, 9, 2, 8, 1);     -- Andrey aos 8' do 1º tempo

-- Confiança x Sergipe (2x1)
INSERT INTO fatogol(PartidaID, JogadorID, TimeID, Minuto, Tempo)
VALUES (28, 4, 1, 26, 1),    -- Reny Max aos 26' do 1º tempo
       (28, 35, 7, 74, 2),   -- Ronald Camarão aos 74' do 2º tempo
       (28, 40, 7, 81, 2);   -- Neto Oliveira aos 81' do 2º tempo

-- Dorense x Guarany (1x2)
INSERT INTO fatogol(PartidaID, JogadorID, TimeID, Minuto, Tempo)
VALUES (29, 45, 3, 92, 2),   -- Jeferson aos 90'+2 do 2º tempo
       (29, 13, 3, 70, 2), -- Lucas Silva aos 70' do 2º tempo (não está na lista - pode ser o Lucas ID: 13)
       (29, 46, 3, 3, 1);    -- Jeferson aos 3' do 1º tempo

-- Lagarto x Itabaiana (0x1)
INSERT INTO fatogol(PartidaID, JogadorID, TimeID, Minuto, Tempo)
VALUES (30, 52, 9, 56, 2);   -- João Vitor aos 56' do 2º tempo

-- Rodada 7
-- Sergipe x Lagarto (0x4)
INSERT INTO fatogol(PartidaID, JogadorID, TimeID, Minuto, Tempo)
VALUES (31, 25, 5, 85, 2), (31, 25, 5, 48, 2), (31, 25, 5, 21, 1),
       (31, 24, 5, 16, 1);

-- Itabaiana-SE x Dorense (4x1)
INSERT INTO fatogol(PartidaID, JogadorID, TimeID, Minuto, Tempo)
VALUES (32, 51, 9, 94, 2), (32, 56, 9, 88, 2), (32, 14, 3, 63, 2),
       (32, 55, 9, 54, 2), (32, 55, 9, 46, 2);

-- Guarany-SE x Falcon-SE (2x0)
INSERT INTO fatogol(PartidaID, JogadorID, TimeID, Minuto, Tempo)
VALUES (33, 48, 8, 94, 2), (33, 47, 8, 72, 2);

-- Carmópolis x América de Propriá (1x1)
INSERT INTO fatogol(PartidaID, JogadorID, TimeID, Minuto, Tempo)
VALUES (34, 59, 10, 90, 2), (34, 31, 6, 44, 1);

-- Confiança x Barra-SE (8x1)
INSERT INTO fatogol(PartidaID, JogadorID, TimeID, Minuto, Tempo)
VALUES (35, 40, 7, 89, 2), (35, 35, 7, 86, 2), (35, 40, 7, 73, 2),
       (35, 35, 7, 65, 2), (35, 37, 7, 61, 2), (35, 34, 7, 57, 2),
       (35, 33, 7, 43, 1), (35, 41, 7, 25, 1), (35, 10, 2, 18, 1);
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