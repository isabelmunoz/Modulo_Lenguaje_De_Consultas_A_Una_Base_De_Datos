create database primerabd character set utf8;
use primerabd;

create table primeraTabla(
	idtabla int auto_increment,
    nombre varchar(30),
    apellidoP varchar(30),
    fechaNacimiento date,
    primary key(idtabla)
);

create table segundaTabla(
    idtabla int auto_increment,
    tipoCliente varchar(10),
    añosAntiguedad int,
    tipoTarjeta varchar(10),
    primary key(idtabla)
);
create table terceraTabla(
    idtabla int auto_increment,
    direccionCliente varchar(20),
    numero int,
    comuna varchar(15),
    primary key(idtabla)
);
create table cuartaTabla(
    idtabla int auto_increment,
    totalCompra int,
    resumenCompra varchar(30),
    tiendaCompra varchar(20),
    primary key(idtabla)
);