CREATE DATABASE modulo10_triggers_eventos;
USE modulo10_triggers_eventos;

CREATE TABLE clientes (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100),
    email VARCHAR(100),
    data_cadastro DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE pedidos (
    id_pedido INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT,
    valor DECIMAL(10,2),
    data_pedido DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente)
);

CREATE TABLE log_pedidos (
    id_log INT AUTO_INCREMENT PRIMARY KEY,
    id_pedido INT,
    acao VARCHAR(50),
    data_log DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE auditoria_clientes (
    id_auditoria INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT,
    nome_antigo VARCHAR(100),
    nome_novo VARCHAR(100),
    data_alteracao DATETIME DEFAULT CURRENT_TIMESTAMP
);

DELIMITER $$

CREATE TRIGGER trg_before_insert_cliente
BEFORE INSERT ON clientes
FOR EACH ROW
BEGIN
SET NEW.nome = UPPER(NEW.nome);
END$$

CREATE TRIGGER trg_after_insert_pedido
AFTER INSERT ON pedidos
FOR EACH ROW
BEGIN
INSERT INTO log_pedidos(id_pedido, acao)
VALUES(NEW.id_pedido,'INSERT');
END$$

CREATE TRIGGER trg_after_delete_pedido
AFTER DELETE ON pedidos
FOR EACH ROW
BEGIN
INSERT INTO log_pedidos(id_pedido, acao)
VALUES(OLD.id_pedido,'DELETE');
END$$

CREATE TRIGGER trg_before_update_cliente
BEFORE UPDATE ON clientes
FOR EACH ROW
BEGIN
INSERT INTO auditoria_clientes(id_cliente,nome_antigo,nome_novo)
VALUES(OLD.id_cliente,OLD.nome,NEW.nome);
END$$

DELIMITER ;

SET GLOBAL event_scheduler = ON;

DELIMITER $$

CREATE EVENT evento_limpeza_logs
ON SCHEDULE EVERY 1 DAY
DO
BEGIN
DELETE FROM log_pedidos
WHERE data_log < NOW() - INTERVAL 30 DAY;
END$$

DELIMITER ;

INSERT INTO clientes(nome,email) VALUES
('Ana Souza','ana@email.com'),
('Carlos Lima','carlos@email.com');

INSERT INTO pedidos(id_cliente,valor) VALUES
(1,200.00),
(2,350.00);

UPDATE clientes
SET nome = 'Ana Silva'
WHERE id_cliente = 1;

DELETE FROM pedidos
WHERE id_pedido = 1;