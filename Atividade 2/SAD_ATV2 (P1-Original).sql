-- Banco de dados (Original), sem modificações

CREATE DATABASE BD_Original;

---------------------------------------
CREATE TABLE tbvdd (
   cdvdd        smallint not null,
   nmvdd        varchar(20),
   sxvdd        smallint, -- 1 - M | 0 - F
   perccomissao decimal(19,2),
   matfunc      smallint not null
); 

-- Criando as chaves primárias (DDL) - OK
ALTER TABLE tbvdd ADD PRIMARY KEY (cdvdd);

-- Inserindo tbvdd (DML)
INSERT INTO tbvdd VALUES (1 , 'Vendedor 1'    , 1, 1  , 1 );
INSERT INTO tbvdd VALUES (2 , 'Vendedor 2    ', 1, 1  , 2 );
INSERT INTO tbvdd VALUES (3 , ' Vendedor 3'   , 1, 1  , 3 );
INSERT INTO tbvdd VALUES (4 , 'Vendedor 4    ', 1, 0.5, 4 );
INSERT INTO tbvdd VALUES (5 , ' Vendedor 5'   , 0, 0.5, 5 );
INSERT INTO tbvdd VALUES (6 , 'Vendedor 6'    , 1, 0.5, 6 );
INSERT INTO tbvdd VALUES (7 , 'Vendedor 7'    , 0, 0.5, 7 );
INSERT INTO tbvdd VALUES (8 , 'Vendedor 8'    , 1, 0.5, 8 );
INSERT INTO tbvdd VALUES (9 , 'Vendedor 9'    , 0, 0.5, 9 );
INSERT INTO tbvdd VALUES (10, 'Vendedor 10'   , 1, 0.5, 10);
INSERT INTO tbvdd VALUES (11, null, 0, 0.5, 11);

---------------------------------------
-- Criação da Tabela Dependente (DDL)
CREATE TABLE tbdep (
   cddep      INT GENERATED ALWAYS AS IDENTITY primary key, -- GENERATED ALWAYS AS IDENTITY (autoincremento do cddep)
   nmdep      varchar(20),
   dtnasc     date,
   sxdep      varchar(2),
   cdvdd      smallint,
   inepescola varchar(10),
   CONSTRAINT FK_Dep_Vdd FOREIGN KEY (cdvdd) REFERENCES tbvdd (cdvdd)
);

-- Populando tbdep (DML)
INSERT INTO tbdep (nmdep, dtnasc, sxdep, cdvdd, inepescola) 
       VALUES ('Dependente 1' , '20100202', 'M' , 1, '11001887');

INSERT INTO tbdep (nmdep, dtnasc, sxdep, cdvdd, inepescola) 
       VALUES ('Dependente 2' , '20120405', 'M' , 3, '11001364'),
              ('Dependente 3' , '20130304', ' F', 3, '11001364'),
              ('Dependente 4' , '20100505', 'F' , 2, '11001666');

-- new insert
INSERT INTO tbdep (nmdep, dtnasc, sxdep, cdvdd, inepescola) 
       VALUES ('Dependente 4' , '20100505', 'F' , 2, '11001666');

---------------------------------------
-- Criação da Tabela de Produto (DDL)

CREATE TABLE tbpro(
    cdpro serial primary key, -- autoincremento - serial
    nmpro varchar(50) NULL,
    tppro varchar(1) NULL,
    undpro varchar(2) NULL,
    slpro int NULL,
    stpro varchar(50) NULL
);

-- Populando tbpro (DML)
INSERT INTO tbpro (nmpro, tppro, undpro, slpro, stpro) VALUES ('Produto A'  , 'A', 'KG' , 20000, 'Ativo');
INSERT INTO tbpro (nmpro, tppro, undpro, slpro, stpro) VALUES ('Produto C'  , 'A', 'KG' , 5000 , 'Ativo');
INSERT INTO tbpro (nmpro, tppro, undpro, slpro, stpro) VALUES ('Produto E'  , 'B', 'KG' , 2000 , 'Ativo');
INSERT INTO tbpro (nmpro, tppro, undpro, slpro, stpro) VALUES ('Produto CH' , 'A', 'KG' , 2000 , 'Ativo');
INSERT INTO tbpro (nmpro, tppro, undpro, slpro, stpro) VALUES ('Produto AB' , 'A', 'KG' , 100  , 'Inativo');
INSERT INTO tbpro (nmpro, tppro, undpro, slpro, stpro) VALUES ('Produto EH' , 'A', 'KG' , 2000 , 'Ativo');
INSERT INTO tbpro (nmpro, tppro, undpro, slpro, stpro) VALUES ('Produto FA' , 'C', 'KG' , 1000 , 'Ativo');
INSERT INTO tbpro (nmpro, tppro, undpro, slpro, stpro) VALUES ('Produto TO' , null, 'KG' , null , 'Ativo');

