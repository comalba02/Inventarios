--
-- Crear la base de datos
--

CREATE DATABASE sgi_inventarios;

--
-- Crear la tabla empresa
--

CREATE TABLE `empresa` (
  `empr_id` int(11) NOT NULL AUTO_INCREMENT,
  `empr_nombre` varchar(60) COLLATE utf8mb4_spanish_ci NOT NULL,
  `empr_nit` varchar(20) COLLATE utf8mb4_spanish_ci DEFAULT NULL,
  PRIMARY KEY (`empr_id`)
);

INSERT INTO `empresa` VALUES (1,'SGI Inventarios','123456789-0');

--
-- Crear la tabla documentos
--

CREATE TABLE `documentos` (
  `doc_id` int(11) NOT NULL AUTO_INCREMENT,
  `doc_tipo` varchar(40) COLLATE utf8mb4_spanish_ci NOT NULL,
  `doc_prefijo` varchar(5) COLLATE utf8mb4_spanish_ci DEFAULT NULL,
  PRIMARY KEY (`doc_id`), UNIQUE KEY `doc_documento_UNIQUE` (`doc_tipo`),
  UNIQUE KEY `doc_prefijo_UNIQUE` (`doc_prefijo`)
);

INSERT INTO `documentos` VALUES (1,'Cedula Ciudadanía','CC'),(2,'Cedula Extranjería','CE'),(3,'Pasaporte','PS');

--
-- Crear la tabla roles
--

CREATE TABLE `roles` (
  `rol_id` int(11) NOT NULL AUTO_INCREMENT,
  `rol_nombre` varchar(40) COLLATE utf8mb4_spanish_ci NOT NULL,
  PRIMARY KEY (`rol_id`),
  UNIQUE KEY `rol_nombre_UNIQUE` (`rol_nombre`)
);

INSERT INTO `roles` VALUES (1,'Administrador'),(2,'Almacenista');

--
-- Crear la tabla empleados
--

CREATE TABLE `empleados` (
  `emp_id` int(11) NOT NULL AUTO_INCREMENT,
  `emp_empresa` int(11) DEFAULT NULL,
  `emp_tipodoc` int(11) DEFAULT NULL,
  `emp_documento` varchar(45) COLLATE utf8mb4_spanish_ci DEFAULT NULL,
  `emp_nombre` varchar(100) COLLATE utf8mb4_spanish_ci DEFAULT NULL,
  `emp_genero` varchar(1) COLLATE utf8mb4_spanish_ci DEFAULT NULL,
  `emp_correo` varchar(60) COLLATE utf8mb4_spanish_ci DEFAULT NULL,
  PRIMARY KEY (`emp_id`),
  KEY `fk_empleados_documentos1_idx` (`emp_tipodoc`),
  KEY `fk_empleados_empresa1_idx` (`emp_empresa`),
  CONSTRAINT `fk_empleados_documentos1` FOREIGN KEY (`emp_tipodoc`) REFERENCES `documentos` (`doc_id`),
  CONSTRAINT `fk_empleados_empresa1` FOREIGN KEY (`emp_empresa`) REFERENCES `empresa` (`empr_id`) ON UPDATE CASCADE
);

INSERT INTO `empleados` VALUES (1,1,1,'0123456789','Administrador','M','admin@sgi.co');

--
-- Crear la tabla usuarios
--

CREATE TABLE `usuarios` (
  `usu_id` int(11) NOT NULL AUTO_INCREMENT,
  `usu_emp` int(11) NOT NULL,
  `usu_rol` int(11) NOT NULL,
  `usu_usuario` varchar(60) COLLATE utf8mb4_spanish_ci NOT NULL,
  `usu_contrasena` varchar(256) COLLATE utf8mb4_spanish_ci NOT NULL,
  PRIMARY KEY (`usu_id`),
  UNIQUE KEY `usu_usuario_UNIQUE` (`usu_usuario`),
  KEY `fk_usuarios_empleados1_idx` (`usu_emp`),
  KEY `fk_usuarios_roles1_idx` (`usu_rol`),
  CONSTRAINT `fk_usuarios_empleados1` FOREIGN KEY (`usu_emp`) REFERENCES `empleados` (`emp_id`),
  CONSTRAINT `fk_usuarios_roles1` FOREIGN KEY (`usu_rol`) REFERENCES `roles` (`rol_id`)
);

