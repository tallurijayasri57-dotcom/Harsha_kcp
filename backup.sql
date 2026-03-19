-- MySQL dump 10.13  Distrib 8.0.45, for Win64 (x86_64)
--
-- Host: localhost    Database: KCP_CRK_APP
-- ------------------------------------------------------
-- Server version	8.0.45

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `match_results`
--

DROP TABLE IF EXISTS `match_results`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `match_results` (
  `id` int NOT NULL AUTO_INCREMENT,
  `winner` varchar(255) NOT NULL,
  `loser` varchar(255) NOT NULL,
  `win_type` varchar(100) NOT NULL,
  `margin` varchar(100) NOT NULL,
  `played_on` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `match_results`
--

LOCK TABLES `match_results` WRITE;
/*!40000 ALTER TABLE `match_results` DISABLE KEYS */;
INSERT INTO `match_results` VALUES (1,'KCP LIONS','KCP ROYALS','won','won by 10 wickets','10/3/2026'),(2,'KCP TIGERS','KCP ROYALS','won','won by 8 wickets','10/3/2026'),(3,'KCP TIGERS','KCP LIONS','won','won by 9 runs','11/3/2026'),(4,'KCP KINGS','KCP LIONS','won','won by 2 runs','11/3/2026'),(5,'KCP LIONS','KCP ROYALS','won','won by 7 runs','17/3/2026'),(6,'KCP LIONS','KCP KINGS','won','won by 6 runs','17/3/2026'),(7,'KCP KINGS','KCP TIGERS','won','won by 10 wickets','18/3/2026'),(8,'KCP ROYALS','KCP LIONS','won','won by 10 wickets','18/3/2026'),(9,'KCP KINGS','KCP LIONS','won','won by 13 runs','18/3/2026'),(10,'KCP KINGS','KCP LIONS','won','won by 10 wickets','18/3/2026'),(11,'KCP KINGS','KCP LIONS','won','won by 19 runs','18/3/2026');
/*!40000 ALTER TABLE `match_results` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `matches`
--

DROP TABLE IF EXISTS `matches`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `matches` (
  `id` int NOT NULL AUTO_INCREMENT,
  `bat_team_id` int DEFAULT NULL,
  `bowl_team_id` int DEFAULT NULL,
  `innings` int DEFAULT NULL,
  `total_runs` int DEFAULT '0',
  `total_wickets` int DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `bat_team_id` (`bat_team_id`),
  KEY `bowl_team_id` (`bowl_team_id`),
  CONSTRAINT `matches_ibfk_1` FOREIGN KEY (`bat_team_id`) REFERENCES `teams` (`id`),
  CONSTRAINT `matches_ibfk_2` FOREIGN KEY (`bowl_team_id`) REFERENCES `teams` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `matches`
--

LOCK TABLES `matches` WRITE;
/*!40000 ALTER TABLE `matches` DISABLE KEYS */;
/*!40000 ALTER TABLE `matches` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `player_stats`
--

DROP TABLE IF EXISTS `player_stats`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `player_stats` (
  `id` int NOT NULL AUTO_INCREMENT,
  `player_name` varchar(100) NOT NULL,
  `team_name` varchar(100) DEFAULT NULL,
  `match_date` date NOT NULL,
  `match_type` enum('bat','bowl') NOT NULL,
  `runs` int DEFAULT '0',
  `balls_faced` int DEFAULT '0',
  `fours` int DEFAULT '0',
  `sixes` int DEFAULT '0',
  `wickets` int DEFAULT '0',
  `overs_bowled` varchar(10) DEFAULT '0.0',
  `runs_conceded` int DEFAULT '0',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `player_stats`
--

LOCK TABLES `player_stats` WRITE;
/*!40000 ALTER TABLE `player_stats` DISABLE KEYS */;
INSERT INTO `player_stats` VALUES (1,'Sk Abdul','KCP KINGS','2026-03-18','bat',0,0,0,0,0,'0.0',0,'2026-03-18 04:59:54'),(2,'K Kaala','KCP KINGS','2026-03-18','bat',0,0,0,0,0,'0.0',0,'2026-03-18 04:59:54'),(3,'G Harsha','KCP KINGS','2026-03-18','bat',19,8,1,1,0,'0.0',0,'2026-03-18 04:59:54'),(4,'R.Vamsi','KCP KINGS','2026-03-18','bat',17,4,1,2,0,'0.0',0,'2026-03-18 04:59:54'),(5,'R Sai','KCP KINGS','2026-03-18','bat',0,0,0,0,0,'0.0',0,'2026-03-18 04:59:54'),(6,'K Satya','KCP KINGS','2026-03-18','bat',0,0,0,0,0,'0.0',0,'2026-03-18 04:59:54'),(7,'A Avinash','KCP LIONS','2026-03-18','bowl',0,0,0,0,0,'0.0',0,'2026-03-18 04:59:54'),(8,'T Yashwanth','KCP KINGS','2026-03-18','bat',0,0,0,0,0,'0.0',0,'2026-03-18 04:59:54'),(9,'B Bablu','KCP LIONS','2026-03-18','bowl',0,0,0,0,0,'1.0',21,'2026-03-18 04:59:54'),(10,'Ch Rakesh','KCP LIONS','2026-03-18','bowl',0,0,0,0,0,'1.0',15,'2026-03-18 04:59:54'),(11,'D Vikas','KCP LIONS','2026-03-18','bowl',0,0,0,0,0,'0.0',0,'2026-03-18 04:59:54'),(12,'L Leela','KCP LIONS','2026-03-18','bowl',0,0,0,0,0,'0.0',0,'2026-03-18 04:59:54'),(13,'M Naveen','KCP LIONS','2026-03-18','bowl',0,0,0,0,0,'0.0',0,'2026-03-18 04:59:54'),(14,'Sk Rehman','KCP LIONS','2026-03-18','bowl',0,0,0,0,0,'0.0',0,'2026-03-18 04:59:54'),(15,'MD Rahim','KCP LIONS','2026-03-18','bowl',0,0,0,0,0,'0.0',0,'2026-03-18 04:59:54'),(16,'D Prasad','KCP LIONS','2026-03-18','bowl',0,0,0,0,0,'0.0',0,'2026-03-18 04:59:54'),(17,'R Ramesh','KCP LIONS','2026-03-18','bowl',0,0,0,0,0,'0.0',0,'2026-03-18 04:59:54'),(18,'D Varun','KCP LIONS','2026-03-18','bowl',0,0,0,0,0,'0.0',0,'2026-03-18 04:59:54'),(19,'A Avinash','KCP LIONS','2026-03-18','bat',0,1,0,0,0,'0.0',0,'2026-03-18 05:00:42'),(20,'Sk Rehman','KCP LIONS','2026-03-18','bat',0,0,0,0,0,'0.0',0,'2026-03-18 05:00:42'),(21,'MD Rahim','KCP LIONS','2026-03-18','bat',0,0,0,0,0,'0.0',0,'2026-03-18 05:00:42'),(22,'M Naveen','KCP LIONS','2026-03-18','bat',0,0,0,0,0,'0.0',0,'2026-03-18 05:00:42'),(23,'B Bablu','KCP LIONS','2026-03-18','bat',14,6,2,0,0,'0.0',0,'2026-03-18 05:00:42'),(24,'Ch Rakesh','KCP LIONS','2026-03-18','bat',3,5,0,0,0,'0.0',0,'2026-03-18 05:00:42'),(25,'D Vikas','KCP LIONS','2026-03-18','bat',0,0,0,0,0,'0.0',0,'2026-03-18 05:00:42'),(26,'D Prasad','KCP LIONS','2026-03-18','bat',0,0,0,0,0,'0.0',0,'2026-03-18 05:00:42'),(27,'R Ramesh','KCP LIONS','2026-03-18','bat',0,0,0,0,0,'0.0',0,'2026-03-18 05:00:42'),(28,'D Varun','KCP LIONS','2026-03-18','bat',0,0,0,0,0,'0.0',0,'2026-03-18 05:00:42'),(29,'L Leela','KCP LIONS','2026-03-18','bat',0,0,0,0,0,'0.0',0,'2026-03-18 05:00:42'),(30,'Sk Abdul','KCP KINGS','2026-03-18','bowl',0,0,0,0,0,'0.0',0,'2026-03-18 05:00:42'),(31,'K Kaala','KCP KINGS','2026-03-18','bowl',0,0,0,0,0,'0.0',0,'2026-03-18 05:00:42'),(32,'R Sai','KCP KINGS','2026-03-18','bowl',0,0,0,0,0,'0.0',0,'2026-03-18 05:00:42'),(33,'K Satya','KCP KINGS','2026-03-18','bowl',0,0,0,0,0,'0.0',0,'2026-03-18 05:00:42'),(34,'T Yashwanth','KCP KINGS','2026-03-18','bowl',0,0,0,0,0,'0.0',0,'2026-03-18 05:00:42'),(35,'G Harsha','KCP KINGS','2026-03-18','bowl',0,0,0,0,1,'1.0',10,'2026-03-18 05:00:42'),(36,'R.Vamsi','KCP KINGS','2026-03-18','bowl',0,0,0,0,0,'1.0',7,'2026-03-18 05:00:42');
/*!40000 ALTER TABLE `player_stats` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `players`
--

DROP TABLE IF EXISTS `players`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `players` (
  `id` int NOT NULL AUTO_INCREMENT,
  `team_name` varchar(50) DEFAULT NULL,
  `player_name` varchar(50) DEFAULT NULL,
  `role` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=110 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `players`
--

LOCK TABLES `players` WRITE;
/*!40000 ALTER TABLE `players` DISABLE KEYS */;
INSERT INTO `players` VALUES (73,'KCP LIONS','A Avinash','Batsman'),(74,'KCP LIONS','B Bablu','Bowler'),(75,'KCP LIONS','Ch Rakesh','All-Rounder'),(76,'KCP LIONS','D Vikas','Wicket-Keeper'),(77,'KCP LIONS','L Leela','Batsman'),(78,'KCP LIONS','M Naveen','Bowler'),(79,'KCP LIONS','Sk Rehman','Batsman'),(80,'KCP LIONS','MD Rahim','Wicket-Keeper'),(81,'KCP LIONS','D Prasad','Bowler'),(82,'KCP LIONS','R Ramesh','Bowler'),(83,'KCP LIONS','D Varun','Batsman'),(84,'KCP ROYALS','K VRao','Batsman'),(85,'KCP ROYALS','A RRao','Batsman'),(86,'KCP ROYALS','R Annamayya','All-Rounder'),(87,'KCP ROYALS','G VRao','Bowler'),(88,'KCP ROYALS','K Pradeep','Bowler'),(89,'KCP ROYALS','K Navadeep','Wicket-Keeper'),(90,'KCP ROYALS','V Naresh','Batsman'),(91,'KCP ROYALS','G Ganesh','All-Rounder'),(92,'KCP ROYALS','D Konda','All-Rounder'),(93,'KCP ROYALS','G Ravi','Batsman'),(94,'KCP ROYALS','G NRao','Bowler'),(95,'KCP TIGERS','Sk Maabu','All-Rounder'),(96,'KCP TIGERS','T Eswar','Bowler'),(97,'KCP TIGERS','M Narendhra','Batsman'),(98,'KCP TIGERS','Ch Anil','All-Rounder'),(99,'KCP TIGERS','K Manikanta','Wicket-Keeper'),(100,'KCP TIGERS','G Nagarjuna','All-Rounder'),(101,'KCP TIGERS','R Narasimha','Bowler'),(102,'KCP TIGERS','N Lokesh','All-Rounder'),(103,'KCP TIGERS','N Chandhra','All-Rounder'),(104,'KCP TIGERS','R Tarun','Batsman'),(105,'KCP TIGERS','C Premsai','Wicket-Keeper'),(108,'KCP KINGS','G.Harsha','All-Rounder'),(109,'KCP KINGS','R.vamsi','Batsman');
/*!40000 ALTER TABLE `players` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `teams`
--

DROP TABLE IF EXISTS `teams`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `teams` (
  `id` int NOT NULL AUTO_INCREMENT,
  `team_name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `team_name` (`team_name`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `teams`
--

LOCK TABLES `teams` WRITE;
/*!40000 ALTER TABLE `teams` DISABLE KEYS */;
INSERT INTO `teams` VALUES (7,'KCP KINGS'),(10,'KCP LIONS'),(9,'KCP ROYALS'),(12,'KCP TIGERS');
/*!40000 ALTER TABLE `teams` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `upcoming_matches`
--

DROP TABLE IF EXISTS `upcoming_matches`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `upcoming_matches` (
  `id` int NOT NULL AUTO_INCREMENT,
  `team1` varchar(255) NOT NULL,
  `team2` varchar(255) NOT NULL,
  `match_date` date NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `upcoming_matches`
--

LOCK TABLES `upcoming_matches` WRITE;
/*!40000 ALTER TABLE `upcoming_matches` DISABLE KEYS */;
/*!40000 ALTER TABLE `upcoming_matches` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(50) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'admin','admin123'),(2,'player1','pass123'),(3,'player2','pass456'),(4,'test','1234'),(5,'harsha','1234'),(8,'Jaya22','Sri01'),(9,'vamsi','5656'),(10,'JAYA','1234'),(11,'ravi','1282');
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

-- Dump completed on 2026-03-19 11:14:42
