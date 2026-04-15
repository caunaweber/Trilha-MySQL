mysqldump -u root -p biblioteca > biblioteca_backup.sql
mysqldump -u root -p biblioteca livros autores > biblioteca_tabelas_backup.sql
mysqldump -u root -p --all-databases > backup_total.sql

log-bin=mysql-bin
mysqlbinlog mysql-bin.000001 > incremental.sql

mysql -u root -p biblioteca < biblioteca_backup.sql
mysql -u root -p < backup_total.sql

SELECT * FROM clientes
INTO OUTFILE '/var/lib/mysql-files/clientes.csv'
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n';

LOAD DATA INFILE '/var/lib/mysql-files/clientes.csv'
INTO TABLE clientes
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n';

0 2 * * * mysqldump -u root -p biblioteca > /backups/backup_$(date +\%F).sql

# Criar banco de teste
mysql -u root -p -e "CREATE DATABASE biblioteca_teste;"

# Restaurar backup
mysql -u root -p biblioteca_teste < biblioteca_backup.sql