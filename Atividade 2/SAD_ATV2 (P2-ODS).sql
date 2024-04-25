-- Criando o Banco de Dados
CREATE DATABASE BD_Atividade2;

-- Aplicando o ETL
-- Esse banco de dados foi criado com base no original da atividade, com algumas mudanças de tipos de dados,  
-- melhoria de suas nomenclaturas de tabelas e colunas e por fim aperfeiçoamento dos contéudo dos dados.

-- Definindo o Banco de Dados para Uso
USE BD_Atividade2;

-- tbvdd foi renomeado para (Tabela de Vendedores)
-- tbdep foi renomeado para (Tabela de Dependentes)
-- tbpro foi renomeado para (Tabela de Produtos)
-- tbven foi renomeado para (Tabela de Vendas)
-- tbven_item foi renomeado para (Tabela de Itens de Venda)

-- Criando a Tabela de Vendedores

-- Modificações de nomenclatura das colunas:
-- cdvdd -> ID_Vendedor, nmvdd -> Nome, sxvdd -> Sexo,
-- perccomissao -> Percentual_Comissao, matfunc -> Matricula

CREATE TABLE Vendedores (
   ID_Vendedor      smallint IDENTITY(1,1) PRIMARY KEY,
   Nome             varchar(50),
   Sexo             char(1), -- Padronizado
   Percentual_Comissao decimal(19,2),
   Matricula smallint not null
); 

-- Inserindo dados na tabela de Vendedores
INSERT INTO Vendedores (Nome, Sexo, Percentual_Comissao, Matricula)
VALUES 
('Vendedor 1', 'M', 1, 1),
('Vendedor 2', 'M', 1, 2),
('Vendedor 3', 'M', 1, 3),
('Vendedor 4', 'M', 0.5, 4),
('Vendedor 5', 'F', 0.5, 5),
('Vendedor 6', 'F', 0.5, 6),
('Vendedor 7', 'F', 0.5, 7),
('Vendedor 8', 'M', 0.5, 8),
('Vendedor 9', 'F', 0.5, 9),
('Vendedor 10', 'M', 0.5, 10),
('Vendedor 11', 'F', 0.5, 11);

-- Criando a Tabela de Dependentes

-- Modificações de nomenclatura das colunas:
-- cddep -> ID_Depedente, nmdep -> Nome, dtnasc -> Data_Nascimento,
-- sxdep -> Sexo, cdvdd -> ID_Vendedor, inepescola -> Inep_Escola

CREATE TABLE Dependentes (
   ID_Dependente    INT IDENTITY(1,1) PRIMARY KEY,
   Nome             varchar(50),
   Data_Nascimento  date,
   Sexo             char(1),
   ID_Vendedor      smallint,
   InepEscola       varchar(10) UNIQUE, -- Evitar duplicidade
   CONSTRAINT FK_Dependente_Vendedor FOREIGN KEY (ID_Vendedor) REFERENCES Vendedores (ID_Vendedor)
);

-- Inserindo dados na tabela de Dependentes
INSERT INTO Dependentes (Nome, Data_Nascimento, Sexo, ID_Vendedor, InepEscola) 
VALUES 
('Depedente 1', '2010-02-02', 'F', 1, '11001887'),
('Depedente 2', '2012-04-05', 'F', 3, '11001364'),
('Depedente 3', '2013-03-04', 'M', 3, '11001364'),
('Depedente 4', '2010-05-05', 'M', 2, '11001666'),
('Depedente 5', '2010-05-05', 'M', 2, '11001669');

-- Criando a Tabela de Produtos

-- Modificações de nomenclatura das colunas:
-- cdpro -> ID_Produto, nmpro -> Nome, tppro -> Tipo,
-- undpro -> Unidade, slpro -> Saldo, stpro -> Status

CREATE TABLE Produtos(
    ID_Produto      INT IDENTITY(1,1) PRIMARY KEY,
    Nome            varchar(50) NULL,
    Tipo            varchar(1) NULL,
    Unidade         varchar(2) NULL,
    Saldo           int NULL,
    Status          varchar(50) NULL
);

-- Inserindo dados na tabela de Produto
INSERT INTO Produtos (Nome, Tipo, Unidade, Saldo, Status) 
VALUES 
('Produto 1', 'A', 'KG', 20000, 'Ativo'),
('Produto 2', 'A', 'KG', 5000, 'Ativo'),
('Produto 3', 'B', 'KG', 2000, 'Ativo'),
('Produto 4', 'A', 'KG', 2000, 'Ativo'),
('Produto 5', 'A', 'KG', 100, 'Inativo'),
('Produto 6', 'A', 'KG', 2000, 'Ativo'),
('Produto 7', 'C', 'KG', 1000, 'Ativo'),
('Produto 8', 'B', 'KG', 3000, 'Ativo');


