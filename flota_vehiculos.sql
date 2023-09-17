drop schema if exists flota_vehiculos cascade;

create schema flota_vehiculos;

create table flota_vehiculos.grupo_empresarial(
id serial primary key,
nombre varchar (20) not null,
unique (nombre));

create table flota_vehiculos.marca_coches(
id serial primary key,
nombre varchar (20) not null,
grupo_empresarial_id int not null,
unique (nombre),
constraint fk_grupo_empresarial_id foreign key (grupo_empresarial_id) references flota_vehiculos.grupo_empresarial (id)); 

create table flota_vehiculos.modelo_coches(
id serial primary key,
nombre varchar (20) not null,
marca_id int not null,
constraint fk_marca_id foreign key (marca_id) references flota_vehiculos.marca_coches (id));

create table flota_vehiculos.seguros(
id serial primary key,
nombre_compañia varchar (20) not null,
numero_poliza varchar (50) not null);

create table flota_vehiculos.coches(
id serial primary key,
color varchar (20) not null,
matricula varchar (20) not null,
km_totales int not null,
fecha_compra date not null,
seguro_id int not null,
modelo_id int not null,
constraint fk_seguro_id foreign key (seguro_id) references flota_vehiculos.seguros (id),
constraint fk_modelo_id foreign key (modelo_id) references flota_vehiculos.modelo_coches (id));

create table flota_vehiculos.revisiones(
id serial primary key,
coche_id int not null,
km_revision int not null,
fecha date not null,
importe_revision int not null,
moneda varchar (3) not null,
constraint fk_coche_id foreign key (coche_id) references flota_vehiculos.coches (id));

insert into flota_vehiculos.grupo_empresarial (nombre) values ('grupo vw');
insert into flota_vehiculos.grupo_empresarial (nombre) values ('psa');
insert into flota_vehiculos.grupo_empresarial (nombre) values ('general motors');
insert into flota_vehiculos.grupo_empresarial (nombre) values ('grupo bmw');

insert into flota_vehiculos.marca_coches (nombre, grupo_empresarial_id) values ('audi', 1);
insert into flota_vehiculos.marca_coches (nombre, grupo_empresarial_id) values ('peugeot', 2);
insert into flota_vehiculos.marca_coches (nombre, grupo_empresarial_id) values ('citroen', 2);
insert into flota_vehiculos.marca_coches (nombre, grupo_empresarial_id) values ('skoda', 1);

insert into flota_vehiculos.modelo_coches (nombre, marca_id) values ('A3', 1);
insert into flota_vehiculos.modelo_coches (nombre, marca_id) values ('207', 2);
insert into flota_vehiculos.modelo_coches (nombre, marca_id) values ('C5', 3);
insert into flota_vehiculos.modelo_coches (nombre, marca_id) values ('octavia', 4);

insert into flota_vehiculos.seguros (nombre_compañia, numero_poliza) values ('mapfre', '23899A45');
insert into flota_vehiculos.seguros (nombre_compañia, numero_poliza) values ('mutua madrileña', '24893D45');
insert into flota_vehiculos.seguros (nombre_compañia, numero_poliza) values ('linea directa', '23899C40');
insert into flota_vehiculos.seguros (nombre_compañia, numero_poliza) values ('axa', '233929A45');

insert into flota_vehiculos.coches (color, matricula, km_totales, fecha_compra, seguro_id, modelo_id) values ('blanco', '2445GHJ', '45678', '2011-08-20', 2, 2);
insert into flota_vehiculos.coches (color, matricula, km_totales, fecha_compra, seguro_id, modelo_id) values ('rojo', '4543JKJ', '35600', '2016-07-11', 1, 1);
insert into flota_vehiculos.coches (color, matricula, km_totales, fecha_compra, seguro_id, modelo_id) values ('gris', '2005KKL', '65678', '2018-10-05', 4, 3);
insert into flota_vehiculos.coches (color, matricula, km_totales, fecha_compra, seguro_id, modelo_id) values ('blanco', '2445LPF', '25678', '2021-03-22', 3, 4);

insert into flota_vehiculos.revisiones (coche_id, km_revision, fecha, importe_revision, moneda) values (1, '11029', '2022-02-12', '120', 'EUR');
insert into flota_vehiculos.revisiones (coche_id, km_revision, fecha, importe_revision, moneda) values (2, '23029', '2021-07-16', '150', 'USD');
insert into flota_vehiculos.revisiones (coche_id, km_revision, fecha, importe_revision, moneda) values (3, '10289', '2023-03-21', '1500', 'USD');
insert into flota_vehiculos.revisiones (coche_id, km_revision, fecha, importe_revision, moneda) values (4, '09002', '2023-07-02', '135', 'EUR');


select c.id, mc.nombre as modelo, m.nombre as marca, ge.nombre as grupo_empresarial, c.fecha_compra, c.matricula, c.color , c.km_totales, s.nombre_compañia, s.numero_poliza  from flota_vehiculos.coches as c
inner join flota_vehiculos.modelo_coches as mc on c.modelo_id  = mc.id
inner join flota_vehiculos.marca_coches as m on mc.marca_id = m.id
inner join flota_vehiculos.grupo_empresarial as ge on m.grupo_empresarial_id = ge.id
inner join flota_vehiculos.seguros as s on c.seguro_id = s.id;

/* query para obtener la revision de coche por id
select coche_id, km_revision, fecha, importe_revision, moneda from flota_vehiculos.revisiones
where coche_id = 1;
*/