-- Criando o Banco de Dados
CREATE DATABASE BD_Atividade2;

-- Criando o ODS
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
