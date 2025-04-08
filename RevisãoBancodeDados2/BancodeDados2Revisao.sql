-- 01. Contar o número total de clientes

SELECT
	COUNT(clientes.id) AS total_de_clientes
FROM
	clientes;

SELECT count(id)
FROM clientes;

-- 02. Contar o número total de pedidos

SELECT count(*) as total_de_pedidos
FROM pedidos;

SELECT count(id)
FROM pedidos; -- não conta os nulos

-- 03. Calcular o valor total de todos os pedidos
SELECT 
  SUM(p.quantidade * pr.preco) AS valor_total_pedidos  -- Soma do valor de todos os pedidos (quantidade × preço)
FROM pedidos p                                          -- Tabela de pedidos
JOIN produtos pr ON p.produto_id = pr.id;               -- Junta com a tabela de produtos para acessar o preço


-- 04. Calcular a média de preço dos produtos
SELECT 
  AVG(preco) AS media_de_preco  -- Calcula a média de todos os preços dos produtos
FROM produtos;                  -- A partir da tabela de produtos

-- 05. Listar todos os clientes e seus pedidos
SELECT 
  c.nome AS cliente,     -- Nome do cliente
  p.id AS pedido         -- ID do pedido feito pelo cliente
FROM Clientes c          -- Tabela de clientes
LEFT JOIN Pedidos p ON c.id = p.cliente_id;  -- Junta com a tabela de pedidos, ligando pelo ID do cliente

-- 06. Listar todos os pedidos e seus produtos, incluindo pedidos sem produtos
SELECT 
  pd.id AS pedidos,         -- ID do pedido
  p.nome AS produtos        -- Nome do produto relacionado (pode ser NULL se não houver)
FROM pedidos pd             -- Tabela de pedidos
LEFT JOIN produtos p ON pd.produto_id = p.id;  -- Junta com a tabela de produtos, incluindo pedidos sem produto

-- 07. Listar os produtos mais caros primeiro
SELECT DISTINCT 
  nome,          -- Nome do produto
  preco          -- Preço do produto
FROM produtos    -- Tabela de produtos
ORDER BY preco DESC;  -- Ordena do mais caro para o mais barato

-- 08 Listar os produtos com menor estoque primeiro

SELECT DISTINCT 
  pd.nome,           -- Nome do produto
  pd.estoque         -- Quantidade disponível no estoque
FROM produtos pd      -- Tabela de produtos
ORDER BY pd.estoque ASC;  -- Ordena do menor para o maior estoque

-- 09 Contar quantos pedidos foram feitos por cliente

SELECT cliente_id, count(id) as total_pedidos
FROM pedidos 
WHERE cliente_id IS NOT NULL  -- Para ignorar pedidos sem cliente associado
GROUP BY cliente_id
ORDER BY total_pedidos DESC;  -- Ordena do maior para o menor
 
-- Listar todos os clientes e a quantidade de pedidos que cada um fez
SELECT
  clientes.nome AS cliente,                          -- Nome do cliente
  COUNT(pedidos.cliente_id) AS total_pedidos         -- Conta quantos pedidos esse cliente fez
FROM clientes                                           -- Tabela principal: clientes
LEFT JOIN pedidos ON clientes.id = pedidos.cliente_id        -- Junta com pedidos (mesmo que não exista pedido)
GROUP BY clientes.id, clientes.nome;                        -- Agrupa pelo ID e nome do cliente

-- 10. Contar quantos produtos diferentes foram vendidos

SELECT COUNT(DISTINCT produto_id) AS produtos_diferentes  -- Conta quantos produtos diferentes (únicos) foram vendidos
FROM pedidos                                               -- A partir da tabela de pedidos
WHERE produto_id IS NOT NULL;                              -- Considera apenas os pedidos que têm um produto (ignora valores nulos)

-- 11. Mostrar os clientes que não realizaram pedidos

SELECT c.nome AS cliente, p.id AS pedido            -- Seleciona o nome do cliente e o ID do pedido (se houver)
FROM clientes c                                       -- Da tabela de clientes (base principal)
LEFT JOIN pedidos p ON c.id = p.cliente_id            -- Junta com a tabela de pedidos, ligando o cliente ao seu pedido
WHERE p.id IS NULL                                    -- Filtra apenas os que NÃO têm pedido (ou seja, p.id é nulo)
ORDER BY c.nome;                                      -- Ordena os resultados pelo nome do cliente (opcional)

-- 12. Mostrar os produtos que nunca foram vendidos
SELECT p.nome AS produtos, pd.id AS pedidos            -- Seleciona o nome do produto e o ID do pedido (se houver)
FROM produtos p                                        -- Da tabela de produtos (base principal)
LEFT JOIN pedidos pd ON p.id = pd.produto_id           -- Junta com a tabela de pedidos, ligando o produto ao pedido
WHERE pd.id IS NULL                                    -- Filtra apenas os produtos que NÃO aparecem em nenhum pedido
ORDER BY p.nome;                                       -- Ordena os resultados pelo nome do produto

