CREATE DATABASE  IF NOT EXISTS `vegetableshop` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `vegetableshop`;
-- MySQL dump 10.13  Distrib 8.0.18, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: vegetableshop
-- ------------------------------------------------------
-- Server version	8.0.18

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
-- Table structure for table `comment`
--

DROP TABLE IF EXISTS `comment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `comment` (
  `comment_id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(45) DEFAULT NULL,
  `product_id` varchar(45) DEFAULT NULL,
  `date` date DEFAULT NULL,
  `rate_stars` varchar(45) DEFAULT NULL,
  `content` text,
  PRIMARY KEY (`comment_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comment`
--

LOCK TABLES `comment` WRITE;
/*!40000 ALTER TABLE `comment` DISABLE KEYS */;
INSERT INTO `comment` VALUES (1,'111111','2','2023-01-05','5','真香'),(2,'111111','2','2023-01-05','3','好吃一直吃'),(3,'111111','2','2023-01-05','4','太好吃拉'),(4,'111111','2','2023-01-05','3','還可以'),(5,'111111','2','2023-01-05','3','普普...家X福的比較好 不會再回購'),(6,'ggininder','2','2023-01-07','5',''),(7,'111111','2','2023-01-07','3','這個買回來都自己跑走\r<br>'),(8,'111111','2','2023-01-07','4','');
/*!40000 ALTER TABLE `comment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `counter`
--

DROP TABLE IF EXISTS `counter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `counter` (
  `count` int(11) NOT NULL,
  PRIMARY KEY (`count`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `counter`
--

LOCK TABLES `counter` WRITE;
/*!40000 ALTER TABLE `counter` DISABLE KEYS */;
INSERT INTO `counter` VALUES (22);
/*!40000 ALTER TABLE `counter` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order`
--

DROP TABLE IF EXISTS `order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order` (
  `order_id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(45) NOT NULL,
  `date` date DEFAULT NULL,
  `payment` varchar(45) DEFAULT NULL,
  `total_payment` varchar(45) DEFAULT NULL,
  `delivery` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`order_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order`
--

LOCK TABLES `order` WRITE;
/*!40000 ALTER TABLE `order` DISABLE KEYS */;
INSERT INTO `order` VALUES (1,'111111','2023-01-06','貨到付款','534','宅配'),(2,'111111','2023-01-06','貨到付款','157','宅配'),(3,'ggininder','2023-01-07','貨到付款','448','宅配'),(4,'ggininder','2023-01-07','貨到付款','1165','宅配'),(5,'111111','2023-01-07','Line Pay','224','7-11取貨'),(6,'111111','2023-01-07','貨到付款','281','宅配'),(7,'111111','2023-01-07','貨到付款','119','宅配');
/*!40000 ALTER TABLE `order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_details`
--

DROP TABLE IF EXISTS `order_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_details` (
  `order_id` varchar(45) NOT NULL,
  `product_id` varchar(45) NOT NULL,
  `product_name` varchar(45) DEFAULT NULL,
  `item_quantity` varchar(45) DEFAULT NULL,
  `subtotal` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`order_id`,`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_details`
--

LOCK TABLES `order_details` WRITE;
/*!40000 ALTER TABLE `order_details` DISABLE KEYS */;
INSERT INTO `order_details` VALUES ('1','1','番茄','1','65'),('1','2','花椰菜','2','118'),('1','6','辣椒','3','291'),('2','6','辣椒','1','97'),('3','6','辣椒','4','388'),('4','1','番茄','17','1105'),('5','2','花椰菜','1','59'),('5','4','檸檬','1','8'),('5','6','辣椒','1','97'),('6','1','番茄','1','65'),('6','2','花椰菜','1','59'),('6','6','辣椒','1','97'),('7','2','花椰菜','1','59');
/*!40000 ALTER TABLE `order_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `products` (
  `product_id` int(11) NOT NULL AUTO_INCREMENT,
  `product_name` varchar(45) DEFAULT NULL,
  `subscription` varchar(45) DEFAULT NULL,
  `origin` varchar(45) DEFAULT NULL,
  `expire_time` varchar(45) DEFAULT NULL,
  `price` varchar(45) DEFAULT NULL,
  `inventory` int(11) DEFAULT '50',
  `sell_quantity` int(11) DEFAULT '0',
  `img` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products`
--

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` VALUES (1,'番茄','新鮮精選番茄，甜美多汁，富有維生素與膳食纖維','紐西蘭','冷藏3-5天','65',29,26,'images/tomato.jpg'),(2,'花椰菜','花椰菜具有標誌性的亮綠色和草本風味，為用途最廣泛的蔬菜之一','台灣','冷藏3-5天','59',43,12,'images/broccoli.jpg'),(3,'洋蔥','洋蔥具有稍微溫和的甜味，適合加入沙拉中生吃','日本','冷藏3-5天','32',49,6,'images/onion.jpg'),(4,'檸檬','新鮮手工採摘檸檬，氣味芳香，酸甜可口，適合用來製作需要強烈酸甜滋味的料理','美國','冷藏保存約可放一個月','8',48,4,'images/lemon.jpg'),(5,'黃瓜','黃瓜味道溫和，清爽爽口，富含營養價值，價格便宜','台灣','室溫保存1~2天，冷藏保存約3-5天','84',49,4,'images/cucumber.jpg'),(6,'辣椒','人工栽培辣椒，表皮光滑，形狀細長，風味鮮明清新','印度','冷藏2~3周','97',37,16,'images/chili.jpg'),(8,'魔鬼椒','辣死人不償命!!','墨西哥','2023-1-9','70',50,0,'images/chili.jpg'),(9,'其實是香蕉','就...其實是香蕉','美國','2023-1-9','40',70,0,'images/cucumber.jpg'),(10,'有手的花椰菜','有手的花椰菜，但是沒有腳，不會偷跑\r\n','台灣','2023-1-9','23',77,0,'images/broccoli.jpg'),(11,'不黃的黃瓜','奧地利進口不黃的黃瓜，非常稀少，只有20個，要買要快，售完不補!!','奧地利','冷藏可放5天','70',20,0,'images/cucumber.jpg');
/*!40000 ALTER TABLE `products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(45) DEFAULT NULL,
  `email` varchar(45) DEFAULT NULL,
  `pwd` char(16) DEFAULT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'111111','111111@gmail.com','1234'),(4,'222222','22222@gmail.com','222'),(5,'ggininder','ggininder@gmail.com','123456');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'vegetableshop'
--

--
-- Dumping routines for database 'vegetableshop'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-01-07  7:24:24
