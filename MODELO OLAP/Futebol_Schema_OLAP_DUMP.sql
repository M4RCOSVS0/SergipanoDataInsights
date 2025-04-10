USE futebol_OLAP_db;

-- Extract unique stadiums
INSERT INTO DimEstadio (Nome, Capacidade, Cidade, Latitude, Longitude) VALUES
('Arena Batistão', 15575, 'Aracaju', -10.9271, -37.0562),--1
('Aristron Azevedo', 3000, 'N.Sra das Dores', -10.4970, -37.1962),--2
('Paulo Barreto', 8000, 'Lagarto', -10.9138, -37.6689),--3
('Etelvino Mendonça', 10000, 'Itabaiana', -10.6826, -37.4273),--4
('Durval Feitosa', 2000, 'Propriá', -10.2136, -36.8440),--5
('Caio Feitosa', 3000, 'Porto da Folha', -9.9165, -37.4142);--6

-- Extract unique clubs
INSERT INTO DimClube (Nome, Titulos, Fundacao, Sede, Participacoes,Escudo) VALUES
('Sergipe', 37, '19091017', 'Aracaju', 102,'https://ssl.gstatic.com/onebox/media/sports/logos/QqnKq-neVPpgo5vgVayISQ_96x96.png'),
('Barra', 0, '20140321', 'Barra dos Coqueiros', 1,'https://upload.wikimedia.org/wikipedia/pt/5/5b/Escudo_AD_Barra.png'),
('Dorense', 0, '19480530', 'Nossa Senhora das Dores', 16,'https://tmssl.akamaized.net//images/wappen/head/56342.png?lm=1614858355'),
('Falcon', 0, '20201123', 'Aracaju', 4,'https://ssl.gstatic.com/onebox/media/sports/logos/aaGlw4MMqxBdZ5QREkdFag_96x96.png'),
('Lagarto', 0, '20090420', 'Lagarto', 14,'https://ssl.gstatic.com/onebox/media/sports/logos/CYZZaHrGPlQarji9OMimDg_96x96.png'),
('América', 2, '19420808', 'Propriá', 19,'https://w7.pngwing.com/pngs/481/951/png-transparent-america-futebol-clube-de-propria-se-hd-logo-thumbnail.png'),
('Confiança', 23, '19360501', 'Aracaju', 74,'https://ssl.gstatic.com/onebox/media/sports/logos/LDxXug_0TbPTd0iUPHaJrg_96x96.png'),
('Guarany', 0, '19400101', 'Porto da Folha', 18,'https://www.zerozero.pt/img/logos/equipas/3279_imgbank.png'),
('Itabaiana', 11, '19380710', 'Itabaiana', 72,'https://ssl.gstatic.com/onebox/media/sports/logos/3Un7pF7XhEA-opN94PlJlQ_96x96.png'),
('Carmópolis', 0, '20220612', 'Carmópolis', 2,'https://upload.wikimedia.org/wikipedia/pt/7/71/EscudoCarmopolis.png');

USE futebol_OLAP_db;
-- Sergipe (TimeID = 1)
INSERT INTO DimJogador (Nome, Posicao, Nascimento, TimeID) VALUES ('Lucas Straub', NULL, NULL, 1); -- JogadorID: 1
INSERT INTO DimJogador (Nome, Posicao, Nascimento, TimeID) VALUES ('Bambam', NULL, NULL, 1); -- JogadorID: 2
INSERT INTO DimJogador (Nome, Posicao, Nascimento, TimeID) VALUES ('Léo Fernandes', NULL, NULL, 1); -- JogadorID: 3
INSERT INTO DimJogador (Nome, Posicao, Nascimento, TimeID) VALUES ('Reny Max', NULL, NULL, 1); -- JogadorID: 4
INSERT INTO DimJogador (Nome, Posicao, Nascimento, TimeID) VALUES ('Adriano Júnior', NULL, NULL, 1); -- JogadorID: 5