-- Criando a Tabela de Venda

-- Modificações de nomenclatura das colunas:
-- cdven -> ID_Venda, dtven -> Data, cdcli -> ID_Cliente,
-- nmcli -> Nome_Cliente, agecli -> Idade_Cliente, clacli -> Classificacao_Cliente,
-- sxcli -> Sexo_Cliente, cidcli -> Cidade_Cliente, estcli -> Estado_Cliente, 
-- paicli -> Pais_Cliente, canal -> Canal, stven -> Status, cdvdd -> ID_Vendedor

CREATE TABLE Venda(
    ID_Venda         smallint PRIMARY KEY,
    Data_Venda       date NULL,
    ID_Cliente       smallint NULL,
    Nome_Cliente     varchar(50) NULL,
    Idade_Cliente    smallint NULL,
    Classificacao_Cliente   smallint NULL,
    Sexo_Cliente     char(1) NULL,
    Cidade_Cliente   varchar(50) NULL,
    Estado_Cliente   varchar(50) NULL,
    Pais_Cliente     varchar(50) NULL,
    Canal_Venda      varchar(12) NOT NULL,
    Status_Venda     smallint NULL,
    ID_Vendedor      smallint NULL,
    CONSTRAINT FK_Venda_Vendedor FOREIGN KEY (ID_Vendedor) REFERENCES Vendedores (ID_Vendedor)
);

-- Inserindo dados na tabela de Venda
INSERT INTO Venda (ID_Venda, Data_Venda, ID_Cliente, Nome_Cliente, Idade_Cliente, Classificacao_Cliente, Sexo_Cliente, Cidade_Cliente, Estado_Cliente, Pais_Cliente, Canal_Venda, Status_Venda, ID_Vendedor) VALUES 
(1, '2010-02-01', 1, 'Cliente 1', 30, 3, 'M', 'Florianópolis', 'Santa Catarina', 'Brasil', 'Loja Própria', 1, 1),
(2, '2022-07-08', 2, 'Cliente 2', 57, 1, 'M', 'Gramado', 'Rio Grande do Sul', 'Brasil', 'Loja Virtual', 1, 2),
(3, '2022-07-08', 3, 'Cliente 3', 50, 1, 'F', 'Fortaleza', 'Ceará', 'Brasil', 'Loja Virtual', 1, 4),
(4, '2022-07-08', 4, 'Cliente 4', 57, 2, 'M', 'Canela', 'Rio Grande do Sul', 'Brasil', 'Loja Virtual', 1, 2), -- Duplicidade de Cliente!
(5, '2019-07-08', 5, 'Cliente 5', 22, 1, 'F', 'São Paulo', 'São Paulo', 'Brasil', 'Loja Virtual', 1, 3),
(6, '2018-04-08', 6, 'Cliente 6', 30, 4, 'F', 'São Paulo', 'São Paulo', 'Brasil', 'Loja Virtual', 1, 4),
(7, '2020-05-08', 7, 'Cliente 7', 41, 2, 'F', 'Rio de Janeiro', 'Rio de Janeiro', 'Brasil', 'Loja Virtual', 1, 3),
(8, '2011-06-08', 8, 'Cliente 8', 19, 1, 'F', 'Eusébio', 'Ceará', 'Brasil', 'Loja Própria', 3, 8),
(9, '2012-07-04', 9, 'Cliente 9', 28, 5, 'F', 'Salvador', 'Bahia', 'Brasil', 'Loja Virtual', 2, 5),
(10, '2013-03-03', 9, 'Cliente 9', 28, 5, 'F', 'Salvador', 'Bahia', 'Brasil', 'Loja Virtual', 1, 6),
(11, '2016-07-01', 10, 'Cliente 10', 28, 2, 'F', 'Vitória', 'Espirito Santo', 'Brasil', 'Loja Virtual', 2, 5),
(12, '2016-05-03', 11, 'Cliente 11', 29, 3, 'F', 'Natal', 'Rio Grande do Norte', 'Brasil', 'Loja Virtual', 1, 6),
(13, '2015-07-01', 12, 'Cliente 12', 30, 1, 'M', 'Natal', 'Rio Grande do Norte', 'Brasil', 'Loja Virtual', 1, 5),
(14, '2015-06-02', 13, 'Cliente 13', 31, 4, 'M', 'São Luis', 'Maranhão', 'Brasil', 'Loja Virtual', 1, 6),
(15, '2017-07-04', 14, 'Cliente 14', 32, 4, 'F', 'Florianópolis', 'Santa Catarina', 'Brasil', 'Loja Virtual', 1, 5),
(16, '2017-05-03', 15, 'Cliente 15', 33, 5, 'M', 'Aracaju', 'Sergipe', 'Brasil', 'Loja Virtual', 1, 6),
(17, '2023-01-08', 16, 'Cliente 16', 19, 1, 'M', 'Eusébio', 'Ceará', 'Brasil', 'Loja Própria', 1, 8),
(18, '2023-02-08', 16, 'Cliente 16', 19, 1, 'M', 'Eusébio', 'Ceará', 'Brasil', 'Loja Própria', 1, 8),
(19, '2023-03-08', 16, 'Cliente 16', 19, 1, 'M', 'Eusébio', 'Ceará', 'Brasil', 'Loja Própria', 1, 8),
(20, '2023-04-06', 7, 'Cliente 7', 41, 2, 'F', 'Rio de Janeiro', 'Rio de Janeiro', 'Brasil', 'Loja Virtual', 1, 3);

