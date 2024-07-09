create table personas(
	id_persona serial primary key,
	nombre varchar(30) not null,
	apellido_paterno varchar(50) not null,
	apellidp_materno varchar(50) not null,
	fecha_nacimiento date not null,
	email varchar(100) not null,
	telefono integer,
	esatdo varchar(50) not null,
	delegacion_municipio varchar(50) not null,
	pais varchar(50) not null,
	codigo_postal integer not null,
	calle varchar(50) not null,
	num_interior integer,
	numm_ext integer,
	colonia varchar(50) not null
);
ALTER TABLE personas RENAME COLUMN apellidp_materno TO apellido_materno;
ALTER TABLE personas RENAME COLUMN numm_ext TO num_ext;
ALTER TABLE personas RENAME COLUMN esatdo TO estado;
alter table personas drop column telefono;
alter table personas add column telefono varchar(10);

create table clientes(
	id_cliente serial primary key,
	identificacion varchar(40) not null,
	id_persona integer not null
); 

alter table clientes add constraint "fk_clientes_personas" 
	foreign key (id_persona) references personas(id_persona);
	
create table sucursal(
	id_sucursal serial primary key,
	nombre_sucursal varchar(50) not null,
	estado_sucursal varchar(50) not null,
	pais varchar(50)  not null,
	delegacion_municipio varchar(50) not null,
	direccion varchar(50) not null,
	telefono integer not null
);
alter table sucursal drop column telefono;
alter table sucursal add column telefono varchar(10);


create table empleados(
	id_empleado serial primary key,
	id_persona integer not null,
	id_sucursal integer not null,
	puesto varchar(50) not null
);


alter table empleados add constraint "fk_empleado_personas" 
	foreign key (id_persona) references personas(id_persona);

alter table empleados add constraint "fk_empleado_sucursal" 
	foreign key (id_sucursal) references sucursal(id_sucursal);


create type estado as enum ('Operativo','Fuera de servicio');

create table cajeros(
	id_cajero serial primary key,
	id_sucursal integer not null,
	estado_cajero estado not null
); 


alter table cajeros add constraint "fk_cajeros_sucursal" 
	foreign key (id_sucursal) references sucursal(id_sucursal);

create type escuenta as enum ('Activa','inactiva','Bloqueda',
							 'Congelada','Cerrada','Suspendida',
							 'sobregirada', 'En revision','Proceso de cierre');

create table cuentas(
	id_cuenta serial primary key,
	codigo_pais varchar(2) not null,
	digito_control integer not null,
	numero_cuenta integer not null,
	saldo money,
	estado_de_ceunta escuenta not null,
	id_cliente integer not null
);

alter table cuentas add constraint "fk_cuenta_clientes" 
	foreign key (id_cliente) references clientes(id_cliente);

create table transacciones(
	id_transaccion serial primary key,
	id_cuenta integer not null,
	tipo varchar(20) not null,
	monto money not null,
	fecha date not null,
	concepto varchar(50)
);

alter table transacciones add constraint "fk_transacciones_cuenta" 
	foreign key (id_cuenta) references cuentas(id_cuenta);


create type estado_tarjeta as enum ('Activa','Bloqueda','Suspendida',
									'Caducada','Robada','Cancelada',
								   'Inactiva','Congelada','Rechazada');

create table tarjeta(
	numero_tarjeta integer unique primary key,
	Fecha_emision date not null,
	fecha_expiracion date not null,
	estado estado_tarjeta not null,
	tipo varchar(50) not null,
	id_cuenta integer not null
);
ALTER TABLE tarjeta
    ALTER COLUMN numero_tarjeta TYPE varchar(20);

alter table tarjeta add constraint "fk_tarjeta_cuenta" 
	foreign key (id_cuenta) references cuentas(id_cuenta);


create type estado_prestamo as enum ('Solicitado','Aprobado','Desembolsado',
									'Activo','Gracia','Vencido','En cobranza',
									'Reestructurado','Liquilado','Perdonado',
									'Incobrable');

create table prestamos(
	id_prestamo serial primary key,
	monto money not null,
	intereses decimal not null,
	fecha_inicio date not null,
	fecha_vencimiento date not null,
	estado estado_prestamo not null,
	id_cliente integer not null
);
	

alter table prestamos add constraint "fk_prestamos_clientes" 
	foreign key (id_cliente) references clientes(id_cliente);
	
create table pagos(
	id_pago serial primary key,
	id_prestamo integer not null,
	fecha_pago date,
	monto money
);


alter table pagos add constraint "fk_pagos_prestamo" 
	foreign key (id_prestamo) references prestamos(id_prestamo);


/*--------------------------------------------------------------------------------------------------------------------------*/

-- personas

