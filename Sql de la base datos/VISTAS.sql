
-- Primera Consulta-----------------------
CREATE VIEW VistaLibrosCubiculos AS
SELECT 
    libro.titulo AS Titulo_Libro,
    persona.nombre1 AS Nombre_Autor,
    persona.apellido1 AS Apellido_Autor,
    autor.nacionalidad AS Nacionalidad_Autor,
    estante.numEstannte AS Estante,
    estante.ubicacion AS Ubicacion_Estante,
    cubiculo.posicion AS Cubiculo_Posicion,
    cubiculo.ubicacion AS Cubiculo_Ubicacion,
    categoria.nombre AS Nombre_Categoria
FROM 
    libro
INNER JOIN 
    libro_has_cubiculo lc ON lc.libro_id = libro.id
INNER JOIN 
    cubiculo ON lc.cubiculo_id = cubiculo.id
INNER JOIN 
    Libro_has_Autor la ON la.libro_id = libro.id
INNER JOIN 
    autor ON autor.id = la.autor_id
INNER JOIN 
    estante ON estante.id = cubiculo.estante_id
INNER JOIN 
    persona ON persona.id = autor.persona_id
INNER JOIN 
    categoria_has_libro cl ON cl.libro_id = libro.id
INNER JOIN 
    categoria ON cl.categoría_id = categoria.id
ORDER BY 
    categoria.nombre;



-- Segunda Vista----------------------------
CREATE VIEW Vista_Usuario AS
SELECT
    persona.nombre1,
    persona.nombre2,
    persona.apellido1,
    persona.apellido2,
    telefono.numTelefono,
    telefono.tipo AS tipo_Telefono,
    telefono.operador,
    membresia.tipo AS Tipo_membresia,
    membresia.duracion AS Duracion_membresia,
    sancion.tipo AS Tipo_sancion,
    sancion.cantidadMultas,
    multa.fechaPago AS Fecha_pago_multa,
    multa.motivo AS Motivo_multa,
    multa.monto AS Monto_multa,
    libro.Titulo AS Titulo_Libro
FROM persona
INNER JOIN 
    usuario ON usuario.persona_id = persona.id
INNER JOIN
    telefono ON telefono.persona_id = persona.id
INNER JOIN 
    membresia ON membresia.usuario_id = usuario.id
INNER JOIN 
    sancion ON sancion.usuario_id = usuario.id
INNER JOIN 
    multa ON multa.usuario_id = usuario.id
INNER JOIN
    libroPerdido ON sancion.libroPerdido_id = libroPerdido.id
INNER JOIN
    libro ON libro.id = libroPerdido.libro_id
ORDER BY persona.nombre1 ASC;


-- Tercera Vista----------------
CREATE VIEW Editorial_Libro AS
SELECT 
    libro.titulo AS Titulo_Libro,
    libro.isbn AS ISBN,
    MAX(libroComprado.precio) AS Precio_Comprado_Libro,
    editorial.nombre AS Nombre_Editorial,
    editorial.correoElectronico AS Correo_Editorial,
    MAX(persona.nombre1) AS Nombre_Proveedor,
    MAX(persona.nombre2) AS Nombre2_Proveedor,
    MAX(persona.apellido1) AS Apellido1_Proveedor,
    MAX(persona.apellido2) AS Apellido2_Proveedor,
    MAX(direccionEditorial.pais) AS Pais_Editorial,
    MAX(direccionEditorial.ciudad) AS Ciudad_Editorial,
    MAX(direccionEditorial.referencia) AS Referencia_Editorial,
    MAX(direccionEditorial.codigoPostal) AS CodigoPostal_Editorial
