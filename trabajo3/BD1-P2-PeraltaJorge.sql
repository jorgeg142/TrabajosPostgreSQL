SELECT * FROM adjudicaciones ad WHERE ad.id_proveedor = 'PY-RUC-859531-3';
select * from categorias
select * from estados
select * from instituciones
select * from llamados
select * from metodos
select * from proveedores
where descripcion LIKE '%EXCELSIS'

CREATE OR REPLACE VIEW vSuperProveedores AS
SELECT
    pr.id AS ruc,
    pr.descripcion AS proveedor,
    CAST(ROUND(SUM(a.monto / 7300.0)) AS INT) AS "En U$$",
    COUNT(*) AS cantidad
FROM
    instituciones i
    JOIN llamados ll ON i.id = ll.id_institucion
    JOIN adjudicaciones a ON a.id_llamado = ll.id
    JOIN proveedores pr ON pr.id = a.id_proveedor
    JOIN categorias ca ON ca.id = ll.id_categoria
    JOIN estados e ON a.id_estado = e.id
WHERE
    ca.descripcion LIKE '%programas computacionales%'
GROUP BY
    pr.id, pr.descripcion
ORDER BY
    "En U$$" DESC
LIMIT 10;

SELECT *
FROM vSuperProveedores;

SELECT
    'mes ' || TO_CHAR(a.fecha_adjudicacion, 'MM') || ' del año ' || TO_CHAR(a.fecha_adjudicacion, 'YYYY') AS mes,
    COUNT(*) AS cantidad_adjudicaciones
FROM
    adjudicaciones a
WHERE
    EXTRACT(YEAR FROM a.fecha_adjudicacion) = 2020
GROUP BY
    TO_CHAR(a.fecha_adjudicacion, 'MM'), TO_CHAR(a.fecha_adjudicacion, 'YYYY')
ORDER BY
    cantidad_adjudicaciones DESC;

SELECT
    EXTRACT(YEAR FROM a.fecha_adjudicacion) AS año_adjudicacion,
    i.descripcion AS institucion,
    m.descripcion AS metodo,
    SUM(a.monto) AS total
FROM
    adjudicaciones a
    JOIN proveedores pr ON a.id_proveedor = pr.id
    JOIN llamados ll ON a.id_llamado = ll.id
    JOIN instituciones i ON i.id = ll.id_institucion
    JOIN metodos m ON ll.id_metodo = m.id
WHERE
    LOWER(pr.descripcion) LIKE '%excelsis%'
    AND LOWER(m.descripcion) NOT LIKE '%licitación%'
GROUP BY
    EXTRACT(YEAR FROM a.fecha_adjudicacion),
    i.descripcion,
    m.descripcion
ORDER BY
    total DESC;

SELECT DISTINCT
    i.id AS id,
    i.descripcion AS institucion
FROM
    llamados ll
    JOIN instituciones i ON ll.id_institucion = i.id
WHERE
    ll.titulo IS NULL OR ll.titulo = ''
ORDER BY
    id, institucion;



