INSERT INTO personas (nombre, apellido_paterno, apellido_materno, fecha_nacimiento, email, telefono, estado, delegacion_municipio, pais, codigo_postal, calle, num_interior, num_ext, colonia) VALUES
('Fernanda', 'Cervantes', 'Soto', '1986-09-05', 'fernanda.cervantes@example.com', '5554523456', 'CDMX', 'Azcapotzalco', 'Mexico', 51023, 'Calle Principal', 81, 441, 'Zona Norte'),
('Juan', 'Perez', 'Lopez', '1980-01-15', 'juan.perez@example.com', '5551234567', 'CDMX', 'Cuauhtemoc', 'Mexico', 12345, 'Av. Reforma', 101, 20, 'Centro'),
('Maria', 'Garcia', 'Martinez', '1985-02-20', 'maria.garcia@example.com', '5552345678', 'CDMX', 'Benito Juarez', 'Mexico', 54321, 'Calle Insurgentes', 202, 30, 'Norte'),
('Luis', 'Hernandez', 'Sanchez', '1990-03-25', 'luis.hernandez@example.com', '5553456789', 'CDMX', 'Miguel Hidalgo', 'Mexico', 67890, 'Calle Juarez', 303, 40, 'Sur'),
('Ana', 'Martinez', 'Ramirez', '1995-04-30', 'ana.martinez@example.com', '5554567890', 'CDMX', 'Iztapalapa', 'Mexico', 98765, 'Av. Morelos', 404, 50, 'Este'),
('Carlos', 'Lopez', 'Gonzalez', '2000-05-10', 'carlos.lopez@example.com', '5555678901', 'CDMX', 'Tlalpan', 'Mexico', 87654, 'Calle Hidalgo', 505, 60, 'Oeste'),
('Laura', 'Sanchez', 'Flores', '1975-06-15', 'laura.sanchez@example.com', '5556789012', 'CDMX', 'Coyoacan', 'Mexico', 76543, 'Av. Independencia', 606, 70, 'Centro'),
('Jorge', 'Ramirez', 'Perez', '1982-07-20', 'jorge.ramirez@example.com', '5557890123', 'CDMX', 'Alvaro Obregon', 'Mexico', 65432, 'Calle Zaragoza', 707, 80, 'Norte'),
('Marta', 'Gonzalez', 'Hernandez', '1988-08-25', 'marta.gonzalez@example.com', '5558901234', 'CDMX', 'Azcapotzalco', 'Mexico', 54321, 'Av. Revolucion', 808, 90, 'Sur'),
('Pedro', 'Flores', 'Martinez', '1978-09-30', 'pedro.flores@example.com', '5559012345', 'CDMX', 'Venustiano Carranza', 'Mexico', 43210, 'Calle Madero', 909, 100, 'Este'),
('Sofia', 'Rodriguez', 'Garcia', '1983-10-15', 'sofia.rodriguez@example.com', '5550123456', 'CDMX', 'Gustavo A. Madero', 'Mexico', 32109, 'Av. Juarez', 1010, 110, 'Oeste'),
('Raul', 'Martinez', 'Lopez', '1991-11-20', 'raul.martinez@example.com', '5551234567', 'CDMX', 'Iztacalco', 'Mexico', 21098, 'Calle Allende', 1111, 120, 'Centro'),
('Carmen', 'Perez', 'Gomez', '1986-12-25', 'carmen.perez@example.com', '5552345678', 'CDMX', 'Magdalena Contreras', 'Mexico', 10987, 'Av. Hidalgo', 1212, 130, 'Norte'),
('Diego', 'Lopez', 'Sanchez', '1992-01-10', 'diego.lopez@example.com', '5553456789', 'CDMX', 'Milpa Alta', 'Mexico', 98765, 'Calle Juarez', 1313, 140, 'Sur'),
('Paula', 'Gomez', 'Ramirez', '1979-02-15', 'paula.gomez@example.com', '5554567890', 'CDMX', 'Tlahuac', 'Mexico', 87654, 'Av. Morelos', 1414, 150, 'Este'),
('Jose', 'Hernandez', 'Perez', '1984-03-20', 'jose.hernandez@example.com', '5555678901', 'CDMX', 'Xochimilco', 'Mexico', 76543, 'Calle Insurgentes', 1515, 160, 'Oeste'),
('Elena', 'Ramirez', 'Lopez', '1990-04-25', 'elena.ramirez@example.com', '5556789012', 'CDMX', 'Cuajimalpa', 'Mexico', 65432, 'Av. Reforma', 1616, 170, 'Centro'),
('Sergio', 'Martinez', 'Garcia', '1995-05-30', 'sergio.martinez@example.com', '5557890123', 'CDMX', 'Iztapalapa', 'Mexico', 54321, 'Calle Madero', 1717, 180, 'Norte'),
('Adriana', 'Lopez', 'Hernandez', '1978-06-15', 'adriana.lopez@example.com', '5558901234', 'CDMX', 'Venustiano Carranza', 'Mexico', 43210, 'Av. Revolucion', 1818, 190, 'Sur'),
('Ricardo', 'Sanchez', 'Gonzalez', '1983-07-20', 'ricardo.sanchez@example.com', '5559012345', 'CDMX', 'Coyoacan', 'Mexico', 32109, 'Calle Allende', 1919, 200, 'Este'),
('Monica', 'Garcia', 'Martinez', '1988-08-25', 'monica.garcia@example.com', '5550123456', 'CDMX', 'Alvaro Obregon', 'Mexico', 21098, 'Av. Independencia', 2020, 210, 'Oeste'),
('Fernando', 'Perez', 'Ramirez', '1979-09-30', 'fernando.perez@example.com', '5551234567', 'CDMX', 'Azcapotzalco', 'Mexico', 10987, 'Calle Juarez', 2121, 220, 'Centro'),
('Isabel', 'Lopez', 'Flores', '1985-10-15', 'isabel.lopez@example.com', '5552345678', 'CDMX', 'Gustavo A. Madero', 'Mexico', 98765, 'Av. Hidalgo', 2222, 230, 'Norte'),
('Victor', 'Hernandez', 'Gomez', '1990-11-20', 'victor.hernandez@example.com', '5553456789', 'CDMX', 'Cuauhtemoc', 'Mexico', 87654, 'Calle Zaragoza', 2323, 240, 'Sur'),
('Patricia', 'Sanchez', 'Lopez', '1985-12-25', 'patricia.sanchez@example.com', '5554567890', 'CDMX', 'Benito Juarez', 'Mexico', 76543, 'Av. Juarez', 2424, 250, 'Este'),
('Miguel', 'Ramirez', 'Martinez', '1980-01-10', 'miguel.ramirez@example.com', '5555678901', 'CDMX', 'Miguel Hidalgo', 'Mexico', 65432, 'Calle Hidalgo', 2525, 260, 'Oeste'),
('Sandra', 'Gonzalez', 'Perez', '1991-02-15', 'sandra.gonzalez@example.com', '5556789012', 'CDMX', 'Iztapalapa', 'Mexico', 54321, 'Av. Morelos', 2626, 270, 'Centro'),
('Roberto', 'Lopez', 'Hernandez', '1982-03-20', 'roberto.lopez@example.com', '5557890123', 'CDMX', 'Tlalpan', 'Mexico', 43210, 'Calle Madero', 2727, 280, 'Norte'),
('Daniela', 'Sanchez', 'Garcia', '1988-04-25', 'daniela.sanchez@example.com', '5558901234', 'CDMX', 'Coyoacan', 'Mexico', 32109, 'Av. Revolucion', 2828, 290, 'Sur'),
('Alejandro', 'Martinez', 'Gonzalez', '1995-05-30', 'alejandro.martinez@example.com', '5559012345', 'CDMX', 'Alvaro Obregon', 'Mexico', 21098, 'Calle Allende', 2929, 300, 'Este'),
('Paola', 'Perez', 'Ramirez', '1978-06-15', 'paola.perez@example.com', '5550123456', 'CDMX', 'Azcapotzalco', 'Mexico', 10987, 'Av. Independencia', 3030, 310, 'Oeste'),
('Hector', 'Lopez', 'Flores', '1983-07-20', 'hector.lopez@example.com','5551234567', 'CDMX', 'Venustiano Carranza', 'Mexico', 98765, 'Calle Juarez', 3131, 320, 'Centro'),
('Sara', 'Gomez', 'Hernandez', '1992-08-25', 'sara.gomez@example.com', '5552345678', 'CDMX', 'Gustavo A. Madero', 'Mexico', 87654, 'Av. Hidalgo', 3232, 330, 'Norte'),
('Mario', 'Hernandez', 'Gonzalez', '1985-09-30', 'mario.hernandez@example.com', '5553456789', 'CDMX', 'Cuauhtemoc', 'Mexico', 76543, 'Calle Zaragoza', 3333, 340, 'Sur'),
('Angela', 'Sanchez', 'Martinez', '1991-10-15', 'angela.sanchez@example.com', '5554567890', 'CDMX', 'Benito Juarez', 'Mexico', 65432, 'Av. Juarez', 3434, 350, 'Este'),
('Oscar', 'Ramirez', 'Perez', '1980-11-20', 'oscar.ramirez@example.com', '5555678901', 'CDMX', 'Miguel Hidalgo', 'Mexico', 54321, 'Calle Hidalgo', 3535, 360, 'Oeste'),
('Lourdes', 'Gonzalez', 'Lopez', '1988-12-25', 'lourdes.gonzalez@example.com', '5556789012', 'CDMX', 'Iztapalapa', 'Mexico', 43210, 'Av. Morelos', 3636, 370, 'Centro'),
('Eduardo', 'Lopez', 'Hernandez', '1982-01-10', 'eduardo.lopez@example.com', '5557890123', 'CDMX', 'Tlalpan', 'Mexico', 32109, 'Calle Madero', 3737, 380, 'Norte'),
('Gabriela', 'Sanchez', 'Garcia', '1990-02-15', 'gabriela.sanchez@example.com', '5558901234', 'CDMX', 'Coyoacan', 'Mexico', 21098, 'Av. Revolucion', 3838, 390, 'Sur'),
('Rodrigo', 'Martinez', 'Gomez', '1985-03-20', 'rodrigo.martinez@example.com', '5559012345', 'CDMX', 'Alvaro Obregon', 'Mexico', 10987, 'Calle Allende', 3939, 400, 'Este'),
('Beatriz', 'Aguilar', 'Morales', '1974-01-13', 'beatriz.aguilar@example.com', '5551324567', 'CDMX', 'Cuajimalpa', 'Mexico', 11023, 'Calle Libertad', 41, 401, 'Zona Norte'),
('Josefina', 'Nava', 'Castillo', '1983-02-18', 'josefina.nava@example.com', '5552435678', 'CDMX', 'Tlahuac', 'Mexico', 12034, 'Calle Progreso', 42, 402, 'Zona Centro'),
('Miguel', 'Padilla', 'Rosales', '1991-03-23', 'miguel.padilla@example.com', '5553546789', 'CDMX', 'Xochimilco', 'Mexico', 13045, 'Calle Paz', 43, 403, 'Zona Sur'),
('Teresa', 'Romero', 'Mendoza', '1980-04-28', 'teresa.romero@example.com', '5554657890', 'CDMX', 'Iztacalco', 'Mexico', 14056, 'Calle Reforma', 44, 404, 'Zona Este'),
('Luis', 'Mendez', 'Guerrero', '1986-05-13', 'luis.mendez@example.com', '5555768901', 'CDMX', 'Magdalena Contreras', 'Mexico', 15067, 'Calle Victoria', 45, 405, 'Zona Oeste'),
('Patricia', 'Pacheco', 'Villalobos', '1990-06-18', 'patricia.pacheco@example.com', '5556879012', 'CDMX', 'Milpa Alta', 'Mexico', 16078, 'Calle Unión', 46, 406, 'Zona Norte'),
('Ricardo', 'Ortega', 'Rios', '1984-07-23', 'ricardo.ortega@example.com', '5557980123', 'CDMX', 'Cuajimalpa', 'Mexico', 17089, 'Calle Libertad', 47, 407, 'Zona Centro'),
('Lorena', 'Santos', 'Luna', '1992-08-28', 'lorena.santos@example.com', '5558091234', 'CDMX', 'Tlahuac', 'Mexico', 18090, 'Calle Progreso', 48, 408, 'Zona Sur'),
('Javier', 'Espinoza', 'Salinas', '1981-09-13', 'javier.espinoza@example.com', '5559102345', 'CDMX', 'Xochimilco', 'Mexico', 19001, 'Calle Paz', 49, 409, 'Zona Este'),
('Claudia', 'Camacho', 'Velazquez', '1987-10-18', 'claudia.camacho@example.com', '5551213456', 'CDMX', 'Iztacalco', 'Mexico', 20012, 'Calle Reforma', 50, 410, 'Zona Oeste'),
('Rafael', 'Lara', 'Navarro', '1979-11-23', 'rafael.lara@example.com', '5552324567', 'CDMX', 'Magdalena Contreras', 'Mexico', 21023, 'Calle Victoria', 51, 411, 'Zona Norte'),
('Silvia', 'Montes', 'Palacios', '1985-12-28', 'silvia.montes@example.com', '5553435678', 'CDMX', 'Milpa Alta', 'Mexico', 22034, 'Calle Unión', 52, 412, 'Zona Centro'),
('Armando', 'Pineda', 'Ponce', '1993-01-13', 'armando.pineda@example.com', '5554546789', 'CDMX', 'Cuajimalpa', 'Mexico', 23045, 'Calle Libertad', 53, 413, 'Zona Sur'),
('Gabriela', 'Sandoval', 'Ibarra', '1982-02-18', 'gabriela.sandoval@example.com', '5555657890', 'CDMX', 'Tlahuac', 'Mexico', 24056, 'Calle Progreso', 54, 414, 'Zona Este'),
('Carlos', 'Lozano', 'Nunez', '1988-03-23', 'carlos.lozano@example.com', '5556768901', 'CDMX', 'Xochimilco', 'Mexico', 25067, 'Calle Paz', 55, 415, 'Zona Oeste'),
('Veronica', 'Rivas', 'Villanueva', '1994-04-28', 'veronica.rivas@example.com', '5557879012', 'CDMX', 'Iztacalco', 'Mexico', 26078, 'Calle Reforma', 56, 416, 'Zona Norte'),
('Eduardo', 'Ramos', 'Gallegos', '1978-05-13', 'eduardo.ramos@example.com', '5558980123', 'CDMX', 'Magdalena Contreras', 'Mexico', 27089, 'Calle Victoria', 57, 417, 'Zona Centro'),
('Martha', 'Ramirez', 'Zamora', '1983-06-18', 'martha.ramirez@example.com', '5559091234', 'CDMX', 'Milpa Alta', 'Mexico', 28090, 'Calle Unión', 58, 418, 'Zona Sur'),
('Juan', 'Vargas', 'Hernandez', '1991-07-23', 'juan.vargas@example.com', '5551102345', 'CDMX', 'Cuajimalpa', 'Mexico', 29001, 'Calle Libertad', 59, 419, 'Zona Este'),
('Alicia', 'Acosta', 'Romero', '1980-08-28', 'alicia.acosta@example.com', '5552213456', 'CDMX', 'Tlahuac', 'Mexico', 30012, 'Calle Progreso', 60, 420, 'Zona Oeste'),
('Roberto', 'Molina', 'Salazar', '1987-09-13', 'roberto.molina@example.com', '5553324567', 'CDMX', 'Xochimilco', 'Mexico', 31023, 'Calle Paz', 61, 421, 'Zona Norte'),
('Elena', 'Mejia', 'Padilla', '1992-10-18', 'elena.mejia@example.com', '5554435678', 'CDMX', 'Iztacalco', 'Mexico', 32034, 'Calle Reforma', 62, 422, 'Zona Centro'),
('Guillermo', 'Rojas', 'Flores', '1981-11-23', 'guillermo.rojas@example.com', '5555546789', 'CDMX', 'Magdalena Contreras', 'Mexico', 33045, 'Calle Victoria', 63, 423, 'Zona Sur'),
('Daniela', 'Torres', 'Rios', '1985-12-28', 'daniela.torres@example.com', '5556657890', 'CDMX', 'Milpa Alta', 'Mexico', 34056, 'Calle Unión', 64, 424, 'Zona Este'),
('Miguel', 'Martinez', 'Nava', '1993-01-13', 'miguel.martinez@example.com', '5557768901', 'CDMX', 'Cuajimalpa', 'Mexico', 35067, 'Calle Libertad', 65, 425, 'Zona Oeste'),
('Sonia', 'Paredes', 'Santana', '1982-02-18', 'sonia.paredes@example.com', '5558879012', 'CDMX', 'Tlahuac', 'Mexico', 36078, 'Calle Progreso', 66, 426, 'Zona Norte'),
('Antonio', 'Fuentes', 'Morales', '1988-03-23', 'antonio.fuentes@example.com', '5559980123', 'CDMX', 'Xochimilco', 'Mexico', 37089, 'Calle Paz', 67, 427, 'Zona Centro'),
('Carolina', 'Guzman', 'Lorenzo', '1994-04-28', 'carolina.guzman@example.com', '5550191234', 'CDMX', 'Iztacalco', 'Mexico', 38090, 'Calle Reforma', 68, 428, 'Zona Sur'),
('Pablo', 'Mendoza', 'Cortes', '1978-05-13', 'pablo.mendoza@example.com', '5551302345', 'CDMX', 'Magdalena Contreras', 'Mexico', 39001, 'Calle Victoria', 69, 429, 'Zona Este'),
('Olga', 'Serrano', 'Pacheco', '1983-06-18', 'olga.serrano@example.com', '5552413456', 'CDMX', 'Milpa Alta', 'Mexico', 40012, 'Calle Unión', 70, 430, 'Zona Oeste'),
('Mario', 'Garcia', 'Cano', '1991-07-23', 'mario.garcia@example.com', '5553524567', 'CDMX', 'Cuajimalpa', 'Mexico', 41023, 'Calle Libertad', 71, 431, 'Zona Norte'),
('Adriana', 'Cruz', 'Ruiz', '1980-08-28', 'adriana.cruz@example.com', '5554635678', 'CDMX', 'Tlahuac', 'Mexico', 42034, 'Calle Progreso', 72, 432, 'Zona Centro'),
('Francisco', 'Lopez', 'Salinas', '1987-09-13', 'francisco.lopez@example.com', '5555746789', 'CDMX', 'Xochimilco', 'Mexico', 43045, 'Calle Paz', 73, 433, 'Zona Sur'),
('Julia', 'Castillo', 'Navarrete', '1992-10-18', 'julia.castillo@example.com', '5556857890', 'CDMX', 'Iztacalco', 'Mexico', 44056, 'Calle Reforma', 74, 434, 'Zona Este'),
('Enrique', 'Salazar', 'Jimenez', '1981-11-23', 'enrique.salazar@example.com', '5557968901', 'CDMX', 'Magdalena Contreras', 'Mexico', 45067, 'Calle Victoria', 75, 435, 'Zona Oeste'),
('Ana', 'Ortiz', 'Miranda', '1985-12-28', 'ana.ortiz@example.com', '5558079012', 'CDMX', 'Milpa Alta', 'Mexico', 46078, 'Calle Unión', 76, 436, 'Zona Norte'),
('Jorge', 'Munoz', 'Santos', '1993-01-13', 'jorge.munoz@example.com', '5559180123', 'CDMX', 'Cuajimalpa', 'Mexico', 47089, 'Calle Libertad', 77, 437, 'Zona Centro'),
('Veronica', 'Reyes', 'Solis', '1982-02-18', 'veronica.reyes@example.com', '5551291234', 'CDMX', 'Tlahuac', 'Mexico', 48090, 'Calle Progreso', 78, 438, 'Zona Sur'),
('Luis', 'Jimenez', 'Cabrera', '1988-03-23', 'luis.jimenez@example.com', '5552302345', 'CDMX', 'Xochimilco', 'Mexico', 49001, 'Calle Paz', 79, 439, 'Zona Este'),
('Patricia', 'Hernandez', 'Fuentes', '1994-04-28', 'patricia.hernandez@example.com', '5553413456', 'CDMX', 'Iztacalco', 'Mexico', 50012, 'Calle Reforma', 80, 440, 'Zona Oeste');
select * from personas

