-- MySQL dump 10.14  Distrib 5.5.56-MariaDB, for Linux (x86_64)
--
-- Host: localhost    Database: thegaragelabs
-- ------------------------------------------------------
-- Server version	5.5.56-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `categories` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `categories_name_unique` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT INTO `categories` VALUES (1,'Développement web front-end','2016-11-22 09:49:40','2016-11-22 09:49:40'),(2,'Développement web back-end','2016-11-22 09:49:40','2016-11-22 09:49:40'),(3,'Développement de modules back-end','2016-11-22 09:49:40','2016-11-22 09:49:40'),(4,'Développement d\'API','2016-11-22 09:49:40','2016-11-22 09:49:40'),(5,'Développement d\'application mobile native','2016-11-22 09:49:40','2016-11-22 09:49:40'),(6,'Développement d\'application mobile hybride','2016-11-22 09:49:40','2016-11-22 09:49:40'),(7,'Développement d\'application cross-platform','2016-11-22 09:49:40','2016-11-22 09:49:40'),(8,'Développement d\'application WebApp','2016-11-22 09:49:40','2016-11-22 09:49:40'),(9,'Développement d\'application multi-plateforme','2016-11-22 09:49:40','2016-11-22 09:49:40'),(10,'Développement d\'un site sous CMS','2016-11-22 09:49:40','2016-11-22 09:49:40'),(11,'Développement d\'un site e-commerce','2016-11-22 09:49:40','2016-11-22 09:49:40'),(12,'Développement d\'un marketplace','2016-11-22 09:49:40','2016-11-22 09:49:40'),(13,'Développement d\'un site de mise en relation','2016-11-22 09:49:40','2016-11-22 09:49:40'),(14,'Développement hardware','2016-11-22 09:49:40','2016-11-22 09:49:40'),(15,'Développement logiciel/desktop','2016-11-22 09:49:40','2016-11-22 09:49:40'),(16,'Développement logiciel multi-plateforme','2016-11-22 09:49:40','2016-11-22 09:49:40'),(17,'Consulting ciblé','2016-11-22 09:49:40','2016-11-22 09:49:40'),(18,'Gestion de projet fonctionnelle','2016-11-22 09:49:40','2016-11-22 09:49:40'),(19,'Gestion de projet technique','2016-11-22 09:49:40','2016-11-22 09:49:40'),(20,'Direction de projet','2016-11-22 09:49:40','2016-11-22 09:49:40'),(21,'Direction technique','2016-11-22 09:49:40','2016-11-22 09:49:40'),(22,'Maquettage UX (mockups)','2016-11-22 09:49:40','2016-11-22 09:49:40'),(23,'Maquettage UI (créations graphiques)','2016-11-22 09:49:40','2016-11-22 09:49:40'),(24,'NoSQL','2016-11-22 09:49:40','2016-11-22 09:49:40'),(25,'Montage d\'animations/vidéos','2016-11-22 09:49:40','2016-11-22 09:49:40'),(26,'Découpage de créations graphiques','2016-11-22 09:49:40','2016-11-22 09:49:40'),(27,'Intégration graphique (X)HTML/CSS(X)','2016-11-22 09:49:40','2016-11-22 09:49:40'),(28,'Référencement on-site','2016-11-22 09:49:40','2016-11-22 09:49:40'),(29,'Référencement off-site (netlinking)','2016-11-22 09:49:40','2016-11-22 09:49:40'),(30,'Référencement audit & suivi','2016-11-22 09:49:40','2016-11-22 09:49:40'),(31,'Rédaction ou génération de contenu','2016-11-22 09:49:40','2016-11-22 09:49:40'),(32,'Analyses et recommandation marketing','2016-11-22 09:49:40','2016-11-22 09:49:40'),(33,'Analyses et recommandation branding','2016-11-22 09:49:40','2016-11-22 09:49:40'),(34,'Community management','2016-11-22 09:49:40','2016-11-22 09:49:40'),(35,'Sécurité logicielle, audit/patching','2016-11-22 09:49:40','2016-11-22 09:49:40'),(36,'Sécurité serveur, audit/patching','2016-11-22 09:49:40','2016-11-22 09:49:40'),(37,'Mise en production','2016-11-22 09:49:40','2016-11-22 09:49:40'),(38,'Prospection technico-commerciale','2016-11-22 09:49:40','2016-11-22 09:49:40'),(39,'Prospection commerciale','2016-11-22 09:49:40','2016-11-22 09:49:40');
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `category_project`
--

