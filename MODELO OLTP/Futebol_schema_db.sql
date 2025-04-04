CREATE DATABASE DB_FUTEBOL_INFO;

USE DB_FUTEBOL_INFO;

CREATE TABLE TIMES(
    ID INT NOT NULL IDENTITY (1,1) PRIMARY KEY ,
    NOME VARCHAR(45) NOT NULL,
    TITULOS INT NOT NULL,
    FUNDACAO DATE NOT NULL,
    SEDE VARCHAR(30) NOT NULL,
    PRIMARY KEY (id)
)

CREATE TABLE CLASSIFICACAO(
    PONTOS INT NOT NULL DEFAULT 0,
    JOGOS INT NOT NULL DEFAULT 0,
    VITORIAS INT NOT NULL DEFAULT 0,
    DERROTAS INT NOT NULL DEFAULT 0,
    GOLS_PRO INT NOT NULL DEFAULT 0,
    GOLS_CONTRA INT NOT NULL DEFAULT 0,
    SALDO AS (GOLS_PRO - GOLS_CONTRA) PERSISTED,
    ID_TIMES INT NOT NULL,
    FOREIGN KEY (ID_TIMES) REFERENCES TIMES(ID),
    PRIMARY KEY(ID_TIMES)
)