-- Consultando (DML)
SELECT * FROM tbpro;

---------------------------------------
-- Criação da Tabela de Venda (DDL)

CREATE TABLE tbven(
    cdven   smallint primary key,
    dtven   date NULL,
    cdcli   smallint NULL,
    nmcli   varchar(50) NULL,
    agecli  smallint NULL,
    clacli  smallint NULL,
    sxcli   varchar(1) NULL,
    cidcli  varchar(50) NULL,
    estcli  varchar(50) NULL,
    paicli  varchar(50) NULL,
    canal   varchar(12) NOT NULL,
    stven   smallint NULL, -- 1 concluída, 2 em aberto e 3 é cancelada
    deleted smallint NULL,
    cdvdd   smallint NULL
); -- drop table tbven

-- Adicionando foreign key - relacionamento com Vendedor
ALTER TABLE tbven ADD CONSTRAINT "fk_vendas_vendedor" FOREIGN KEY ( cdvdd ) REFERENCES tbvdd ( cdvdd );


-- populando tbven (DML)
INSERT INTO tbven VALUES (1, '2010-02-01', 1, 'Cliente AA' , 30, 3, 'M', 'Florianópolis', 'Santa Catarina'   , 'Brasil', 'Loja Própria', 1,0,1);
INSERT INTO tbven VALUES (2, '2022-07-08', 2, 'Cliente GRM', 57, 1, 'M', 'Gramado'      , 'Rio Grande do Sul', 'Brasil', 'Loja Virtual', 1,0,2);
INSERT INTO tbven VALUES (3, '2022-07-08', 3, 'Cliente ARM', 50, 1, 'F', 'Fortaleza'    , 'Ceará'            , 'Brasil', 'Loja Virtual', 1,0,4);
INSERT INTO tbven VALUES (4, '2022-07-08', 4, 'Cliente GRM', 57, 2, 'M', 'Canela'       , 'Rio Grande do Sul', 'Brasil', 'Loja Virtual', 1,0,2); -- Duplicidade de Cliente!
INSERT INTO tbven VALUES (5, '2019-07-08', 5, 'Cliente CRM', 22, 1, 'F', 'São Paulo'      , 'São Paulo'      , 'Brasil', 'Loja Virtual', 1,0,3);
INSERT INTO tbven VALUES (6, '2018-04-08', 6, 'Cliente ACM', 30, 4, 'F', 'São Paulo'      , 'São Paulo'      , 'Brasil', 'Loja Virtual', 1,0,4);
INSERT INTO tbven VALUES (7, '2020-05-08', 7, 'Cliente ABM', 41, 2, 'F', 'Rio de Janeiro' , 'Rio de Janeiro' , 'Brasil', 'Loja Virtual', 1,0,3);
INSERT INTO tbven VALUES (8, '2011-06-08', 8, 'Cliente AAM', 19, 1, 'F', 'Eusébio'        , 'Ceará'          , 'Brasil', 'Loja Própria', 3,0,8);
INSERT INTO tbven VALUES (9, '2012-07-04', 9, 'Cliente AAA', 28, 5, 'F', 'Salvador'       , 'Bahia'          , 'Brasil', 'Loja Virtual', 2,0,5);
INSERT INTO tbven VALUES (10,'2013-03-03', 9, 'Cliente AAA', 28, 5, 'F', 'Salvador'       , 'Bahia'          , 'Brasil', 'Loja Virtual', 1,0,6);
INSERT INTO tbven VALUES (11, '2016-07-01', 10, 'Cliente AAAD', 28, 2, 'F', 'Vitória'       , 'Espirito Santo'      , 'Brasil', 'Loja Virtual', 2,0,5);
INSERT INTO tbven VALUES (12, '2016-05-03', 11, 'Cliente AAAE', 29, 3, 'F', 'Natal'         , 'Rio Grande do Norte' , 'Brasil', 'Loja Virtual', 1,0,6);
INSERT INTO tbven VALUES (13, '2015-07-01', 12, 'Cliente AAAF', 30, 1, 'F', 'Natal'         , 'Rio Grande do Norte' , 'Brasil', 'Loja Virtual', 1,0,5);
INSERT INTO tbven VALUES (14, '2015-06-02', 13, 'Cliente AAAG', 31, 4, 'M', 'São Luis'      , 'Maranhão'            , 'Brasil', 'Loja Virtual', 1,0,6);
INSERT INTO tbven VALUES (15, '2017-07-04', 14, 'Cliente AAAH', 32, 4, 'F', 'Florianópolis' , 'Santa Catarina'      , 'Brasil', 'Loja Virtual', 1,0,5);
INSERT INTO tbven VALUES (16, '2017-05-03', 15, 'Cliente AAAI', 33, 5, 'F', 'Aracaju'       , 'Sergipe'             , 'Brasil', 'Loja Virtual', 1,0,6);
INSERT INTO tbven VALUES (17, '2023-01-08', 16, 'Cliente WAAM', 19, 1, 'M', 'Eusébio'       , 'Ceará'               , 'Brasil', 'Loja Própria', 1,0,8);
INSERT INTO tbven VALUES (18, '2023-02-08', 16, 'Cliente WAAM', 19, 1, 'M', 'Eusébio'       , 'Ceará'               , 'Brasil', 'Loja Própria', 1,0,8);
INSERT INTO tbven VALUES (19, '2023-03-08', 16, 'Cliente WAAM', 19, 1, 'M', 'Eusébio'       , 'Ceará'               , 'Brasil', 'Loja Própria', 1,0,8);
INSERT INTO tbven VALUES (20, '2023-04-06', 7 , 'Cliente ABM' , 41, 2, 'F', 'Rio de Janeiro' , 'Rio de Janeiro' , 'Brasil', 'Loja Virtual', 1,1,3);

