CREATE USER 'usuario_local'@'localhost' IDENTIFIED BY 'SenhaFraca123';

CREATE USER 'usuario_remoto'@'%' IDENTIFIED BY 'SenhaFraca123';

ALTER USER 'usuario_local'@'localhost'
IDENTIFIED BY 'Senha$F0rte!2026';

DROP USER 'usuario_remoto'@'%';

CREATE USER 'admin_user'@'%' IDENTIFIED BY 'Senha$F0rte!2026';

GRANT SELECT ON loja.clientes
TO 'usuario_local'@'localhost';

GRANT ALL PRIVILEGES ON loja.*
TO 'admin_user'@'%';

REVOKE SELECT ON loja.clientes
FROM 'usuario_local'@'localhost';

CREATE USER 'usuario_servidor'@'localhost'
IDENTIFIED BY 'Senha$F0rte!2026';

CREATE USER 'relatorio_user'@'localhost'
IDENTIFIED BY 'Senha$F0rte!2026';

GRANT SELECT ON loja.relatorios
TO 'relatorio_user'@'localhost';

SELECT user, host FROM mysql.user;

SHOW GRANTS FOR 'usuario_local'@'localhost';

FLUSH PRIVILEGES;