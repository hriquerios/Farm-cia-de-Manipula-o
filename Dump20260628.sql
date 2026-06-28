CREATE DATABASE  IF NOT EXISTS `rth` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `rth`;
-- MySQL dump 10.13  Distrib 8.0.46, for Win64 (x86_64)
--
-- Host: localhost    Database: rth
-- ------------------------------------------------------
-- Server version	8.0.46

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `cliente`
--

DROP TABLE IF EXISTS `cliente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cliente` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(50) NOT NULL,
  `cpf` varchar(11) NOT NULL,
  `tel1` varchar(11) NOT NULL,
  `tel2` varchar(11) DEFAULT NULL,
  `email` varchar(25) DEFAULT NULL,
  `desc_rua` varchar(25) NOT NULL,
  `desc_bairro` varchar(25) NOT NULL,
  `desc_num_local` int NOT NULL,
  `cep` varchar(10) DEFAULT NULL,
  `cidade` varchar(25) NOT NULL,
  `estado` varchar(25) NOT NULL,
  `nacionalidade` varchar(25) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cliente`
--

LOCK TABLES `cliente` WRITE;
/*!40000 ALTER TABLE `cliente` DISABLE KEYS */;
INSERT INTO `cliente` VALUES (1,'João Silva','12345678901','37999990001','37988880001','joao@email.com','Rua das Flores','Centro',101,'35500000','Divinópolis','MG','Brasileiro'),(2,'MARIA LUISA FERREIRA','234124214','21312321',NULL,'SEASAA','SDADASDA','DSADAS',501,NULL,'DIVINOPOLIS','\'MINAS GERAIS','BRASILEIRA');
/*!40000 ALTER TABLE `cliente` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `formula_composicao`
--

DROP TABLE IF EXISTS `formula_composicao`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `formula_composicao` (
  `id_formula` int NOT NULL,
  `id_insumo` int NOT NULL,
  `id_lote_insumo` int NOT NULL,
  `dosagem` varchar(25) NOT NULL,
  PRIMARY KEY (`id_formula`,`id_insumo`),
  KEY `fk_composicao_insumo` (`id_insumo`),
  KEY `fk_composicao_lote` (`id_lote_insumo`),
  CONSTRAINT `fk_composicao_formula` FOREIGN KEY (`id_formula`) REFERENCES `formula_manipulada` (`id`),
  CONSTRAINT `fk_composicao_insumo` FOREIGN KEY (`id_insumo`) REFERENCES `insumo_material` (`id`),
  CONSTRAINT `fk_composicao_lote` FOREIGN KEY (`id_lote_insumo`) REFERENCES `lote_insumo` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `formula_composicao`
--

LOCK TABLES `formula_composicao` WRITE;
/*!40000 ALTER TABLE `formula_composicao` DISABLE KEYS */;
INSERT INTO `formula_composicao` VALUES (1,1,1,'500mg');
/*!40000 ALTER TABLE `formula_composicao` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `formula_manipulada`
--

DROP TABLE IF EXISTS `formula_manipulada`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `formula_manipulada` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_profissional` int NOT NULL,
  `nome` varchar(50) NOT NULL,
  `posologia` varchar(50) NOT NULL,
  `observacao` varchar(100) DEFAULT NULL,
  `preco` float NOT NULL,
  `f_status` varchar(25) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_formulamanip_profissional` (`id_profissional`),
  CONSTRAINT `fk_formulamanip_profissional` FOREIGN KEY (`id_profissional`) REFERENCES `profissional` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `formula_manipulada`
--

LOCK TABLES `formula_manipulada` WRITE;
/*!40000 ALTER TABLE `formula_manipulada` DISABLE KEYS */;
INSERT INTO `formula_manipulada` VALUES (1,1,'Analgésico Composto','Tomar 1 cápsula a cada 8 horas','Evitar uso prolongado',45,'Ativo');
/*!40000 ALTER TABLE `formula_manipulada` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `formula_pedido`
--

DROP TABLE IF EXISTS `formula_pedido`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `formula_pedido` (
  `id_pedido` int NOT NULL,
  `id_formula` int NOT NULL,
  `quantidade` int NOT NULL,
  `preco` float NOT NULL,
  PRIMARY KEY (`id_pedido`,`id_formula`),
  KEY `fk_formula` (`id_formula`),
  CONSTRAINT `fk_formula` FOREIGN KEY (`id_formula`) REFERENCES `formula_manipulada` (`id`),
  CONSTRAINT `fk_pedido` FOREIGN KEY (`id_pedido`) REFERENCES `pedido` (`id`),
  CONSTRAINT `ck_preco` CHECK ((`preco` > 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `formula_pedido`
--

LOCK TABLES `formula_pedido` WRITE;
/*!40000 ALTER TABLE `formula_pedido` DISABLE KEYS */;
INSERT INTO `formula_pedido` VALUES (1,1,2,45);
/*!40000 ALTER TABLE `formula_pedido` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fornecedor`
--

