SELECT cu.numero_cuenta, cu.anho, tc.tipo_cuenta, MAX(cu.fecha_apertura) AS fecha_apertura_maxima, c.codigo_cliente, c.nombres
FROM cuentas cu
JOIN clientes c ON cu.codigo_cliente = c.codigo_cliente
JOIN tipos_cuentas tc ON cu.codigo_tipo = tc.codigo_tipo
WHERE c.codigo_cliente IN (647848, 3659553) AND tc.codigo_tipo IN (2, 3)
GROUP BY cu.numero_cuenta, cu.anho, tc.tipo_cuenta, c.codigo_cliente, c.nombres;

SELECT c.codigo_cliente, c.nombres, tc.tipo_cuenta, COUNT(DISTINCT cu.numero_cuenta) AS cantidad
FROM cuentas cu
JOIN clientes c ON cu.codigo_cliente = c.codigo_cliente
JOIN tipos_cuentas tc ON cu.codigo_tipo = tc.codigo_tipo
WHERE c.codigo_cliente IN (647848, 3659553, 1735058)
GROUP BY c.codigo_cliente, c.nombres, tc.tipo_cuenta
ORDER BY c.nombres ASC;

SELECT cu.numero_cuenta, tc.tipo_cuenta, c.codigo_cliente, c.nombres, calcularsaldo(m.codigo_movimiento) AS cantidad
FROM cuentas cu
JOIN clientes c ON cu.codigo_cliente = c.codigo_cliente
JOIN tipos_cuentas tc ON cu.codigo_tipo = tc.codigo_tipo
JOIN movimiento m ON cu.codigo_cuenta = m.codigo_cuenta
WHERE c.codigo_cliente IN (647848, 3659553, 1735058) AND fecha_operacion = '2021-12-31'
GROUP BY cu.numero_cuenta, tc.tipo_cuenta, c.codigo_cliente, c.nombres, m.codigo_movimiento
ORDER BY cantidad DESC;

