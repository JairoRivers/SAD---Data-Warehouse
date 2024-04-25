-- Aplicando o ETL no banco de dados da atividade
-- Esse cenário seria a tratativa inicial das mudanças de nomenclaturas

-- Extração (Extract)
-- Alteração dos nomes das tabelas 
EXEC sp_rename 'tbdep', 'Dependentes';
EXEC sp_rename 'tbpro', 'Produtos';
EXEC sp_rename 'tbvdd', 'Vendedores';
EXEC sp_rename 'tbven', 'Venda';
EXEC sp_rename 'tbven_item', 'Itens_Venda';

-- Transformação (Transform)
-- Update dos nomes das colunas de Dependentes (Modificações de nomenclatura das colunas):
-- cddep -> ID_Depedente, nmdep -> Nome, dtnasc -> Data_Nascimento,
-- sxdep -> Sexo, cdvdd -> ID_Vendedor, inepescola -> Inep_Escola
EXEC sp_rename 'Dependentes.cddep', 'ID_Dependente', 'COLUMN';
EXEC sp_rename 'Dependentes.nmdep', 'Nome', 'COLUMN';
EXEC sp_rename 'Dependentes.dtnasc', 'Data_Nascimento', 'COLUMN';
EXEC sp_rename 'Dependentes.sxdep', 'Sexo', 'COLUMN';
EXEC sp_rename 'Dependentes.cdvdd', 'ID_Vendedor', 'COLUMN';
EXEC sp_rename 'Dependentes.inepescola', 'Inep_Escola', 'COLUMN';

-- Update dos nomes das colunas de Produtos (Modificações de nomenclatura das colunas):
-- cdpro -> ID_Produto, nmpro -> Nome, tppro -> Tipo,
-- undpro -> Unidade, slpro -> Saldo, stpro -> Status
EXEC sp_rename 'Produtos.cdpro', 'ID_Produto', 'COLUMN';
EXEC sp_rename 'Produtos.nmpro', 'Nome', 'COLUMN';
EXEC sp_rename 'Produtos.tppro', 'Tipo', 'COLUMN';
EXEC sp_rename 'Produtos.undpro', 'Unidade', 'COLUMN';
EXEC sp_rename 'Produtos.slpro', 'Saldo', 'COLUMN';
EXEC sp_rename 'Produtos.stpro', 'Status', 'COLUMN';

-- Update dos nomes das colunas de Vendedores (Modificações de nomenclatura das colunas):
-- cdvdd -> ID_Vendedor, nmvdd -> Nome, sxvdd -> Sexo,
-- perccomissao -> Percentual_Comissao, matfunc -> Matricula
EXEC sp_rename 'Vendedores.cdvdd', 'ID_Vendedor', 'COLUMN';
EXEC sp_rename 'Vendedores.nmvdd', 'Nome', 'COLUMN';
EXEC sp_rename 'Vendedores.sxvdd', 'Sexo', 'COLUMN';
EXEC sp_rename 'Vendedores.perccomissao', 'Percentual_Comissao', 'COLUMN';
EXEC sp_rename 'Vendedores.matfunc', 'Matricula', 'COLUMN';

-- Update dos nomes das colunas de Venda (Modificações de nomenclatura das colunas):
-- cdven -> ID_Venda, dtven -> Data, cdcli -> ID_Cliente,
-- nmcli -> Nome_Cliente, agecli -> Idade_Cliente, clacli -> Classificacao_Cliente,
-- sxcli -> Sexo_Cliente, cidcli -> Cidade_Cliente, estcli -> Estado_Cliente, 
-- paicli -> Pais_Cliente, canal -> Canal, stven -> Status, cdvdd -> ID_Vendedor
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

-- Update dos nomes das colunas de Itens de Venda (Modificações de nomenclatura das colunas):
-- cdvenitem -> ID_Item, cdpro -> ID_Produto, qtven -> Quantidade,
-- vruven -> Valor_Unitario, vrtven -> Valor_Total, cdven -> ID_Venda
EXEC sp_rename 'Itens_Venda.cdvenitem', 'ID_Item', 'COLUMN';
EXEC sp_rename 'Itens_Venda.cdpro', 'ID_Produto', 'COLUMN';
EXEC sp_rename 'Itens_Venda.qtven', 'Quantidade', 'COLUMN';
EXEC sp_rename 'Itens_Venda.vruven', 'Valor_Unitario', 'COLUMN';
EXEC sp_rename 'Itens_Venda.vrtven', 'Valor_Total', 'COLUMN';
EXEC sp_rename 'Itens_Venda.cdven', 'ID_Venda', 'COLUMN';

-- Updates de Informações de Dependentes que estavam 
UPDATE Vendedores
SET Nome = 
    CASE ID_Vendedor
        WHEN 1 THEN 'Vendedor 1'
        WHEN 2 THEN 'Vendedor 2'
        WHEN 3 THEN 'Vendedor 3'
        WHEN 4 THEN 'Vendedor 4'
        WHEN 5 THEN 'Venderor 5'
        WHEN 6 THEN 'Venderor 6'
        WHEN 7 THEN 'Venderor 7'
        WHEN 8 THEN 'Venderor 8'
        WHEN 9 THEN 'Venderor 9'
        WHEN 10 THEN 'Venderor 10'
        WHEN 11 THEN 'Venderor 11'
    END;
