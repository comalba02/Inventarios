-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 04-12-2021 a las 16:25:49
-- Versión del servidor: 10.4.11-MariaDB
-- Versión de PHP: 7.4.5

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `marco`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `categorias`
--

CREATE TABLE `categorias` (
  `cat_id` int(11) NOT NULL,
  `cat_nombre` varchar(60) COLLATE utf8mb4_spanish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

--
-- Volcado de datos para la tabla `categorias`
--

INSERT INTO `categorias` (`cat_id`, `cat_nombre`) VALUES
(1, 'Papeleria'),
(2, 'Aseo'),
(3, 'Herramienta');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `documentos`
--

CREATE TABLE `documentos` (
  `doc_id` int(11) NOT NULL,
  `doc_tipo` varchar(40) COLLATE utf8mb4_spanish_ci NOT NULL,
  `doc_prefijo` varchar(5) COLLATE utf8mb4_spanish_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

--
-- Volcado de datos para la tabla `documentos`
--

INSERT INTO `documentos` (`doc_id`, `doc_tipo`, `doc_prefijo`) VALUES
(1, 'Cedula Ciudadanía', 'CC'),
(2, 'Cedula Extranjería', 'CE'),
(3, 'Pasaporte', 'PS');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `documento_ent`
--

CREATE TABLE `documento_ent` (
  `docen_id` int(11) NOT NULL,
  `docen_fecha` datetime NOT NULL,
  `docen_usuario` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `documento_sa`
--

CREATE TABLE `documento_sa` (
  `docsa_id` int(11) NOT NULL,
  `docsa_fecha` datetime NOT NULL,
  `docsa_usuario` int(11) NOT NULL,
  `docsa_empleado` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `empleados`
--

CREATE TABLE `empleados` (
  `emp_id` int(11) NOT NULL,
  `emp_empresa` int(11) DEFAULT NULL,
  `emp_tipodoc` int(11) DEFAULT NULL,
  `emp_documento` varchar(45) COLLATE utf8mb4_spanish_ci DEFAULT NULL,
  `emp_nombre` varchar(100) COLLATE utf8mb4_spanish_ci DEFAULT NULL,
  `emp_genero` varchar(1) COLLATE utf8mb4_spanish_ci DEFAULT NULL,
  `emp_correo` varchar(60) COLLATE utf8mb4_spanish_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `empresa`
--

CREATE TABLE `empresa` (
  `empr_id` int(11) NOT NULL,
  `empr_nombre` varchar(60) COLLATE utf8mb4_spanish_ci NOT NULL,
  `empr_nit` varchar(20) COLLATE utf8mb4_spanish_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci KEY_BLOCK_SIZE=4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `entradas`
--

CREATE TABLE `entradas` (
  `ent_id` int(11) NOT NULL,
  `ent_documento` int(11) NOT NULL,
  `ent_inventario` int(11) NOT NULL,
  `ent_cantidad` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

--
-- Disparadores `entradas`
--
DELIMITER $$
CREATE TRIGGER `entradas_AFTER_INSERT` AFTER INSERT ON `entradas` FOR EACH ROW BEGIN
update inventarios set inv_cantidad = inv_cantidad + NEW.ent_cantidad WHERE inv_id = NEW.ent_inventario;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `inventarios`
--

CREATE TABLE `inventarios` (
  `inv_id` int(11) NOT NULL,
  `inv_item` int(11) NOT NULL,
  `inv_cantidad` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `items`
--

CREATE TABLE `items` (
  `ite_id` int(11) NOT NULL,
  `ite_nombre` varchar(100) COLLATE utf8mb4_spanish_ci NOT NULL,
  `ite_descripcion` varchar(255) COLLATE utf8mb4_spanish_ci NOT NULL,
  `ite_categoria` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

--
-- Disparadores `items`
--
DELIMITER $$
CREATE TRIGGER `items_AFTER_INSERT` AFTER INSERT ON `items` FOR EACH ROW BEGIN
insert into inventarios (inv_item, inv_cantidad) values (NEW.ite_id , '0');
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `roles`
--

CREATE TABLE `roles` (
  `rol_id` int(11) NOT NULL,
  `rol_nombre` varchar(40) COLLATE utf8mb4_spanish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `salidas`
--

CREATE TABLE `salidas` (
  `sal_id` int(11) NOT NULL,
  `sal_documento` int(11) NOT NULL,
  `sal_inventario` int(11) NOT NULL,
  `sal_cantidad` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci KEY_BLOCK_SIZE=1;

--
-- Disparadores `salidas`
--
DELIMITER $$
CREATE TRIGGER `salidas_AFTER_INSERT` AFTER INSERT ON `salidas` FOR EACH ROW BEGIN
update inventarios set inv_cantidad = inv_cantidad - NEW.sal_cantidad WHERE inv_id = NEW.sal_inventario;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `usu_id` int(11) NOT NULL,
  `usu_emp` int(11) NOT NULL,
  `usu_rol` int(11) NOT NULL,
  `usu_usuario` varchar(60) COLLATE utf8mb4_spanish_ci NOT NULL,
  `usu_contrasena` varchar(256) COLLATE utf8mb4_spanish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `vista_empleados`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `vista_empleados` (
`Id` int(11)
,`Empresa` varchar(60)
,`Tipo Documento` varchar(40)
,`Documento` varchar(45)
,`Empleado` varchar(100)
,`Genero` varchar(1)
,`Correo Electronico` varchar(60)
);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `vista_entradas`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `vista_entradas` (
`ENTRADA` int(11)
,`FECHA` datetime
,`USUARIO` varchar(100)
,`ITEM` int(11)
,`NOMBRE` varchar(100)
,`CANTIDAD` int(11)
);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `vista_inventarios`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `vista_inventarios` (
`Id` int(11)
,`Item` varchar(100)
,`Descripcion` varchar(255)
,`Categoria` varchar(60)
,`Disponible` int(11)
);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `vista_items`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `vista_items` (
`Id` int(11)
,`Item` varchar(100)
,`Descripcion` varchar(255)
,`Categoria` varchar(60)
);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `vista_salidas`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `vista_salidas` (
`SALIDA` int(11)
,`FECHA` datetime
,`USUARIO` varchar(100)
,`ITEM` int(11)
,`NOMBRE` varchar(100)
,`CANTIDAD` int(11)
,`EMPLEADO` varchar(100)
);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `vista_usuarios`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `vista_usuarios` (
`Id` int(11)
,`Empleado` varchar(100)
,`Usuario` varchar(60)
,`Rol` varchar(40)
,`Empresa` varchar(60)
);

-- --------------------------------------------------------

--
-- Estructura para la vista `vista_empleados`
--
DROP TABLE IF EXISTS `vista_empleados`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vista_empleados`  AS  select `e`.`emp_id` AS `Id`,`emp`.`empr_nombre` AS `Empresa`,`d`.`doc_tipo` AS `Tipo Documento`,`e`.`emp_documento` AS `Documento`,`e`.`emp_nombre` AS `Empleado`,`e`.`emp_genero` AS `Genero`,`e`.`emp_correo` AS `Correo Electronico` from ((`empleados` `e` join `empresa` `emp` on(`e`.`emp_empresa` = `emp`.`empr_id`)) join `documentos` `d` on(`e`.`emp_tipodoc` = `d`.`doc_id`)) ;

-- --------------------------------------------------------

--
-- Estructura para la vista `vista_entradas`
--
DROP TABLE IF EXISTS `vista_entradas`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vista_entradas`  AS  select `d`.`docen_id` AS `ENTRADA`,`d`.`docen_fecha` AS `FECHA`,`em`.`emp_nombre` AS `USUARIO`,`it`.`ite_id` AS `ITEM`,`it`.`ite_nombre` AS `NOMBRE`,`e`.`ent_cantidad` AS `CANTIDAD` from (((((`documento_ent` `d` join `entradas` `e` on(`d`.`docen_id` = `e`.`ent_documento`)) join `inventarios` `i` on(`e`.`ent_inventario` = `i`.`inv_id`)) join `items` `it` on(`i`.`inv_item` = `it`.`ite_id`)) join `usuarios` `u` on(`d`.`docen_usuario` = `u`.`usu_id`)) join `empleados` `em` on(`u`.`usu_emp` = `em`.`emp_id`)) ;

-- --------------------------------------------------------

--
-- Estructura para la vista `vista_inventarios`
--
DROP TABLE IF EXISTS `vista_inventarios`;

CREATE ALGORITHM=UNDEFINED DEFINER=`marco`@`%` SQL SECURITY DEFINER VIEW `vista_inventarios`  AS  select `i`.`inv_id` AS `Id`,`it`.`ite_nombre` AS `Item`,`it`.`ite_descripcion` AS `Descripcion`,`c`.`cat_nombre` AS `Categoria`,`i`.`inv_cantidad` AS `Disponible` from ((`inventarios` `i` join `items` `it` on(`i`.`inv_item` = `it`.`ite_id`)) join `categorias` `c` on(`it`.`ite_categoria` = `c`.`cat_id`)) ;

-- --------------------------------------------------------

--
-- Estructura para la vista `vista_items`
--
DROP TABLE IF EXISTS `vista_items`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vista_items`  AS  select `i`.`ite_id` AS `Id`,`i`.`ite_nombre` AS `Item`,`i`.`ite_descripcion` AS `Descripcion`,`c`.`cat_nombre` AS `Categoria` from (`items` `i` join `categorias` `c` on(`i`.`ite_categoria` = `c`.`cat_id`)) ;

-- --------------------------------------------------------

--
-- Estructura para la vista `vista_salidas`
--
DROP TABLE IF EXISTS `vista_salidas`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vista_salidas`  AS  select `d`.`docsa_id` AS `SALIDA`,`d`.`docsa_fecha` AS `FECHA`,`em`.`emp_nombre` AS `USUARIO`,`it`.`ite_id` AS `ITEM`,`it`.`ite_nombre` AS `NOMBRE`,`s`.`sal_cantidad` AS `CANTIDAD`,`emp`.`emp_nombre` AS `EMPLEADO` from ((((((`documento_sa` `d` join `salidas` `s` on(`d`.`docsa_id` = `s`.`sal_documento`)) join `inventarios` `i` on(`s`.`sal_inventario` = `i`.`inv_id`)) join `items` `it` on(`i`.`inv_item` = `it`.`ite_id`)) join `usuarios` `u` on(`d`.`docsa_usuario` = `u`.`usu_id`)) join `empleados` `em` on(`u`.`usu_emp` = `em`.`emp_id`)) join `empleados` `emp` on(`d`.`docsa_empleado` = `emp`.`emp_id`)) ;

-- --------------------------------------------------------

--
-- Estructura para la vista `vista_usuarios`
--
DROP TABLE IF EXISTS `vista_usuarios`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vista_usuarios`  AS  select `u`.`usu_id` AS `Id`,`e`.`emp_nombre` AS `Empleado`,`u`.`usu_usuario` AS `Usuario`,`r`.`rol_nombre` AS `Rol`,`emp`.`empr_nombre` AS `Empresa` from (((`usuarios` `u` join `empleados` `e` on(`u`.`usu_emp` = `e`.`emp_id`)) join `empresa` `emp` on(`e`.`emp_empresa` = `emp`.`empr_id`)) join `roles` `r` on(`u`.`usu_rol` = `r`.`rol_id`)) ;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `categorias`
--
ALTER TABLE `categorias`
  ADD PRIMARY KEY (`cat_id`);

--
-- Indices de la tabla `documentos`
--
ALTER TABLE `documentos`
  ADD PRIMARY KEY (`doc_id`),
  ADD UNIQUE KEY `doc_documento_UNIQUE` (`doc_tipo`),
  ADD UNIQUE KEY `doc_prefijo_UNIQUE` (`doc_prefijo`);

--
-- Indices de la tabla `documento_ent`
--
ALTER TABLE `documento_ent`
  ADD PRIMARY KEY (`docen_id`),
  ADD KEY `fk_documento_ent_usuarios1_idx` (`docen_usuario`);

--
-- Indices de la tabla `documento_sa`
--
ALTER TABLE `documento_sa`
  ADD PRIMARY KEY (`docsa_id`),
  ADD KEY `fk_documento_sa_usuarios1_idx` (`docsa_usuario`),
  ADD KEY `fk_documento_sa_empleados1_idx` (`docsa_empleado`);

--
-- Indices de la tabla `empleados`
--
ALTER TABLE `empleados`
  ADD PRIMARY KEY (`emp_id`),
  ADD KEY `fk_empleados_documentos1_idx` (`emp_tipodoc`),
  ADD KEY `fk_empleados_empresa1_idx` (`emp_empresa`);

--
-- Indices de la tabla `empresa`
--
ALTER TABLE `empresa`
  ADD PRIMARY KEY (`empr_id`);

--
-- Indices de la tabla `entradas`
--
ALTER TABLE `entradas`
  ADD PRIMARY KEY (`ent_id`),
  ADD KEY `fk_entradas_inventarios1_idx` (`ent_inventario`),
  ADD KEY `fk_entradas_documento_ent1_idx` (`ent_documento`);

--
-- Indices de la tabla `inventarios`
--
ALTER TABLE `inventarios`
  ADD PRIMARY KEY (`inv_id`),
  ADD KEY `fk_inventarios_items1_idx` (`inv_item`);

--
-- Indices de la tabla `items`
--
ALTER TABLE `items`
  ADD PRIMARY KEY (`ite_id`),
  ADD KEY `fk_items_categorias1_idx` (`ite_categoria`);

--
-- Indices de la tabla `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`rol_id`),
  ADD UNIQUE KEY `rol_nombre_UNIQUE` (`rol_nombre`);

--
-- Indices de la tabla `salidas`
--
ALTER TABLE `salidas`
  ADD PRIMARY KEY (`sal_id`),
  ADD KEY `fk_salidas_inventarios1_idx` (`sal_inventario`),
  ADD KEY `fk_salidas_documento_sa1_idx` (`sal_documento`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`usu_id`),
  ADD UNIQUE KEY `usu_usuario_UNIQUE` (`usu_usuario`),
  ADD KEY `fk_usuarios_empleados1_idx` (`usu_emp`),
  ADD KEY `fk_usuarios_roles1_idx` (`usu_rol`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `categorias`
--
ALTER TABLE `categorias`
  MODIFY `cat_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `documentos`
--
ALTER TABLE `documentos`
  MODIFY `doc_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `documento_ent`
--
ALTER TABLE `documento_ent`
  MODIFY `docen_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `documento_sa`
--
ALTER TABLE `documento_sa`
  MODIFY `docsa_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `empleados`
--
ALTER TABLE `empleados`
  MODIFY `emp_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `empresa`
--
ALTER TABLE `empresa`
  MODIFY `empr_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `entradas`
--
ALTER TABLE `entradas`
  MODIFY `ent_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `inventarios`
--
ALTER TABLE `inventarios`
  MODIFY `inv_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `items`
--
ALTER TABLE `items`
  MODIFY `ite_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `roles`
--
ALTER TABLE `roles`
  MODIFY `rol_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `salidas`
--
ALTER TABLE `salidas`
  MODIFY `sal_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `usu_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `documento_ent`
--
ALTER TABLE `documento_ent`
  ADD CONSTRAINT `fk_documento_ent_usuarios1` FOREIGN KEY (`docen_usuario`) REFERENCES `usuarios` (`usu_id`) ON UPDATE CASCADE;

--
-- Filtros para la tabla `documento_sa`
--
ALTER TABLE `documento_sa`
  ADD CONSTRAINT `fk_documento_sa_empleados1` FOREIGN KEY (`docsa_empleado`) REFERENCES `empleados` (`emp_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_documento_sa_usuarios1` FOREIGN KEY (`docsa_usuario`) REFERENCES `usuarios` (`usu_id`) ON UPDATE CASCADE;

--
-- Filtros para la tabla `empleados`
--
ALTER TABLE `empleados`
  ADD CONSTRAINT `fk_empleados_documentos1` FOREIGN KEY (`emp_tipodoc`) REFERENCES `documentos` (`doc_id`),
  ADD CONSTRAINT `fk_empleados_empresa1` FOREIGN KEY (`emp_empresa`) REFERENCES `empresa` (`empr_id`) ON UPDATE CASCADE;

--
-- Filtros para la tabla `entradas`
--
ALTER TABLE `entradas`
  ADD CONSTRAINT `fk_entradas_documento_ent1` FOREIGN KEY (`ent_documento`) REFERENCES `documento_ent` (`docen_id`),
  ADD CONSTRAINT `fk_entradas_inventarios1` FOREIGN KEY (`ent_inventario`) REFERENCES `inventarios` (`inv_id`) ON UPDATE CASCADE;

--
-- Filtros para la tabla `inventarios`
--
ALTER TABLE `inventarios`
  ADD CONSTRAINT `fk_inventarios_items1` FOREIGN KEY (`inv_item`) REFERENCES `items` (`ite_id`);

--
-- Filtros para la tabla `items`
--
ALTER TABLE `items`
  ADD CONSTRAINT `fk_items_categorias1` FOREIGN KEY (`ite_categoria`) REFERENCES `categorias` (`cat_id`) ON UPDATE CASCADE;

--
-- Filtros para la tabla `salidas`
--
ALTER TABLE `salidas`
  ADD CONSTRAINT `fk_salidas_documento_sa1` FOREIGN KEY (`sal_documento`) REFERENCES `documento_sa` (`docsa_id`),
  ADD CONSTRAINT `fk_salidas_inventarios1` FOREIGN KEY (`sal_inventario`) REFERENCES `inventarios` (`inv_id`) ON UPDATE CASCADE;

--
-- Filtros para la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD CONSTRAINT `fk_usuarios_empleados1` FOREIGN KEY (`usu_emp`) REFERENCES `empleados` (`emp_id`),
  ADD CONSTRAINT `fk_usuarios_roles1` FOREIGN KEY (`usu_rol`) REFERENCES `roles` (`rol_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
