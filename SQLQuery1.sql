/*
Crear una base de datos llamada UniversidadDB la cual maneja dos modulos: Academico y seguridad
Modulo academico: Carrera y Estudiante
Modulo seguridad: Cargo y Usuario
*/
use master
go
if exists(select * from sys.databases where name = 'UniversidadDB')
begin
	drop database UniversidadDB
end
go
create database UniversidadDB
go
use UniversidadDB
go
--Schema: Es un contenedor logico que sirve para organizar objetos dentro de una base de datos.
create schema Academico
go
create schema Seguridad
go
create table Academico.Carrera(
	id int primary key identity(1,1),
	nombre nvarchar(100) not null,
	precio decimal(10,2),
	created_at datetime default getdate(),
	updated_at datetime null,
	deleted_at datetime null
)
go
create table Academico.Estudiante(
	id int identity(1,1) primary key
	, cif varchar(8) unique not null
	, nombres nvarchar(60) not null
	, apellidos nvarchar(60) not null
	, fechaNac datetime null
	, email nvarchar(120) null
	, idCarrera int foreign key references Academico.carrera(id)
)
go

create table Seguridad.Cargo(
	id int identity(1,1) primary key
	, nombre nvarchar,
	created_at datetime default getdate(),
	updated_at datetime null,
	deleted_at datetime null
)go

create table Seguridad.Usuario(
	idUsuario int identity(1,1) primary key,
	cif varchar(8) unique not null
	, nombres nvarchar(60) not null
	, apellidos nvarchar(60) not null
	, fechaNac datetime null
	, password nvarchar(60) not null
	, email nvarchar(120) null,
	created_at datetime default getdate(),
	updated_at datetime null,
	deleted_at datetime null
)
go