-- Barra (TimeID = 2)
INSERT INTO DimJogador (Nome, Posicao, Nascimento, TimeID) VALUES ('Thauã', NULL, NULL, 2); -- JogadorID: 6
INSERT INTO DimJogador (Nome, Posicao, Nascimento, TimeID) VALUES ('Roni', NULL, NULL, 2); -- JogadorID: 7
INSERT INTO DimJogador (Nome, Posicao, Nascimento, TimeID) VALUES ('Helber', NULL, NULL, 2); -- JogadorID: 8
INSERT INTO DimJogador (Nome, Posicao, Nascimento, TimeID) VALUES ('Andrey', NULL, NULL, 2); -- JogadorID: 9
INSERT INTO DimJogador (Nome, Posicao, Nascimento, TimeID) VALUES ('Caio Miranda', NULL, NULL, 2); -- JogadorID: 10
INSERT INTO DimJogador (Nome, Posicao, Nascimento, TimeID) VALUES ('Índio', NULL, NULL, 2); -- JogadorID: 11 -- Marcou contra

-- Dorense (TimeID = 3)
INSERT INTO DimJogador (Nome, Posicao, Nascimento, TimeID) VALUES ('Jeferson', NULL, NULL, 3); -- JogadorID: 12
INSERT INTO DimJogador (Nome, Posicao, Nascimento, TimeID) VALUES ('Lucas', NULL, NULL, 3); -- JogadorID: 13
INSERT INTO DimJogador (Nome, Posicao, Nascimento, TimeID) VALUES ('Vaninho', NULL, NULL, 3); -- JogadorID: 14

-- Falcon (TimeID = 4)
INSERT INTO DimJogador (Nome, Posicao, Nascimento, TimeID) VALUES ('Vitor Alagoano', NULL, NULL, 4); -- JogadorID: 15
INSERT INTO DimJogador (Nome, Posicao, Nascimento, TimeID) VALUES ('Arthur Caculé', NULL, NULL, 4); -- JogadorID: 16
INSERT INTO DimJogador (Nome, Posicao, Nascimento, TimeID) VALUES ('Dandan', NULL, NULL, 4); -- JogadorID: 17
INSERT INTO DimJogador (Nome, Posicao, Nascimento, TimeID) VALUES ('Everson', NULL, NULL, 4); -- JogadorID: 18
INSERT INTO DimJogador (Nome, Posicao, Nascimento, TimeID) VALUES ('Palominha', NULL, NULL, 4); -- JogadorID: 19
INSERT INTO DimJogador (Nome, Posicao, Nascimento, TimeID) VALUES ('David', NULL, NULL, 4); -- JogadorID: 20
INSERT INTO DimJogador (Nome, Posicao, Nascimento, TimeID) VALUES ('Lucas Lopes', NULL, NULL, 4); -- JogadorID: 21

-- Lagarto (TimeID = 5)
INSERT INTO DimJogador (Nome, Posicao, Nascimento, TimeID) VALUES ('Ronan', NULL, NULL, 5); -- JogadorID: 22
INSERT INTO DimJogador (Nome, Posicao, Nascimento, TimeID) VALUES ('Miller', NULL, NULL, 5); -- JogadorID: 23
INSERT INTO DimJogador (Nome, Posicao, Nascimento, TimeID) VALUES ('Rhuan', NULL, NULL, 5); -- JogadorID: 24
INSERT INTO DimJogador (Nome, Posicao, Nascimento, TimeID) VALUES ('Nael', NULL, NULL, 5); -- JogadorID: 25
INSERT INTO DimJogador (Nome, Posicao, Nascimento, TimeID) VALUES ('Bruno Gonçalves', NULL, NULL, 5); -- JogadorID: 26

-- América de Propriá (TimeID = 6)
INSERT INTO DimJogador (Nome, Posicao, Nascimento, TimeID) VALUES ('Elimar', NULL, NULL, 6); -- JogadorID: 27
INSERT INTO DimJogador (Nome, Posicao, Nascimento, TimeID) VALUES ('Jonathan', NULL, NULL, 6); -- JogadorID: 28
INSERT INTO DimJogador (Nome, Posicao, Nascimento, TimeID) VALUES ('Birimbau', NULL, NULL, 6); -- JogadorID: 29
INSERT INTO DimJogador (Nome, Posicao, Nascimento, TimeID) VALUES ('Berimbal', NULL, NULL, 6); -- JogadorID: 30
INSERT INTO DimJogador (Nome, Posicao, Nascimento, TimeID) VALUES ('Chuva', NULL, NULL, 6); -- JogadorID: 31