DROP TABLE IF EXISTS `category_project`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `category_project` (
  `category_id` int(10) unsigned NOT NULL,
  `project_id` int(10) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`category_id`,`project_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category_project`
--

LOCK TABLES `category_project` WRITE;
/*!40000 ALTER TABLE `category_project` DISABLE KEYS */;
INSERT INTO `category_project` VALUES (1,1,NULL,NULL),(1,5,NULL,NULL),(1,7,NULL,NULL),(1,15,NULL,NULL),(1,19,NULL,NULL),(1,22,NULL,NULL),(1,23,NULL,NULL),(1,32,NULL,NULL),(1,34,NULL,NULL),(2,1,NULL,NULL),(2,4,NULL,NULL),(2,5,NULL,NULL),(2,8,NULL,NULL),(2,24,NULL,NULL),(2,26,NULL,NULL),(2,29,NULL,NULL),(2,30,NULL,NULL),(2,33,NULL,NULL),(3,2,NULL,NULL),(3,4,NULL,NULL),(3,7,NULL,NULL),(3,8,NULL,NULL),(3,27,NULL,NULL),(3,31,NULL,NULL),(3,35,NULL,NULL),(3,38,NULL,NULL),(4,5,NULL,NULL),(4,8,NULL,NULL),(4,25,NULL,NULL),(4,27,NULL,NULL),(4,28,NULL,NULL),(4,32,NULL,NULL),(4,36,NULL,NULL),(4,39,NULL,NULL),(5,6,NULL,NULL),(5,29,NULL,NULL),(5,35,NULL,NULL),(6,5,NULL,NULL),(7,36,NULL,NULL),(8,40,NULL,NULL),(9,9,NULL,NULL),(9,11,NULL,NULL),(9,14,NULL,NULL),(9,16,NULL,NULL),(9,21,NULL,NULL),(10,11,NULL,NULL),(11,18,NULL,NULL),(12,10,NULL,NULL),(12,17,NULL,NULL),(12,27,NULL,NULL),(14,35,NULL,NULL),(15,20,NULL,NULL),(19,33,NULL,NULL),(20,37,NULL,NULL),(21,13,NULL,NULL),(22,39,NULL,NULL),(37,12,NULL,NULL);
/*!40000 ALTER TABLE `category_project` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `category_startup`
--

DROP TABLE IF EXISTS `category_startup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `category_startup` (
  `s_category_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `start_up_id` int(10) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`s_category_id`,`start_up_id`)
) ENGINE=MyISAM AUTO_INCREMENT=30 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category_startup`
--

LOCK TABLES `category_startup` WRITE;
/*!40000 ALTER TABLE `category_startup` DISABLE KEYS */;
INSERT INTO `category_startup` VALUES (1,5,NULL,NULL),(1,6,NULL,NULL),(18,7,NULL,NULL),(18,8,NULL,NULL),(2,9,NULL,NULL),(18,10,NULL,NULL),(18,11,NULL,NULL),(2,12,NULL,NULL),(4,12,NULL,NULL),(2,13,NULL,NULL),(1,14,NULL,NULL),(17,14,NULL,NULL),(4,15,NULL,NULL),(4,16,NULL,NULL),(6,17,NULL,NULL),(18,18,NULL,NULL),(2,19,NULL,NULL),(20,20,NULL,NULL),(20,21,NULL,NULL),(20,22,NULL,NULL),(20,23,NULL,NULL),(20,24,NULL,NULL),(20,25,NULL,NULL),(20,26,NULL,NULL),(20,27,NULL,NULL),(20,28,NULL,NULL),(2,29,NULL,NULL),(5,30,NULL,NULL),(2,30,NULL,NULL),(19,31,NULL,NULL),(20,31,NULL,NULL),(1,32,NULL,NULL),(17,33,NULL,NULL),(4,34,NULL,NULL),(17,35,NULL,NULL),(24,36,NULL,NULL),(2,37,NULL,NULL),(1,38,NULL,NULL),(6,39,NULL,NULL),(2,40,NULL,NULL),(2,41,NULL,NULL),(3,41,NULL,NULL),(12,42,NULL,NULL),(25,42,NULL,NULL),(29,42,NULL,NULL);
/*!40000 ALTER TABLE `category_startup` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cities`
--

DROP TABLE IF EXISTS `cities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cities` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `country_id` int(10) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `cities_name_country_id_unique` (`name`,`country_id`),
  KEY `cities_country_id_index` (`country_id`),
  CONSTRAINT `cities_country_id_foreign` FOREIGN KEY (`country_id`) REFERENCES `countries` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cities`
--

LOCK TABLES `cities` WRITE;
/*!40000 ALTER TABLE `cities` DISABLE KEYS */;
INSERT INTO `cities` VALUES (1,'Washington',1,NULL,NULL),(2,'London',2,NULL,NULL),(3,'Paris',3,NULL,NULL);
/*!40000 ALTER TABLE `cities` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `contacts`
--

DROP TABLE IF EXISTS `contacts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `contacts` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `start_up_id` int(10) unsigned NOT NULL,
  `author_id` int(10) unsigned NOT NULL,
  `message` text COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=47 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contacts`
--

LOCK TABLES `contacts` WRITE;
/*!40000 ALTER TABLE `contacts` DISABLE KEYS */;
INSERT INTO `contacts` VALUES (34,36,54,'I am very interesting your project .\nI will provide good project for you','2018-01-19 10:36:50','2018-01-19 10:36:50'),(33,34,20,'hi','2018-01-11 17:24:52','2018-01-11 17:24:52'),(32,34,49,'test1','2018-01-08 17:44:46','2018-01-08 17:44:46'),(31,35,49,'hello','2018-01-08 17:44:01','2018-01-08 17:44:01'),(30,34,42,'Hello','2018-01-08 17:11:14','2018-01-08 17:11:14'),(29,34,49,'hello?','2018-01-05 21:32:35','2018-01-05 21:32:35'),(28,35,49,'hello?','2018-01-05 21:32:18','2018-01-05 21:32:18'),(27,34,49,'Hi i like your start-up','2017-12-21 20:00:22','2017-12-21 20:00:22'),(26,15,20,'hiiiiiiii','2017-09-21 19:58:33','2017-09-21 19:58:33'),(25,15,20,'oh','2017-09-18 08:07:26','2017-09-18 08:07:26'),(24,15,20,'hello ? je suis intéressé.','2017-09-09 10:33:42','2017-09-09 10:33:42'),(23,14,20,'test2','2017-09-09 10:25:05','2017-09-09 10:25:05'),(22,14,20,'test','2017-09-09 10:24:31','2017-09-09 10:24:31'),(21,14,43,'Hello user 1','2017-09-09 09:52:31','2017-09-09 09:52:31'),(35,38,43,'Hello','2018-01-31 14:42:03','2018-01-31 14:42:03'),(36,38,53,'hello','2018-01-31 18:07:59','2018-01-31 18:07:59'),(37,38,53,'hi','2018-02-01 17:04:12','2018-02-01 17:04:12'),(38,38,43,'hello','2018-02-03 02:46:55','2018-02-03 02:46:55'),(39,38,43,'ok','2018-02-03 02:47:03','2018-02-03 02:47:03'),(40,38,43,'Hello, I would like to apply','2018-02-03 02:49:39','2018-02-03 02:49:39'),(41,39,43,'Hello','2018-02-19 04:02:50','2018-02-19 04:02:50'),(42,38,49,'Hi','2018-02-19 18:30:26','2018-02-19 18:30:26'),(43,37,49,'hi','2018-02-20 12:16:32','2018-02-20 12:16:32'),(44,38,49,'ok','2018-02-20 12:18:04','2018-02-20 12:18:04'),(45,41,49,'I want to join this fucking startup','2018-03-05 13:29:14','2018-03-05 13:29:14'),(46,41,61,'Je kiffe','2018-03-07 15:42:19','2018-03-07 15:42:19');
/*!40000 ALTER TABLE `contacts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `conversations`
--

DROP TABLE IF EXISTS `conversations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `conversations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `project_id` int(10) unsigned NOT NULL,
  `proposal_id` int(10) unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `conversations_project_id_index` (`project_id`),
  KEY `conversations_proposal_id_index` (`proposal_id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `conversations`
--

LOCK TABLES `conversations` WRITE;
/*!40000 ALTER TABLE `conversations` DISABLE KEYS */;
INSERT INTO `conversations` VALUES (16,25,16,'2017-09-09 10:39:16','2017-09-09 10:39:16'),(17,24,17,'2017-09-24 08:46:58','2017-09-24 08:46:58'),(18,26,20,'2017-10-10 17:08:20','2017-10-10 17:08:20'),(19,27,21,'2017-10-11 09:52:34','2017-10-11 09:52:34'),(20,28,22,'2017-11-12 09:03:21','2017-11-12 09:03:21'),(21,29,23,'2017-12-21 20:06:46','2017-12-21 20:06:46'),(22,35,24,'2018-02-02 11:30:15','2018-02-02 11:30:15'),(23,36,25,'2018-02-03 09:52:36','2018-02-03 09:52:36'),(24,33,26,'2018-02-11 14:02:10','2018-02-11 14:02:10'),(25,37,27,'2018-03-05 11:08:06','2018-03-05 11:08:06');
/*!40000 ALTER TABLE `conversations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `countries`
--

DROP TABLE IF EXISTS `countries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `countries` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `code` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `countries_name_unique` (`name`),
  KEY `countries_code_index` (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `countries`
--

LOCK TABLES `countries` WRITE;
/*!40000 ALTER TABLE `countries` DISABLE KEYS */;
INSERT INTO `countries` VALUES (1,'United States of America',NULL,NULL,NULL),(2,'United Kingdom',NULL,NULL,NULL),(3,'France',NULL,NULL,NULL);
/*!40000 ALTER TABLE `countries` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer_supports`
--

DROP TABLE IF EXISTS `customer_supports`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `customer_supports` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `reason` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `order_id` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `comment` text COLLATE utf8_unicode_ci NOT NULL,
  `type` enum('package','milestone') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'package',
  `service_id` int(10) unsigned NOT NULL,
  `author_id` int(10) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=12 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer_supports`
--

LOCK TABLES `customer_supports` WRITE;
/*!40000 ALTER TABLE `customer_supports` DISABLE KEYS */;
INSERT INTO `customer_supports` VALUES (9,'My delivery is late and the supplier is not replying','111','Please remove','package',30,42,'2018-02-19 04:08:26','2018-02-19 04:08:26'),(10,'My delivery is late and the supplier is not replying','111','Please remove','package',30,42,'2018-02-19 04:11:34','2018-02-19 04:11:34'),(11,'My delivery is late and the supplier is not replying','123','I have a problem','package',31,49,'2018-02-19 14:37:19','2018-02-19 14:37:19');
/*!40000 ALTER TABLE `customer_supports` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `delivery_milestones`
--

DROP TABLE IF EXISTS `delivery_milestones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `delivery_milestones` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `milestone_id` int(10) unsigned NOT NULL,
  `description` text COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=33 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `delivery_milestones`
--

LOCK TABLES `delivery_milestones` WRITE;
/*!40000 ALTER TABLE `delivery_milestones` DISABLE KEYS */;
INSERT INTO `delivery_milestones` VALUES (15,34,'I did your task. \nPlease check attached file.','2017-10-11 10:10:11','2017-10-11 10:10:11'),(16,35,'delivery 2','2017-10-11 11:16:34','2017-10-11 11:16:34'),(17,35,'delivery v2.. thanks','2017-10-11 11:18:30','2017-10-11 11:18:30'),(18,36,'This is the delivery','2017-10-11 14:53:17','2017-10-11 14:53:17'),(19,36,'This is the documents','2017-10-11 14:56:39','2017-10-11 14:56:39'),(20,38,'This is the delivery','2017-10-11 15:03:41','2017-10-11 15:03:41'),(21,39,'DELIVERYY CHECH FILE','2017-10-12 10:20:27','2017-10-12 10:20:27'),(22,39,'DELIVERY 2 for ML3','2017-10-12 10:21:31','2017-10-12 10:21:31'),(23,44,'This is cool','2017-10-15 07:02:11','2017-10-15 07:02:11'),(24,45,'Hello this is the delivery','2017-11-12 02:57:58','2017-11-12 02:57:58'),(25,49,'Here is blablabla.','2017-11-12 09:06:38','2017-11-12 09:06:38'),(26,50,'Here is my stuff eat it','2017-11-13 20:22:09','2017-11-13 20:22:09'),(27,50,'Like this??????','2017-11-13 20:24:12','2017-11-13 20:24:12'),(28,51,'done','2017-12-26 20:01:35','2017-12-26 20:01:35'),(29,53,'Ok','2018-02-03 09:48:21','2018-02-03 09:48:21'),(30,59,'DELIVERY','2018-02-21 19:17:26','2018-02-21 19:17:26'),(31,59,'delivery 2','2018-02-21 19:20:14','2018-02-21 19:20:14'),(32,60,'The delivery 34567','2018-02-22 06:33:11','2018-02-22 06:33:11');
/*!40000 ALTER TABLE `delivery_milestones` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `documents`
--

DROP TABLE IF EXISTS `documents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `documents` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `author_id` int(10) unsigned NOT NULL,
  `filename` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `documents_filename_unique` (`filename`),
  KEY `documents_author_id_index` (`author_id`),
  CONSTRAINT `documents_author_id_foreign` FOREIGN KEY (`author_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `documents`
--

LOCK TABLES `documents` WRITE;
/*!40000 ALTER TABLE `documents` DISABLE KEYS */;
INSERT INTO `documents` VALUES (1,42,'L3cp9Azlz8.docx','2018-01-05 17:29:27','2018-01-05 17:29:27'),(2,53,'AWxxuiDR9B.png','2018-01-31 18:03:17','2018-01-31 18:03:17'),(3,49,'vqOTga4kvc.png','2018-02-19 18:28:01','2018-02-19 18:28:01'),(4,49,'tRdya7XsYi.png','2018-02-19 18:28:18','2018-02-19 18:28:18'),(5,49,'hqfkrMuKyH.jpg','2018-02-21 19:12:11','2018-02-21 19:12:11'),(6,49,'t2ojGL2GXD.jpg','2018-02-21 19:12:44','2018-02-21 19:12:44'),(7,56,'3YdyP9glQ3.png','2018-03-05 10:29:13','2018-03-05 10:29:13'),(8,49,'m6LKbyWkgD.png','2018-03-05 13:18:05','2018-03-05 13:18:05');
/*!40000 ALTER TABLE `documents` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `documenttables`
--

DROP TABLE IF EXISTS `documenttables`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `documenttables` (
  `document_id` int(10) unsigned NOT NULL,
  `documenttable_id` int(10) unsigned NOT NULL,
  `documenttable_type` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`document_id`,`documenttable_id`,`documenttable_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `documenttables`
--

LOCK TABLES `documenttables` WRITE;
/*!40000 ALTER TABLE `documenttables` DISABLE KEYS */;
INSERT INTO `documenttables` VALUES (2,33,'App\\Project',NULL,NULL),(6,78,'App\\Message',NULL,NULL),(7,37,'App\\Project',NULL,NULL);
/*!40000 ALTER TABLE `documenttables` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `feedbacks`
--

DROP TABLE IF EXISTS `feedbacks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `feedbacks` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `author_id` int(10) unsigned NOT NULL,
  `receiver_id` int(10) unsigned NOT NULL,
  `project_id` int(10) unsigned NOT NULL,
  `message` text COLLATE utf8_unicode_ci NOT NULL,
  `rating` int(11) NOT NULL,
  `communication` int(11) NOT NULL DEFAULT '0',
  `skill` int(11) NOT NULL DEFAULT '0',
  `deadline` int(11) NOT NULL DEFAULT '0',
  `experience` int(11) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `feedbacks_author_id_index` (`author_id`),
  KEY `feedbacks_receiver_id_index` (`receiver_id`),
  KEY `feedbacks_project_id_index` (`project_id`),
  CONSTRAINT `feedbacks_author_id_foreign` FOREIGN KEY (`author_id`) REFERENCES `users` (`id`),
  CONSTRAINT `feedbacks_project_id_foreign` FOREIGN KEY (`project_id`) REFERENCES `projects` (`id`),
  CONSTRAINT `feedbacks_receiver_id_foreign` FOREIGN KEY (`receiver_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `feedbacks`
--

LOCK TABLES `feedbacks` WRITE;
/*!40000 ALTER TABLE `feedbacks` DISABLE KEYS */;
INSERT INTO `feedbacks` VALUES (1,53,49,29,'aaaa',4,4,4,4,4,'2018-01-08 17:55:42','2018-01-08 17:55:42');
/*!40000 ALTER TABLE `feedbacks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fonds_types`
--

DROP TABLE IF EXISTS `fonds_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fonds_types` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(250) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fonds_types`
--

LOCK TABLES `fonds_types` WRITE;
/*!40000 ALTER TABLE `fonds_types` DISABLE KEYS */;
INSERT INTO `fonds_types` VALUES (1,'Premiere levee de fonds en preseeed',NULL,NULL),(2,'seconde levee en seed',NULL,NULL),(3,'seconde levee de fonds en serie A',NULL,NULL),(4,'seconde levee de fonds en serie B ',NULL,NULL),(5,'seconde levee de fonds en serie C',NULL,NULL);
/*!40000 ALTER TABLE `fonds_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fundraisings`
--

DROP TABLE IF EXISTS `fundraisings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fundraisings` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `firstname` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `name` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `email` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `mobile` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `problem` text COLLATE utf8_unicode_ci,
  `business_model` text COLLATE utf8_unicode_ci,
  `team` text COLLATE utf8_unicode_ci,
  `author_id` int(10) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fundraisings`
--

LOCK TABLES `fundraisings` WRITE;
/*!40000 ALTER TABLE `fundraisings` DISABLE KEYS */;
INSERT INTO `fundraisings` VALUES (3,'test','123','123','abc@cd.com','1234','tesr','test','test',42,'2018-02-19 03:53:11','2018-02-19 03:53:11'),(4,'STARUP DU FUTUR','Khaled','Khaled Shehata','khaled@novientis.com','063897798789','Coucou','Business model','4 devs',49,'2018-02-19 14:36:28','2018-02-19 14:36:28'),(5,'Lorem','Tom Rip','Bunk','tomripert@gmail.com','07896789654','Lorem ipsum','Lorem ipsum','Lorem ipsum',56,'2018-03-05 10:50:24','2018-03-05 10:50:24');
/*!40000 ALTER TABLE `fundraisings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `galleries`
--

DROP TABLE IF EXISTS `galleries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `galleries` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `type` enum('image','video') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'image',
  `service_id` int(10) unsigned NOT NULL,
  `filename` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=47 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `galleries`
--

LOCK TABLES `galleries` WRITE;
/*!40000 ALTER TABLE `galleries` DISABLE KEYS */;
INSERT INTO `galleries` VALUES (36,'image',16,'gallery/uM4jPlVYg8.jpg','2017-12-17 10:57:08','2017-12-17 10:57:08'),(37,'image',16,'gallery/YKNzioyFw8.jpg','2017-12-17 10:57:08','2017-12-17 10:57:08'),(38,'image',17,'gallery/BwoFVgs5q2.png','2017-12-17 16:22:34','2017-12-17 16:22:34'),(46,'video',18,'https://www.youtube.com/watch?v=MahvzfsDu68','2018-02-02 11:01:33','2018-02-02 11:01:33'),(45,'image',18,'gallery/XAB6XXWmLd.png','2018-02-02 11:01:33','2018-02-02 11:01:33'),(43,'image',19,'gallery/3XrBJWyt91.jpg','2017-12-19 10:36:25','2017-12-19 10:36:25'),(44,'image',20,'gallery/SgnPcSqDJv.jpg','2017-12-19 10:59:29','2017-12-19 10:59:29');
/*!40000 ALTER TABLE `galleries` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `members`
--

DROP TABLE IF EXISTS `members`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `members` (
  `conversation_id` int(10) unsigned NOT NULL,
  `user_id` int(10) unsigned NOT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`conversation_id`,`user_id`),
  KEY `members_user_id_foreign` (`user_id`),
  CONSTRAINT `members_conversation_id_foreign` FOREIGN KEY (`conversation_id`) REFERENCES `conversations` (`id`) ON DELETE CASCADE,
  CONSTRAINT `members_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `members`
--

LOCK TABLES `members` WRITE;
/*!40000 ALTER TABLE `members` DISABLE KEYS */;
INSERT INTO `members` VALUES (16,20,NULL,NULL),(16,46,NULL,NULL),(17,20,NULL,NULL),(17,42,NULL,NULL),(18,42,NULL,NULL),(18,43,NULL,NULL),(19,20,NULL,NULL),(19,49,NULL,NULL),(20,20,NULL,NULL),(20,49,NULL,NULL),(21,49,NULL,NULL),(21,53,NULL,NULL),(22,49,NULL,NULL),(22,53,NULL,NULL),(23,49,NULL,NULL),(23,53,NULL,NULL),(24,49,NULL,NULL),(24,53,NULL,NULL),(25,56,NULL,NULL),(25,58,NULL,NULL);
/*!40000 ALTER TABLE `members` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `messages`
--

DROP TABLE IF EXISTS `messages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `messages` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `conversation_id` int(10) unsigned NOT NULL,
  `sender_id` int(10) unsigned NOT NULL,
  `receiver_id` int(10) unsigned NOT NULL,
  `text` text COLLATE utf8_unicode_ci NOT NULL,
  `read` tinyint(1) NOT NULL DEFAULT '0',
  `updated_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `messages_conversation_id_index` (`conversation_id`),
  KEY `messages_sender_id_index` (`sender_id`),
  KEY `messages_receiver_id_index` (`receiver_id`),
  KEY `messages_created_at_index` (`created_at`),
  CONSTRAINT `messages_receiver_id_foreign` FOREIGN KEY (`receiver_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `messages_sender_id_foreign` FOREIGN KEY (`sender_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=85 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `messages`
--

LOCK TABLES `messages` WRITE;
/*!40000 ALTER TABLE `messages` DISABLE KEYS */;
INSERT INTO `messages` VALUES (44,16,46,20,'hello?\n Offer is 90€',1,'2017-11-12 08:27:35','2017-09-09 10:39:16'),(45,16,20,46,'cool.',1,'2017-09-19 09:42:47','2017-09-09 10:46:51'),(46,16,20,46,'Proposal was accepted. Amount: 90€',1,'2017-09-19 09:42:47','2017-09-09 11:14:22'),(47,16,46,20,'hi',1,'2017-11-12 08:27:35','2017-09-10 08:26:28'),(48,16,46,20,'hi2',1,'2017-11-12 08:27:35','2017-09-10 08:26:51'),(49,17,42,20,'Hello\n Offer is 100€',1,'2017-11-12 08:27:45','2017-09-24 08:46:58'),(50,18,43,42,'I would like to apply for it\n Offer is 2000€',1,'2018-02-22 06:31:32','2017-10-10 17:08:20'),(51,18,42,43,'Proposal was accepted. Amount: 2000€',1,'2018-01-08 17:10:36','2017-10-10 17:09:08'),(52,19,49,20,'Hello?\n Offer is 2500€',1,'2017-11-13 08:52:53','2017-10-11 09:52:34'),(53,19,20,49,'Proposal was accepted. Amount: 2500€',1,'2018-01-08 17:41:44','2017-10-11 09:52:56'),(54,19,49,20,'Is it okay for milestone 2?',1,'2017-11-13 08:52:53','2017-10-11 11:00:01'),(55,19,49,20,'yes',1,'2017-11-13 08:52:53','2017-10-11 11:14:46'),(56,17,20,42,'Proposal was accepted. Amount: 100€',1,'2018-01-08 17:12:21','2017-11-11 18:02:33'),(57,19,20,49,'hello',1,'2018-01-08 17:41:44','2017-11-12 08:28:15'),(58,20,49,20,'Hello?\n Offer is 1150€',1,'2017-11-24 14:01:36','2017-11-12 09:03:21'),(59,20,20,49,'Proposal was accepted. Amount: 1150€',1,'2018-03-05 15:40:52','2017-11-12 09:05:15'),(60,20,20,49,'Thank for acception my ML2 !',1,'2018-03-05 15:40:52','2017-11-13 20:21:20'),(61,21,49,53,'I wanna work with you.\n Offer is 500€',1,'2018-02-02 16:51:22','2017-12-21 20:06:46'),(62,21,53,49,'Proposal was accepted. Amount: 500€',1,'2018-02-02 11:13:38','2017-12-21 20:07:07'),(63,21,53,49,'Hi',1,'2018-02-02 11:13:38','2017-12-21 21:06:38'),(64,21,53,49,'hiii',1,'2018-02-02 11:13:38','2017-12-21 21:06:46'),(65,18,42,43,'hoii',1,'2018-01-08 17:10:36','2018-01-06 09:17:56'),(66,18,42,43,'Nice to meet you',1,'2018-01-08 17:10:36','2018-01-06 09:18:35'),(67,18,42,43,'Hello 1',1,'2018-01-08 17:10:36','2018-01-06 09:19:36'),(68,18,42,43,'Hello 2',1,'2018-01-08 17:10:36','2018-01-06 09:19:41'),(69,21,53,49,'hi?',1,'2018-02-02 11:13:38','2018-01-08 17:39:25'),(70,22,49,53,'Hi,\nI have experience in blabla.\nhttps://coco.com\ncheck my portfolio.\nThanks\n Offer is 930€',1,'2018-02-03 09:47:19','2018-02-02 11:30:15'),(71,22,53,49,'Proposal was accepted. Amount: 930€',1,'2018-02-03 09:50:56','2018-02-02 11:31:46'),(72,22,53,49,'I accepted your offer.',1,'2018-02-03 09:50:56','2018-02-02 11:31:58'),(73,23,49,53,'Hello?\n Offer is 750€',1,'2018-02-19 14:03:46','2018-02-03 09:52:36'),(74,23,53,49,'Proposal was accepted. Amount: 750€',1,'2018-02-22 11:29:19','2018-02-03 09:52:59'),(75,24,49,53,'Mssage\n Offer is 2000€',1,'2018-02-21 19:18:52','2018-02-11 14:02:10'),(76,23,49,53,'hi',1,'2018-02-19 14:03:46','2018-02-11 14:05:03'),(77,24,49,53,'Hello',1,'2018-02-21 19:18:52','2018-02-19 18:28:19'),(78,24,49,53,'hello plz',1,'2018-02-21 19:18:52','2018-02-21 19:12:46'),(79,24,49,53,'Offer was updated. Amount: 2000€',1,'2018-02-21 19:18:52','2018-02-21 19:13:08'),(80,24,53,49,'Proposal was accepted. Amount: 2000€',1,'2018-02-22 10:34:02','2018-02-21 19:13:33'),(81,24,53,49,'Proposal was accepted. Amount: 2000€',1,'2018-02-22 10:34:02','2018-02-21 19:13:33'),(82,25,58,56,'I\'m interested\n Offer is 2000€',1,'2018-03-05 12:01:35','2018-03-05 11:08:06'),(83,25,56,58,'Proposal was accepted. Amount: 2000€',1,'2018-03-05 11:54:26','2018-03-05 11:08:48'),(84,25,56,58,'jnkknjk.',1,'2018-03-05 11:54:26','2018-03-05 11:08:55');
/*!40000 ALTER TABLE `messages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `migrations`
--

DROP TABLE IF EXISTS `migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `migrations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=307 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `migrations`
--

LOCK TABLES `migrations` WRITE;
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
INSERT INTO `migrations` VALUES (289,'2014_10_12_000000_create_users_table',1),(290,'2014_10_12_100000_create_password_resets_table',1),(291,'2016_10_10_193057_create_countries_table',1),(292,'2016_10_10_193433_create_cities_table',1),(293,'2016_10_10_193727_create_projects_table',1),(294,'2016_10_10_194935_create_categories_table',1),(295,'2016_10_10_195322_category_project',1),(296,'2016_10_10_200343_create_documents_table',1),(297,'2016_10_10_200631_create_proposals_table',1),(298,'2016_10_10_201231_create_references_table',1),(299,'2016_10_10_201747_create_messages_table',1),(300,'2016_10_10_202138_create_notifications_table',1),(301,'2016_10_10_202443_create_feedbacks_table',1),(302,'2016_10_12_110501_create_documenttables_table',1),(303,'2016_10_20_015029_create_tags_table',1),(304,'2016_10_20_015046_create_table_project_tag',1),(305,'2016_11_08_141227_create_conversations_table',1),(306,'2016_11_08_141831_create_members_table',1);
/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `milestone_documents`
--

DROP TABLE IF EXISTS `milestone_documents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `milestone_documents` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `filename` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `milestone_id` int(10) unsigned NOT NULL,
  `type` enum('milestone','delivery') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'milestone',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=28 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `milestone_documents`
--

LOCK TABLES `milestone_documents` WRITE;
/*!40000 ALTER TABLE `milestone_documents` DISABLE KEYS */;
INSERT INTO `milestone_documents` VALUES (11,'htvDj7x1s5.xlsx',38,'milestone','2017-10-11 15:02:47','2017-10-11 15:02:47'),(12,'wuiOxXMQrI.xlsx',20,'delivery','2017-10-11 15:03:41','2017-10-11 15:03:41'),(13,'uAfuZBo7tP.pdf',41,'milestone','2017-10-12 10:17:56','2017-10-12 10:17:56'),(14,'OP2KQ5kKS2.pdf',21,'delivery','2017-10-12 10:20:27','2017-10-12 10:20:27'),(15,'89uWvdU636.pdf',22,'delivery','2017-10-12 10:21:31','2017-10-12 10:21:31'),(16,'KS0xSX72uH.docx',42,'milestone','2017-10-15 06:49:02','2017-10-15 06:49:02'),(17,'0rSTotZpUj.xlsx',42,'milestone','2017-10-15 06:49:02','2017-10-15 06:49:02'),(18,'KS0xSX72uH.docx',43,'milestone','2017-10-15 06:54:07','2017-10-15 06:54:07'),(19,'0rSTotZpUj.xlsx',43,'milestone','2017-10-15 06:54:07','2017-10-15 06:54:07'),(20,'Z6yHNIqgVE.docx',44,'milestone','2017-10-15 06:59:37','2017-10-15 06:59:37'),(21,'l9PW1mBiRN.docx',23,'delivery','2017-10-15 07:02:11','2017-10-15 07:02:11'),(22,'fyrAPDE8gu.jpg',24,'delivery','2017-11-12 02:57:58','2017-11-12 02:57:58'),(23,'w5odOIHhtg.png',26,'delivery','2017-11-13 20:22:09','2017-11-13 20:22:09'),(24,'DW5raWf0G2.jpg',59,'milestone','2018-02-21 19:16:28','2018-02-21 19:16:28'),(25,'8znGIw5xBC.PNG',60,'milestone','2018-02-22 06:31:59','2018-02-22 06:31:59'),(26,'08cwpfLv26.docx',32,'delivery','2018-02-22 06:33:11','2018-02-22 06:33:11'),(27,'O7JzEYEugy.xlsx',32,'delivery','2018-02-22 06:33:11','2018-02-22 06:33:11');
/*!40000 ALTER TABLE `milestone_documents` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `milestones`
--

DROP TABLE IF EXISTS `milestones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `milestones` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `proposal_id` int(10) unsigned NOT NULL,
  `title` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `description` text COLLATE utf8_unicode_ci NOT NULL,
  `deadline` date NOT NULL,
  `price` int(10) unsigned NOT NULL,
  `status` enum('revision','waiting','accepted','rejected','submitted','approved','new') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'waiting',
  `author_id` int(10) unsigned NOT NULL,
  `supplier_inv_id` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `owner_inv_id` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `inv_created_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `funding_date` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=63 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `milestones`
--

LOCK TABLES `milestones` WRITE;
/*!40000 ALTER TABLE `milestones` DISABLE KEYS */;
INSERT INTO `milestones` VALUES (34,21,'Front end devs','1. do this\n2. do that.\n3. do this and that.','2017-10-12',50,'approved',20,NULL,NULL,NULL,'2017-10-11 10:05:36','2017-10-11 10:11:00','2017-10-15 00:00:00'),(35,21,'aaaa','bbb','2017-11-01',10,'approved',20,NULL,NULL,NULL,'2017-10-11 10:45:33','2017-10-11 11:18:49','2017-10-15 00:00:00'),(36,20,'This is the title 1','The description for milestone 1','2017-10-18',500,'approved',42,NULL,NULL,NULL,'2017-10-11 14:51:13','2017-10-11 14:56:55','2017-10-15 00:00:00'),(37,20,'Milestone 2','This is the Milestone 2','2017-10-18',200,'waiting',42,NULL,NULL,NULL,'2017-10-11 14:58:36','2017-10-11 14:58:36','2017-10-15 00:00:00'),(38,20,'Milestone 3','Milestone 3','2017-10-18',300,'approved',42,NULL,NULL,NULL,'2017-10-11 15:02:47','2017-10-11 15:04:18','2017-10-15 00:00:00'),(39,21,'ML3','ssss','2017-11-02',100,'approved',20,NULL,NULL,NULL,'2017-10-11 19:12:14','2017-10-12 10:21:55','2017-10-15 00:00:00'),(40,21,'Test milestone 3','Description of ML3','2017-10-26',100,'waiting',20,NULL,NULL,NULL,'2017-10-12 10:16:46','2017-10-12 10:16:46','2017-10-15 00:00:00'),(41,21,'ML4','ML4','2017-10-26',10,'waiting',20,NULL,NULL,NULL,'2017-10-12 10:17:56','2017-10-12 10:17:56','2017-10-15 00:00:00'),(42,20,'The milestone 4','This is the milestone 4','2017-10-24',1000,'waiting',42,NULL,NULL,NULL,'2017-10-15 06:49:02','2017-11-12 04:15:34','2017-11-12 04:15:34'),(43,20,'The milestone 4','This is the milestone 4','2017-10-24',500,'waiting',42,NULL,NULL,NULL,'2017-10-15 06:54:07','2017-10-15 06:57:03','2017-10-15 06:57:03'),(44,20,'This is the title 6','This is the title 6','2017-10-15',200,'approved',42,NULL,NULL,NULL,'2017-10-15 06:59:37','2017-10-15 07:05:17','2017-10-15 06:59:37'),(45,20,'This is the title 7','This is the title 7','2017-10-25',1000,'approved',42,'X9SCWG4543-12112017','X9SCWG4542-12112017','2017-11-12 03:00:41','2017-10-15 07:01:12','2017-11-12 03:00:41','2017-10-12 02:54:40'),(46,21,'M6','D6','2017-10-17',50,'accepted',20,NULL,NULL,NULL,'2017-10-15 09:03:22','2017-12-01 17:09:04','2017-10-15 09:03:33'),(47,21,'sdssd','sdsdsds','2017-11-23',1000,'accepted',20,NULL,NULL,NULL,'2017-11-06 17:21:20','2017-12-01 17:09:00','2017-11-06 17:21:20'),(48,17,'M1','S','2017-11-24',1000,'waiting',20,NULL,NULL,NULL,'2017-11-11 18:03:16','2017-11-11 18:03:16','2017-11-11 18:03:16'),(49,22,'Do that in ML1 ','Description','2017-11-29',500,'approved',20,'UGZFLQ4949-12112017','UGZFLQ4920-12112017','2017-11-12 09:07:23','2017-11-12 09:06:01','2017-11-12 09:07:23','2017-11-12 09:06:01'),(50,22,'Do that please now !!','Descri','2017-11-16',1000,'approved',20,'HAESVM5049-13112017','HAESVM5020-13112017','2017-11-13 20:25:17','2017-11-13 20:19:45','2017-11-13 20:25:17','2017-11-13 20:19:45'),(51,23,'XXXXX','ABC','2017-12-27',10000,'approved',53,'7O2ZAD5149-08012018','7O2ZAD5153-08012018','2018-01-08 17:55:35','2017-12-21 21:06:08','2018-01-08 17:55:35','2017-12-21 21:06:08'),(52,23,'ML2','Desc','2018-01-31',100,'new',53,NULL,NULL,NULL,'2018-02-02 11:10:04','2018-02-02 11:10:04',NULL),(53,24,'ML1','Desc','2018-02-03',100,'submitted',53,NULL,NULL,NULL,'2018-02-02 11:33:51','2018-02-03 09:48:21','2018-02-03 09:47:35'),(54,25,'ML1','DE','2018-02-04',100,'accepted',53,NULL,NULL,NULL,'2018-02-03 09:53:32','2018-02-03 09:53:52','2018-02-03 09:53:32'),(55,25,'M2','DEC2','2018-02-05',100,'accepted',53,NULL,NULL,NULL,'2018-02-03 09:54:33','2018-02-03 11:18:15','2018-02-03 09:55:57'),(56,25,'MIlestone 3','aaaaa','2018-02-14',500,'accepted',53,NULL,NULL,NULL,'2018-02-11 14:01:21','2018-02-19 14:15:00','2018-02-11 14:01:21'),(57,20,'test','test','2018-02-20',100,'waiting',42,NULL,NULL,NULL,'2018-02-19 04:27:42','2018-02-19 04:27:42','2018-02-19 04:27:42'),(58,20,'Test','Test','2018-02-20',100,'waiting',42,NULL,NULL,NULL,'2018-02-19 04:28:03','2018-02-19 04:28:21','2018-02-19 04:28:21'),(59,26,'ML1','DESC','2018-02-28',200,'submitted',53,NULL,NULL,NULL,'2018-02-21 19:16:28','2018-02-21 19:20:14','2018-02-21 19:16:28'),(60,20,'Test milestone 777','Test milestone 777','2018-02-28',100,'submitted',42,NULL,NULL,NULL,'2018-02-22 06:31:59','2018-02-22 06:33:11','2018-02-22 06:31:59'),(61,27,'M1','Lorem ipsum','2018-03-29',500,'waiting',56,NULL,NULL,NULL,'2018-03-05 11:59:17','2018-03-05 11:59:37','2018-03-05 11:59:37'),(62,27,'M2','Lorem ipsum','2018-04-06',500,'waiting',56,NULL,NULL,NULL,'2018-03-05 12:01:48','2018-03-05 12:02:02','2018-03-05 12:02:02');
/*!40000 ALTER TABLE `milestones` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notifications`
--

DROP TABLE IF EXISTS `notifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `notifications` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `receiver_id` int(10) unsigned NOT NULL,
  `title` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `message` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `link` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `is_read` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `notifications_receiver_id_index` (`receiver_id`)
) ENGINE=InnoDB AUTO_INCREMENT=304 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notifications`
--

LOCK TABLES `notifications` WRITE;
/*!40000 ALTER TABLE `notifications` DISABLE KEYS */;
INSERT INTO `notifications` VALUES (48,42,'New start-up','Your start-up has been successfully created','/startups/test-the-startup-title-1-566',1,'2017-09-08 16:28:05','2018-02-22 06:33:19'),(49,42,'New project','Your project has been successfully created','/projects/23',1,'2017-09-08 16:29:16','2018-02-22 06:33:19'),(50,20,'New project','Your project has been successfully created','/projects/24',1,'2017-09-08 23:24:48','2018-01-11 17:26:29'),(51,42,'New Contact to your startup','ms user2:\nHello user 1','/startups/test-the-startup-title-1-566',1,'2017-09-09 09:52:31','2018-02-22 06:33:19'),(52,43,'New message from mr user1','Hello user 2','/user/messages/startup-thread/21',1,'2017-09-09 09:53:00','2018-02-22 06:32:26'),(53,42,'New message from ms user2','Hello','/user/messages/startup-thread/21',1,'2017-09-09 09:53:30','2018-02-22 06:33:19'),(54,42,'New Contact to your startup','Khaled Shehata:\ntest','/startups/test-the-startup-title-1-566',1,'2017-09-09 10:24:31','2018-02-22 06:33:19'),(55,42,'New Contact to your startup','Khaled Shehata:\ntest2','/startups/test-the-startup-title-1-566',1,'2017-09-09 10:25:05','2018-02-22 06:33:19'),(56,46,'New start-up','Your start-up has been successfully created','/startups/startup-proj-167',1,'2017-09-09 10:32:59','2017-09-19 09:41:57'),(57,46,'New Contact to your startup','Khaled Shehata:\nhello ? je suis intéressé.','/startups/startup-proj-167',1,'2017-09-09 10:33:42','2017-09-19 09:41:57'),(58,20,'New message from Founder1 Stanislas','Bonjour','/user/messages/startup-thread/24',1,'2017-09-09 10:34:16','2018-01-11 17:26:29'),(59,46,'New message from Khaled Shehata','Hi','/user/messages/startup-thread/24',1,'2017-09-09 10:34:44','2017-09-19 09:41:57'),(60,20,'New project','Your project has been successfully created','/projects/25',1,'2017-09-09 10:36:40','2018-01-11 17:26:29'),(61,20,'New proposal to your project','User Founder1 Stanislas has made proposal to your project.\nOffer: 90 €','/user/messages/thread/16',1,'2017-09-09 10:39:16','2018-01-11 17:26:29'),(62,46,'Your proposal was accepted','User Khaled Shehata has accepted your proposal.\nOffer: 90 €','/projects/website-a-monter-rapidement-482',1,'2017-09-09 11:14:22','2017-09-19 09:41:57'),(63,20,'New message from Founder1 Stanislas','cava?','/user/messages/startup-thread/24',1,'2017-09-10 19:50:03','2018-01-11 17:26:29'),(64,20,'New message from Founder1 Stanislas','ou pas','/user/messages/startup-thread/24',1,'2017-09-10 19:50:11','2018-01-11 17:26:29'),(65,20,'New message from mr user1','Hello there','/user/messages/startup-thread/23',1,'2017-09-11 01:22:35','2018-01-11 17:26:29'),(66,43,'New message from mr user1','Hello user2','/user/messages/startup-thread/21',1,'2017-09-11 01:23:25','2018-02-22 06:32:26'),(67,20,'New message from Founder1 Stanislas','look','/user/messages/startup-thread/24',1,'2017-09-11 18:28:52','2018-01-11 17:26:29'),(68,46,'New Contact to your startup','Khaled Shehata:\noh','/startups/startup-proj-167',1,'2017-09-18 08:07:26','2017-09-19 09:41:57'),(69,46,'New Contact to your startup','Khaled Shehata:\nhiiiiiiii','/startups/startup-proj-167',0,'2017-09-21 19:58:33','2017-09-21 19:58:33'),(70,20,'New proposal to your project','User mr user1 has made proposal to your project.\nOffer: 100 €','/user/messages/thread/17',1,'2017-09-24 08:46:58','2018-01-11 17:26:29'),(71,46,'New message from Khaled Shehata','hi','/user/messages/startup-thread/24',0,'2017-10-09 12:49:27','2017-10-09 12:49:27'),(72,42,'New project','Your project has been successfully created','/projects/26',1,'2017-10-10 17:04:43','2018-02-22 06:33:19'),(73,42,'New proposal to your project','User ms user2 has made proposal to your project.\nOffer: 2000 €','/user/messages/thread/18',1,'2017-10-10 17:08:20','2018-02-22 06:33:19'),(74,43,'Your proposal was accepted','User mr user1 has accepted your proposal.\nOffer: 2000 €','/projects/implement-angular-project-188',1,'2017-10-10 17:09:08','2018-02-22 06:32:26'),(75,20,'New project','Your project has been successfully created','/projects/27',1,'2017-10-11 09:48:33','2018-01-11 17:26:29'),(76,20,'New proposal to your project','User One Who has made proposal to your project.\nOffer: 2500 €','/user/messages/thread/19',1,'2017-10-11 09:52:34','2018-01-11 17:26:29'),(77,49,'Your proposal was accepted','User Khaled Shehata has accepted your proposal.\nOffer: 2500 €','/projects/new-marketplace-to-build-quickly-309',1,'2017-10-11 09:52:56','2018-03-05 15:44:04'),(78,49,'New milestone \"Front end devs\" was funded','New milestone Front end devs was funded\nAmmount: 50 €','/projects/milestone/management/21',1,'2017-10-11 10:05:37','2018-03-05 15:44:04'),(79,20,'The milestone \"Front end devs\" was accepted','The milestone Front end devs was accepted\nAmmount: 50 €','/projects/milestone/owner/management/21',1,'2017-10-11 10:06:30','2018-01-11 17:26:29'),(80,20,'The milestone \"Front end devs\" was delivery','The milestone Front end devs was delivery\nAmmount: 50 €','/projects/milestone/owner/management/21',1,'2017-10-11 10:10:11','2018-01-11 17:26:29'),(81,49,'The milestone \"Front end devs\" was approved','The milestone Front end devs was approved\nAmmount: 50 €','/projects/milestone/management/21',1,'2017-10-11 10:11:00','2018-03-05 15:44:04'),(82,49,'New milestone \"aaaa\" was funded','New milestone aaaa was funded\nAmmount: 10 €','/projects/milestone/management/21',1,'2017-10-11 10:45:33','2018-03-05 15:44:04'),(83,20,'The milestone \"aaaa\" was accepted','The milestone aaaa was accepted\nAmmount: 10 €','/projects/milestone/owner/management/21',1,'2017-10-11 10:55:57','2018-01-11 17:26:29'),(84,20,'The milestone \"aaaa\" was delivery','The milestone aaaa was delivery\nAmmount: 10 €','/projects/milestone/owner/management/21',1,'2017-10-11 11:16:34','2018-01-11 17:26:29'),(85,49,'The milestone \"aaaa\" was asked revision.','The milestone aaaa was asked revision.\nAmmount: 10 €','/projects/milestone/management/21',1,'2017-10-11 11:17:06','2018-03-05 15:44:04'),(86,20,'The milestone \"aaaa\" was delivery','The milestone aaaa was delivery\nAmmount: 10 €','/projects/milestone/owner/management/21',1,'2017-10-11 11:18:30','2018-01-11 17:26:29'),(87,49,'The milestone \"aaaa\" was approved','The milestone aaaa was approved\nAmmount: 10 €','/projects/milestone/management/21',1,'2017-10-11 11:18:49','2018-03-05 15:44:04'),(88,43,'New milestone \"This is the title 1\" was funded','New milestone This is the title 1 was funded\nAmmount: 500 €','/projects/milestone/management/20',1,'2017-10-11 14:51:14','2018-02-22 06:32:26'),(89,42,'The milestone \"This is the title 1\" was accepted','The milestone This is the title 1 was accepted\nAmmount: 500 €','/projects/milestone/owner/management/20',1,'2017-10-11 14:52:38','2018-02-22 06:33:19'),(90,42,'The milestone \"This is the title 1\" was delivery','The milestone This is the title 1 was delivery\nAmmount: 500 €','/projects/milestone/owner/management/20',1,'2017-10-11 14:53:17','2018-02-22 06:33:19'),(91,43,'The milestone \"This is the title 1\" was asked revision.','The milestone This is the title 1 was asked revision.\nAmmount: 500 €','/projects/milestone/management/20',1,'2017-10-11 14:55:36','2018-02-22 06:32:26'),(92,42,'The milestone \"This is the title 1\" was delivery','The milestone This is the title 1 was delivery\nAmmount: 500 €','/projects/milestone/owner/management/20',1,'2017-10-11 14:56:39','2018-02-22 06:33:19'),(93,43,'The milestone \"This is the title 1\" was approved','The milestone This is the title 1 was approved\nAmmount: 500 €','/projects/milestone/management/20',1,'2017-10-11 14:56:55','2018-02-22 06:32:26'),(94,43,'New milestone \"Milestone 2\" was funded','New milestone Milestone 2 was funded\nAmmount: 200 €','/projects/milestone/management/20',1,'2017-10-11 14:58:36','2018-02-22 06:32:26'),(95,43,'New milestone \"Milestone 3\" was funded','New milestone Milestone 3 was funded\nAmmount: 300 €','/projects/milestone/management/20',1,'2017-10-11 15:02:47','2018-02-22 06:32:26'),(96,42,'The milestone \"Milestone 3\" was accepted','The milestone Milestone 3 was accepted\nAmmount: 300 €','/projects/milestone/owner/management/20',1,'2017-10-11 15:03:28','2018-02-22 06:33:19'),(97,42,'The milestone \"Milestone 3\" was delivery','The milestone Milestone 3 was delivery\nAmmount: 300 €','/projects/milestone/owner/management/20',1,'2017-10-11 15:03:41','2018-02-22 06:33:19'),(98,43,'The milestone \"Milestone 3\" was approved','The milestone Milestone 3 was approved\nAmmount: 300 €','/projects/milestone/management/20',1,'2017-10-11 15:04:18','2018-02-22 06:32:26'),(99,49,'New milestone \"ML3\" was funded','New milestone ML3 was funded\nAmmount: 100 €','/projects/milestone/management/21',1,'2017-10-11 19:12:14','2018-03-05 15:44:04'),(100,20,'The milestone \"ML3\" was accepted','The milestone ML3 was accepted\nAmmount: 100 €','/projects/milestone/owner/management/21',1,'2017-10-11 19:14:56','2018-01-11 17:26:29'),(101,49,'New milestone \"Test milestone 3\" was funded','New milestone Test milestone 3 was funded\nAmmount: 100 €','/projects/milestone/management/21',1,'2017-10-12 10:16:47','2018-03-05 15:44:04'),(102,49,'New milestone \"ML4\" was funded','New milestone ML4 was funded\nAmmount: 10 €','/projects/milestone/management/21',1,'2017-10-12 10:17:56','2018-03-05 15:44:04'),(103,20,'The milestone \"ML3\" was delivery','The milestone ML3 was delivery\nAmmount: 100 €','/projects/milestone/owner/management/21',1,'2017-10-12 10:20:27','2018-01-11 17:26:29'),(104,49,'The milestone \"ML3\" was asked revision.','The milestone ML3 was asked revision.\nAmmount: 100 €','/projects/milestone/management/21',1,'2017-10-12 10:21:01','2018-03-05 15:44:04'),(105,20,'The milestone \"ML3\" was delivery','The milestone ML3 was delivery\nAmmount: 100 €','/projects/milestone/owner/management/21',1,'2017-10-12 10:21:31','2018-01-11 17:26:29'),(106,49,'The milestone \"ML3\" was approved','The milestone ML3 was approved\nAmmount: 100 €','/projects/milestone/management/21',1,'2017-10-12 10:21:55','2018-03-05 15:44:04'),(107,20,'New start-up','Your start-up has been successfully created','/startups/mobile-app-test-project-239',1,'2017-10-12 10:40:05','2018-01-11 17:26:29'),(108,43,'New milestone \"The milestone 4\" was funded','New milestone The milestone 4 was funded\nAmmount: 500 €','/projects/milestone/management/20',1,'2017-10-15 06:57:04','2018-02-22 06:32:26'),(109,43,'New milestone \"This is the title 6\" was funded','New milestone This is the title 6 was funded\nAmmount: 200 €','/projects/milestone/management/20',1,'2017-10-15 06:59:38','2018-02-22 06:32:26'),(111,42,'The milestone \"This is the title 6\" was delivery','The milestone This is the title 6 was delivery\nAmmount: 200 €','/projects/milestone/owner/management/20',1,'2017-10-15 07:02:11','2018-02-22 06:33:19'),(112,43,'The milestone \"This is the title 6\" was approved','The milestone This is the title 6 was approved\nAmmount: 200 €','/projects/milestone/management/20',1,'2017-10-15 07:05:17','2018-02-22 06:32:26'),(113,49,'New milestone \"M6\" was funded','New milestone M6 was funded\nAmmount: 50 €','/projects/milestone/management/21',1,'2017-10-15 09:03:33','2018-03-05 15:44:04'),(114,50,'New start-up','Your start-up has been successfully created','/startups/fongoh-martin-s-digital-renter-383',0,'2017-10-17 14:52:13','2017-10-17 14:52:13'),(115,42,'New start-up','Your start-up has been successfully created','/startups/this-is-the-title-1-933',1,'2017-10-17 14:54:46','2018-02-22 06:33:19'),(116,42,'New start-up','Your start-up has been successfully created','/startups/test-startup-1-762',1,'2017-10-30 01:04:07','2018-02-22 06:33:19'),(117,49,'New milestone \"sdssd\" was funded','New milestone sdssd was funded\nAmmount: 1000 €','/projects/milestone/management/21',1,'2017-11-06 17:21:21','2018-03-05 15:44:04'),(118,42,'Your proposal was accepted','User Khaled Shehata has accepted your proposal.\nOffer: 100 €','/projects/projet-test-353',1,'2017-11-11 18:02:33','2018-02-22 06:33:19'),(119,42,'New milestone \"M1\" was funded','New milestone M1 was funded\nAmmount: 1000 €','/projects/milestone/management/17',1,'2017-11-11 18:03:17','2018-02-22 06:33:19'),(120,42,'New start-up','Your start-up has been successfully created','/startups/this-is-the-title-1-405',1,'2017-11-12 00:42:46','2018-02-22 06:33:19'),(121,42,'New start-up','Your start-up has been successfully created','/startups/this-is-the-title-1-405',1,'2017-11-12 01:35:23','2018-02-22 06:33:19'),(122,43,'New milestone \"This is the title 7\" was funded','New milestone This is the title 7 was funded\nAmmount: 1000 €','/projects/milestone/management/20',1,'2017-11-12 02:54:41','2018-02-22 06:32:26'),(123,42,'The milestone \"This is the title 7\" was accepted','The milestone This is the title 7 was accepted\nAmmount: 1000 €','/projects/milestone/owner/management/20',1,'2017-11-12 02:57:11','2018-02-22 06:33:19'),(124,42,'The milestone \"This is the title 7\" was delivery','The milestone This is the title 7 was delivery\nAmmount: 1000 €','/projects/milestone/owner/management/20',1,'2017-11-12 02:57:58','2018-02-22 06:33:19'),(125,43,'The milestone \"This is the title 7\" was approved','The milestone This is the title 7 was approved\nAmmount: 1000 €','/projects/milestone/management/20',1,'2017-11-12 03:00:41','2018-02-22 06:32:26'),(126,43,'New milestone \"The milestone 4\" was funded','New milestone The milestone 4 was funded\nAmmount: 1000 €','/projects/milestone/management/20',1,'2017-11-12 04:15:35','2018-02-22 06:32:26'),(127,42,'New start-up','Your start-up has been successfully created','/startups/implement-vue-project-875',1,'2017-11-12 05:30:32','2018-02-22 06:33:19'),(128,42,'New start-up','Your start-up has been successfully created','/startups/implement-vue-project-875',1,'2017-11-12 05:33:44','2018-02-22 06:33:19'),(129,42,'New start-up','Your start-up has been successfully created','/startups/implement-vue-project-875',1,'2017-11-12 05:39:26','2018-02-22 06:33:19'),(130,42,'New member has joined your team',' accepted to join your team.','/startups/implement-vue-project-875',1,'2017-11-12 05:39:44','2018-02-22 06:33:19'),(131,20,'New start-up','Your start-up has been successfully created','/startups/start-up-fintech-841',1,'2017-11-12 08:20:40','2018-01-11 17:26:29'),(132,20,'New project','Your project has been successfully created','/projects/28',1,'2017-11-12 08:57:56','2018-01-11 17:26:29'),(133,20,'New proposal to your project','User One Who has made proposal to your project.\nOffer: 1150 €','/user/messages/thread/20',1,'2017-11-12 09:03:21','2018-01-11 17:26:29'),(134,49,'Your proposal was accepted','User Khaled Shehata has accepted your proposal.\nOffer: 1150 €','/projects/project-abc-945',1,'2017-11-12 09:05:15','2018-03-05 15:44:04'),(135,49,'New milestone \"Do that in ML1 \" was funded','New milestone Do that in ML1  was funded\nAmmount: 500 €','/projects/milestone/management/22',1,'2017-11-12 09:06:01','2018-03-05 15:44:04'),(136,20,'The milestone \"Do that in ML1 \" was accepted','The milestone Do that in ML1  was accepted\nAmmount: 500 €','/projects/milestone/owner/management/22',1,'2017-11-12 09:06:20','2018-01-11 17:26:29'),(137,20,'The milestone \"Do that in ML1 \" was delivery','The milestone Do that in ML1  was delivery\nAmmount: 500 €','/projects/milestone/owner/management/22',1,'2017-11-12 09:06:38','2018-01-11 17:26:29'),(138,49,'The milestone \"Do that in ML1 \" was approved','The milestone Do that in ML1  was approved\nAmmount: 500 €','/projects/milestone/management/22',1,'2017-11-12 09:07:23','2018-03-05 15:44:04'),(139,42,'New start-up','Your start-up has been successfully created','/startups/test-the-startup-770',1,'2017-11-13 00:49:46','2018-02-22 06:33:19'),(140,42,'New start-up','Your start-up has been successfully created','/startups/this-is-the-title-1111-851',1,'2017-11-13 01:11:15','2018-02-22 06:33:19'),(141,42,'New member has joined your team',' accepted to join your team.','/startups/this-is-the-title-1111-851',1,'2017-11-13 01:13:44','2018-02-22 06:33:19'),(142,53,'New start-up','Your start-up has been successfully created','/startups/start-up-xyz-469',1,'2017-11-13 07:17:45','2018-03-22 06:45:52'),(143,49,'New milestone \"Do that please now !!\" was funded','New milestone Do that please now !! was funded\nAmmount: 1000 €','/projects/milestone/management/22',1,'2017-11-13 20:19:46','2018-03-05 15:44:04'),(144,20,'The milestone \"Do that please now !!\" was accepted','The milestone Do that please now !! was accepted\nAmmount: 1000 €','/projects/milestone/owner/management/22',1,'2017-11-13 20:20:10','2018-01-11 17:26:29'),(145,20,'The milestone \"Do that please now !!\" was delivery','The milestone Do that please now !! was delivery\nAmmount: 1000 €','/projects/milestone/owner/management/22',1,'2017-11-13 20:22:09','2018-01-11 17:26:29'),(146,49,'The milestone \"Do that please now !!\" was asked revision.','The milestone Do that please now !! was asked revision.\nAmmount: 1000 €','/projects/milestone/management/22',1,'2017-11-13 20:23:10','2018-03-05 15:44:04'),(147,20,'The milestone \"Do that please now !!\" was delivery','The milestone Do that please now !! was delivery\nAmmount: 1000 €','/projects/milestone/owner/management/22',1,'2017-11-13 20:24:12','2018-01-11 17:26:29'),(148,49,'The milestone \"Do that please now !!\" was approved','The milestone Do that please now !! was approved\nAmmount: 1000 €','/projects/milestone/management/22',1,'2017-11-13 20:25:17','2018-03-05 15:44:04'),(149,20,'The milestone \"sdssd\" was accepted','The milestone sdssd was accepted\nAmmount: 1000 €','/projects/milestone/owner/management/21',1,'2017-12-01 17:09:00','2018-01-11 17:26:29'),(150,20,'The milestone \"M6\" was accepted','The milestone M6 was accepted\nAmmount: 50 €','/projects/milestone/owner/management/21',1,'2017-12-01 17:09:04','2018-01-11 17:26:29'),(151,42,'New start-up','Your start-up has been successfully created','/startups/this-is-the-title-1-238',1,'2017-12-18 01:19:36','2018-02-22 06:33:19'),(152,42,'New package  was ordered','New package of your service \"Implement angular project service\" was ordered\nAmmount: 234 €','/user/sold-package/20',1,'2017-12-18 16:58:42','2018-02-22 06:33:19'),(153,43,'The package  was delivered','The package of your service \"Implement angular project service\" was delivered\nAmmount: 234 €','/user/ordered-package/20',1,'2017-12-18 17:00:05','2018-02-22 06:32:26'),(154,42,'The package  was asked revision','The package of your service \"Implement angular project service\" was asked revision\nAmmount: 234 €','/user/sold-package/20',1,'2017-12-18 17:00:51','2018-02-22 06:33:19'),(155,43,'The package  was delivered','The package of your service \"Implement angular project service\" was delivered\nAmmount: 234 €','/user/ordered-package/20',1,'2017-12-18 17:01:31','2018-02-22 06:32:26'),(156,42,'The package  was approved','The package of your service \"Implement angular project service\" was approved\nAmmount: 234 €','/user/sold-package/20',1,'2017-12-18 17:01:48','2018-02-22 06:33:19'),(157,49,'New package  was ordered','New package of your service \"I\'ll scrap a website\" was ordered\nAmmount: 150 €','/user/sold-package/21',1,'2017-12-18 20:30:02','2018-03-05 15:44:04'),(158,53,'The package  was delivered','The package of your service \"I\'ll scrap a website\" was delivered\nAmmount: 150 €','/user/ordered-package/21',1,'2017-12-18 20:30:41','2018-03-22 06:45:52'),(159,49,'The package  was asked revision','The package of your service \"I\'ll scrap a website\" was asked revision\nAmmount: 150 €','/user/sold-package/21',1,'2017-12-18 20:31:13','2018-03-05 15:44:04'),(160,53,'The package  was delivered','The package of your service \"I\'ll scrap a website\" was delivered\nAmmount: 150 €','/user/ordered-package/21',1,'2017-12-18 20:31:31','2018-03-22 06:45:52'),(161,49,'The package  was approved','The package of your service \"I\'ll scrap a website\" was approved\nAmmount: 150 €','/user/sold-package/21',1,'2017-12-18 20:31:47','2018-03-05 15:44:04'),(162,42,'New package  was ordered','New package of your service \"Implement angular project service\" was ordered\nAmmount: 1000 €','/user/sold-package/22',1,'2017-12-19 04:59:04','2018-02-22 06:33:19'),(163,43,'The package  was delivered','The package of your service \"Implement angular project service\" was delivered\nAmmount: 1000 €','/user/ordered-package/22',1,'2017-12-19 04:59:33','2018-02-22 06:32:26'),(164,42,'The package  was approved','The package of your service \"Implement angular project service\" was approved\nAmmount: 1000 €','/user/sold-package/22',1,'2017-12-19 04:59:47','2018-02-22 06:33:19'),(165,42,'New package  was ordered','New package of your service \"Implement angular project service\" was ordered\nAmmount: 1000 €','/user/sold-package/23',1,'2017-12-19 05:02:02','2018-02-22 06:33:19'),(166,43,'The package  was delivered','The package of your service \"Implement angular project service\" was delivered\nAmmount: 1000 €','/user/ordered-package/23',1,'2017-12-19 05:02:20','2018-02-22 06:32:26'),(167,42,'The package  was approved','The package of your service \"Implement angular project service\" was approved\nAmmount: 1000 €','/user/sold-package/23',1,'2017-12-19 05:02:47','2018-02-22 06:33:19'),(168,42,'New package  was ordered','New package of your service \"Implement angular project service\" was ordered\nAmmount: 234 €','/user/sold-package/24',1,'2017-12-19 05:12:12','2018-02-22 06:33:19'),(169,43,'The package  was delivered','The package of your service \"Implement angular project service\" was delivered\nAmmount: 234 €','/user/ordered-package/24',1,'2017-12-19 05:13:43','2018-02-22 06:32:26'),(170,42,'The package  was approved','The package of your service \"Implement angular project service\" was approved\nAmmount: 234 €','/user/sold-package/24',1,'2017-12-19 05:15:03','2018-02-22 06:33:19'),(171,49,'New package  was ordered','New package of your service \"I\'ll scrap a website\" was ordered\nAmmount: 150 €','/user/sold-package/25',1,'2017-12-19 06:04:22','2018-03-05 15:44:04'),(172,53,'The package  was delivered','The package of your service \"I\'ll scrap a website\" was delivered\nAmmount: 150 €','/user/ordered-package/25',1,'2017-12-19 06:05:12','2018-03-22 06:45:52'),(173,49,'The package  was approved','The package of your service \"I\'ll scrap a website\" was approved\nAmmount: 150 €','/user/sold-package/25',1,'2017-12-19 06:05:32','2018-03-05 15:44:04'),(174,42,'New package  was ordered','New package of your service \"Implement angular project user1\" was ordered\nAmmount: 100 €','/user/sold-package/26',1,'2017-12-19 10:37:33','2018-02-22 06:33:19'),(175,43,'The package  was delivered','The package of your service \"Implement angular project user1\" was delivered\nAmmount: 100 €','/user/ordered-package/26',1,'2017-12-19 10:38:05','2018-02-22 06:32:26'),(177,49,'New package  was ordered','New package of your service \"I\'ll scrap a website\" was ordered\nAmmount: 100 €','/user/sold-package/27',1,'2017-12-19 19:00:35','2018-03-05 15:44:04'),(178,53,'The package  was delivered','The package of your service \"I\'ll scrap a website\" was delivered\nAmmount: 100 €','/user/ordered-package/27',1,'2017-12-19 19:01:06','2018-03-22 06:45:52'),(179,49,'The package  was approved','The package of your service \"I\'ll scrap a website\" was approved\nAmmount: 100 €','/user/sold-package/27',1,'2017-12-19 19:01:29','2018-03-05 15:44:04'),(180,53,'New Contact to your startup','One Who:\nHi i like your start-up','/startups/start-up-xyz-469',1,'2017-12-21 20:00:22','2018-03-22 06:45:52'),(181,49,'New message from Niel York','Hello','/user/messages/startup-thread/27',1,'2017-12-21 20:01:27','2018-03-05 15:44:04'),(182,53,'New project','Your project has been successfully created','/projects/29',1,'2017-12-21 20:06:12','2018-03-22 06:45:52'),(183,53,'New proposal to your project','User One Who has made proposal to your project.\nOffer: 500 €','/user/messages/thread/21',1,'2017-12-21 20:06:46','2018-03-22 06:45:52'),(184,49,'Your proposal was accepted','User Niel York has accepted your proposal.\nOffer: 500 €','/projects/abc-project-406',1,'2017-12-21 20:07:07','2018-03-05 15:44:04'),(185,49,'New milestone \"XXXXX\" was funded','New milestone XXXXX was funded\nAmmount: 10000 €','/projects/milestone/management/23',1,'2017-12-21 21:06:09','2018-03-05 15:44:04'),(186,49,'New package  was ordered','New package of your service \"I\'ll scrap a website\" was ordered\nAmmount: 200 €','/user/sold-package/28',1,'2017-12-26 19:59:09','2018-03-05 15:44:04'),(187,53,'The package  was delivered','The package of your service \"I\'ll scrap a website\" was delivered\nAmmount: 200 €','/user/ordered-package/28',1,'2017-12-26 20:00:23','2018-03-22 06:45:52'),(188,53,'The milestone \"XXXXX\" was accepted','The milestone XXXXX was accepted\nAmmount: 10000 €','/projects/milestone/owner/management/23',1,'2017-12-26 20:01:24','2018-03-22 06:45:52'),(189,53,'The milestone \"XXXXX\" was delivery','The milestone XXXXX was delivery\nAmmount: 10000 €','/projects/milestone/owner/management/23',1,'2017-12-26 20:01:35','2018-03-22 06:45:52'),(190,43,'New package  was ordered','New package of your service \"The service 2\" was ordered\nAmmount: 1000 €','/user/sold-package/29',1,'2017-12-31 01:37:13','2018-02-22 06:32:26'),(191,42,'The package  was delivered','The package of your service \"The service 2\" was delivered\nAmmount: 1000 €','/user/ordered-package/29',1,'2017-12-31 01:38:17','2018-02-22 06:33:19'),(192,43,'The package  was approved','The package of your service \"The service 2\" was approved\nAmmount: 1000 €','/user/sold-package/29',1,'2017-12-31 01:38:47','2018-02-22 06:32:26'),(193,43,'New package  was ordered','New package of your service \"The service 2\" was ordered\nAmmount: 1000 €','/user/sold-package/30',1,'2018-01-05 17:27:43','2018-02-22 06:32:26'),(194,43,'You have got new message','mr user1: hello user 2\n','/user/ordered-contact/30',1,'2018-01-05 17:28:34','2018-02-22 06:32:26'),(195,42,'You have got new message','ms user2: hello user 1\n','/user/ordered-contact/30',1,'2018-01-05 17:29:10','2018-02-22 06:33:19'),(196,43,'You have got new message','mr user1: doc\n','/user/ordered-contact/30',1,'2018-01-05 17:29:33','2018-02-22 06:32:26'),(198,53,'New Contact to your startup','One Who:\nhello?','/startups/start-up-xyz-469',1,'2018-01-05 21:32:35','2018-03-22 06:45:52'),(199,49,'New message from Niel York','hi ? (second message)','/user/messages/startup-thread/29',1,'2018-01-05 21:34:18','2018-03-05 15:44:04'),(200,49,'New package  was ordered','New package of your service \"I\'ll scrap a website\" was ordered\nAmmount: 150 €','/user/sold-package/31',1,'2018-01-05 21:36:32','2018-03-05 15:44:04'),(201,53,'You have got new message','One Who: hello\n','/user/ordered-contact/31',1,'2018-01-05 21:37:07','2018-03-22 06:45:52'),(202,49,'You have got new message','Niel York: hi\n','/user/ordered-contact/31',1,'2018-01-05 21:39:39','2018-03-05 15:44:04'),(203,53,'You have got new message','One Who: hiii\n','/user/ordered-contact/31',1,'2018-01-05 21:40:12','2018-03-22 06:45:52'),(204,53,'New Contact to your startup','mr user1:\nHello','/startups/start-up-xyz-469',1,'2018-01-08 17:11:14','2018-03-22 06:45:52'),(205,53,'You have got new message','One Who: testoo\n','/user/ordered-contact/31',1,'2018-01-08 17:38:48','2018-03-22 06:45:52'),(206,49,'You have got new message','Niel York: oh\n','/user/ordered-contact/28',1,'2018-01-08 17:40:35','2018-03-05 15:44:04'),(208,53,'New Contact to your startup','One Who:\ntest1','/startups/start-up-xyz-469',1,'2018-01-08 17:44:46','2018-03-22 06:45:52'),(209,49,'New message from Niel York','ttt','/user/messages/startup-thread/32',1,'2018-01-08 17:51:48','2018-03-05 15:44:04'),(210,49,'The milestone \"XXXXX\" was approved','The milestone XXXXX was approved\nAmmount: 10000 €','/projects/milestone/management/23',1,'2018-01-08 17:55:35','2018-03-05 15:44:04'),(211,49,'New message from mr user1','Hello','/user/messages/startup-thread/31',1,'2018-01-09 00:21:18','2018-03-05 15:44:04'),(212,53,'New Contact to your startup','Khaled Shehata:\nhi','/startups/start-up-xyz-469',1,'2018-01-11 17:24:52','2018-03-22 06:45:52'),(213,20,'New message from Niel York','hu1','/user/messages/startup-thread/33',1,'2018-01-11 17:25:21','2018-01-11 17:26:29'),(214,20,'New message from Niel York','ho','/user/messages/startup-thread/33',1,'2018-01-11 17:25:36','2018-01-11 17:26:29'),(215,53,'New message from Khaled Shehata','xx','/user/messages/startup-thread/33',1,'2018-01-11 17:26:06','2018-03-22 06:45:52'),(216,55,'New start-up','Your start-up has been successfully created','/startups/project-for-ezio-458',1,'2018-01-19 10:35:37','2018-01-19 10:38:19'),(217,55,'New Contact to your startup','assassiner Ezio:\nI am very interesting your project .\nI will provide good project for you','/startups/project-for-ezio-458',1,'2018-01-19 10:36:50','2018-01-19 10:38:19'),(218,54,'New project','Your project has been successfully created','/projects/30',1,'2018-01-22 17:33:45','2018-03-20 18:36:17'),(219,54,'New project','Your project has been successfully created','/projects/31',1,'2018-01-22 22:14:26','2018-03-20 18:36:17'),(220,42,'New project','Your project has been successfully created','/projects/32',1,'2018-01-31 14:09:14','2018-02-22 06:33:19'),(221,42,'New start-up','Your start-up has been successfully created','/startups/start-up-with-icon-362',1,'2018-01-31 14:10:31','2018-02-22 06:33:19'),(222,42,'New start-up','Your start-up has been successfully created','/startups/test-with-icon-878',1,'2018-01-31 14:25:38','2018-02-22 06:33:19'),(223,42,'New Contact to your startup','ms user2:\nHello','/startups/test-with-icon-878',1,'2018-01-31 14:42:03','2018-02-22 06:33:19'),(225,42,'New Contact to your startup','Niel York:\nhello','/startups/test-with-icon-878',1,'2018-01-31 18:07:59','2018-02-22 06:33:19'),(227,53,'New project','Your project has been successfully created','/projects/34',1,'2018-02-02 11:14:35','2018-03-22 06:45:52'),(228,53,'New project','Your project has been successfully created','/projects/35',1,'2018-02-02 11:17:43','2018-03-22 06:45:52'),(229,53,'New proposal to your project','User One Who has made proposal to your project.\nOffer: 930 €','/user/messages/thread/22',1,'2018-02-02 11:30:15','2018-03-22 06:45:52'),(230,49,'Your proposal was accepted','User Niel York has accepted your proposal.\nOffer: 930 €','/projects/sss3-891',1,'2018-02-02 11:31:46','2018-03-05 15:44:04'),(231,49,'The package  was approved','The package of your service \"I\'ll scrap a website\" was approved\nAmmount: 200 €','/user/sold-package/28',1,'2018-02-02 16:58:32','2018-03-05 15:44:04'),(232,42,'New Contact to your startup','ms user2:\nhello','/startups/test-with-icon-878',1,'2018-02-03 02:46:55','2018-02-22 06:33:19'),(233,42,'New Contact to your startup','ms user2:\nok','/startups/test-with-icon-878',1,'2018-02-03 02:47:03','2018-02-22 06:33:19'),(234,42,'New Contact to your startup','ms user2:\nHello, I would like to apply','/startups/test-with-icon-878',1,'2018-02-03 02:49:39','2018-02-22 06:33:19'),(235,49,'New milestone \"ML1\" was funded','New milestone ML1 was funded\nAmmount: 100 €','/projects/milestone/management/24',1,'2018-02-03 09:47:36','2018-03-05 15:44:04'),(236,53,'The milestone \"ML1\" was accepted','The milestone ML1 was accepted\nAmmount: 100 €','/projects/milestone/owner/management/24',1,'2018-02-03 09:47:54','2018-03-22 06:45:52'),(237,53,'The milestone \"ML1\" was delivery','The milestone ML1 was delivery\nAmmount: 100 €','/projects/milestone/owner/management/24',1,'2018-02-03 09:48:21','2018-03-22 06:45:52'),(238,53,'New project','Your project has been successfully created','/projects/36',1,'2018-02-03 09:52:07','2018-03-22 06:45:52'),(239,53,'New proposal to your project','User One Who has made proposal to your project.\nOffer: 750 €','/user/messages/thread/23',1,'2018-02-03 09:52:36','2018-03-22 06:45:52'),(240,49,'Your proposal was accepted','User Niel York has accepted your proposal.\nOffer: 750 €','/projects/new-project-921',1,'2018-02-03 09:52:59','2018-03-05 15:44:04'),(241,49,'New milestone \"ML1\" was funded','New milestone ML1 was funded\nAmmount: 100 €','/projects/milestone/management/25',1,'2018-02-03 09:53:33','2018-03-05 15:44:04'),(242,53,'The milestone \"ML1\" was accepted','The milestone ML1 was accepted\nAmmount: 100 €','/projects/milestone/owner/management/25',1,'2018-02-03 09:53:52','2018-03-22 06:45:52'),(243,49,'New milestone \"M2\" was funded','New milestone M2 was funded\nAmmount: 100 €','/projects/milestone/management/25',1,'2018-02-03 09:55:58','2018-03-05 15:44:04'),(244,53,'The milestone \"M2\" was accepted','The milestone M2 was accepted\nAmmount: 100 €','/projects/milestone/owner/management/25',1,'2018-02-03 11:18:15','2018-03-22 06:45:52'),(245,49,'New milestone \"MIlestone 3\" was funded','New milestone MIlestone 3 was funded\nAmmount: 500 €','/projects/milestone/management/25',1,'2018-02-11 14:01:22','2018-03-05 15:44:04'),(246,53,'New proposal to your project','User One Who has made proposal to your project.\nOffer: 2000 €','/user/messages/thread/24',1,'2018-02-11 14:02:10','2018-03-22 06:45:52'),(247,42,'New start-up','Your start-up has been successfully created','/startups/the-startup-message-291',1,'2018-02-19 04:00:05','2018-02-22 06:33:19'),(248,42,'New start-up','Your start-up has been successfully created','/startups/the-startup-message-291',1,'2018-02-19 04:02:07','2018-02-22 06:33:19'),(249,42,'New Contact to your startup','ms user2:\nHello','/startups/the-startup-message-291',1,'2018-02-19 04:02:50','2018-02-22 06:33:19'),(250,43,'New message from mr user1','OK','/user/messages/startup-thread/41',1,'2018-02-19 04:03:15','2018-02-22 06:32:26'),(251,43,'New message from mr user1','How are you?','/user/messages/startup-thread/41',1,'2018-02-19 04:04:02','2018-02-22 06:32:26'),(252,42,'New package  was ordered','New package of your service \"Implement angular project user1\" was ordered\nAmmount: 100 €','/user/sold-package/32',1,'2018-02-19 04:20:17','2018-02-22 06:33:19'),(253,43,'The package  was delivered','The package of your service \"Implement angular project user1\" was delivered\nAmmount: 100 €','/user/ordered-package/32',1,'2018-02-19 04:21:34','2018-02-22 06:32:26'),(254,42,'The package  was approved','The package of your service \"Implement angular project user1\" was approved\nAmmount: 100 €','/user/sold-package/32',1,'2018-02-19 04:22:10','2018-02-22 06:33:19'),(255,53,'New package  was ordered','New package of your service \"T1\" was ordered\nAmmount: 1 €','/user/sold-package/33',1,'2018-02-19 04:25:06','2018-03-22 06:45:52'),(256,42,'New package  was ordered','New package of your service \"The demo 1\" was ordered\nAmmount: 123 €','/user/sold-package/34',1,'2018-02-19 04:25:32','2018-02-22 06:33:19'),(257,43,'New milestone \"test\" was funded','New milestone test was funded\nAmmount: 100 €','/projects/milestone/management/20',1,'2018-02-19 04:27:43','2018-02-22 06:32:26'),(258,43,'New milestone \"Test\" was funded','New milestone Test was funded\nAmmount: 100 €','/projects/milestone/management/20',1,'2018-02-19 04:28:21','2018-02-22 06:32:26'),(259,53,'New package  was ordered','New package of your service \"T1\" was ordered\nAmmount: 5 €','/user/sold-package/35',1,'2018-02-19 14:08:15','2018-03-22 06:45:52'),(260,53,'New package  was ordered','New package of your service \"T1\" was ordered\nAmmount: 5 €','/user/sold-package/36',1,'2018-02-19 14:09:22','2018-03-22 06:45:52'),(261,53,'You have got new message','One Who: hiiii\n','/user/ordered-contact/35',1,'2018-02-19 14:11:45','2018-03-22 06:45:52'),(262,53,'The milestone \"MIlestone 3\" was accepted','The milestone MIlestone 3 was accepted\nAmmount: 500 €','/projects/milestone/owner/management/25',1,'2018-02-19 14:15:00','2018-03-22 06:45:52'),(263,42,'New Contact to your startup','One Who:\nHi','/startups/test-with-icon-878',1,'2018-02-19 18:30:26','2018-02-22 06:33:19'),(264,42,'New Contact to your startup','One Who:\nhi','/startups/start-up-with-icon-362',1,'2018-02-20 12:16:32','2018-02-22 06:33:19'),(265,42,'New Contact to your startup','One Who:\nok','/startups/test-with-icon-878',1,'2018-02-20 12:18:04','2018-02-22 06:33:19'),(266,53,'You have got new message','One Who: hello file\n','/user/ordered-contact/35',1,'2018-02-21 19:12:14','2018-03-22 06:45:52'),(267,53,'The offer was updated','User One Who has updated the offer.\nNew Offer: 2000 €','/projects/test-project-499',1,'2018-02-21 19:13:08','2018-03-22 06:45:52'),(268,49,'Your proposal was accepted','User Niel York has accepted your proposal.\nOffer: 2000 €','/projects/test-project-499',1,'2018-02-21 19:13:33','2018-03-05 15:44:04'),(269,49,'Your proposal was accepted','User Niel York has accepted your proposal.\nOffer: 2000 €','/projects/test-project-499',1,'2018-02-21 19:13:33','2018-03-05 15:44:04'),(270,49,'New milestone \"ML1\" was funded','New milestone ML1 was funded\nAmmount: 200 €','/projects/milestone/management/26',1,'2018-02-21 19:16:28','2018-03-05 15:44:04'),(271,53,'The milestone \"ML1\" was accepted','The milestone ML1 was accepted\nAmmount: 200 €','/projects/milestone/owner/management/26',1,'2018-02-21 19:17:08','2018-03-22 06:45:52'),(272,53,'The milestone \"ML1\" was delivery','The milestone ML1 was delivery\nAmmount: 200 €','/projects/milestone/owner/management/26',1,'2018-02-21 19:17:26','2018-03-22 06:45:52'),(273,49,'The milestone \"ML1\" was asked revision.','The milestone ML1 was asked revision.\nAmmount: 200 €','/projects/milestone/management/26',1,'2018-02-21 19:19:40','2018-03-05 15:44:04'),(274,53,'The milestone \"ML1\" was delivery','The milestone ML1 was delivery\nAmmount: 200 €','/projects/milestone/owner/management/26',1,'2018-02-21 19:20:14','2018-03-22 06:45:52'),(275,53,'New package  was ordered','New package of your service \"T1\" was ordered\nAmmount: 1 €','/user/sold-package/37',1,'2018-02-22 04:18:25','2018-03-22 06:45:52'),(276,42,'New package  was ordered','New package of your service \"The demo 1\" was ordered\nAmmount: 123 €','/user/sold-package/38',1,'2018-02-22 04:21:25','2018-02-22 06:33:19'),(277,43,'New milestone \"Test milestone 777\" was funded','New milestone Test milestone 777 was funded\nAmmount: 100 €','/projects/milestone/management/20',1,'2018-02-22 06:31:59','2018-02-22 06:32:26'),(278,42,'The milestone \"Test milestone 777\" was accepted','The milestone Test milestone 777 was accepted\nAmmount: 100 €','/projects/milestone/owner/management/20',1,'2018-02-22 06:32:41','2018-02-22 06:33:19'),(279,42,'The milestone \"Test milestone 777\" was delivery','The milestone Test milestone 777 was delivery\nAmmount: 100 €','/projects/milestone/owner/management/20',1,'2018-02-22 06:33:11','2018-02-22 06:33:19'),(280,53,'New start-up','Your start-up has been successfully created','/startups/benchmark-cold-wallet-hardware-security-elements-crypto-currencies-947',1,'2018-02-27 21:01:25','2018-03-22 06:45:52'),(281,53,'New member has joined your team',' accepted to join your team.','/startups/benchmark-cold-wallet-hardware-security-elements-crypto-currencies-947',1,'2018-02-27 21:02:37','2018-03-22 06:45:52'),(282,56,'New start-up','Your start-up has been successfully created','/startups/bunk-511',1,'2018-03-05 10:09:18','2018-03-14 21:51:46'),(283,56,'New project','Your project has been successfully created','/projects/37',1,'2018-03-05 10:30:08','2018-03-14 21:51:46'),(284,49,'New package  was ordered','New package of your service \"I\'ll scrap a website\" was ordered\nAmmount: 100 €','/user/sold-package/39',1,'2018-03-05 10:43:09','2018-03-05 15:44:04'),(285,56,'New proposal to your project','User Alejandro Abramson has made proposal to your project.\nOffer: 2000 €','/user/messages/thread/25',1,'2018-03-05 11:08:06','2018-03-14 21:51:46'),(286,58,'Your proposal was accepted','User Tom  Ripert has accepted your proposal.\nOffer: 2000 €','/projects/lorem-ipsum-327',1,'2018-03-05 11:08:48','2018-03-05 12:50:10'),(287,58,'New milestone \"M1\" was funded','New milestone M1 was funded\nAmmount: 500 €','/projects/milestone/management/27',1,'2018-03-05 11:59:38','2018-03-05 12:50:10'),(288,58,'New milestone \"M2\" was funded','New milestone M2 was funded\nAmmount: 500 €','/projects/milestone/management/27',1,'2018-03-05 12:02:03','2018-03-05 12:50:10'),(289,56,'You have got new message','One Who: hi\n','/user/ordered-contact/39',1,'2018-03-05 12:45:53','2018-03-14 21:51:46'),(290,49,'You have got new message','Tom  Ripert: Ola chico\n','/user/ordered-contact/39',1,'2018-03-05 12:47:00','2018-03-05 15:44:04'),(291,49,'You have got new message','Tom  Ripert: Je kiffe l\'email html, le logo il claque sur fond noir. Faut trouver la bonne combinaison pour le site\n','/user/ordered-contact/39',1,'2018-03-05 12:48:50','2018-03-05 15:44:04'),(292,56,'You have got new message','One Who: haha :)\n','/user/ordered-contact/39',1,'2018-03-05 12:52:29','2018-03-14 21:51:46'),(293,56,'You have got new message','One Who: La page des notifs marche, mais un peu cheum : http://52.32.112.212/user/notifications\n','/user/ordered-contact/39',1,'2018-03-05 13:17:50','2018-03-14 21:51:46'),(294,56,'You have got new message','One Who: Test attached file\n','/user/ordered-contact/39',1,'2018-03-05 13:18:07','2018-03-14 21:51:46'),(295,56,'New Contact to your startup','One Who:\nI want to join this fucking startup','/startups/bunk-511',1,'2018-03-05 13:29:14','2018-03-14 21:51:46'),(296,49,'New message from Tom  Ripert','We only hire fucking psychopaths mate','/user/messages/startup-thread/45',1,'2018-03-05 13:37:00','2018-03-05 15:44:04'),(297,56,'New message from One Who','haha :D','/user/messages/startup-thread/45',1,'2018-03-05 13:38:21','2018-03-14 21:51:46'),(298,49,'You have got new message','Tom  Ripert: That works\n','/user/ordered-contact/39',0,'2018-03-05 18:37:20','2018-03-05 18:37:20'),(301,56,'New Contact to your startup','One  Two:\nJe kiffe','/startups/bunk-511',1,'2018-03-07 15:42:19','2018-03-14 21:51:46'),(302,61,'New start-up','Your start-up has been successfully created','/startups/bob-819',1,'2018-03-07 15:48:09','2018-03-07 18:46:18'),(303,61,'New project','Your project has been successfully created','/projects/40',1,'2018-03-07 15:52:42','2018-03-07 18:46:18');
/*!40000 ALTER TABLE `notifications` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `package_categories`
--

DROP TABLE IF EXISTS `package_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `package_categories` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `parent_id` int(10) unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `package_categories`
--

LOCK TABLES `package_categories` WRITE;
/*!40000 ALTER TABLE `package_categories` DISABLE KEYS */;
/*!40000 ALTER TABLE `package_categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `package_deliveries`
--

DROP TABLE IF EXISTS `package_deliveries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `package_deliveries` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ordered_package_id` int(10) unsigned NOT NULL,
  `description` text COLLATE utf8_unicode_ci NOT NULL,
  `type` enum('new','revision') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'new',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=31 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `package_deliveries`
--

LOCK TABLES `package_deliveries` WRITE;
/*!40000 ALTER TABLE `package_deliveries` DISABLE KEYS */;
INSERT INTO `package_deliveries` VALUES (13,17,'The delivery','new','2017-12-17 11:02:01','2017-12-17 11:02:01'),(14,17,'Ok it is','new','2017-12-17 11:02:38','2017-12-17 11:02:38'),(15,18,'Hello i finished','new','2017-12-17 16:28:46','2017-12-17 16:28:46'),(16,19,'ok','new','2017-12-17 16:38:25','2017-12-17 16:38:25'),(17,19,'2','new','2017-12-17 16:39:29','2017-12-17 16:39:29'),(18,20,'I am done','new','2017-12-18 17:00:05','2017-12-18 17:00:05'),(19,20,'This is','new','2017-12-18 17:01:31','2017-12-18 17:01:31'),(20,21,'ok','new','2017-12-18 20:30:41','2017-12-18 20:30:41'),(21,21,'ok2','new','2017-12-18 20:31:31','2017-12-18 20:31:31'),(22,22,'Fine go','new','2017-12-19 04:59:33','2017-12-19 04:59:33'),(23,23,'Find thanks','new','2017-12-19 05:02:20','2017-12-19 05:02:20'),(24,24,'Ok fine','new','2017-12-19 05:13:43','2017-12-19 05:13:43'),(25,25,'ok','new','2017-12-19 06:05:12','2017-12-19 06:05:12'),(26,26,'delivery','new','2017-12-19 10:38:05','2017-12-19 10:38:05'),(27,27,'done man.','new','2017-12-19 19:01:06','2017-12-19 19:01:06'),(28,28,'done','new','2017-12-26 20:00:23','2017-12-26 20:00:23'),(29,29,'This is the delivery','new','2017-12-31 01:38:17','2017-12-31 01:38:17'),(30,32,'lokk','new','2018-02-19 04:21:34','2018-02-19 04:21:34');
/*!40000 ALTER TABLE `package_deliveries` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `package_delivery_documents`
--

DROP TABLE IF EXISTS `package_delivery_documents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `package_delivery_documents` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `filename` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `package_delivery_id` int(10) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `package_delivery_documents`
--

LOCK TABLES `package_delivery_documents` WRITE;
/*!40000 ALTER TABLE `package_delivery_documents` DISABLE KEYS */;
INSERT INTO `package_delivery_documents` VALUES (5,'package_delivery/1N09zuK9of.docx',13,'2017-12-17 11:02:01','2017-12-17 11:02:01'),(6,'package_delivery/yzlnuk8BfL.jpg',18,'2017-12-18 17:00:05','2017-12-18 17:00:05');
/*!40000 ALTER TABLE `package_delivery_documents` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `package_documents`
--

DROP TABLE IF EXISTS `package_documents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `package_documents` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `filename` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `package_id` int(10) unsigned NOT NULL,
  `package_order_id` int(10) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `package_documents`
--

LOCK TABLES `package_documents` WRITE;
/*!40000 ALTER TABLE `package_documents` DISABLE KEYS */;
/*!40000 ALTER TABLE `package_documents` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `package_feedback`
--

DROP TABLE IF EXISTS `package_feedback`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `package_feedback` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `seller_id` int(10) unsigned NOT NULL,
  `buyer_id` int(10) unsigned NOT NULL,
  `package_id` int(10) unsigned NOT NULL,
  `ordered_package_id` int(10) unsigned NOT NULL,
  `message` text COLLATE utf8_unicode_ci,
  `rating` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `communication` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `skill` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `deadline` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `experience` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ordered_package_id` (`ordered_package_id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `package_feedback`
--

LOCK TABLES `package_feedback` WRITE;
/*!40000 ALTER TABLE `package_feedback` DISABLE KEYS */;
INSERT INTO `package_feedback` VALUES (1,42,42,40,29,'cool thanks',5,0,0,0,0,'2017-12-31 01:39:05','2017-12-31 01:39:05'),(2,42,43,39,32,'',5,0,0,0,0,'2018-02-19 04:22:32','2018-02-19 04:22:32');
/*!40000 ALTER TABLE `package_feedback` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `package_orders`
--

DROP TABLE IF EXISTS `package_orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `package_orders` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `paying_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `package_id` int(10) unsigned NOT NULL,
  `instruction` text COLLATE utf8_unicode_ci,
  `buyer_id` int(10) unsigned NOT NULL,
  `status` enum('waiting','approved','new') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'new',
  `asked_revisions` smallint(5) unsigned NOT NULL DEFAULT '0',
  `seller_id` int(10) unsigned NOT NULL,
  `supplier_inv_id` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `owner_inv_id` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `inv_created_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=40 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `package_orders`
--

LOCK TABLES `package_orders` WRITE;
/*!40000 ALTER TABLE `package_orders` DISABLE KEYS */;
INSERT INTO `package_orders` VALUES (17,'2017-12-17 11:02:47',31,'The instruction',43,'approved',1,42,NULL,NULL,NULL,'2017-12-17 11:00:18','2017-12-17 11:02:47'),(18,'2017-12-17 16:28:46',33,'The website to scrap is : 12345.com.\n',20,'waiting',0,49,NULL,NULL,NULL,'2017-12-17 16:24:54','2017-12-17 16:28:46'),(19,'2017-12-17 16:39:50',33,'hello ?',53,'approved',1,49,NULL,NULL,NULL,'2017-12-17 16:30:19','2017-12-17 16:39:50'),(20,'2017-12-18 17:01:48',31,'The instruction',43,'approved',1,42,'LXCUP72043-18122017','LXCUP72042-18122017','2017-12-18 17:01:48','2017-12-18 16:58:42','2017-12-18 17:01:48'),(21,'2017-12-18 20:31:47',34,'hello',53,'approved',1,49,'SZQE6O2153-18122017','SZQE6O2149-18122017','2017-12-18 20:31:47','2017-12-18 20:30:01','2017-12-18 20:31:47'),(22,'2017-12-19 04:59:47',32,'Ok let\'s go',43,'approved',0,42,'PLE5OY2243-19122017','PLE5OY2242-19122017','2017-12-19 04:59:47','2017-12-19 04:59:03','2017-12-19 04:59:47'),(23,'2017-12-19 05:02:47',32,'AAAA',43,'approved',0,42,'NX3OWG2343-19122017','NX3OWG2342-19122017','2017-12-19 05:02:47','2017-12-19 05:02:02','2017-12-19 05:02:47'),(24,'2017-12-19 05:15:03',31,'Okk',43,'approved',0,42,'1NW9LW2443-19122017','1NW9LW2442-19122017','2017-12-19 05:15:03','2017-12-19 05:12:11','2017-12-19 05:15:03'),(25,'2017-12-19 06:05:32',34,'Hello',53,'approved',0,49,'LEH8WL2553-19122017','LEH8WL2549-19122017','2017-12-19 06:05:32','2017-12-19 06:04:21','2017-12-19 06:05:32'),(26,'2017-12-19 10:38:29',39,'ffff',43,'approved',0,42,'3UZ86Z2643-19122017','3UZ86Z2642-19122017','2017-12-19 10:38:29','2017-12-19 10:37:32','2017-12-19 10:38:29'),(27,'2017-12-19 19:01:29',33,'instructions',53,'approved',0,49,'NCYNLI2753-19122017','NCYNLI2749-19122017','2017-12-19 19:01:29','2017-12-19 19:00:35','2017-12-19 19:01:29'),(28,'2018-02-02 16:58:32',35,'hiiiiiii',53,'approved',0,49,'BSWNLX2853-02022018','BSWNLX2849-02022018','2018-02-02 16:58:32','2017-12-26 19:59:08','2018-02-02 16:58:32'),(29,'2017-12-31 01:38:47',40,'Ok fine',42,'approved',0,43,'A8E1GR2942-31122017','A8E1GR2943-31122017','2017-12-31 01:38:47','2017-12-31 01:37:12','2017-12-31 01:38:47'),(30,'2018-01-05 17:28:14',40,'Ok ok',42,'new',0,43,NULL,NULL,NULL,'2018-01-05 17:27:42','2018-01-05 17:28:14'),(31,'2018-01-05 21:36:37',34,'hello',53,'new',0,49,NULL,NULL,NULL,'2018-01-05 21:36:31','2018-01-05 21:36:37'),(32,'2018-02-19 04:22:10',39,'OK',43,'approved',0,42,'D9LLMA3243-19022018','D9LLMA3242-19022018','2018-02-19 04:22:10','2018-02-19 04:20:17','2018-02-19 04:22:10'),(33,'2018-02-19 04:25:12',48,'ggg',43,'new',0,53,NULL,NULL,NULL,'2018-02-19 04:25:05','2018-02-19 04:25:12'),(34,'2018-02-19 04:25:40',43,'ok',43,'new',0,42,NULL,NULL,NULL,'2018-02-19 04:25:31','2018-02-19 04:25:40'),(35,'2018-02-19 14:08:26',47,'Blabla!',49,'new',0,53,NULL,NULL,NULL,'2018-02-19 14:08:14','2018-02-19 14:08:26'),(36,'2018-02-19 14:09:29',47,'Blabla2',49,'new',0,53,NULL,NULL,NULL,'2018-02-19 14:09:21','2018-02-19 14:09:29'),(37,'2018-02-22 04:18:30',48,'test',42,'new',0,53,NULL,NULL,NULL,'2018-02-22 04:18:24','2018-02-22 04:18:30'),(38,'2018-02-22 04:21:31',43,'test',43,'new',0,42,NULL,NULL,NULL,'2018-02-22 04:21:24','2018-02-22 04:21:31'),(39,'2018-03-05 10:45:17',33,'Lorem ipsum',56,'new',0,49,NULL,NULL,NULL,'2018-03-05 10:43:08','2018-03-05 10:45:17');
/*!40000 ALTER TABLE `package_orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `package_revision_documents`
--

DROP TABLE IF EXISTS `package_revision_documents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `package_revision_documents` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `filename` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `package_revision_id` int(10) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `package_revision_documents`
--

LOCK TABLES `package_revision_documents` WRITE;
/*!40000 ALTER TABLE `package_revision_documents` DISABLE KEYS */;
/*!40000 ALTER TABLE `package_revision_documents` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `package_revisions`
--

DROP TABLE IF EXISTS `package_revisions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `package_revisions` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ordered_package_id` int(10) unsigned NOT NULL,
  `description` text COLLATE utf8_unicode_ci NOT NULL,
  `status` enum('new','delivered') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'new',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `package_revisions`
--

LOCK TABLES `package_revisions` WRITE;
/*!40000 ALTER TABLE `package_revisions` DISABLE KEYS */;
INSERT INTO `package_revisions` VALUES (4,17,'Please provide the revision','delivered','2017-12-17 11:02:24','2017-12-17 11:02:38'),(5,19,'undo please, try again','delivered','2017-12-17 16:38:59','2017-12-17 16:39:29'),(6,20,'Please do something','delivered','2017-12-18 17:00:51','2017-12-18 17:01:31'),(7,21,'ok','delivered','2017-12-18 20:31:13','2017-12-18 20:31:31');
/*!40000 ALTER TABLE `package_revisions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `packages`
--

DROP TABLE IF EXISTS `packages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `packages` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `service_id` int(10) unsigned NOT NULL,
  `author_id` int(10) unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `description` text COLLATE utf8_unicode_ci NOT NULL,
  `price` int(10) unsigned NOT NULL,
  `days_to_deliver` smallint(5) unsigned NOT NULL,
  `number_devisions` smallint(5) unsigned NOT NULL,
  `instruction` text COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=50 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `packages`
--

LOCK TABLES `packages` WRITE;
/*!40000 ALTER TABLE `packages` DISABLE KEYS */;
INSERT INTO `packages` VALUES (31,16,42,'Basic','The option 1',234,5,2,'aaa','2017-12-17 10:57:08','2017-12-17 10:57:08'),(32,16,42,'Advance','The option 2',1000,5,20,'nnbb','2017-12-17 10:57:08','2017-12-17 10:57:08'),(33,17,49,'Basic','1000 lines scrapped',100,2,2,'Please give the URL, pages that has to be scrapped.','2017-12-17 16:22:34','2017-12-17 16:22:34'),(34,17,49,'Advanced','10 000 lines scrapped',150,2,2,'Please give the URL, pages that has to be scrapped.','2017-12-17 16:22:34','2017-12-17 16:22:34'),(35,17,49,'Premium','Unlimited\n3 sources of websites',200,3,5,'Please give the URL, pages that has to be scrapped.','2017-12-17 16:22:34','2017-12-17 16:22:34'),(45,18,53,'Basic','aaaa',100,1,1,'bbbb','2018-02-02 11:01:33','2018-02-02 11:01:33'),(39,19,42,'basic','simple',100,5,2,'ssss','2017-12-19 10:36:25','2017-12-19 10:36:25'),(40,20,43,'basic','basic',1000,5,2,'kkll','2017-12-19 10:59:29','2017-12-19 10:59:29'),(43,21,42,'basic','ss',123,2,2,'ss','2018-01-05 17:27:00','2018-01-05 17:27:00'),(47,22,53,'O1','O1',5,1,1,'INS1','2018-02-02 11:03:06','2018-02-02 11:03:06'),(46,18,53,'aaa','aaaa',10,1,1,'1','2018-02-02 11:01:33','2018-02-02 11:01:33'),(48,22,53,'O2','AA',1,1,1,'1','2018-02-02 11:03:06','2018-02-02 11:03:06'),(49,23,58,'Lorem ipsum','Lorem ipsum',10000,10,1,'Lorem ipsum','2018-03-05 10:56:35','2018-03-05 10:56:35');
/*!40000 ALTER TABLE `packages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `password_resets`
--

DROP TABLE IF EXISTS `password_resets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `password_resets` (
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  KEY `password_resets_email_index` (`email`),
  KEY `password_resets_token_index` (`token`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `password_resets`
--

LOCK TABLES `password_resets` WRITE;
/*!40000 ALTER TABLE `password_resets` DISABLE KEYS */;
/*!40000 ALTER TABLE `password_resets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `portfolios`
--

DROP TABLE IF EXISTS `portfolios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `portfolios` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(250) NOT NULL,
  `item_path` varchar(500) NOT NULL,
  `description` text NOT NULL,
  `user_id` int(10) unsigned NOT NULL,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `fk_portfolio_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `portfolios`
--

LOCK TABLES `portfolios` WRITE;
/*!40000 ALTER TABLE `portfolios` DISABLE KEYS */;
INSERT INTO `portfolios` VALUES (2,'Portfolio 1','http://52.32.112.212/storage/portfolio/X1wzVTTXMq.jpg','Portfolio 1',43,'2017-11-12 05:53:59','2017-11-12 05:53:59'),(3,'Project 1','http://52.32.112.212/storage/portfolio/rMBQ5fu6S1.png','Test',20,'2017-11-12 08:43:34','2017-11-12 08:43:34'),(5,'Project 1','http://52.32.112.212/storage/portfolio/GKUwGk2OUW.png','App',52,'2017-11-12 08:46:22','2017-11-12 08:46:22'),(6,'I did this App','http://52.32.112.212/storage/portfolio/ecET9vbmgD.png','iPhone App ',49,'2017-11-13 20:30:33','2017-11-13 20:30:33');
/*!40000 ALTER TABLE `portfolios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `project_histories`
--

DROP TABLE IF EXISTS `project_histories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `project_histories` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `author_id` int(10) unsigned NOT NULL,
  `proposal_id` int(10) unsigned NOT NULL,
  `description` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `action` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=131 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `project_histories`
--

LOCK TABLES `project_histories` WRITE;
/*!40000 ALTER TABLE `project_histories` DISABLE KEYS */;
INSERT INTO `project_histories` VALUES (24,43,20,'user2 offered 2000€',NULL,'2017-10-10 17:08:20','2017-10-10 17:08:20'),(25,42,20,'user2 offered 2000€ (accepted by user1)',NULL,'2017-10-10 17:09:08','2017-10-10 17:09:08'),(26,49,21,'onewho offered 2500€',NULL,'2017-10-11 09:52:34','2017-10-11 09:52:34'),(27,20,21,'onewho offered 2500€ (accepted by khaleds)',NULL,'2017-10-11 09:52:56','2017-10-11 09:52:56'),(28,20,21,'Milestone \"Front end devs\" funded on 11/10/2017(50€) - waiting for acceptation',NULL,'2017-10-11 10:05:37','2017-10-11 10:05:37'),(29,49,21,'Milestone \"Front end devs\" was accepted by onewho',NULL,'2017-10-11 10:06:30','2017-10-11 10:06:30'),(30,49,21,'Milestone \"Front end devs\" was submitted by onewho(50€)',NULL,'2017-10-11 10:10:11','2017-10-11 10:10:11'),(31,20,21,'Milestone  \"Front end devs\" was approved by khaleds(50€)',NULL,'2017-10-11 10:11:00','2017-10-11 10:11:00'),(32,20,21,'Milestone \"aaaa\" funded on 11/10/2017(10€) - waiting for acceptation',NULL,'2017-10-11 10:45:33','2017-10-11 10:45:33'),(33,49,21,'Milestone \"aaaa\" was accepted by onewho',NULL,'2017-10-11 10:55:57','2017-10-11 10:55:57'),(34,49,21,'Milestone \"aaaa\" was submitted by onewho(10€)',NULL,'2017-10-11 11:16:34','2017-10-11 11:16:34'),(35,20,21,'Revision asked on for milestone \"aaaa\" was asked on 11/10/2017',NULL,'2017-10-11 11:17:06','2017-10-11 11:17:06'),(36,49,21,'Milestone \"aaaa\" was submitted by onewho(10€)',NULL,'2017-10-11 11:18:30','2017-10-11 11:18:30'),(37,20,21,'Milestone  \"aaaa\" was approved by khaleds(10€)',NULL,'2017-10-11 11:18:49','2017-10-11 11:18:49'),(38,42,20,'Milestone \"This is the title 1\" funded on 11/10/2017(500€) - waiting for acceptation',NULL,'2017-10-11 14:51:14','2017-10-11 14:51:14'),(39,43,20,'Milestone \"This is the title 1\" was accepted by user2',NULL,'2017-10-11 14:52:38','2017-10-11 14:52:38'),(40,43,20,'Milestone \"This is the title 1\" was submitted by user2(500€)',NULL,'2017-10-11 14:53:17','2017-10-11 14:53:17'),(41,42,20,'Revision asked on for milestone \"This is the title 1\" was asked on 11/10/2017',NULL,'2017-10-11 14:55:36','2017-10-11 14:55:36'),(42,43,20,'Milestone \"This is the title 1\" was submitted by user2(500€)',NULL,'2017-10-11 14:56:39','2017-10-11 14:56:39'),(43,42,20,'Milestone  \"This is the title 1\" was approved by user1(500€)',NULL,'2017-10-11 14:56:55','2017-10-11 14:56:55'),(44,42,20,'Milestone \"Milestone 2\" funded on 11/10/2017(200€) - waiting for acceptation',NULL,'2017-10-11 14:58:36','2017-10-11 14:58:36'),(45,42,20,'Milestone \"Milestone 3\" funded on 11/10/2017(300€) - waiting for acceptation',NULL,'2017-10-11 15:02:47','2017-10-11 15:02:47'),(46,43,20,'Milestone \"Milestone 3\" was accepted by user2',NULL,'2017-10-11 15:03:28','2017-10-11 15:03:28'),(47,43,20,'Milestone \"Milestone 3\" was submitted by user2(300€)',NULL,'2017-10-11 15:03:41','2017-10-11 15:03:41'),(48,42,20,'Milestone  \"Milestone 3\" was approved by user1(300€)',NULL,'2017-10-11 15:04:18','2017-10-11 15:04:18'),(49,20,21,'Milestone \"ML3\" funded on 11/10/2017(100€) - waiting for acceptation',NULL,'2017-10-11 19:12:14','2017-10-11 19:12:14'),(50,49,21,'Milestone \"ML3\" was accepted by onewho',NULL,'2017-10-11 19:14:56','2017-10-11 19:14:56'),(51,20,21,'Milestone \"Test milestone 3\" funded on 12/10/2017(100€) - waiting for acceptation',NULL,'2017-10-12 10:16:47','2017-10-12 10:16:47'),(52,20,21,'Milestone \"ML4\" funded on 12/10/2017(10€) - waiting for acceptation',NULL,'2017-10-12 10:17:56','2017-10-12 10:17:56'),(53,49,21,'Milestone \"ML3\" was submitted by onewho(100€)',NULL,'2017-10-12 10:20:27','2017-10-12 10:20:27'),(54,20,21,'Revision asked on for milestone \"ML3\" was asked on 12/10/2017',NULL,'2017-10-12 10:21:01','2017-10-12 10:21:01'),(55,49,21,'Milestone \"ML3\" was submitted by onewho(100€)',NULL,'2017-10-12 10:21:31','2017-10-12 10:21:31'),(56,20,21,'Milestone  \"ML3\" was approved by khaleds(100€)',NULL,'2017-10-12 10:21:55','2017-10-12 10:21:55'),(57,42,20,'Milestone \"The milestone 4\" was created on 15/10/2017',NULL,'2017-10-15 06:54:07','2017-10-15 06:54:07'),(58,42,20,'Milestone \"The milestone 4\" funded on 15/10/2017(500) - waiting for acceptation',NULL,'2017-10-15 06:57:04','2017-10-15 06:57:04'),(59,42,20,'Milestone \"This is the title 6\" funded on 15/10/2017(200) - waiting for acceptation',NULL,'2017-10-15 06:59:38','2017-10-15 06:59:38'),(60,42,20,'Milestone \"This is the title 7\" was created on 15/10/2017',NULL,'2017-10-15 07:01:12','2017-10-15 07:01:12'),(61,43,20,'Milestone \"This is the title 6\" was accepted by user2',NULL,'2017-10-15 07:01:29','2017-10-15 07:01:29'),(62,43,20,'Milestone \"This is the title 6\" was submitted by user2(200)',NULL,'2017-10-15 07:02:11','2017-10-15 07:02:11'),(63,42,20,'Milestone  \"This is the title 6\" was approved by user1(200)',NULL,'2017-10-15 07:05:17','2017-10-15 07:05:17'),(64,20,21,'Milestone \"M6\" was created on 15/10/2017',NULL,'2017-10-15 09:03:22','2017-10-15 09:03:22'),(65,20,21,'Milestone \"M6\" funded on 15/10/2017(50) - waiting for acceptation',NULL,'2017-10-15 09:03:33','2017-10-15 09:03:33'),(66,20,21,'Milestone \"sdssd\" funded on 06/11/2017(1000) - waiting for acceptation',NULL,'2017-11-06 17:21:21','2017-11-06 17:21:21'),(67,20,17,'user1 offered 100€ (accepted by khaleds)',NULL,'2017-11-11 18:02:33','2017-11-11 18:02:33'),(68,20,17,'Milestone \"M1\" funded on 11/11/2017(1000€) - waiting for acceptation',NULL,'2017-11-11 18:03:17','2017-11-11 18:03:17'),(69,42,20,'Milestone \"This is the title 7\" funded on 12/11/2017(1000€) - waiting for acceptation',NULL,'2017-11-12 02:54:41','2017-11-12 02:54:41'),(70,43,20,'Milestone \"This is the title 7\" was accepted by user2',NULL,'2017-11-12 02:57:11','2017-11-12 02:57:11'),(71,43,20,'Milestone \"This is the title 7\" was submitted by user2(1000€)',NULL,'2017-11-12 02:57:58','2017-11-12 02:57:58'),(72,42,20,'Milestone  \"This is the title 7\" was approved by user1(1000€)',NULL,'2017-11-12 03:00:41','2017-11-12 03:00:41'),(73,42,20,'Milestone \"The milestone 4\" funded on 12/11/2017(1000€) - waiting for acceptation',NULL,'2017-11-12 04:15:35','2017-11-12 04:15:35'),(74,49,22,'onewho offered 1150€',NULL,'2017-11-12 09:03:21','2017-11-12 09:03:21'),(75,20,22,'onewho offered 1150€ (accepted by khaleds)',NULL,'2017-11-12 09:05:15','2017-11-12 09:05:15'),(76,20,22,'Milestone \"Do that in ML1 \" funded on 12/11/2017(500€) - waiting for acceptation',NULL,'2017-11-12 09:06:01','2017-11-12 09:06:01'),(77,49,22,'Milestone \"Do that in ML1 \" was accepted by onewho',NULL,'2017-11-12 09:06:20','2017-11-12 09:06:20'),(78,49,22,'Milestone \"Do that in ML1 \" was submitted by onewho(500€)',NULL,'2017-11-12 09:06:38','2017-11-12 09:06:38'),(79,20,22,'Milestone  \"Do that in ML1 \" was approved by khaleds(500€)',NULL,'2017-11-12 09:07:23','2017-11-12 09:07:23'),(80,20,22,'Milestone \"Do that please now !!\" funded on 13/11/2017(1000€) - waiting for acceptation',NULL,'2017-11-13 20:19:46','2017-11-13 20:19:46'),(81,49,22,'Milestone \"Do that please now !!\" was accepted by onewho',NULL,'2017-11-13 20:20:10','2017-11-13 20:20:10'),(82,49,22,'Milestone \"Do that please now !!\" was submitted by onewho(1000€)',NULL,'2017-11-13 20:22:09','2017-11-13 20:22:09'),(83,20,22,'Revision asked on for milestone \"Do that please now !!\" was asked on 13/11/2017',NULL,'2017-11-13 20:23:10','2017-11-13 20:23:10'),(84,49,22,'Milestone \"Do that please now !!\" was submitted by onewho(1000€)',NULL,'2017-11-13 20:24:12','2017-11-13 20:24:12'),(85,20,22,'Milestone  \"Do that please now !!\" was approved by khaleds(1000€)',NULL,'2017-11-13 20:25:17','2017-11-13 20:25:17'),(86,49,21,'Milestone \"sdssd\" was accepted by onewho',NULL,'2017-12-01 17:09:00','2017-12-01 17:09:00'),(87,49,21,'Milestone \"M6\" was accepted by onewho',NULL,'2017-12-01 17:09:04','2017-12-01 17:09:04'),(88,49,23,'onewho offered 500€',NULL,'2017-12-21 20:06:46','2017-12-21 20:06:46'),(89,53,23,'onewho offered 500€ (accepted by nielyork)',NULL,'2017-12-21 20:07:07','2017-12-21 20:07:07'),(90,53,23,'Milestone \"XXXXX\" funded on 21/12/2017(10000€) - waiting for acceptation',NULL,'2017-12-21 21:06:09','2017-12-21 21:06:09'),(91,49,23,'Milestone \"XXXXX\" was accepted by onewho',NULL,'2017-12-26 20:01:24','2017-12-26 20:01:24'),(92,49,23,'Milestone \"XXXXX\" was submitted by onewho(10000€)',NULL,'2017-12-26 20:01:35','2017-12-26 20:01:35'),(93,53,23,'Milestone  \"XXXXX\" was approved by nielyork(10000€)',NULL,'2018-01-08 17:55:35','2018-01-08 17:55:35'),(94,53,23,'Milestone \"ML2\" was created on 02/02/2018',NULL,'2018-02-02 11:10:04','2018-02-02 11:10:04'),(95,49,24,'onewho offered 930€',NULL,'2018-02-02 11:30:15','2018-02-02 11:30:15'),(96,53,24,'onewho offered 930€ (accepted by nielyork)',NULL,'2018-02-02 11:31:46','2018-02-02 11:31:46'),(97,53,24,'Milestone \"ML1\" was created on 02/02/2018',NULL,'2018-02-02 11:33:51','2018-02-02 11:33:51'),(98,53,24,'Milestone \"ML1\" funded on 03/02/2018(100€) - waiting for acceptation',NULL,'2018-02-03 09:47:36','2018-02-03 09:47:36'),(99,49,24,'Milestone \"ML1\" was accepted by onewho',NULL,'2018-02-03 09:47:54','2018-02-03 09:47:54'),(100,49,24,'Milestone \"ML1\" was submitted by onewho(100€)',NULL,'2018-02-03 09:48:21','2018-02-03 09:48:21'),(101,49,25,'onewho offered 750€',NULL,'2018-02-03 09:52:36','2018-02-03 09:52:36'),(102,53,25,'onewho offered 750€ (accepted by nielyork)',NULL,'2018-02-03 09:52:59','2018-02-03 09:52:59'),(103,53,25,'Milestone \"ML1\" funded on 03/02/2018(100€) - waiting for acceptation',NULL,'2018-02-03 09:53:33','2018-02-03 09:53:33'),(104,49,25,'Milestone \"ML1\" was accepted by onewho',NULL,'2018-02-03 09:53:52','2018-02-03 09:53:52'),(105,53,25,'Milestone \"M2\" was created on 03/02/2018',NULL,'2018-02-03 09:54:33','2018-02-03 09:54:33'),(106,53,25,'Milestone \"M2\" funded on 03/02/2018(100€) - waiting for acceptation',NULL,'2018-02-03 09:55:58','2018-02-03 09:55:58'),(107,49,25,'Milestone \"M2\" was accepted by onewho',NULL,'2018-02-03 11:18:15','2018-02-03 11:18:15'),(108,53,25,'Milestone \"MIlestone 3\" funded on 11/02/2018(500€) - waiting for acceptation',NULL,'2018-02-11 14:01:22','2018-02-11 14:01:22'),(109,49,26,'onewho offered 2000€',NULL,'2018-02-11 14:02:10','2018-02-11 14:02:10'),(110,42,20,'Milestone \"test\" funded on 19/02/2018(100€) - waiting for acceptation',NULL,'2018-02-19 04:27:43','2018-02-19 04:27:43'),(111,42,20,'Milestone \"Test\" was created on 19/02/2018',NULL,'2018-02-19 04:28:03','2018-02-19 04:28:03'),(112,42,20,'Milestone \"Test\" funded on 19/02/2018(100€) - waiting for acceptation',NULL,'2018-02-19 04:28:21','2018-02-19 04:28:21'),(113,49,25,'Milestone \"MIlestone 3\" was accepted by onewho',NULL,'2018-02-19 14:15:00','2018-02-19 14:15:00'),(114,49,26,'onewho modified offer to 2000€ - waiting for accepting',NULL,'2018-02-21 19:13:08','2018-02-21 19:13:08'),(115,53,26,'onewho offered 2000€ (accepted by nielyork)',NULL,'2018-02-21 19:13:33','2018-02-21 19:13:33'),(116,53,26,'onewho offered 2000€ (accepted by nielyork)',NULL,'2018-02-21 19:13:33','2018-02-21 19:13:33'),(117,53,26,'Milestone \"ML1\" funded on 21/02/2018(200€) - waiting for acceptation',NULL,'2018-02-21 19:16:28','2018-02-21 19:16:28'),(118,49,26,'Milestone \"ML1\" was accepted by onewho',NULL,'2018-02-21 19:17:08','2018-02-21 19:17:08'),(119,49,26,'Milestone \"ML1\" was submitted by onewho(200€)',NULL,'2018-02-21 19:17:26','2018-02-21 19:17:26'),(120,53,26,'Revision asked on for milestone \"ML1\" was asked on 21/02/2018',NULL,'2018-02-21 19:19:40','2018-02-21 19:19:40'),(121,49,26,'Milestone \"ML1\" was submitted by onewho(200€)',NULL,'2018-02-21 19:20:14','2018-02-21 19:20:14'),(122,42,20,'Milestone \"Test milestone 777\" funded on 22/02/2018(100€) - waiting for acceptation',NULL,'2018-02-22 06:31:59','2018-02-22 06:31:59'),(123,43,20,'Milestone \"Test milestone 777\" was accepted by user2',NULL,'2018-02-22 06:32:41','2018-02-22 06:32:41'),(124,43,20,'Milestone \"Test milestone 777\" was submitted by user2(100€)',NULL,'2018-02-22 06:33:11','2018-02-22 06:33:11'),(125,58,27,'zoro  offered 2000€',NULL,'2018-03-05 11:08:06','2018-03-05 11:08:06'),(126,56,27,'zoro  offered 2000€ (accepted by tom)',NULL,'2018-03-05 11:08:48','2018-03-05 11:08:48'),(127,56,27,'Milestone \"M1\" was created on 05/03/2018',NULL,'2018-03-05 11:59:17','2018-03-05 11:59:17'),(128,56,27,'Milestone \"M1\" funded on 05/03/2018(500€) - waiting for acceptation',NULL,'2018-03-05 11:59:38','2018-03-05 11:59:38'),(129,56,27,'Milestone \"M2\" was created on 05/03/2018',NULL,'2018-03-05 12:01:48','2018-03-05 12:01:48'),(130,56,27,'Milestone \"M2\" funded on 05/03/2018(500€) - waiting for acceptation',NULL,'2018-03-05 12:02:03','2018-03-05 12:02:03');
/*!40000 ALTER TABLE `project_histories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `project_tag`
--

DROP TABLE IF EXISTS `project_tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `project_tag` (
  `project_id` int(10) unsigned NOT NULL,
  `tag_id` int(10) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`project_id`,`tag_id`),
  KEY `project_tag_project_id_index` (`project_id`),
  KEY `project_tag_tag_id_index` (`tag_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `project_tag`
--

LOCK TABLES `project_tag` WRITE;
/*!40000 ALTER TABLE `project_tag` DISABLE KEYS */;
INSERT INTO `project_tag` VALUES (23,6,NULL,NULL),(24,2,NULL,NULL),(25,1,NULL,NULL),(26,6,NULL,NULL),(27,2,NULL,NULL),(29,2,NULL,NULL),(30,2,NULL,NULL),(31,8,NULL,NULL),(32,6,NULL,NULL),(33,2,NULL,NULL),(34,1,NULL,NULL),(35,1,NULL,NULL),(35,8,NULL,NULL),(36,8,NULL,NULL),(38,32,NULL,NULL),(38,33,NULL,NULL),(38,57,NULL,NULL),(39,8,NULL,NULL),(39,15,NULL,NULL),(39,32,NULL,NULL),(39,33,NULL,NULL),(40,125,NULL,NULL);
/*!40000 ALTER TABLE `project_tag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `projects`
--

DROP TABLE IF EXISTS `projects`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `projects` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `type` enum('project','mission') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'project',
  `status` enum('opened','closed') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'opened',
  `author_id` int(10) unsigned NOT NULL,
  `title` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `description` text COLLATE utf8_unicode_ci NOT NULL,
  `slug` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `payment_method` enum('by day','flat price') COLLATE utf8_unicode_ci DEFAULT NULL,
  `budget` int(11) NOT NULL,
  `starts_at` date NOT NULL,
  `ends_at` date DEFAULT NULL,
  `place` text COLLATE utf8_unicode_ci,
  `show_email` tinyint(1) NOT NULL DEFAULT '1',
  `show_phone` tinyint(1) NOT NULL DEFAULT '1',
  `contact_phone` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `contact_email` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `views` int(11) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `projects_slug_unique` (`slug`),
  KEY `projects_author_id_index` (`author_id`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `projects`
--

LOCK TABLES `projects` WRITE;
/*!40000 ALTER TABLE `projects` DISABLE KEYS */;
INSERT INTO `projects` VALUES (23,'project','opened',42,'The employee management project','The employee management project','the-employee-management-project-565',NULL,2222,'2017-09-08','2017-09-20',NULL,1,1,'12345','hoadv106@gmail.com',12,'2017-09-08 16:29:16','2017-11-11 18:12:48'),(24,'project','closed',20,'Projet test','test','projet-test-353',NULL,1000,'2017-09-26','2017-10-04',NULL,1,1,'0787678786','khaled@thegaragelabs.com',28,'2017-09-08 23:24:48','2017-12-21 20:05:32'),(25,'project','closed',20,'Website a monter rapidement','Hi','website-a-monter-rapidement-482',NULL,1000,'2017-09-27','2017-09-27',NULL,1,1,'0787678786','khaled@thegaragelabs.com',62,'2017-09-09 10:36:40','2018-01-19 10:19:34'),(26,'project','closed',42,'Implement angular project','This is the project test','implement-angular-project-188',NULL,2000,'2017-10-12','2017-10-31',NULL,1,1,'12345','user1@gmail.com',76,'2017-10-10 17:04:43','2018-02-22 06:32:14'),(27,'project','closed',20,'New marketplace to build quickly','Here is the description of functionnal assets :\n- a\n- b\n- c..','new-marketplace-to-build-quickly-309',NULL,5000,'2017-10-18','2017-10-25',NULL,1,1,'0787678786','khaled@thegaragelabs.com',52,'2017-10-11 09:48:33','2018-01-19 10:17:21'),(28,'project','closed',20,'Project ABC','Desc','project-abc-945',NULL,1000,'2017-11-27','2017-12-14',NULL,1,1,'0787678786','khaled@thegaragelabs.com',32,'2017-11-12 08:57:56','2018-03-05 15:40:47'),(29,'project','closed',53,'ABC project','Searching for a dev','abc-project-406',NULL,100,'2018-01-04','2018-01-04',NULL,1,1,'897789987978','nielyork@gail.com',11,'2017-12-21 20:06:11','2018-03-07 15:41:36'),(30,'project','opened',54,'asdfasdf','asdfasdf','asdfasdf-403',NULL,500,'2018-01-24','2018-02-08',NULL,1,1,'webstar611@gmail.com','webstar611@gmail.com',4,'2018-01-22 17:33:45','2018-01-30 12:23:56'),(31,'project','opened',54,'asdf','asdf','asdf-640',NULL,355,'2018-01-24','2018-02-01',NULL,1,1,'webstar611@gmail.com','webstar611@gmail.com',1,'2018-01-22 22:14:26','2018-01-22 22:14:28'),(32,'project','opened',42,'Test issue','sss','test-issue-580',NULL,123,'2018-01-31','2018-02-01',NULL,1,1,'12345','user1@gmail.com',2,'2018-01-31 14:09:14','2018-01-31 14:10:26'),(33,'project','closed',53,'Test project','abcdef','test-project-499',NULL,1000,'2018-02-07','2018-02-08',NULL,1,1,'897789987978','nielyork@gail.com',2,'2018-01-31 18:03:51','2018-02-21 19:13:33'),(34,'project','opened',53,'SSS','AB','sss-239',NULL,2500,'2018-02-03','2018-02-04',NULL,1,1,'897789987978','nielyork@gail.com',5,'2018-02-02 11:14:35','2018-02-02 11:18:42'),(35,'project','closed',53,'SSS3','Desc','sss3-891',NULL,750,'2018-02-27','2018-02-27',NULL,1,1,'897789987978','nielyork@gail.com',5,'2018-02-02 11:17:43','2018-02-11 13:59:39'),(36,'project','closed',53,'New project','DESC','new-project-921',NULL,1000,'2018-02-03','2018-02-03',NULL,1,1,'897789987978','nielyork@gail.com',23,'2018-02-03 09:52:07','2018-03-05 21:34:50'),(37,'project','closed',56,'Lorem ipsum','Lorem ipsum','lorem-ipsum-327',NULL,2000,'2018-03-13','2018-03-19',NULL,1,1,'07894849948','tomripert@gmail.com',10,'2018-03-05 10:30:08','2018-03-05 19:00:59'),(38,'project','opened',56,'AAA','Lorem ipsum','aaa-387',NULL,10000,'2018-04-03','2018-03-08',NULL,1,1,'','tomripert@gmail.com',7,'2018-03-05 19:02:48','2018-03-05 21:40:24'),(39,'project','opened',56,'Lorem ipsum','Lorem ipsum','lorem-ipsum-463',NULL,10000,'2018-02-28','2018-03-27',NULL,1,1,'','tomripert@gmail.com',3,'2018-03-05 21:11:54','2018-03-07 15:51:40'),(40,'project','opened',61,'Lorem ipsum','Lorem ipsum','lorem-ipsum-544',NULL,1,'2018-03-21','2018-03-21',NULL,1,1,'07898789987','onetwo@gmail.com',3,'2018-03-07 15:52:42','2018-03-22 06:50:38');
/*!40000 ALTER TABLE `projects` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `proposals`
--

DROP TABLE IF EXISTS `proposals`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `proposals` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `author_id` int(10) unsigned NOT NULL,
  `project_id` int(10) unsigned NOT NULL,
  `offer` int(11) NOT NULL,
  `message` text COLLATE utf8_unicode_ci NOT NULL,
  `status` enum('waiting','accepted','rejected') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'waiting',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `proposals_author_id_project_id_unique` (`author_id`,`project_id`),
  KEY `proposals_author_id_index` (`author_id`),
  KEY `proposals_project_id_index` (`project_id`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `proposals`
--

LOCK TABLES `proposals` WRITE;
/*!40000 ALTER TABLE `proposals` DISABLE KEYS */;
INSERT INTO `proposals` VALUES (16,46,25,90,'hello?','accepted','2017-09-09 10:39:16','2017-09-09 11:14:22'),(17,42,24,100,'Hello','accepted','2017-09-24 08:46:58','2017-11-11 18:02:33'),(20,43,26,2000,'I would like to apply for it','accepted','2017-10-10 17:08:20','2017-10-10 17:09:08'),(21,49,27,2500,'Hello?','accepted','2017-10-11 09:52:34','2017-10-11 09:52:56'),(22,49,28,1150,'Hello?','accepted','2017-11-12 09:03:21','2017-11-12 09:05:15'),(23,49,29,500,'I wanna work with you.','accepted','2017-12-21 20:06:46','2017-12-21 20:07:07'),(24,49,35,930,'Hi,\nI have experience in blabla.\nhttps://coco.com\ncheck my portfolio.\nThanks','accepted','2018-02-02 11:30:15','2018-02-02 11:31:46'),(25,49,36,750,'Hello?','accepted','2018-02-03 09:52:36','2018-02-03 09:52:59'),(26,49,33,2000,'Mssage','accepted','2018-02-11 14:02:10','2018-02-21 19:13:33'),(27,58,37,2000,'I\'m interested','accepted','2018-03-05 11:08:06','2018-03-05 11:08:48');
/*!40000 ALTER TABLE `proposals` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `references`
--

DROP TABLE IF EXISTS `references`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `references` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL,
  `title` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `description` text COLLATE utf8_unicode_ci NOT NULL,
  `url` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `image` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `references_user_id_index` (`user_id`),
  CONSTRAINT `references_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `references`
--

LOCK TABLES `references` WRITE;
/*!40000 ALTER TABLE `references` DISABLE KEYS */;
/*!40000 ALTER TABLE `references` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `revisions`
--

DROP TABLE IF EXISTS `revisions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `revisions` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `milestone_id` int(10) unsigned NOT NULL,
  `description` text COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `revisions`
--

LOCK TABLES `revisions` WRITE;
/*!40000 ALTER TABLE `revisions` DISABLE KEYS */;
INSERT INTO `revisions` VALUES (5,35,'can u do that ? i need you to revise 1,2,3.\nthanks.','2017-10-11 11:17:06','2017-10-11 11:17:06'),(6,36,'Please attach the document','2017-10-11 14:55:36','2017-10-11 14:55:36'),(7,39,'DO X,Y,Z','2017-10-12 10:21:01','2017-10-12 10:21:01'),(8,50,'I dont like your shit\nPlease do it better.','2017-11-13 20:23:10','2017-11-13 20:23:10'),(9,59,'I didn\'t receive delivery?','2018-02-21 19:19:40','2018-02-21 19:19:40');
/*!40000 ALTER TABLE `revisions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `scategories`
--

DROP TABLE IF EXISTS `scategories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `scategories` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=31 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `scategories`
--

LOCK TABLES `scategories` WRITE;
/*!40000 ALTER TABLE `scategories` DISABLE KEYS */;
INSERT INTO `scategories` VALUES (1,'Artisanat',NULL,NULL),(2,'Energie',NULL,NULL),(3,'Beauté',NULL,NULL),(4,'Automobile',NULL,NULL),(5,'Evennementiel',NULL,NULL),(6,'Immobilier',NULL,NULL),(7,'Education',NULL,NULL),(8,'Internet des objets',NULL,NULL),(9,'Domotique',NULL,NULL),(10,'Industriel',NULL,NULL),(11,'Distribution/retail',NULL,NULL),(12,'Tourisme',NULL,NULL),(13,'Voyage',NULL,NULL),(14,'Consulting',NULL,NULL),(15,'Logistique',NULL,NULL),(16,'Marketing digital',NULL,NULL),(17,'Bien être/santé',NULL,NULL),(18,'Services B2C',NULL,NULL),(19,'Services B2B',NULL,NULL),(20,'Services B2B2C',NULL,NULL),(21,'Télécommunications',NULL,NULL),(22,'Marketplace',NULL,NULL),(23,'Application mobile',NULL,NULL),(24,'E-commerce',NULL,NULL),(25,'Sécurité',NULL,NULL),(26,'Finance/Finetech',NULL,NULL),(27,'Technologies',NULL,NULL),(28,'Gamification/jeu',NULL,NULL),(29,'Art',NULL,NULL),(30,'Logiciel',NULL,NULL);
/*!40000 ALTER TABLE `scategories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `service_categories`
--

DROP TABLE IF EXISTS `service_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `service_categories` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `service_categories`
--

LOCK TABLES `service_categories` WRITE;
/*!40000 ALTER TABLE `service_categories` DISABLE KEYS */;
INSERT INTO `service_categories` VALUES (1,'Conseil stratégique',NULL,NULL),(2,'Design',NULL,NULL),(3,'Branding',NULL,NULL),(4,'Marketing digital',NULL,NULL),(5,'Référencement',NULL,NULL),(6,'Contenu',NULL,NULL),(7,'Vidéo',NULL,NULL),(8,'Technologies/développement',NULL,NULL),(9,'Développement business',NULL,NULL),(10,'Juridique',NULL,NULL),(11,'Comptabilité',NULL,NULL),(12,'Fiscalité',NULL,NULL);
/*!40000 ALTER TABLE `service_categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `service_message_documents`
--

DROP TABLE IF EXISTS `service_message_documents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `service_message_documents` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `service_message_id` int(10) unsigned NOT NULL,
  `filename` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `service_message_documents`
--

LOCK TABLES `service_message_documents` WRITE;
/*!40000 ALTER TABLE `service_message_documents` DISABLE KEYS */;
INSERT INTO `service_message_documents` VALUES (2,29,'L3cp9Azlz8.docx','2018-01-05 17:29:33','2018-01-05 17:29:33'),(3,36,'hqfkrMuKyH.jpg','2018-02-21 19:12:14','2018-02-21 19:12:14'),(4,42,'m6LKbyWkgD.png','2018-03-05 13:18:07','2018-03-05 13:18:07');
/*!40000 ALTER TABLE `service_message_documents` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `service_messages`
--

DROP TABLE IF EXISTS `service_messages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `service_messages` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ordered_package_id` int(10) unsigned NOT NULL,
  `text` text COLLATE utf8_unicode_ci NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '0',
  `sender_id` int(10) unsigned NOT NULL,
  `receiver_id` int(10) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=44 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `service_messages`
--

LOCK TABLES `service_messages` WRITE;
/*!40000 ALTER TABLE `service_messages` DISABLE KEYS */;
INSERT INTO `service_messages` VALUES (27,30,'hello user 2',1,42,43,'2018-01-05 17:28:34','2018-01-08 17:10:31'),(28,30,'hello user 1',1,43,42,'2018-01-05 17:29:10','2018-01-08 17:12:13'),(29,30,'doc',1,42,43,'2018-01-05 17:29:33','2018-01-08 17:10:31'),(30,31,'hello',1,49,53,'2018-01-05 21:37:07','2018-01-08 17:40:20'),(31,31,'hi',1,53,49,'2018-01-05 21:39:39','2018-01-08 17:41:25'),(32,31,'hiii',1,49,53,'2018-01-05 21:40:12','2018-01-08 17:40:20'),(33,31,'testoo',1,49,53,'2018-01-08 17:38:48','2018-01-08 17:40:20'),(34,28,'oh',1,53,49,'2018-01-08 17:40:35','2018-02-19 14:07:07'),(35,35,'hiiii',1,49,53,'2018-02-19 14:11:45','2018-02-21 19:13:26'),(36,35,'hello file',1,49,53,'2018-02-21 19:12:14','2018-02-21 19:13:26'),(37,39,'hi',1,49,56,'2018-03-05 12:45:53','2018-03-05 18:37:05'),(38,39,'Ola chico',1,56,49,'2018-03-05 12:47:00','2018-03-05 15:56:48'),(39,39,'Je kiffe l\'email html, le logo il claque sur fond noir. Faut trouver la bonne combinaison pour le site',1,56,49,'2018-03-05 12:48:50','2018-03-05 15:56:48'),(40,39,'haha :)',1,49,56,'2018-03-05 12:52:29','2018-03-05 18:37:05'),(41,39,'La page des notifs marche, mais un peu cheum : http://52.32.112.212/user/notifications',1,49,56,'2018-03-05 13:17:50','2018-03-05 18:37:05'),(42,39,'Test attached file',1,49,56,'2018-03-05 13:18:07','2018-03-05 18:37:05'),(43,39,'That works',0,56,49,'2018-03-05 18:37:20','2018-03-05 18:37:20');
/*!40000 ALTER TABLE `service_messages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `service_subcategories`
--

DROP TABLE IF EXISTS `service_subcategories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `service_subcategories` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `category_id` int(10) unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=12 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `service_subcategories`
--

LOCK TABLES `service_subcategories` WRITE;
/*!40000 ALTER TABLE `service_subcategories` DISABLE KEYS */;
INSERT INTO `service_subcategories` VALUES (1,2,'UX et maquettage conceptuel',NULL,NULL),(2,2,'Logos & identités visuelles de marque',NULL,NULL),(3,2,'Design d’Applications (UI)',NULL,NULL),(4,2,'Design de sites (UI)',NULL,NULL),(5,2,'Design d’application bureau (UI) ',NULL,NULL),(6,8,'Développement mobile',NULL,NULL),(7,8,'Développement web, e-commerce',NULL,NULL),(8,8,'Développement d’applications bureau',NULL,NULL),(9,8,'Administration serveur',NULL,NULL),(10,8,'Sécurité ',NULL,NULL),(11,8,'E-payment et gestion de fonds pour compte de tiers',NULL,NULL);
/*!40000 ALTER TABLE `service_subcategories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `services`
--

DROP TABLE IF EXISTS `services`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `services` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `slug` int(11) NOT NULL,
  `avg_stars` decimal(10,0) NOT NULL DEFAULT '0',
  `author_id` int(10) unsigned NOT NULL,
  `category_id` int(10) unsigned NOT NULL,
  `subcategory_id` int(10) unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=24 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `services`
--

LOCK TABLES `services` WRITE;
/*!40000 ALTER TABLE `services` DISABLE KEYS */;
INSERT INTO `services` VALUES (16,'Implement angular project service','Implement angular project service',0,0,42,1,0,'2017-12-17 10:56:01','2017-12-17 10:56:01'),(17,'I\'ll scrap a website','Scrapper built in PHP',0,0,49,2,1,'2017-12-17 16:22:34','2017-12-17 16:22:34'),(18,'test video','aaaa',0,0,53,2,1,'2017-12-17 19:05:06','2018-02-02 11:01:33'),(19,'Implement angular project user1','Implement angular project user1',0,0,42,1,0,'2017-12-19 10:36:25','2017-12-19 10:36:25'),(20,'The service 2','The service 2',0,0,43,1,0,'2017-12-19 10:59:29','2017-12-19 10:59:29'),(21,'The demo 1','The demo 1',0,0,42,4,0,'2018-01-05 17:14:57','2018-01-05 17:27:00'),(22,'T1','D2',0,0,53,8,6,'2018-01-12 07:10:11','2018-01-12 07:10:11'),(23,'Lorem ipsum','Lorem ipsum',0,0,58,4,0,'2018-03-05 10:56:35','2018-03-05 10:56:35');
/*!40000 ALTER TABLE `services` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `skill_startup`
--

DROP TABLE IF EXISTS `skill_startup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `skill_startup` (
  `skill_id` int(10) unsigned NOT NULL,
  `start_up_id` int(10) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`skill_id`,`start_up_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `skill_startup`
--

LOCK TABLES `skill_startup` WRITE;
/*!40000 ALTER TABLE `skill_startup` DISABLE KEYS */;
INSERT INTO `skill_startup` VALUES (1,5,NULL,NULL),(1,6,NULL,NULL),(2,6,NULL,NULL),(2,7,NULL,NULL),(3,8,NULL,NULL),(4,9,NULL,NULL),(2,10,NULL,NULL),(2,11,NULL,NULL),(1,11,NULL,NULL),(3,12,NULL,NULL),(14,12,NULL,NULL),(19,12,NULL,NULL),(3,13,NULL,NULL),(2,14,NULL,NULL),(9,15,NULL,NULL),(11,15,NULL,NULL),(5,15,NULL,NULL),(13,16,NULL,NULL),(9,16,NULL,NULL),(7,17,NULL,NULL),(2,18,NULL,NULL),(2,19,NULL,NULL),(4,20,NULL,NULL),(9,20,NULL,NULL),(4,21,NULL,NULL),(9,21,NULL,NULL),(4,22,NULL,NULL),(9,22,NULL,NULL),(4,23,NULL,NULL),(9,23,NULL,NULL),(4,24,NULL,NULL),(9,24,NULL,NULL),(4,25,NULL,NULL),(9,25,NULL,NULL),(4,26,NULL,NULL),(9,26,NULL,NULL),(4,27,NULL,NULL),(11,27,NULL,NULL),(4,28,NULL,NULL),(11,28,NULL,NULL),(2,29,NULL,NULL),(3,30,NULL,NULL),(6,31,NULL,NULL),(17,31,NULL,NULL),(18,32,NULL,NULL),(2,33,NULL,NULL),(8,34,NULL,NULL),(2,35,NULL,NULL),(9,36,NULL,NULL),(20,37,NULL,NULL),(19,38,NULL,NULL),(17,39,NULL,NULL),(2,40,NULL,NULL),(11,41,NULL,NULL),(13,41,NULL,NULL),(8,42,NULL,NULL),(9,42,NULL,NULL),(12,42,NULL,NULL);
/*!40000 ALTER TABLE `skill_startup` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `skill_user`
--

DROP TABLE IF EXISTS `skill_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `skill_user` (
  `user_id` int(10) unsigned NOT NULL,
  `skill_id` int(10) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`user_id`,`skill_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `skill_user`
--

LOCK TABLES `skill_user` WRITE;
/*!40000 ALTER TABLE `skill_user` DISABLE KEYS */;
INSERT INTO `skill_user` VALUES (51,19,NULL,NULL),(42,1,NULL,NULL),(43,3,NULL,NULL),(43,4,NULL,NULL),(20,10,NULL,NULL),(20,7,NULL,NULL),(20,8,NULL,NULL),(52,3,NULL,NULL),(53,3,NULL,NULL),(54,2,NULL,NULL),(55,2,NULL,NULL),(56,6,NULL,NULL),(57,3,NULL,NULL),(58,9,NULL,NULL),(58,4,NULL,NULL),(58,3,NULL,NULL),(59,4,NULL,NULL),(59,3,NULL,NULL),(56,1,NULL,NULL),(56,4,NULL,NULL),(56,3,NULL,NULL),(56,7,NULL,NULL),(60,11,NULL,NULL),(60,3,NULL,NULL),(61,22,NULL,NULL);
/*!40000 ALTER TABLE `skill_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `skills`
--

DROP TABLE IF EXISTS `skills`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `skills` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=32 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `skills`
--

LOCK TABLES `skills` WRITE;
/*!40000 ALTER TABLE `skills` DISABLE KEYS */;
INSERT INTO `skills` VALUES (1,'Développement mobile',NULL,NULL),(2,'Développement web',NULL,NULL),(3,'Développement back-end',NULL,NULL),(4,'Développement FULL STACK JS',NULL,NULL),(5,'Développement d’applicatifs',NULL,NULL),(6,'A/B testing',NULL,NULL),(7,'Architecture technique',NULL,NULL),(8,'Big Data',NULL,NULL),(9,'CRM',NULL,NULL),(10,'Marketing viral',NULL,NULL),(11,'Machine Learning',NULL,NULL),(12,'Intelligence artificielle',NULL,NULL),(13,'Mathématiques, algorithmique',NULL,NULL),(14,'Gestion de projet fonctionnelle',NULL,NULL),(15,'Gestion de projet technique',NULL,NULL),(16,'Rédaction de spécifications',NULL,NULL),(17,'Marketing digital',NULL,NULL),(18,'Growth hacking',NULL,NULL),(19,'SEO',NULL,NULL),(20,'Positionnement produit',NULL,NULL),(21,'Branding',NULL,NULL),(22,'Finance',NULL,NULL),(23,'Levée de fonds (A/B Stage)',NULL,NULL),(24,'Business development',NULL,NULL),(25,'Stratégie commerciale',NULL,NULL),(26,'Prospection/avant-vente',NULL,NULL),(27,'Direction/administratif',NULL,NULL),(28,'Compatibilité',NULL,NULL),(29,'Graphisme/UI',NULL,NULL),(30,'Direction artistique',NULL,NULL),(31,'Maquettage conceptuel UX',NULL,NULL);
/*!40000 ALTER TABLE `skills` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `startup_member`
--

DROP TABLE IF EXISTS `startup_member`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `startup_member` (
  `start_up_id` int(10) NOT NULL,
  `user_id` int(10) NOT NULL,
  `role` varchar(255) NOT NULL COMMENT 'saber ouarezzamen',
  `description` text NOT NULL,
  PRIMARY KEY (`start_up_id`,`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `startup_member`
--

LOCK TABLES `startup_member` WRITE;
/*!40000 ALTER TABLE `startup_member` DISABLE KEYS */;
/*!40000 ALTER TABLE `startup_member` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `startup_members`
--

DROP TABLE IF EXISTS `startup_members`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `startup_members` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `start_up_id` int(10) unsigned NOT NULL,
  `link` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `email` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `user_id` int(10) unsigned NOT NULL,
  `name` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `role` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `avatar_path` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `joined_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=72 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `startup_members`
--

LOCK TABLES `startup_members` WRITE;
/*!40000 ALTER TABLE `startup_members` DISABLE KEYS */;
INSERT INTO `startup_members` VALUES (42,29,'','user1@gmail.com',42,'mr user1','CEO','This is the CEO role','http://52.32.112.212/vendor/avatar/default.jpg',1,'2017-11-12 00:42:46','2017-11-12 01:17:55',NULL),(43,29,NULL,'hoadv106@gmail.com',43,'ms user2','CEO','This is the CEO','http://52.32.112.212/vendor/avatar/default.jpg',1,'2017-11-12 00:42:46','2017-11-12 01:20:03','2017-11-12 01:20:03'),(45,29,NULL,'xbdvhqn@gmail.com',51,'user12 u','develop1','develop1','http://52.32.112.212/vendor/avatar/default.jpg',1,'2017-11-12 01:35:23','2017-11-12 01:38:27','2017-11-12 01:35:36'),(46,30,'','user1@gmail.com',42,'mr user1','CEO','Say some words about you role in the company.','http://52.32.112.212/vendor/avatar/default.jpg',1,'2017-11-12 05:30:32','2017-11-12 05:30:32',NULL),(47,30,NULL,'hoadv106@gmail.com',43,'ms user2','member','Hello you','http://52.32.112.212/vendor/avatar/default.jpg',1,'2017-11-12 05:30:32','2017-11-12 05:30:55','2017-11-12 05:30:55'),(49,30,NULL,'xbdvhqn@gmail.com',51,'user12 u','develop','Please join','http://52.32.112.212/vendor/avatar/default.jpg',1,'2017-11-12 05:39:26','2017-11-12 05:39:44','2017-11-12 05:39:44'),(50,31,'','khaled@thegaragelabs.com',20,'Khaled Shehata','CEO','I\'m the boss here.','http://52.32.112.212/vendor/avatar/default.jpg',1,'2017-11-12 08:20:40','2017-11-12 08:20:40',NULL),(51,31,'QbTOZtgUpWUO3jdmzEBz','khaled.solutions@gmail.com',0,'New member','CTO','Tech rockstar','',0,'2017-11-12 08:20:40','2017-11-12 08:20:40',NULL),(52,31,'6TuAFIBi6L0c2p4WS30g','khaled@geniesis.co',0,'New member','COO','Our COO.','',0,'2017-11-12 08:20:40','2017-11-12 08:20:40',NULL),(53,32,'','user1@gmail.com',42,'mr user1','My position (Ex. CEO)','Say some words about you role in the company.','http://52.32.112.212/vendor/avatar/default.jpg',1,'2017-11-13 00:49:46','2017-11-13 00:49:46',NULL),(54,32,'a12HmmneGhWcjK5dHsIj','xbdvhqn@gmail.com',0,'New member','member','hello','',0,'2017-11-13 00:49:46','2017-11-13 00:49:46',NULL),(55,33,'','user1@gmail.com',42,'mr user1','My position (Ex. CEO)','Say some words about you role in the company.','http://52.32.112.212/vendor/avatar/default.jpg',1,'2017-11-13 01:11:15','2017-11-13 01:11:15',NULL),(56,33,'xcFSzqWB3XazkSyBkUeP','xbdvhqn@gmail.com',0,'New member','member','aaa','/vendor/img/startup-logo.jpg',0,'2017-11-13 01:11:15','2017-11-13 01:11:15',NULL),(57,33,NULL,'hoadv106@gmail.com',43,'ms user2','Develop','dd','http://52.32.112.212/storage/5n9SaxjqFU.jpg',1,'2017-11-13 01:11:15','2017-11-13 01:13:44','2017-11-13 01:13:44'),(58,34,'','nielyork@gail.com',53,'Niel York','CEO','I\'m the founder.','http://52.32.112.212/vendor/avatar/default.jpg',1,'2017-11-13 07:17:45','2017-11-13 07:17:45',NULL),(59,34,'IyaQwHLvVqkMdySu8Dd0','g.el.messaoudi@gmail.com',5,'Ghariba El Messaoudi','COO','She\'s mananing the operations in XYZ.','http://52.32.112.212/vendor/avatar/default.jpg',0,'2017-11-13 07:17:45','2017-11-13 07:17:45',NULL),(60,35,'','user1@gmail.com',42,'mr user1','My position (Ex. CEO)','Say some words about you role in the company.','http://52.32.112.212/vendor/avatar/default.jpg',1,'2017-12-18 01:19:36','2017-12-18 01:19:36',NULL),(61,36,'','ezio.d@mail.com',55,'creed ezio','My position (Ex. CEO)','Say some words about you role in the company.','http://52.32.112.212/vendor/avatar/default.jpg',1,'2018-01-19 10:35:37','2018-01-19 10:35:37',NULL),(62,37,'','user1@gmail.com',42,'mr user1','My position (Ex. CEO)','Say some words about you role in the company.','http://52.32.112.212/vendor/avatar/default.jpg',1,'2018-01-31 14:10:31','2018-01-31 14:10:31',NULL),(63,38,'','user1@gmail.com',42,'mr user1','My position (Ex. CEO)','Say some words about you role in the company.','http://52.32.112.212/vendor/avatar/default.jpg',1,'2018-01-31 14:25:38','2018-01-31 14:25:38',NULL),(64,39,'','user1@gmail.com',42,'mr user1','My position (Ex. CEO)','Say some words about you role in the company.','http://52.32.112.212/vendor/avatar/default.jpg',1,'2018-02-19 04:00:05','2018-02-19 04:00:05',NULL),(65,39,'rSQvbDnu5ynqAIXKVad4','hoadv106@gmail.com',43,'ms user2','dev','hello','http://52.32.112.212/storage/5n9SaxjqFU.jpg',0,'2018-02-19 04:02:07','2018-02-19 04:02:07',NULL),(66,40,'','nielyork@gail.com',53,'Niel York','CEO','Im the boss here','http://52.32.112.212/vendor/avatar/default.jpg',1,'2018-02-27 21:01:25','2018-02-27 21:01:25',NULL),(67,40,NULL,'khaled.solutions@gmail.com',57,'loulou ss','CTO','tech guy','http://52.32.112.212/vendor/avatar/default.jpg',1,'2018-02-27 21:01:25','2018-02-27 21:02:37','2018-02-27 21:02:37'),(68,41,'','tomripert@gmail.com',56,'Tom  Ripert','CEO','Lorem ipsum','http://52.32.112.212/storage/AwlUvwTHCQ.jpg',1,'2018-03-05 10:09:18','2018-03-05 10:09:18',NULL),(69,41,'SYBJcv5XheKqfNNVuJcA','tom@rolzo.com',0,'New member','CTO','Lorem ipsum','/vendor/img/startup-logo.jpg',0,'2018-03-05 10:09:18','2018-03-05 10:09:18',NULL),(70,42,'','onetwo@gmail.com',61,'One  Two','Intern','I make coffee for the team','http://52.32.112.212/storage/tj81r0gadQ.png',1,'2018-03-07 15:48:09','2018-03-07 15:48:09',NULL),(71,42,'rXCKVNcP9zH7YkU8EP9Z','clean@gmail.com',0,'New member','Cleaner','I clean the coffee cups for the team','/vendor/img/startup-logo.jpg',0,'2018-03-07 15:48:09','2018-03-07 15:48:09',NULL);
/*!40000 ALTER TABLE `startup_members` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `startup_message_documents`
--

DROP TABLE IF EXISTS `startup_message_documents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `startup_message_documents` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `startup_message_id` int(10) unsigned NOT NULL,
  `filename` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `author_id` int(10) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `startup_message_documents`
--

LOCK TABLES `startup_message_documents` WRITE;
/*!40000 ALTER TABLE `startup_message_documents` DISABLE KEYS */;
INSERT INTO `startup_message_documents` VALUES (4,34,'ITGUHRkW6x.docx',42,'2018-02-19 04:03:15','2018-02-19 04:03:15');
/*!40000 ALTER TABLE `startup_message_documents` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `startup_messages`
--

DROP TABLE IF EXISTS `startup_messages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `startup_messages` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `contact_id` int(10) unsigned NOT NULL,
  `text` text COLLATE utf8_unicode_ci NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '0',
  `sender_id` int(10) unsigned NOT NULL,
  `receiver_id` int(10) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=38 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `startup_messages`
--

LOCK TABLES `startup_messages` WRITE;
/*!40000 ALTER TABLE `startup_messages` DISABLE KEYS */;
INSERT INTO `startup_messages` VALUES (28,29,'hi ? (second message)',1,53,49,'2018-01-05 21:34:18','2018-02-19 14:11:13'),(27,27,'Hello',1,53,49,'2017-12-21 20:01:27','2017-12-21 20:06:27'),(26,24,'hi',0,20,46,'2017-10-09 12:49:27','2017-10-09 12:49:27'),(25,24,'look',1,46,20,'2017-09-11 18:28:52','2017-10-09 12:49:45'),(24,21,'Hello user2',1,42,43,'2017-09-11 01:23:25','2018-02-19 04:04:34'),(23,23,'Hello there',0,42,20,'2017-09-11 01:22:35','2017-09-11 01:22:35'),(22,24,'ou pas',1,46,20,'2017-09-10 19:50:11','2017-10-09 12:49:45'),(21,24,'cava?',1,46,20,'2017-09-10 19:50:03','2017-10-09 12:49:45'),(20,24,'Hi',1,20,46,'2017-09-09 10:34:44','2017-09-19 09:42:19'),(19,24,'Bonjour',1,46,20,'2017-09-09 10:34:16','2017-10-09 12:49:45'),(18,21,'Hello',1,43,42,'2017-09-09 09:53:30','2017-09-11 01:27:47'),(17,21,'Hello user 2',1,42,43,'2017-09-09 09:53:00','2018-02-19 04:04:34'),(29,32,'ttt',1,53,49,'2018-01-08 17:51:48','2018-01-08 17:52:08'),(30,31,'Hello',1,42,49,'2018-01-09 00:21:18','2018-02-02 11:11:46'),(31,33,'hu1',1,53,20,'2018-01-11 17:25:21','2018-01-11 17:26:24'),(32,33,'ho',1,53,20,'2018-01-11 17:25:36','2018-01-11 17:26:24'),(33,33,'xx',1,20,53,'2018-01-11 17:26:06','2018-02-02 10:46:26'),(34,41,'OK',1,42,43,'2018-02-19 04:03:15','2018-02-19 04:04:42'),(35,41,'How are you?',1,42,43,'2018-02-19 04:04:02','2018-02-19 04:04:42'),(36,45,'We only hire fucking psychopaths mate',1,56,49,'2018-03-05 13:37:00','2018-03-05 15:28:22'),(37,45,'haha :D',1,49,56,'2018-03-05 13:38:21','2018-03-05 13:38:45');
/*!40000 ALTER TABLE `startup_messages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `startups`
--

DROP TABLE IF EXISTS `startups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `startups` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `finding` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
  `montant_recherche` decimal(10,0) DEFAULT NULL,
  `parts_sociales_cedees` decimal(10,0) DEFAULT NULL,
  `valorisation_societe` decimal(10,0) DEFAULT NULL,
  `montant_leve` decimal(10,0) DEFAULT NULL,
  `montant_utilisation` text COLLATE utf8_unicode_ci,
  `concept` text COLLATE utf8_unicode_ci,
  `business_model` text COLLATE utf8_unicode_ci,
  `competitors` text COLLATE utf8_unicode_ci,
  `project_status` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `looking_partners` text COLLATE utf8_unicode_ci,
  `website` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `concept_video` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `author_id` int(10) unsigned NOT NULL,
  `views` int(11) unsigned NOT NULL DEFAULT '0',
  `slug` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `type` varchar(10) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'startups',
  `logo` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `fonds_types_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fonds_types_id` (`fonds_types_id`),
  KEY `fonds_types_id_2` (`fonds_types_id`)
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `startups`
--

LOCK TABLES `startups` WRITE;
/*!40000 ALTER TABLE `startups` DISABLE KEYS */;
INSERT INTO `startups` VALUES (14,'Test the startup title 1','0',NULL,NULL,NULL,NULL,NULL,'This is the concept','This is the business model','aa','0_2','test','http://abc.com','',42,74,'test-the-startup-title-1-566','startups',NULL,'2017-09-08 16:28:05','2018-02-03 10:27:42',1),(15,'Startup proj\' !','0_1',NULL,NULL,NULL,NULL,NULL,'Conceptus description','BM','Competitors !','0_1_2_3_4','Mes sauces.','http://www.google.fr','',46,141,'startup-proj-167','startups',NULL,'2017-09-09 10:32:59','2017-11-06 17:19:25',1),(16,'Mobile App test project','0_1',100000,20,1000000,20000,'Lancer la communication.','Concept inédit de co-voiturage de luxe.','Marge sur la course, volume.','Aucun.','0_1_2_3','Des malades mentaux.','http://www.rookso.com','',20,14,'mobile-app-test-project-239','startups',NULL,'2017-10-12 10:40:05','2018-02-02 15:02:06',1),(17,'Fongoh Martin\'s Digital Renter','0_1',23223,223,2323,23,'Description of the funds needed','Lorep ipson for the concept','Business model for the lorem','Concceretne lorep','0_1_2','Associes and some lorem','https://digitalrenter.com','https://digitalrenter.com/listings',50,6,'fongoh-martin-s-digital-renter-383','startups',NULL,'2017-10-17 14:52:13','2017-12-04 07:32:13',3),(18,'This is the title 1','0',0,0,0,0,'','abc','abc','abc','0','aaa','https://www.youtube.com/watch?v=Jbt5bEgv_QM','https://www.youtube.com/watch?v=Jbt5bEgv_QM',42,4,'this-is-the-title-1-933','startups',NULL,'2017-10-17 14:54:46','2017-11-11 17:52:47',0),(19,'Test startup 1','0',0,0,0,0,'','Test startup 1','Test startup 1','Test startup 1','0_1','Test startup 1','https://www.youtube.com/watch?v=Jbt5bEgv_QM','https://www.youtube.com/watch?v=Jbt5bEgv_QM',42,22,'test-startup-1-762','startups',NULL,'2017-10-30 01:04:07','2017-12-17 14:56:32',0),(29,'This is the title 1','0',0,0,0,0,'','This is the title 1','This is the title 1','This is the title 1','0_1','HElLO','https://www.youtube.com/watch?v=Jbt5bEgv_QM','https://www.youtube.com/watch?v=Jbt5bEgv_QM',42,31,'this-is-the-title-1-405','startups',NULL,'2017-11-12 00:42:46','2018-01-12 15:55:03',0),(30,'Implement Vue project','0',0,0,0,0,'','The concept','The business model','The concurents','0_1_2_3_4','Test','https://www.youtube.com/watch?v=Jbt5bEgv_QM','https://www.youtube.com/watch?v=Jbt5bEgv_QM',42,29,'implement-vue-project-875','startups',NULL,'2017-11-12 05:30:32','2018-03-02 13:51:27',0),(31,'Start-up fintech ','0',0,0,0,0,'','Concept','Business model','Competitors','0_1_2_3','Associés','','',20,27,'start-up-fintech-841','startups',NULL,'2017-11-12 08:20:40','2018-01-20 12:20:20',0),(32,'Test the startup','0',0,0,0,0,'','test','test','test','0_1','aaa','https://www.youtube.com/watch?v=Jbt5bEgv_QM','https://www.youtube.com/watch?v=Jbt5bEgv_QM',42,8,'test-the-startup-770','startups',NULL,'2017-11-13 00:49:46','2018-02-19 04:00:17',0),(33,'This is the title 1111','0',0,0,0,0,'','ss','fff','ggg','0_1','ddd','https://www.youtube.com/watch?v=Jbt5bEgv_QM','https://www.youtube.com/watch?v=Jbt5bEgv_QM',42,10,'this-is-the-title-1111-851','startups',NULL,'2017-11-13 01:11:15','2018-02-11 14:19:57',0),(34,'Start-up XYZ','0',0,0,0,0,'','C','BM','CC','0_1_2_3_4','','','',53,43,'start-up-xyz-469','startups',NULL,'2017-11-13 07:17:45','2018-03-05 15:51:21',0),(35,'This is the title 1','0',0,0,0,0,'','This is the title 1','This is the title 1','This is the title 1','1_2','This is the title 1','https://www.youtube.com/watch?v=Jbt5bEgv_QM','https://www.youtube.com/watch?v=Jbt5bEgv_QM',42,16,'this-is-the-title-1-238','startups',NULL,'2017-12-18 01:19:36','2018-03-05 15:56:53',0),(36,'project for ezio','0',0,0,0,0,'','test concept','test business model','competitors','0_2','','','',55,13,'project-for-ezio-458','startups',NULL,'2018-01-19 10:35:37','2018-03-04 15:53:33',0),(37,'Start up with icon','0',0,0,0,0,'','aa','dd','ff','0_1','dd','https://www.youtube.com/watch?v=Jbt5bEgv_QM','https://www.youtube.com/watch?v=Jbt5bEgv_QM',42,12,'start-up-with-icon-362','startups',NULL,'2018-01-31 14:10:31','2018-03-06 15:09:35',0),(38,'test with icon','0',0,0,0,0,'','sss','rrr','ttt','0_1','te','https://www.youtube.com/watch?v=Jbt5bEgv_QM','https://www.youtube.com/watch?v=Jbt5bEgv_QM',42,26,'test-with-icon-878','startups','kwrUNPOvRk.jpg','2018-01-31 14:25:38','2018-03-05 10:48:02',0),(39,'The startup message','0',0,0,0,0,'','The startup message','The startup message','The startup message','0_1','The startup message','https://www.youtube.com/watch?v=Jbt5bEgv_QM','https://www.youtube.com/watch?v=Jbt5bEgv_QM',42,15,'the-startup-message-291','startups','','2018-02-19 04:00:05','2018-03-04 15:12:48',0),(40,'Benchmark cold-wallet hardware/security elements (crypto-currencies)','0',0,0,0,0,'','cc','bm','cc','0_1_3_2','','','',53,25,'benchmark-cold-wallet-hardware-security-elements-crypto-currencies-947','startups','','2018-02-27 21:01:25','2018-03-22 06:44:33',0),(41,'bunk','0',0,0,0,0,'','Lorem ipsum','Lorem ipsum','Lorem ipsum','2_1_0','Lorem ipsum','','',56,21,'bunk-511','startups','65ljQScDYn.jpg','2018-03-05 10:09:18','2018-03-22 06:50:49',0),(42,'BOB','0_1',10000,1,1,1,'Lorem ipsum','Lorem ipsum','Lorem ipsum','Lorem ipsum','0_1_2_3','Lorem ipsum\n\nLorem ipsum\n\nLorem ipsum\n\nLorem ipsum\n\nLorem ipsum','','',61,9,'bob-819','startups','niKE7rdSEp.png','2018-03-07 15:48:09','2018-03-22 06:50:42',3);
/*!40000 ALTER TABLE `startups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tags`
--

DROP TABLE IF EXISTS `tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tags` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `tags_name_unique` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=248 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tags`
--

LOCK TABLES `tags` WRITE;
/*!40000 ALTER TABLE `tags` DISABLE KEYS */;
INSERT INTO `tags` VALUES (1,'PHP','2016-11-22 09:49:40','2016-11-22 09:49:40'),(2,'Laravel','2016-11-22 09:49:40','2016-11-22 09:49:40'),(3,'Symfony','2016-11-22 09:49:40','2016-11-22 09:49:40'),(4,'Zend framework','2016-11-22 09:49:40','2016-11-22 09:49:40'),(5,'Node.js','2016-11-22 09:49:40','2016-11-22 09:49:40'),(6,'Angular.js','2016-11-22 09:49:40','2016-11-22 09:49:40'),(7,'Vue.js','2016-11-22 09:49:40','2016-11-22 09:49:40'),(8,'Javascript','2016-11-22 09:49:40','2016-11-22 09:49:40'),(9,'Backbone.JS','2016-11-22 09:49:40','2016-11-22 09:49:40'),(10,'Ember.JS','2016-11-22 09:49:40','2016-11-22 09:49:40'),(11,'Spin.JS','2016-11-22 09:49:40','2016-11-22 09:49:40'),(12,'Dojo framework','2016-11-22 09:49:40','2016-11-22 09:49:40'),(13,'ASP.NET','2016-11-22 09:49:40','2016-11-22 09:49:40'),(14,'J2EE','2016-11-22 09:49:40','2016-11-22 09:49:40'),(15,'Java','2016-11-22 09:49:40','2016-11-22 09:49:40'),(16,'Android OS','2016-11-22 09:49:40','2016-11-22 09:49:40'),(17,'iOS','2016-11-22 09:49:40','2016-11-22 09:49:40'),(18,'Windows Phone','2016-11-22 09:49:40','2016-11-22 09:49:40'),(19,'Python','2016-11-22 09:49:40','2016-11-22 09:49:40'),(20,'Django','2016-11-22 09:49:40','2016-11-22 09:49:40'),(21,'Ruby on rails','2016-11-22 09:49:40','2016-11-22 09:49:40'),(22,'HTML','2016-11-22 09:49:40','2016-11-22 09:49:40'),(23,'CSS','2016-11-22 09:49:40','2016-11-22 09:49:40'),(24,'NoSQL','2016-11-22 09:49:40','2016-11-22 09:49:40'),(25,'MangoDB','2016-11-22 09:49:40','2016-11-22 09:49:40'),(26,'Cassandra','2016-11-22 09:49:40','2016-11-22 09:49:40'),(27,'MySQL','2016-11-22 09:49:40','2016-11-22 09:49:40'),(28,'Postgres','2016-11-22 09:49:40','2016-11-22 09:49:40'),(29,'Raven','2016-11-22 09:49:40','2016-11-22 09:49:40'),(30,'BigTables','2016-11-22 09:49:40','2016-11-22 09:49:40'),(31,'Redis','2016-11-22 09:49:40','2016-11-22 09:49:40'),(32,'Photoshop','2016-11-22 09:49:40','2016-11-22 09:49:40'),(33,'Illustrator','2016-11-22 09:49:40','2016-11-22 09:49:40'),(34,'CakePHP','2016-11-22 09:49:40','2016-11-22 09:49:40'),(35,'Wordpress','2016-11-22 09:49:40','2016-11-22 09:49:40'),(36,'Drupal','2016-11-22 09:49:40','2016-11-22 09:49:40'),(37,'C#','2016-11-22 09:49:40','2016-11-22 09:49:40'),(38,'Titanium','2016-11-22 09:49:40','2016-11-22 09:49:40'),(39,'Ionic','2016-11-22 09:49:40','2016-11-22 09:49:40'),(40,'React native','2016-11-22 09:49:40','2016-11-22 09:49:40'),(41,'React.js','2016-11-22 09:49:40','2016-11-22 09:49:40'),(42,'Clojure','2016-11-22 09:49:40','2016-11-22 09:49:40'),(43,'Scala','2016-11-22 09:49:40','2016-11-22 09:49:40'),(44,'Elastic search','2016-11-22 09:49:40','2016-11-22 09:49:40'),(45,'Kibbana','2016-11-22 09:49:40','2016-11-22 09:49:40'),(46,'ASM','2016-11-22 09:49:40','2016-11-22 09:49:40'),(47,'Cobol','2016-11-22 09:49:40','2016-11-22 09:49:40'),(48,'Redmine','2016-11-22 09:49:40','2016-11-22 09:49:40'),(49,'JIRA','2016-11-22 09:49:40','2016-11-22 09:49:40'),(50,'Magento','2016-11-22 09:49:40','2016-11-22 09:49:40'),(51,'Prestashop','2016-11-22 09:49:40','2016-11-22 09:49:40'),(52,'Codeigniter','2016-11-22 09:49:40','2016-11-22 09:49:40'),(57,'AWS JavaScript','2016-11-22 09:49:40','2016-11-22 09:49:40'),(58,'ActionScript','2016-11-22 09:49:40','2016-11-22 09:49:40'),(59,'Akka','2016-11-22 09:49:40','2016-11-22 09:49:40'),(60,'Angular.dart','2016-11-22 09:49:40','2016-11-22 09:49:40'),(61,'Ansible','2016-11-22 09:49:40','2016-11-22 09:49:40'),(62,'Appcelerator Titanium','2016-11-22 09:49:40','2016-11-22 09:49:40'),(63,'AppleScript','2016-11-22 09:49:40','2016-11-22 09:49:40'),(64,'Arduino','2016-11-22 09:49:40','2016-11-22 09:49:40'),(65,'Bash','2016-11-22 09:49:40','2016-11-22 09:49:40'),(66,'Boost','2016-11-22 09:49:40','2016-11-22 09:49:40'),(67,'Bootstrap','2016-11-22 09:49:40','2016-11-22 09:49:40'),(68,'Bourbon','2016-11-22 09:49:40','2016-11-22 09:49:40'),(69,'C','2016-11-22 09:49:40','2016-11-22 09:49:40'),(70,'C++','2016-11-22 09:49:40','2016-11-22 09:49:40'),(71,'CMake','2016-11-22 09:49:40','2016-11-22 09:49:40'),(72,'Cappuccino','2016-11-22 09:49:40','2016-11-22 09:49:40'),(73,'Chai','2016-11-22 09:49:40','2016-11-22 09:49:40'),(74,'Chef','2016-11-22 09:49:40','2016-11-22 09:49:40'),(76,'Cocos2D','2016-11-22 09:49:40','2016-11-22 09:49:40'),(77,'Cocos2D-X','2016-11-22 09:49:40','2016-11-22 09:49:40'),(78,'Cocos3D','2016-11-22 09:49:40','2016-11-22 09:49:40'),(79,'CoffeeScript','2016-11-22 09:49:40','2016-11-22 09:49:40'),(80,'ColdFusion','2016-11-22 09:49:40','2016-11-22 09:49:40'),(81,'Common','2016-11-22 09:49:40','2016-11-22 09:49:40'),(82,'Lisp','2016-11-22 09:49:40','2016-11-22 09:49:40'),(83,'Compass','2016-11-22 09:49:40','2016-11-22 09:49:40'),(84,'Cordova','2016-11-22 09:49:40','2016-11-22 09:49:40'),(85,'Corona','2016-11-22 09:49:40','2016-11-22 09:49:40'),(86,'CouchDB','2016-11-22 09:49:40','2016-11-22 09:49:40'),(87,'Craft','2016-11-22 09:49:40','2016-11-22 09:49:40'),(88,'D3JS','2016-11-22 09:49:40','2016-11-22 09:49:40'),(89,'Dart','2016-11-22 09:49:40','2016-11-22 09:49:40'),(90,'Docker','2016-11-22 09:49:40','2016-11-22 09:49:40'),(91,'Doctrine','2016-11-22 09:49:40','2016-11-22 09:49:40'),(92,'Dojo','2016-11-22 09:49:40','2016-11-22 09:49:40'),(93,'Elixir','2016-11-22 09:49:40','2016-11-22 09:49:40'),(94,'Emacs','2016-11-22 09:49:40','2016-11-22 09:49:40'),(96,'EmberJS','2016-11-22 09:49:40','2016-11-22 09:49:40'),(97,'Emmet','2016-11-22 09:49:40','2016-11-22 09:49:40'),(98,'Erlang','2016-11-22 09:49:40','2016-11-22 09:49:40'),(99,'Express','2016-11-22 09:49:40','2016-11-22 09:49:40'),(100,'ExpressionEngine','2016-11-22 09:49:40','2016-11-22 09:49:40'),(101,'ExtJS','2016-11-22 09:49:40','2016-11-22 09:49:40'),(102,'Flask','2016-11-22 09:49:40','2016-11-22 09:49:40'),(103,'Foundation','2016-11-22 09:49:40','2016-11-22 09:49:40'),(104,'GLib','2016-11-22 09:49:40','2016-11-22 09:49:40'),(105,'Go','2016-11-22 09:49:40','2016-11-22 09:49:40'),(106,'Gradle','2016-11-22 09:49:40','2016-11-22 09:49:40'),(107,'DSL','2016-11-22 09:49:40','2016-11-22 09:49:40'),(109,'Groovy','2016-11-22 09:49:40','2016-11-22 09:49:40'),(110,'API','2016-11-22 09:49:40','2016-11-22 09:49:40'),(112,'Grails','2016-11-22 09:49:40','2016-11-22 09:49:40'),(115,'JDK','2016-11-22 09:49:40','2016-11-22 09:49:40'),(116,'Grunt','2016-11-22 09:49:40','2016-11-22 09:49:40'),(117,'Gulp','2016-11-22 09:49:40','2016-11-22 09:49:40'),(118,'Haml','2016-11-22 09:49:40','2016-11-22 09:49:40'),(119,'Handlebars','2016-11-22 09:49:40','2016-11-22 09:49:40'),(120,'Haskell','2016-11-22 09:49:40','2016-11-22 09:49:40'),(121,'Jade','2016-11-22 09:49:40','2016-11-22 09:49:40'),(122,'Jasmine','2016-11-22 09:49:40','2016-11-22 09:49:40'),(123,'JEE6','2016-11-22 09:49:40','2016-11-22 09:49:40'),(124,'Java EE7','2016-11-22 09:49:40','2016-11-22 09:49:40'),(125,'Java SE6','2016-11-22 09:49:40','2016-11-22 09:49:40'),(126,'Java SE7','2016-11-22 09:49:40','2016-11-22 09:49:40'),(127,'Java SE8','2016-11-22 09:49:40','2016-11-22 09:49:40'),(128,'JavaFX','2016-11-22 09:49:40','2016-11-22 09:49:40'),(129,'Jekyll','2016-11-22 09:49:40','2016-11-22 09:49:40'),(130,'Jinja','2016-11-22 09:49:40','2016-11-22 09:49:40'),(131,'Joomla','2016-11-22 09:49:40','2016-11-22 09:49:40'),(132,'Julia','2016-11-22 09:49:40','2016-11-22 09:49:40'),(133,'KnockoutJS','2016-11-22 09:49:40','2016-11-22 09:49:40'),(134,'Kobold2D','2016-11-22 09:49:40','2016-11-22 09:49:40'),(135,'LaTeX','2016-11-22 09:49:40','2016-11-22 09:49:40'),(137,'Less','2016-11-22 09:49:40','2016-11-22 09:49:40'),(138,'Lo-Dash','2016-11-22 09:49:40','2016-11-22 09:49:40'),(139,'Lua 5.1','2016-11-22 09:49:40','2016-11-22 09:49:40'),(140,'Lua 5.2','2016-11-22 09:49:40','2016-11-22 09:49:40'),(141,'Lua 5.3','2016-11-22 09:49:40','2016-11-22 09:49:40'),(142,'MarionetteJS','2016-11-22 09:49:40','2016-11-22 09:49:40'),(143,'Markdown','2016-11-22 09:49:40','2016-11-22 09:49:40'),(144,'Meteor','2016-11-22 09:49:40','2016-11-22 09:49:40'),(145,'Mocha','2016-11-22 09:49:40','2016-11-22 09:49:40'),(146,'MomentJS','2016-11-22 09:49:40','2016-11-22 09:49:40'),(147,'MongoDB','2016-11-22 09:49:40','2016-11-22 09:49:40'),(148,'Mongoose','2016-11-22 09:49:40','2016-11-22 09:49:40'),(149,'Mono','2016-11-22 09:49:40','2016-11-22 09:49:40'),(150,'MooTools','2016-11-22 09:49:40','2016-11-22 09:49:40'),(151,'Neat','2016-11-22 09:49:40','2016-11-22 09:49:40'),(152,'Nginx','2016-11-22 09:49:40','2016-11-22 09:49:40'),(153,'NumPy','2016-11-22 09:49:40','2016-11-22 09:49:40'),(154,'OCaml','2016-11-22 09:49:40','2016-11-22 09:49:40'),(155,'OpenCV','2016-11-22 09:49:40','2016-11-22 09:49:40'),(156,'OpenGL 2','2016-11-22 09:49:40','2016-11-22 09:49:40'),(157,'OpenGL 3','2016-11-22 09:49:40','2016-11-22 09:49:40'),(158,'OpenGL 4','2016-11-22 09:49:40','2016-11-22 09:49:40'),(159,'PHPUnit','2016-11-22 09:49:40','2016-11-22 09:49:40'),(160,'Pandas','2016-11-22 09:49:40','2016-11-22 09:49:40'),(161,'Perl','2016-11-22 09:49:40','2016-11-22 09:49:40'),(162,'Phalcon','2016-11-22 09:49:40','2016-11-22 09:49:40'),(163,'PhoneGap','2016-11-22 09:49:40','2016-11-22 09:49:40'),(164,'Play','2016-11-22 09:49:40','2016-11-22 09:49:40'),(166,'Polymer.dart','2016-11-22 09:49:40','2016-11-22 09:49:40'),(167,'PrototypeJS','2016-11-22 09:49:40','2016-11-22 09:49:40'),(168,'Puppet','2016-11-22 09:49:40','2016-11-22 09:49:40'),(169,'Python 2','2016-11-22 09:49:40','2016-11-22 09:49:40'),(170,'Python 3','2016-11-22 09:49:40','2016-11-22 09:49:40'),(171,'Qt 4','2016-11-22 09:49:40','2016-11-22 09:49:40'),(172,'Qt 5','2016-11-22 09:49:40','2016-11-22 09:49:40'),(173,'Racket','2016-11-22 09:49:40','2016-11-22 09:49:40'),(174,'React','2016-11-22 09:49:40','2016-11-22 09:49:40'),(176,'RequireJS','2016-11-22 09:49:40','2016-11-22 09:49:40'),(177,'Ruby 2','2016-11-22 09:49:40','2016-11-22 09:49:40'),(178,'Ruby on Rails 3','2016-11-22 09:49:40','2016-11-22 09:49:40'),(179,'Ruby on Rails 4','2016-11-22 09:49:40','2016-11-22 09:49:40'),(180,'Ruby on Rails 5','2016-11-22 09:49:40','2016-11-22 09:49:40'),(181,'RubyMotion','2016-11-22 09:49:40','2016-11-22 09:49:40'),(182,'Rust','2016-11-22 09:49:40','2016-11-22 09:49:40'),(183,'SQLAlchemy','2016-11-22 09:49:40','2016-11-22 09:49:40'),(184,'SQLite','2016-11-22 09:49:40','2016-11-22 09:49:40'),(185,'SVG','2016-11-22 09:49:40','2016-11-22 09:49:40'),(186,'SailsJS','2016-11-22 09:49:40','2016-11-22 09:49:40'),(187,'SaltStack','2016-11-22 09:49:40','2016-11-22 09:49:40'),(188,'Sass','2016-11-22 09:49:40','2016-11-22 09:49:40'),(190,'SciPy','2016-11-22 09:49:40','2016-11-22 09:49:40'),(191,'Semantic','2016-11-22 09:49:40','2016-11-22 09:49:40'),(192,'Sencha Touch','2016-11-22 09:49:40','2016-11-22 09:49:40'),(193,'Smarty','2016-11-22 09:49:40','2016-11-22 09:49:40'),(194,'Sparrow','2016-11-22 09:49:40','2016-11-22 09:49:40'),(195,'Spring Framework','2016-11-22 09:49:40','2016-11-22 09:49:40'),(196,'Statamic','2016-11-22 09:49:40','2016-11-22 09:49:40'),(197,'Stylus','2016-11-22 09:49:40','2016-11-22 09:49:40'),(198,'Susy','2016-11-22 09:49:40','2016-11-22 09:49:40'),(199,'Swift','2016-11-22 09:49:40','2016-11-22 09:49:40'),(201,'TYPO3','2016-11-22 09:49:40','2016-11-22 09:49:40'),(202,'Tcl','2016-11-22 09:49:40','2016-11-22 09:49:40'),(203,'Tornado','2016-11-22 09:49:40','2016-11-22 09:49:40'),(204,'Twig','2016-11-22 09:49:40','2016-11-22 09:49:40'),(205,'Twisted','2016-11-22 09:49:40','2016-11-22 09:49:40'),(206,'TypeScript','2016-11-22 09:49:40','2016-11-22 09:49:40'),(207,'UnderscoreJS','2016-11-22 09:49:40','2016-11-22 09:49:40'),(208,'Unity3D','2016-11-22 09:49:40','2016-11-22 09:49:40'),(209,'VMware','2016-11-22 09:49:40','2016-11-22 09:49:40'),(210,'vSphere','2016-11-22 09:49:40','2016-11-22 09:49:40'),(211,'Vagrant','2016-11-22 09:49:40','2016-11-22 09:49:40'),(212,'Vim','2016-11-22 09:49:40','2016-11-22 09:49:40'),(213,'XSLT','2016-11-22 09:49:40','2016-11-22 09:49:40'),(214,'XUL','2016-11-22 09:49:40','2016-11-22 09:49:40'),(215,'Xamarin','2016-11-22 09:49:40','2016-11-22 09:49:40'),(216,'Xojo','2016-11-22 09:49:40','2016-11-22 09:49:40'),(217,'YUI','2016-11-22 09:49:40','2016-11-22 09:49:40'),(218,'Yii','2016-11-22 09:49:40','2016-11-22 09:49:40'),(219,'Zend Framework 1','2016-11-22 09:49:40','2016-11-22 09:49:40'),(220,'Zend Framework 2','2016-11-22 09:49:40','2016-11-22 09:49:40'),(221,'Zend Framework 3','2016-11-22 09:49:40','2016-11-22 09:49:40'),(222,'ZeptoJS','2016-11-22 09:49:40','2016-11-22 09:49:40'),(223,'jQuery','2016-11-22 09:49:40','2016-11-22 09:49:40'),(224,'jQuery Mobile','2016-11-22 09:49:40','2016-11-22 09:49:40'),(225,'jQuery UI','2016-11-22 09:49:40','2016-11-22 09:49:40'),(226,'matplotlib ','2016-11-22 09:49:40','2016-11-22 09:49:40'),(227,'AMOA','2016-11-22 09:49:40','2016-11-22 09:49:40'),(228,'MOA','2016-11-22 09:49:40','2016-11-22 09:49:40'),(229,'Agile','2016-11-22 09:49:40','2016-11-22 09:49:40'),(230,'Telecom','2016-11-22 09:49:40','2016-11-22 09:49:40'),(231,'Assurance','2016-11-22 09:49:40','2016-11-22 09:49:40'),(232,'Banque','2016-11-22 09:49:40','2016-11-22 09:49:40'),(233,'Pure player','2016-11-22 09:49:40','2016-11-22 09:49:40'),(234,'E-commerce','2016-11-22 09:49:40','2016-11-22 09:49:40'),(235,'M-commerce','2016-11-22 09:49:40','2016-11-22 09:49:40'),(236,'Social networks','2016-11-22 09:49:40','2016-11-22 09:49:40'),(237,'Facebook API','2016-11-22 09:49:40','2016-11-22 09:49:40'),(238,'Google Maps API','2016-11-22 09:49:40','2016-11-22 09:49:40'),(239,'Google Matrix API','2016-11-22 09:49:40','2016-11-22 09:49:40'),(240,'Twitter API','2016-11-22 09:49:40','2016-11-22 09:49:40'),(241,'SDK','2016-11-22 09:49:40','2016-11-22 09:49:40'),(242,'Openstreet map API','2016-11-22 09:49:40','2016-11-22 09:49:40'),(243,'Open data','2016-11-22 09:49:40','2016-11-22 09:49:40'),(244,'Waze SDK','2016-11-22 09:49:40','2016-11-22 09:49:40'),(245,'ATS','2016-11-22 09:49:40','2016-11-22 09:49:40'),(246,'HTTPS','2016-11-22 09:49:40','2016-11-22 09:49:40'),(247,'TLS','2016-11-22 09:49:40','2016-11-22 09:49:40');
/*!40000 ALTER TABLE `tags` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_bank`
--

DROP TABLE IF EXISTS `user_bank`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_bank` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `country_id` int(10) unsigned NOT NULL,
  `iban` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `sift_bic` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `user_id` int(10) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_bank`
--

LOCK TABLES `user_bank` WRITE;
/*!40000 ALTER TABLE `user_bank` DISABLE KEYS */;
INSERT INTO `user_bank` VALUES (3,'ACB',2,'1234456','232',43,'2017-11-12 05:21:17','2017-11-12 05:21:17'),(4,'HELLO CORP',3,'8979978779878789789798','BLC776678',49,'2017-11-12 09:14:15','2017-11-12 09:14:15');
/*!40000 ALTER TABLE `user_bank` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_company`
--

DROP TABLE IF EXISTS `user_company`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_company` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `country_id` int(10) unsigned NOT NULL,
  `incorporation_number` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `vat_number` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `user_id` int(10) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_company`
--

LOCK TABLES `user_company` WRITE;
/*!40000 ALTER TABLE `user_company` DISABLE KEYS */;
INSERT INTO `user_company` VALUES (4,'Company',1,'123457','123',42,'2017-11-12 02:53:32','2017-11-12 02:53:32'),(5,'User2 company',3,'abc12234','345',43,'2017-11-12 05:20:59','2017-11-12 05:20:59'),(6,'CARBON COMPANY ONE WHO',3,'7878787837783FR','7378399993',49,'2017-11-12 09:14:49','2017-11-12 09:14:49');
/*!40000 ALTER TABLE `user_company` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `first_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `last_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `username` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `api_token` char(60) COLLATE utf8_unicode_ci NOT NULL,
  `phone` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `company_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `company_phone` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `address` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `postal_code` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `country_id` int(10) unsigned DEFAULT NULL,
  `city_id` int(10) unsigned DEFAULT NULL,
  `cover_path` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `avatar_path` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `website` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `linkedin_url` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `i_am` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `displaying_i_am` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `remember_token` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `customer_id` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `card_id` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `presentation` text COLLATE utf8_unicode_ci,
  `avg_stars` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `num_reviews` smallint(5) unsigned NOT NULL DEFAULT '0',
  `card_no` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_username_unique` (`username`),
  UNIQUE KEY `users_email_unique` (`email`),
  UNIQUE KEY `users_api_token_unique` (`api_token`),
  KEY `users_country_id_index` (`country_id`),
  KEY `users_city_id_index` (`city_id`)
) ENGINE=InnoDB AUTO_INCREMENT=62 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'Yann','Solomone ','user','user@example.com','$2y$10$4K3XmOg/TucV/x0zBlZeD.LcyywPcaU6OBp61YH9fQNa07uSAIWMy','aCDhl2XkFl7hMQnCajZvxvtzBtMbrlOWGjfksjd5s78bmBCHIDueYH6gr1o3','+1 111 1111','','','','',3,3,NULL,NULL,'',NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,'','2016-11-22 09:49:40','2016-11-29 22:16:22'),(5,'Ghariba','El Messaoudi','ghariba','g.el.messaoudi@gmail.com','$2y$10$tRRVngiUrkSM60AvUwKq5OINNqMoauGPWjW8rHD98seAgES/NKzxS','TqYmHAI4z7UlJ0F6HkjuK82TDHt5KJoWrwrTJcNl9TU7FiQyvjLBtIVtIFB1','0209809809',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,'','2016-11-27 00:25:09','2016-11-27 00:25:09'),(6,'G','Gg','Text@cf.com','Text@cf.com','$2y$10$ur.SorR.SD4jY.QG9e.IiuXUEKLgq9ktVjCzFACyPxHXbj8RjxtgO','56CQfesAX5DQolTnae1565VRJiJOl4TsVrDyEQmqNryydzAgS6DhiR6D7oSf','065422',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,'','2016-11-27 13:22:21','2016-11-27 13:22:21'),(7,'Mike','Soudes','mikes-soudes','cotonperle1@gmail.com','$2y$10$d.EHTSWr0OPBTDCB9GZz7eCRsVw1z5pdomzC5y.xZ1eNEqSmI5L.a','BWx4XDrq3vRIq0B02w3WKko4D7XHYcgZlrByrFJbRtB1JjYHfFDYLC5Z5ot9','0200222',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,'','2016-11-29 21:49:08','2016-11-29 21:49:08'),(8,'Leo','Mirdif','Leomirdif','Palmrewards@gmail.com','$2y$10$BXATS3vhnuCQe99dB43K9uSN.0/7Ufb1FhzzXyR4OcPr4E2x608K.','dE3xWc2I4xPsFXWxCxOXz4WUjYpcqWyg0G46IauynxGylniyYbw6zCy9Q9jF','101010101',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,'','2016-11-29 22:09:18','2016-11-29 22:09:18'),(9,'Stephan','Biot','Stephan16','stephanbiot@gmail.com','$2y$10$iLvO7b2IHpoZ4O1pNtIEGOWHIbq552Z3u7Pse1hRtRZrboSoSXQ/u','oSfh4T1yupZNirEhqh40CDQcJSzG058FmqCwomRhP1CO9BfJeORozR0Dt2fb','0200222',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'https://static.pexels.com/photos/36764/marguerite-daisy-beautiful-beauty.jpg',NULL,NULL,'0_1_2',NULL,NULL,NULL,NULL,NULL,0,0,'','2016-11-30 10:16:16','2016-11-30 10:49:27'),(10,'Sarah','M','Sarah125','ffcffcrx@gmail.com','$2y$10$8wsrR9WJuvqlj6u5QCVj/ugbqgx.RtbrpZHwlfsMNp0R7mn57u6qy','bhCsm9lvmyePdDvE5SbNDBMtxYF3lxVdCWoPMQSeB2gs60deDZcucwNtXwKp','06321367788',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'http://prestatairedigital.com/storage/syVUs8ZsG5.JPG',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,'','2016-12-03 13:03:30','2016-12-03 13:11:11'),(11,'Jan-Luc','Pasquet','Digitalventure12','app.expert.port@gmail.com','$2y$10$/mj4sfkL7FBd5I0/YnVgmu/uTKNNX1k/0FXWaxh03wGF.HfAIKdxm','oHHtjNSSf8jVB4LG5QhEoRFLfv50ssJeQhZGxrQPh3Jasi62WubMA8NlvaqR','app.expert.port@gmail.com',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,'','2016-12-04 22:47:50','2016-12-04 22:47:50'),(12,'Yves','Roux','Yves-75015','hgshs@hjhs.com','$2y$10$zDYOsw6scHyN0oNB0jRPWu.8YYvnfKbECuOGk8KjVWKZpEGMhVG1i','UkePs6RpzyM9FJcKHKDHm21Iwk86rJ4MlZi04xR6kZpzC5Qoil48gd1w6Asj','hgshs@hjhs.com',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,'','2016-12-05 10:11:52','2016-12-05 10:11:52'),(13,'Gymtech2016','','Gymtech2016','jshs@shsh.com','$2y$10$lsvpyHPEyyx1VIEzbAPQ7OwYjOcBN5ImPFf2ecs6o7qSbA2Jb0yZi','IbCaBs8oXgAs4xk0HdI2rXzODUGyyZHC1z1tMP49DSiywQz5jA25d2ZHBwwN','jshs@shsh.com',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,'','2016-12-06 16:01:34','2016-12-06 16:01:34'),(14,'Digitalexpert','','Digitalexpert09','hshs@sjsh.com','$2y$10$piebp1r/F263lLNYQ760kebHmucxRI30oJm3gR4KdrzzfIiwVhrka','peI0E3wF1GnpzAVOOJZClYdWkl9Kl4LF5hYMiGAI3HGnmg1r9WQLp7IsEt8d','hshs@sjsh.com',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,'','2016-12-07 13:30:27','2016-12-07 13:30:27'),(15,'Camille','Nenot','Camille','ghariba0507@yahoo.com','$2y$10$fAIKE9CywU0QbSHt4x0ux.zk4Y9lo76vCGD2lvrWJp2tFjRiBzDXa','gcaulSqx0NsLbyzmPET539fW66umRHDWR05DRgPXCNywZccaicIdJGBqBEAW','ghariba0507@yahoo.com','','528068219','ARY BUILDING 210 MARINA','51246',3,3,NULL,NULL,'',NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,'','2017-02-05 11:47:25','2017-02-05 12:21:56'),(16,'Digitalprestataire112','Digital','Digitalprestataire112','contact@cotonperle.com','$2y$10$yLnNAC1yrDmePDS1NWdQ6.GCV/4mGrwdyFYC8tJErSZqMof4qRHEi','H5WBA8HdsQgg4xpI8zoP7V6C8vH034Agc8Xj3PwqGxTcTqVwzEMpfTGPM7cQ','contact@cotonperle.com','1982','633184799','16 Rue Sadi Carnot, Digicode: 1428','92120',3,3,NULL,NULL,'',NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,'','2017-02-05 12:09:28','2017-02-05 12:20:47'),(17,'Ali','Raza','aliraza371','aliraza094b@gmail.com','$2y$10$r1pOe3CFCYQgnvTc48blmu5aNX86TRNog.3aASm0J54QZmIl.T6jO','l0jghovLLucBi8xh6hkjuIjXQPEQMAfImBcK2CVEU9gsCdknZEw7rnb9R6uk','3244540156',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,'','2017-08-15 14:17:02','2017-08-15 14:17:02'),(18,'asd','adad','atifjvd1@gmail.com','atifjvd1@gmail.com','$2y$10$LQnR9E9jDJxczBCHP/wxruBAwCjwbwM7CkVGU3bMy.b1M7DD2vCQe','9MTf6CnflI92U8kNz1WRGUx1mW8g4EqZhU9PwAnaY0D9IOPhZ7J8aLtxxjqJ','12312',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,'','2017-08-15 21:07:17','2017-08-15 21:07:17'),(20,'Khaled','Shehata','khaleds','khaled@thegaragelabs.com','$2y$10$BDmbZTC47h24mjfUsLIp.Oilm4G5Cl2QA85Ly8gTzGmhl8b.CjkUu','4fSw9uAObrvHa6dEFAKlrlhVBwM9dKubWxoo9XMl8mcs7C8RXLmZTmogjRs7','0787678786',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Hello all.',0,0,'','2017-08-16 14:39:59','2017-11-12 08:12:35'),(40,'hoa','dang','us','admin1@gmail.com','$2y$10$rm3ybggJurps0E58B4K/luT.JL.gV28wkEaLFtMK5WIPFGPNLm7RC','Z8rh4lBCgNw7cy9srhsIW63ZhkmDgn7CJdX38gFL3zjvRZ5m1B0tE34CvjRV','12345678',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'','1',NULL,NULL,NULL,NULL,NULL,0,0,'','2017-08-20 22:03:31','2017-08-20 22:03:31'),(42,'mr','user1','user1','user1@gmail.com','$2y$10$xfW.BasHzvMOQ7Rho1DNLeLHJ24kUG0NydcNeJ1sA.XxpYr.9zEty','8hBeeirrYGESUpOSnIg8MYT19FH7RsKwPvxrTQTRC5WQjzSlGPdYmjn7OXh0','12345',NULL,NULL,'16 Rue Sadi Carnot, Digicode: 1428',NULL,3,3,NULL,'http://52.32.112.212/storage/Ay3sk6zigH.PNG',NULL,'','2_1_0','Un investisseur|Un entrepreneur|Un prestataire',NULL,'cus_CLnr10TZraHD3I','card_1Bx6FdCFwEZn7st7NuMChVbS',NULL,5,1,'4242','2017-08-25 19:09:18','2018-02-22 04:19:11'),(43,'ms','user2','user2','hoadv106@gmail.com','$2y$10$C4S1ZJzpqiFBdNcThONGxuPXqJCnhmzZ8XpCq22vMO8B8BchyiRHy','hsn33V8GEZBFpTOshmJpkHxgTqvwi1C9yHdI58YmmwX3QgtIbni2X2m4RYJR','12345',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'http://52.32.112.212/storage/5n9SaxjqFU.jpg',NULL,'https://www.youtube.com/channel/UCIYR-dVhR2lH0vZoaocQJgw','2_0','Un investisseur|Un prestataire',NULL,'cus_CLnjL5lun412u4','card_1Bx68SCFwEZn7st7bnYneWIY','Hello, \nMy name is Hoa',0,0,'4242','2017-08-25 19:12:03','2018-02-19 04:20:17'),(44,'user3','mr','user3','user3@gmail.com','$2y$10$jF36Us3D7HJnne2yXfuhnuFqFyP4WR2oku8BcARAdxQohjQrzMLUS','3rMqj6wN0JhGgVM9Ng2ThrCCjGrXNqC0EB7pCRP7Q3sGhc3KBVzAcSixQ4j7','12345',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'','0_2',NULL,NULL,NULL,NULL,NULL,0,0,'','2017-08-25 19:51:12','2017-08-25 19:51:12'),(45,'user4','ms','user4','user4@gmail.com','$2y$10$3fItOvgPHBoW//8KYsWQuu.ehSVgvNCV3je0bz9Fk8N10e12zi8MO','qg83Qt4EEXcajLxDLAEZrLc5Lrn7l0gAGyVVmlV9RK5cgTrGoqdUphr1XCDZ','12345',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'','2_0','Un investisseur|Un prestataire',NULL,NULL,NULL,NULL,0,0,'','2017-08-25 20:01:08','2017-08-25 20:01:08'),(46,'Founder1','Stanislas','founder1','founder1@gmail.com','$2y$10$zeS8gNDxLBZS0yotsSZ5A.7SSOeniUR4u4IuQJvcRfs3SRPEAoAkC','t3LRJotrQmkS6NUnZJxBYC7BFqdAVhua6lPt0kl368BiszhrmTWflumk6m2L','09088090',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'','0_1_2','Un prestataire|Un entrepreneur|Un investisseur',NULL,NULL,NULL,NULL,0,0,'','2017-09-09 10:31:53','2017-09-09 10:31:53'),(47,'saber','ouarezzamen','rebas39','our.saber@gmail.com','$2y$10$BGo.plAIOW/7jSh/mk5FQ.aQi3w6.ogFmr5ZJjNCx8ODKwKN4TLjK','5znWmS0XuuvVE1C4d1RmlZKxl2vcQNfWLfWhXSQt9HJRl5xaqhPE5lC0BFVQ','661652138',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'','0','Un prestataire',NULL,NULL,NULL,NULL,0,0,'','2017-09-09 11:19:39','2017-09-09 11:19:39'),(48,'Someone','Else','someone-else','khaled.shehata@rueducommerce.fr','$2y$10$BDzc.FjrKlg/kDl./zuQIucUJJ7TVk1eRm3R1b6gVDh1VYlkrhV.2','8fOMJ7P5zsMdZM9wgyjB4okEGwoIy2Iu7aPocJFu2kN119YFBKkTvfrAUhPb','khaled@geniesis.co',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'','0_1_2','Un prestataire|Un entrepreneur|Un investisseur',NULL,NULL,NULL,NULL,0,0,'','2017-10-11 09:50:08','2017-10-11 09:50:08'),(49,'One','Who','onewho','onewho@gmail.com','$2y$10$uWkssPz9b33PQoCTn8ArFeaew3wrQdjJKrWukj9zKQxOs6Q6e279u','GNDsWGQb1iG6tcGABxSFNB9UZFrnugNDA9oqZ7TXxyYtijY2dQtHfSj7pAyq','123',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'http://52.32.112.212/storage/6zzISLHa9B.png',NULL,'http://google.fr','0_1_2','Un prestataire|Un entrepreneur|Un investisseur',NULL,'cus_CLxDGqsOO7EVZu','card_1BxFJRCFwEZn7st7DbNH6j5g','It\'s me.',4,1,'5556','2017-10-11 09:52:08','2018-02-20 12:17:36'),(50,'Fongoh','Tayong','echelon','fongohmartin@gmail.com','$2y$10$Tn4gl6WOfLyFrH/Put8ypO0xl9zL061/X3vtGEm8ZoPXpahscFo/m','AlEP49wJ37Ax1MkY1xWA2bNaMUnvZdT7fkO4YmgdlQqIPGxWZIals8k1XlGC','679574561',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'https://linkein.com/masters','0_1_2','Un prestataire|Un entrepreneur|Un investisseur',NULL,NULL,NULL,NULL,0,0,'','2017-10-17 14:35:58','2017-10-17 14:35:58'),(51,'user12','u','12','xbdvhqn1@gmail.com','$2y$10$sLfhS3VPXV8.9bFEPAsrvulrvopV0NazIb6WLOHpbrt0pdYjMx0Ii','1sV7cbFW37mVssxyZLyCTyeCfP1YPA9KXccc99jmzjufoODwJBPnaV32AZZt','123456789',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'http://www.abc.com','0_1','Un prestataire|Un entrepreneur',NULL,NULL,NULL,NULL,0,0,'','2017-11-12 01:31:52','2017-11-12 01:31:52'),(52,'KK','SS','kkss','khaled@geniesis.co','$2y$10$CQwhaYrEylkgirIzv8Pkm.TPh1OS1KMaCsXD9g2mYMmWPGYsjy2CC','oCyZ7U57g2tzPQ6osIrwtP2IPZi1jENaKCJbKCy3CJm134ZWDXnU1p9cQArw','0890808',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'http://52.32.112.212/storage/TM8IZtcgdy.png',NULL,'','0_1','Un prestataire|Un entrepreneur',NULL,NULL,NULL,NULL,0,0,'','2017-11-12 08:22:35','2017-11-12 08:24:16'),(53,'Niel','York','nielyork','nielyork@gail.com','$2y$10$B3XRddyIIZ2sBMCWhp/eI.xvspPYyYPnH9DwH6zP2IWpTT54Et1nq','KNYtYED7XXMwcbw96CxE5TqZrPE7hh8UwKD9Z8QgaUCjQ6eUJuHFVol0zxyF','897789987978',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'','0_1_2','Un prestataire|Un entrepreneur|Un investisseur',NULL,'cus_CMmeX7YhZEK3i1','card_1By34pCFwEZn7st7bDV50Q15','hello',0,0,'4444','2017-11-12 09:16:17','2018-02-21 19:16:28'),(54,'assassiner','Ezio','david','webstar611@gmail.com','$2y$10$KnR2p/typJ7iVKZ6gT.lHeoqpcrvd3/PcJHkoJalt8CvbLg.tcT/a','tlwdzVIhLDnxWPw0CND7v0fflRACpWW8hDr3KvfSxEyyMxaq6IG0Ja8q2JNY','webstar611@gmail.com',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'','0','Un prestataire',NULL,NULL,NULL,NULL,0,0,'','2018-01-19 10:25:47','2018-01-19 10:25:47'),(55,'creed','ezio','davide','ezio.d@mail.com','$2y$10$rRtXLrg8A7Ow0yG.XTASL.8tgTCPtxqv.Mq49Xu9oAtOzjcil8RCC','DVQ4V5ifPsg0rIiy3f0vBSLIZhgqrKE1yojccx21XGl6dWNGQiEkD7tBqUES','ezio.d@mail.com',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'','1_2','Un entrepreneur|Un investisseur',NULL,NULL,NULL,NULL,0,0,'','2018-01-19 10:32:23','2018-01-19 10:32:23'),(56,'Tom ','Ripert','tom','tomripert@gmail.com','$2y$10$QEqb55Ni1SN9SBJp9ciQE.Hf3N4Y8QK9CHaDG9Ac8iGp8Krjx/4Ty','uTcZhiQ9VBK71Tlxl8Gisua9hq8kFCvnL0aYsGEyDQ6w2ovXtDXuYHyvG1Dv','',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'http://52.32.112.212/storage/AwlUvwTHCQ.jpg',NULL,'','0','Un prestataire',NULL,'cus_CR94IIZh5pqGsm','card_1C2GmeCFwEZn7st7PGkhwbhr',NULL,0,0,'4242','2018-01-20 10:25:54','2018-03-05 10:43:08'),(57,'loulou','ss','loulou','khaled.solutions@gmail.com','$2y$10$gvGhhaH/gTB0IYzKpyyAnuV21LM2.M4tN/lJ3appXRLdMYBCAS3Ou','9ba5wF4hYHpeQWD4tMpoBbJiNSnsMQA316jTAWPoU9623zFTiHa5MgC12Fyg','088388383',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'','0_1','Un prestataire|Un entrepreneur',NULL,NULL,NULL,NULL,0,0,NULL,'2018-02-27 21:02:28','2018-02-27 21:02:28'),(58,'Alejandro','Abramson','zoro ','alejandroabramson@gmail.com','$2y$10$JATEbuEekGW9EM8Z.u9r.OEFwMmJs3Y7.zaL2pPWWD7xclI0gu6pC','fDIJdX5xr7VzzNfqnay9dD4SZVTHFxIle9eR7ZNT2AICi2jMX9DyRbLcilqC','',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'','0','Un prestataire',NULL,NULL,NULL,NULL,0,0,NULL,'2018-03-02 16:35:47','2018-03-02 16:35:47'),(59,'Tom','Ola','ola','ola@gmail.com','$2y$10$OyosGz2a.oyuMkMnj/WbqORTCTq58olgA5n4LX7V9EmXAbOwo/3ee','E0Mmp9eNHqmht6jKDG0ojQ1gGaIzTmO38egsActpUU9bdAqommcV4RztSIyk','07591683949',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'','1_2','Un entrepreneur|Un investisseur',NULL,NULL,NULL,NULL,0,0,NULL,'2018-03-04 15:16:14','2018-03-04 15:16:14'),(60,'Ola','Ola','Onewhen','tom.ripert@facebook.com','$2y$10$iQt.u0N99WPbiKV.GQJX4uy55DacolrV3jaFRiCBpKEdeXaO4nCPC','RcBEPdG1DfK2V02xTh9g0eZ6r3mid4UONXhyctrGB9kBy6pgdD5QQvozFS8N','07898909876',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'','2','Un investisseur',NULL,NULL,NULL,NULL,0,0,NULL,'2018-03-05 15:15:40','2018-03-05 15:15:40'),(61,'One ','Two','OneTwo','onetwo@gmail.com','$2y$10$4apLXQg5TLNQEc6UkKYV9.Uy.5EB56CsD0iVV3n13HIFCh3QdxCle','kWi7C2OF2kVyIHe4ItA0e88cLM7pGGaveiDAVjtPNf9rNnar4fiPiO7w3hZE','07898789987',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'http://52.32.112.212/storage/tj81r0gadQ.png',NULL,'','1','Un entrepreneur',NULL,NULL,NULL,NULL,0,0,NULL,'2018-03-07 15:38:42','2018-03-07 15:39:34');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-04-07 13:19:06
