-- Criação do Data Warehouse com as tabelas de dimensão e fato

-- Dimensões: Dim_Vendedor, Dim_Produto, Dim_Cliente, Dim_Dependente e Dim_Data
-- Fato: Fato_Venda e Fato_Item_Venda

-- Criando a Tabela Dimensão Vendedor
CREATE TABLE Dim_Vendedor (
   ID_Vendedor      smallint PRIMARY KEY,
   Nome             varchar(50),
   Sexo             char(1),
   Percentual_Comissao decimal(19,2),
   Matricula        smallint
);

-- Inserindo dados na tabela de Dimensão Vendedor
INSERT INTO Dim_Vendedor (ID_Vendedor, Nome, Sexo, Percentual_Comissao, Matricula)
SELECT ID_Vendedor, Nome, Sexo, Percentual_Comissao, Matricula
FROM Vendedores;

-- Criando a Tabela Dimensão Produto
CREATE TABLE Dim_Produto (
    ID_Produto      INT PRIMARY KEY,
    Nome            varchar(50),
    Tipo            varchar(1),
    Unidade         varchar(2),
    Saldo           int,
    Status          varchar(50)
);

-- Inserindo dados na tabela de Dimensão Produto
INSERT INTO Dim_Produto (ID_Produto, Nome, Tipo, Unidade, Saldo, Status)
SELECT ID_Produto, Nome, Tipo, Unidade, Saldo, Status
FROM Produtos;

-- Criando a Tabela Dimensão Cliente
CREATE TABLE Dim_Cliente (
    ID_Cliente      INT PRIMARY KEY,
    Nome_Cliente    varchar(50),
    Idade_Cliente   smallint,
    Classificacao_Cliente   smallint,
    Sexo_Cliente    char(1),
    Cidade_Cliente  varchar(50),
    Estado_Cliente  varchar(50),
    Pais_Cliente    varchar(50)
);

-- Inserindo dados na tabela de Dimensão Cliente
INSERT INTO Dim_Cliente (ID_Cliente, Nome_Cliente, Idade_Cliente, Classificacao_Cliente, Sexo_Cliente, Cidade_Cliente, Estado_Cliente, Pais_Cliente)
SELECT DISTINCT ID_Cliente, Nome_Cliente, Idade_Cliente, Classificacao_Cliente, Sexo_Cliente, Cidade_Cliente, Estado_Cliente, Pais_Cliente
FROM Venda;

-- Criando a Tabela Dimensão Dependentes
CREATE TABLE Dim_Dependente (
    ID_Dependente    INT PRIMARY KEY,
    Nome             VARCHAR(50),
    Data_Nascimento  DATE,
    Sexo             CHAR(1),
    ID_Vendedor      SMALLINT,
    InepEscola       VARCHAR(10),
    CONSTRAINT FK_Dim_Dependente_Vendedor FOREIGN KEY (ID_Vendedor) REFERENCES Dim_Vendedor (ID_Vendedor) -- Chave estrangeira referenciando a tabela Dim_Vendedor
);

-- Inserindo dados na tabela de Dimensão Dependentes
INSERT INTO Dim_Dependente (ID_Dependente, Nome, Data_Nascimento, Sexo, ID_Vendedor, InepEscola)
SELECT DISTINCT ID_Dependente, Nome, Data_Nascimento, Sexo, ID_Vendedor, InepEscola
FROM Dependentes;

-- -- Criando a Tabela Dimensão de Data
CREATE TABLE Dim_Data (
    ID_Data INT PRIMARY KEY,
    Data_Completa DATE,
    Dia TINYINT,
    Mes TINYINT,
    Ano SMALLINT
);

-- Criando a Tabela Fato Venda
CREATE TABLE Fato_Venda (
    ID_Fato_Venda    smallint IDENTITY(1,1) PRIMARY KEY,
    Data_Venda       date,
    ID_Cliente       INT,
    ID_Vendedor      smallint,
    ID_Produto       INT,
    Quantidade_Venda int,
    Valor_Unitario   decimal(18, 2),
    Valor_Total      decimal(29, 2),
    Canal_Venda      varchar(12),
    Status_Venda     smallint,
    CONSTRAINT FK_Fato_Venda_Vendedor FOREIGN KEY (ID_Vendedor) REFERENCES Dim_Vendedor (ID_Vendedor),
    CONSTRAINT FK_Fato_Venda_Produto FOREIGN KEY (ID_Produto) REFERENCES Dim_Produto (ID_Produto),
    CONSTRAINT FK_Fato_Venda_Cliente FOREIGN KEY (ID_Cliente) REFERENCES Dim_Cliente (ID_Cliente)
);

-- Inserindo dados na tabela Fato_Venda
INSERT INTO Fato_Venda (Data_Venda, ID_Cliente, ID_Vendedor, ID_Produto, Quantidade_Venda, Valor_Unitario, Valor_Total, Canal_Venda, Status_Venda)
SELECT v.Data_Venda, v.ID_Cliente, v.ID_Vendedor, iv.ID_Produto, iv.Quantidade_Venda, iv.Valor_Unitario, iv.Valor_Total, v.Canal_Venda, v.Status_Venda
FROM Venda v
JOIN Item_Venda iv ON v.ID_Venda = iv.ID_Venda;
