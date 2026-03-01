-- テンプレ
-- CREATE DATABASE IF NOT EXISTS `test01`;
-- CREATE USER `test01`@`%` IDENTIFIED BY 'password';
-- GRANT ALL ON test01.* TO 'test01'@'%';

-- -----------------------------------------
-- ダンプファイルからの復元例
-- -----------------------------------------
-- CREATE DATABASE IF NOT EXISTS `{db_name}`;
-- SOURCE /docker-entrypoint-initdb.d/dump/{db_name}.sql;
