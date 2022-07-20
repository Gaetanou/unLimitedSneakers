-- MySQL dump 10.13  Distrib 8.0.24, for macos11 (x86_64)
--
-- Host: localhost    Database: dbecommerce
-- ------------------------------------------------------
-- Server version	8.0.28

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
-- Table structure for table `dettaglioprodotto`
--

DROP TABLE IF EXISTS `dettaglioprodotto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dettaglioprodotto` (
  `taglia` int NOT NULL,
  `prodotto` varchar(25) NOT NULL,
  `costo` decimal(7,2) NOT NULL,
  `quantita` int NOT NULL,
  `categoria` varchar(45) NOT NULL,
  PRIMARY KEY (`taglia`,`prodotto`),
  KEY `fk_new_table_1_idx` (`prodotto`),
  CONSTRAINT `fk_new_table_1` FOREIGN KEY (`prodotto`) REFERENCES `prodotto` (`codiceSeriale`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dettaglioprodotto`
--

LOCK TABLES `dettaglioprodotto` WRITE;
/*!40000 ALTER TABLE `dettaglioprodotto` DISABLE KEYS */;
INSERT INTO `dettaglioprodotto` VALUES (36,'N0006',160.00,4,'donna'),(37,'N0006',160.00,6,'donna'),(37,'O0004',200.00,3,'donna'),(38,'N0006',160.00,5,'donna'),(38,'O0004',200.00,3,'donna'),(39,'N0001',10000.00,4,'uomo'),(39,'N0006',160.00,3,'donna'),(39,'O0004',200.00,0,'donna'),(39,'Y0003',160.00,0,'donna'),(40,'N0004',450.00,2,'uomo'),(40,'N0005',120.00,6,'donna'),(40,'O0003',220.00,4,'donna'),(40,'Y0004',180.00,6,'donna'),(41,'N0004',450.00,3,'uomo'),(41,'N0006',160.00,3,'donna'),(42,'N0001',10000.00,1,'uomo'),(42,'N0002',7000.00,4,'uomo'),(42,'N0003',220.00,2,'uomo'),(42,'N0004',450.00,2,'uomo'),(42,'O0001',300.00,3,'uomo'),(42,'O0002',550.00,0,'uomo'),(42,'Y0001',380.00,2,'uomo'),(42,'Y0002',420.00,0,'uomo'),(43,'N0001',10000.00,4,'uomo'),(43,'N0002',7000.00,3,'uomo'),(44,'N0001',10000.00,0,'uomo'),(44,'N0002',7000.00,2,'uomo'),(44,'N0004',450.00,6,'uomo'),(45,'N0001',10000.00,4,'uomo'),(45,'N0003',220.00,0,'uomo'),(45,'N0004',450.00,2,'uomo'),(46,'N0001',10000.00,6,'uomo'),(46,'N0004',450.00,2,'uomo'),(47,'N0002',7000.00,5,'uomo');
/*!40000 ALTER TABLE `dettaglioprodotto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dettagliordine`
--

DROP TABLE IF EXISTS `dettagliordine`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dettagliordine` (
  `ordine` int NOT NULL AUTO_INCREMENT,
  `cliente` varchar(45) NOT NULL,
  `prodotto` varchar(45) NOT NULL,
  `taglia` varchar(45) NOT NULL,
  `quantita` int NOT NULL,
  `costo` decimal(10,0) NOT NULL,
  PRIMARY KEY (`ordine`,`cliente`,`prodotto`,`taglia`),
  KEY `foreignkey_username_idx` (`cliente`),
  CONSTRAINT `fk_ordine` FOREIGN KEY (`ordine`) REFERENCES `ordine` (`numOrdineProgressivo`) ON DELETE CASCADE,
  CONSTRAINT `foreignkey_cliente` FOREIGN KEY (`cliente`) REFERENCES `ordine` (`cliente`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dettagliordine`
--

LOCK TABLES `dettagliordine` WRITE;
/*!40000 ALTER TABLE `dettagliordine` DISABLE KEYS */;
INSERT INTO `dettagliordine` VALUES (10,'Gaetano','N0001','42',1,10000),(10,'Gaetano','N0002','42',1,7000),(10,'Gaetano','N0006','38',2,160),(11,'Gaetano','O0004','39',3,200),(12,'Gaetanou','N0001','42',1,10000);
/*!40000 ALTER TABLE `dettagliordine` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `indirizzo`
--

DROP TABLE IF EXISTS `indirizzo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `indirizzo` (
  `numIndirizzoProgressivo` int NOT NULL AUTO_INCREMENT,
  `utente` varchar(50) NOT NULL,
  `via` varchar(50) NOT NULL,
  `citta` varchar(50) NOT NULL,
  `CAP` varchar(10) NOT NULL,
  `civico` varchar(10) NOT NULL,
  `provincia` varchar(10) NOT NULL,
  `nazione` varchar(25) NOT NULL,
  `scala` varchar(5) DEFAULT NULL,
  `interno` varchar(20) DEFAULT NULL,
  `preferito` enum('si','no') NOT NULL,
  PRIMARY KEY (`numIndirizzoProgressivo`,`utente`),
  KEY `indirizzo_utente_username_fk` (`utente`),
  CONSTRAINT `indirizzo_utente_username_fk` FOREIGN KEY (`utente`) REFERENCES `utente` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `indirizzo`
--

LOCK TABLES `indirizzo` WRITE;
/*!40000 ALTER TABLE `indirizzo` DISABLE KEYS */;
INSERT INTO `indirizzo` VALUES (8,'Gaetano','Via Roma ','Roma','00042','10','Roma','Italia','','','si'),(9,'Gaetano','Via Duomo','Milano','00002','15','Milano','Italia','','','no'),(10,'Gaetanou','Via dei pini','Castel','84083','8','Salerno','Italia','','','si');
/*!40000 ALTER TABLE `indirizzo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `metododipagamento`
--

DROP TABLE IF EXISTS `metododipagamento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `metododipagamento` (
  `numPagamentoProgressivo` int NOT NULL AUTO_INCREMENT,
  `utente` varchar(50) NOT NULL,
  `nome` varchar(50) NOT NULL,
  `cognome` varchar(50) NOT NULL,
  `numCarta` varchar(19) DEFAULT NULL,
  `dataScadenza` varchar(10) NOT NULL,
  `cvv` varchar(3) NOT NULL,
  `preferito` enum('si','no') NOT NULL,
  PRIMARY KEY (`numPagamentoProgressivo`,`utente`),
  KEY `metodoDiPagamento_utente_username_fk` (`utente`),
  CONSTRAINT `metodoDiPagamento_utente_username_fk` FOREIGN KEY (`utente`) REFERENCES `utente` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `metododipagamento`
--

LOCK TABLES `metododipagamento` WRITE;
/*!40000 ALTER TABLE `metododipagamento` DISABLE KEYS */;
INSERT INTO `metododipagamento` VALUES (4,'Gaetano','Gaetano','Cataldo','4929920171053530','09/2025','425','si'),(5,'Gaetanou','Gaetano','Cataldo','44444444444444','12/22','222','si');
/*!40000 ALTER TABLE `metododipagamento` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ordine`
--

DROP TABLE IF EXISTS `ordine`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ordine` (
  `numOrdineProgressivo` int NOT NULL AUTO_INCREMENT,
  `cliente` varchar(45) NOT NULL,
  `numCarta` varchar(45) NOT NULL,
  `citta` varchar(45) NOT NULL,
  `CAP` varchar(45) NOT NULL,
  `via` varchar(45) NOT NULL,
  `civico` varchar(45) NOT NULL,
  `provincia` varchar(45) NOT NULL,
  `nazione` varchar(45) NOT NULL,
  `dataAcquisto` date NOT NULL,
  `costoTotale` double NOT NULL,
  PRIMARY KEY (`numOrdineProgressivo`,`cliente`),
  KEY `fk2_idx` (`cliente`),
  CONSTRAINT `ordine_utente_username_fk` FOREIGN KEY (`cliente`) REFERENCES `utente` (`username`) ON DELETE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ordine`
--

LOCK TABLES `ordine` WRITE;
/*!40000 ALTER TABLE `ordine` DISABLE KEYS */;
INSERT INTO `ordine` VALUES (10,'Gaetano','4929920171053530','Roma','00042','Via Roma ','10','Roma','Italia','2022-07-19',17320),(11,'Gaetano','4929920171053530','Milano','00002','Via Duomo','15','Milano','Italia','2022-07-19',600),(12,'Gaetanou','44444444444444','Castel','84083','Via dei pini','8','Salerno','Italia','2022-07-20',10000);
/*!40000 ALTER TABLE `ordine` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prodotto`
--

DROP TABLE IF EXISTS `prodotto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `prodotto` (
  `codiceSeriale` varchar(20) NOT NULL,
  `nome` varchar(45) NOT NULL,
  `brand` varchar(45) NOT NULL,
  `descrizioneBreve` varchar(400) NOT NULL,
  PRIMARY KEY (`codiceSeriale`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prodotto`
--

LOCK TABLES `prodotto` WRITE;
/*!40000 ALTER TABLE `prodotto` DISABLE KEYS */;
INSERT INTO `prodotto` VALUES ('N0001','Jordan 1 Retro High Dior','Nike','Punta tonda, suola piatta in gomma, chiusura frontale con lacci, soletta con logo, motivo con monogramma e altezza alla caviglia.'),('N0002','Jordan 1 Retro High Mocha','Nike','Le scarpe Air Jordan 1, estremamente popolari, sono le Air Jordan piu\' vendute nella storia del marchio, per non parlare poi del successo che hanno avuto le versioni dedicate alla carriera di Michael Jordan.'),('N0003','Nike Dunk Low Panda','Nike','Scarpa Uomo'),('N0004','Nike Air Max 1 x Travis Scott','Nike','Scarpa Uomo'),('N0005','Air Force 1 Low Light Bordeaux','Nike','Air Force 1 Low Light Bordeaux'),('N0006','Air Jordan 1 Low Pinksicle','Nike','Le scarpe Air Jordan 1, estremamente popolari, sono le Air Jordan piu\' vendute nella storia del marchio, per non parlare poi del successo che hanno avuto le versioni dedicate alla carriera di Michael Jordan.'),('O0001','Off-White New Logo','Off-White','Scarpa Uomo'),('O0002','Off-White Low Top ODSY-2000','Off-White','Scarpa Uomo'),('O0003','Off-White Mid Top New Sponge','Off-White','Off-White Mid Top New SpongeOff-White Mid Top New Sponge'),('O0004','Off-White Tela','Off-White','Off-White Tela'),('Y0001','Yeezy Boost 350 Onyx','Yeezy','Scarpa Uomo'),('Y0002','Yeezy 500','Yeezy','Scarpa Uomo'),('Y0003','Yeezy 700','Yeezy','Yeezy 700'),('Y0004','Yeezy Boost 350 Bone','Yeezy','Yeezy Boost 350 Bone');
/*!40000 ALTER TABLE `prodotto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `utente`
--

DROP TABLE IF EXISTS `utente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `utente` (
  `username` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `nome` varchar(50) NOT NULL,
  `cognome` varchar(50) DEFAULT NULL,
  `admin` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `utente`
--

LOCK TABLES `utente` WRITE;
/*!40000 ALTER TABLE `utente` DISABLE KEYS */;
INSERT INTO `utente` VALUES ('Gaetano','MTIzNDU=','gaetano@email.com','Gaetano','Cataldo',0),('Gaetanou','MTIzNDU=','gaetanou@gmail.com','Gaetano','Cataldo',0),('Piero','MTIzNDU=','piero@gmail.com','Piero','Angela',0),('root','cm9vdA==','root@email.com','root','sudo',1);
/*!40000 ALTER TABLE `utente` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-07-20 18:29:33
