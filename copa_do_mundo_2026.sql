CREATE DATABASE copa_do_mundo_2026;
USE copa_do_mundo_2026;

-- TABELA PAIS
CREATE TABLE Pais (
    id_pais INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(50) NOT NULL,
    continente VARCHAR(30) NOT NULL
);

-- TABELA GRUPO
CREATE TABLE Grupo (
    id_grupo INT AUTO_INCREMENT PRIMARY KEY,
    nome_grupo CHAR(1) NOT NULL
);

-- TABELA TIME
CREATE TABLE Time (
    id_time INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    id_pais INT NOT NULL,
    id_grupo INT NOT NULL,

    FOREIGN KEY (id_pais) REFERENCES Pais(id_pais),
    FOREIGN KEY (id_grupo) REFERENCES Grupo(id_grupo)
);

-- TABELA JOGADOR
CREATE TABLE Jogador (
    id_jogador INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    posicao VARCHAR(30) NOT NULL,
    numero_camisa INT NOT NULL,
    idade INT NOT NULL,
    id_time INT NOT NULL,

    FOREIGN KEY (id_time) REFERENCES Time(id_time)
);

-- TABELA JOGO
CREATE TABLE Jogo (
    id_jogo INT AUTO_INCREMENT PRIMARY KEY,
    data_jogo DATE NOT NULL,
    horario TIME NOT NULL,
    estadio VARCHAR(100) NOT NULL,
    fase VARCHAR(50) NOT NULL
);

-- TABELA RESULTADO
CREATE TABLE Resultado (
    id_resultado INT AUTO_INCREMENT PRIMARY KEY,
    id_jogo INT NOT NULL,
    id_time_casa INT NOT NULL,
    id_time_visitante INT NOT NULL,
    gols_casa INT DEFAULT 0,
    gols_visitante INT DEFAULT 0,

    FOREIGN KEY (id_jogo) REFERENCES Jogo(id_jogo),
    FOREIGN KEY (id_time_casa) REFERENCES Time(id_time),
    FOREIGN KEY (id_time_visitante) REFERENCES Time(id_time)
);

-- TABELA ESCALACAO
CREATE TABLE Escalacao (
    id_escalacao INT AUTO_INCREMENT PRIMARY KEY,
    id_jogo INT NOT NULL,
    id_jogador INT NOT NULL,
    titular TINYINT(1) NOT NULL,

    FOREIGN KEY (id_jogo) REFERENCES Jogo(id_jogo),
    FOREIGN KEY (id_jogador) REFERENCES Jogador(id_jogador)
);

-- DADOS DE TESTE

INSERT INTO Pais (nome, continente) VALUES
('Brasil', 'América do Sul'),
('Argentina', 'América do Sul'),
('França', 'Europa');

INSERT INTO Grupo (nome_grupo) VALUES
('A'),
('B'),
('C');

INSERT INTO Time (nome, id_pais, id_grupo) VALUES
('Seleção Brasileira', 1, 3),
('Seleção Argentina', 2, 1),
('Seleção Francesa', 3, 2);

INSERT INTO Jogador (nome, posicao, numero_camisa, idade, id_time) VALUES
('Vinicius Junior', 'Atacante', 7, 25, 1),
('Rodrygo', 'Atacante', 10, 25, 1),
('Lionel Messi', 'Atacante', 10, 39, 2),
('Kylian Mbappe', 'Atacante', 10, 27, 3);

INSERT INTO Jogo (data_jogo, horario, estadio, fase) VALUES
('2026-06-24', '18:00:00', 'MetLife Stadium', 'Fase de Grupos');

INSERT INTO Resultado
(id_jogo, id_time_casa, id_time_visitante, gols_casa, gols_visitante)
VALUES
(1, 1, 2, 3, 1);

INSERT INTO Escalacao
(id_jogo, id_jogador, titular)
VALUES
(1, 1, 1),
(1, 2, 1),
(1, 3, 1);

-- CONSULTAS DE TESTE

SELECT * FROM Pais;
SELECT * FROM Grupo;
SELECT * FROM Time;
SELECT * FROM Jogador;
SELECT * FROM Jogo;
SELECT * FROM Resultado;
SELECT * FROM Escalacao;

SELECT j.nome AS Jogador, t.nome AS Time
FROM Jogador j
INNER JOIN Time t ON j.id_time = t.id_time;

SELECT
tc.nome AS Time_Casa,
tv.nome AS Time_Visitante,
r.gols_casa,
r.gols_visitante
FROM Resultado r
INNER JOIN Time tc ON r.id_time_casa = tc.id_time
INNER JOIN Time tv ON r.id_time_visitante = tv.id_time;
