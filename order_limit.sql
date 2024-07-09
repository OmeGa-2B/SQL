
--*Muestra a la primer persona con mayor edad.
SELECT *, AGE(fecha_nacimiento) AS edad
FROM personas
ORDER BY fecha_nacimiento
LIMIT 1;

--*Muestra al alumno con el promedio mas alto.
SELECT p.nombre, p.primerapellido, p.segundoapellido, e.*, subquery.promedio
FROM 
    (
        SELECT em.id_boleta,
            AVG(em.calificacion) AS promedio
        FROM estudiante_materia em
        GROUP BY em.id_boleta
        ORDER BY promedio DESC
        LIMIT 1
    ) subquery
INNER JOIN estudiantes e ON subquery.id_bolet = e.boleta
INNER JOIN personas p ON e.id_persona = p.id_persona;



--*Muestra a las personas ordenados alfabéticamente por nombre.
select * from personas order by nombre;

--*Muestra las primeras 3 personas de Azcapotzalco
select * from personas
	where delegacion_municipio = 'Azcapotzalco'
limit 3

--*Muestra los alumnos ordenados de acuerdo con su promedio de manera descendente

select * ,(select avg(calificacion) as promedio
				 from estudiante_materia where 
				 id_boleta = boleta) 
					 from estudiantes 
order by promedio desc;
--*Muestra a los 5 primeros docentes que tienen un doctorado.
select p.nombre,p.primerapellido,p.segundoapellido,d.* from docente as d
inner join personas as p on d.id_persona = p.id_persona
where d.grado_academico = 'Doctorado'
limit 5
--*Muestra los alumnos ordenados por delegación, las delegaciones deben estar en orden ascendente y los pacientes de cada delegación ordénalos en forma descendente basados en su promedio
 
--delegacion                 promedio             Cliente
--coyoacan                   10              		Abril
--Coyoacan                   8.5                	Martha
--Coyoacan                   3.5                	Jaime
--Iztapalapa                 5.0                	Jaime  
--Iztapalapa                 3.0                	Ana


select p.delegacion_municipio, (select avg(calificacion) as promedio
				 from estudiante_materia where 
				 id_boleta = boleta), p.nombre
from estudiante_materia as em
inner join estudiantes as e on em.id_boleta = e.boleta
inner join personas as p on e.id_persona = p.id_persona
order by p.delegacion_municipio,promedio desc;