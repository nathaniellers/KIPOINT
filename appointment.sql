-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               10.4.21-MariaDB - mariadb.org binary distribution
-- Server OS:                    Win64
-- HeidiSQL Version:             12.2.0.6576
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Dumping database structure for appointmentsystem
CREATE DATABASE IF NOT EXISTS `appointmentsystem` /*!40100 DEFAULT CHARACTER SET utf8mb4 */;
USE `appointmentsystem`;

-- Dumping structure for table appointmentsystem.barangay_info
CREATE TABLE IF NOT EXISTS `barangay_info` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `b_name` varchar(50) DEFAULT NULL,
  `city` varchar(50) DEFAULT NULL,
  `district` varchar(50) DEFAULT NULL,
  `b_logo` varchar(1000) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;

-- Data exporting was unselected.

-- Dumping structure for table appointmentsystem.blotter
CREATE TABLE IF NOT EXISTS `blotter` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date` datetime NOT NULL,
  `complainant` int(11) NOT NULL DEFAULT 0,
  `contact1` varchar(14) NOT NULL,
  `complainee` int(11) NOT NULL DEFAULT 0,
  `contact2` varchar(14) NOT NULL,
  `complaint` longtext NOT NULL,
  `incidence` longtext NOT NULL,
  `status` enum('Active','Settled') NOT NULL,
  `assist_by` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=utf8mb4;

-- Data exporting was unselected.

-- Dumping structure for table appointmentsystem.equipment
CREATE TABLE IF NOT EXISTS `equipment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `eq_name` varchar(50) NOT NULL,
  `eq_num` varchar(50) NOT NULL,
  `eq_brand` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4;

-- Data exporting was unselected.

-- Dumping structure for table appointmentsystem.equipment_reservation
CREATE TABLE IF NOT EXISTS `equipment_reservation` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `eq_id` int(11) NOT NULL DEFAULT 0,
  `eq_req` varchar(50) NOT NULL DEFAULT '0',
  `purpose` varchar(100) NOT NULL,
  `date_start` date NOT NULL,
  `date_end` date NOT NULL,
  `time_start` time NOT NULL,
  `time_end` time NOT NULL,
  `reserved_by` int(11) NOT NULL DEFAULT 0,
  `reserved_with` int(11) DEFAULT 0,
  `remarks` varchar(100) DEFAULT '0',
  `status` enum('Approved','Pending','Disapproved','Rescheduled','Cancel') DEFAULT 'Pending',
  `approved_by` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK__equipment` (`eq_id`),
  CONSTRAINT `FK__equipment` FOREIGN KEY (`eq_id`) REFERENCES `equipment` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=330 DEFAULT CHARSET=utf8mb4;

-- Data exporting was unselected.

-- Dumping structure for table appointmentsystem.position
CREATE TABLE IF NOT EXISTS `position` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pname` varchar(50) DEFAULT NULL,
  `plimit` int(11) DEFAULT NULL,
  `prank` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4;

-- Data exporting was unselected.

