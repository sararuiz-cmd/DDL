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
	deleted_at datetime null,
	Constraint ck_carrera check (precio>0)
)
go
create table Academico.Estudiante(
	id int identity(1,1) primary key
	, cif varchar(8) unique not null
	, nombres nvarchar(60) not null
	, apellidos nvarchar(60) not null
	, fechaNac datetime null
	, email nvarchar(120) null
	, idCarrera int 
	constraint uq_email unique(email),
	constraint ck_email check(email like '%_@_%'),
	constraint fk_id foreign key (id) references Academico.carrera(id)
	
	
)
go

create table Seguridad.Cargo(
	id int identity(1,1) primary key
	, nombre nvarchar not null,
	created_at datetime default getdate(),
	updated_at datetime null,
	deleted_at datetime null
)
go

create table Seguridad.Usuario(
	idUsuario int identity(1,1) primary key,
	cif varchar(8) unique not null
	, nombres nvarchar(60) not null
	, apellidos nvarchar(60) not null
	, fechaNac datetime null
	, pw varbinary(64) not null
	, email nvarchar(120) null,
	created_at datetime default getdate(),
	updated_at datetime null,
	deleted_at datetime null
)
go

--Insert
insert into Academico.Carrera(nombre,precio)
values('Sistemas',2000)
update Academico.Carrera set precio=2000.99, updated_at=GETDATE() where id=1
insert into Seguridad.Usuario(cif,nombres,apellidos,pw)values('401','Juan','Lopez',HASHBYTES('Sha2_256','Temp2026'))
select * from Seguridad.Usuario