INSERT INTO `usuarios` VALUES (1,1,1,'admin','e10adc3949ba59abbe56e057f20f883e');

--
-- Crear la tabla categorias
--

CREATE TABLE `categorias` (
  `cat_id` int(11) NOT NULL AUTO_INCREMENT,
  `cat_nombre` varchar(60) COLLATE utf8mb4_spanish_ci NOT NULL,
  PRIMARY KEY (`cat_id`)
);

INSERT INTO `categorias` VALUES (1,'Papeleria'),(2,'Aseo');

--
-- Crear la tabla items
--

CREATE TABLE `items` (
  `ite_id` int(11) NOT NULL AUTO_INCREMENT,
  `ite_nombre` varchar(100) COLLATE utf8mb4_spanish_ci NOT NULL,
  `ite_descripcion` varchar(255) COLLATE utf8mb4_spanish_ci NOT NULL,
  `ite_categoria` int(11) NOT NULL,
  PRIMARY KEY (`ite_id`),
  KEY `fk_items_categorias1_idx` (`ite_categoria`),
  CONSTRAINT `fk_items_categorias1` FOREIGN KEY (`ite_categoria`) REFERENCES `categorias` (`cat_id`) ON UPDATE CASCADE
);

--
-- Crear la tabla inventarios
--

CREATE TABLE `inventarios` (
  `inv_id` int(11) NOT NULL AUTO_INCREMENT,
  `inv_item` int(11) NOT NULL,
  `inv_cantidad` int(11) NOT NULL,
  PRIMARY KEY (`inv_id`),
  KEY `fk_inventarios_items1_idx` (`inv_item`),
  CONSTRAINT `fk_inventarios_items1` FOREIGN KEY (`inv_item`) REFERENCES `items` (`ite_id`)
);

--
-- Crear la tabla documento_ent
--

CREATE TABLE `documento_ent` (
  `docen_id` int(11) NOT NULL AUTO_INCREMENT,
  `docen_fecha` datetime NOT NULL,
  `docen_usuario` int(11) NOT NULL,
  PRIMARY KEY (`docen_id`),
  KEY `fk_documento_ent_usuarios1_idx` (`docen_usuario`),
  CONSTRAINT `fk_documento_ent_usuarios1` FOREIGN KEY (`docen_usuario`) REFERENCES `usuarios` (`usu_id`) ON UPDATE CASCADE
);

--
-- Crear la tabla entradas
--

CREATE TABLE `entradas` (
  `ent_id` int(11) NOT NULL AUTO_INCREMENT,
  `ent_documento` int(11) NOT NULL,
  `ent_inventario` int(11) NOT NULL,
  `ent_cantidad` int(11) NOT NULL,
  PRIMARY KEY (`ent_id`),
  KEY `fk_entradas_inventarios1_idx` (`ent_inventario`),
  KEY `fk_entradas_documento_ent1_idx` (`ent_documento`),
  CONSTRAINT `fk_entradas_documento_ent1` FOREIGN KEY (`ent_documento`) REFERENCES `documento_ent` (`docen_id`),
  CONSTRAINT `fk_entradas_inventarios1` FOREIGN KEY (`ent_inventario`) REFERENCES `inventarios` (`inv_id`) ON UPDATE CASCADE
);

--
-- Crear la tabla documento_sa
--

