-- 1. Contar o número total de clientes

SELECT COUNT(*) 
FROM clientes;

-- não conta os nulos 

SELECT COUNT(id)
FROM clientes;

-- 2 Contar o número total de pedidos

SELECT COUNT(*) as total_de_pedidos
FROM pedidos;

SELECT COUNT(produto_id) as total_semnulos
FROM pedidos;

-- 3 Calcular o valor total de todos os pedidos
SELECT sum(quantidade) as total_pedidos
FROM pedidos;

--  4 Calcular a média de preço dos produtos

SELECT avg(preco) as media_preco_produtos
FROM produtos;

-- 5. Listar todos os clientes e seus pedidos

SELECT c.nome AS cliente, p.id AS pedido
FROM Clientes c
JOIN Pedidos p ON c.id = p.cliente_id;

-- 6. Listar todos os pedidos e seus produtos, incluindo pedidos sem produtos

SELECT pd.id AS pedido, p.nome AS produto
FROM pedidos pd
LEFT JOIN produtos p ON pd.produto_id = p.id;

-- 7.Listar os produtos mais caros primeiro

SELECT * 
FROM produtos 
ORDER BY preco DESC;

-- 8 Listar os produtos com menor estoque

SELECT *
FROM produtos
order by estoque ASC

-- 9 -- Contar quantos pedidos foram feitos por cliente 

SELECT cliente_id, COUNT(id) AS total_pedidos
FROM pedidos
WHERE cliente_id IS NOT NULL  -- Para ignorar pedidos sem cliente associado
GROUP BY cliente_id
ORDER BY total_pedidos DESC;  -- Ordena do maior para o menor




SELECT c.*, p.* 
FROM clientes c
JOIN pedidos p ON c.id_cliente = p.id_cliente;


SELECT *
FROM produtos

SELECT *
FROM pedidos;

SELECT *
FROM clientes