-- Confiança (TimeID = 7)
INSERT INTO DimJogador (Nome, Posicao, Nascimento, TimeID) VALUES ('André Lima', NULL, NULL, 7); -- JogadorID: 32
INSERT INTO DimJogador (Nome, Posicao, Nascimento, TimeID) VALUES ('Rodriguinho', NULL, NULL, 7); -- JogadorID: 33
INSERT INTO DimJogador (Nome, Posicao, Nascimento, TimeID) VALUES ('Breyner Camilo', NULL, NULL, 7); -- JogadorID: 34
INSERT INTO DimJogador (Nome, Posicao, Nascimento, TimeID) VALUES ('Ronald Camarão', NULL, NULL, 7); -- JogadorID: 35
INSERT INTO DimJogador (Nome, Posicao, Nascimento, TimeID) VALUES ('Luiz Otávio', NULL, NULL, 7); -- JogadorID: 36
INSERT INTO DimJogador (Nome, Posicao, Nascimento, TimeID) VALUES ('Fábio', NULL, NULL, 7); -- JogadorID: 37
INSERT INTO DimJogador (Nome, Posicao, Nascimento, TimeID) VALUES ('Thiago Santos', NULL, NULL, 7); -- JogadorID: 38
INSERT INTO DimJogador (Nome, Posicao, Nascimento, TimeID) VALUES ('Valdir Júnior', NULL, NULL, 7); -- JogadorID: 39
INSERT INTO DimJogador (Nome, Posicao, Nascimento, TimeID) VALUES ('Neto', NULL, NULL, 7); -- JogadorID: 40
INSERT INTO DimJogador (Nome, Posicao, Nascimento, TimeID) VALUES ('Adryan', NULL, NULL, 7); -- JogadorID: 41

-- Guarany (TimeID = 8)
INSERT INTO DimJogador (Nome, Posicao, Nascimento, TimeID) VALUES ('Ryan', NULL, NULL, 8); -- JogadorID: 42
INSERT INTO DimJogador (Nome, Posicao, Nascimento, TimeID) VALUES ('João Marcos', NULL, NULL, 8); -- JogadorID: 43
INSERT INTO DimJogador (Nome, Posicao, Nascimento, TimeID) VALUES ('Palhinha', NULL, NULL, 8); -- JogadorID: 44
INSERT INTO DimJogador (Nome, Posicao, Nascimento, TimeID) VALUES ('Jefinho', NULL, NULL, 8); -- JogadorID: 45
INSERT INTO DimJogador (Nome, Posicao, Nascimento, TimeID) VALUES ('Pedrinho', NULL, NULL, 8); -- JogadorID: 46
INSERT INTO DimJogador (Nome, Posicao, Nascimento, TimeID) VALUES ('Rayamersson', NULL, NULL, 8); -- JogadorID: 47
INSERT INTO DimJogador (Nome, Posicao, Nascimento, TimeID) VALUES ('PH', NULL, NULL, 8); -- JogadorID: 48

-- Itabaiana (TimeID = 9)
INSERT INTO DimJogador (Nome, Posicao, Nascimento, TimeID) VALUES ('Matheus', NULL, NULL, 9); -- JogadorID: 49
INSERT INTO DimJogador (Nome, Posicao, Nascimento, TimeID) VALUES ('Romarinho', NULL, NULL, 9); -- JogadorID: 50
INSERT INTO DimJogador (Nome, Posicao, Nascimento, TimeID) VALUES ('Wendel', NULL, NULL, 9); -- JogadorID: 51
INSERT INTO DimJogador (Nome, Posicao, Nascimento, TimeID) VALUES ('João Vitor', NULL, NULL, 9); -- JogadorID: 52
INSERT INTO DimJogador (Nome, Posicao, Nascimento, TimeID) VALUES ('Gabriel Henrique', NULL, NULL, 9); -- JogadorID: 53
INSERT INTO DimJogador (Nome, Posicao, Nascimento, TimeID) VALUES ('Neném', NULL, NULL, 9); -- JogadorID: 54
INSERT INTO DimJogador (Nome, Posicao, Nascimento, TimeID) VALUES ('Jackson', NULL, NULL, 9); -- JogadorID: 55
INSERT INTO DimJogador (Nome, Posicao, Nascimento, TimeID) VALUES ('Gabriel Santiago', NULL, NULL, 9); -- JogadorID: 56