-- clientes

INSERT INTO clientes (identificacion, id_persona) VALUES
    ('ABCD123456EFG', 1),
    ('HIJK789012LMN', 2),
    ('OPQR345678STU', 3),
    ('VWXY901234ZAB', 4),
    ('CDEF567890GHI', 5),
    ('JKLM123456NOP', 6),
    ('QRST789012UVW', 7),
    ('XYZA345678BCD', 8),
    ('EFGH901234IJK', 9),
    ('LMNO567890PQR', 10),
    ('1234ABCD5678EFG', 11),
    ('5678HIJK1234LMN', 12),
    ('9012OPQR3456STU', 13),
    ('3456VWXY7890ZAB', 14),
    ('7890CDEF1234GHI', 15),
    ('2345JKLM6789NOP', 16),
    ('6789QRST1234UVW', 17),
    ('1234XYZA5678BCD', 18),
    ('5678EFGH9012IJK', 19),
    ('9012LMNO3456PQR', 20),
    ('ABCD1234567890EF', 21),
    ('HIJK1234567890LM', 22),
    ('OPQR5678901234ST', 23),
    ('VWXY5678901234AB', 24),
    ('CDEF9012345678GH', 25),
    ('JKLM9012345678NO', 26),
    ('QRST3456789012UV', 27),
    ('XYZA3456789012BC', 28),
    ('EFGH5678901234IJ', 29),
    ('LMNO5678901234PQ', 30),
    ('1234ABCD567890EF', 31),
    ('5678HIJK123456LM', 32),
    ('9012OPQR345678ST', 33),
    ('3456VWXY789012AB', 34),
    ('7890CDEF123456GH', 35),
    ('2345JKLM678901NO', 36),
    ('6789QRST123456UV', 37),
    ('1234XYZA567890BC', 38),
    ('5678EFGH901234IJ', 39),
    ('9012LMNO345678PQ', 40);