DROP TABLE IF EXISTS `fornecedor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fornecedor` (
  `id` int NOT NULL AUTO_INCREMENT,
  `razao_social` varchar(50) NOT NULL,
  `nome_fantasia` varchar(50) NOT NULL,
  `cidade` varchar(25) NOT NULL,
  `estado` varchar(25) NOT NULL,
  `pais` varchar(25) NOT NULL,
  `responsavel` varchar(50) NOT NULL,
  `tel_resp` varchar(11) NOT NULL,
  `tel_comercial` varchar(11) NOT NULL,
  `email_resp` varchar(25) NOT NULL,
  `email_comercial` varchar(25) NOT NULL,
  `desc_rua` varchar(25) NOT NULL,
  `desc_bairro` varchar(25) NOT NULL,
  `desc_num_local` int NOT NULL,
  `cep` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fornecedor`
--

LOCK TABLES `fornecedor` WRITE;
/*!40000 ALTER TABLE `fornecedor` DISABLE KEYS */;
INSERT INTO `fornecedor` VALUES (1,'Química Brasil LTDA','QuimiBrasil','São Paulo','SP','Brasil','Pedro Lima','11999990003','1133330003','pedro@quimi.com','contato@quimi.com','Av. Industrial','Distrito Industrial',500,'01310000');
/*!40000 ALTER TABLE `fornecedor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `insumo_material`
--

DROP TABLE IF EXISTS `insumo_material`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `insumo_material` (
  `id` int NOT NULL AUTO_INCREMENT,
  `descricao` varchar(50) NOT NULL,
  `tipo` varchar(25) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `insumo_material`
--

LOCK TABLES `insumo_material` WRITE;
/*!40000 ALTER TABLE `insumo_material` DISABLE KEYS */;
INSERT INTO `insumo_material` VALUES (1,'Paracetamol 500mg','Materia-Prima');
/*!40000 ALTER TABLE `insumo_material` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lote_insumo`
--

DROP TABLE IF EXISTS `lote_insumo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lote_insumo` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_insumo` int NOT NULL,
  `id_fornecedor` int NOT NULL,
  `dt_fabricacao` date NOT NULL,
  `dt_validade` date NOT NULL,
  `quantidade` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_loteinsumo_insumo` (`id_insumo`),
  KEY `fk_loteinsumo_fornecedor` (`id_fornecedor`),
  CONSTRAINT `fk_loteinsumo_fornecedor` FOREIGN KEY (`id_fornecedor`) REFERENCES `fornecedor` (`id`),
  CONSTRAINT `fk_loteinsumo_insumo` FOREIGN KEY (`id_insumo`) REFERENCES `insumo_material` (`id`),
  CONSTRAINT `ck_lote` CHECK (((`dt_validade` > `dt_fabricacao`) and (`quantidade` > 0)))
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lote_insumo`
--

LOCK TABLES `lote_insumo` WRITE;
/*!40000 ALTER TABLE `lote_insumo` DISABLE KEYS */;
INSERT INTO `lote_insumo` VALUES (1,1,1,'2024-01-01','2026-01-01',1000);
/*!40000 ALTER TABLE `lote_insumo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pedido`
--

DROP TABLE IF EXISTS `pedido`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pedido` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_cliente` int NOT NULL,
  `id_profissional` int NOT NULL,
  `data_hora` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `medico_solicitante` varchar(50) NOT NULL,
  `crm_solicitante` varchar(10) NOT NULL,
  `valor_total` float NOT NULL,
  `tipo_pagamento` varchar(10) NOT NULL,
  `observacao` varchar(100) NOT NULL,
  `status` varchar(25) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_pedido_cliente` (`id_cliente`),
  KEY `fk_pedido_profissional` (`id_profissional`),
  CONSTRAINT `fk_pedido_cliente` FOREIGN KEY (`id_cliente`) REFERENCES `cliente` (`id`),
  CONSTRAINT `fk_pedido_profissional` FOREIGN KEY (`id_profissional`) REFERENCES `profissional` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pedido`
--

LOCK TABLES `pedido` WRITE;
/*!40000 ALTER TABLE `pedido` DISABLE KEYS */;
INSERT INTO `pedido` VALUES (1,1,1,'2026-06-27 21:30:47','Dr. Marcos Reis','MG123456',90,'Pix','Entregar na farmácia','Em confecção');
/*!40000 ALTER TABLE `pedido` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `profissional`
--

DROP TABLE IF EXISTS `profissional`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `profissional` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(50) NOT NULL,
  `cpf` varchar(11) NOT NULL,
  `tel` varchar(11) NOT NULL,
  `email` varchar(25) NOT NULL,
  `tel_emergencia` varchar(11) NOT NULL,
  `nome_emergencia` varchar(50) NOT NULL,
  `desc_rua` varchar(25) NOT NULL,
  `desc_bairro` varchar(25) NOT NULL,
  `desc_num_local` int NOT NULL,
  `cep` varchar(10) DEFAULT NULL,
  `cidade` varchar(25) NOT NULL,
  `estado` varchar(25) NOT NULL,
  `nacionalidade` varchar(25) NOT NULL,
  `farmaceutico` tinyint(1) NOT NULL DEFAULT '0',
  `crf` varchar(6) DEFAULT NULL,
  `cargo` varchar(25) NOT NULL,
  `salario` float NOT NULL,
  `hora_inicio` time NOT NULL,
  `hora_fim` time NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `ck_farmaceutico` CHECK (((`farmaceutico` = false) or ((`farmaceutico` = true) and (`crf` is not null))))
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `profissional`
--

LOCK TABLES `profissional` WRITE;
/*!40000 ALTER TABLE `profissional` DISABLE KEYS */;
INSERT INTO `profissional` VALUES (1,'Ana Souza','98765432100','37999990002','ana@email.com','37988880002','Carlos Souza','Rua das Palmeiras','Bela Vista',202,'35500001','Divinópolis','MG','Brasileiro',1,'MG1234','Farmaceutico',5000,'08:00:00','17:00:00');
/*!40000 ALTER TABLE `profissional` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `vw_formula_composicao`
--

DROP TABLE IF EXISTS `vw_formula_composicao`;
/*!50001 DROP VIEW IF EXISTS `vw_formula_composicao`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_formula_composicao` AS SELECT 
 1 AS `id_formula`,
 1 AS `formula`,
 1 AS `posologia`,
 1 AS `preco`,
 1 AS `status`,
 1 AS `insumo`,
 1 AS `tipo_insumo`,
 1 AS `dosagem`,
 1 AS `validade_lote`,
 1 AS `estoque_lote`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_fornecedor_tipo`
--

DROP TABLE IF EXISTS `vw_fornecedor_tipo`;
/*!50001 DROP VIEW IF EXISTS `vw_fornecedor_tipo`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_fornecedor_tipo` AS SELECT 
 1 AS `razao_social`,
 1 AS `cidade`,
 1 AS `estado`,
 1 AS `responsavel`,
 1 AS `tel_Resp`,
 1 AS `tipo`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_lotes_vencimento`
--

DROP TABLE IF EXISTS `vw_lotes_vencimento`;
/*!50001 DROP VIEW IF EXISTS `vw_lotes_vencimento`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_lotes_vencimento` AS SELECT 
 1 AS `id_lote`,
 1 AS `insumo`,
 1 AS `tipo`,
 1 AS `fornecedor`,
 1 AS `dt_fabricacao`,
 1 AS `dt_validade`,
 1 AS `quantidade`,
 1 AS `dias_para_vencer`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_pedidos_cidade`
--

DROP TABLE IF EXISTS `vw_pedidos_cidade`;
/*!50001 DROP VIEW IF EXISTS `vw_pedidos_cidade`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_pedidos_cidade` AS SELECT 
 1 AS `Cod_pedido`,
 1 AS `nome`,
 1 AS `cidade`,
 1 AS `medico_solicitante`,
 1 AS `observacao`,
 1 AS `status`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_pedidos_completos`
--

DROP TABLE IF EXISTS `vw_pedidos_completos`;
/*!50001 DROP VIEW IF EXISTS `vw_pedidos_completos`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_pedidos_completos` AS SELECT 
 1 AS `Cod_pedido`,
 1 AS `cliente`,
 1 AS `telefone_cliente`,
 1 AS `atendente`,
 1 AS `cargo_atendente`,
 1 AS `data_hora`,
 1 AS `medico_solicitante`,
 1 AS `valor_total`,
 1 AS `tipo_pagamento`,
 1 AS `observacao`*/;
SET character_set_client = @saved_cs_client;

--
-- Dumping routines for database 'rth'
--

--
-- Final view structure for view `vw_formula_composicao`
--

/*!50001 DROP VIEW IF EXISTS `vw_formula_composicao`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_formula_composicao` AS select `fm`.`id` AS `id_formula`,`fm`.`nome` AS `formula`,`fm`.`posologia` AS `posologia`,`fm`.`preco` AS `preco`,`fm`.`f_status` AS `status`,`im`.`descricao` AS `insumo`,`im`.`tipo` AS `tipo_insumo`,`fc`.`dosagem` AS `dosagem`,`li`.`dt_validade` AS `validade_lote`,`li`.`quantidade` AS `estoque_lote` from (((`formula_manipulada` `fm` join `formula_composicao` `fc` on((`fc`.`id_formula` = `fm`.`id`))) join `insumo_material` `im` on((`im`.`id` = `fc`.`id_insumo`))) join `lote_insumo` `li` on((`li`.`id` = `fc`.`id_lote_insumo`))) order by `fm`.`id` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_fornecedor_tipo`
--

/*!50001 DROP VIEW IF EXISTS `vw_fornecedor_tipo`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_fornecedor_tipo` AS select `f`.`razao_social` AS `razao_social`,`f`.`cidade` AS `cidade`,`f`.`estado` AS `estado`,`f`.`responsavel` AS `responsavel`,`f`.`tel_resp` AS `tel_Resp`,`base`.`tipo` AS `tipo` from (`fornecedor` `f` join (select `li`.`id_fornecedor` AS `id_fornecedor`,`im`.`id` AS `id`,`im`.`descricao` AS `descricao`,`im`.`tipo` AS `tipo` from (`lote_insumo` `li` join `insumo_material` `im` on((`im`.`id` = `li`.`id_insumo`)))) `base` on((`base`.`id_fornecedor` = `f`.`id`))) where (1 = 1) order by `base`.`tipo`,`f`.`razao_social` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_lotes_vencimento`
--

/*!50001 DROP VIEW IF EXISTS `vw_lotes_vencimento`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_lotes_vencimento` AS select `li`.`id` AS `id_lote`,`im`.`descricao` AS `insumo`,`im`.`tipo` AS `tipo`,`f`.`razao_social` AS `fornecedor`,`li`.`dt_fabricacao` AS `dt_fabricacao`,`li`.`dt_validade` AS `dt_validade`,`li`.`quantidade` AS `quantidade`,(to_days(`li`.`dt_validade`) - to_days(curdate())) AS `dias_para_vencer` from ((`lote_insumo` `li` join `insumo_material` `im` on((`im`.`id` = `li`.`id_insumo`))) join `fornecedor` `f` on((`f`.`id` = `li`.`id_fornecedor`))) where ((1 = 1) and ((to_days(`li`.`dt_validade`) - to_days(curdate())) <= 60)) order by (to_days(`li`.`dt_validade`) - to_days(curdate())) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_pedidos_cidade`
--

/*!50001 DROP VIEW IF EXISTS `vw_pedidos_cidade`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_pedidos_cidade` AS select `p`.`id` AS `Cod_pedido`,`c`.`nome` AS `nome`,`c`.`cidade` AS `cidade`,`p`.`medico_solicitante` AS `medico_solicitante`,`p`.`observacao` AS `observacao`,`p`.`status` AS `status` from (`pedido` `p` join `cliente` `c` on((`c`.`id` = `p`.`id_cliente`))) where ((1 = 1) and (`p`.`valor_total` > 50)) order by `c`.`cidade`,`c`.`nome` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_pedidos_completos`
--

/*!50001 DROP VIEW IF EXISTS `vw_pedidos_completos`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_pedidos_completos` AS select `p`.`id` AS `Cod_pedido`,`c`.`nome` AS `cliente`,`c`.`tel1` AS `telefone_cliente`,`prof`.`nome` AS `atendente`,`prof`.`cargo` AS `cargo_atendente`,`p`.`data_hora` AS `data_hora`,`p`.`medico_solicitante` AS `medico_solicitante`,`p`.`valor_total` AS `valor_total`,`p`.`tipo_pagamento` AS `tipo_pagamento`,`p`.`observacao` AS `observacao` from ((`pedido` `p` join `cliente` `c` on((`c`.`id` = `p`.`id_cliente`))) join `profissional` `prof` on((`prof`.`id` = `p`.`id_profissional`))) */;
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

-- Dump completed on 2026-06-28 12:22:13