-- Carmópolis (TimeID = 10)
INSERT INTO DimJogador (Nome, Posicao, Nascimento, TimeID) VALUES ('José Everton', NULL, NULL, 10); -- JogadorID: 57
INSERT INTO DimJogador (Nome, Posicao, Nascimento, TimeID) VALUES ('Dudu', NULL, NULL, 10); -- JogadorID: 58
INSERT INTO DimJogador (Nome, Posicao, Nascimento, TimeID) VALUES ('Nixon', NULL, NULL, 10); -- JogadorID: 59
INSERT INTO DimJogador (Nome, Posicao, Nascimento, TimeID) VALUES ('Vanderley', NULL, NULL, 10); -- JogadorID: 60
INSERT INTO DimJogador (Nome, Posicao, Nascimento, TimeID) VALUES ('Felipe', NULL, NULL, 10); -- JogadorID: 61
INSERT INTO DimJogador (Nome, Posicao, Nascimento, TimeID) VALUES ('Thierry', NULL, NULL, 10); -- JogadorID: 62
INSERT INTO DimJogador (Nome, Posicao, Nascimento, TimeID) VALUES ('Allan Santos', NULL, NULL, 10); -- JogadorID: 63

-- Sergipe (TimeID = 1)
INSERT INTO DimJogador (Nome, Posicao, Nascimento, TimeID) VALUES ('Pedro Henrique', NULL, NULL, 1); -- JogadorID: 64

-- Dorense (TimeID = 3)
INSERT INTO DimJogador (Nome, Posicao, Nascimento, TimeID) VALUES ('Everton Santos', NULL, NULL, 3); -- JogadorID: 65

-- América de Propriá (TimeID = 6)
INSERT INTO DimJogador (Nome, Posicao, Nascimento, TimeID) VALUES ('Renato', NULL, NULL, 6); -- JogadorID: 66

-- Itabaiana (TimeID = 9)
INSERT INTO DimJogador (Nome, Posicao, Nascimento, TimeID) VALUES ('Luis Fernando', NULL, NULL, 9); -- JogadorID: 67
INSERT INTO DimJogador (Nome, Posicao, Nascimento, TimeID) VALUES ('Coppetti ', NULL, NULL, 9); -- JogadorID: 68
INSERT INTO DimJogador (Nome, Posicao, Nascimento, TimeID) VALUES ('Kesley', NULL, NULL, 9); -- JogadorID: 69

-- Dorense (TimeID = 3)
INSERT INTO DimJogador (Nome, Posicao, Nascimento, TimeID) VALUES ('Everton Santos', NULL, NULL, 3); -- JogadorID: 70
INSERT INTO DimJogador (Nome, Posicao, Nascimento, TimeID) VALUES ('Mano', NULL, NULL, 3); -- JogadorID: 71

-- Lagarto (TimeID = 5)
INSERT INTO DimJogador (Nome, Posicao, Nascimento, TimeID) VALUES ('Romulo', NULL, NULL, 5); -- JogadorID: 72
INSERT INTO DimJogador (Nome, Posicao, Nascimento, TimeID) VALUES ('Naylhor', NULL, NULL, 5); -- JogadorID: 73

-- América de Propriá (TimeID = 6)
INSERT INTO DimJogador (Nome, Posicao, Nascimento, TimeID) VALUES ('Henrique', NULL, NULL, 6); -- JogadorID: 74

-- Guarany (TimeID = 8)
INSERT INTO DimJogador (Nome, Posicao, Nascimento, TimeID) VALUES ('Alanderson', NULL, NULL, 8); -- JogadorID: 75

-- Carmópolis (TimeID = 10)
INSERT INTO DimJogador (Nome, Posicao, Nascimento, TimeID) VALUES ('Brendon', NULL, NULL, 10); -- JogadorID: 76

-- Insert dates - converting from DD-MMM format to proper dates (assuming 2024 year)
INSERT INTO DimData (Data, Ano, Mes, Dia, DiaSemana) VALUES
('2025-01-11', 2025, 1, 11, 'SAB'),
('2025-01-13', 2025, 1, 13, 'SEG'),
('2025-01-14', 2025, 1, 14, 'TER'),
('2025-01-15', 2025, 1, 15, 'QUA'),
('2025-01-16', 2025, 1, 16, 'QUI'),
('2025-01-19', 2025, 1, 19, 'DOM'),
('2025-01-20', 2025, 1, 20, 'SEG'),
('2025-01-22', 2025, 1, 22, 'QUA'),
('2025-01-23', 2025, 1, 23, 'QUI'),
('2025-01-25', 2025, 1, 25, 'SAB'),
('2025-01-26', 2025, 1, 26, 'DOM'),
('2025-01-29', 2025, 1, 29, 'QUA'),
('2025-02-01', 2025, 2, 1, 'SAB'),
('2025-02-02', 2025, 2, 2, 'DOM'),
('2025-02-03', 2025, 2, 3, 'SEG'),
('2025-02-08', 2025, 2, 8, 'SAB'),
('2025-02-09', 2025, 2, 9, 'DOM'),
('2025-02-10', 2025, 2, 10, 'SEG'),
('2025-02-15', 2025, 2, 15, 'SAB'),
('2025-02-16', 2025, 2, 16, 'DOM'),
('2025-02-22', 2025, 2, 22, 'SAB'),
('2025-02-23', 2025, 2, 23, 'DOM'),
('2025-02-24', 2025, 2, 24, 'SEG'),
('2025-03-01', 2025, 3, 1, 'SAB');

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
VALUES (6, 11, 45, 3, 4, 2), (7, 11, 55, 3, 5, 0);

