CREATE TABLE produtos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    preco DECIMAL(10,2) NOT NULL,
    quantidade_estoque INT NOT NULL,
    data_cadastro DATE
);

ALTER TABLE produtos
ADD descricao VARCHAR(255);

ALTER TABLE produtos
MODIFY preco DECIMAL(8,2);

ALTER TABLE produtos
DROP COLUMN quantidade_estoque;

DROP TABLE produtos;