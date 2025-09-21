-- =================================================================================
-- SCRIPT DE CRIAÇÃO DO SCHEMA (DDL) PARA O BANCO DE DADOS OFICINA
-- =================================================================================

CREATE TABLE Cliente (
    idCliente INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    CPF CHAR(11) UNIQUE,
    CNPJ CHAR(14) UNIQUE,
    endereco VARCHAR(255),
    contato VARCHAR(20)
);

CREATE TABLE Equipe (
    idEquipe INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nomeEquipe VARCHAR(100) NOT NULL UNIQUE,
    especialidade VARCHAR(255)
);

CREATE TABLE Mecanico (
    idMecanico INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    codigo CHAR(10) NOT NULL UNIQUE,
    especialidade VARCHAR(255)
);

CREATE TABLE Equipe_Mecanico (
    idEquipe INT,
    idMecanico INT,
    PRIMARY KEY (idEquipe, idMecanico),
    CONSTRAINT fk_equipemec_equipe FOREIGN KEY (idEquipe) REFERENCES Equipe(idEquipe),
    CONSTRAINT fk_equipemec_mecanico FOREIGN KEY (idMecanico) REFERENCES Mecanico(idMecanico)
);

CREATE TABLE Veiculo (
    idVeiculo INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    idCliente INT,
    placa CHAR(7) NOT NULL UNIQUE,
    modelo VARCHAR(100) NOT NULL,
    marca VARCHAR(100),
    ano INT,
    CONSTRAINT fk_veiculo_cliente FOREIGN KEY (idCliente) REFERENCES Cliente(idCliente)
);

CREATE TABLE Peca (
    idPeca INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nomePeca VARCHAR(255) NOT NULL,
    valor DECIMAL(10, 2) NOT NULL
);

CREATE TABLE Servico (
    idServico INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nomeServico VARCHAR(255) NOT NULL,
    valorMaoDeObra DECIMAL(10, 2) NOT NULL
);

CREATE TABLE Ordem_Servico (
    idOS INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    idVeiculo INT NOT NULL,
    idEquipe INT,
    dataEmissao DATE NOT NULL,
    dataConclusao DATE,
    statusOS VARCHAR(50) CHECK (statusOS IN ('Aguardando aprovação', 'Aprovada', 'Em execução', 'Concluída', 'Cancelada')),
    valorTotal DECIMAL(10, 2),
    CONSTRAINT fk_os_veiculo FOREIGN KEY (idVeiculo) REFERENCES Veiculo(idVeiculo),
    CONSTRAINT fk_os_equipe FOREIGN KEY (idEquipe) REFERENCES Equipe(idEquipe)
);

CREATE TABLE OS_Peca (
    idOS INT,
    idPeca INT,
    quantidade INT NOT NULL DEFAULT 1,
    PRIMARY KEY (idOS, idPeca),
    CONSTRAINT fk_ospeca_os FOREIGN KEY (idOS) REFERENCES Ordem_Servico(idOS),
    CONSTRAINT fk_ospeca_peca FOREIGN KEY (idPeca) REFERENCES Peca(idPeca)
);

CREATE TABLE OS_Servico (
    idOS INT,
    idServico INT,
    PRIMARY KEY (idOS, idServico),
    CONSTRAINT fk_osservico_os FOREIGN KEY (idOS) REFERENCES Ordem_Servico(idOS),
    CONSTRAINT fk_osservico_servico FOREIGN KEY (idServico) REFERENCES Servico(idServico)
);

CREATE TABLE Pagamento (
    idPagamento INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    idOS INT NOT NULL,
    tipoPagamento VARCHAR(50) CHECK (tipoPagamento IN ('Cartão de Crédito', 'Boleto', 'PIX', 'Dinheiro')),
    valor DECIMAL(10, 2) NOT NULL,
    CONSTRAINT fk_pagamento_os FOREIGN KEY (idOS) REFERENCES Ordem_Servico(idOS)
);