CREATE TABLE `documento_sa` (
  `docsa_id` int(11) NOT NULL AUTO_INCREMENT,
  `docsa_fecha` datetime NOT NULL,
  `docsa_usuario` int(11) NOT NULL,
  `docsa_empleado` int(11) NOT NULL,
  PRIMARY KEY (`docsa_id`),
  KEY `fk_documento_sa_usuarios1_idx` (`docsa_usuario`),
  KEY `fk_documento_sa_empleados1_idx` (`docsa_empleado`),
  CONSTRAINT `fk_documento_sa_empleados1` FOREIGN KEY (`docsa_empleado`) REFERENCES `empleados` (`emp_id`) ON UPDATE CASCADE,
  CONSTRAINT `fk_documento_sa_usuarios1` FOREIGN KEY (`docsa_usuario`) REFERENCES `usuarios` (`usu_id`) ON UPDATE CASCADE
);

--
-- Crear la tabla salidas
--

CREATE TABLE `salidas` (
  `sal_id` int(11) NOT NULL AUTO_INCREMENT,
  `sal_documento` int(11) NOT NULL,
  `sal_inventario` int(11) NOT NULL,
  `sal_cantidad` int(11) NOT NULL,
  PRIMARY KEY (`sal_id`),
  KEY `fk_salidas_inventarios1_idx` (`sal_inventario`),
  KEY `fk_salidas_documento_sa1_idx` (`sal_documento`),
  CONSTRAINT `fk_salidas_documento_sa1` FOREIGN KEY (`sal_documento`) REFERENCES `documento_sa` (`docsa_id`),
  CONSTRAINT `fk_salidas_inventarios1` FOREIGN KEY (`sal_inventario`) REFERENCES `inventarios` (`inv_id`) ON UPDATE CASCADE
);

--
-- Crear la vista_empleados
--

CREATE VIEW `vista_empleados` AS SELECT
    `e`.`emp_id` AS `Id`,
    `emp`.`empr_nombre` AS `Empresa`,
    `d`.`doc_tipo` AS `Tipo Documento`,
    `e`.`emp_documento` AS `Documento`,
    `e`.`emp_nombre` AS `Empleado`,
    `e`.`emp_genero` AS `Genero`,
    `e`.`emp_correo` AS `Correo Electronico`
FROM
    (
        (
            `empleados` `e`
        JOIN `empresa` `emp` ON
            (`e`.`emp_empresa` = `emp`.`empr_id`)
        )
    JOIN `documentos` `d` ON
        (`e`.`emp_tipodoc` = `d`.`doc_id`)
    );

--
-- Crear la vista_entradas
--

CREATE VIEW `vista_entradas` AS SELECT
    `d`.`docen_id` AS `ENTRADA`,
    `d`.`docen_fecha` AS `FECHA`,
    `em`.`emp_nombre` AS `USUARIO`,
    `it`.`ite_id` AS `ITEM`,
    `it`.`ite_nombre` AS `NOMBRE`,
    `e`.`ent_cantidad` AS `CANTIDAD`
FROM
    (
        (
            (
                (
                    (
                        `documento_ent` `d`
                    JOIN `entradas` `e` ON
                        (`d`.`docen_id` = `e`.`ent_documento`)
                    )
                JOIN `inventarios` `i` ON
                    (`e`.`ent_inventario` = `i`.`inv_id`)
                )
            JOIN `items` `it` ON
                (`i`.`inv_item` = `it`.`ite_id`)
            )
        JOIN `usuarios` `u` ON
            (`d`.`docen_usuario` = `u`.`usu_id`)
        )
    JOIN `empleados` `em` ON
        (`u`.`usu_emp` = `em`.`emp_id`)
    );

--
-- Crear la vista_inventarios
--

CREATE VIEW `vista_inventarios` AS SELECT
    `i`.`inv_id` AS `Id`,
    `it`.`ite_nombre` AS `Item`,
    `it`.`ite_descripcion` AS `Descripcion`,
    `c`.`cat_nombre` AS `Categoria`,
    `i`.`inv_cantidad` AS `Disponible`