-- Falcon x Barra (4x0)
INSERT INTO PontePartidaTime (TIMEID, PARTIDAID, PosseDeBola, Escanteios, ChutesAGol, Impedimentos)
VALUES (4, 12, 59, 5, 4, 1), (2, 12, 41, 7, 2, 3);

-- Dorense x Carmópolis (0x0)
INSERT INTO PontePartidaTime (TIMEID, PARTIDAID, PosseDeBola, Escanteios, ChutesAGol, Impedimentos)
VALUES (3, 13, 55, 3, 3, 1), (10, 13, 45, 5, 1, 5);

-- Lagarto x Guarany (4x0)
INSERT INTO PontePartidaTime (TIMEID, PARTIDAID, PosseDeBola, Escanteios, ChutesAGol, Impedimentos)
VALUES (5, 14, 50, 7, 10, 1), (8, 14, 50, 1, 5, 3);

-- Itabaiana x Sergipe (1x1)
INSERT INTO PontePartidaTime (TIMEID, PARTIDAID, PosseDeBola, Escanteios, ChutesAGol, Impedimentos)
VALUES (9, 15, 52, 2, 4, 3), (1, 15, 48, 7, 3, 0);

-- For rodada 4
-- Carmópolis x Confiança (1x2)
INSERT INTO PontePartidaTime (TIMEID, PARTIDAID, PosseDeBola, Escanteios, ChutesAGol, Impedimentos)
VALUES (10, 16, 42, 2, 2, 4), (7, 16, 58, 5, 7, 3);

-- Guarany x Barra (1x0)
INSERT INTO PontePartidaTime (TIMEID, PARTIDAID, PosseDeBola, Escanteios, ChutesAGol, Impedimentos)
VALUES (8, 17, 55, 1, 3, 1), (2, 17, 55, 1, 1, 0);

-- América x Itabaiana (1x1)
INSERT INTO PontePartidaTime (TIMEID, PARTIDAID, PosseDeBola, Escanteios, ChutesAGol, Impedimentos)
VALUES (6, 18, 45, 6, 5, 0), (9, 18, 55, 7, 5, 1);

-- Sergipe x Falcon (0x1)
INSERT INTO PontePartidaTime (TIMEID, PARTIDAID, PosseDeBola, Escanteios, ChutesAGol, Impedimentos)
VALUES (1, 19, 58, 11, 9, 1), (4, 19, 42, 1, 1, 1);

-- Lagarto x Dorense (1x1)
INSERT INTO PontePartidaTime (TIMEID, PARTIDAID, PosseDeBola, Escanteios, ChutesAGol, Impedimentos)
VALUES (5, 20, 55, 4, 8, 3), (3, 20, 45, 3, 2, 2);

-- For rodada 5
-- Confiança x Lagarto (4x0)
INSERT INTO PontePartidaTime (TIMEID, PARTIDAID, PosseDeBola, Escanteios, ChutesAGol, Impedimentos)
VALUES (7, 21, 46, 6, 7, 3), (5, 21, 54, 7, 4, 3);

-- Dorense x Sergipe (0x1)
INSERT INTO PontePartidaTime (TIMEID, PARTIDAID, PosseDeBola, Escanteios, ChutesAGol, Impedimentos)
VALUES (3, 22, 55, 2, 2, 1), (1, 22, 45, 5, 4, 0);

-- América x Guarany (3x0)
INSERT INTO PontePartidaTime (TIMEID, PARTIDAID, PosseDeBola, Escanteios, ChutesAGol, Impedimentos)
VALUES (6, 23, 60, 3, 7, 1), (8, 23, 40, 6, 3, 4);