FROM libro
INNER JOIN libroComprado ON libro.id = libroComprado.libro_id
INNER JOIN editorial ON editorial.id = libro.editorial_id
INNER JOIN Libro_Comprado_has_Proveedor ON Libro_Comprado_has_Proveedor.libro_comprado_id = libroComprado.id
INNER JOIN proveedor ON Libro_Comprado_has_Proveedor.proveedor_id = proveedor.id
INNER JOIN persona ON proveedor.persona_id = persona.id
INNER JOIN Editorial_has_Direccion_Editorial ON Editorial_has_Direccion_Editorial.editorial_id = editorial.id
INNER JOIN direccionEditorial ON direccionEditorial.id = Editorial_has_Direccion_Editorial.direccionEditorial_id
GROUP BY libro.titulo, libro.isbn, editorial.nombre, editorial.correoElectronico;



-- Cuarta Vista-------------------------
CREATE VIEW categoria_con_Libro AS
SELECT
    categoria.nombre AS Nombre_Categoria,
    libro.titulo,
    libro.isbn,
    libro.numPaginas,
    editorial.nombre AS Nombre_Editorial
FROM
    libro
INNER JOIN
    categoria_has_libro ON libro.id = categoria_has_libro.libro_id
INNER JOIN
    categoria ON categoria_has_libro.categoría_id = categoria.id
INNER JOIN
    editorial ON libro.editorial_id = editorial.id;

-- Quinta Vista-----------------------------------------------------------
CREATE VIEW Prestamos_Activos AS
SELECT
    prestamo.id,
    persona.nombre1,
    persona.nombre2,
    persona.apellido1,
    persona.apellido2,
    libro.titulo,
    libro.imagen,
    libro.url,
    prestamo.fechaPrestamo,
    prestamo.fechaRegreso
FROM
    prestamo
INNER JOIN
    usuario ON prestamo.usuario_id = usuario.id
INNER JOIN
    persona ON usuario.persona_id = persona.id
INNER JOIN
    libro ON prestamo.libro_id = libro.id;


-- Sexta Vista --------------------------------
CREATE VIEW Libros_Disponibles AS
SELECT
    libro.id,
    libro.titulo,
    libro.isbn,
    libro.numPaginas,
    libro.imagen,
    libro.url,
    editorial.nombre AS Nombre_Editorial,
    persona.nombre1 AS Nombre_Autor,
    persona.apellido1 AS Apellido_Autor,
    formatoLibro.precio
FROM
    libro
INNER JOIN
    editorial ON libro.editorial_id = editorial.id
INNER JOIN 
    Libro_has_Autor la ON la.libro_id = libro.id
INNER JOIN 
    autor ON autor.id = la.autor_id
INNER JOIN
	persona ON persona.id=autor.persona_id
INNER JOIN
	Formato_Libro_has_Libro ON  Formato_Libro_has_Libro.libro_id=libro.id
INNER JOIN
	formatoLibro ON formatoLibro.id=Formato_Libro_has_Libro.formatoLibro_id
WHERE
    libro.id NOT IN (SELECT libro_id FROM prestamo)
    AND libro.id NOT IN (SELECT libroPerdido.libro_id FROM libroPerdido)
    AND libro.id NOT IN (SELECT libroVendido.libro_id FROM libroVendido);

-- Septima Vista --------------------------------------
CREATE VIEW Libros_Perdidos_Por_Usuario AS
SELECT
    libro.id AS Libro_ID,
    libro.titulo AS Titulo_Libro,
    libro.isbn AS ISBN_Libro,
    usuario.id AS Usuario_ID,
    persona.nombre1 AS Nombre_Usuario,
    persona.apellido1 AS Apellido_Usuario
FROM
    libroPerdido
JOIN
    libro ON libroPerdido.libro_id = libro.id
JOIN
    usuario ON libroPerdido.usuario_id = usuario.id
JOIN
    persona ON usuario.persona_id = persona.id
ORDER BY
    persona.nombre1 ASC;