select * from clientes

-- sucursal

INSERT INTO sucursal (nombre_sucursal, estado_sucursal, pais, delegacion_municipio, direccion, telefono) VALUES
    ('Sucursal Central', 'Ciudad de México', 'México', 'Cuauhtémoc', 'Av. Insurgentes Sur 123', '5551234567'),
    ('Sucursal Norte', 'Nuevo León', 'México', 'Monterrey', 'Av. Revolución 456', '8187654321'),
    ('Sucursal Sur', 'Jalisco', 'México', 'Guadalajara', 'Av. Vallarta 789', '3319876543'),
    ('Sucursal Este', 'México', 'México', 'Nezahualcóyotl', 'Av. Juárez 234', '5558765432'),
    ('Sucursal Oeste', 'Puebla', 'México', 'Puebla', 'Av. Reforma 567', '2224567890'),
    ('Sucursal 1', 'Ciudad de México', 'México', 'Benito Juárez', 'Av. Universidad 890', '5552345678'),
    ('Sucursal 2', 'Veracruz', 'México', 'Veracruz', 'Av. Malecón 123', '2298765432'),
    ('Sucursal 3', 'Chihuahua', 'México', 'Chihuahua', 'Av. Hidalgo 456', '6143456789'),
    ('Sucursal 4', 'Sinaloa', 'México', 'Culiacán', 'Av. Álvaro Obregón 789', '6672345678'),
    ('Sucursal 5', 'Querétaro', 'México', 'Querétaro', 'Av. Constituyentes 234', '4429876543'),
    ('Sucursal A', 'Ciudad de México', 'México', 'Álvaro Obregón', 'Av. Patriotismo 567', '5557890123'),
    ('Sucursal B', 'Guerrero', 'México', 'Acapulco', 'Av. Costera 890', '7443456789'),
    ('Sucursal C', 'Michoacán', 'México', 'Morelia', 'Av. Madero 123', '4432345678'),
    ('Sucursal D', 'Tamaulipas', 'México', 'Tampico', 'Av. Hidalgo 456', '8339876543'),
    ('Sucursal E', 'Sonora', 'México', 'Hermosillo', 'Av. Reforma 789', '6624567890'),
    ('Sucursal F', 'Guanajuato', 'México', 'León', 'Av. Juárez 234', '4772345678'),
    ('Sucursal G', 'Tabasco', 'México', 'Villahermosa', 'Av. Ruiz Cortines 567', '9939876543'),
    ('Sucursal H', 'Coahuila', 'México', 'Saltillo', 'Av. Carranza 890', '8443456789'),
    ('Sucursal I', 'Yucatán', 'México', 'Mérida', 'Av. Montejo 123', '9992345678'),
    ('Sucursal J', 'Hidalgo', 'México', 'Pachuca', 'Av. Madero 456', '7719876543'),
    ('Sucursal K', 'Durango', 'México', 'Durango', 'Av. 20 de Noviembre 789', '6184567890'),
    ('Sucursal L', 'Zacatecas', 'México', 'Zacatecas', 'Av. García Salinas 234', '4922345678'),
    ('Sucursal M', 'Baja California', 'México', 'Tijuana', 'Av. Revolución 567', '6649876543'),
    ('Sucursal N', 'Chiapas', 'México', 'Tuxtla Gutiérrez', 'Av. Central 890', '9613456789'),
    ('Sucursal O', 'Nayarit', 'México', 'Tepic', 'Av. México 123', '3112345678'),
    ('Sucursal P', 'Colima', 'México', 'Colima', 'Av. Venustiano Carranza 456', '3129876543'),
    ('Sucursal Q', 'San Luis Potosí', 'México', 'San Luis Potosí', 'Av. Reforma 789', '4444567890'),
    ('Sucursal R', 'Oaxaca', 'México', 'Oaxaca', 'Av. Juárez 234', '9512345678'),
    ('Sucursal S', 'Aguascalientes', 'México', 'Aguascalientes', 'Av. Madero 567', '4499876543'),
    ('Sucursal T', 'Quintana Roo', 'México', 'Cancún', 'Av. Kukulcán 890', '9983456789'),
    ('Sucursal U', 'Baja California Sur', 'México', 'La Paz', 'Av. Forjadores 123', '6122345678'),
    ('Sucursal V', 'Guadalajara', 'México', 'Zapopan', 'Av. Vallarta 456', '3339876543'),
    ('Sucursal W', 'Monterrey', 'México', 'San Pedro Garza García', 'Av. Morones Prieto 789', '8184567890'),
    ('Sucursal X', 'Puebla', 'México', 'Cholula', 'Av. Juárez 234', '2222345678'),
    ('Sucursal Y', 'Ciudad de México', 'México', 'Álvaro Obregón', 'Av. Patriotismo 567', '5558765432'),
    ('Sucursal Z', 'Toluca', 'México', 'Toluca', 'Av. Independencia 890', '7223456789'),
    ('Sucursal AA', 'México', 'México', 'Naucalpan', 'Av. Periférico 123', '5553456789'),
    ('Sucursal BB', 'México', 'México', 'Ecatepec', 'Av. López Mateos 456', '5556789012'),
    ('Sucursal CC', 'México', 'México', 'Tlalnepantla', 'Av. Gustavo Baz 789', '5559012345'),
    ('Sucursal DD', 'México', 'México', 'Atizapán', 'Av. Ruiz Cortines 234', '5551234560');

