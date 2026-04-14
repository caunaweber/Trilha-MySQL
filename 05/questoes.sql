CREATE TABLE clientes (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100)
);

CREATE TABLE pedidos (
    id_pedido INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT,
    valor_total DECIMAL(10,2),

    FOREIGN KEY (id_cliente)
        REFERENCES clientes(id_cliente)
);

INSERT INTO clientes (nome) VALUES
('João Silva'),
('Maria Souza'),
('Ana Oliveira'),
('Carlos Pereira'),
('Fernanda Lima');

INSERT INTO pedidos (id_cliente, valor_total) VALUES
(1,150.00),
(1,300.00),
(2,200.00),
(2,50.00),
(4,400.00);

SELECT c.nome, p.valor_total
FROM clientes c
INNER JOIN pedidos p
ON c.id_cliente = p.id_cliente;

SELECT c.nome, p.valor_total
FROM clientes c
LEFT JOIN pedidos p
ON c.id_cliente = p.id_cliente;

SELECT c.nome, p.valor_total
FROM clientes c
RIGHT JOIN pedidos p
ON c.id_cliente = p.id_cliente;

SELECT c.nome, p.valor_total
FROM clientes c
LEFT JOIN pedidos p
ON c.id_cliente = p.id_cliente

UNION

SELECT c.nome, p.valor_total
FROM clientes c
RIGHT JOIN pedidos p
ON c.id_cliente = p.id_cliente;

SELECT nome
FROM clientes
WHERE id_cliente = (
    SELECT id_cliente
    FROM pedidos
    ORDER BY valor_total DESC
    LIMIT 1
);

INSERT INTO pedidos (id_cliente, valor_total)
VALUES (
    (
        SELECT id_cliente
        FROM pedidos
        ORDER BY valor_total DESC
        LIMIT 1
    ),
    500
);

SELECT
    c.nome,
    (
        SELECT SUM(p.valor_total)
        FROM pedidos p
        WHERE p.id_cliente = c.id_cliente
    ) AS total_pedidos
FROM clientes c;

SELECT COUNT(*) AS total_pedidos
FROM pedidos;

SELECT
    c.nome,
    SUM(p.valor_total) AS total_vendas
FROM clientes c
JOIN pedidos p
ON c.id_cliente = p.id_cliente
GROUP BY c.nome;

SELECT
    c.nome,
    SUM(p.valor_total) AS total_vendas
FROM clientes c
JOIN pedidos p
ON c.id_cliente = p.id_cliente
GROUP BY c.nome
HAVING total_vendas > 200;