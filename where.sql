-- Los que NO se llaman Pedro o Juan.
select * from personas where not nombre = 'Pedro' or nombre = 'Juan';

--Los que se llamen Pedro y su apellido paterno es Ramírez.
select * from personas where nombre = 'Pedro' and primerapellido = 'Ramírez';

--Los que su apellido paterno es López y NO se llaman Héctor.
select * from personas where not nombre ='Héctor' and primerapellido = 'López';

--Los que se llaman Claudia o su apellido paterno es López
select * from personas where nombre = 'Claudia' or primerapellido ='López';

--Los que cualquiera de sus apellidos es Ruiz.
insert into personas(nombre,primerapellido,segundoapellido,genero) values
	('Daniel','Ruiz','Ruiz','Masculino')
select * from personas where primerapellido ='Ruiz' and segundoapellido = 'Ruiz';

-- Los que su apellido paterno es Gómez, Romero o Flores.
select * from personas where primerapellido ='Gómez' or primerapellido = 'Flores' or primerapellido = 'Romero';

--  Los que se llaman Daniel y su apellido paterno es Govea o Pérez
select * from personas where nombre = 'Daniel'
	and primerapellido = 'Govea'
	or primerapellido = 'Pérez';
	
-- Las personas que su sea Iztacalco, Coyoacán o Benito Juárez (Operadores Especiales)
select * from personas where delegacion_municipio in('Coyoacán','Benito Juárez')

--Las personas de la delegación Azcapotzalco, Coyoacán o Benito Juárez y su apellido paterno sea Flores. (Operadores Especiales)
select * from personas where delegacion_municipio in('Azcapotzalco','Coyoacán','Benito Juárez')
	 and primerapellido = 'Flores'
	 
--Las personas de la delegación Iztacalco, Iztapalapa o Tlalpan y cualquiera de sus apellidos sea Blanco, Pérez o García (Operadores Especiales) 
select * from personas where delegacion_municipio in('Iztacalco', 'Iztapalapa','Tlalpan')
and (primerapellido in('Blanco', 'Pérez','García') or segundoapellido in('Blanco', 'Pérez', 'García'))

--Las personas que posean una fecha de nacimiento y alguno de los apellidos es (Martínez, García, Vázquez, Díaz, López, Hernández). (Operadores Especiales).
select * from personas where fecha_nacimiento is not null
	and (primerapellido in('Martínez', 'García', 'Vázquez', 'Díaz', 'López', 'Hernández')
		or segundoapellido in('Martínez', 'García', 'Vázquez', 'Díaz', 'López', 'Hernández'))

-- Las personas que no posean teléfono y tampoco se apelliden Flores, García o Ramírez en alguno de sus apellidos. (Operadores Especiales)
select * from personas where telefono is null
	and not (primerapellido in('Flores', 'García', 'Ramírez')
			or segundoapellido in('Flores', 'García','Ramírez'))
	