FROM
    (
        (
            `inventarios` `i`
        JOIN `items` `it` ON
            (`i`.`inv_item` = `it`.`ite_id`)
        )
    JOIN `categorias` `c` ON
        (`it`.`ite_categoria` = `c`.`cat_id`)
    );

--
-- Crear la vista_items
--

CREATE VIEW `vista_items` AS SELECT
    `i`.`ite_id` AS `Id`,
    `i`.`ite_nombre` AS `Item`,
    `i`.`ite_descripcion` AS `Descripcion`,
    `c`.`cat_nombre` AS `Categoria`
FROM
    (
        `items` `i`
    JOIN `categorias` `c` ON
        (`i`.`ite_categoria` = `c`.`cat_id`)
    );

--
-- Crear la vista_salidas
--

CREATE VIEW `vista_salidas` AS SELECT
    `d`.`docsa_id` AS `SALIDA`,
    `d`.`docsa_fecha` AS `FECHA`,
    `em`.`emp_nombre` AS `USUARIO`,
    `it`.`ite_id` AS `ITEM`,
    `it`.`ite_nombre` AS `NOMBRE`,
    `s`.`sal_cantidad` AS `CANTIDAD`,
    `emp`.`emp_nombre` AS `EMPLEADO`
FROM
    (
        (
            (
                (
                    (
                        (
                            `documento_sa` `d`
                        JOIN `salidas` `s` ON
                            (`d`.`docsa_id` = `s`.`sal_documento`)
                        )
                    JOIN `inventarios` `i` ON
                        (`s`.`sal_inventario` = `i`.`inv_id`)
                    )
                JOIN `items` `it` ON
                    (`i`.`inv_item` = `it`.`ite_id`)
                )
            JOIN `usuarios` `u` ON
                (`d`.`docsa_usuario` = `u`.`usu_id`)
            )
        JOIN `empleados` `em` ON
            (`u`.`usu_emp` = `em`.`emp_id`)
        )
    JOIN `empleados` `emp` ON
        (`d`.`docsa_empleado` = `emp`.`emp_id`)
    );

--
-- Crear la vista_usuarios
--

CREATE VIEW `vista_usuarios` AS SELECT
    `u`.`usu_id` AS `Id`,
    `e`.`emp_nombre` AS `Empleado`,
    `u`.`usu_usuario` AS `Usuario`,
    `r`.`rol_nombre` AS `Rol`,
    `emp`.`empr_nombre` AS `Empresa`
FROM
    (
        (
            (
                `usuarios` `u`
            JOIN `empleados` `e` ON
                (`u`.`usu_emp` = `e`.`emp_id`)
            )
        JOIN `empresa` `emp` ON
            (`e`.`emp_empresa` = `emp`.`empr_id`)
        )
    JOIN `roles` `r` ON
        (`u`.`usu_rol` = `r`.`rol_id`)
    );

--
-- Crear disparador items_inventario
--

DELIMITER |
CREATE TRIGGER `items_inventario` AFTER INSERT ON
    `items` FOR EACH ROW
BEGIN
    INSERT INTO inventarios(inv_item, inv_cantidad) VALUES(NEW.ite_id, '0') ;
END|

--
-- Crear disparador entradas_inventario
--

DELIMITER |
CREATE TRIGGER `entradas_inventario2` AFTER INSERT ON
    `entradas` FOR EACH ROW
BEGIN
    UPDATE
        inventarios
    SET
        inv_cantidad = inv_cantidad + NEW.ent_cantidad
    WHERE
        inv_id = NEW.ent_inventario;
END
|

--
-- Crear disparador salidas_inventario
--

DELIMITER |
CREATE TRIGGER `salidas_inventario2` AFTER INSERT ON
    `salidas` FOR EACH ROW
BEGIN
    UPDATE
        inventarios
    SET
        inv_cantidad = inv_cantidad - NEW.sal_cantidad
    WHERE
        inv_id = NEW.sal_inventario ;
END|
