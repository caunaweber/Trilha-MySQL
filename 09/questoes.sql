

DROP DATABASE IF EXISTS modulo09;
CREATE DATABASE modulo09;
USE modulo09;

CREATE TABLE clientes (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100)
);

CREATE TABLE produtos (
    id_produto INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100),
    preco DECIMAL(10,2)
);

CREATE TABLE pedidos (
    id_pedido INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT,
    data_pedido DATE,
    valor DECIMAL(10,2),
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente)
);


INSERT INTO clientes (nome) VALUES
('Ana Souza'),
('Carlos Lima'),
('Maria Silva');

INSERT INTO produtos (nome, preco) VALUES
('Notebook',3500.50),
('Mouse',80.40),
('Teclado',150.90);

INSERT INTO pedidos (id_cliente, data_pedido, valor) VALUES
(1,'2026-05-01',250.75),
(2,'2026-05-10',100.25),
(3,'2026-05-15',300.90);

SELECT CONCAT(nome,'-',id_cliente) AS identificador
FROM clientes;

SELECT SUBSTRING(nome,1,3) AS inicio_nome
FROM produtos;



SELECT UPPER(nome) AS nome_maiusculo
FROM clientes;


SELECT DATE_FORMAT(NOW(),'%d/%m/%Y %H:%i:%s') AS data_formatada;


SELECT
    id_pedido,
    DATEDIFF(CURDATE(), data_pedido) AS dias_passados
FROM pedidos;


SELECT nome, ROUND(preco,2) AS preco_arredondado
FROM produtos;

SELECT
    valor,
    FLOOR(valor) AS arredondado_baixo,
    CEIL(valor) AS arredondado_cima
FROM pedidos;


DELIMITER $$

CREATE PROCEDURE inserir_pedido(
    IN p_id_cliente INT,
    IN p_data DATE,
    IN p_valor DECIMAL(10,2)
)
BEGIN
    INSERT INTO pedidos(id_cliente, data_pedido, valor)
    VALUES(p_id_cliente, p_data, p_valor);
END $$

DELIMITER ;


CALL inserir_pedido(1,'2026-06-01',500.00);

DELIMITER $$

CREATE FUNCTION calcular_desconto(
    valor DECIMAL(10,2),
    percentual DECIMAL(5,2)
)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    RETURN valor - (valor * percentual / 100);
END $$

DELIMITER ;

SELECT
    valor,
    calcular_desconto(valor,10) AS valor_com_desconto
FROM pedidos;