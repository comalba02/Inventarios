-- MariaDB dump 10.19  Distrib 10.4.20-MariaDB, for Win64 (AMD64)
--
-- Host: localhost    Database: sgiinventarios
-- ------------------------------------------------------
-- Server version	10.4.20-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
-- MariaDB dump 10.19  Distrib 10.4.20-MariaDB, for Win64 (AMD64)
--
-- Host: localhost    Database: sgi_inventarios
-- ------------------------------------------------------
-- Server version	10.4.20-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `categorias`
--

DROP TABLE IF EXISTS `categorias`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `categorias` (
  `cat_id` int(11) NOT NULL AUTO_INCREMENT,
  `cat_nombre` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  PRIMARY KEY (`cat_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categorias`
--

LOCK TABLES `categorias` WRITE;
/*!40000 ALTER TABLE `categorias` DISABLE KEYS */;
INSERT INTO `categorias` VALUES (1,'Papeleria'),(2,'Aseo'),(3,'Computadores');
/*!40000 ALTER TABLE `categorias` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `documento_ent`
--

DROP TABLE IF EXISTS `documento_ent`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `documento_ent` (
  `docen_id` int(11) NOT NULL AUTO_INCREMENT,
  `docen_fecha` datetime NOT NULL,
  `docen_usuario` int(11) NOT NULL,
  PRIMARY KEY (`docen_id`),
  KEY `fk_documento_ent_usuarios1_idx` (`docen_usuario`),
  CONSTRAINT `fk_documento_ent_usuarios1` FOREIGN KEY (`docen_usuario`) REFERENCES `usuarios` (`usu_id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `documento_ent`
--

LOCK TABLES `documento_ent` WRITE;
/*!40000 ALTER TABLE `documento_ent` DISABLE KEYS */;
INSERT INTO `documento_ent` VALUES (1,'2022-02-24 19:15:14',1),(2,'2022-02-24 19:15:34',1),(3,'2022-02-24 20:19:29',1),(4,'2022-02-24 20:21:08',1),(5,'2022-02-24 20:47:51',2);
/*!40000 ALTER TABLE `documento_ent` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `documento_sa`
--

DROP TABLE IF EXISTS `documento_sa`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `documento_sa`
--

LOCK TABLES `documento_sa` WRITE;
/*!40000 ALTER TABLE `documento_sa` DISABLE KEYS */;
/*!40000 ALTER TABLE `documento_sa` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `documentos`
--

DROP TABLE IF EXISTS `documentos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `documentos` (
  `doc_id` int(11) NOT NULL AUTO_INCREMENT,
  `doc_tipo` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  `doc_prefijo` varchar(5) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci DEFAULT NULL,
  PRIMARY KEY (`doc_id`),
  UNIQUE KEY `doc_documento_UNIQUE` (`doc_tipo`),
  UNIQUE KEY `doc_prefijo_UNIQUE` (`doc_prefijo`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `documentos`
--

LOCK TABLES `documentos` WRITE;
/*!40000 ALTER TABLE `documentos` DISABLE KEYS */;
INSERT INTO `documentos` VALUES (1,'Cedula Ciudadanía','CC'),(2,'Cedula Extranjería','CE'),(3,'Pasaporte','PS');
/*!40000 ALTER TABLE `documentos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `empleados`
--

DROP TABLE IF EXISTS `empleados`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `empleados` (
  `emp_id` int(11) NOT NULL AUTO_INCREMENT,
  `emp_empresa` int(11) DEFAULT NULL,
  `emp_tipodoc` int(11) DEFAULT NULL,
  `emp_documento` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci DEFAULT NULL,
  `emp_nombre` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci DEFAULT NULL,
  `emp_genero` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci DEFAULT NULL,
  `emp_correo` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci DEFAULT NULL,
  PRIMARY KEY (`emp_id`),
  KEY `fk_empleados_documentos1_idx` (`emp_tipodoc`),
  KEY `fk_empleados_empresa1_idx` (`emp_empresa`),
  CONSTRAINT `fk_empleados_documentos1` FOREIGN KEY (`emp_tipodoc`) REFERENCES `documentos` (`doc_id`),
  CONSTRAINT `fk_empleados_empresa1` FOREIGN KEY (`emp_empresa`) REFERENCES `empresa` (`empr_id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `empleados`
--

LOCK TABLES `empleados` WRITE;
/*!40000 ALTER TABLE `empleados` DISABLE KEYS */;
INSERT INTO `empleados` VALUES (1,1,1,'0123456789','Administrador','M','admin@sgi.co'),(2,1,1,'1027884420','Paula Montes','F','paumontes@hotmail.com'),(3,1,1,'1121858293','Marco Alberto Coronado Baquero','M','comalba02@hotmail.com');
/*!40000 ALTER TABLE `empleados` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `empresa`
--

DROP TABLE IF EXISTS `empresa`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `empresa` (
  `empr_id` int(11) NOT NULL AUTO_INCREMENT,
  `empr_nombre` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  `empr_nit` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci DEFAULT NULL,
  PRIMARY KEY (`empr_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `empresa`
--

LOCK TABLES `empresa` WRITE;
/*!40000 ALTER TABLE `empresa` DISABLE KEYS */;
INSERT INTO `empresa` VALUES (1,'SGI Inventarios','123456789-0');
/*!40000 ALTER TABLE `empresa` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `entradas`
--

DROP TABLE IF EXISTS `entradas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
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
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `entradas`
--

LOCK TABLES `entradas` WRITE;
/*!40000 ALTER TABLE `entradas` DISABLE KEYS */;
INSERT INTO `entradas` VALUES (1,2,1,5),(2,3,2,10),(3,3,3,7),(4,3,4,15),(5,4,5,6),(6,4,6,3),(7,5,3,5),(8,5,4,3),(9,5,1,2),(10,5,2,1);
/*!40000 ALTER TABLE `entradas` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `entradas_inventario2` AFTER INSERT ON `entradas` FOR EACH ROW BEGIN
    UPDATE
        inventarios
    SET
        inv_cantidad = inv_cantidad + NEW.ent_cantidad
    WHERE
        inv_id = NEW.ent_inventario;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `inventarios`
--

DROP TABLE IF EXISTS `inventarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `inventarios` (
  `inv_id` int(11) NOT NULL AUTO_INCREMENT,
  `inv_item` int(11) NOT NULL,
  `inv_cantidad` int(11) NOT NULL,
  PRIMARY KEY (`inv_id`),
  KEY `fk_inventarios_items1_idx` (`inv_item`),
  CONSTRAINT `fk_inventarios_items1` FOREIGN KEY (`inv_item`) REFERENCES `items` (`ite_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inventarios`
--

LOCK TABLES `inventarios` WRITE;
/*!40000 ALTER TABLE `inventarios` DISABLE KEYS */;
INSERT INTO `inventarios` VALUES (1,1,7),(2,2,11),(3,3,12),(4,4,18),(5,5,6),(6,6,3);
/*!40000 ALTER TABLE `inventarios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `items`
--

DROP TABLE IF EXISTS `items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `items` (
  `ite_id` int(11) NOT NULL AUTO_INCREMENT,
  `ite_nombre` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  `ite_descripcion` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  `ite_categoria` int(11) NOT NULL,
  PRIMARY KEY (`ite_id`),
  KEY `fk_items_categorias1_idx` (`ite_categoria`),
  CONSTRAINT `fk_items_categorias1` FOREIGN KEY (`ite_categoria`) REFERENCES `categorias` (`cat_id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `items`
--

LOCK TABLES `items` WRITE;
/*!40000 ALTER TABLE `items` DISABLE KEYS */;
INSERT INTO `items` VALUES (1,'Clorox','Clorox botella x 1 Litro',2),(2,'Sanpic','Sanpic botella x 1 Litro',2),(3,'Resma de Papel Carta','Papel blanco tamaño carta',1),(4,'Resma de Papel Oficio','Papel blanco tamaño oficio',1),(5,'Mouse USB','Mouse optico usb color negro',3),(6,'Teclado Gamer USB','Teclado retroiluminado color negro con conector USB',3);
/*!40000 ALTER TABLE `items` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `items_inventario` AFTER INSERT ON `items` FOR EACH ROW BEGIN
    INSERT INTO inventarios(inv_item, inv_cantidad) VALUES(NEW.ite_id, '0') ;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `roles` (
  `rol_id` int(11) NOT NULL AUTO_INCREMENT,
  `rol_nombre` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  PRIMARY KEY (`rol_id`),
  UNIQUE KEY `rol_nombre_UNIQUE` (`rol_nombre`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES (1,'Administrador'),(2,'Almacenista');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `salidas`
--

DROP TABLE IF EXISTS `salidas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `salidas`
--

LOCK TABLES `salidas` WRITE;
/*!40000 ALTER TABLE `salidas` DISABLE KEYS */;
/*!40000 ALTER TABLE `salidas` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `salidas_inventario2` AFTER INSERT ON `salidas` FOR EACH ROW BEGIN
    UPDATE
        inventarios
    SET
        inv_cantidad = inv_cantidad - NEW.sal_cantidad
    WHERE
        inv_id = NEW.sal_inventario ;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `usuarios`
--

DROP TABLE IF EXISTS `usuarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `usuarios` (
  `usu_id` int(11) NOT NULL AUTO_INCREMENT,
  `usu_emp` int(11) NOT NULL,
  `usu_rol` int(11) NOT NULL,
  `usu_usuario` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  `usu_contrasena` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  PRIMARY KEY (`usu_id`),
  UNIQUE KEY `usu_usuario_UNIQUE` (`usu_usuario`),
  KEY `fk_usuarios_empleados1_idx` (`usu_emp`),
  KEY `fk_usuarios_roles1_idx` (`usu_rol`),
  CONSTRAINT `fk_usuarios_empleados1` FOREIGN KEY (`usu_emp`) REFERENCES `empleados` (`emp_id`),
  CONSTRAINT `fk_usuarios_roles1` FOREIGN KEY (`usu_rol`) REFERENCES `roles` (`rol_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuarios`
--

LOCK TABLES `usuarios` WRITE;
/*!40000 ALTER TABLE `usuarios` DISABLE KEYS */;
INSERT INTO `usuarios` VALUES (1,1,1,'admin','e10adc3949ba59abbe56e057f20f883e'),(2,2,2,'paulam','e10adc3949ba59abbe56e057f20f883e'),(3,3,2,'comalba02','e10adc3949ba59abbe56e057f20f883e');
/*!40000 ALTER TABLE `usuarios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary table structure for view `vista_empleados`
--

DROP TABLE IF EXISTS `vista_empleados`;
/*!50001 DROP VIEW IF EXISTS `vista_empleados`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `vista_empleados` (
  `Id` tinyint NOT NULL,
  `Empresa` tinyint NOT NULL,
  `Tipo Documento` tinyint NOT NULL,
  `Documento` tinyint NOT NULL,
  `Empleado` tinyint NOT NULL,
  `Genero` tinyint NOT NULL,
  `Correo Electronico` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `vista_entradas`
--

DROP TABLE IF EXISTS `vista_entradas`;
/*!50001 DROP VIEW IF EXISTS `vista_entradas`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `vista_entradas` (
  `ENTRADA` tinyint NOT NULL,
  `FECHA` tinyint NOT NULL,
  `USUARIO` tinyint NOT NULL,
  `ITEM` tinyint NOT NULL,
  `NOMBRE` tinyint NOT NULL,
  `CANTIDAD` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `vista_inventarios`
--

DROP TABLE IF EXISTS `vista_inventarios`;
/*!50001 DROP VIEW IF EXISTS `vista_inventarios`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `vista_inventarios` (
  `Id` tinyint NOT NULL,
  `Item` tinyint NOT NULL,
  `Descripcion` tinyint NOT NULL,
  `Categoria` tinyint NOT NULL,
  `Disponible` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `vista_items`
--

DROP TABLE IF EXISTS `vista_items`;
/*!50001 DROP VIEW IF EXISTS `vista_items`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `vista_items` (
  `Id` tinyint NOT NULL,
  `Item` tinyint NOT NULL,
  `Descripcion` tinyint NOT NULL,
  `Categoria` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `vista_salidas`
--

DROP TABLE IF EXISTS `vista_salidas`;
/*!50001 DROP VIEW IF EXISTS `vista_salidas`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `vista_salidas` (
  `SALIDA` tinyint NOT NULL,
  `FECHA` tinyint NOT NULL,
  `USUARIO` tinyint NOT NULL,
  `ITEM` tinyint NOT NULL,
  `NOMBRE` tinyint NOT NULL,
  `CANTIDAD` tinyint NOT NULL,
  `EMPLEADO` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `vista_usuarios`
--

DROP TABLE IF EXISTS `vista_usuarios`;
/*!50001 DROP VIEW IF EXISTS `vista_usuarios`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `vista_usuarios` (
  `Id` tinyint NOT NULL,
  `Empleado` tinyint NOT NULL,
  `Usuario` tinyint NOT NULL,
  `Rol` tinyint NOT NULL,
  `Empresa` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Final view structure for view `vista_empleados`
--

/*!50001 DROP TABLE IF EXISTS `vista_empleados`*/;
/*!50001 DROP VIEW IF EXISTS `vista_empleados`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vista_empleados` AS select `e`.`emp_id` AS `Id`,`emp`.`empr_nombre` AS `Empresa`,`d`.`doc_tipo` AS `Tipo Documento`,`e`.`emp_documento` AS `Documento`,`e`.`emp_nombre` AS `Empleado`,`e`.`emp_genero` AS `Genero`,`e`.`emp_correo` AS `Correo Electronico` from ((`empleados` `e` join `empresa` `emp` on(`e`.`emp_empresa` = `emp`.`empr_id`)) join `documentos` `d` on(`e`.`emp_tipodoc` = `d`.`doc_id`)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vista_entradas`
--

/*!50001 DROP TABLE IF EXISTS `vista_entradas`*/;
/*!50001 DROP VIEW IF EXISTS `vista_entradas`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vista_entradas` AS select `d`.`docen_id` AS `ENTRADA`,`d`.`docen_fecha` AS `FECHA`,`em`.`emp_nombre` AS `USUARIO`,`it`.`ite_id` AS `ITEM`,`it`.`ite_nombre` AS `NOMBRE`,`e`.`ent_cantidad` AS `CANTIDAD` from (((((`documento_ent` `d` join `entradas` `e` on(`d`.`docen_id` = `e`.`ent_documento`)) join `inventarios` `i` on(`e`.`ent_inventario` = `i`.`inv_id`)) join `items` `it` on(`i`.`inv_item` = `it`.`ite_id`)) join `usuarios` `u` on(`d`.`docen_usuario` = `u`.`usu_id`)) join `empleados` `em` on(`u`.`usu_emp` = `em`.`emp_id`)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vista_inventarios`
--

/*!50001 DROP TABLE IF EXISTS `vista_inventarios`*/;
/*!50001 DROP VIEW IF EXISTS `vista_inventarios`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vista_inventarios` AS select `i`.`inv_id` AS `Id`,`it`.`ite_nombre` AS `Item`,`it`.`ite_descripcion` AS `Descripcion`,`c`.`cat_nombre` AS `Categoria`,`i`.`inv_cantidad` AS `Disponible` from ((`inventarios` `i` join `items` `it` on(`i`.`inv_item` = `it`.`ite_id`)) join `categorias` `c` on(`it`.`ite_categoria` = `c`.`cat_id`)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vista_items`
--

/*!50001 DROP TABLE IF EXISTS `vista_items`*/;
/*!50001 DROP VIEW IF EXISTS `vista_items`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vista_items` AS select `i`.`ite_id` AS `Id`,`i`.`ite_nombre` AS `Item`,`i`.`ite_descripcion` AS `Descripcion`,`c`.`cat_nombre` AS `Categoria` from (`items` `i` join `categorias` `c` on(`i`.`ite_categoria` = `c`.`cat_id`)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vista_salidas`
--

/*!50001 DROP TABLE IF EXISTS `vista_salidas`*/;
/*!50001 DROP VIEW IF EXISTS `vista_salidas`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vista_salidas` AS select `d`.`docsa_id` AS `SALIDA`,`d`.`docsa_fecha` AS `FECHA`,`em`.`emp_nombre` AS `USUARIO`,`it`.`ite_id` AS `ITEM`,`it`.`ite_nombre` AS `NOMBRE`,`s`.`sal_cantidad` AS `CANTIDAD`,`emp`.`emp_nombre` AS `EMPLEADO` from ((((((`documento_sa` `d` join `salidas` `s` on(`d`.`docsa_id` = `s`.`sal_documento`)) join `inventarios` `i` on(`s`.`sal_inventario` = `i`.`inv_id`)) join `items` `it` on(`i`.`inv_item` = `it`.`ite_id`)) join `usuarios` `u` on(`d`.`docsa_usuario` = `u`.`usu_id`)) join `empleados` `em` on(`u`.`usu_emp` = `em`.`emp_id`)) join `empleados` `emp` on(`d`.`docsa_empleado` = `emp`.`emp_id`)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vista_usuarios`
--

/*!50001 DROP TABLE IF EXISTS `vista_usuarios`*/;
/*!50001 DROP VIEW IF EXISTS `vista_usuarios`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vista_usuarios` AS select `u`.`usu_id` AS `Id`,`e`.`emp_nombre` AS `Empleado`,`u`.`usu_usuario` AS `Usuario`,`r`.`rol_nombre` AS `Rol`,`emp`.`empr_nombre` AS `Empresa` from (((`usuarios` `u` join `empleados` `e` on(`u`.`usu_emp` = `e`.`emp_id`)) join `empresa` `emp` on(`e`.`emp_empresa` = `emp`.`empr_id`)) join `roles` `r` on(`u`.`usu_rol` = `r`.`rol_id`)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-12-18  8:26:38