-- Itabaiana x Falcon (4x0)
INSERT INTO PontePartidaTime (TIMEID, PARTIDAID, PosseDeBola, Escanteios, ChutesAGol, Impedimentos)
VALUES (9, 24, 41, 2, 6, 0), (4, 24, 59, 1, 3, 0);

-- Barra x Carmópolis (3x2)
INSERT INTO PontePartidaTime (TIMEID, PARTIDAID, PosseDeBola, Escanteios, ChutesAGol, Impedimentos)
VALUES (2, 25, 39, 5, 6, 1), (10, 25, 61, 3, 2, 3);

-- For rodada 6
-- Confiança x Sergipe (2x1)
INSERT INTO PontePartidaTime (TIMEID, PARTIDAID, PosseDeBola, Escanteios, ChutesAGol, Impedimentos)
VALUES (7, 26, 62, 6, 5, 4), (1, 26, 38, 1, 3, 3);

-- Lagarto x Itabaiana (0x1)
INSERT INTO PontePartidaTime (TIMEID, PARTIDAID, PosseDeBola, Escanteios, ChutesAGol, Impedimentos)
VALUES (5, 27, 50, 0, 5, 0), (9, 27, 50, 0, 1, 1);

-- Dorense x Guarany (1x2)
INSERT INTO PontePartidaTime (TIMEID, PARTIDAID, PosseDeBola, Escanteios, ChutesAGol, Impedimentos)
VALUES (3, 28, 55, 2, 5, 0), (8, 28, 45, 2, 2, 1);

-- Falcon x Carmópolis (3x2)
INSERT INTO PontePartidaTime (TIMEID, PARTIDAID, PosseDeBola, Escanteios, ChutesAGol, Impedimentos)
VALUES (4, 29, 57, 8, 7, 1), (10, 29, 43, 2, 5, 1);

-- Barra x América (1x0)
INSERT INTO PontePartidaTime (TIMEID, PARTIDAID, PosseDeBola, Escanteios, ChutesAGol, Impedimentos)
VALUES (2, 30, 55, 5, 9, 1), (6, 30, 45, 2, 3, 3);

-- For rodada 7
-- Confiança x Barra (8x1)
INSERT INTO PontePartidaTime (TIMEID, PARTIDAID, PosseDeBola, Escanteios, ChutesAGol, Impedimentos)
VALUES (7, 31, 60, 4, 12, 1), (2, 31, 40, 1, 2, 0);

-- Carmópolis x América (1x1)
INSERT INTO PontePartidaTime (TIMEID, PARTIDAID, PosseDeBola, Escanteios, ChutesAGol, Impedimentos)
VALUES
(10, 32, 50, 0, 4, 0),(6, 32, 50, 3, 6, 2);

-- Guarany x Falcon (2x0)
INSERT INTO PontePartidaTime (TIMEID, PARTIDAID, PosseDeBola, Escanteios, ChutesAGol, Impedimentos)
VALUES
(8, 33, 55, 3, 5, 0),(4, 33, 45, 1, 2, 0);

-- Itabaiana x Dorense (4x1)
INSERT INTO PontePartidaTime (TIMEID, PARTIDAID, PosseDeBola, Escanteios, ChutesAGol, Impedimentos)
VALUES
(9, 34, 60, 4, 8, 4),(3, 34, 40, 3, 3, 1);

-- Sergipe x Lagarto (0x4)
INSERT INTO PontePartidaTime (TIMEID, PARTIDAID, PosseDeBola, Escanteios, ChutesAGol, Impedimentos)
VALUES
(1, 35, 51, 8, 5, 3),(5, 35, 49, 8, 9, 1);

-- Para rodada 8
-- Confiança x Itabaiana (0x0)
INSERT INTO PontePartidaTime (TIMEID, PARTIDAID, PosseDeBola, Escanteios, ChutesAGol, Impedimentos)
VALUES (7, 36, 59, 7, 4, 1), (9, 36, 41, 0, 2, 0);

-- Sergipe x Guarany (4x0)
INSERT INTO PontePartidaTime (TIMEID, PARTIDAID, PosseDeBola, Escanteios, ChutesAGol, Impedimentos)
VALUES (1, 37, 42, 0, 7, 1), (8, 37, 58, 2, 3, 1);