-- Octava Vista----------------------------------------
CREATE VIEW Empleado_Info AS
SELECT 
    empleado.id AS Empleado_ID,
    empleado.persona_id,
    cargo.nombre AS Cargo_Nombre,
    horarioEmpleado.turno,
    horarioEmpleado.horaIngreso,
    horarioEmpleado.horaEgreso,
    horarioEmpleado.cantidad AS Horas_Trabajadas,
    salario.hora_extra,
    salario.bono,
    salario.catorceavo,
    salario.deduccion,
    salario.total AS Salario_Total,
    salario.fecha AS Fecha_Pago
FROM 
    empleado 
INNER JOIN 
    cargo ON empleado.cargo_id = cargo.id
INNER JOIN 
    horarioEmpleado ON empleado.id = horarioEmpleado.empleado_id
INNER JOIN 
    salario ON cargo.salario_id = salario.id;


-- Novena Vista-------------------------------------
CREATE VIEW Comentario_Valoraciones_Libros AS
SELECT 
    libro.titulo AS Libro_Titulo,
    libro.isbn AS Libro_ISBN,
    libro.numEdicion AS Libro_NumEdicion,
    valoracion.estrella AS Valoracion_Estrella,
    comentario.tipo AS Comentario_Tipo,
    comentario.contenido AS Comentario_Contenido,
    persona.nombre1 AS Persona_Nombre1,
    persona.apellido1 AS Persona_Apellido1
FROM libro
INNER JOIN valoracion ON valoracion.libro_id = libro.id
INNER JOIN comentario ON comentario.libro_id = libro.id AND comentario.usuario_id = valoracion.usuario_id
INNER JOIN usuario ON usuario.id = valoracion.usuario_id
INNER JOIN persona ON usuario.persona_id = persona.id;

-- Decima Vista----------------------
CREATE VIEW Libros_Donados AS
SELECT
    libro.id AS Libro_ID,
    libro.titulo AS Titulo_Libro,
    libro.isbn AS ISBN_Libro,
	libro.url,
    libro.imagen,
    persona.nombre1 AS Nombre_Usuario,
    persona.apellido1 AS Apellido_Usuario
FROM
    donacion
JOIN
    libro ON donacion.libro_id = libro.id
JOIN
    persona ON donacion.persona_id = persona.id
ORDER BY
    persona.nombre1 ASC;

-- Onceava Vista----------------------
CREATE VIEW Vista_Factura AS
SELECT 
    factura.id AS Factura_ID,
    persona.nombre1 AS Nombre_Usuario,
    persona.apellido1 AS Apellido_Usuario,
    libro.titulo AS Libro_Vendido,
    factura.fechaEmision AS Factura_FechaEmision,
    factura.formaPago_id AS FormaPago_ID,
    formaPago.tipo AS FormaPago_Tipo,
    detalleFactura.descripcion AS DetalleFactura_Descripcion,
    detalleFactura.cantidad AS DetalleFactura_Cantidad,
    detalleFactura.precioUnitario AS DetalleFactura_PrecioUnitario,
    detalleFactura.subTotal AS DetalleFactura_SubTotal,
    detalleFactura.total AS DetalleFactura_Total,
    multa.id AS Multa_ID,
    multa.monto AS Multa_Monto,
    multa.fechaPago AS Multa_FechaPago,
    sancion.id AS Sancion_ID,
    sancion.tipo AS Sancion_Tipo,
    sancion.cantidadMultas AS Sancion_CantidadMultas
FROM factura
INNER JOIN detalleFactura ON factura.id = detalleFactura.factura_id
INNER JOIN formaPago ON factura.formaPago_id = formaPago.id
LEFT JOIN multa ON multa.usuario_id = factura.usuario_id
LEFT JOIN sancion ON sancion.usuario_id = factura.usuario_id
INNER JOIN usuario ON usuario.id = factura.usuario_id
INNER JOIN libroVendido ON libroVendido.usuario_id = usuario.id
INNER JOIN libro ON libro.id = libroVendido.libro_id
INNER JOIN persona ON usuario.persona_id = persona.id;