select * from sucursal

-- empleados

INSERT INTO empleados (id_persona, id_sucursal, puesto) VALUES
    (41, 1, 'Gerente'),
    (42, 1, 'Cajero'),
    (43, 4, 'Asistente de Ventas'),
    (44, 4, 'Contador'),
    (45, 4, 'Analista de Crédito'),
    (46, 1, 'Gerente de Sucursal'),
    (47, 5, 'Ejecutivo de Cuentas'),
    (48, 5, 'Asesor Financiero'),
    (49, 5, 'Cajero Principal'),
    (50, 1, 'Analista Financiero'),
    (51, 3, 'Asistente Administrativo'),
    (52, 4, 'Especialista en Inversiones'),
    (53, 5, 'Director de Sucursal'),
    (54, 1, 'Consultor de Negocios'),
    (55, 5, 'Auditor Interno'),
    (56, 6, 'Analista de Riesgos'),
    (57, 7, 'Analista de Mercados'),
    (58, 7, 'Asistente de Contabilidad'),
    (59, 7, 'Analista de Finanzas Corporativas'),
    (60, 7, 'Ejecutivo Comercial'),
    (61, 10, 'Analista de Crédito'),
    (62, 10, 'Gerente de Relaciones'),
    (63, 10, 'Asesor de Inversiones'),
    (64, 10, 'Especialista en Banca Personal'),
    (65, 11, 'Ejecutivo de Negocios'),
    (66, 11, 'Asistente de Crédito'),
    (67, 11, 'Cajero Principal'),
    (68, 11, 'Analista Financiero'),
    (69, 11, 'Director de Sucursal'),
    (70, 12, 'Consultor de Finanzas'),
    (71, 12, 'Auditor Interno'),
    (72, 12, 'Especialista en Riesgos'),
    (73, 12, 'Analista de Mercados'),
    (74, 13, 'Asistente Administrativo'),
    (75, 13, 'Gerente de Sucursal'),
    (76, 13, 'Ejecutivo de Cuentas'),
    (77, 13, 'Asesor Financiero'),
    (78, 14, 'Cajero'),
    (79, 14, 'Analista de Crédito'),
    (80, 14, 'Asistente de Ventas');

