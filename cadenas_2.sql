--Muestra el nombre de las personas reemplazando los siguientes caracteres A-->@,E-->3,I-->!, O-->0 ( Murcielago--> Murc!3l@g0).
select replace(
		replace(
			replace(
				replace(upper(nombre),'A','@'),
			'E','3'),
		'I','!'),
	'O','0') as nombre
from personas;

--Convierte los primeros tres caracteres del nombre en mayúscula (Edgar-->EDgar).
select concat(upper(left(nombre,3)),substring(nombre,4)) from personas

--Convierte el ultimo carácter del nombre en mayúsculas (Edgar-->EdgaR).
select concat(substring(nombre,1,length(nombre)-1),upper(right(nombre,1))) from personas
														
--Convierte el 3er carácter del nombre en Mayúscula (Edgar--> EdGar).
select concat(substring(nombre,1,2),upper(substring(nombre,3,1)),substring(nombre,4)) from personas

--Convierte el 2do y 4to carácter del nombre a Mayúscula(Edgar-->EDgAr).
select concat(substring(nombre,1,1),upper(substring(nombre,2,1)),substring(nombre,3,1),upper(substring(nombre,4,1)),substring(nombre,5))
from personas;

--Convierte a mayúsculas el segundo y último carácter (Armando-->ArmandO)
select concat(substring(nombre,1,1),upper(substring(nombre,2,1)),substring(nombre,3,length(nombre)-1),upper(right(nombre,1))) from personas

--Convierte a mayúscula el segundo, cuarto y penúltimo carácter del nombre (Armando--> ARmAnDo)


SELECT 
    CASE 
        WHEN LENGTH(nombre) < 2 THEN nombre
        WHEN LENGTH(nombre) < 4 THEN 
            CONCAT(
                SUBSTRING(nombre, 1, 1),
                UPPER(SUBSTRING(nombre, 2, 1)),
                SUBSTRING(nombre, 3, LENGTH(nombre) - 2)
            )
        ELSE 
            CONCAT(
                SUBSTRING(nombre, 1, 1),                                
                UPPER(SUBSTRING(nombre, 2, 1)),                            
                SUBSTRING(nombre, 3, 1),                                 
                UPPER(SUBSTRING(nombre, 4, 1)),                         
                CASE 
                    WHEN LENGTH(nombre) > 4 THEN 
                        SUBSTRING(nombre, 5, LENGTH(nombre) - 5)             
                    ELSE '' 
                END,
                UPPER(SUBSTRING(nombre, LENGTH(nombre) - 1, 1)),             
                SUBSTRING(nombre, LENGTH(nombre), 1)                         
            )
    END AS nombre_modificado
FROM personas;