---------------------------------------
-- Criação da Tabela de Item de Venda (DDL)

CREATE TABLE tbven_item(
    cdvenitem   smallint primary key,
    cdpro       smallint NULL,
    qtven       int NULL,
    vruven      decimal(18, 2) NULL,
    vrtven      decimal(29, 2) NULL,
    cdven       smallint NULL
); -- drop table tbven_item

-- Adicionando foreign key - relacionamento com produto
ALTER TABLE tbven_item ADD CONSTRAINT "fk_vendas_item_produto" FOREIGN KEY ( cdpro ) REFERENCES tbpro ( cdpro );

-- Adicionando foreign key - relacionamento com a venda
ALTER TABLE tbven_item ADD CONSTRAINT "fk_vendas_item_venda" FOREIGN KEY ( cdven ) REFERENCES tbven ( cdven );

-- populando tbven_item (DML)
INSERT INTO tbven_item VALUES (1, 1, 4000 , 0.34, 0, 1);
INSERT INTO tbven_item VALUES (2, 1, 6000 , 0.34, 0, 1);
INSERT INTO tbven_item VALUES (3, 1, 4500 , 0.34, 0, 2);
INSERT INTO tbven_item VALUES (4, 1, 5000 , 0.34, 0, 3);
INSERT INTO tbven_item VALUES (5, 2, 300  , 1.50, 0, 4);
INSERT INTO tbven_item VALUES (6, 3, 4000 , 0.50, 0, 4);
INSERT INTO tbven_item VALUES (8 , 1, 4000 , 0.34, 0, 5);
INSERT INTO tbven_item VALUES (9 , 1, 6000 , 0.34, 0, 6);
INSERT INTO tbven_item VALUES (10, 1, 4500 , 0.34, 0, 7);
INSERT INTO tbven_item VALUES (11, 1, 5000 , 0.34, 0, 7);
INSERT INTO tbven_item VALUES (12, 2, 300  , 1.50, 0, 8);
INSERT INTO tbven_item VALUES (13, 3, 4000 , 0.50, 0, 8);
INSERT INTO tbven_item VALUES (14, 1, 4000 , 0.34, 0, 9);
INSERT INTO tbven_item VALUES (15, 1, 6000 , 0.34, 0, 9);
INSERT INTO tbven_item VALUES (16, 1, 4500 , 0.34, 0, 9);
INSERT INTO tbven_item VALUES (17, 1, 5000 , 0.34, 0, 10);
INSERT INTO tbven_item VALUES (18, 2, 300  , 1.50, 0, 10);
INSERT INTO tbven_item VALUES (19, 3, 4000 , 0.50, 0, 11);
INSERT INTO tbven_item VALUES (20, 7, 4000 , 0.34, 0, 12);
INSERT INTO tbven_item VALUES (21, 7, 6000 , 0.34, 0, 13);
INSERT INTO tbven_item VALUES (22, 7, 4500 , 0.34, 0, 14);
INSERT INTO tbven_item VALUES (23, 1, 5000 , 0.34, 0, 14);
INSERT INTO tbven_item VALUES (24, 8, 300  , 1.50, 0, 15);
INSERT INTO tbven_item VALUES (25, 8, 4000 , 0.50, 0, 15);
INSERT INTO tbven_item VALUES (26, 1, 4000 , 0.34, 0, 16);
INSERT INTO tbven_item VALUES (27, 7, 6000 , 0.34, 0, 17);
INSERT INTO tbven_item VALUES (28, 7, 4500 , 0.34, 0, 18);
INSERT INTO tbven_item VALUES (29, 1, 5000 , 0.34, 0, 18);
INSERT INTO tbven_item VALUES (30, 2, 300  , 1.50, 0, 19);
INSERT INTO tbven_item VALUES (31, 6, 4000 , 0.50, 0, 20);
INSERT INTO tbven_item VALUES (32 , 1, 4000 , 0.34, 0, 5);
INSERT INTO tbven_item VALUES (33 , 1, 6000 , 0.34, 0, 6);
INSERT INTO tbven_item VALUES (34, 1, 4500 , 0.34, 0, 7);
INSERT INTO tbven_item VALUES (35, 1, 5000 , 0.34, 0, 7);
INSERT INTO tbven_item VALUES (36, 2, 300  , 1.50, 0, 8);
INSERT INTO tbven_item VALUES (37, 3, 4000 , 0.50, 0, 8);
INSERT INTO tbven_item VALUES (38, 1, 4000 , 0.34, 0, 9);
INSERT INTO tbven_item VALUES (39, 1, 6000 , 0.34, 0, 9);
INSERT INTO tbven_item VALUES (40, 1, 4500 , 0.34, 0, 9);
INSERT INTO tbven_item VALUES (41, 1, 5000 , 0.34, 0, 10);
INSERT INTO tbven_item VALUES (42, 2, 300  , 1.50, 0, 10);
INSERT INTO tbven_item VALUES (43, 3, 4000 , 0.50, 0, 11);
INSERT INTO tbven_item VALUES (44, 7, 4000 , 0.34, 0, 12);
INSERT INTO tbven_item VALUES (45, 7, 6000 , 0.34, 0, 13);
INSERT INTO tbven_item VALUES (46, 7, 4500 , 0.34, 0, 14);
INSERT INTO tbven_item VALUES (47, 1, 5000 , 0.34, 0, 14);
INSERT INTO tbven_item VALUES (48, 8, 300  , 1.50, 0, 15);
INSERT INTO tbven_item VALUES (49, 8, 4000 , 0.50, 0, 15);
INSERT INTO tbven_item VALUES (50, 1, 4000 , 0.34, 0, 16);
INSERT INTO tbven_item VALUES (51, 7, 6000 , 0.34, 0, 17);
INSERT INTO tbven_item VALUES (52, 7, 4500 , 0.34, 0, 18);
INSERT INTO tbven_item VALUES (53, 1, 5000 , 0.34, 0, 18);
INSERT INTO tbven_item VALUES (54, 2, 300  , 1.50, 0, 19);
INSERT INTO tbven_item VALUES (55, 6, 4000 , 0.50, 0, 20);