-- 13. Contar o número de pedidos feitos por dia
SELECT DATE(data_pedido) AS dia,                  -- Extrai apenas a data (sem hora) do pedido
		COUNT(*) AS total_pedidos                  -- Conta quantos pedidos foram feitos nesse dia
FROM pedidos                                 -- A partir da tabela de pedidos
WHERE data_pedido IS NOT NULL                -- Garante que só vai contar pedidos com data válida
GROUP BY DATE(data_pedido)                   -- Agrupa os resultados por dia
ORDER BY dia;                                -- Ordena os resultados em ordem crescente de data

-- 14. Listar os produtos mais vendidos
SELECT 
  p.nome AS produtos,                           -- Nome do produto
  SUM(pd.quantidade) AS total_vendido           -- Soma total de unidades vendidas do produto
FROM produtos p                                 -- Da tabela de produtos
LEFT JOIN pedidos pd ON p.id = pd.produto_id         -- Junta com a tabela de pedidos, ligando produto ao pedido
GROUP BY p.nome                                 -- Agrupa por nome do produto
ORDER BY total_vendido DESC;                    -- Ordena do mais vendido para o menos vendido

-- 15. Encontrar o cliente que mais fez pedidos 
SELECT 
  c.nome,                                 -- Nome do cliente
  COUNT(pd.id) AS total_de_pedidos        -- Conta quantos pedidos esse cliente fez
FROM clientes c                           -- Tabela de clientes
JOIN pedidos pd ON c.id = pd.cliente_id   -- Junta os pedidos com os clientes, usando o ID
GROUP BY c.nome                            -- Agrupa os resultados por nome do cliente
ORDER BY total_de_pedidos DESC             -- Ordena do maior número de pedidos para o menor
LIMIT 1;                                   -- Retorna só o cliente que mais fez pedidos                              -- Mostra só o top 1


-- 16. Listar os pedidos e os clientes que os fizeram, incluindo pedidos sem clientes

SELECT 
  ped.id AS pedido,         -- ID do pedido
  c.nome AS cliente,        -- Nome do cliente (pode ser NULL se não tiver cliente)
  p.nome AS produto         -- Nome do produto associado ao pedido
FROM pedidos ped
LEFT JOIN clientes c ON ped.cliente_id = c.id     -- Junta com a tabela de clientes (mesmo que o cliente não exista)
LEFT JOIN produtos p ON p.id = ped.produto_id     -- Junta com a tabela de produtos
ORDER BY ped.id;                                   -- Ordena os resultados pelo ID do pedido

-- 17. Listar os produtos e o total de vendas por produto com preço
SELECT 
  p.nome AS produto,                          -- Nome do produto
  SUM(p.preco * pd.quantidade) AS total_de_vendas  -- Soma total das vendas (preço x quantidade)
FROM pedidos pd                               -- Tabela de pedidos
JOIN produtos p ON pd.produto_id = p.id       -- Junta com produtos, ligando o pedido ao produto
GROUP BY p.nome                               -- Agrupa por nome do produto
ORDER BY total_de_vendas DESC;                -- Ordena do mais vendido ao menos vendido (opcional)

-- Listar apenas a quantidade de unidades vendidas
SELECT
	produtos.nome AS produto,                         -- Seleciona o nome do produto e renomeia a coluna como "produto"
	COUNT(pedidos.produto_id) AS total_de_pedidos,   -- Conta quantas vezes o produto apareceu em pedidos
	SUM(pedidos.quantidade) AS unidades_vendidas     -- Soma o total de unidades vendidas do produto
FROM produtos                                          -- A partir da tabela de produtos
LEFT JOIN pedidos ON pedidos.produto_id = produtos.id       -- Junta com a tabela de pedidos, relacionando pelo ID do produto
	                                                  -- LEFT JOIN garante que produtos sem vendas também apareçam
GROUP BY produtos.nome		                                -- Agrupa os resultados por nome do produto
ORDER BY unidades_vendidas DESC;

    -- Listar os produtos com total de pedidos, unidades vendidas e valor total de vendas
SELECT
  p.nome AS produto,                                         -- Nome do produto
  COUNT(pd.id) AS total_de_pedidos,                          -- Quantidade de vezes que o produto foi pedido
  SUM(pd.quantidade) AS unidades_vendidas,                   -- Soma das unidades vendidas
  SUM(p.preco * pd.quantidade) AS total_em_vendas            -- Soma do valor total vendido (preço x quantidade)
FROM produtos p
LEFT JOIN pedidos pd ON pd.produto_id = p.id                 -- Junta produtos com pedidos (mesmo que não tenha sido vendido)
GROUP BY p.nome
ORDER BY total_em_vendas DESC;                               -- Ordena do mais lucrativo para o menos

-- 18. Calcular a média de quantidade de produtos por pedido
SELECT 
  AVG(quantidade) AS media_quantidade_por_pedido  -- Média da quantidade de produtos por pedido
FROM pedidos;                                     -- Diretamente da tabela de pedidos

-- Calcular a média de quantidade por produto
SELECT 
  p.nome AS produto,                                  -- Nome do produto
  AVG(pd.quantidade) AS media_quantidade              -- Média da quantidade vendida por pedido, por produto
