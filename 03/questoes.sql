CREATE TABLE funcionarios (
    id_funcionario INT PRIMARY KEY,
    nome VARCHAR(100),
    email VARCHAR(100),
    cargo VARCHAR(50)
);

INSERT INTO funcionarios (id_funcionario, nome, email, cargo) VALUES
(1, 'João Silva', 'joao@email.com', 'Analista'),
(2, 'Maria Souza', 'maria@email.com', 'Gerente'),
(3, 'Carlos Lima', 'carlos@email.com', 'Analista');

INSERT INTO funcionarios (id_funcionario, nome, email, cargo) VALUES
(4, 'Ana Oliveira', 'ana@email.com', 'RH'),
(5, 'Pedro Santos', 'pedro@email.com', 'Analista'),
(6, 'Lucas Costa', 'lucas@email.com', 'Desenvolvedor'),
(7, 'Fernanda Alves', 'fernanda@email.com', 'Gerente'),
(8, 'Bruno Rocha', 'bruno@email.com', 'Analista');

ALTER TABLE funcionarios
ADD cidade VARCHAR(100) DEFAULT 'Não Informado';

SELECT * FROM funcionarios
WHERE cargo = 'Analista';

SELECT * FROM funcionarios
ORDER BY nome ASC;

SELECT * FROM funcionarios
LIMIT 3;

SELECT DISTINCT cidade FROM funcionarios;

SELECT cargo, COUNT(*) AS total_funcionarios
FROM funcionarios
GROUP BY cargo;

UPDATE funcionarios
SET cargo = 'Coordenador'
WHERE nome LIKE 'João%';

DELETE FROM funcionarios
WHERE cargo = 'Analista';