-- Dumping structure for table appointmentsystem.religion
CREATE TABLE IF NOT EXISTS `religion` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `religion_name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4;

-- Data exporting was unselected.

-- Dumping structure for table appointmentsystem.request
CREATE TABLE IF NOT EXISTS `request` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `resident_id` int(11) NOT NULL DEFAULT 0,
  `request` varchar(50) NOT NULL,
  `purpose` varchar(50) NOT NULL,
  `or_num` varchar(50) NOT NULL,
  `date` varchar(50) NOT NULL,
  `assist_by` int(11) NOT NULL DEFAULT 0,
  `remarks` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=59 DEFAULT CHARSET=utf8mb4;

-- Data exporting was unselected.

-- Dumping structure for table appointmentsystem.request_history
CREATE TABLE IF NOT EXISTS `request_history` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `req` varchar(50) NOT NULL,
  `details` longtext NOT NULL,
  `datetime` datetime NOT NULL,
  `process_by` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Data exporting was unselected.

-- Dumping structure for table appointmentsystem.request_requirements
CREATE TABLE IF NOT EXISTS `request_requirements` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `request` varchar(50) NOT NULL DEFAULT '0',
  `requirements` varchar(50) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4;

-- Data exporting was unselected.

-- Dumping structure for table appointmentsystem.residential_list
CREATE TABLE IF NOT EXISTS `residential_list` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fname` varchar(50) NOT NULL DEFAULT '0',
  `lname` varchar(50) NOT NULL DEFAULT '0',
  `mi` varchar(50) NOT NULL DEFAULT '0',
  `gender` enum('Male','Female') NOT NULL,
  `marital_status` enum('Single','Married','Widowed','Separated','Divorced') NOT NULL,
  `household_no` int(11) NOT NULL,
  `street` varchar(50) NOT NULL,
  `zone` enum('3','4') NOT NULL,
  `bday` date NOT NULL,
  `bplace` varchar(50) NOT NULL,
  `religion` int(11) NOT NULL,
  `occupation` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=58 DEFAULT CHARSET=utf8mb4;

-- Data exporting was unselected.

-- Dumping structure for table appointmentsystem.schedule_venue
CREATE TABLE IF NOT EXISTS `schedule_venue` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `req` varchar(50) DEFAULT NULL,
  `venue_id` int(11) NOT NULL DEFAULT 0,
  `date_start` date DEFAULT NULL,
  `date_end` date DEFAULT NULL,
  `venue_start` time NOT NULL,
  `venue_end` time NOT NULL,
  `purpose` varchar(50) NOT NULL,
  `reserved_by` varchar(50) NOT NULL,
  `remarks` varchar(50) NOT NULL DEFAULT 'None',
  `status` enum('Approved','Pending','Disapproved','Rescheduled','Cancel') DEFAULT 'Pending',
  `approved_by` varchar(50) DEFAULT 'None',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=85 DEFAULT CHARSET=utf8mb4;

-- Data exporting was unselected.

