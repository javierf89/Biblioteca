-- DDL for table Comentario_Valoraciones_Libros
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `Comentario_Valoraciones_Libros` AS select `libro`.`titulo` AS `Libro_Titulo`,`libro`.`isbn` AS `Libro_ISBN`,`libro`.`numEdicion` AS `Libro_NumEdicion`,`valoracion`.`estrella` AS `Valoracion_Estrella`,`comentario`.`tipo` AS `Comentario_Tipo`,`comentario`.`contenido` AS `Comentario_Contenido`,`persona`.`nombre1` AS `Persona_Nombre1`,`persona`.`apellido1` AS `Persona_Apellido1` from ((((`libro` join `valoracion` on((`valoracion`.`libro_id` = `libro`.`id`))) join `comentario` on(((`comentario`.`libro_id` = `libro`.`id`) and (`comentario`.`usuario_id` = `valoracion`.`usuario_id`)))) join `usuario` on((`usuario`.`id` = `valoracion`.`usuario_id`))) join `persona` on((`usuario`.`persona_id` = `persona`.`id`)));

-- DDL for table Editorial_Libro
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `Editorial_Libro` AS select `libro`.`titulo` AS `Titulo_Libro`,`libro`.`isbn` AS `ISBN`,max(`libroComprado`.`precio`) AS `Precio_Comprado_Libro`,`editorial`.`nombre` AS `Nombre_Editorial`,`editorial`.`correoElectronico` AS `Correo_Editorial`,max(`persona`.`nombre1`) AS `Nombre_Proveedor`,max(`persona`.`nombre2`) AS `Nombre2_Proveedor`,max(`persona`.`apellido1`) AS `Apellido1_Proveedor`,max(`persona`.`apellido2`) AS `Apellido2_Proveedor`,max(`direccionEditorial`.`pais`) AS `Pais_Editorial`,max(`direccionEditorial`.`ciudad`) AS `Ciudad_Editorial`,max(`direccionEditorial`.`referencia`) AS `Referencia_Editorial`,max(`direccionEditorial`.`codigoPostal`) AS `CodigoPostal_Editorial` from (((((((`libro` join `libroComprado` on((`libro`.`id` = `libroComprado`.`libro_id`))) join `editorial` on((`editorial`.`id` = `libro`.`editorial_id`))) join `Libro_Comprado_has_Proveedor` on((`Libro_Comprado_has_Proveedor`.`libro_comprado_id` = `libroComprado`.`id`))) join `proveedor` on((`Libro_Comprado_has_Proveedor`.`proveedor_id` = `proveedor`.`id`))) join `persona` on((`proveedor`.`persona_id` = `persona`.`id`))) join `Editorial_has_Direccion_Editorial` on((`Editorial_has_Direccion_Editorial`.`editorial_id` = `editorial`.`id`))) join `direccionEditorial` on((`direccionEditorial`.`id` = `Editorial_has_Direccion_Editorial`.`direccionEditorial_id`))) group by `libro`.`titulo`,`libro`.`isbn`,`editorial`.`nombre`,`editorial`.`correoElectronico`;

