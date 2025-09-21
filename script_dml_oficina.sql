##Fase 2: Inserção de Dados (DML)
-- =================================================================================
-- SCRIPT DE INSERÇÃO DE DADOS (DML) PARA O BANCO DE DADOS OFICINA
-- =================================================================================

-- Garanta que você está conectado ao banco de dados "oficina" antes de executar.

-- -----------------------------------------------------
-- Inserção nas tabelas base (sem dependências)
-- -----------------------------------------------------

-- Clientes
INSERT INTO Cliente (nome, CPF, endereco, contato) VALUES
('Carlos Pereira', '11122233344', 'Rua das Rodas, 10', '11988887777'),
('Sandra Gomes', '55566677788', 'Avenida do Motor, 20', '21977776666'),
('Transportadora Veloz Ltda', '12345678000199', 'Rodovia Principal, Km 50', '1433221100'); -- Cliente PJ, CPF será nulo

-- Equipes
INSERT INTO Equipe (nomeEquipe, especialidade) VALUES
('Equipe Alpha', 'Motor e Transmissão'),
('Equipe Beta', 'Freios e Suspensão'),
('Equipe Charlie', 'Elétrica e Diagnóstico');

-- Mecânicos
INSERT INTO Mecanico (nome, codigo, especialidade) VALUES
('João Silva', 'MEC-001', 'Motor'),
('Pedro Souza', 'MEC-002', 'Transmissão'),
('Ana Costa', 'MEC-003', 'Freios'),
('Mariana Dias', 'MEC-004', 'Suspensão'),
('Lucas Martins', 'MEC-005', 'Elétrica'),
('Beatriz Lima', 'MEC-006', 'Diagnóstico Geral');

-- Associando Mecânicos às Equipes (N:N)
-- Equipe Alpha (id=1) com João e Pedro
INSERT INTO Equipe_Mecanico (idEquipe, idMecanico) VALUES (1, 1), (1, 2);
-- Equipe Beta (id=2) com Ana e Mariana
INSERT INTO Equipe_Mecanico (idEquipe, idMecanico) VALUES (2, 3), (2, 4);
-- Equipe Charlie (id=3) com Lucas e Beatriz
INSERT INTO Equipe_Mecanico (idEquipe, idMecanico) VALUES (3, 5), (3, 6);


-- Veículos (associados aos clientes)
-- idCliente=1 (Carlos), idCliente=2 (Sandra)
INSERT INTO Veiculo (idCliente, placa, modelo, marca, ano) VALUES
(1, 'ABC1234', 'Gol', 'Volkswagen', 2020),
(1, 'DEF5678', 'Civic', 'Honda', 2021),
(2, 'GHI9012', 'Corolla', 'Toyota', 2022);


-- Catálogo de Peças
INSERT INTO peca (nomePeca, valor) VALUES
('Filtro de Óleo', 50.00),
('Pastilha de Freio (par)', 120.00),
('Óleo de Motor (litro)', 40.00),
('Vela de Ignição', 25.00),
('Bateria 60Ah', 400.00);

-- Catálogo de Serviços
INSERT INTO servico (nomeServico, valorMaoDeObra) VALUES
('Troca de Óleo e Filtro', 100.00),
('Troca de Pastilhas de Freio', 150.00),
('Diagnóstico Eletrônico', 200.00),
('Alinhamento e Balanceamento', 120.00);


-- -----------------------------------------------------
-- Inserção das Ordens de Serviço e seus relacionamentos
-- -----------------------------------------------------

-- Ordem de Serviço 1 (Concluída)
-- Cliente: Carlos Pereira, Veículo: Gol (id=1), Equipe: Beta (id=2)
INSERT INTO ordem_servico (idVeiculo, idEquipe, dataEmissao, dataConclusao, statusOS, valorTotal)
VALUES (1, 2, '2025-09-15', '2025-09-16', 'Concluída', 270.00); -- Valor: 120 (peça) + 150 (serviço) = 270
-- Assumimos que a OS criada teve o id=1

-- Peças e Serviços para a OS 1
INSERT INTO os_peca (idOS, idPeca, quantidade) VALUES (1, 2, 1); -- id 2 = Pastilha de Freio
INSERT INTO os_servico (idOS, idServico) VALUES (1, 2); -- id 2 = Troca de Pastilhas de Freio

-- Pagamento para a OS 1
INSERT INTO pagamento (idOS, tipoPagamento, valor) VALUES (1, 'Cartão de Crédito', 270.00);


-- Ordem de Serviço 2 (Em execução)
-- Cliente: Carlos Pereira, Veículo: Civic (id=2), Equipe: Alpha (id=1)
INSERT INTO ordem_servico (idVeiculo, idEquipe, dataEmissao, statusOS)
VALUES (2, 1, '2025-09-20', 'Em execução');
-- Assumimos que a OS criada teve o id=2

-- Peças e Serviços para a OS 2
INSERT INTO os_peca (idOS, idPeca, quantidade) VALUES (2, 1, 1), (2, 3, 4); -- id 1 = Filtro, id 3 = Óleo (4 litros)
INSERT INTO os_servico (idOS, idServico) VALUES (2, 1); -- id 1 = Troca de Óleo e Filtro


-- Ordem de Serviço 3 (Aguardando aprovação)
-- Cliente: Sandra Gomes, Veículo: Corolla (id=3), Equipe: Charlie (id=3)
INSERT INTO ordem_servico (idVeiculo, idEquipe, dataEmissao, statusOS)
VALUES (3, 3, '2025-09-21', 'Aguardando aprovação');
-- Assumimos que a OS criada teve o id=3

-- Serviços para a OS 3 (sem peças por enquanto)
INSERT INTO os_servico (idOS, idServico) VALUES (3, 3); -- id 3 = Diagnóstico Eletrônico