-- Carmópolis x Lagarto (1x1)
INSERT INTO PontePartidaTime (TIMEID, PARTIDAID, PosseDeBola, Escanteios, ChutesAGol, Impedimentos)
VALUES (10, 38, 41, 0, 3, 4), (5, 38, 59, 6, 7, 3);

-- Barra x Dorense (0x2)
INSERT INTO PontePartidaTime (TIMEID, PARTIDAID, PosseDeBola, Escanteios, ChutesAGol, Impedimentos)
VALUES (2, 39, 48, 2, 4, 2), (3, 39, 52, 3, 7, 1);

-- Falcon x América (0x1)
INSERT INTO PontePartidaTime (TIMEID, PARTIDAID, PosseDeBola, Escanteios, ChutesAGol, Impedimentos)
VALUES (4, 40, 63, 10, 2, 1), (6, 40, 37, 1, 2, 4);

-- For rodada 9
-- Itabaiana x Barra (4x2)
INSERT INTO PontePartidaTime (TIMEID, PARTIDAID, PosseDeBola, Escanteios, ChutesAGol, Impedimentos)
VALUES (9, 41, 60, 2, 8, 1), (2, 41, 40, 2, 3, 0);

-- Dorense x Confiança (2x1)
INSERT INTO PontePartidaTime (TIMEID, PARTIDAID, PosseDeBola, Escanteios, ChutesAGol, Impedimentos)
VALUES (3, 42, 55, 2, 5, 1), (7, 42, 45, 1, 2, 0);

-- Lagarto x Falcon (3x0)
INSERT INTO PontePartidaTime (TIMEID, PARTIDAID, PosseDeBola, Escanteios, ChutesAGol, Impedimentos)
VALUES (5, 43, 50, 5, 6, 1), (4, 43, 50, 2, 3, 2);

-- Sergipe x América (0x1)
INSERT INTO PontePartidaTime (TIMEID, PARTIDAID, PosseDeBola, Escanteios, ChutesAGol, Impedimentos)
VALUES (1, 44, 53, 5, 4, 3), (6, 44, 47, 5, 4, 1);

