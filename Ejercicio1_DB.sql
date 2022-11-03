drop schema if exists Ejercicio1;
create schema Ejercicio1;
use Ejercicio1;

create table departamento(
	-- auto_increment: Incrementa en una unidad
    -- con valor "null" ó "default", ha de ser campo numérico
	codigo int primary key auto_increment,
    -- not null: valida un campo para que no esté vacío
    nombre varchar(100) not null,
    localizacion varchar(100) not null
);

create table empleado(
	id_e int primary key auto_increment,
    DNI char(9) not null,
    Nombre varchar(45) not null,
    tlf char(9) not null,
    salario int not null,
    departamento int,
    constraint fk_ejer1 
    foreign key (departamento)
    references departamento(codigo)
);
    
    
    
    


    
    





