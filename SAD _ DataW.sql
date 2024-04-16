-- Criando o banco de dados
CREATE DATABASE "Atividade_SAD";

-- Selecionando o banco
USE "Atividade_SAD";

-- Criando tabela (Já na atividade)
CREATE TABLE Vendas (
    VendaID INT IDENTITY(1,1) PRIMARY KEY,
    DataVenda DATETIME,
    ValorVenda DECIMAL(10, 2),
    ClienteID INT,
    NomeCliente NVARCHAR(100),
    EnderecoCliente NVARCHAR(255),
    ProdutoID INT,
    NomeProduto NVARCHAR(100),
    PrecoUnitario DECIMAL(10, 2),
    Quantidade INT,
    VendedorID INT,
    NomeVendedor NVARCHAR(100)
);

-- Inserindo Dados (Já na atividade)
DECLARE @i INT = 0;

WHILE @i < 200
BEGIN
    INSERT INTO Vendas (
        DataVenda,
        ValorVenda,
        ClienteID,
        NomeCliente,
        EnderecoCliente,
        ProdutoID,
        NomeProduto,
        PrecoUnitario,
        Quantidade,
        VendedorID,
        NomeVendedor
    )
    VALUES (
        GETDATE(),
        ROUND((RAND() * (500 - 50) + 50), 2),
        @i % 10 + 1,
        'Cliente ' + CAST((@i % 10 + 1) AS NVARCHAR(10)),
        'Endereço ' + CAST((@i % 10 + 1) AS NVARCHAR(10)),
        @i % 5 + 1,
        'Produto ' + CAST((@i % 5 + 1) AS NVARCHAR(10)),
        ROUND((RAND() * (100 - 10) + 10), 2),
        @i % 3 + 1,
        @i % 4 + 1,
        'Vendedor ' + CAST((@i % 4 + 1) AS NVARCHAR(10))
    );

    SET @i = @i + 1;
END

-- Tabela Dimensão de Data
CREATE TABLE DimensaoData (
    DataID INT IDENTITY(1,1) PRIMARY KEY,
    DataCompleta DATE,
    Ano INT,
    Mes INT,
    Dia INT,
    NomeMes NVARCHAR(20),
    NomeDiaSemana NVARCHAR(20)
);


-- Inserindo dados na Dimensão de Data
INSERT INTO DimensaoData (DataCompleta, Ano, Mes, Dia, NomeMes, NomeDiaSemana)
SELECT DISTINCT
    CAST(DataVenda AS DATE) AS DataCompleta,
    YEAR(DataVenda) AS Ano,
    MONTH(DataVenda) AS Mes,
    DAY(DataVenda) AS Dia,
    DATENAME(MONTH, DataVenda) AS NomeMes,
    DATENAME(WEEKDAY, DataVenda) AS NomeDiaSemana
FROM Vendas;


-- Tabela Dimensão Cliente
CREATE TABLE DimensaoCliente (
    ClienteID INT PRIMARY KEY,
    NomeCliente NVARCHAR(100),
    EnderecoCliente NVARCHAR(255)
);

-- Inserindo dados na Dimensão Cliente
INSERT INTO DimensaoCliente (ClienteID, NomeCliente, EnderecoCliente)
SELECT DISTINCT
    ClienteID,
    NomeCliente,
    EnderecoCliente
FROM Vendas;

-- Tabela Dimensão Produto
CREATE TABLE DimensaoProduto (
    ProdutoID INT PRIMARY KEY,
    NomeProduto NVARCHAR(100),
    PrecoUnitario DECIMAL(10, 2)
);

-- Inserindo dados na Dimensão Produto
INSERT INTO DimensaoProduto (ProdutoID, NomeProduto, PrecoUnitario)
SELECT DISTINCT
    ProdutoID,
    NomeProduto,
    PrecoUnitario
FROM Vendas;

-- Tabela Dimensão Vendedor
CREATE TABLE DimensaoVendedor (
    VendedorID INT PRIMARY KEY,
    NomeVendedor NVARCHAR(100)
);

-- Inserindo dados na Dimensão Vendedor
INSERT INTO DimensaoVendedor (VendedorID, NomeVendedor)
SELECT DISTINCT
    VendedorID,
    NomeVendedor
FROM Vendas;

-- Tabela Fato Vendas
CREATE TABLE FatoVendas (
    VendaID INT PRIMARY KEY,
    DataID INT,
    ClienteID INT,
    ProdutoID INT,
    VendedorID INT,
    ValorVenda DECIMAL(10, 2),
    Quantidade INT,
    FOREIGN KEY (DataID) REFERENCES DimensaoData(DataID),
    FOREIGN KEY (ClienteID) REFERENCES DimensaoCliente(ClienteID),
    FOREIGN KEY (ProdutoID) REFERENCES DimensaoProduto(ProdutoID),
    FOREIGN KEY (VendedorID) REFERENCES DimensaoVendedor(VendedorID)
);

-- Inserindo dados na Tabela Fato Vendas
INSERT INTO FatoVendas (VendaID, DataID, ClienteID, ProdutoID, VendedorID, ValorVenda, Quantidade)
SELECT
    VendaID,
    d.DataID,
    v.ClienteID,
    p.ProdutoID,
    vd.VendedorID,
    ValorVenda,
    Quantidade
FROM Vendas v
INNER JOIN DimensaoData d ON CAST(v.DataVenda AS DATE) = d.DataCompleta
INNER JOIN DimensaoProduto p ON v.ProdutoID = p.ProdutoID
INNER JOIN DimensaoVendedor vd ON v.VendedorID = vd.VendedorID;