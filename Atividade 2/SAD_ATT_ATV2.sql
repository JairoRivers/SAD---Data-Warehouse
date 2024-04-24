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
UPDATE Dependentes
SET Nome = 
    CASE ID_Dependente
        WHEN 1 THEN 'João Victor'
        WHEN 2 THEN 'Petrus Onofre'
        WHEN 3 THEN 'Juliana Fontenele'
        WHEN 4 THEN 'Luana Ribeiro'
        WHEN 5 THEN 'Luiza Nobre'
    END;

-- Updates de Informações de Produtos
UPDATE Produtos
SET Nome = 
    CASE ID_Produto
        WHEN 1 THEN 'Câmera de segurança'
        WHEN 2 THEN 'Celular'
        WHEN 3 THEN 'PS2'
        WHEN 4 THEN 'Kit de Ferramentas'
        WHEN 5 THEN 'Livro dos Ventos'
        WHEN 6 THEN 'Kindle'
        WHEN 7 THEN 'Fone de Ouvido Gamer'
        WHEN 8 THEN 'PS4'
    END;

--
UPDATE Vendedores
SET Nome = 
    CASE ID_Vendedor
        WHEN 1 THEN 'João Silva'
        WHEN 2 THEN 'Maria Santos'
        WHEN 3 THEN 'Pedro Oliveira'
        WHEN 4 THEN 'Ana Costa'
        WHEN 5 THEN 'Lucas Pereira'
        WHEN 6 THEN 'Juliana Souza'
        WHEN 7 THEN 'Marcos Santos'
        WHEN 8 THEN 'Fernanda Lima'
    END
WHERE ID_Vendedor IN (1, 2, 3, 4, 5, 6, 7, 8);

--
UPDATE Venda
SET Nome_Cliente = 
    CASE 
        WHEN ID_Cliente = 1 THEN 'Gustavo Ramos' 
        WHEN ID_Cliente = 2 THEN 'Arthur Almeida' 
        WHEN ID_Cliente = 3 THEN 'Carla Ribeiro' 
        WHEN ID_Cliente = 4 THEN 'André Costa' 
        WHEN ID_Cliente = 5 THEN 'Aline Amaral' 
        WHEN ID_Cliente = 6 THEN 'Ana Amorim' 
        WHEN ID_Cliente = 7 THEN 'Alice Andrade' 
        WHEN ID_Cliente = 8 THEN 'Amanda Alves' 
        WHEN ID_Cliente = 9 THEN 'Amélia Albuquerque' 
        WHEN ID_Cliente = 10 THEN 'Alex Araújo' 
        WHEN ID_Cliente = 11 THEN 'Alex Araújo'
        WHEN ID_Cliente = 12 THEN 'Andressa Alencar' 
        WHEN ID_Cliente = 13 THEN 'Wagner Almeida' 
        WHEN ID_Cliente = 14 THEN 'Bianca Barbosa' 
        WHEN ID_Cliente = 15 THEN 'Bruna Borges' 
        WHEN ID_Cliente = 16 THEN 'Lucas Cardoso'
        WHEN ID_Cliente = 17 THEN 'César Castro' 
        WHEN ID_Cliente = 18 THEN 'Cláudia Costa' 
        WHEN ID_Cliente = 19 THEN 'Daniel Dantas' 
        WHEN ID_Cliente = 20 THEN 'Débora Duarte' 
    END;
