
SET NAMES utf8mb4;

DROP DATABASE IF EXISTS sistema_solidario;

CREATE DATABASE sistema_solidario
CHARACTER SET utf8mb4
COLLATE utf8mb4_unicode_ci;

USE sistema_solidario;

-- TABELA DE DOADORES
CREATE TABLE doador (
    id_doador INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(150) NOT NULL,
    cpf VARCHAR(14) UNIQUE,
    email VARCHAR(100) UNIQUE,
    telefone VARCHAR(20),
    data_cadastro TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- TABELA DE CATEGORIAS
CREATE TABLE categoria (
    id_categoria INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL UNIQUE,
    descricao VARCHAR(255)
);

-- TABELA DE ITENS
CREATE TABLE item (
    id_item INT AUTO_INCREMENT PRIMARY KEY,
    id_categoria INT NOT NULL,
    nome VARCHAR(150) NOT NULL,
    descricao TEXT,
    quantidade_estoque INT NOT NULL DEFAULT 0,
    FOREIGN KEY (id_categoria)
        REFERENCES categoria(id_categoria),
    CHECK (quantidade_estoque >= 0)
);

-- TABELA DE DOACOES
CREATE TABLE doacao (
    id_doacao INT AUTO_INCREMENT PRIMARY KEY,
    id_doador INT NOT NULL,
    descricao TEXT NOT NULL,
    quantidade INT NOT NULL,
    data_doacao DATE NOT NULL,
    FOREIGN KEY (id_doador)
        REFERENCES doador(id_doador),
    CHECK (quantidade > 0)
);

-- TABELA ASSOCIATIVA: DOACAO E ITEM
CREATE TABLE doacao_item (
    id_doacao INT NOT NULL,
    id_item INT NOT NULL,
    quantidade INT NOT NULL,
    PRIMARY KEY (id_doacao, id_item),
    FOREIGN KEY (id_doacao)
        REFERENCES doacao(id_doacao)
        ON DELETE CASCADE,
    FOREIGN KEY (id_item)
        REFERENCES item(id_item),
    CHECK (quantidade > 0)
);