-- DDL for table Editorial_has_Direccion_Editorial
CREATE TABLE `Editorial_has_Direccion_Editorial` (
  `editorial_id` int NOT NULL COMMENT 'Identificador único para cada registro de la \ntabla Editorial.\r',
  `direccionEditorial_id` int NOT NULL COMMENT 'Identificador único para cada registro de la \ntabla Direccion_Editorial.',
  PRIMARY KEY (`editorial_id`,`direccionEditorial_id`),
  KEY `fk_Editorial_has_Direccion_Editorial_Direccion_Editorial1_idx` (`direccionEditorial_id`),
  KEY `fk_Editorial_has_Direccion_Editorial_Editorial1_idx` (`editorial_id`),
  CONSTRAINT `fk_Editorial_has_Direccion_Editorial_Direccion_Editorial1` FOREIGN KEY (`direccionEditorial_id`) REFERENCES `direccionEditorial` (`id`),
  CONSTRAINT `fk_Editorial_has_Direccion_Editorial_Editorial1` FOREIGN KEY (`editorial_id`) REFERENCES `editorial` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- DDL for table Editorial_has_Proveedor
CREATE TABLE `Editorial_has_Proveedor` (
  `editorial_id` int NOT NULL,
  `proveedor_id` int NOT NULL,
  PRIMARY KEY (`editorial_id`,`proveedor_id`),
  KEY `fk_Editorial_has_Proveedor_Proveedor1_idx` (`proveedor_id`),
  KEY `fk_Editorial_has_Proveedor_Editorial1_idx` (`editorial_id`),
  CONSTRAINT `fk_Editorial_has_Proveedor_Editorial1` FOREIGN KEY (`editorial_id`) REFERENCES `editorial` (`id`),
  CONSTRAINT `fk_Editorial_has_Proveedor_Proveedor1` FOREIGN KEY (`proveedor_id`) REFERENCES `proveedor` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- DDL for table Empleado_Info
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `Empleado_Info` AS select `empleado`.`id` AS `Empleado_ID`,`empleado`.`persona_id` AS `persona_id`,`cargo`.`nombre` AS `Cargo_Nombre`,`horarioEmpleado`.`turno` AS `turno`,`horarioEmpleado`.`horaIngreso` AS `horaIngreso`,`horarioEmpleado`.`horaEgreso` AS `horaEgreso`,`horarioEmpleado`.`cantidad` AS `Horas_Trabajadas`,`salario`.`hora_extra` AS `hora_extra`,`salario`.`bono` AS `bono`,`salario`.`catorceavo` AS `catorceavo`,`salario`.`deduccion` AS `deduccion`,`salario`.`total` AS `Salario_Total`,`salario`.`Fecha` AS `Fecha_Pago` from (((`empleado` join `cargo` on((`empleado`.`cargo_id` = `cargo`.`id`))) join `horarioEmpleado` on((`empleado`.`id` = `horarioEmpleado`.`empleado_id`))) join `salario` on((`cargo`.`salario_id` = `salario`.`id`)));

-- DDL for table Eventos_has_Horario_Biblioteca
CREATE TABLE `Eventos_has_Horario_Biblioteca` (
  `eventos_id` int NOT NULL,
  `horarioBiblioteca_id` int NOT NULL,
  PRIMARY KEY (`eventos_id`,`horarioBiblioteca_id`),
  KEY `fk_Eventos_has_Horario_Biblioteca_Horario_Biblioteca1_idx` (`horarioBiblioteca_id`),
  KEY `fk_Eventos_has_Horario_Biblioteca_Eventos1_idx` (`eventos_id`),
  CONSTRAINT `fk_Eventos_has_Horario_Biblioteca_Eventos1` FOREIGN KEY (`eventos_id`) REFERENCES `evento` (`id`),
  CONSTRAINT `fk_Eventos_has_Horario_Biblioteca_Horario_Biblioteca1` FOREIGN KEY (`horarioBiblioteca_id`) REFERENCES `horarioBiblioteca` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- DDL for table Formato_Libro_has_Libro
CREATE TABLE `Formato_Libro_has_Libro` (
  `formatoLibro_id` int NOT NULL COMMENT 'Identificador único para cada registro de la \ntabla Formato_Libro.',
  `libro_id` int NOT NULL COMMENT 'Identificador único para cada registro de la \ntabla Libro',
  PRIMARY KEY (`formatoLibro_id`,`libro_id`),
  KEY `fk_Formato_Libro_has_Libro_Libro1_idx` (`libro_id`),
  KEY `fk_Formato_Libro_has_Libro_Formato_Libro1_idx` (`formatoLibro_id`),
  CONSTRAINT `fk_Formato_Libro_has_Libro_Formato_Libro1` FOREIGN KEY (`formatoLibro_id`) REFERENCES `formatoLibro` (`id`),
  CONSTRAINT `fk_Formato_Libro_has_Libro_Libro1` FOREIGN KEY (`libro_id`) REFERENCES `libro` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- DDL for table Libro_Comprado_has_Proveedor
CREATE TABLE `Libro_Comprado_has_Proveedor` (
  `libro_comprado_id` int NOT NULL COMMENT 'Identificador único para cada registro de\nla tabla Libro_Comprado.',
  `proveedor_id` int NOT NULL COMMENT 'Identificador único para cada registro de\nla tabla Proveedor.',
  PRIMARY KEY (`libro_comprado_id`,`proveedor_id`),
  KEY `fk_Libro_Comprado_has_Proveedor_Proveedor1_idx` (`proveedor_id`),
  KEY `fk_Libro_Comprado_has_Proveedor_Libro_Comprado1_idx` (`libro_comprado_id`),
  CONSTRAINT `fk_Libro_Comprado_has_Proveedor_Libro_Comprado1` FOREIGN KEY (`libro_comprado_id`) REFERENCES `libroComprado` (`id`),
  CONSTRAINT `fk_Libro_Comprado_has_Proveedor_Proveedor1` FOREIGN KEY (`proveedor_id`) REFERENCES `proveedor` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- DDL for table Libro_has_Autor
CREATE TABLE `Libro_has_Autor` (
  `libro_id` int NOT NULL COMMENT 'Identificador único para cada registro de la \ntabla Libro.\r',
  `autor_id` int NOT NULL COMMENT 'Identificador único para cada registro de la \ntabla Autor',
  PRIMARY KEY (`libro_id`,`autor_id`),
  KEY `fk_Libro_has_Autor_Autor1_idx` (`autor_id`),
  KEY `fk_Libro_has_Autor_Libro1_idx` (`libro_id`),
  CONSTRAINT `fk_Libro_has_Autor_Autor1` FOREIGN KEY (`autor_id`) REFERENCES `autor` (`id`),
  CONSTRAINT `fk_Libro_has_Autor_Libro1` FOREIGN KEY (`libro_id`) REFERENCES `libro` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- DDL for table Libros_Disponibles
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `Libros_Disponibles` AS select `libro`.`id` AS `id`,`libro`.`titulo` AS `titulo`,`libro`.`isbn` AS `isbn`,`libro`.`numPaginas` AS `numPaginas`,`libro`.`imagen` AS `imagen`,`libro`.`url` AS `url`,`editorial`.`nombre` AS `Nombre_Editorial`,`persona`.`nombre1` AS `Nombre_Autor`,`persona`.`apellido1` AS `Apellido_Autor`,`formatoLibro`.`precio` AS `precio` from ((((((`libro` join `editorial` on((`libro`.`editorial_id` = `editorial`.`id`))) join `Libro_has_Autor` `la` on((`la`.`libro_id` = `libro`.`id`))) join `autor` on((`autor`.`id` = `la`.`autor_id`))) join `persona` on((`persona`.`id` = `autor`.`persona_id`))) join `Formato_Libro_has_Libro` on((`Formato_Libro_has_Libro`.`libro_id` = `libro`.`id`))) join `formatoLibro` on((`formatoLibro`.`id` = `Formato_Libro_has_Libro`.`formatoLibro_id`))) where (`libro`.`id` in (select `prestamo`.`libro_id` from `prestamo`) is false and `libro`.`id` in (select `libroPerdido`.`libro_id` from `libroPerdido`) is false and `libro`.`id` in (select `libroVendido`.`libro_id` from `libroVendido`) is false);

-- DDL for table Libros_Donados
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `Libros_Donados` AS select `libro`.`id` AS `Libro_ID`,`libro`.`titulo` AS `Titulo_Libro`,`libro`.`isbn` AS `ISBN_Libro`,`libro`.`url` AS `url`,`libro`.`imagen` AS `imagen`,`persona`.`nombre1` AS `Nombre_Usuario`,`persona`.`apellido1` AS `Apellido_Usuario` from ((`donacion` join `libro` on((`donacion`.`libro_id` = `libro`.`id`))) join `persona` on((`donacion`.`persona_id` = `persona`.`id`))) order by `persona`.`nombre1`;

-- DDL for table Libros_Perdidos_Por_Usuario
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `Libros_Perdidos_Por_Usuario` AS select `libro`.`id` AS `Libro_ID`,`libro`.`titulo` AS `Titulo_Libro`,`libro`.`isbn` AS `ISBN_Libro`,`usuario`.`id` AS `Usuario_ID`,`persona`.`nombre1` AS `Nombre_Usuario`,`persona`.`apellido1` AS `Apellido_Usuario` from (((`libroPerdido` join `libro` on((`libroPerdido`.`libro_id` = `libro`.`id`))) join `usuario` on((`libroPerdido`.`usuario_id` = `usuario`.`id`))) join `persona` on((`usuario`.`persona_id` = `persona`.`id`))) order by `persona`.`nombre1`;

-- DDL for table Membresia_has_Descuento
CREATE TABLE `Membresia_has_Descuento` (
  `membresia_id` int NOT NULL COMMENT 'Identificador único para cada registro de la \ntabla Membresia.',
  `descuento_id` int NOT NULL COMMENT 'Identificador único para cada registro de la \ntabla Descuento.\n',
  PRIMARY KEY (`membresia_id`,`descuento_id`),
  KEY `fk_Membresía_has_Descuento_Descuento1_idx` (`descuento_id`),
  KEY `fk_Membresía_has_Descuento_Membresía1_idx` (`membresia_id`),
  CONSTRAINT `fk_Membresía_has_Descuento_Descuento1` FOREIGN KEY (`descuento_id`) REFERENCES `descuento` (`id`),
  CONSTRAINT `fk_Membresía_has_Descuento_Membresía1` FOREIGN KEY (`membresia_id`) REFERENCES `membresia` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- DDL for table Prestamos_Activos
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `Prestamos_Activos` AS select `prestamo`.`id` AS `id`,`persona`.`nombre1` AS `nombre1`,`persona`.`nombre2` AS `nombre2`,`persona`.`apellido1` AS `apellido1`,`persona`.`apellido2` AS `apellido2`,`libro`.`titulo` AS `titulo`,`libro`.`imagen` AS `imagen`,`libro`.`url` AS `url`,`prestamo`.`fechaPrestamo` AS `fechaPrestamo`,`prestamo`.`fechaRegreso` AS `fechaRegreso` from (((`prestamo` join `usuario` on((`prestamo`.`usuario_id` = `usuario`.`id`))) join `persona` on((`usuario`.`persona_id` = `persona`.`id`))) join `libro` on((`prestamo`.`libro_id` = `libro`.`id`)));

-- DDL for table SubArea_has_Autor
CREATE TABLE `SubArea_has_Autor` (
  `subArea_id` int NOT NULL COMMENT 'Identificador único para cada registro de la \ntabla SubArea.',
  `autor_id` int NOT NULL COMMENT 'Identificador único para cada registro de la \ntabla Autor.\n',
  PRIMARY KEY (`subArea_id`,`autor_id`),
  KEY `fk_SubArea_has_Autor_Autor1_idx` (`autor_id`),
  KEY `fk_SubArea_has_Autor_SubArea1_idx` (`subArea_id`),
  CONSTRAINT `fk_SubArea_has_Autor_Autor1` FOREIGN KEY (`autor_id`) REFERENCES `autor` (`id`),
  CONSTRAINT `fk_SubArea_has_Autor_SubArea1` FOREIGN KEY (`subArea_id`) REFERENCES `subArea` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- DDL for table VistaLibrosCubiculos
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `VistaLibrosCubiculos` AS select `libro`.`titulo` AS `Titulo_Libro`,`persona`.`nombre1` AS `Nombre_Autor`,`persona`.`apellido1` AS `Apellido_Autor`,`autor`.`nacionalidad` AS `Nacionalidad_Autor`,`estante`.`numEstannte` AS `Estante`,`estante`.`ubicacion` AS `Ubicacion_Estante`,`cubiculo`.`posicion` AS `Cubiculo_Posicion`,`cubiculo`.`ubicacion` AS `Cubiculo_Ubicacion`,`categoria`.`nombre` AS `Nombre_Categoria` from ((((((((`libro` join `libro_has_cubiculo` `lc` on((`lc`.`libro_id` = `libro`.`id`))) join `cubiculo` on((`lc`.`cubiculo_id` = `cubiculo`.`id`))) join `Libro_has_Autor` `la` on((`la`.`libro_id` = `libro`.`id`))) join `autor` on((`autor`.`id` = `la`.`autor_id`))) join `estante` on((`estante`.`id` = `cubiculo`.`estante_id`))) join `persona` on((`persona`.`id` = `autor`.`persona_id`))) join `categoria_has_libro` `cl` on((`cl`.`libro_id` = `libro`.`id`))) join `categoria` on((`cl`.`categoría_id` = `categoria`.`id`))) order by `categoria`.`nombre`;

-- DDL for table Vista_Factura
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `Vista_Factura` AS select `factura`.`id` AS `Factura_ID`,`persona`.`nombre1` AS `Nombre_Usuario`,`persona`.`apellido1` AS `Apellido_Usuario`,`libro`.`titulo` AS `Libro_Vendido`,`factura`.`fechaEmision` AS `Factura_FechaEmision`,`factura`.`formaPago_id` AS `FormaPago_ID`,`formaPago`.`tipo` AS `FormaPago_Tipo`,`detalleFactura`.`descripcion` AS `DetalleFactura_Descripcion`,`detalleFactura`.`cantidad` AS `DetalleFactura_Cantidad`,`detalleFactura`.`precioUnitario` AS `DetalleFactura_PrecioUnitario`,`detalleFactura`.`subTotal` AS `DetalleFactura_SubTotal`,`detalleFactura`.`total` AS `DetalleFactura_Total`,`multa`.`id` AS `Multa_ID`,`multa`.`monto` AS `Multa_Monto`,`multa`.`fechaPago` AS `Multa_FechaPago`,`sancion`.`id` AS `Sancion_ID`,`sancion`.`tipo` AS `Sancion_Tipo`,`sancion`.`cantidadMultas` AS `Sancion_CantidadMultas` from ((((((((`factura` join `detalleFactura` on((`factura`.`id` = `detalleFactura`.`factura_id`))) join `formaPago` on((`factura`.`formaPago_id` = `formaPago`.`id`))) left join `multa` on((`multa`.`usuario_id` = `factura`.`usuario_id`))) left join `sancion` on((`sancion`.`usuario_id` = `factura`.`usuario_id`))) join `usuario` on((`usuario`.`id` = `factura`.`usuario_id`))) join `libroVendido` on((`libroVendido`.`usuario_id` = `usuario`.`id`))) join `libro` on((`libro`.`id` = `libroVendido`.`libro_id`))) join `persona` on((`usuario`.`persona_id` = `persona`.`id`)));

-- DDL for table Vista_Usuario
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `Vista_Usuario` AS select `persona`.`nombre1` AS `nombre1`,`persona`.`nombre2` AS `nombre2`,`persona`.`apellido1` AS `apellido1`,`persona`.`apellido2` AS `apellido2`,`telefono`.`numTelefono` AS `numTelefono`,`telefono`.`tipo` AS `tipo_Telefono`,`telefono`.`operador` AS `operador`,`membresia`.`tipo` AS `Tipo_membresia`,`membresia`.`duracion` AS `Duracion_membresia`,`sancion`.`tipo` AS `Tipo_sancion`,`sancion`.`cantidadMultas` AS `cantidadMultas`,`multa`.`fechaPago` AS `Fecha_pago_multa`,`multa`.`motivo` AS `Motivo_multa`,`multa`.`monto` AS `Monto_multa`,`libro`.`titulo` AS `Titulo_Libro` from (((((((`persona` join `usuario` on((`usuario`.`persona_id` = `persona`.`id`))) join `telefono` on((`telefono`.`persona_id` = `persona`.`id`))) join `membresia` on((`membresia`.`usuario_id` = `usuario`.`id`))) join `sancion` on((`sancion`.`usuario_id` = `usuario`.`id`))) join `multa` on((`multa`.`usuario_id` = `usuario`.`id`))) join `libroPerdido` on((`sancion`.`libroPerdido_id` = `libroPerdido`.`id`))) join `libro` on((`libro`.`id` = `libroPerdido`.`libro_id`))) order by `persona`.`nombre1`;

-- DDL for table area
CREATE TABLE `area` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'Identificador único para cada registro \nen la tabla Área.',
  `nombre` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'Nombre del Área de división de libros \nen la biblioteca.',
  `ubicacion` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'Ubicación del Área dentro de la \nbiblioteca.',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- DDL for table autor
CREATE TABLE `autor` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'Identificador único para cada registro \nen la tabla Autor.',
  `nacionalidad` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'Nacionalidad del Autor',
  `persona_id` int NOT NULL COMMENT 'Asociación con Persona, un Autor es \nuna Persona',
  PRIMARY KEY (`id`),
  KEY `fk_Autor_Persona1_idx` (`persona_id`),
  CONSTRAINT `fk_Autor_Persona1` FOREIGN KEY (`persona_id`) REFERENCES `persona` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=77 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- DDL for table biblioteca
CREATE TABLE `biblioteca` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'Identificador único para cada \nregistro en la tabla biblioteca.',
  `nombre` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'Nombre de la Biblioteca',
  `direccion` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'Dirección de la Biblioteca\n',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- DDL for table cargo
CREATE TABLE `cargo` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'Identificador único para cada registro en \nla tabla Cargo',
  `salario_id` int NOT NULL COMMENT 'Salario asociado al cargo desempeñado \npor el empleado',
  `nombre` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'Nombre del cargo desempeñado por el \nempleado.\n',
  PRIMARY KEY (`id`),
  KEY `fk_Cargo_Salario1_idx` (`salario_id`),
  CONSTRAINT `fk_Cargo_Salario1` FOREIGN KEY (`salario_id`) REFERENCES `salario` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- DDL for table categoria
CREATE TABLE `categoria` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'Identificador único para cada registro en la \ntabla Cargo',
  `nombre` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'Nombre de la categoría de división de libros \ndentro de la biblioteca.',
  `descripcion` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'Descripción de la categoría',
  `area_id` int NOT NULL COMMENT 'Área asociada a la categoría divisoria.',
  PRIMARY KEY (`id`),
  KEY `fk_Categoría_Area1_idx` (`area_id`),
  CONSTRAINT `fk_Categoría_Area1` FOREIGN KEY (`area_id`) REFERENCES `area` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- DDL for table categoria_con_Libro
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `categoria_con_Libro` AS select `categoria`.`nombre` AS `Nombre_Categoria`,`libro`.`titulo` AS `titulo`,`libro`.`isbn` AS `isbn`,`libro`.`numPaginas` AS `numPaginas`,`editorial`.`nombre` AS `Nombre_Editorial` from (((`libro` join `categoria_has_libro` on((`libro`.`id` = `categoria_has_libro`.`libro_id`))) join `categoria` on((`categoria_has_libro`.`categoría_id` = `categoria`.`id`))) join `editorial` on((`libro`.`editorial_id` = `editorial`.`id`)));

-- DDL for table categoria_has_libro
CREATE TABLE `categoria_has_libro` (
  `categoría_id` int NOT NULL COMMENT 'Identificador único para cada registro de la tabla\nCategoría.',
  `libro_id` int NOT NULL COMMENT 'Identificador único para cada registro de la tabla\nLibro.',
  PRIMARY KEY (`categoría_id`,`libro_id`),
  KEY `fk_Categoría_has_Libro_Libro1_idx` (`libro_id`),
  KEY `fk_Categoría_has_Libro_Categoría1_idx` (`categoría_id`),
  CONSTRAINT `fk_Categoría_has_Libro_Categoría1` FOREIGN KEY (`categoría_id`) REFERENCES `categoria` (`id`),
  CONSTRAINT `fk_Categoría_has_Libro_Libro1` FOREIGN KEY (`libro_id`) REFERENCES `libro` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- DDL for table comentario
CREATE TABLE `comentario` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'Identificador único para cada registro en \nla tabla Comentario.',
  `tipo` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'Categoría de comentario.',
  `contenido` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'Contenido/Cuerpo del comentario',
  `usuario_id` int NOT NULL COMMENT 'Usuario asociado a comentario.',
  `libro_id` int NOT NULL COMMENT 'Libro asociado a comentario.\r',
  PRIMARY KEY (`id`),
  KEY `fk_Comentario_Usuario1_idx` (`usuario_id`),
  KEY `fk_Comentario_Libro1_idx` (`libro_id`),
  CONSTRAINT `fk_Comentario_Libro1` FOREIGN KEY (`libro_id`) REFERENCES `libro` (`id`),
  CONSTRAINT `fk_Comentario_Usuario1` FOREIGN KEY (`usuario_id`) REFERENCES `usuario` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- DDL for table cubiculo
CREATE TABLE `cubiculo` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'Identificador único para cada registro en \nla tabla cubículo',
  `posicion` int NOT NULL COMMENT 'Posición del cubículo en el estante \nasociado.',
  `ubicacion` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'Ubicación del cubículo dentro del estante.\r',
  `estante_id` int NOT NULL COMMENT 'Estante asociado al cubículo\n',
  PRIMARY KEY (`id`),
  KEY `fk_Cubículo_Estante1_idx` (`estante_id`),
  CONSTRAINT `fk_Cubículo_Estante1` FOREIGN KEY (`estante_id`) REFERENCES `estante` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=114 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- DDL for table descuento
CREATE TABLE `descuento` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'Identificador único para cada registro en \nla tabla descuento',
  `fechaInicio` date NOT NULL COMMENT 'Fecha de inicio de establecimiento del \ndescuento.',
  `fechaFin` date NOT NULL COMMENT 'Fecha de finalización de establecimiento \ndel descuento',
  `tipoDescuento` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'Tipo de Descuento, dependiendo de la \\nmembresía aplicada en la compra del usuario.\nDescuento por volumen: 10%\nDescuento por pronto pago: 5%\nDescuento promocional: 20%\nDescuento por fidelidad: 15%\nDescuento estacional: 25%\nDescuento por defectos: 30%\nDescuento por introducción: 10%',
  `porcentaje` double NOT NULL COMMENT 'Porcentaje del descuento',
  `detalleFactura_id` int NOT NULL COMMENT 'Detalles de Factura asociados a \ndescuento.\n',
  PRIMARY KEY (`id`),
  KEY `fk_Descuento_Detalle_Factura1_idx` (`detalleFactura_id`),
  CONSTRAINT `fk_Descuento_Detalle_Factura1` FOREIGN KEY (`detalleFactura_id`) REFERENCES `detalleFactura` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- DDL for table detalleFactura
CREATE TABLE `detalleFactura` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'Identificador único para cada \nregistro en la tabla Detalle_Factura',
  `descripcion` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'Descripción de Factura',
  `cantidad` int NOT NULL COMMENT 'Cantidad de libros vendidos.\r',
  `precioUnitario` double NOT NULL COMMENT 'Precio Unitario de los libros.',
  `subTotal` double NOT NULL COMMENT 'Total, antes de impuestos y \\ndescuentos.',
  `total` double NOT NULL COMMENT 'Total después de impuestos y \\ndescuentos.',
  `factura_id` int NOT NULL COMMENT 'Factura asociada de detalles de \nespecificación de venta.\r',
  `libroVendido_id` int NOT NULL COMMENT 'Libro vendido asociado de detalles \nde especificación de venta.',
  `membresía_id` int NOT NULL COMMENT 'Membresía asociada de detalles de \nespecificación de venta',
  PRIMARY KEY (`id`),
  KEY `fk_Detalle_Factura_Factura1_idx` (`factura_id`),
  KEY `fk_Detalle_Factura_Libro_Vendido1_idx` (`libroVendido_id`),
  KEY `fk_Detalle_Factura_Membresía1_idx` (`membresía_id`),
  CONSTRAINT `fk_Detalle_Factura_Factura1` FOREIGN KEY (`factura_id`) REFERENCES `factura` (`id`),
  CONSTRAINT `fk_Detalle_Factura_Libro_Vendido1` FOREIGN KEY (`libroVendido_id`) REFERENCES `libroVendido` (`id`),
  CONSTRAINT `fk_Detalle_Factura_Membresía1` FOREIGN KEY (`membresía_id`) REFERENCES `membresia` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=64 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- DDL for table devolucion
CREATE TABLE `devolucion` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'Identificador único para cada registro en \nla tabla Devolución. ',
  `estadoLibro` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'Estado de libro devuelto.',
  `causa` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'Justificación de devolución',
  `costoDevolucion` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'Costo aplicado a la devolución del libro',
  `usuario_id` int NOT NULL COMMENT 'Usuario asociado a devolución realizada.',
  PRIMARY KEY (`id`),
  KEY `fk_Devolución_Usuario1_idx` (`usuario_id`),
  CONSTRAINT `fk_Devolución_Usuario1` FOREIGN KEY (`usuario_id`) REFERENCES `usuario` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- DDL for table direccionEditorial
CREATE TABLE `direccionEditorial` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'Identificador único para cada registro \nen la tabla Direccion_Editorial\r',
  `pais` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'País asociado a la dirección.',
  `estados` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'Estado/Provincia asociado a la \\ndirección.',
  `ciudad` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'Ciudad asociada a la dirección.',
  `calle` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'Calle asociada a la dirección.',
  `numero` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'Numero de edificación asociada a la \ndirección.',
  `codigoPostal` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'Código Postal asociado a la dirección.',
  `referencia` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'Referencia informal asociada a la \ndirección.',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- DDL for table direccionPersona
CREATE TABLE `direccionPersona` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'Identificador único para cada \nregistro en la tabla \nDireccion_Persona.',
  `pais` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'País asociado a la dirección.',
  `estado` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'Estado/Provincia asociado a la \\ndirección.\\r',
  `ciudad` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'Ciudad asociada a la dirección.',
  `calle` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'Calle asociada a la dirección.',
  `numero` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'Numero de edificación asociada a la \ndirección.\r',
  `codigoPostal` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'Código Postal asociado a la \ndirección.',
  `referencia` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'Referencia informal asociada a la \ndirección.\r',
  `persona_id` int NOT NULL COMMENT 'Persona asociada a su dirección. ',
  PRIMARY KEY (`id`),
  KEY `fk_Direccion_Persona_Persona1_idx` (`persona_id`),
  CONSTRAINT `fk_Direccion_Persona_Persona1` FOREIGN KEY (`persona_id`) REFERENCES `persona` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- DDL for table donacion
CREATE TABLE `donacion` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'Identificador único para cada registro en la \ntabla Donación.',
  `libro_id` int NOT NULL COMMENT 'Libro asociado a donación realizada.\r',
  `persona_id` int NOT NULL COMMENT 'Persona asociada a la donación efectuada.\n',
  PRIMARY KEY (`id`),
  KEY `fk_Donación_Libro1_idx` (`libro_id`),
  KEY `fk_Donación_Persona1_idx` (`persona_id`),
  CONSTRAINT `fk_Donación_Libro1` FOREIGN KEY (`libro_id`) REFERENCES `libro` (`id`),
  CONSTRAINT `fk_Donación_Persona1` FOREIGN KEY (`persona_id`) REFERENCES `persona` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- DDL for table editorial
CREATE TABLE `editorial` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'Identificador único para cada registro \nen la tabla Editorial.',
  `nombre` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'Nombre de la Editorial.\r',
  `correoElectronico` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'Correo Electrónico de la Editorial',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- DDL for table empleado
CREATE TABLE `empleado` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'Identificador único para cada registro en la \ntabla Empleado.',
  `persona_id` int NOT NULL COMMENT 'Un empleado es una persona.',
  `cargo_id` int NOT NULL COMMENT 'Un empleado desempeña un cargo.',
  PRIMARY KEY (`id`),
  KEY `fk_Empleado_Persona1_idx` (`persona_id`),
  KEY `fk_Empleado_Cargo1_idx` (`cargo_id`),
  CONSTRAINT `fk_Empleado_Cargo1` FOREIGN KEY (`cargo_id`) REFERENCES `cargo` (`id`),
  CONSTRAINT `fk_Empleado_Persona1` FOREIGN KEY (`persona_id`) REFERENCES `persona` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- DDL for table estadoCuenta
CREATE TABLE `estadoCuenta` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'Identificador único para cada registro en la \ntabla Estado_Cuenta',
  `tipo` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'Tipo de Estado. \n\nDonde A=Activo y I=Inactivo',
  `motivo` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'Motivo de Estado de Cuenta.',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- DDL for table estante
CREATE TABLE `estante` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'Identificador único para cada registro en \nla tabla Estante.',
  `numEstannte` int NOT NULL COMMENT 'Numero asociado a estante.',
  `cantidadCubiculo` int NOT NULL COMMENT 'Cantidad de cubículos que conforman el \nestante.',
  `ubicacion` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'Ubicación de estante dentro de la \nbiblioteca\r',
  `area_id` int NOT NULL COMMENT 'Área en la biblioteca asociada a estante.\r',
  `biblioteca_id` int NOT NULL COMMENT 'Biblioteca asociada al estante.\n',
  PRIMARY KEY (`id`),
  KEY `fk_Estante_Area1_idx` (`area_id`),
  KEY `fk_Estante_Biblioteca1_idx` (`biblioteca_id`),
  CONSTRAINT `fk_Estante_Area1` FOREIGN KEY (`area_id`) REFERENCES `area` (`id`),
  CONSTRAINT `fk_Estante_Biblioteca1` FOREIGN KEY (`biblioteca_id`) REFERENCES `biblioteca` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- DDL for table evento
CREATE TABLE `evento` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'Identificador único para cada registro en \nla tabla Evento',
  `tipo` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'Tipo de evento a realizar.',
  `fecha` date NOT NULL COMMENT 'Fecha del evento.',
  `horaInicio` time DEFAULT NULL,
  `horaFin` time DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- DDL for table factura
CREATE TABLE `factura` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'Identificador único para cada registro en la \ntabla Factura',
  `fechaEmision` datetime DEFAULT NULL,
  `formaPago_id` int NOT NULL,
  `usuario_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_factura_formaPago1_idx` (`formaPago_id`),
  KEY `fk_factura_usuario1_idx` (`usuario_id`),
  CONSTRAINT `fk_factura_formaPago1` FOREIGN KEY (`formaPago_id`) REFERENCES `formaPago` (`id`),
  CONSTRAINT `fk_factura_usuario1` FOREIGN KEY (`usuario_id`) REFERENCES `usuario` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=76 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- DDL for table formaPago
CREATE TABLE `formaPago` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'Identificador único para cada registro en \nla tabla Forma_de_Pago\r',
  `tipo` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'Tipo de forma de pago.\n',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- DDL for table formatoLibro
CREATE TABLE `formatoLibro` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'Identificador único para cada registro en la \ntabla Formato_Libro',
  `tipo` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'Tipo de formato de libro',
  `observacion` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `precio` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'Precio aplicado sobre el formato del libro.',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=319 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- DDL for table horarioBiblioteca
CREATE TABLE `horarioBiblioteca` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'Identificador único para cada registro en \nla tabla Horario_Biblioteca',
  `fecha` date NOT NULL COMMENT 'Fecha de aplicación del Horario',
  `horaApertura` datetime NOT NULL COMMENT 'Hora de apertura de la biblioteca.\r',
  `horaCierre` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'Hora de cierre de la biblioteca.\r',
  `biblioteca_id` int NOT NULL COMMENT 'Biblioteca asociada a su horario.',
  PRIMARY KEY (`id`),
  KEY `fk_Horario_Biblioteca_Biblioteca1_idx` (`biblioteca_id`),
  CONSTRAINT `fk_Horario_Biblioteca_Biblioteca1` FOREIGN KEY (`biblioteca_id`) REFERENCES `biblioteca` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- DDL for table horarioEmpleado
CREATE TABLE `horarioEmpleado` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'Identificador único para cada registro en \nla tabla Horario_Empleado\r',
  `turno` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'Turno del empleado.\r',
  `horaIngreso` datetime NOT NULL COMMENT 'Hora de ingreso del empleado.\r',
  `horaEgreso` datetime DEFAULT NULL COMMENT 'Hora de egreso del empleado',
  `cantidad` int DEFAULT NULL COMMENT 'Cantidad de horas trabajadas.\r',
  `empleado_id` int NOT NULL COMMENT 'Empleado asociado a su horario.\r',
  PRIMARY KEY (`id`),
  KEY `fk_Horario_Empleado_Empleado1_idx` (`empleado_id`),
  CONSTRAINT `fk_Horario_Empleado_Empleado1` FOREIGN KEY (`empleado_id`) REFERENCES `empleado` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- DDL for table impuesto
CREATE TABLE `impuesto` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'Identificador único para cada registro \nen la tabla Impuesto',
  `tipo` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'Tipo de impuesto.\r',
  `porcentajeImpuesto` int NOT NULL COMMENT 'Porcentaje a aplicar en impuesto.',
  `detalleFactura_ID` int NOT NULL COMMENT 'Detalle de facturación asociado a \nimpuesto sobre factura.\n',
  PRIMARY KEY (`id`),
  KEY `fk_Impuesto_Detalle_Factura1_idx` (`detalleFactura_ID`),
  CONSTRAINT `fk_Impuesto_Detalle_Factura1` FOREIGN KEY (`detalleFactura_ID`) REFERENCES `detalleFactura` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- DDL for table libro
CREATE TABLE `libro` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'Identificador único para cada registro \nen la tabla Libro.\r',
  `titulo` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'Título del libro.',
  `fecha_publicacion` date NOT NULL COMMENT 'Fecha de Publicación del libro',
  `idioma` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'Idioma del libro.',
  `isbn` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'ISBN (International Standard Book \nNumber) es un código normalizado \ninternacional para libros.\r',
  `numEdicion` int NOT NULL COMMENT 'Numero de edición.\r',
  `numPaginas` int NOT NULL COMMENT 'Número de páginas que conforman el \nlibro.\r',
  `url` varchar(1500) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `editorial_id` int NOT NULL COMMENT 'Editorial asociada al libro.',
  `biblioteca_id` int NOT NULL COMMENT 'Biblioteca asociada al libro.',
  `imagen` longblob,
  PRIMARY KEY (`id`),
  KEY `fk_Libro_Editorial1_idx` (`editorial_id`),
  KEY `fk_Libro_Biblioteca1_idx` (`biblioteca_id`),
  CONSTRAINT `fk_Libro_Biblioteca1` FOREIGN KEY (`biblioteca_id`) REFERENCES `biblioteca` (`id`),
  CONSTRAINT `fk_Libro_Editorial1` FOREIGN KEY (`editorial_id`) REFERENCES `editorial` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=164 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- DDL for table libroComprado
CREATE TABLE `libroComprado` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'Identificador único para cada registro en \nla tabla Libro',
  `precio` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'Precio de libro comprado.',
  `libro_id` int NOT NULL COMMENT 'Libro asociado a Libro comprado.\n',
  PRIMARY KEY (`id`),
  KEY `fk_Libro_Comprado_Libro1_idx` (`libro_id`),
  CONSTRAINT `fk_Libro_Comprado_Libro1` FOREIGN KEY (`libro_id`) REFERENCES `libro` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=233 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- DDL for table libroPerdido
CREATE TABLE `libroPerdido` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'Identificador único para cada registro en la \ntabla Libros_Perdidos',
  `libro_id` int NOT NULL COMMENT 'Libro asociado libro perdido',
  `usuario_id` int NOT NULL COMMENT 'Usuario asociado a libro perdido.',
  PRIMARY KEY (`id`),
  KEY `fk_Libros_Perdidos_Libro1_idx` (`libro_id`),
  KEY `fk_Libros_Perdidos_Usuario1_idx` (`usuario_id`),
  CONSTRAINT `fk_Libros_Perdidos_Libro1` FOREIGN KEY (`libro_id`) REFERENCES `libro` (`id`),
  CONSTRAINT `fk_Libros_Perdidos_Usuario1` FOREIGN KEY (`usuario_id`) REFERENCES `usuario` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- DDL for table libroVendido
CREATE TABLE `libroVendido` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'Identificador único para cada registro en la \ntabla Libro_Vendido',
  `libro_id` int NOT NULL COMMENT 'Libro asociado a venta.\r',
  `usuario_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_Libro_Vendido_Libro1_idx` (`libro_id`),
  KEY `fk_libroVendido_usuario1_idx` (`usuario_id`),
  CONSTRAINT `fk_Libro_Vendido_Libro1` FOREIGN KEY (`libro_id`) REFERENCES `libro` (`id`),
  CONSTRAINT `fk_libroVendido_usuario1` FOREIGN KEY (`usuario_id`) REFERENCES `usuario` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=84 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- DDL for table libro_has_cubiculo
CREATE TABLE `libro_has_cubiculo` (
  `libro_id` int NOT NULL,
  `cubiculo_id` int NOT NULL,
  PRIMARY KEY (`libro_id`,`cubiculo_id`),
  KEY `fk_libro_has_cubiculo_cubiculo1_idx` (`cubiculo_id`),
  KEY `fk_libro_has_cubiculo_libro1_idx` (`libro_id`),
  CONSTRAINT `fk_libro_has_cubiculo_cubiculo1` FOREIGN KEY (`cubiculo_id`) REFERENCES `cubiculo` (`id`),
  CONSTRAINT `fk_libro_has_cubiculo_libro1` FOREIGN KEY (`libro_id`) REFERENCES `libro` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- DDL for table membresia
CREATE TABLE `membresia` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'Identificador único para cada registro en \nla tabla Membresía.\r',
  `tipo` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'Identificador único para cada registro en \nla tabla Membresía.\r\nTipos de Membresias: Platinum (PL), Premium(PR), Basica (BA)',
  `duracion` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'Duración de la membresía.',
  `usuario_id` int NOT NULL COMMENT 'Usuario asociado a una membresía.',
  `porcentaje` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_Membresía_Usuario1_idx` (`usuario_id`),
  CONSTRAINT `fk_Membresía_Usuario1` FOREIGN KEY (`usuario_id`) REFERENCES `usuario` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=58 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- DDL for table multa
CREATE TABLE `multa` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'Identificador único para cada registro en la \ntabla Multa\r',
  `monto` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'Monto a pagar por multa aplicada.',
  `fechaPago` date NOT NULL COMMENT 'Fecha de pago de la multa.',
  `motivo` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'Motivo, justificación de la multa aplicada.\r',
  `usuario_id` int NOT NULL COMMENT 'Usuario asociado a multa aplicada.\r',
  PRIMARY KEY (`id`),
  KEY `fk_Multa_Usuario1_idx` (`usuario_id`),
  CONSTRAINT `fk_Multa_Usuario1` FOREIGN KEY (`usuario_id`) REFERENCES `usuario` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- DDL for table persona
CREATE TABLE `persona` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'Identificador único para cada \nregistro en la tabla Persona.',
  `nombre1` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'Primer nombre de la persona.',
  `nombre2` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'Segundo y/o tercer nombre de la \npersona.',
  `apellido1` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'Primer apellido de la persona.',
  `apellido2` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'Segundo y/o tercer apellido de la \npersona.',
  `correoElectronico` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'Correo electrónico de la persona',
  `fechaNacimiento` date DEFAULT NULL COMMENT 'Fecha de nacimiento de la persona.\n',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=147 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- DDL for table prestamo
CREATE TABLE `prestamo` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'Identificador único para cada registro en \nla tabla Préstamo.',
  `fechaPrestamo` date NOT NULL COMMENT 'Fecha de adquisición de préstamo.\r',
  `fechaRegreso` date NOT NULL COMMENT 'Fecha de retorno del préstamo.\r',
  `estadoPrestamo` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'Estado de préstamo del libro.\r',
  `usuario_id` int NOT NULL COMMENT 'Usuario asociado a préstamo.\r',
  `libro_id` int NOT NULL COMMENT 'Libro asociado a préstamo.\r',
  PRIMARY KEY (`id`),
  KEY `fk_Préstamo_Usuario1_idx` (`usuario_id`),
  KEY `fk_Préstamo_Libro1_idx` (`libro_id`),
  CONSTRAINT `fk_Préstamo_Libro1` FOREIGN KEY (`libro_id`) REFERENCES `libro` (`id`),
  CONSTRAINT `fk_Préstamo_Usuario1` FOREIGN KEY (`usuario_id`) REFERENCES `usuario` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- DDL for table proveedor
CREATE TABLE `proveedor` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'Identificador único para cada registro en la \ntabla Proveedor.',
  `persona_id` int NOT NULL COMMENT 'Un proveedor es una persona.\r',
  PRIMARY KEY (`id`),
  KEY `fk_Proveedor_Persona1_idx` (`persona_id`),
  CONSTRAINT `fk_Proveedor_Persona1` FOREIGN KEY (`persona_id`) REFERENCES `persona` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- DDL for table salario
CREATE TABLE `salario` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'Identificador único para cada \nregistro en la tabla Salario.\r',
  `hora_extra` int DEFAULT NULL COMMENT 'Horas extras asociadas al salario.',
  `bono` double DEFAULT NULL COMMENT 'Bonos asociados.\r',
  `catorceavo` double DEFAULT NULL COMMENT 'Catorceavo asociado',
  `deduccion` double DEFAULT NULL COMMENT 'Deducciones asociadas.',
  `total` double NOT NULL COMMENT 'Total de salario.\r',
  `Fecha` date NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- DDL for table sancion
CREATE TABLE `sancion` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'Identificador único para cada registro en \nla tabla Sanción. ',
  `tipo` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'Tipo de sanción.',
  `cantidadMultas` int NOT NULL COMMENT 'Cantidad de multas asociadas a la \nsanción aplicada.\r',
  `usuario_id` int NOT NULL COMMENT 'Usuario asociado a sanción aplicada',
  `libroPerdido_id` int NOT NULL COMMENT 'Libros perdidos asociados a sanción. ',
  PRIMARY KEY (`id`),
  KEY `fk_Sanción_Usuario1_idx` (`usuario_id`),
  KEY `fk_Sanción_Libros_Perdidos1_idx` (`libroPerdido_id`),
  CONSTRAINT `fk_Sanción_Libros_Perdidos1` FOREIGN KEY (`libroPerdido_id`) REFERENCES `libroPerdido` (`id`),
  CONSTRAINT `fk_Sanción_Usuario1` FOREIGN KEY (`usuario_id`) REFERENCES `usuario` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- DDL for table subArea
CREATE TABLE `subArea` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'Identificador único para cada registro en la \ntabla Subárea',
  `nombre` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'Nombre de subárea.',
  `ubicacion` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'Ubicación de subárea. ',
  `año` date NOT NULL COMMENT 'Año asociado a subárea.\r',
  `area_id` int NOT NULL COMMENT 'Área asociada a subárea. \n',
  PRIMARY KEY (`id`),
  KEY `fk_SubArea_Area1_idx` (`area_id`),
  CONSTRAINT `fk_SubArea_Area1` FOREIGN KEY (`area_id`) REFERENCES `area` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- DDL for table subCategoria
CREATE TABLE `subCategoria` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'Identificador único para cada registro en \nla tabla Subcategoría.\r',
  `nombre` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'Nombre de la subcategoría.\r',
  `descripcion` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'Descripción de la subcategoría.',
  `area_id` int NOT NULL COMMENT 'Área asociada a subcategoría.',
  PRIMARY KEY (`id`),
  KEY `fk_Subcategoría_Area1_idx` (`area_id`),
  CONSTRAINT `fk_Subcategoría_Area1` FOREIGN KEY (`area_id`) REFERENCES `area` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- DDL for table subCategoria_has_categoria
CREATE TABLE `subCategoria_has_categoria` (
  `subCategoria_id` int NOT NULL,
  `categoria_id` int NOT NULL,
  PRIMARY KEY (`subCategoria_id`,`categoria_id`),
  KEY `fk_subCategoria_has_categoria_categoria1_idx` (`categoria_id`),
  KEY `fk_subCategoria_has_categoria_subCategoria1_idx` (`subCategoria_id`),
  CONSTRAINT `fk_subCategoria_has_categoria_categoria1` FOREIGN KEY (`categoria_id`) REFERENCES `categoria` (`id`),
  CONSTRAINT `fk_subCategoria_has_categoria_subCategoria1` FOREIGN KEY (`subCategoria_id`) REFERENCES `subCategoria` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- DDL for table sugerencia
CREATE TABLE `sugerencia` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'Identificador único para cada registro en \nla tabla Sugerencias.',
  `contenido` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'Contenido de la sugerencia.\r',
  `usuario_id` int NOT NULL COMMENT 'Usuario asociado a la sugerencia.\r',
  PRIMARY KEY (`id`),
  KEY `fk_Sugerencias_Usuario1_idx` (`usuario_id`),
  CONSTRAINT `fk_Sugerencias_Usuario1` FOREIGN KEY (`usuario_id`) REFERENCES `usuario` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- DDL for table telefono
CREATE TABLE `telefono` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'Identificador único para cada registro en \nla tabla Teléfono.',
  `numTelefono` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'Número de teléfono asociado.',
  `tipo` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'Tipo de número telefónico.',
  `operador` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'Operador del número telefónico.\r',
  `persona_id` int NOT NULL COMMENT 'Persona asociada a número telefónico',
  `editorial_id` int NOT NULL COMMENT 'Editorial asociada a número telefónico.\r',
  PRIMARY KEY (`id`),
  KEY `fk_Teléfono_Persona1_idx` (`persona_id`),
  KEY `fk_Teléfono_Editorial1_idx` (`editorial_id`),
  CONSTRAINT `fk_Teléfono_Editorial1` FOREIGN KEY (`editorial_id`) REFERENCES `editorial` (`id`),
  CONSTRAINT `fk_Teléfono_Persona1` FOREIGN KEY (`persona_id`) REFERENCES `persona` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=209 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- DDL for table usuario
CREATE TABLE `usuario` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'Identificador único para cada registro en la \ntabla Usuario.',
  `persona_id` int NOT NULL COMMENT 'Un usuario es una persona.\r',
  `estadoCuenta_id` int NOT NULL COMMENT 'Un usurario posee un estado de cuenta.\r',
  `contraseña` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `token` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `rol` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_Usuario_Persona1_idx` (`persona_id`),
  KEY `fk_Usuario_Estado_Cuenta1_idx` (`estadoCuenta_id`),
  CONSTRAINT `fk_Usuario_Estado_Cuenta1` FOREIGN KEY (`estadoCuenta_id`) REFERENCES `estadoCuenta` (`id`),
  CONSTRAINT `fk_Usuario_Persona1` FOREIGN KEY (`persona_id`) REFERENCES `persona` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=67 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- DDL for table valoracion
CREATE TABLE `valoracion` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'Identificador único para cada registro en la \ntabla Valoración.',
  `estrella` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'Estrellas de la valoración',
  `libro_id` int NOT NULL COMMENT 'Libro asociado a la valoración.',
  `usuario_id` int NOT NULL COMMENT 'Usuario asociado a la valoración.',
  PRIMARY KEY (`id`),
  KEY `fk_Valoración_Libro1_idx` (`libro_id`),
  KEY `fk_Valoración_Usuario1_idx` (`usuario_id`),
  CONSTRAINT `fk_Valoración_Libro1` FOREIGN KEY (`libro_id`) REFERENCES `libro` (`id`),
  CONSTRAINT `fk_Valoración_Usuario1` FOREIGN KEY (`usuario_id`) REFERENCES `usuario` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=52 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

