select * from personas where nombre = 'Eduardo'

select * from personas where not nombre ='Eduardo'

select id_docente,id_persona, area_especialidad from docente where not grado_academico = 'Maestría'

select id_docente,id_persona, area_especialidad from docente where grado_academico = 'Maestría'

select nombre,primerapellido,segundoapellido,delegacion_municipio from personas where ciudad = 'Ciudad de Mexico'

select nombre,primerapellido,segundoapellido,delegacion_municipio from personas where not ciudad = 'Ciudad de Mexico'

select nombre,primerapellido,segundoapellido from personas where genero = 'Femenino'

SELECT 
    'La persona '|| nombre || primerapellido || segundoapellido || ' vive en la delegacion o Municipio ' || delegacion_municipio 
FROM 
    personas;

select nombre_materia,semestre from materia
select * from materia

select
	'En la academia de' || ' ' || academia || ' ' || 'posee la materia' || ' ' || nombre_materia || ' ' || 'con' || ' ' || creditos || ' ' || 'creditos'
from materia