-- Modificações
-- Esse cenário seria a tratativa inicial das mudanças de nomenclaturas

-- Alteração dos nomes das tabelas
EXEC sp_rename 'tbdep', 'Dependentes';
EXEC sp_rename 'tbpro', 'Produtos';
EXEC sp_rename 'tbvdd', 'Vendedores';
EXEC sp_rename 'tbven', 'Venda';
EXEC sp_rename 'tbven_item', 'Itens_Venda';

-- Update dos nomes das colunas de Dependentes
EXEC sp_rename 'Dependentes.cddep', 'ID_Dependente', 'COLUMN';
EXEC sp_rename 'Dependentes.nmdep', 'Nome', 'COLUMN';
EXEC sp_rename 'Dependentes.dtnasc', 'Data_Nascimento', 'COLUMN';
EXEC sp_rename 'Dependentes.sxdep', 'Sexo', 'COLUMN';
EXEC sp_rename 'Dependentes.cdvdd', 'ID_Vendedor', 'COLUMN';
EXEC sp_rename 'Dependentes.inepescola', 'Inep_Escola', 'COLUMN';

-- Update dos nomes das colunas de Produtos
EXEC sp_rename 'Produtos.cdpro', 'ID_Produto', 'COLUMN';
EXEC sp_rename 'Produtos.nmpro', 'Nome', 'COLUMN';
EXEC sp_rename 'Produtos.tppro', 'Tipo', 'COLUMN';
EXEC sp_rename 'Produtos.undpro', 'Unidade', 'COLUMN';
EXEC sp_rename 'Produtos.slpro', 'Saldo', 'COLUMN';
EXEC sp_rename 'Produtos.stpro', 'Status', 'COLUMN';

