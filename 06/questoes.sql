CREATE TABLE clientes (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100),
    email VARCHAR(100),
    cidade VARCHAR(100)
);

-- =========================
-- TABELA PEDIDOS
-- =========================
CREATE TABLE pedidos (
    id_pedido INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT,
    data_pedido DATE,
    valor DECIMAL(10,2),
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente)
);

-- =========================
-- TABELA PRODUTOS
-- =========================
CREATE TABLE produtos (
    id_produto INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100),
    categoria VARCHAR(100),
    preco DECIMAL(10,2)
);

-- =========================
-- DADOS DE TESTE
-- =========================

INSERT INTO clientes (nome, email, cidade) VALUES
('Ana Souza','ana@email.com','Joinville'),
('Carlos Lima','carlos@email.com','Blumenau'),
('Maria Silva','maria@email.com','Joinville'),
('Pedro Alves','pedro@email.com','Curitiba'),
('Juliana Costa','juliana@email.com','Florianopolis'),
('Lucas Rocha','lucas@email.com','Joinville');

INSERT INTO pedidos (id_cliente, data_pedido, valor) VALUES
(1,'2026-01-10',250.00),
(2,'2026-02-05',100.00),
(1,'2026-02-15',300.00),
(3,'2026-03-01',150.00),
(5,'2026-03-10',500.00);

INSERT INTO produtos (nome, categoria, preco) VALUES
('Notebook','Eletronicos',3500.00),
('Mouse','Eletronicos',80.00),
('Teclado','Eletronicos',150.00),
('Cadeira','Moveis',900.00),
('Mesa','Moveis',1200.00);

CREATE INDEX idx_nome_cliente
ON clientes(nome);

CREATE UNIQUE INDEX idx_email_unico
ON clientes(email);

CREATE INDEX idx_nome_cidade
ON clientes(nome, cidade);

EXPLAIN
SELECT c.nome, p.valor
FROM clientes c
JOIN pedidos p
ON c.id_cliente = p.id_cliente;

CREATE INDEX idx_pedidos_cliente
ON pedidos(id_cliente);
EXPLAIN
SELECT c.nome, p.valor
FROM clientes c
JOIN pedidos p
ON c.id_cliente = p.id_cliente;

EXPLAIN
SELECT * FROM clientes
WHERE nome = 'Ana Souza';

CREATE INDEX idx_nome_busca
ON clientes(nome);

EXPLAIN
SELECT * FROM clientes
WHERE nome = 'Ana Souza';

SELECT *
FROM clientes
ORDER BY nome
LIMIT 5;

SELECT *
FROM clientes
WHERE nome = 'Ana Souza';

CREATE INDEX idx_categoria
ON produtos(categoria);

CREATE INDEX idx_preco
ON produtos(preco);

SELECT * FROM produtos
WHERE categoria = 'Eletronicos'
AND preco < 500;

EXPLAIN
SELECT c.nome, SUM(p.valor)
FROM clientes c
JOIN pedidos p ON c.id_cliente = p.id_cliente
GROUP BY c.nome;

CREATE INDEX idx_fk_cliente
ON pedidos(id_cliente);