select * from empleados

-- cajeros
INSERT INTO cajeros (id_sucursal, estado_cajero) VALUES
(20,'Operativo'),
(1, 'Operativo'),
(1, 'Operativo'),
(2, 'Operativo'),
(2, 'Fuera de servicio'),
(3, 'Operativo'),
(3, 'Operativo'),
(4, 'Fuera de servicio'),
(4, 'Operativo'),
(5, 'Operativo'),
(5, 'Operativo'),
(6, 'Operativo'),
(6, 'Operativo'),
(7, 'Operativo'),
(7, 'Operativo'),
(8, 'Fuera de servicio'),
(8, 'Operativo'),
(9, 'Operativo'),
(9, 'Operativo'),
(10, 'Operativo'),
(10, 'Operativo'),
(11, 'Operativo'),
(11, 'Operativo'),
(12, 'Operativo'),
(12, 'Operativo'),
(13, 'Operativo'),
(13, 'Fuera de servicio'),
(14, 'Operativo'),
(14, 'Operativo'),
(15, 'Operativo'),
(15, 'Operativo'),
(16, 'Operativo'),
(16, 'Operativo'),
(17, 'Operativo'),
(17, 'Fuera de servicio'),
(18, 'Operativo'),
(18, 'Operativo'),
(19, 'Operativo'),
(19, 'Operativo'),
(20, 'Operativo');
select * from cajeros

-- cuentas

INSERT INTO cuentas (codigo_pais, digito_control, numero_cuenta, saldo, estado_de_ceunta, id_cliente) VALUES
('MX', 1, 1001, 5000.00, 'Activa', 1),
('MX', 2, 1002, 1500.50, 'inactiva', 2),
('MX', 3, 1003, 2000.75, 'Bloqueda', 3),
('MX', 4, 1004, 3000.00, 'Congelada', 4),
('MX', 5, 1005, 2500.00, 'Cerrada', 5),
('MX', 6, 1006, 3500.00, 'Suspendida', 6),
('MX', 7, 1007, 4000.00, 'sobregirada', 7),
('MX', 8, 1008, 4500.00, 'En revision', 8),
('MX', 9, 1009, 5000.00, 'Proceso de cierre', 9),
('MX', 10, 1010, 5500.00, 'Activa', 10),
('MX', 11, 1011, 6000.00, 'inactiva', 11),
('MX', 12, 1012, 6500.00, 'Bloqueda', 12),
('MX', 13, 1013, 7000.00, 'Congelada', 13),
('MX', 14, 1014, 7500.00, 'Cerrada', 14),
('MX', 15, 1015, 8000.00, 'Suspendida', 15),
('MX', 16, 1016, 8500.00, 'sobregirada', 16),
('MX', 17, 1017, 9000.00, 'En revision', 17),
('MX', 18, 1018, 9500.00, 'Proceso de cierre', 18),
('MX', 19, 1019, 10000.00, 'Activa', 19),
('MX', 20, 1020, 10500.00, 'inactiva', 20),
('MX', 21, 1021, 11000.00, 'Bloqueda', 21),
('MX', 22, 1022, 11500.00, 'Congelada', 22),
('MX', 23, 1023, 12000.00, 'Cerrada', 23),
('MX', 24, 1024, 12500.00, 'Suspendida', 24),
('MX', 25, 1025, 13000.00, 'sobregirada', 25),
('MX', 26, 1026, 13500.00, 'En revision', 26),
('MX', 27, 1027, 14000.00, 'Proceso de cierre', 27),
('MX', 28, 1028, 14500.00, 'Activa', 28),
('MX', 29, 1029, 15000.00, 'inactiva', 29),
('MX', 30, 1030, 15500.00, 'Bloqueda', 30),
('MX', 31, 1031, 16000.00, 'Congelada', 31),
('MX', 32, 1032, 16500.00, 'Cerrada', 32),
('MX', 33, 1033, 17000.00, 'Suspendida', 33),
('MX', 34, 1034, 17500.00, 'sobregirada', 34),
('MX', 35, 1035, 18000.00, 'En revision', 35),
('MX', 36, 1036, 18500.00, 'Proceso de cierre', 36),
('MX', 37, 1037, 19000.00, 'Activa', 37),
('MX', 38, 1038, 19500.00, 'inactiva', 38),
('MX', 39, 1039, 20000.00, 'Bloqueda', 39),
('MX', 40, 1040, 20500.00, 'Congelada', 40);

select * from cuentas

--transacciones

INSERT INTO transacciones (id_cuenta, tipo, monto, fecha, concepto) VALUES
(1, 'Deposito', 1000.00, '2024-01-01', 'Ingreso inicial'),
(2, 'Retiro', 200.00, '2024-01-02', 'Pago de servicios'),
(3, 'Deposito', 1500.00, '2024-01-03', 'Transferencia recibida'),
(4, 'Transferencia', 300.00, '2024-01-04', 'Envío a otra cuenta'),
(5, 'Retiro', 500.00, '2024-01-05', 'Pago de tarjeta de crédito'),
(6, 'Deposito', 2000.00, '2024-01-06', 'Ingreso de nómina'),
(7, 'Transferencia', 250.00, '2024-01-07', 'Pago de alquiler'),
(8, 'Retiro', 400.00, '2024-01-08', 'Compras en supermercado'),
(9, 'Deposito', 1750.00, '2024-01-09', 'Ingreso por ventas'),
(10, 'Transferencia', 350.00, '2024-01-10', 'Envío a familia'),
(11, 'Retiro', 600.00, '2024-01-11', 'Pago de servicios públicos'),
(12, 'Deposito', 2200.00, '2024-01-12', 'Ingreso por comisión'),
(13, 'Transferencia', 400.00, '2024-01-13', 'Pago de suscripción'),
(14, 'Retiro', 450.00, '2024-01-14', 'Gastos médicos'),
(15, 'Deposito', 1950.00, '2024-01-15', 'Ingreso por trabajos freelance'),
(16, 'Transferencia', 300.00, '2024-01-16', 'Donación a ONG'),
(17, 'Retiro', 700.00, '2024-01-17', 'Pago de renta'),
(18, 'Deposito', 2500.00, '2024-01-18', 'Ingreso de inversión'),
(19, 'Transferencia', 450.00, '2024-01-19', 'Envío a amigo'),
(20, 'Retiro', 800.00, '2024-01-20', 'Pago de matrícula'),
(21, 'Deposito', 2100.00, '2024-01-21', 'Ingreso de beca'),
(22, 'Transferencia', 350.00, '2024-01-22', 'Compra en línea'),
(23, 'Retiro', 500.00, '2024-01-23', 'Gastos de viaje'),
(24, 'Deposito', 2400.00, '2024-01-24', 'Ingreso por alquiler'),
(25, 'Transferencia', 500.00, '2024-01-25', 'Envío a familia'),
(26, 'Retiro', 550.00, '2024-01-26', 'Pago de seguros'),
(27, 'Deposito', 2300.00, '2024-01-27', 'Ingreso por premios'),
(28, 'Transferencia', 600.00, '2024-01-28', 'Pago de hipoteca'),
(29, 'Retiro', 650.00, '2024-01-29', 'Compras en tienda'),
(30, 'Deposito', 2700.00, '2024-01-30', 'Ingreso por ahorro'),
(31, 'Transferencia', 700.00, '2024-01-31', 'Envío a amigo'),
(32, 'Retiro', 750.00, '2024-02-01', 'Gastos personales'),
(33, 'Deposito', 2600.00, '2024-02-02', 'Ingreso por ventas'),
(34, 'Transferencia', 800.00, '2024-02-03', 'Pago de préstamos'),
(35, 'Retiro', 850.00, '2024-02-04', 'Pago de eventos'),
(36, 'Deposito', 2800.00, '2024-02-05', 'Ingreso de trabajo adicional'),
(37, 'Transferencia', 900.00, '2024-02-06', 'Pago de club'),
(38, 'Retiro', 900.00, '2024-02-07', 'Gastos de entretenimiento'),
(39, 'Deposito', 2900.00, '2024-02-08', 'Ingreso de proyectos'),
(40, 'Transferencia', 1000.00, '2024-02-09', 'Envío a socio');
select * from transacciones

