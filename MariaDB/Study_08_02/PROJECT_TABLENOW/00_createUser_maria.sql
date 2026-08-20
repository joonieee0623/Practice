--mysql -u root -p
--Enter password: 1234

drop user if exists 'team2'@'localhost';
drop database if exists tablenow_schema;

create user 'team2'@'localhost' identified by 'java';
create database tablenow_schema;

grant all privileges on tablenow_schema.* to 'team2'@'localhost';
flush privileges;

exit;