-- Guarany x Carmópolis (2x1)
INSERT INTO PontePartidaTime (TIMEID, PARTIDAID, PosseDeBola, Escanteios, ChutesAGol, Impedimentos)
VALUES (8, 45, 60, 3, 3, 1), (10, 45, 40, 2, 4, 1);

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
VALUES (15, 51, 9, 29, 1), -- Wendel Júnior aos 29' do 1º tempo (jogador não está na lista ou é Wendel ID 51)
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
VALUES (37, 64, 1, 1, 1),    -- Pedro Silva scored at 1'
       (37, 3, 1, 33, 1),    -- Léo Fernandes (yellow card at 33', not a goal)
       (37, 64, 1, 56, 2),   -- Pedro Silva scored second goal at 56'
       (37,4 , 1, 75, 2);    -- Reny Max (yellow card at 75', not a goal)

-- Carmópolis x Lagarto (1x1)
INSERT INTO fatogol(PartidaID, JogadorID, TimeID, Minuto, Tempo)
VALUES (38, 63, 10, 70, 2),  -- Felipinho (likely Felipe, ID 61) scored at 70'
       (38, 22, 5, 4, 1);    -- Ronan scored at 4'

-- Barra x Dorense (0x2)
INSERT INTO fatogol(PartidaID, JogadorID, TimeID, Minuto, Tempo)
VALUES (39, 12, 3, 27, 1),   -- Jeferson scored at 27'
       (39, 65, 3, 81, 2);   -- Everton scored at 81' (Note: ID 57 is José Everton in DimJogador)

-- Falcon x América (0x1)
INSERT INTO fatogol(PartidaID, JogadorID, TimeID, Minuto, Tempo)
VALUES (40, 66, 6, 4, 1);    -- Renato scored at 4'

-- Rodada 9
-- Itabaiana x Barra (4x2)
INSERT INTO fatogol(PartidaID, JogadorID, TimeID, Minuto, Tempo)
VALUES (41, 55, 9, 11, 1),      -- Jackson Bernardo scored at 11'
       (41, 7, 2, 42, 1),    -- Ronaldo scored at 42'
       (41, 7, 2, 47, 1),    -- Ronaldo scored at 45'+2
       (41, 67, 9, 60, 2),    -- Luis Fernando scored at 60'
       (41, 68, 9, 73, 2),    -- Carlos Coppetti scored at 73'
       (41, 69, 9, 82, 2);    -- Kesley scored at 82'

-- Dorense x Confiança (2x1)
INSERT INTO fatogol(PartidaID, JogadorID, TimeID, Minuto, Tempo)
VALUES (42, 13, 3, 22, 1),    -- Lucas Silva scored at 37'
       (42, 71, 3, 37, 1),    -- Mano (yellow card at 22', not a goal)
       (42, 40, 7, 13, 1);      -- Neto Oliveira scored at 13'

-- Lagarto x Falcon (3x0)
INSERT INTO fatogol(PartidaID, JogadorID, TimeID, Minuto, Tempo)
VALUES (43, 22, 5, 2, 1),       -- Ronan scored at 2'
       (43, 72, 5, 18, 1),    -- Rômulo scored at 18'
       (43, 73, 5, 22, 1);    -- Naylhor scored at 22'

-- Sergipe x América (0x1)
INSERT INTO fatogol(PartidaID, JogadorID, TimeID, Minuto, Tempo)
VALUES (44, 74, 6, 47, 1);    -- Carlos Henrique scored at 45'+2

-- Guarany x Carmópolis (2x1)
INSERT INTO fatogol(PartidaID, JogadorID, TimeID, Minuto, Tempo)
VALUES (45, 43, 8, 35, 1),      -- João Marcos scored at 35'
       (45, 75, 8, 51, 2),    -- Alanderson scored at 51'
       (45, 76, 10, 41, 1);   -- Brendon Lucas scored at 41'

-- RODADA 1
-- Create initial standings for all teams after Round 1
INSERT INTO fatoclassificacao (RodadaID, TimeID, Pontos, Jogos, Vitorias, Empates, Derrotas, GolsPro, GolsContra)
VALUES (1, 1, 1, 1, 0, 1, 0, 1, 1); -- Sergipe (1x1 vs Barra)

INSERT INTO fatoclassificacao (RodadaID, TimeID, Pontos, Jogos, Vitorias, Empates, Derrotas, GolsPro, GolsContra)
VALUES (1, 2, 1, 1, 0, 1, 0, 1, 1); -- Barra (1x1 vs Sergipe)

INSERT INTO fatoclassificacao (RodadaID, TimeID, Pontos, Jogos, Vitorias, Empates, Derrotas, GolsPro, GolsContra)
VALUES (1, 3, 0, 1, 0, 0, 1, 0, 2); -- Dorense (0x2 vs Falcon)

INSERT INTO fatoclassificacao (RodadaID, TimeID, Pontos, Jogos, Vitorias, Empates, Derrotas, GolsPro, GolsContra)
VALUES (1, 4, 3, 1, 1, 0, 0, 2, 0); -- Falcon (2x0 vs Dorense)

INSERT INTO fatoclassificacao (RodadaID, TimeID, Pontos, Jogos, Vitorias, Empates, Derrotas, GolsPro, GolsContra)
VALUES (1, 5, 3, 1, 1, 0, 0, 2, 1); -- Lagarto (2x1 vs América)

INSERT INTO fatoclassificacao (RodadaID, TimeID, Pontos, Jogos, Vitorias, Empates, Derrotas, GolsPro, GolsContra)
VALUES (1, 6, 0, 1, 0, 0, 1, 1, 2); -- América (1x2 vs Lagarto)

INSERT INTO fatoclassificacao (RodadaID, TimeID, Pontos, Jogos, Vitorias, Empates, Derrotas, GolsPro, GolsContra)
VALUES (1, 7, 3, 1, 1, 0, 0, 5, 1); -- Confiança (5x1 vs Guarany)

INSERT INTO fatoclassificacao (RodadaID, TimeID, Pontos, Jogos, Vitorias, Empates, Derrotas, GolsPro, GolsContra)
VALUES (1, 8, 0, 1, 0, 0, 1, 1, 5); -- Guarany (1x5 vs Confiança)

INSERT INTO fatoclassificacao (RodadaID, TimeID, Pontos, Jogos, Vitorias, Empates, Derrotas, GolsPro, GolsContra)
VALUES (1, 9, 3, 1, 1, 0, 0, 2, 1); -- Itabaiana (2x1 vs Carmópolis)

INSERT INTO fatoclassificacao (RodadaID, TimeID, Pontos, Jogos, Vitorias, Empates, Derrotas, GolsPro, GolsContra)
VALUES (1, 10, 0, 1, 0, 0, 1, 1, 2); -- Carmópolis (1x2 vs Itabaiana)