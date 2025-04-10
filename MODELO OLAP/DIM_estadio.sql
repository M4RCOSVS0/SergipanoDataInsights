USE futebol_OLAP_db;

-- Extract unique stadiums
INSERT INTO DimEstadio (Nome, Capacidade, Cidade) VALUES
('Arena Batistão', 15575, 'Aracaju'),--1
('Aristron Azevedo', 3000, 'N.Sra das Dores'),--2
('Paulo Barreto', 8000, 'Lagarto'),--3
('Etelvino Mendonça', 10000, 'Itabaiana'),--4
('Durval Feitosa', 2000, 'Propriá'),--5
('Caio Feitosa', 3000, 'Porto da Folha');--6
