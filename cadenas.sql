--Muestra solo a las personas que su nombre tiene más de 5 letras.
SELECT * FROM personas WHERE LENGTH(nombre) > 5;

-- Muestra a las personas que su nombre tiene entre 5 y 7 caracteres.
select * from personas where length(nombre) > 4 and length(nombre) <8;

--Muestra a las personas que su nombre tiene entre mas de 7 caracteres y alguno de sus apellidos tenga entre 5 y 7 caracteres.
select * from personas where length(nombre) > 7
	and ((length(primerapellido) > 4 and length(primerapellido) < 8)
		or (length(segundoapellido) > 4 and length(segundoapellido) < 8));

--Muestra los primeros tres caracteres del nombre.
select substring(nombre,1,3) from personas;

-- Muestra los últimos 3 caracteres del nombre.
select substring(nombre,length(nombre)-2,3) from personas;

-- Muestra del 2do al 5to carácter del nombre.
select substring(nombre,2,5) from personas;

--Reemplaza las d por s en nombre.
select nombre from personas
select replace(nombre,'d','s') from personas;

-- Obtén la longitud del apellido paterno.
select primerapellido,length(primerapellido) from personas as longitud_apellido
	where primerapellido is not null;

--Muestra en mayúsculas el nombre.
select upper(nombre) from personas;

--Muestra en minúsculas el apellido paterno.
select lower(primerapellido) from personas where primerapellido is not null;

--Muestra a las personas con su delegación, reemplazando Benito Juárez por B. Juárez.
SELECT nombre,primerapellido,segundoapellido, REPLACE(delegacion_municipio, 'Benito Juárez', 'B. Juárez') AS delegacion_modificada
FROM personas;

--Muestra el nombre completo empezando por el apellido paterno con mayúsculas en una sola columna.
select upper(concat(primerapellido,' ',segundoapellido,' ',nombre)) from personas as nombre_completo;

--Muestra el nombre de las personas con las E reemplazadas con el número 3.
select replace(nombre,'E','3') from personas;

--Muestra el nombre completo de las personas con las o reemplazados con el número 0 en una sola columna.

select replace(concat(primerapellido,' ',segundoapellido,' ',nombre),'o','0') from personas as nombre_completo;