-- Update dos nomes das colunas de Vendedores
EXEC sp_rename 'Vendedores.cdvdd', 'ID_Vendedor', 'COLUMN';
EXEC sp_rename 'Vendedores.nmvdd', 'Nome', 'COLUMN';
EXEC sp_rename 'Vendedores.sxvdd', 'Sexo', 'COLUMN';
EXEC sp_rename 'Vendedores.perccomissao', 'Percentual_Comissao', 'COLUMN';
EXEC sp_rename 'Vendedores.matfunc', 'Matricula', 'COLUMN';

-- Update dos nomes das colunas de Venda
EXEC sp_rename 'Venda.cdven', 'ID_Venda', 'COLUMN';
EXEC sp_rename 'Venda.dtven', 'Data', 'COLUMN';
EXEC sp_rename 'Venda.cdcli', 'ID_Cliente', 'COLUMN';
EXEC sp_rename 'Venda.nmcli', 'Nome_Cliente', 'COLUMN';
EXEC sp_rename 'Venda.agecli', 'Idade_Cliente', 'COLUMN';
EXEC sp_rename 'Venda.clacli', 'Classificacao_Cliente', 'COLUMN';
EXEC sp_rename 'Venda.sxcli', 'Sexo_Cliente', 'COLUMN';
EXEC sp_rename 'Venda.cidcli', 'Cidade_Cliente', 'COLUMN';
EXEC sp_rename 'Venda.estcli', 'Estado_Cliente', 'COLUMN';
EXEC sp_rename 'Venda.paicli', 'País_Cliente', 'COLUMN';
EXEC sp_rename 'Venda.canal', 'Canal', 'COLUMN';
EXEC sp_rename 'Venda.stven', 'Status', 'COLUMN';
EXEC sp_rename 'Venda.deleted', 'Deletado', 'COLUMN';
EXEC sp_rename 'Venda.cdvdd', 'ID_Vendedor', 'COLUMN';

-- Update dos nomes das colunas de Itens de Venda
EXEC sp_rename 'Itens_Venda.cdvenitem', 'ID_Item', 'COLUMN';
EXEC sp_rename 'Itens_Venda.cdpro', 'ID_Produto', 'COLUMN';
EXEC sp_rename 'Itens_Venda.qtven', 'Quantidade', 'COLUMN';
EXEC sp_rename 'Itens_Venda.vruven', 'Valor_Unitario', 'COLUMN';
EXEC sp_rename 'Itens_Venda.vrtven', 'Valor_Total', 'COLUMN';
EXEC sp_rename 'Itens_Venda.cdven', 'ID_Venda', 'COLUMN';

-- Updates de Informações de Dependentes
UPDATE Vendedores
SET Nome = 
    CASE ID_Dependente
        WHEN 1 THEN 'Vendedor 1'
        WHEN 2 THEN 'Vendedor 2'
        WHEN 3 THEN 'Vendedor 3'
        WHEN 4 THEN 'Vendedor 4'
        WHEN 5 THEN 'Venderor 5'
        WHEN 6 THEN 'Venderor 6'
    END;