-- Dumping structure for table appointmentsystem.user
CREATE TABLE IF NOT EXISTS `user` (
  `id` tinyint(4) NOT NULL AUTO_INCREMENT,
  `firstname` varchar(50) DEFAULT NULL,
  `lastname` varchar(50) DEFAULT NULL,
  `mi` varchar(50) DEFAULT NULL,
  `username` varchar(50) DEFAULT NULL,
  `password` varchar(50) DEFAULT NULL,
  `secret_question` enum('In what city were you born?','What is the name of your favorite pet?','What high school did you attend?','What is the name of your first school?','What was the make of your first car?','What was your favorite food as a child?','Where did you meet your spouse?') DEFAULT NULL,
  `secret_answer` varchar(50) DEFAULT NULL,
  `user_type` enum('Admin','Staff','Residential') NOT NULL DEFAULT 'Admin',
  `is_deleted` tinyint(1) NOT NULL DEFAULT 0,
  `is_active` tinyint(1) NOT NULL DEFAULT 0,
  `resi_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=59 DEFAULT CHARSET=utf8mb4;

-- Data exporting was unselected.

-- Dumping structure for table appointmentsystem.user_position
CREATE TABLE IF NOT EXISTS `user_position` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fname` varchar(50) NOT NULL,
  `mname` varchar(50) NOT NULL,
  `lname` varchar(50) NOT NULL,
  `position_id` int(11) NOT NULL,
  `term_id` int(11) NOT NULL DEFAULT 0,
  `status` int(11) DEFAULT 1,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8mb4;

-- Data exporting was unselected.

-- Dumping structure for table appointmentsystem.venue
CREATE TABLE IF NOT EXISTS `venue` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `venue` varchar(50) DEFAULT NULL,
  `capacity` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4;

-- Data exporting was unselected.

-- Dumping structure for view appointmentsystem.view_blotter
-- Creating temporary table to overcome VIEW dependency errors
CREATE TABLE `view_blotter` (
	`id` INT(11) NOT NULL,
	`date` DATETIME NOT NULL,
	`complainant_id` INT(11) NULL,
	`complainant` VARCHAR(152) NULL COLLATE 'utf8mb4_general_ci',
	`contact1` VARCHAR(14) NOT NULL COLLATE 'utf8mb4_general_ci',
	`complainee_id` INT(11) NULL,
	`complainee` VARCHAR(152) NULL COLLATE 'utf8mb4_general_ci',
	`contact2` VARCHAR(14) NOT NULL COLLATE 'utf8mb4_general_ci',
	`complaint` LONGTEXT NOT NULL COLLATE 'utf8mb4_general_ci',
	`incidence` LONGTEXT NOT NULL COLLATE 'utf8mb4_general_ci',
	`status` ENUM('Active','Settled') NOT NULL COLLATE 'utf8mb4_general_ci',
	`assist_by` VARCHAR(153) NULL COLLATE 'utf8mb4_general_ci'
) ENGINE=MyISAM;

-- Dumping structure for view appointmentsystem.view_position
-- Creating temporary table to overcome VIEW dependency errors
CREATE TABLE `view_position` (
	`id` INT(11) NOT NULL,
	`position_id` INT(11) NOT NULL,
	`pname` VARCHAR(50) NULL COLLATE 'utf8mb4_general_ci',
	`plimit` INT(11) NULL,
	`lname` VARCHAR(50) NOT NULL COLLATE 'utf8mb4_general_ci',
	`fname` VARCHAR(50) NOT NULL COLLATE 'utf8mb4_general_ci',
	`mname` VARCHAR(50) NOT NULL COLLATE 'utf8mb4_general_ci',
	`term` VARCHAR(9) NULL COLLATE 'utf8mb4_general_ci',
	`ustatus` INT(11) NULL,
	`status` VARCHAR(8) NULL COLLATE 'utf8mb4_general_ci'
) ENGINE=MyISAM;

-- Dumping structure for view appointmentsystem.view_request
-- Creating temporary table to overcome VIEW dependency errors
CREATE TABLE `view_request` (
	`id` INT(11) NOT NULL,
	`resi_id` INT(11) NOT NULL,
	`Name` VARCHAR(152) NOT NULL COLLATE 'utf8mb4_general_ci',
	`request` VARCHAR(50) NOT NULL COLLATE 'utf8mb4_general_ci',
	`purpose` VARCHAR(50) NOT NULL COLLATE 'utf8mb4_general_ci',
	`or_num` VARCHAR(50) NOT NULL COLLATE 'utf8mb4_general_ci',
	`date` VARCHAR(50) NOT NULL COLLATE 'utf8mb4_general_ci',
	`remarks` VARCHAR(50) NOT NULL COLLATE 'utf8mb4_general_ci',
	`assist_by` VARCHAR(101) NULL COLLATE 'utf8mb4_general_ci'
) ENGINE=MyISAM;

-- Dumping structure for view appointmentsystem.view_request_history
-- Creating temporary table to overcome VIEW dependency errors
CREATE TABLE `view_request_history` (
	`id` INT(11) NOT NULL,
	`req` VARCHAR(50) NOT NULL COLLATE 'utf8mb4_general_ci',
	`details` LONGTEXT NOT NULL COLLATE 'utf8mb4_general_ci',
	`datetime` DATETIME NOT NULL,
	`process_by` VARCHAR(101) NULL COLLATE 'utf8mb4_general_ci'
) ENGINE=MyISAM;

-- Dumping structure for view appointmentsystem.view_reservation
-- Creating temporary table to overcome VIEW dependency errors
CREATE TABLE `view_reservation` (
	`id` INT(11) NOT NULL,
	`eq_id` INT(11) NOT NULL,
	`eq_name` VARCHAR(50) NOT NULL COLLATE 'utf8mb4_general_ci',
	`eq_num` VARCHAR(50) NOT NULL COLLATE 'utf8mb4_general_ci',
	`eq_brand` VARCHAR(50) NOT NULL COLLATE 'utf8mb4_general_ci',
	`eq_req` VARCHAR(50) NOT NULL COLLATE 'utf8mb4_general_ci',
	`purpose` VARCHAR(100) NOT NULL COLLATE 'utf8mb4_general_ci',
	`date_start` VARCHAR(10) NULL COLLATE 'utf8mb4_general_ci',
	`date_end` VARCHAR(10) NULL COLLATE 'utf8mb4_general_ci',
	`t_start` VARCHAR(8) NULL COLLATE 'utf8mb4_general_ci',
	`t_end` VARCHAR(8) NULL COLLATE 'utf8mb4_general_ci',
	`time_start` TIME NOT NULL,
	`time_end` TIME NOT NULL,
	`reserved_by_id` INT(11) NOT NULL,
	`reserved_by` VARCHAR(152) NOT NULL COLLATE 'utf8mb4_general_ci',
	`status` ENUM('Approved','Pending','Disapproved','Rescheduled','Cancel') NULL COLLATE 'utf8mb4_general_ci',
	`remarks` VARCHAR(100) NULL COLLATE 'utf8mb4_general_ci',
	`reserved_with` INT(11) NULL,
	`approved_by` VARCHAR(152) NULL COLLATE 'utf8mb4_general_ci'
) ENGINE=MyISAM;

-- Dumping structure for view appointmentsystem.view_residential
-- Creating temporary table to overcome VIEW dependency errors
CREATE TABLE `view_residential` (
	`id` INT(11) NOT NULL,
	`lname` VARCHAR(50) NOT NULL COLLATE 'utf8mb4_general_ci',
	`fname` VARCHAR(50) NOT NULL COLLATE 'utf8mb4_general_ci',
	`mi` VARCHAR(50) NOT NULL COLLATE 'utf8mb4_general_ci',
	`gender` ENUM('Male','Female') NOT NULL COLLATE 'utf8mb4_general_ci',
	`marital_status` ENUM('Single','Married','Widowed','Separated','Divorced') NOT NULL COLLATE 'utf8mb4_general_ci',
	`household_no` INT(11) NOT NULL,
	`street` VARCHAR(50) NOT NULL COLLATE 'utf8mb4_general_ci',
	`zone` ENUM('3','4') NOT NULL COLLATE 'utf8mb4_general_ci',
	`bday` VARCHAR(10) NULL COLLATE 'utf8mb4_general_ci',
	`bplace` VARCHAR(50) NOT NULL COLLATE 'utf8mb4_general_ci',
	`religion_id` INT(11) NULL,
	`religion` VARCHAR(50) NULL COLLATE 'utf8mb4_general_ci',
	`occupation` VARCHAR(50) NOT NULL COLLATE 'utf8mb4_general_ci'
) ENGINE=MyISAM;

-- Dumping structure for view appointmentsystem.view_user
-- Creating temporary table to overcome VIEW dependency errors
CREATE TABLE `view_user` (
	`id` TINYINT(4) NOT NULL,
	`lastname` VARCHAR(50) NULL COLLATE 'utf8mb4_general_ci',
	`firstname` VARCHAR(50) NULL COLLATE 'utf8mb4_general_ci',
	`mi` VARCHAR(50) NULL COLLATE 'utf8mb4_general_ci',
	`username` VARCHAR(50) NULL COLLATE 'utf8mb4_general_ci',
	`user_type` ENUM('Admin','Staff','Residential') NOT NULL COLLATE 'utf8mb4_general_ci',
	`is_deleted` TINYINT(1) NOT NULL
) ENGINE=MyISAM;

-- Dumping structure for view appointmentsystem.view_venue
-- Creating temporary table to overcome VIEW dependency errors
CREATE TABLE `view_venue` (
	`id` INT(11) NOT NULL,
	`REQ` VARCHAR(50) NULL COLLATE 'utf8mb4_general_ci',
	`venue_id` INT(11) NOT NULL,
	`venue` VARCHAR(50) NULL COLLATE 'utf8mb4_general_ci',
	`purpose` VARCHAR(50) NOT NULL COLLATE 'utf8mb4_general_ci',
	`capacity` INT(11) NULL,
	`date_start` VARCHAR(10) NULL COLLATE 'utf8mb4_general_ci',
	`date_end` VARCHAR(10) NULL COLLATE 'utf8mb4_general_ci',
	`v_start` VARCHAR(8) NULL COLLATE 'utf8mb4_general_ci',
	`v_end` VARCHAR(8) NULL COLLATE 'utf8mb4_general_ci',
	`venue_start` TIME NOT NULL,
	`venue_end` TIME NOT NULL,
	`reserved_by_id` INT(11) NOT NULL,
	`reserved_by` VARCHAR(152) NOT NULL COLLATE 'utf8mb4_general_ci',
	`remarks` VARCHAR(50) NOT NULL COLLATE 'utf8mb4_general_ci',
	`status` ENUM('Approved','Pending','Disapproved','Rescheduled','Cancel') NULL COLLATE 'utf8mb4_general_ci',
	`approved_by` VARCHAR(152) NULL COLLATE 'utf8mb4_general_ci'
) ENGINE=MyISAM;

-- Dumping structure for table appointmentsystem.year_term
CREATE TABLE IF NOT EXISTS `year_term` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `term_start` date DEFAULT NULL,
  `term_end` date DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;

-- Data exporting was unselected.

-- Dumping structure for view appointmentsystem.view_blotter
-- Removing temporary table and create final VIEW structure
DROP TABLE IF EXISTS `view_blotter`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `view_blotter` AS SELECT 
b.id,
b.date,
(SELECT id FROM residential_list WHERE id = b.complainant) AS complainant_id,
(SELECT CONCAT(fname,' ',mi,' ',lname) FROM residential_list WHERE id = b.complainant) AS complainant,
b.contact1,
(SELECT id FROM residential_list WHERE id = b.complainee) AS complainee_id,
(SELECT CONCAT(fname,' ',mi,' ',lname) FROM residential_list WHERE id = b.complainee) AS complainee,
b.contact2,
b.complaint,
b.incidence,
b.status AS 'status',
CONCAT(u.firstname,' ',u.mi,'. ',u.lastname) AS assist_by
FROM blotter b JOIN  residential_list r ON b.complainant = r.id
JOIN user u ON b.assist_by = u.id WITH LOCAL CHECK OPTION ;

-- Dumping structure for view appointmentsystem.view_position
-- Removing temporary table and create final VIEW structure
DROP TABLE IF EXISTS `view_position`;
CREATE ALGORITHM=MERGE SQL SECURITY DEFINER VIEW `view_position` AS SELECT 
up.id,
p.id AS 'position_id',
p.pname,
p.plimit,
up.lname,
up.fname,
up.mname,
CONCAT(DATE_FORMAT(y.term_start,'%Y'),'-',DATE_FORMAT(y.term_end,'%Y')) AS term,
up.status AS 'ustatus',
CASE
 WHEN up.status = 0 THEN 'Inactive'
 WHEN y.term_start <= CURDATE() AND y.term_end >= CURDATE() THEN 'Active'
 ELSE 'Inactive'
END AS status
FROM position p JOIN user_position up ON p.id = up.position_id
JOIN year_term y ON up.term_id = y.id
ORDER BY p.prank ASC ;

-- Dumping structure for view appointmentsystem.view_request
-- Removing temporary table and create final VIEW structure
DROP TABLE IF EXISTS `view_request`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `view_request` AS SELECT
req.id,
resi.id AS resi_id,
CONCAT (resi.fname, ' ', resi.mi , ' ' , resi.lname) AS 'Name',
req.request ,
req.purpose ,
req.or_num ,
req.date ,
req.remarks ,
CONCAT(u.firstname,' ',u.lastname) AS 'assist_by'
FROM request req JOIN residential_list resi ON  req.resident_id =resi.id
JOIN user u ON u.id = req.assist_by ;

-- Dumping structure for view appointmentsystem.view_request_history
-- Removing temporary table and create final VIEW structure
DROP TABLE IF EXISTS `view_request_history`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `view_request_history` AS SELECT 
rh.id,
rh.req,
rh.details,
rh.datetime,
CONCAT(u.firstname,' ',u.lastname) AS 'process_by'
FROM request_history rh JOIN schedule_venue sv ON rh.req = sv.req
JOIN equipment_reservation er ON rh.req = er.eq_req
JOIN user u ON rh.process_by = u.id ;

-- Dumping structure for view appointmentsystem.view_reservation
-- Removing temporary table and create final VIEW structure
DROP TABLE IF EXISTS `view_reservation`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `view_reservation` AS SELECT 
er.id,
er.eq_id,
e.eq_name,
e.eq_num,
e.eq_brand,
er.eq_req,
er.purpose,
DATE_FORMAT(er.date_start,'%Y-%m-%d') AS 'date_start',
DATE_FORMAT(er.date_end,'%Y-%m-%d') AS 'date_end',
TIME_FORMAT (er.time_start,   "%h:%i %p")AS t_start,
TIME_FORMAT (er.time_end,   "%h:%i %p")AS t_end, 
er.time_start ,
er.time_end,
r.id AS 'reserved_by_id',
CONCAT (r.fname, ' ', r.mi , ' ' , r.lname) AS 'reserved_by',
er.`status`,
er.remarks,
er.reserved_with,
CONCAT (u.firstname, ' ', u.mi , ' ' , u.lastname) AS 'approved_by'
FROM equipment_reservation er JOIN equipment e ON er.eq_id = e.id 
JOIN residential_list r ON r.id = er.reserved_by 
LEFT JOIN user u ON er.approved_by = u.id ;

-- Dumping structure for view appointmentsystem.view_residential
-- Removing temporary table and create final VIEW structure
DROP TABLE IF EXISTS `view_residential`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `view_residential` AS SELECT
r.id ,
r.lname ,
r.fname ,
r.mi ,
r.gender ,
r.marital_status,
r.household_no ,
r.street ,
r.zone AS 'zone',
DATE_FORMAT(r.bday,'%Y-%m-%d') as bday,
r.bplace ,
re.id AS religion_id,
re.religion_name AS religion,
r.occupation 
FROM residential_list r LEFT JOIN religion re ON r.religion = re.id ;

-- Dumping structure for view appointmentsystem.view_user
-- Removing temporary table and create final VIEW structure
DROP TABLE IF EXISTS `view_user`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `view_user` AS SELECT 
id,
lastname ,
firstname,
mi,
username,
user_type,
is_deleted
from user ;

-- Dumping structure for view appointmentsystem.view_venue
-- Removing temporary table and create final VIEW structure
DROP TABLE IF EXISTS `view_venue`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `view_venue` AS SELECT
s.id,
s.req AS REQ,
v.id AS venue_id,
v.venue,
s.purpose,
v.capacity,
DATE_FORMAT(s.date_start,'%Y-%m-%d') AS 'date_start',
DATE_FORMAT(s.date_end,'%Y-%m-%d') AS 'date_end',
TIME_FORMAT (s.venue_start,   "%h:%i %p")AS v_start,
TIME_FORMAT (s.venue_end,   "%h:%i %p")AS v_end,        
s.venue_start,
s.venue_end,
r.id AS 'reserved_by_id',
CONCAT (r.fname, ' ', r.mi , ' ' , r.lname) AS 'reserved_by',
s.remarks,
s.`status`,
CONCAT (u.firstname, ' ', u.mi , ' ' , u.lastname) AS 'approved_by'
FROM schedule_venue s JOIN venue v ON s.venue_id=v.id
JOIN residential_list r ON r.id = s.reserved_by
LEFT JOIN user u ON s.approved_by = u.id ;

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