-- Criando a Tabela de Item de Venda

-- Modificações de nomenclatura das colunas:
-- cdvenitem -> ID_Item, cdpro -> ID_Produto, qtven -> Quantidade,
-- vruven -> Valor_Unitario, vrtven -> Valor_Total, cdven -> ID_Venda

CREATE TABLE Item_Venda(
    ID_Item_Venda    smallint PRIMARY KEY,
    ID_Produto       INT NULL,
    Quantidade_Venda int NULL,
    Valor_Unitario   decimal(18, 2) NULL,
    Valor_Total      AS (Quantidade_Venda * Valor_Unitario), --Mudança para já compor o cálculo do Valor Total
    ID_Venda         smallint NULL,
    CONSTRAINT FK_ItemVenda_Produto FOREIGN KEY (ID_Produto) REFERENCES Produtos (ID_Produto),
    CONSTRAINT FK_ItemVenda_Venda FOREIGN KEY (ID_Venda) REFERENCES Venda (ID_Venda)
);

-- Inserindo dados na tabela de Item de Venda
INSERT INTO Item_Venda VALUES 
(3, 1, 4500, 0.34, 2),
(4, 1, 5000, 0.34, 3),
(5, 2, 300, 1.50, 4),
(6, 3, 4000, 0.50, 4),
(8, 1, 4000, 0.34, 5),
(9, 1, 6000, 0.34, 6),
(10, 1, 4500, 0.34, 7),
(11, 1, 5000, 0.34, 7),
(12, 2, 300, 1.50, 8),
(13, 3, 4000, 0.50, 8),
(14, 1, 4000, 0.34, 9),
(15, 1, 6000, 0.34, 9),
(16, 1, 4500, 0.34, 9),
(17, 1, 5000, 0.34, 10),
(18, 2, 300, 1.50, 10),
(19, 3, 4000, 0.50, 11),
(20, 7, 4000, 0.34, 12),
(21, 7, 6000, 0.34, 13),
(22, 7, 4500, 0.34, 14),
(23, 1, 5000, 0.34, 14),
(24, 8, 300, 1.50, 15),
(25, 8, 4000, 0.50, 15),
(26, 1, 4000, 0.34, 16),
(27, 7, 6000, 0.34, 17),
(28, 7, 4500, 0.34, 18),
(29, 1, 5000, 0.34, 18),
(30, 2, 300, 1.50, 19),
(31, 6, 4000, 0.50, 20),
(32, 1, 4000, 0.34, 5),
(33, 1, 6000, 0.34, 6),
(34, 1, 4500, 0.34, 7),
(35, 1, 5000, 0.34, 7),
(36, 2, 300, 1.50, 8),
(37, 3, 4000, 0.50, 8),
(38, 1, 4000, 0.34, 9),
(39, 1, 6000, 0.34, 9),
(40, 1, 4500, 0.34, 9),
(41, 1, 5000, 0.34, 10),
(42, 2, 300, 1.50, 10),
(43, 3, 4000, 0.50, 11),
(44, 7, 4000, 0.34, 12),
(45, 7, 6000, 0.34, 13),
(46, 7, 4500, 0.34, 14),
(47, 1, 5000, 0.34, 14),
(48, 8, 300, 1.50, 15),
(49, 8, 4000, 0.50, 15),
(50, 1, 4000, 0.34, 16),
(51, 7, 6000, 0.34, 17),
(52, 7, 4500, 0.34, 18),
(53, 1, 5000, 0.34, 18),
(54, 2, 300, 1.50, 19),
(55, 6, 4000, 0.50, 20);