-- tarjetas

INSERT INTO tarjeta (numero_tarjeta, fecha_emision, fecha_expiracion, estado, tipo, id_cuenta) VALUES
('1234567812345678', '2022-01-01', '2025-01-01', 'Activa', 'Debito', 1),
('2345678923456789', '2022-02-01', '2025-02-01', 'Bloqueda', 'Credito', 2),
('3456789034567890', '2022-03-01', '2025-03-01', 'Suspendida', 'Debito', 3),
('4567890145678901', '2022-04-01', '2025-04-01', 'Caducada', 'Credito', 4),
('5678901256789012', '2022-05-01', '2025-05-01', 'Robada', 'Debito', 5),
('6789012367890123', '2022-06-01', '2025-06-01', 'Cancelada', 'Credito', 6),
('7890123478901234', '2022-07-01', '2025-07-01', 'Inactiva', 'Debito', 7),
('8901234589012345', '2022-08-01', '2025-08-01', 'Congelada', 'Credito', 8),
('9012345690123456', '2022-09-01', '2025-09-01', 'Rechazada', 'Debito', 9),
('0123456701234567', '2022-10-01', '2025-10-01', 'Activa', 'Credito', 10),
('1234567812345670', '2022-11-01', '2025-11-01', 'Bloqueda', 'Debito', 11),
('2345678923456781', '2022-12-01', '2025-12-01', 'Suspendida', 'Credito', 12),
('3456789034567892', '2023-01-01', '2026-01-01', 'Caducada', 'Debito', 13),
('4567890145678903', '2023-02-01', '2026-02-01', 'Robada', 'Credito', 14),
('5678901256789014', '2023-03-01', '2026-03-01', 'Cancelada', 'Debito', 15),
('6789012367890125', '2023-04-01', '2026-04-01', 'Inactiva', 'Credito', 16),
('7890123478901236', '2023-05-01', '2026-05-01', 'Congelada', 'Debito', 17),
('8901234589012347', '2023-06-01', '2026-06-01', 'Rechazada', 'Credito', 18),
('9012345690123458', '2023-07-01', '2026-07-01', 'Activa', 'Debito', 19),
('0123456701234569', '2023-08-01', '2026-08-01', 'Bloqueda', 'Credito', 20),
('1234567812345679', '2023-09-01', '2026-09-01', 'Suspendida', 'Debito', 21),
('2345678923456780', '2023-10-01', '2026-10-01', 'Caducada', 'Credito', 22),
('3456789034567891', '2023-11-01', '2026-11-01', 'Robada', 'Debito', 23),
('4567890145678902', '2023-12-01', '2026-12-01', 'Cancelada', 'Credito', 24),
('5678901256789013', '2024-01-01', '2027-01-01', 'Inactiva', 'Debito', 25),
('6789012367890124', '2024-02-01', '2027-02-01', 'Congelada', 'Credito', 26),
('7890123478901235', '2024-03-01', '2027-03-01', 'Rechazada', 'Debito', 27),
('8901234589012346', '2024-04-01', '2027-04-01', 'Activa', 'Credito', 28),
('9012345690123457', '2024-05-01', '2027-05-01', 'Bloqueda', 'Debito', 29),
('0123456701234568', '2024-06-01', '2027-06-01', 'Suspendida', 'Credito', 30),
('1234567812345671', '2024-07-01', '2027-07-01', 'Caducada', 'Debito', 31),
('2345678923456782', '2024-08-01', '2027-08-01', 'Robada', 'Credito', 32),
('3456789034567893', '2024-09-01', '2027-09-01', 'Cancelada', 'Debito', 33),
('4567890145678904', '2024-10-01', '2027-10-01', 'Inactiva', 'Credito', 34),
('5678901256789015', '2024-11-01', '2027-11-01', 'Congelada', 'Debito', 35),
('6789012367890126', '2024-12-01', '2027-12-01', 'Rechazada', 'Credito', 36),
('7890123478901237', '2025-01-01', '2028-01-01', 'Activa', 'Debito', 37),
('8901234589012348', '2025-02-01', '2028-02-01', 'Bloqueda', 'Credito', 38),
('9012345690123459', '2025-03-01', '2028-03-01', 'Suspendida', 'Debito', 39),
('0123456701234570', '2025-04-01', '2028-04-01', 'Caducada', 'Credito', 40);
select * from tarjeta

-- prestamos

