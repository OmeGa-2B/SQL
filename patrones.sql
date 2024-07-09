--Las personas que se llamen Eduardo sin importar que tengan 2 nombres.
select * from personas where nombre like '%Eduardo%'

--Las personas que su segundo caracter sea una "d".
select * from personas where nombre like '_d%'

-- Los que no empiecen su nombre con una  vocal.
SELECT * FROM personas 
WHERE nombre !~'^[AEIOU]'


--Los que empiecen su nombre con una vocal y terminen con s.	
SELECT  FROM personas 
WHERE nombre LIKE 'A%s' 
  or nombre LIKE 'E%s' 
  or nombre LIKE 'I%s'
  or nombre LIKE 'O%s'
  or nombre LIKE 'U%s';

--Los que su tercer caracter del nombre sea una G.
SELECT * FROM personas 
WHERE nombre LIKE '___g%';

--Los que su primer caracter en el apellido paterno sea 'E' y el 4 sea 'A'
insert into personas(nombre,primerapellido,segundoapellido,genero,fecha_nacimiento) values
	('Bryan', 'Escamilla', 'Abarca','Masculino','2001-3-21')

SELECT * FROM personas 
WHERE primerapellido LIKE 'E__a%';


-- Los que tengan por lo menos una 'E' en su nombre.
SELECT * FROM personas 
WHERE nombre LIKE '%E%';

--Los que se llaman Eduardo y Cualquiera de sus apellidos empiece con 'C'

insert into personas(nombre,primerapellido,segundoapellido,genero,fecha_nacimiento) values
	('Eduardo', 'Casarrubias', 'Riqueño','Masculino','2001-11-11')
	
select * from personas where nombre = 'Eduardo'
 AND (primerapellido like 'C%' or segundoapellido like 'C%')
 
  
-- Las personas que su apellido materno empiece con la primera mitad del alfabeto [A-M] pero que no empiecen ni con A ni con E
SELECT * FROM personas  WHERE segundoapellido ~ '^[B-M]' AND segundoapellido !~ '^E';

--Las personas que su apellido paterno empiece con la segunda mitad del alfabeto [N-Z]
SELECT * FROM personas  WHERE primerapellido ~ '^[N-Z]'

--concadenar los nombres, vocal empiezan
  
SELECT concat(primerapellido,' ',segundoapellido,' ',nombre) as nombre FROM personas 
WHERE nombre ~'^[AEIOU]'