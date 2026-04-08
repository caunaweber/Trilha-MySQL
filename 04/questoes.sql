CREATE TABLE clientes (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100),
    email VARCHAR(100)
);

CREATE TABLE pedidos (
    id_pedido INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT,
    valor_total DECIMAL(10,2),

    FOREIGN KEY (id_cliente)
        REFERENCES clientes(id_cliente)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

INSERT INTO clientes (nome, email) VALUES
('Cliente 1','c1@email.com'),
('Cliente 2','c2@email.com'),
('Cliente 3','c3@email.com'),
('Cliente 4','c4@email.com'),
('Cliente 5','c5@email.com'),
('Cliente 6','c6@email.com'),
('Cliente 7','c7@email.com'),
('Cliente 8','c8@email.com'),
('Cliente 9','c9@email.com'),
('Cliente 10','c10@email.com');

INSERT INTO pedidos (id_cliente, valor_total) VALUES
(1,100),(1,200),(2,150),(3,300),(4,50),
(5,120),(6,500),(7,220),(8,80),(9,90);

SELECT *
FROM pedidos
WHERE id_cliente = 1;

CREATE TABLE produtos (
    id_produto INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100),
    preco DECIMAL(10,2)
);

INSERT INTO produtos (nome, preco) VALUES
('Notebook',3000),
('Mouse',100),
('Teclado',150);

CREATE TABLE pedido_produto (
    id_pedido INT,
    id_produto INT,
    quantidade INT,

    PRIMARY KEY (id_pedido, id_produto),

    FOREIGN KEY (id_pedido)
        REFERENCES pedidos(id_pedido)
        ON DELETE CASCADE,

    FOREIGN KEY (id_produto)
        REFERENCES produtos(id_produto)
);

SELECT p.id_pedido, pr.nome, p.quantidade
FROM pedido_produto p
JOIN produtos pr
ON p.id_produto = pr.id_produto
WHERE p.id_pedido = 1;

SELECT
    c.nome AS cliente,
    pr.nome AS produto,
    pp.quantidade
FROM clientes c
JOIN pedidos pe ON c.id_cliente = pe.id_cliente
JOIN pedido_produto pp ON pe.id_pedido = pp.id_pedido
JOIN produtos pr ON pp.id_produto = pr.id_produto;

DELETE FROM clientes
WHERE id_cliente = 1;
SELECT * FROM pedidos;

CREATE TABLE detalhes_cliente (
    id_cliente INT PRIMARY KEY,
    cpf VARCHAR(14),

    FOREIGN KEY (id_cliente)
        REFERENCES clientes(id_cliente)
);

SELECT pe.id_pedido
FROM pedidos pe
JOIN pedido_produto pp ON pe.id_pedido = pp.id_pedido
JOIN produtos pr ON pp.id_produto = pr.id_produto
WHERE pr.nome = 'Notebook';