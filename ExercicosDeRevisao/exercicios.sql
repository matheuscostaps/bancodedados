use loja;

--  Contar o número total de clientes
SELECT count(*)
FROM clientes;

-- Contar o número total de pedidos

SELECT count(*)
FROM pedidos;

-- Calcular o valor total de todos os pedidos

SELECT pe.id,SUM(pe.quantidade * pr.preco)
FROM pedidos as pe
JOIN produtos as pr 
ON pe.produto_id = pr.id
GROUP BY pe.id;

SELECT pedidos.id,
SUM(pedidos.quantidade * produtos.preco)
FROM pedidos
	JOIN produtos; 

-- Calcular a média de preço dos produtos

SELECT avg(preco) as media_preco
FROM produtos;

-- Listar todos os clientes e seus pedidos

SELECT clientes.nome AS cliente,
       pedidos.id AS id_pedido,
       produtos.nome AS produto
FROM
	clientes
JOIN
	pedidos ON pedidos.cliente_id = clientes.id
JOIN
	produtos ON produtos.id = pedidos.produto_id;
    
-- Listar todos os pedidos e seus produtos, incluindo pedidos sem produtos

SELECT pedidos.id as pedido,
		produtos.nome as produto
        FROM pedidos 
        LEFT JOIN produtos ON produtos.id = pedidos.produto_id;

-- Listar os produtos mais caros primeiro

SELECT * 
FROM produtos 
ORDER BY preco DESC;

-- Listar os produtos com menor estoque

SELECT nome as produto, estoque
FROM produtos
ORDER BY estoque ASC;

-- Contar quantos pedidos foram feitos por cliente

SELECT clientes.nome as cliente, 
		count(pedidos.cliente_id) as total_pedidos
FROM clientes
LEFT JOIN pedidos ON clientes.id = pedidos.cliente_id
GROUP BY clientes.nome;

-- Contar quantos produtos diferentes foram vendidos

SELECT count(pedidos.produto_id) as qnt_pedidos
FROM pedidos; 

-- Mostrar os clientes que não realizaram pedidos

SELECT clientes.nome as clientes
FROM clientes 
LEFT JOIN pedidos ON pedidos.cliente_id = clientes.id
WHERE pedidos.id is null;

-- Mostrar os produtos que nunca foram vendidos

SELECT produtos.nome
FROM produtos 
LEFT JOIN pedidos ON pedidos.produto_id = produtos.id
WHERE pedidos.id is null;

-- Contar o número de pedidos feitos por dia

SELECT DISTINCT pedidos.data_pedido, count(data_pedido)
FROM pedidos
GROUP BY data_pedido;
