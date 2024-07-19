SELECT * FROM adjudicaciones ad WHERE ad.id_proveedor = 'PY-RUC-859531-3';
select * from categorias
select * from estados
select * from instituciones
select * from llamados
select * from metodos
select * from proveedores

select i.descripcion as institucion, pr.descripcion as proveedor, sum (a.monto) as total, ca.descripcion as categoria from instituciones i
join llamados ll on i.id = ll.id_institucion
join adjudicaciones a on a.	id_llamado = ll.id
join proveedores pr on pr.id = a.id_proveedor	
join categorias ca on ca.id = ll.id_categoria
join estados e on a.id_estado = e.id	

where ll.titulo	ilike '%Alquiler%' and e.id = 2 and EXTRACT(YEAR FROM a.fecha_adjudicacion) = 2021
	
group by i.descripcion, pr.descripcion, ca.descripcion
order by 3 desc
limit 10

SELECT 
    i.descripcion AS institucion, 
    contar_metodos_institucion(22, ll.id_institucion) AS "Contratacion directa", 
    contar_metodos_institucion(25, ll.id_institucion) AS "Concurso de oferta",
    contar_metodos_institucion(3, ll.id_institucion) AS "Contratacion por Excepcion"
FROM 
    llamados ll
JOIN 
    instituciones i ON i.id = ll.id_institucion
JOIN 
    metodos m ON m.id = ll.id_metodo
WHERE 
    i.descripcion LIKE '%Ministerio%'
GROUP BY 
    i.descripcion, ll.id_institucion
ORDER BY 
    "Contratacion directa" DESC;

CREATE OR REPLACE FUNCTION public.OtrasAdjudicaciones(llamado_id varchar, proveedor_id varchar, institucion_id integer)
RETURNS integer
LANGUAGE plpgsql
AS $function$
DECLARE
    cantidad_otras_adjudicaciones INTEGER;
BEGIN
    SELECT COUNT(DISTINCT l.id)
    INTO cantidad_otras_adjudicaciones
    FROM adjudicaciones a
    JOIN llamados l ON l.id = a.id_llamado
    JOIN instituciones i ON i.id = l.id_institucion
    WHERE a.id_llamado <> llamado_id
      AND a.id_proveedor = proveedor_id
      AND i.id = institucion_id;

    RETURN cantidad_otras_adjudicaciones;
END
$function$;

SELECT 
    l.id AS "LLamado",
    i.descripcion AS "Institución",
    a.monto,
    OtrasAdjudicaciones(l.id, p.id, i.id) AS "Otras Adjudicaciones"
FROM
    adjudicaciones a
JOIN
    proveedores p ON p.id = a.id_proveedor
JOIN
    llamados l ON l.id = a.id_llamado
JOIN
    instituciones i ON i.id = l.id_institucion
WHERE
    p.id = 'PY-RUC-859531-3'
ORDER BY
    a.monto DESC;



