FROM pedidos pd
JOIN produtos p ON pd.produto_id = p.id               -- Junta pedido com produto
GROUP BY p.nome                                       -- Agrupa por produto
ORDER BY media_quantidade DESC;                       -- Ordena do mais vendido por pedido

-- 19. Listar os pedidos ordenados por data (mais recentes primeiro)
SELECT 
  p.nome AS nome_do_produto,              -- Nome do produto do pedido
  pd.id AS pedido,                        -- ID do pedido
  pd.data_pedido AS data_mais_recente     -- Data em que o pedido foi feito
FROM pedidos pd                           -- Tabela de pedidos
JOIN produtos p ON p.id = pd.produto_id   -- Junta com a tabela de produtos pelo ID
ORDER BY pd.data_pedido DESC;             -- Ordena da data mais recente para a mais antiga


SELECT pedidos.data_pedido AS data,   -- Seleciona a data do pedido e dá o apelido "data"
		pedidos.id AS pedido_id        -- Seleciona o ID do pedido e chama de "pedido_id"
FROM 	pedidos                        -- A partir da tabela de pedidos
ORDER BY data DESC;                     -- Ordena pela data (mais recente primeiro)

-- 20. Contar quantos clientes possuem telefone cadastrado
SELECT COUNT(telefone) AS clientes_com_telefone
FROM clientes;

SELECT COUNT(*) AS total_clientes_com_telefone
FROM clientes
WHERE telefone IS NOT NULL;

-- 21. Encontrar o cliente que gastou mais dinheiro em pedidos
SELECT 
  c.nome AS cliente,                                  -- Nome do cliente
  SUM(p.quantidade * pr.preco) AS total_gasto         -- Total gasto = quantidade x preço do produto
FROM clientes c                                       -- Tabela de clientes
JOIN pedidos p ON c.id = p.cliente_id                -- Liga clientes aos pedidos
JOIN produtos pr ON p.produto_id = pr.id             -- Liga pedidos aos produtos (pra pegar o preço)
GROUP BY c.nome                                       -- Agrupa por cliente
ORDER BY total_gasto DESC                            -- Ordena do maior gasto para o menor
LIMIT 1;                                              -- Pega só o que mais gastou


-- 22. Listar os 5 produtos mais vendidos - em preço
SELECT 
  p.nome AS produtos_mais_vendidos,                 -- Nome do produto
  SUM(p.preco * pd.quantidade) AS total_em_vendas   -- Total vendido (preço x quantidade)
FROM pedidos pd                                     -- Tabela de pedidos
JOIN produtos p ON p.id = pd.produto_id             -- Junta com produtos pelo ID
GROUP BY p.nome                                     -- Agrupa os resultados por nome do produto
ORDER BY total_em_vendas DESC                       -- Ordena do mais vendido pro menos vendido
LIMIT 5;                                            -- Mostra só os 5 primeiros
														-- em quantidade 

SELECT
	produtos.nome AS produto,                     -- Seleciona o nome do produto e renomeia como "produto"
    SUM(pedidos.quantidade) AS unidades_vendidas -- Soma todas as quantidades vendidas desse produto
FROM
	produtos                                      -- A consulta parte da tabela de produtos
LEFT JOIN
	pedidos ON pedidos.produto_id = produtos.id   -- Junta com a tabela de pedidos, associando cada pedido ao seu produto
GROUP BY
	produtos.nome                                 -- Agrupa os resultados por nome do produto
ORDER BY
	unidades_vendidas DESC                        -- Ordena os produtos pelo total de unidades vendidas (do maior pro menor)
LIMIT 5;                                          -- Mostra apenas os 5 primeiros resultados (top 5 mais vendidos)

-- 23. Listar os clientes que já fizeram pedidos e o número de pedidos de cada um

SELECT 
  c.nome AS cliente,                        -- Nome do cliente
  COUNT(pd.id) AS numero_de_pedidos         -- Quantidade de pedidos feitos
FROM clientes c                             -- Tabela de clientes
JOIN pedidos pd ON c.id = pd.cliente_id     -- Junta com pedidos usando o ID do cliente
GROUP BY c.nome                             -- Agrupa por cliente
ORDER BY numero_de_pedidos DESC;            -- (Opcional) ordena do que mais pediu pro que menos

-- 24. Encontrar a data com mais pedidos realizados
SELECT 
  data_pedido AS data_com_mais_pedidos,         -- A data do pedido
  COUNT(id) AS total_de_pedidos                 -- Total de pedidos naquela data
FROM pedidos
GROUP BY data_pedido                            -- Agrupa por data
ORDER BY total_de_pedidos DESC                  -- Ordena da data com mais pedidos para menos
LIMIT 1;                                        -- Mostra só a data com mais pedidos


-- 25.  Calcular a média de valor gasto por pedido
SELECT 
  AVG(p.quantidade * pr.preco) AS media_valor_pedido  -- Média do valor total de cada pedido
FROM pedidos p                                        -- Tabela de pedidos
JOIN produtos pr ON p.produto_id = pr.id;             -- Junta com produtos para pegar o preço

