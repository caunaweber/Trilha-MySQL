CREATE DATABASE sistema_vendas;
USE sistema_vendas;

CREATE TABLE clientes (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    telefone VARCHAR(20)
);

CREATE TABLE produtos (
    id_produto INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    preco DECIMAL(10,2) NOT NULL,
    estoque INT NOT NULL
);

CREATE TABLE pedidos (
    id_pedido INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT,
    data_pedido DATE,
    FOREIGN KEY (id_cliente)
        REFERENCES clientes(id_cliente)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE pedido_produto (
    id_pedido INT,
    id_produto INT,
    quantidade INT NOT NULL,
    PRIMARY KEY (id_pedido, id_produto),
    FOREIGN KEY (id_pedido)
        REFERENCES pedidos(id_pedido)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (id_produto)
        REFERENCES produtos(id_produto)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

INSERT INTO clientes (nome,email,telefone) VALUES
('Ana Souza','ana@email.com','47999990001'),
('Carlos Lima','carlos@email.com','47999990002'),
('Maria Silva','maria@email.com','47999990003');

INSERT INTO produtos (nome,preco,estoque) VALUES
('Notebook',3500.00,10),
('Mouse',80.00,50),
('Teclado',150.00,40),
('Monitor',1200.00,15);

INSERT INTO pedidos (id_cliente,data_pedido) VALUES
(1,'2026-05-01'),
(2,'2026-05-02');

INSERT INTO pedido_produto VALUES
(1,1,1),
(1,2,2),
(2,3,1);

SELECT
    p.id_pedido,
    c.nome AS cliente,
    p.data_pedido,
    pr.nome AS produto,
    pp.quantidade
FROM pedidos p
JOIN clientes c ON p.id_cliente = c.id_cliente
JOIN pedido_produto pp ON p.id_pedido = pp.id_pedido
JOIN produtos pr ON pp.id_produto = pr.id_produto;

SELECT nome
FROM produtos
WHERE id_produto IN (
    SELECT id_produto
    FROM pedido_produto
    GROUP BY id_produto
    ORDER BY SUM(quantidade) DESC
);

DELIMITER $$

CREATE PROCEDURE registrar_pedido(
    IN p_cliente INT,
    IN p_produto INT,
    IN p_quantidade INT
)
BEGIN
    DECLARE estoque_atual INT;
    DECLARE novo_pedido INT;

    START TRANSACTION;

    SELECT estoque INTO estoque_atual
    FROM produtos
    WHERE id_produto = p_produto;

    IF estoque_atual >= p_quantidade THEN

        INSERT INTO pedidos(id_cliente,data_pedido)
        VALUES(p_cliente,CURDATE());

        SET novo_pedido = LAST_INSERT_ID();

        INSERT INTO pedido_produto
        VALUES(novo_pedido,p_produto,p_quantidade);

        UPDATE produtos
        SET estoque = estoque - p_quantidade
        WHERE id_produto = p_produto;

        COMMIT;

    ELSE
        ROLLBACK;
    END IF;

END$$

DELIMITER ;

CREATE INDEX idx_cliente ON pedidos(id_cliente);
CREATE INDEX idx_produto ON pedido_produto(id_produto);
CREATE INDEX idx_pedido ON pedido_produto(id_pedido);

EXPLAIN
SELECT
    c.nome,
    pr.nome,
    pp.quantidade
FROM pedidos p
JOIN clientes c ON p.id_cliente = c.id_cliente
JOIN pedido_produto pp ON p.id_pedido = pp.id_pedido
JOIN produtos pr ON pp.id_produto = pr.id_produto;