INSERT INTO prestamos (monto, intereses, fecha_inicio, fecha_vencimiento, estado, id_cliente) VALUES
(10000.00, 5.5, '2023-01-01', '2023-12-31', 'Solicitado', 1),
(15000.00, 4.8, '2023-02-01', '2024-01-31', 'Aprobado', 2),
(20000.00, 6.2, '2023-03-01', '2024-02-29', 'Desembolsado', 3),
(25000.00, 3.9, '2023-04-01', '2024-03-31', 'Activo', 4),
(12000.00, 5.1, '2023-05-01', '2024-04-30', 'Gracia', 5),
(13000.00, 6.0, '2023-06-01', '2024-05-31', 'Vencido', 6),
(17000.00, 4.5, '2023-07-01', '2024-06-30', 'En cobranza', 7),
(22000.00, 3.7, '2023-08-01', '2024-07-31', 'Reestructurado', 8),
(19000.00, 5.3, '2023-09-01', '2024-08-31', 'Liquilado', 9),
(16000.00, 4.9, '2023-10-01', '2024-09-30', 'Perdonado', 10),
(11000.00, 5.7, '2023-11-01', '2024-10-31', 'Incobrable', 11),
(14000.00, 4.6, '2023-12-01', '2024-11-30', 'Solicitado', 12),
(18000.00, 5.8, '2024-01-01', '2024-12-31', 'Aprobado', 13),
(21000.00, 6.1, '2024-02-01', '2025-01-31', 'Desembolsado', 14),
(23000.00, 3.8, '2024-03-01', '2025-02-28', 'Activo', 15),
(27000.00, 4.2, '2024-04-01', '2025-03-31', 'Gracia', 16),
(26000.00, 5.0, '2024-05-01', '2025-04-30', 'Vencido', 17),
(25000.00, 6.3, '2024-06-01', '2025-05-31', 'En cobranza', 18),
(24000.00, 3.5, '2024-07-01', '2025-06-30', 'Reestructurado', 19),
(29000.00, 4.4, '2024-08-01', '2025-07-31', 'Liquilado', 20),
(30000.00, 5.2, '2024-09-01', '2025-08-31', 'Perdonado', 21),
(32000.00, 6.4, '2024-10-01', '2025-09-30', 'Incobrable', 22),
(34000.00, 3.6, '2024-11-01', '2025-10-31', 'Solicitado', 23),
(36000.00, 4.7, '2024-12-01', '2025-11-30', 'Aprobado', 24),
(38000.00, 5.6, '2025-01-01', '2025-12-31', 'Desembolsado', 25),
(40000.00, 6.1, '2025-02-01', '2026-01-31', 'Activo', 26),
(42000.00, 3.9, '2025-03-01', '2026-02-28', 'Gracia', 27),
(44000.00, 5.3, '2025-04-01', '2026-03-31', 'Vencido', 28),
(46000.00, 4.8, '2025-05-01', '2026-04-30', 'En cobranza', 29),
(48000.00, 5.9, '2025-06-01', '2026-05-31', 'Reestructurado', 30),
(50000.00, 3.7, '2025-07-01', '2026-06-30', 'Liquilado', 31),
(52000.00, 4.5, '2025-08-01', '2026-07-31', 'Perdonado', 32),
(54000.00, 5.8, '2025-09-01', '2026-08-31', 'Incobrable', 33),
(56000.00, 6.0, '2025-10-01', '2026-09-30', 'Solicitado', 34),
(58000.00, 3.4, '2025-11-01', '2026-10-31', 'Aprobado', 35),
(60000.00, 4.6, '2025-12-01', '2026-11-30', 'Desembolsado', 36),
(62000.00, 5.7, '2026-01-01', '2026-12-31', 'Activo', 37),
(64000.00, 6.2, '2026-02-01', '2027-01-31', 'Gracia', 38),
(66000.00, 3.9, '2026-03-01', '2027-02-28', 'Vencido', 39),
(68000.00, 5.1, '2026-04-01', '2027-03-31', 'En cobranza', 40);
select * from prestamos

-- pagos

INSERT INTO pagos (id_prestamo, fecha_pago, monto) VALUES
(1, '2023-01-15', 500.00),
(2, '2023-02-15', 600.00),
(3, '2023-03-15', 700.00),
(4, '2023-04-15', 800.00),
(5, '2023-05-15', 900.00),
(6, '2023-06-15', 1000.00),
(7, '2023-07-15', 1100.00),
(8, '2023-08-15', 1200.00),
(9, '2023-09-15', 1300.00),
(10, '2023-10-15', 1400.00),
(11, '2023-11-15', 1500.00),
(12, '2023-12-15', 1600.00),
(13, '2024-01-15', 1700.00),
(14, '2024-02-15', 1800.00),
(15, '2024-03-15', 1900.00),
(16, '2024-04-15', 2000.00),
(17, '2024-05-15', 2100.00),
(18, '2024-06-15', 2200.00),
(19, '2024-07-15', 2300.00),
(20, '2024-08-15', 2400.00),
(21, '2024-09-15', 2500.00),
(22, '2024-10-15', 2600.00),
(23, '2024-11-15', 2700.00),
(24, '2024-12-15', 2800.00),
(25, '2025-01-15', 2900.00),
(26, '2025-02-15', 3000.00),
(27, '2025-03-15', 3100.00),
(28, '2025-04-15', 3200.00),
(29, '2025-05-15', 3300.00),
(30, '2025-06-15', 3400.00),
(31, '2025-07-15', 3500.00),
(32, '2025-08-15', 3600.00),
(33, '2025-09-15', 3700.00),
(34, '2025-10-15', 3800.00),
(35, '2025-11-15', 3900.00),
(36, '2025-12-15', 4000.00),
(37, '2026-01-15', 4100.00),
(38, '2026-02-15', 4200.00),
(39, '2026-03-15', 4300.00),
(40, '2026-04-15', 4400.00),
(1, '2026-05-15', 4500.00),
(2, '2026-06-15', 4600.00),
(3, '2026-07-15', 4700.00),
(4, '2026-08-15', 4800.00),
(5, '2026-09-15', 4900.00),
(6, '2026-10-15', 5000.00),
(7, '2026-11-15', 5100.00),
(8, '2026-12-15', 5200.00),
(9, '2027-01-15', 5300.00),
(10, '2027-02-15', 5400.00),
(11, '2027-03-15', 5500.00),
(12, '2027-04-15', 5600.00),
(13, '2027-05-15', 5700.00),
(14, '2027-06-15', 5800.00),
(15, '2027-07-15', 5900.00),
(16, '2027-08-15', 6000.00),
(17, '2027-09-15', 6100.00),
(18, '2027-10-15', 6200.00),
(19, '2027-11-15', 6300.00),
(20, '2027-12-15', 6400.00),
(21, '2028-01-15', 6500.00),
(22, '2028-02-15', 6600.00),
(23, '2028-03-15', 6700.00),
(24, '2028-04-15', 6800.00),
(25, '2028-05-15', 6900.00),
(26, '2028-06-15', 7000.00),
(27, '2028-07-15', 7100.00),
(28, '2028-08-15', 7200.00),
(29, '2028-09-15', 7300.00),
(30, '2028-10-15', 7400.00),
(31, '2028-11-15', 7500.00),
(32, '2028-12-15', 7600.00),
(33, '2029-01-15', 7700.00),
(34, '2029-02-15', 7800.00),
(35, '2029-03-15', 7900.00),
(36, '2029-04-15', 8000.00),
(37, '2029-05-15', 8100.00),
(38, '2029-06-15', 8200.00),
(39, '2029-07-15', 8300.00),
(40, '2029-08-15', 8400.00);
