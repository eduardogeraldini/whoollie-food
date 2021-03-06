-- --------------------------------------------------------
-- Servidor:                     sql141.main-hosting.eu
-- Versão do servidor:           10.2.17-MariaDB - MariaDB Server
-- OS do Servidor:               Linux
-- HeidiSQL Versão:              10.1.0.5464
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


-- Copiando estrutura do banco de dados para u672842222_food
DROP DATABASE IF EXISTS `u672842222_food`;
CREATE DATABASE IF NOT EXISTS `u672842222_food` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `u672842222_food`;

-- Copiando estrutura para tabela u672842222_food.tbBoards
DROP TABLE IF EXISTS `tbBoards`;
CREATE TABLE IF NOT EXISTS `tbBoards` (
  `idBoard` int(11) NOT NULL AUTO_INCREMENT,
  `idCompany` int(11) NOT NULL,
  `vlBoard` text NOT NULL,
  `qtPlaces` int(11) NOT NULL,
  `isActive` tinyint(4) NOT NULL DEFAULT 1,
  `dtRegister` datetime NOT NULL DEFAULT current_timestamp(),
  `isDeleted` tinyint(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`idBoard`),
  KEY `fk_tbMesas_tbEmpresas1_idx` (`idCompany`),
  CONSTRAINT `fk_tbMesas_tbEmpresas1` FOREIGN KEY (`idCompany`) REFERENCES `tbCompanies` (`idCompany`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- Copiando dados para a tabela u672842222_food.tbBoards: ~4 rows (aproximadamente)
/*!40000 ALTER TABLE `tbBoards` DISABLE KEYS */;
REPLACE INTO `tbBoards` (`idBoard`, `idCompany`, `vlBoard`, `qtPlaces`, `isActive`, `dtRegister`, `isDeleted`) VALUES
	(1, 1, '1', 4, 1, '2019-04-13 14:55:22', 0),
	(2, 1, '', 0, 1, '2019-04-20 10:42:42', 1),
	(3, 1, '2', 4, 1, '2019-04-20 22:01:02', 0),
	(4, 1, '', 0, 1, '2019-04-23 01:02:18', 1);
/*!40000 ALTER TABLE `tbBoards` ENABLE KEYS */;

-- Copiando estrutura para tabela u672842222_food.tbCompanies
DROP TABLE IF EXISTS `tbCompanies`;
CREATE TABLE IF NOT EXISTS `tbCompanies` (
  `idCompany` int(11) NOT NULL AUTO_INCREMENT,
  `desName` varchar(60) NOT NULL,
  `desCNPJ` varchar(15) NOT NULL,
  `desChannel` varchar(45) NOT NULL,
  `isActive` tinyint(4) NOT NULL DEFAULT 1,
  `dtRegister` datetime NOT NULL DEFAULT current_timestamp(),
  `isDeleted` tinyint(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`idCompany`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- Copiando dados para a tabela u672842222_food.tbCompanies: ~1 rows (aproximadamente)
/*!40000 ALTER TABLE `tbCompanies` DISABLE KEYS */;
REPLACE INTO `tbCompanies` (`idCompany`, `desName`, `desCNPJ`, `desChannel`, `isActive`, `dtRegister`, `isDeleted`) VALUES
	(1, 'Whoollie Services - ME', '147258369147257', 'whoollie', 1, '2019-04-01 21:43:30', 0);
/*!40000 ALTER TABLE `tbCompanies` ENABLE KEYS */;

-- Copiando estrutura para tabela u672842222_food.tbDepartments
DROP TABLE IF EXISTS `tbDepartments`;
CREATE TABLE IF NOT EXISTS `tbDepartments` (
  `idDepartment` int(11) NOT NULL AUTO_INCREMENT,
  `idCompany` int(11) NOT NULL,
  `desName` varchar(45) NOT NULL,
  `dtRegister` datetime NOT NULL DEFAULT current_timestamp(),
  `isDeleted` tinyint(4) NOT NULL DEFAULT 0,
  `isActive` tinyint(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`idDepartment`),
  KEY `fk_tbDepartamentos_tbEmpresas1_idx` (`idCompany`),
  CONSTRAINT `fk_tbDepartamentos_tbEmpresas1` FOREIGN KEY (`idCompany`) REFERENCES `tbCompanies` (`idCompany`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- Copiando dados para a tabela u672842222_food.tbDepartments: ~1 rows (aproximadamente)
/*!40000 ALTER TABLE `tbDepartments` DISABLE KEYS */;
REPLACE INTO `tbDepartments` (`idDepartment`, `idCompany`, `desName`, `dtRegister`, `isDeleted`, `isActive`) VALUES
	(1, 1, 'TI', '2019-04-01 21:43:39', 0, 1);
/*!40000 ALTER TABLE `tbDepartments` ENABLE KEYS */;

-- Copiando estrutura para tabela u672842222_food.tbDevices
DROP TABLE IF EXISTS `tbDevices`;
CREATE TABLE IF NOT EXISTS `tbDevices` (
  `idDevice` int(11) NOT NULL AUTO_INCREMENT,
  `idCompany` int(11) NOT NULL,
  `idBoard` int(11) NOT NULL,
  `desName` text NOT NULL,
  `desLogin` text NOT NULL,
  `desPassword` text NOT NULL,
  `isActive` tinyint(4) NOT NULL DEFAULT 1,
  `dtRegister` datetime NOT NULL DEFAULT current_timestamp(),
  `isDeleted` tinyint(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`idDevice`),
  KEY `FK1_companys` (`idCompany`),
  KEY `FK2_boards` (`idBoard`),
  CONSTRAINT `FK1_companys` FOREIGN KEY (`idCompany`) REFERENCES `tbCompanies` (`idCompany`),
  CONSTRAINT `FK2_boards` FOREIGN KEY (`idBoard`) REFERENCES `tbBoards` (`idBoard`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- Copiando dados para a tabela u672842222_food.tbDevices: ~1 rows (aproximadamente)
/*!40000 ALTER TABLE `tbDevices` DISABLE KEYS */;
REPLACE INTO `tbDevices` (`idDevice`, `idCompany`, `idBoard`, `desName`, `desLogin`, `desPassword`, `isActive`, `dtRegister`, `isDeleted`) VALUES
	(1, 1, 1, 'Ipad - 01', 'ipad01', '40bd001563085fc35165329ea1ff5c5ecbdbbeef', 1, '2019-04-24 22:03:43', 0);
/*!40000 ALTER TABLE `tbDevices` ENABLE KEYS */;

-- Copiando estrutura para tabela u672842222_food.tbEmployees
DROP TABLE IF EXISTS `tbEmployees`;
CREATE TABLE IF NOT EXISTS `tbEmployees` (
  `idEmployee` int(11) NOT NULL AUTO_INCREMENT,
  `idCompany` int(11) NOT NULL,
  `idDepartment` int(11) NOT NULL,
  `idUser` int(11) DEFAULT NULL,
  `desName` varchar(100) NOT NULL,
  `desCPF` varchar(11) NOT NULL,
  `dtBirth` date NOT NULL,
  `isActive` tinyint(4) NOT NULL DEFAULT 1,
  `dtRegister` datetime NOT NULL DEFAULT current_timestamp(),
  `isDeleted` tinyint(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`idEmployee`),
  KEY `fk_tbFuncionarios_tbDepartamentos1_idx` (`idDepartment`),
  KEY `fk_tbFuncionarios_tbUsuarios1_idx` (`idUser`),
  KEY `fkEtbEmployees_tbCompanies1_idx` (`idCompany`),
  CONSTRAINT `fkEtbEmployees_tbCompanies1` FOREIGN KEY (`idCompany`) REFERENCES `tbCompanies` (`idCompany`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_tbFuncionarios_tbDepartamentos1` FOREIGN KEY (`idDepartment`) REFERENCES `tbDepartments` (`idDepartment`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_tbFuncionarios_tbUsuarios1` FOREIGN KEY (`idUser`) REFERENCES `tbUsers` (`idUser`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;

-- Copiando dados para a tabela u672842222_food.tbEmployees: ~10 rows (aproximadamente)
/*!40000 ALTER TABLE `tbEmployees` DISABLE KEYS */;
REPLACE INTO `tbEmployees` (`idEmployee`, `idCompany`, `idDepartment`, `idUser`, `desName`, `desCPF`, `dtBirth`, `isActive`, `dtRegister`, `isDeleted`) VALUES
	(1, 1, 1, 1, 'Matheus1', '47169948800', '1999-03-01', 1, '2019-04-01 21:43:56', 0),
	(10, 1, 1, 18, 'Eduardo12', '44694640827', '1996-12-05', 1, '2019-04-04 13:57:00', 0),
	(11, 1, 1, 19, 'Neli', '34567890', '4567-03-12', 0, '2019-04-04 17:35:09', 0),
	(12, 1, 1, 20, 'dsdasd', '342423', '1233-03-12', 1, '2019-04-04 20:45:25', 0),
	(13, 1, 1, 21, 'Funcionario', '45678', '6777-05-04', 1, '2019-04-05 11:32:53', 0),
	(16, 1, 1, 24, 'fxgfcg64654646465464564', '23123123', '1222-12-12', 0, '2019-04-06 08:27:52', 1),
	(17, 1, 1, 25, 'Everaldo', '1234567', '4555-03-12', 1, '2019-04-06 09:02:46', 1),
	(18, 1, 1, 26, 'czxcklj', '12345', '5666-04-23', 1, '2019-04-10 20:47:51', 0),
	(19, 1, 1, 27, 'Marlon Englemam', '03979255589', '1996-02-11', 1, '2019-04-18 02:51:58', 0),
	(20, 1, 1, 28, 'Marlonin', '7868767', '3333-03-31', 1, '2019-04-26 23:59:37', 0);
/*!40000 ALTER TABLE `tbEmployees` ENABLE KEYS */;

-- Copiando estrutura para tabela u672842222_food.tbIngredients
DROP TABLE IF EXISTS `tbIngredients`;
CREATE TABLE IF NOT EXISTS `tbIngredients` (
  `idIngredient` int(11) NOT NULL AUTO_INCREMENT,
  `idCompany` int(11) NOT NULL,
  `desName` varchar(80) NOT NULL,
  `vlUnity` decimal(8,2) NOT NULL,
  `isActive` tinyint(4) NOT NULL DEFAULT 1,
  `dtRegister` datetime NOT NULL DEFAULT current_timestamp(),
  `isDeleted` tinyint(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`idIngredient`),
  KEY `FK1_Ingredientes_company` (`idCompany`),
  CONSTRAINT `FK1_Ingredientes_company` FOREIGN KEY (`idCompany`) REFERENCES `tbCompanies` (`idCompany`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- Copiando dados para a tabela u672842222_food.tbIngredients: ~3 rows (aproximadamente)
/*!40000 ALTER TABLE `tbIngredients` DISABLE KEYS */;
REPLACE INTO `tbIngredients` (`idIngredient`, `idCompany`, `desName`, `vlUnity`, `isActive`, `dtRegister`, `isDeleted`) VALUES
	(1, 1, 'teste', 2.00, 1, '2019-04-24 21:55:44', 1),
	(2, 1, 'teste', 1.00, 1, '2019-04-24 23:19:35', 1),
	(3, 1, 'teste2', 1.34, 1, '2019-04-24 23:19:59', 1);
/*!40000 ALTER TABLE `tbIngredients` ENABLE KEYS */;

-- Copiando estrutura para tabela u672842222_food.tbIngredientsProducts
DROP TABLE IF EXISTS `tbIngredientsProducts`;
CREATE TABLE IF NOT EXISTS `tbIngredientsProducts` (
  `idIngredientProduct` int(11) NOT NULL AUTO_INCREMENT,
  `idProduct` int(11) NOT NULL,
  `idIngredient` int(11) NOT NULL,
  `idMeasurement` int(11) NOT NULL,
  `qtIngredient` int(11) NOT NULL DEFAULT 1,
  PRIMARY KEY (`idIngredientProduct`),
  KEY `FK1_ingredient_product_product` (`idProduct`),
  KEY `FK2_ingredient_product_ingredient` (`idIngredient`),
  KEY `FK3_ingredient_measurement_ingredient` (`idMeasurement`),
  CONSTRAINT `FK1_ingredient_product_product` FOREIGN KEY (`idProduct`) REFERENCES `tbProducts` (`idProduct`),
  CONSTRAINT `FK2_ingredient_product_ingredient` FOREIGN KEY (`idIngredient`) REFERENCES `tbIngredients` (`idIngredient`),
  CONSTRAINT `FK3_ingredient_measurement_ingredient` FOREIGN KEY (`idMeasurement`) REFERENCES `tbMeasurements` (`idMeasurement`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Copiando dados para a tabela u672842222_food.tbIngredientsProducts: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `tbIngredientsProducts` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbIngredientsProducts` ENABLE KEYS */;

-- Copiando estrutura para tabela u672842222_food.tbMeasurements
DROP TABLE IF EXISTS `tbMeasurements`;
CREATE TABLE IF NOT EXISTS `tbMeasurements` (
  `idMeasurement` int(11) NOT NULL AUTO_INCREMENT,
  `desName` varchar(20) NOT NULL,
  `desShort` varchar(5) NOT NULL,
  PRIMARY KEY (`idMeasurement`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

-- Copiando dados para a tabela u672842222_food.tbMeasurements: ~8 rows (aproximadamente)
/*!40000 ALTER TABLE `tbMeasurements` DISABLE KEYS */;
REPLACE INTO `tbMeasurements` (`idMeasurement`, `desName`, `desShort`) VALUES
	(1, 'Unidade', 'un'),
	(2, 'Grama', 'gr'),
	(3, 'Kilograma', 'kg'),
	(4, 'Litro', 'lt'),
	(5, 'Mililitro', 'mlt'),
	(6, 'Copo', 'cp'),
	(7, 'Colher', 'cl'),
	(8, 'Xícara', 'xc');
/*!40000 ALTER TABLE `tbMeasurements` ENABLE KEYS */;

-- Copiando estrutura para tabela u672842222_food.tbOrders
DROP TABLE IF EXISTS `tbOrders`;
CREATE TABLE IF NOT EXISTS `tbOrders` (
  `idOrder` int(11) NOT NULL AUTO_INCREMENT,
  `idCompany` int(11) NOT NULL,
  `idDevice` int(11) NOT NULL,
  `idBoard` int(11) NOT NULL,
  `desName` varchar(50) NOT NULL,
  `vlDiscount` decimal(3,1) DEFAULT 0.0,
  `vlStatus` int(11) DEFAULT 0,
  `dtRegister` datetime NOT NULL DEFAULT current_timestamp(),
  `isDeleted` tinyint(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`idOrder`),
  KEY `fk_tbComandas_tbEmpresas1_idx` (`idCompany`),
  KEY `fk_tbComandas_tbMesas1_idx` (`idBoard`),
  KEY `fk_tbComandas_tbFuncionarios1_idx` (`idDevice`) USING BTREE,
  CONSTRAINT `fk_tbComandas_tbEmpresas1` FOREIGN KEY (`idCompany`) REFERENCES `tbCompanies` (`idCompany`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_tbComandas_tbFuncionarios1` FOREIGN KEY (`idDevice`) REFERENCES `tbDevices` (`idDevice`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_tbComandas_tbMesas1` FOREIGN KEY (`idBoard`) REFERENCES `tbBoards` (`idBoard`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=130 DEFAULT CHARSET=utf8;

-- Copiando dados para a tabela u672842222_food.tbOrders: ~129 rows (aproximadamente)
/*!40000 ALTER TABLE `tbOrders` DISABLE KEYS */;
REPLACE INTO `tbOrders` (`idOrder`, `idCompany`, `idDevice`, `idBoard`, `desName`, `vlDiscount`, `vlStatus`, `dtRegister`, `isDeleted`) VALUES
	(1, 1, 2, 1, 'Marlon', 0.0, 0, '2019-04-23 00:39:40', 0),
	(2, 1, 2, 1, 'Marlon', 0.0, 1, '2019-04-23 00:44:32', 0),
	(3, 1, 2, 1, 'Marlon', 0.0, 0, '2019-04-23 00:54:26', 0),
	(4, 1, 2, 1, 'Marlon', 0.0, 0, '2019-04-23 01:03:10', 0),
	(5, 1, 2, 1, 'Marlon', 0.0, 0, '2019-04-23 04:04:07', 0),
	(6, 1, 2, 1, 'Marlon', 0.0, 0, '2019-04-23 04:16:13', 0),
	(7, 1, 2, 1, 'Marlon', 0.0, 0, '2019-04-23 04:28:07', 0),
	(8, 1, 2, 1, 'Marlon', 0.0, 0, '2019-04-23 04:45:11', 0),
	(9, 1, 2, 1, 'Marlon', 0.0, 0, '2019-04-23 04:52:28', 0),
	(10, 1, 2, 1, 'Marlon', 0.0, 0, '2019-04-23 12:03:32', 0),
	(11, 1, 2, 1, 'Marlon', 0.0, 0, '2019-04-23 12:05:29', 0),
	(12, 1, 2, 1, 'Marlon', 0.0, 0, '2019-04-23 12:30:03', 0),
	(13, 1, 2, 1, 'Marlon', 0.0, 0, '2019-04-23 13:14:07', 0),
	(14, 1, 2, 1, 'Marlon', 0.0, 0, '2019-04-23 14:11:04', 0),
	(15, 1, 2, 1, 'Marlon', 0.0, 0, '2019-04-23 15:53:39', 0),
	(16, 1, 4, 1, 'teste', 0.0, 0, '2019-04-23 16:31:46', 0),
	(17, 1, 4, 1, 'TESTE', 0.0, 0, '2019-04-23 17:41:20', 0),
	(18, 1, 2, 1, 'Marlon', 0.0, 0, '2019-04-23 22:04:08', 0),
	(19, 1, 2, 1, 'Marlon', 0.0, 0, '2019-04-23 22:24:08', 0),
	(20, 1, 2, 1, 'Marlon', 0.0, 0, '2019-04-23 22:28:59', 0),
	(21, 1, 2, 1, 'Marlon', 0.0, 0, '2019-04-23 22:29:53', 0),
	(22, 1, 2, 1, 'Marlon', 0.0, 0, '2019-04-23 22:36:38', 0),
	(23, 1, 2, 1, 'Marlon', 0.0, 0, '2019-04-23 22:39:03', 0),
	(24, 1, 2, 1, 'Marlon', 0.0, 0, '2019-04-23 22:41:05', 0),
	(25, 1, 2, 1, 'Marlon', 0.0, 0, '2019-04-23 22:46:37', 0),
	(26, 1, 2, 1, 'Marlon', 0.0, 0, '2019-04-23 22:51:20', 0),
	(27, 1, 6, 1, 'Marlon', 0.0, 0, '2019-04-23 22:52:10', 0),
	(28, 1, 2, 1, 'Marlon', 0.0, 0, '2019-04-23 22:55:35', 0),
	(29, 1, 6, 1, 'Marlon', 0.0, 0, '2019-04-23 23:21:17', 0),
	(30, 1, 2, 1, 'Marlon', 0.0, 0, '2019-04-23 23:21:46', 0),
	(31, 1, 2, 1, 'Marlon', 0.0, 0, '2019-04-23 23:34:21', 0),
	(32, 1, 2, 1, 'Marlon', 0.0, 0, '2019-04-23 23:37:32', 0),
	(33, 1, 2, 1, 'Marlon', 0.0, 0, '2019-04-23 23:38:23', 0),
	(34, 1, 2, 1, 'Marlon', 0.0, 0, '2019-04-23 23:41:42', 0),
	(35, 1, 2, 1, 'Marlon', 0.0, 0, '2019-04-23 23:51:05', 0),
	(36, 1, 2, 1, 'Marlon', 0.0, 0, '2019-04-23 23:55:53', 0),
	(37, 1, 2, 1, 'Marlon', 0.0, 0, '2019-04-24 00:03:30', 0),
	(38, 1, 2, 1, 'Marlon', 0.0, 0, '2019-04-24 00:05:16', 0),
	(39, 1, 2, 1, 'Marlon', 0.0, 0, '2019-04-24 00:07:17', 0),
	(40, 1, 2, 1, 'Marlon', 0.0, 0, '2019-04-24 00:42:36', 0),
	(41, 1, 6, 1, 'Marlon', 0.0, 0, '2019-04-24 01:15:50', 0),
	(42, 1, 6, 1, 'Marlon', 0.0, 0, '2019-04-24 01:15:51', 0),
	(43, 1, 6, 1, 'Marlon', 0.0, 0, '2019-04-24 02:06:59', 0),
	(44, 1, 6, 1, 'Marlon', 0.0, 0, '2019-04-24 02:30:28', 0),
	(45, 1, 2, 1, 'Marlon', 0.0, 0, '2019-04-24 03:28:07', 0),
	(46, 1, 2, 1, 'Marlon', 0.0, 0, '2019-04-24 03:40:01', 0),
	(47, 1, 2, 1, 'Marlon', 0.0, 0, '2019-04-24 03:43:37', 0),
	(48, 1, 2, 1, 'Marlon', 0.0, 0, '2019-04-24 04:03:25', 0),
	(49, 1, 2, 1, 'Marlon', 0.0, 0, '2019-04-24 04:04:24', 0),
	(50, 1, 2, 1, 'Marlon', 0.0, 0, '2019-04-24 04:07:35', 0),
	(51, 1, 2, 1, 'Marlon', 0.0, 0, '2019-04-24 04:08:32', 0),
	(52, 1, 2, 1, 'Marlon', 0.0, 0, '2019-04-24 04:11:39', 0),
	(53, 1, 2, 1, 'Marlon', 0.0, 0, '2019-04-24 04:16:12', 0),
	(54, 1, 2, 1, 'Marlon', 0.0, 0, '2019-04-24 04:19:16', 0),
	(55, 1, 2, 1, 'Marlon', 0.0, 0, '2019-04-24 04:35:38', 0),
	(56, 1, 2, 1, 'Marlon', 0.0, 0, '2019-04-24 04:41:42', 0),
	(57, 1, 2, 1, 'Marlon', 0.0, 0, '2019-04-24 04:46:02', 0),
	(58, 1, 6, 1, 'Marlon', 0.0, 0, '2019-04-24 10:07:53', 0),
	(59, 1, 2, 1, 'Marlon', 0.0, 0, '2019-04-24 11:39:50', 0),
	(60, 1, 6, 1, 'Marlon', 0.0, 0, '2019-04-24 12:08:37', 0),
	(61, 1, 6, 1, 'Marlon', 0.0, 0, '2019-04-24 12:27:34', 0),
	(62, 1, 6, 1, 'Marlon', 0.0, 0, '2019-04-24 13:52:41', 0),
	(63, 1, 6, 1, 'Marlon', 0.0, 0, '2019-04-24 14:25:59', 0),
	(64, 1, 2, 1, 'Marlon', 0.0, 0, '2019-04-24 16:04:03', 0),
	(65, 1, 6, 1, 'Marlon', 0.0, 0, '2019-04-24 18:47:28', 0),
	(66, 1, 6, 1, 'Marlon', 0.0, 0, '2019-04-24 18:47:29', 0),
	(67, 1, 6, 1, 'Marlon', 0.0, 0, '2019-04-24 21:01:26', 0),
	(68, 1, 2, 1, 'Marlon', 0.0, 0, '2019-04-24 21:48:21', 0),
	(69, 1, 6, 1, 'Marlon', 0.0, 0, '2019-04-24 21:54:04', 0),
	(70, 1, 1, 1, 'Marlon', 0.0, 0, '2019-04-25 11:59:45', 0),
	(71, 1, 1, 1, 'Marlon', 0.0, 0, '2019-04-25 12:01:34', 0),
	(72, 1, 1, 1, 'Marlon', 0.0, 0, '2019-04-25 12:33:19', 0),
	(73, 1, 1, 1, 'Marlon', 0.0, 0, '2019-04-25 16:39:01', 0),
	(74, 1, 1, 1, 'Marlon', 0.0, 0, '2019-04-25 16:39:45', 0),
	(75, 1, 1, 1, 'Marlon', 0.0, 0, '2019-04-25 16:42:13', 0),
	(76, 1, 1, 1, 'Marlon', 0.0, 0, '2019-04-25 16:46:13', 0),
	(77, 1, 1, 1, 'Marlon', 0.0, 0, '2019-04-25 17:32:25', 0),
	(78, 1, 1, 1, 'Marlon', 0.0, 0, '2019-04-25 17:58:59', 0),
	(79, 1, 1, 1, 'Marlon', 0.0, 0, '2019-04-25 19:13:49', 0),
	(80, 1, 1, 1, 'Marlon', 0.0, 0, '2019-04-25 21:36:15', 0),
	(81, 1, 1, 1, 'Marlon', 0.0, 0, '2019-04-25 21:55:01', 0),
	(82, 1, 1, 1, 'Marlon', 0.0, 0, '2019-04-25 22:15:10', 0),
	(83, 1, 1, 1, 'Marlon', 0.0, 0, '2019-04-25 23:08:24', 0),
	(84, 1, 1, 1, 'Marlon', 0.0, 0, '2019-04-25 23:28:46', 0),
	(85, 1, 1, 1, 'Marlon', 0.0, 0, '2019-04-25 23:34:00', 0),
	(86, 1, 1, 1, 'Marlon', 0.0, 0, '2019-04-25 23:50:02', 0),
	(87, 1, 1, 1, 'Marlon', 0.0, 0, '2019-04-26 00:04:56', 0),
	(88, 1, 1, 1, 'Marlon', 0.0, 0, '2019-04-26 01:36:39', 0),
	(89, 1, 1, 1, 'Marlon', 0.0, 0, '2019-04-26 01:42:55', 0),
	(90, 1, 1, 1, 'Marlon', 0.0, 0, '2019-04-26 01:42:56', 0),
	(91, 1, 1, 1, 'Marlon', 0.0, 0, '2019-04-26 01:43:44', 0),
	(92, 1, 1, 1, 'Marlon', 0.0, 0, '2019-04-26 01:47:56', 0),
	(93, 1, 1, 1, 'Marlon', 0.0, 0, '2019-04-26 01:55:34', 0),
	(94, 1, 1, 1, 'Marlon', 0.0, 0, '2019-04-26 02:04:43', 0),
	(95, 1, 1, 1, 'Marlon', 0.0, 0, '2019-04-26 02:15:45', 0),
	(96, 1, 1, 1, 'Marlon', 0.0, 0, '2019-04-26 02:15:45', 0),
	(97, 1, 1, 1, 'Marlon', 0.0, 0, '2019-04-26 02:23:01', 0),
	(98, 1, 1, 1, 'Marlon', 0.0, 0, '2019-04-26 02:37:23', 0),
	(99, 1, 1, 1, 'Marlon', 0.0, 0, '2019-04-26 02:38:20', 0),
	(100, 1, 1, 1, 'Marlon', 0.0, 0, '2019-04-26 02:41:43', 0),
	(101, 1, 1, 1, 'Marlon', 0.0, 0, '2019-04-26 02:48:53', 0),
	(102, 1, 1, 1, 'Marlon', 0.0, 0, '2019-04-26 03:02:15', 0),
	(103, 1, 1, 1, 'Marlon', 0.0, 0, '2019-04-26 03:18:22', 0),
	(104, 1, 1, 1, 'Marlon', 0.0, 0, '2019-04-26 10:27:56', 0),
	(105, 1, 1, 1, 'Marlon', 0.0, 0, '2019-04-26 10:27:56', 0),
	(106, 1, 1, 1, 'Marlon', 0.0, 0, '2019-04-26 11:04:30', 0),
	(107, 1, 1, 1, 'Marlon', 0.0, 0, '2019-04-26 11:21:01', 0),
	(108, 1, 1, 1, 'Marlon', 0.0, 0, '2019-04-26 13:55:27', 0),
	(109, 1, 1, 1, 'Marlon', 0.0, 0, '2019-04-26 15:58:11', 0),
	(110, 1, 1, 1, 'Marlon', 0.0, 0, '2019-04-26 19:44:03', 0),
	(111, 1, 1, 1, 'Marlon', 0.0, 0, '2019-04-26 19:46:12', 0),
	(112, 1, 1, 1, 'Marlon', 0.0, 0, '2019-04-26 20:41:19', 0),
	(113, 1, 1, 1, 'Marlon', 0.0, 0, '2019-04-26 20:41:19', 0),
	(114, 1, 1, 1, 'Marlon', 0.0, 0, '2019-04-26 21:07:53', 0),
	(115, 1, 1, 1, 'Marlon', 0.0, 0, '2019-04-26 21:51:47', 0),
	(116, 1, 1, 1, 'Marlon', 0.0, 0, '2019-04-26 22:14:08', 0),
	(117, 1, 1, 1, 'Marlon', 0.0, 0, '2019-04-26 22:35:00', 0),
	(118, 1, 1, 1, 'Marlon', 0.0, 0, '2019-04-27 00:03:51', 0),
	(119, 1, 1, 1, 'Marlon', 0.0, 0, '2019-04-27 00:47:55', 0),
	(120, 1, 1, 1, 'Marlon', 0.0, 0, '2019-04-27 01:06:42', 0),
	(121, 1, 1, 1, 'Marlon', 0.0, 0, '2019-04-27 01:08:27', 0),
	(122, 1, 1, 1, 'Marlon', 0.0, 0, '2019-04-27 01:18:39', 0),
	(123, 1, 1, 1, 'Marlon', 0.0, 0, '2019-04-27 01:22:11', 0),
	(124, 1, 1, 1, 'Marlon', 0.0, 0, '2019-04-27 03:38:38', 0),
	(125, 1, 1, 1, 'Marlon', 0.0, 0, '2019-04-27 05:13:47', 0),
	(126, 1, 1, 1, 'Marlon', 0.0, 0, '2019-04-27 05:17:27', 0),
	(127, 1, 1, 1, 'Marlon', 0.0, 0, '2019-04-27 09:37:04', 0),
	(128, 1, 1, 1, 'Marlon', 0.0, 0, '2019-04-27 11:48:41', 0),
	(129, 1, 1, 1, 'Marlon', 0.0, 0, '2019-04-27 12:48:39', 0);
/*!40000 ALTER TABLE `tbOrders` ENABLE KEYS */;

-- Copiando estrutura para tabela u672842222_food.tbPrivileges
DROP TABLE IF EXISTS `tbPrivileges`;
CREATE TABLE IF NOT EXISTS `tbPrivileges` (
  `idPrivilege` int(11) NOT NULL AUTO_INCREMENT,
  `idEmployee` int(11) NOT NULL,
  `viewProducts` int(11) NOT NULL DEFAULT 1,
  `viewOrders` int(11) NOT NULL DEFAULT 1,
  `viewBoards` int(11) NOT NULL DEFAULT 1,
  `viewMonitor` int(11) NOT NULL DEFAULT 1,
  `viewDevices` int(11) NOT NULL DEFAULT 1,
  `viewIngredients` int(11) NOT NULL DEFAULT 1,
  `viewEmployees` int(11) NOT NULL DEFAULT 1,
  `viewReports` int(11) NOT NULL DEFAULT 1,
  `viewConfigs` int(11) NOT NULL DEFAULT 1,
  PRIMARY KEY (`idPrivilege`),
  KEY `fkEtbPrivileges_tbEmployees1_idx` (`idEmployee`),
  CONSTRAINT `fkEtbPrivileges_tbEmployees1` FOREIGN KEY (`idEmployee`) REFERENCES `tbEmployees` (`idEmployee`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

-- Copiando dados para a tabela u672842222_food.tbPrivileges: ~10 rows (aproximadamente)
/*!40000 ALTER TABLE `tbPrivileges` DISABLE KEYS */;
REPLACE INTO `tbPrivileges` (`idPrivilege`, `idEmployee`, `viewProducts`, `viewOrders`, `viewBoards`, `viewMonitor`, `viewDevices`, `viewIngredients`, `viewEmployees`, `viewReports`, `viewConfigs`) VALUES
	(1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1),
	(2, 10, 1, 1, 1, 1, 1, 1, 1, 1, 0),
	(3, 11, 0, 0, 1, 1, 1, 1, 1, 0, 1),
	(4, 12, 1, 0, 1, 1, 1, 1, 0, 1, 0),
	(5, 13, 1, 1, 1, 1, 1, 1, 1, 1, 1),
	(6, 16, 0, 1, 1, 1, 1, 1, 1, 1, 1),
	(7, 17, 1, 1, 1, 1, 1, 1, 1, 1, 0),
	(8, 18, 1, 1, 1, 1, 1, 1, 0, 0, 0),
	(9, 19, 1, 1, 1, 1, 1, 1, 1, 1, 1),
	(10, 20, 1, 0, 1, 1, 1, 1, 1, 1, 1);
/*!40000 ALTER TABLE `tbPrivileges` ENABLE KEYS */;

-- Copiando estrutura para tabela u672842222_food.tbProducts
DROP TABLE IF EXISTS `tbProducts`;
CREATE TABLE IF NOT EXISTS `tbProducts` (
  `idProduct` int(11) NOT NULL AUTO_INCREMENT,
  `idCompany` int(11) NOT NULL,
  `idProductCategory` int(11) NOT NULL,
  `vlUnity` decimal(8,2) NOT NULL DEFAULT 0.00,
  `desName` varchar(45) NOT NULL,
  `desNote` varchar(50) NOT NULL,
  `desImagePath` varchar(250) DEFAULT '/res/admin/img/sem_foto.png',
  `isActive` tinyint(4) NOT NULL DEFAULT 1,
  `dtRegister` datetime NOT NULL DEFAULT current_timestamp(),
  `isDeleted` tinyint(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`idProduct`),
  KEY `fk_tbProdutos_tbCategoriasProdutos1_idx` (`idProductCategory`),
  KEY `fk_tbProdutos_tbEmpresas1_idx` (`idCompany`),
  CONSTRAINT `fk_tbProdutos_tbCategoriasProdutos1` FOREIGN KEY (`idProductCategory`) REFERENCES `tbProductsCategories` (`idProductCategory`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_tbProdutos_tbEmpresas1` FOREIGN KEY (`idCompany`) REFERENCES `tbCompanies` (`idCompany`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=66 DEFAULT CHARSET=utf8;

-- Copiando dados para a tabela u672842222_food.tbProducts: ~54 rows (aproximadamente)
/*!40000 ALTER TABLE `tbProducts` DISABLE KEYS */;
REPLACE INTO `tbProducts` (`idProduct`, `idCompany`, `idProductCategory`, `vlUnity`, `desName`, `desNote`, `desImagePath`, `isActive`, `dtRegister`, `isDeleted`) VALUES
	(12, 1, 8, 0.00, 'jhjkh', 'jkhkjhkj', '/res/uploads/products/1554344672_UseCase Diagram0.jpg', 1, '2019-04-03 23:24:32', 1),
	(13, 1, 11, 890.00, 'Diego', '20938', '/res/uploads/products/1555108931_unnamed.jpg', 1, '2019-04-03 23:27:55', 1),
	(14, 1, 8, 98.00, 'Lanche da Ma', 'kljlk', '/res/uploads/products/1555030650_images.jpg', 1, '2019-04-03 23:28:44', 1),
	(15, 1, 8, 897.00, 'djhd', 'ksaljdlkasjdklajsdklasjdklajskldjalksdjaskldjalksd', '/res/admin/img/sem_foto.png', 1, '2019-04-03 23:29:24', 1),
	(16, 1, 8, 994.69, 'czc', 'jnjknj', '/res/admin/img/sem_foto.png', 1, '2019-04-03 23:31:52', 1),
	(17, 1, 9, 14.00, 'X - Burguer', 'Big burguer, x-burguer salada especial da Vi', '/res/admin/img/sem_foto.png', 1, '2019-04-04 07:49:24', 1),
	(18, 1, 11, 70.50, 'X Burguer 2', 'X burger 2 em 1', '/res/uploads/products/1554386244_x-burguer bem feito.png', 1, '2019-04-04 10:57:24', 0),
	(19, 1, 9, 89.00, 'jkhkj', 'hkjhkjh', '/res/uploads/products/1555030500_download-2.jpeg', 1, '2019-04-04 10:58:34', 1),
	(20, 1, 8, 78.00, 'kjhjhj', 'hjhjk', '/res/admin/img/sem_foto.png', 1, '2019-04-05 19:04:20', 1),
	(21, 1, 9, 3156.00, 'Baconn', 'ajsdkj', '/res/uploads/products/1555107351_images.jpg', 0, '2019-04-12 19:15:51', 1),
	(22, 1, 10, 123.00, 'Testeeeee', 'testeett', '/res/uploads/products/1555107392_adesivo-lanchonete-lanche-hamburguer-artesanal-fast-food-hd-adesivo-food.jpg', 0, '2019-04-12 19:16:32', 1),
	(23, 1, 11, 25.00, 'X Tudo', 'teste', '/res/uploads/products/1555114808_images.jpg', 1, '2019-04-12 21:20:08', 0),
	(24, 1, 11, 20.00, 'X Salada', 'salada', '/res/uploads/products/1555114819_images.jpg', 1, '2019-04-12 21:20:19', 0),
	(25, 1, 11, 15.00, 'Teste1', 'teste1', '/res/uploads/products/1555114834_adesivo-lanchonete-lanche-hamburguer-artesanal-fast-food-hd-adesivo-food.jpg', 1, '2019-04-12 21:20:34', 1),
	(26, 1, 11, 14.00, 'Hamburguer completo', 'Completo!', '/res/uploads/products/1555114849_adesivo-lanchonete-lanche-hamburguer-artesanal-fast-food-hd-adesivo-food.jpg', 1, '2019-04-12 21:20:49', 0),
	(27, 1, 8, 12.00, 'teste4', 'teste4', '/res/admin/img/sem_foto.png', 1, '2019-04-12 21:29:57', 1),
	(28, 1, 8, 10.00, 'teste5', 'teste5', '/res/admin/img/sem_foto.png', 1, '2019-04-12 21:30:07', 1),
	(29, 1, 8, 20.00, 'teste6', 'teste6', '/res/admin/img/sem_foto.png', 1, '2019-04-12 21:30:17', 1),
	(30, 1, 8, 30.00, 'Jack Daniels', 'Daniels Jack', '/res/uploads/products/1555553780_ci-jack-daniels-old-no-7-92707d5e737cf4ac.jpeg', 1, '2019-04-18 02:16:20', 0),
	(31, 1, 8, 22.00, 'Amarula 2', 'amarula 1 litro', '/res/uploads/products/1555553861_amarula.jpg', 1, '2019-04-18 02:17:41', 0),
	(32, 1, 8, 28.00, 'Especial Alcool', 'bebida especial da casa', '/res/uploads/products/1555553886_586074.png', 1, '2019-04-18 02:18:06', 0),
	(33, 1, 8, 20.00, 'Vodka', 'vodka especial', '/res/uploads/products/1555553957_5432286_1GG.jpg', 1, '2019-04-18 02:19:17', 0),
	(34, 1, 9, 13.00, 'Ramen', 'massa ramen', '/res/uploads/products/1555554175_58931-ramen.jpg', 1, '2019-04-18 02:22:55', 0),
	(35, 1, 9, 14.00, 'Massa Italiana', 'Massa do tipo italiana', '/res/uploads/products/1555554203_222massa.jpg', 1, '2019-04-18 02:23:23', 0),
	(36, 1, 9, 11.00, 'Capa Massa', 'Massa capa especial', '/res/uploads/products/1555554230_Capa-Massa.jpg', 1, '2019-04-18 02:23:50', 0),
	(37, 1, 9, 16.00, 'Massa da casa', 'Lorem Ipsum é simplesmente uma simulação de texto ', '/res/uploads/products/1555554277_massa1.jpg', 1, '2019-04-18 02:24:24', 0),
	(38, 1, 9, 16.00, 'Vernicelli', 'Do tipo vernicelli', '/res/uploads/products/1555554367_vermicelli_upma_semiya_upma_recipe_gluten_free.jpg', 1, '2019-04-18 02:26:07', 0),
	(39, 1, 9, 18.00, 'Uppa Vernicelli', 'Vernicelli tipo 2', '/res/uploads/products/1555554410_Vermicelli upma1.JPG', 1, '2019-04-18 02:26:50', 0),
	(40, 1, 10, 22.00, 'Batata Frita', 'Porção comum de batata frita', '/res/uploads/products/1555554500_5716e77f-0da4-4b4a-b492-4064ac1f1305.jpg', 1, '2019-04-18 02:28:20', 0),
	(41, 1, 10, 24.00, 'Mandioca Frita', 'Porção de mandioca frita', '/res/uploads/products/1555554527_964494000000-Mandioca-frita.jpg', 1, '2019-04-18 02:28:48', 0),
	(42, 1, 10, 30.00, 'Batata Frita com Bacon', 'Porção de fritas com bacon', '/res/uploads/products/1555554557_porcao-de-batatas-fritas-grande-com-bancon-rechlanches-joinville.jpg', 1, '2019-04-18 02:29:17', 0),
	(43, 1, 10, 32.00, 'Dupla mista', 'Porção de dupla mista', '/res/uploads/products/1555554612_porcaoduplamistaa.png', 1, '2019-04-18 02:30:12', 0),
	(44, 1, 10, 27.00, 'Porção Torresmo', 'De torresmo especial', '/res/uploads/products/1555554684_porcao-de-torresmo.jpg', 1, '2019-04-18 02:31:24', 0),
	(45, 1, 10, 35.00, 'Porção de peixe', 'De peixe', '/res/uploads/products/1555554745_downloadpeixeporcao.jpg', 1, '2019-04-18 02:32:25', 0),
	(46, 1, 10, 17.00, 'Porção de Frios', 'Apenas frios', '/res/uploads/products/1555554804_58ef6b39-0698-49a0-bde7-0bdeac1f1e06.jpg', 1, '2019-04-18 02:33:24', 0),
	(47, 1, 10, 24.00, 'Frango a passarinho', 'Porção de frango a passarinho', '/res/uploads/products/1555554862_5716e77f-33f0-40ab-a9e0-4064ac1f1305.jpg', 1, '2019-04-18 02:34:22', 0),
	(48, 1, 12, 37.00, 'Pizza Italiana', 'Italiana apenas', '/res/uploads/products/1555554955_pizzaita.jpg', 1, '2019-04-18 02:35:55', 0),
	(49, 1, 12, 33.00, 'Morango e Chocolate', 'Morango com chocolate', '/res/uploads/products/1555554988_pizza-de-chocolate.jpg', 1, '2019-04-18 02:36:28', 0),
	(50, 1, 12, 28.00, 'Pizza de Chocolate', 'Apenas chocolate', '/res/uploads/products/1555555022_pizza-chocolate.jpg', 1, '2019-04-18 02:37:02', 0),
	(51, 1, 12, 35.00, 'Pizza de Morango', 'Com morango apenas', '/res/uploads/products/1555555052_1506701024-massa-de-pizza_616x462.jpg', 1, '2019-04-18 02:37:32', 0),
	(52, 1, 12, 31.00, 'Pizza 3 queijos', 'De 3 queijos', '/res/uploads/products/1555555086_pizza-de-3-queijos-15244.jpg', 1, '2019-04-18 02:38:06', 0),
	(53, 1, 12, 34.00, 'Pizza Requeijão', 'Com Requeijão', '/res/uploads/products/1555555131_pizzademilhoerequeijao-2.jpg', 1, '2019-04-18 02:38:52', 0),
	(54, 1, 10, 31.00, 'Mandioca e carne seca', 'Mandioca com carne seca!', '/res/uploads/products/1555555211_Mandiocacarneseca.jpg', 1, '2019-04-18 02:40:11', 0),
	(55, 1, 11, 21.00, 'Burguer Vegano', 'Com carne de soja', '/res/uploads/products/1555555331_roasted-veggie-burgers-with-carrot-ketchup-XL-RECIPE0517.jpg', 1, '2019-04-18 02:42:11', 0),
	(56, 1, 8, 5.00, 'Pitu', 'Aguardente de cana adoçada', '/res/uploads/products/1556018407_3b58de9fdf.jpg', 1, '2019-04-23 11:20:07', 0),
	(57, 1, 8, 2.00, 'Corote Blueberry', 'Coquetel alcoólico', '/res/uploads/products/1556018655_cachaca-D_NP_813501-MLB27776406155_072018-Q.jpg', 1, '2019-04-23 11:24:15', 0),
	(58, 1, 9, 30.00, 'Macarrão com Salshicha', 'Deliciosoooo!', '/res/uploads/products/1556060070_macarraocomsalsicha.jpg', 1, '2019-04-23 22:54:30', 0),
	(59, 1, 12, 25082.00, 'Produto sem foto', 'teste', '/res/admin/img/sem_foto.png', 1, '2019-04-24 01:29:23', 0),
	(60, 1, 9, 40.00, 'Macarrão Caseiro', 'Gostosooo!!', '/res/uploads/products/1556071871_receitas-de-macarrao-com-carne-moida.jpg', 1, '2019-04-24 02:11:11', 0),
	(61, 1, 11, 20.00, 'X Bacon', 'Saboroso!!', '/res/uploads/products/1556100612_receita-x-bacon.jpg', 1, '2019-04-24 10:10:12', 0),
	(62, 1, 8, 20.00, 'Suco de Laranja', 'Teste', '/res/uploads/products/1556108063_15561079556341719027630.jpg', 1, '2019-04-24 12:14:23', 1),
	(63, 1, 8, 20.00, 'Suco de Laranja', 'Teste', '/res/uploads/products/1556108071_15561079556341719027630.jpg', 1, '2019-04-24 12:14:31', 1),
	(64, 1, 10, 45.00, 'Lombo de Bacalhau', 'Bacalhau top!', '/res/uploads/products/1556114155_lombo-de-bacalhau-com-crosta-de-castanha.jpg', 1, '2019-04-24 13:55:55', 0),
	(65, 1, 12, 500.00, 'Exemplo', 'só um exemplo', '/res/uploads/products/1556235147_408ryru2vzty.jpg', 1, '2019-04-25 23:32:27', 0);
/*!40000 ALTER TABLE `tbProducts` ENABLE KEYS */;

-- Copiando estrutura para tabela u672842222_food.tbProductsCategories
DROP TABLE IF EXISTS `tbProductsCategories`;
CREATE TABLE IF NOT EXISTS `tbProductsCategories` (
  `idProductCategory` int(11) NOT NULL AUTO_INCREMENT,
  `idCompany` int(11) NOT NULL,
  `desName` varchar(45) NOT NULL,
  `desImagePath` varchar(250) DEFAULT '/res/admin/img/sem_foto.png',
  `dtRegister` datetime NOT NULL DEFAULT current_timestamp(),
  `isDeleted` tinyint(4) NOT NULL DEFAULT 0,
  `isActive` tinyint(4) NOT NULL DEFAULT 1,
  PRIMARY KEY (`idProductCategory`),
  KEY `fk_tbProductsCategories_tbCompanies1_idx` (`idCompany`),
  CONSTRAINT `fk_tbProductsCategories_tbCompanies1` FOREIGN KEY (`idCompany`) REFERENCES `tbCompanies` (`idCompany`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;

-- Copiando dados para a tabela u672842222_food.tbProductsCategories: ~6 rows (aproximadamente)
/*!40000 ALTER TABLE `tbProductsCategories` DISABLE KEYS */;
REPLACE INTO `tbProductsCategories` (`idProductCategory`, `idCompany`, `desName`, `desImagePath`, `dtRegister`, `isDeleted`, `isActive`) VALUES
	(8, 1, 'Bebidas', '/res/uploads/productsCategories/1555704572_ja-san-miguel-1274325-unsplash.jpg', '2019-04-03 19:13:57', 0, 1),
	(9, 1, 'Massas', '/res/uploads/productsCategories/1555704693_eiliv-sonas-aceron-769745-unsplash.jpg', '2019-04-03 19:14:01', 0, 1),
	(10, 1, 'Porções', '/res/uploads/productsCategories/1555704780_neonbrand-571476-unsplash.jpg', '2019-04-03 23:33:04', 0, 1),
	(11, 1, 'Lanches', '/res/uploads/productsCategories/1555704834_quentin-lagache-76503-unsplash.jpg', '2019-04-04 10:58:56', 0, 1),
	(12, 1, 'Pizzas', '/res/uploads/productsCategories/1555704848_ivan-torres-478678-unsplash.jpg', '2019-04-18 02:34:55', 0, 1),
	(13, 1, 'Teste', '/res/admin/img/sem_foto.png', '2019-04-18 18:54:29', 1, 1);
/*!40000 ALTER TABLE `tbProductsCategories` ENABLE KEYS */;

-- Copiando estrutura para tabela u672842222_food.tbRequests
DROP TABLE IF EXISTS `tbRequests`;
CREATE TABLE IF NOT EXISTS `tbRequests` (
  `idRequest` int(11) NOT NULL AUTO_INCREMENT,
  `idOrder` int(11) NOT NULL,
  `desNote` varchar(250) DEFAULT NULL,
  `vlStatus` int(11) NOT NULL DEFAULT 0,
  `dtRegister` datetime NOT NULL DEFAULT current_timestamp(),
  `isDeleted` tinyint(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`idRequest`),
  KEY `fk_tbPedidos_tbComandas_idx` (`idOrder`),
  CONSTRAINT `fk_tbPedidos_tbComandas` FOREIGN KEY (`idOrder`) REFERENCES `tbOrders` (`idOrder`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=163 DEFAULT CHARSET=utf8;

-- Copiando dados para a tabela u672842222_food.tbRequests: ~154 rows (aproximadamente)
/*!40000 ALTER TABLE `tbRequests` DISABLE KEYS */;
REPLACE INTO `tbRequests` (`idRequest`, `idOrder`, `desNote`, `vlStatus`, `dtRegister`, `isDeleted`) VALUES
	(1, 1, NULL, 1, '2019-04-23 00:42:19', 0),
	(2, 2, NULL, 1, '2019-04-23 00:45:30', 0),
	(3, 2, NULL, 1, '2019-04-23 00:49:13', 0),
	(4, 3, NULL, 1, '2019-04-23 00:55:42', 0),
	(5, 3, NULL, 1, '2019-04-23 00:57:04', 0),
	(6, 3, NULL, 1, '2019-04-23 01:00:15', 0),
	(7, 4, NULL, 1, '2019-04-23 01:06:51', 0),
	(8, 5, NULL, 1, '2019-04-23 04:13:31', 0),
	(9, 6, NULL, 1, '2019-04-23 04:17:47', 0),
	(10, 6, NULL, 1, '2019-04-23 04:25:08', 0),
	(11, 6, NULL, 1, '2019-04-23 04:25:42', 0),
	(12, 6, NULL, 1, '2019-04-23 04:27:09', 0),
	(13, 7, NULL, 1, '2019-04-23 04:28:36', 0),
	(14, 8, NULL, 1, '2019-04-23 04:46:50', 0),
	(15, 8, NULL, 1, '2019-04-23 04:47:16', 0),
	(16, 8, NULL, 1, '2019-04-23 04:48:52', 0),
	(17, 8, NULL, 1, '2019-04-23 04:50:56', 0),
	(18, 9, NULL, 1, '2019-04-23 04:54:40', 0),
	(19, 12, NULL, 1, '2019-04-23 12:31:41', 0),
	(20, 12, NULL, 1, '2019-04-23 12:31:47', 0),
	(21, 12, NULL, 1, '2019-04-23 12:31:51', 0),
	(22, 12, NULL, 1, '2019-04-23 12:32:02', 0),
	(23, 12, NULL, 1, '2019-04-23 12:32:05', 0),
	(24, 12, NULL, 1, '2019-04-23 12:32:14', 0),
	(25, 12, NULL, 1, '2019-04-23 12:32:25', 0),
	(26, 13, NULL, 1, '2019-04-23 13:14:26', 0),
	(27, 13, NULL, 1, '2019-04-23 13:14:44', 0),
	(28, 14, NULL, 1, '2019-04-23 14:11:17', 0),
	(29, 14, NULL, 1, '2019-04-23 14:11:34', 0),
	(30, 14, NULL, 1, '2019-04-23 14:12:19', 0),
	(31, 14, NULL, 1, '2019-04-23 14:12:57', 0),
	(32, 15, NULL, 1, '2019-04-23 15:54:24', 0),
	(33, 16, NULL, 1, '2019-04-23 16:32:43', 0),
	(34, 16, NULL, 1, '2019-04-23 16:34:50', 0),
	(35, 19, NULL, 1, '2019-04-23 22:25:13', 0),
	(36, 19, NULL, 1, '2019-04-23 22:25:19', 0),
	(37, 19, NULL, 1, '2019-04-23 22:25:50', 0),
	(38, 19, NULL, 1, '2019-04-23 22:26:20', 0),
	(39, 19, NULL, 1, '2019-04-23 22:27:31', 0),
	(40, 20, NULL, 1, '2019-04-23 22:29:07', 0),
	(41, 21, NULL, 1, '2019-04-23 22:30:16', 0),
	(42, 24, NULL, 1, '2019-04-23 22:44:18', 0),
	(43, 24, NULL, 1, '2019-04-23 22:44:31', 0),
	(44, 24, NULL, 1, '2019-04-23 22:45:23', 0),
	(45, 25, NULL, 1, '2019-04-23 22:48:31', 0),
	(46, 27, NULL, 1, '2019-04-23 22:52:45', 0),
	(47, 28, NULL, 1, '2019-04-23 22:57:20', 0),
	(48, 27, NULL, 1, '2019-04-23 23:09:01', 0),
	(49, 27, NULL, 1, '2019-04-23 23:10:48', 0),
	(50, 34, NULL, 1, '2019-04-23 23:46:56', 0),
	(51, 36, NULL, 1, '2019-04-23 23:57:45', 0),
	(52, 39, NULL, 1, '2019-04-24 00:11:37', 0),
	(53, 42, NULL, 1, '2019-04-24 01:28:04', 0),
	(54, 43, NULL, 1, '2019-04-24 02:07:51', 0),
	(55, 43, NULL, 1, '2019-04-24 02:08:50', 0),
	(56, 54, NULL, 1, '2019-04-24 04:23:38', 0),
	(57, 54, NULL, 1, '2019-04-24 04:28:26', 0),
	(58, 54, NULL, 1, '2019-04-24 04:30:10', 0),
	(59, 55, NULL, 1, '2019-04-24 04:38:33', 0),
	(60, 57, NULL, 1, '2019-04-24 04:48:09', 0),
	(61, 58, NULL, 1, '2019-04-24 10:11:25', 0),
	(62, 58, NULL, 1, '2019-04-24 10:15:28', 0),
	(63, 58, NULL, 1, '2019-04-24 10:16:07', 0),
	(64, 59, NULL, 1, '2019-04-24 11:56:53', 0),
	(65, 59, NULL, 1, '2019-04-24 12:01:41', 0),
	(66, 62, NULL, 1, '2019-04-24 13:53:26', 0),
	(67, 62, NULL, 1, '2019-04-24 13:54:13', 0),
	(68, 62, NULL, 1, '2019-04-24 13:54:35', 0),
	(69, 62, NULL, 1, '2019-04-24 13:56:24', 0),
	(70, 64, NULL, 1, '2019-04-24 16:04:33', 0),
	(71, 68, NULL, 1, '2019-04-24 21:56:50', 0),
	(72, 69, NULL, 1, '2019-04-24 21:56:54', 0),
	(73, 68, NULL, 1, '2019-04-24 22:11:32', 0),
	(74, 68, NULL, 1, '2019-04-24 22:14:03', 0),
	(75, 68, NULL, 1, '2019-04-24 22:23:46', 0),
	(76, 68, NULL, 1, '2019-04-24 22:33:05', 0),
	(77, 68, NULL, 1, '2019-04-24 22:41:29', 0),
	(78, 68, NULL, 1, '2019-04-24 22:42:34', 0),
	(79, 68, NULL, 1, '2019-04-24 22:46:47', 0),
	(80, 68, NULL, 1, '2019-04-24 22:49:40', 0),
	(81, 68, NULL, 1, '2019-04-24 22:51:47', 0),
	(82, 68, NULL, 1, '2019-04-24 23:40:18', 0),
	(91, 70, NULL, 1, '2019-04-25 12:06:02', 0),
	(92, 75, NULL, 1, '2019-04-25 16:42:56', 0),
	(93, 76, NULL, 1, '2019-04-25 16:47:17', 0),
	(94, 79, NULL, 1, '2019-04-25 19:15:32', 0),
	(95, 79, NULL, 1, '2019-04-25 19:56:07', 0),
	(96, 79, NULL, 1, '2019-04-25 19:56:50', 0),
	(97, 79, NULL, 1, '2019-04-25 20:00:37', 0),
	(98, 79, NULL, 1, '2019-04-25 20:00:37', 0),
	(99, 79, NULL, 1, '2019-04-25 20:28:13', 0),
	(100, 80, NULL, 1, '2019-04-25 21:38:46', 0),
	(101, 81, NULL, 1, '2019-04-25 21:56:04', 0),
	(102, 81, NULL, 1, '2019-04-25 22:01:22', 0),
	(103, 81, NULL, 1, '2019-04-25 22:02:30', 0),
	(104, 81, NULL, 1, '2019-04-25 22:12:11', 0),
	(105, 82, NULL, 1, '2019-04-25 22:28:33', 0),
	(106, 84, NULL, 1, '2019-04-25 23:30:34', 0),
	(107, 85, NULL, 1, '2019-04-25 23:35:07', 0),
	(108, 85, NULL, 1, '2019-04-25 23:35:37', 0),
	(109, 87, NULL, 1, '2019-04-26 00:12:35', 0),
	(110, 93, NULL, 1, '2019-04-26 01:58:08', 0),
	(111, 93, NULL, 1, '2019-04-26 01:59:54', 0),
	(112, 101, NULL, 1, '2019-04-26 02:53:54', 0),
	(113, 101, NULL, 1, '2019-04-26 02:53:55', 0),
	(114, 101, NULL, 1, '2019-04-26 02:55:15', 0),
	(115, 101, NULL, 1, '2019-04-26 02:55:15', 0),
	(116, 102, NULL, 1, '2019-04-26 03:03:06', 0),
	(117, 102, NULL, 1, '2019-04-26 03:06:42', 0),
	(118, 102, NULL, 1, '2019-04-26 03:10:39', 0),
	(119, 102, NULL, 1, '2019-04-26 03:11:29', 0),
	(120, 103, NULL, 1, '2019-04-26 03:19:38', 0),
	(121, 103, NULL, 1, '2019-04-26 03:20:42', 0),
	(122, 105, NULL, 1, '2019-04-26 10:29:10', 0),
	(123, 105, NULL, 1, '2019-04-26 10:29:45', 0),
	(124, 105, NULL, 1, '2019-04-26 10:30:04', 0),
	(125, 106, NULL, 1, '2019-04-26 11:05:18', 0),
	(126, 107, NULL, 1, '2019-04-26 12:32:23', 0),
	(127, 108, NULL, 1, '2019-04-26 13:56:27', 0),
	(128, 109, NULL, 1, '2019-04-26 15:59:56', 0),
	(129, 109, NULL, 1, '2019-04-26 16:01:28', 0),
	(130, 111, NULL, 1, '2019-04-26 20:00:41', 0),
	(131, 111, NULL, 1, '2019-04-26 20:00:42', 0),
	(132, 111, NULL, 1, '2019-04-26 20:00:42', 0),
	(133, 111, NULL, 1, '2019-04-26 20:00:42', 0),
	(134, 111, NULL, 1, '2019-04-26 20:00:43', 0),
	(135, 111, NULL, 1, '2019-04-26 20:00:43', 0),
	(136, 111, NULL, 1, '2019-04-26 20:00:44', 0),
	(137, 111, NULL, 1, '2019-04-26 20:00:44', 0),
	(138, 111, NULL, 1, '2019-04-26 20:00:44', 0),
	(139, 111, NULL, 1, '2019-04-26 20:00:44', 0),
	(140, 111, NULL, 1, '2019-04-26 20:00:45', 0),
	(141, 110, NULL, 1, '2019-04-26 20:04:38', 0),
	(142, 110, NULL, 1, '2019-04-26 20:05:01', 0),
	(143, 110, NULL, 1, '2019-04-26 20:05:20', 0),
	(144, 110, NULL, 1, '2019-04-26 20:06:11', 0),
	(145, 110, NULL, 1, '2019-04-26 20:07:34', 0),
	(146, 110, NULL, 1, '2019-04-26 20:08:41', 0),
	(147, 110, NULL, 1, '2019-04-26 20:09:17', 0),
	(148, 110, NULL, 1, '2019-04-26 20:11:55', 0),
	(149, 113, NULL, 1, '2019-04-26 20:42:08', 0),
	(150, 115, NULL, 1, '2019-04-26 21:54:34', 0),
	(151, 116, NULL, 1, '2019-04-26 22:14:50', 0),
	(152, 116, NULL, 1, '2019-04-26 22:17:12', 0),
	(153, 118, NULL, 1, '2019-04-27 00:04:59', 0),
	(154, 122, NULL, 1, '2019-04-27 01:20:01', 0),
	(155, 123, NULL, 1, '2019-04-27 01:23:36', 0),
	(156, 123, NULL, 1, '2019-04-27 01:24:58', 0),
	(157, 125, NULL, 0, '2019-04-27 05:14:34', 0),
	(158, 126, NULL, 0, '2019-04-27 05:22:22', 0),
	(159, 127, NULL, 0, '2019-04-27 09:39:00', 0),
	(160, 127, NULL, 0, '2019-04-27 10:20:51', 0),
	(161, 128, NULL, 0, '2019-04-27 11:50:09', 0),
	(162, 129, NULL, 0, '2019-04-27 12:50:03', 0);
/*!40000 ALTER TABLE `tbRequests` ENABLE KEYS */;

-- Copiando estrutura para tabela u672842222_food.tbRequestsProducts
DROP TABLE IF EXISTS `tbRequestsProducts`;
CREATE TABLE IF NOT EXISTS `tbRequestsProducts` (
  `idRequestProduct` int(11) NOT NULL AUTO_INCREMENT,
  `idRequest` int(11) NOT NULL,
  `idProduct` int(11) NOT NULL,
  `qtProduct` int(11) NOT NULL DEFAULT 1,
  `vlUnity` decimal(8,2) NOT NULL DEFAULT 0.00,
  `dtRegister` datetime NOT NULL DEFAULT current_timestamp(),
  `isDeleted` tinyint(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`idRequestProduct`),
  KEY `fk_tbPedidos_has_tbProdutos_tbProdutos1_idx` (`idProduct`),
  KEY `fk_tbPedidos_has_tbProdutos_tbPedidos1_idx` (`idRequest`),
  CONSTRAINT `fk_tbPedidos_has_tbProdutos_tbPedidos1` FOREIGN KEY (`idRequest`) REFERENCES `tbRequests` (`idRequest`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_tbPedidos_has_tbProdutos_tbProdutos1` FOREIGN KEY (`idProduct`) REFERENCES `tbProducts` (`idProduct`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=279 DEFAULT CHARSET=utf8;

-- Copiando dados para a tabela u672842222_food.tbRequestsProducts: ~269 rows (aproximadamente)
/*!40000 ALTER TABLE `tbRequestsProducts` DISABLE KEYS */;
REPLACE INTO `tbRequestsProducts` (`idRequestProduct`, `idRequest`, `idProduct`, `qtProduct`, `vlUnity`, `dtRegister`, `isDeleted`) VALUES
	(1, 1, 35, 7, 14.00, '2019-04-23 00:42:19', 0),
	(2, 1, 36, 2, 11.00, '2019-04-23 00:42:19', 0),
	(3, 1, 52, 1, 31.00, '2019-04-23 00:42:19', 0),
	(4, 1, 34, 1, 13.00, '2019-04-23 00:42:19', 0),
	(5, 2, 50, 1, 28.00, '2019-04-23 00:45:30', 0),
	(6, 3, 51, 1, 35.00, '2019-04-23 00:49:13', 0),
	(7, 4, 40, 1, 22.00, '2019-04-23 00:55:42', 0),
	(8, 5, 33, 1, 20.00, '2019-04-23 00:57:04', 0),
	(9, 6, 34, 2, 13.00, '2019-04-23 01:00:15', 0),
	(10, 6, 35, 2, 14.00, '2019-04-23 01:00:15', 0),
	(11, 6, 36, 1, 11.00, '2019-04-23 01:00:15', 0),
	(12, 7, 39, 7, 18.00, '2019-04-23 01:06:51', 0),
	(13, 7, 35, 2, 14.00, '2019-04-23 01:06:51', 0),
	(14, 8, 30, 2, 30.00, '2019-04-23 04:13:31', 0),
	(15, 8, 31, 2, 22.00, '2019-04-23 04:13:31', 0),
	(16, 9, 37, 2, 16.00, '2019-04-23 04:17:47', 0),
	(17, 9, 36, 2, 11.00, '2019-04-23 04:17:47', 0),
	(18, 10, 36, 2, 11.00, '2019-04-23 04:25:08', 0),
	(19, 10, 35, 3, 14.00, '2019-04-23 04:25:08', 0),
	(20, 10, 52, 3, 31.00, '2019-04-23 04:25:08', 0),
	(21, 10, 50, 1, 28.00, '2019-04-23 04:25:08', 0),
	(22, 10, 40, 1, 22.00, '2019-04-23 04:25:08', 0),
	(23, 11, 47, 1, 24.00, '2019-04-23 04:25:42', 0),
	(24, 12, 44, 2, 27.00, '2019-04-23 04:27:09', 0),
	(25, 12, 55, 1, 21.00, '2019-04-23 04:27:09', 0),
	(26, 13, 35, 2, 14.00, '2019-04-23 04:28:36', 0),
	(27, 13, 34, 1, 13.00, '2019-04-23 04:28:36', 0),
	(28, 14, 35, 2, 14.00, '2019-04-23 04:46:50', 0),
	(29, 14, 40, 1, 22.00, '2019-04-23 04:46:50', 0),
	(30, 14, 52, 1, 31.00, '2019-04-23 04:46:50', 0),
	(31, 14, 49, 1, 33.00, '2019-04-23 04:46:50', 0),
	(32, 14, 55, 1, 21.00, '2019-04-23 04:46:50', 0),
	(33, 16, 33, 3, 20.00, '2019-04-23 04:48:52', 0),
	(34, 16, 48, 1, 37.00, '2019-04-23 04:48:52', 0),
	(35, 16, 26, 1, 14.00, '2019-04-23 04:48:52', 0),
	(36, 17, 26, 1, 14.00, '2019-04-23 04:50:56', 0),
	(37, 17, 48, 1, 37.00, '2019-04-23 04:50:56', 0),
	(38, 18, 18, 1, 70.50, '2019-04-23 04:54:40', 0),
	(39, 18, 40, 1, 22.00, '2019-04-23 04:54:40', 0),
	(40, 18, 44, 1, 27.00, '2019-04-23 04:54:40', 0),
	(50, 28, 37, 1, 16.00, '2019-04-23 14:11:17', 0),
	(51, 29, 35, 1, 14.00, '2019-04-23 14:11:34', 0),
	(52, 30, 34, 3, 13.00, '2019-04-23 14:12:19', 0),
	(53, 31, 36, 1, 11.00, '2019-04-23 14:12:57', 0),
	(54, 31, 52, 1, 31.00, '2019-04-23 14:12:57', 0),
	(55, 31, 57, 1, 2.00, '2019-04-23 14:12:57', 0),
	(56, 32, 36, 1, 11.00, '2019-04-23 15:54:24', 0),
	(57, 32, 55, 1, 21.00, '2019-04-23 15:54:24', 0),
	(58, 33, 50, 3, 28.00, '2019-04-23 16:32:43', 0),
	(59, 34, 50, 1, 28.00, '2019-04-23 16:34:50', 0),
	(60, 34, 51, 2, 35.00, '2019-04-23 16:34:50', 0),
	(61, 35, 36, 2, 11.00, '2019-04-23 22:25:13', 0),
	(62, 35, 18, 8, 70.50, '2019-04-23 22:25:13', 0),
	(63, 35, 40, 1, 22.00, '2019-04-23 22:25:13', 0),
	(64, 35, 57, 1, 2.00, '2019-04-23 22:25:13', 0),
	(65, 37, 30, 1, 30.00, '2019-04-23 22:25:50', 0),
	(66, 38, 57, 1, 2.00, '2019-04-23 22:26:20', 0),
	(67, 38, 42, 1, 30.00, '2019-04-23 22:26:20', 0),
	(68, 39, 46, 1, 17.00, '2019-04-23 22:27:31', 0),
	(69, 39, 31, 1, 22.00, '2019-04-23 22:27:31', 0),
	(70, 39, 50, 1, 28.00, '2019-04-23 22:27:31', 0),
	(71, 41, 36, 1, 11.00, '2019-04-23 22:30:16', 0),
	(72, 41, 57, 1, 2.00, '2019-04-23 22:30:16', 0),
	(73, 42, 56, 1, 5.00, '2019-04-23 22:44:18', 0),
	(74, 42, 36, 1, 11.00, '2019-04-23 22:44:18', 0),
	(75, 42, 51, 1, 35.00, '2019-04-23 22:44:18', 0),
	(76, 44, 50, 1, 28.00, '2019-04-23 22:45:23', 0),
	(77, 45, 46, 1, 17.00, '2019-04-23 22:48:31', 0),
	(78, 45, 42, 1, 30.00, '2019-04-23 22:48:31', 0),
	(79, 46, 57, 1, 2.00, '2019-04-23 22:52:45', 0),
	(80, 47, 57, 1, 2.00, '2019-04-23 22:57:20', 0),
	(81, 47, 36, 1, 11.00, '2019-04-23 22:57:20', 0),
	(82, 47, 48, 1, 37.00, '2019-04-23 22:57:20', 0),
	(83, 48, 26, 1, 14.00, '2019-04-23 23:09:01', 0),
	(84, 49, 55, 1, 21.00, '2019-04-23 23:10:48', 0),
	(85, 49, 57, 1, 2.00, '2019-04-23 23:10:48', 0),
	(86, 49, 42, 1, 30.00, '2019-04-23 23:10:48', 0),
	(87, 49, 58, 1, 30.00, '2019-04-23 23:10:48', 0),
	(88, 50, 49, 1, 33.00, '2019-04-23 23:46:56', 0),
	(89, 50, 57, 1, 2.00, '2019-04-23 23:46:56', 0),
	(90, 51, 32, 1, 28.00, '2019-04-23 23:57:45', 0),
	(91, 51, 55, 2, 21.00, '2019-04-23 23:57:45', 0),
	(92, 51, 39, 1, 18.00, '2019-04-23 23:57:45', 0),
	(93, 51, 57, 2, 2.00, '2019-04-23 23:57:45', 0),
	(94, 51, 31, 1, 22.00, '2019-04-23 23:57:45', 0),
	(95, 51, 36, 1, 11.00, '2019-04-23 23:57:45', 0),
	(96, 52, 31, 1, 22.00, '2019-04-24 00:11:37', 0),
	(97, 52, 40, 1, 22.00, '2019-04-24 00:11:37', 0),
	(98, 52, 57, 1, 2.00, '2019-04-24 00:11:37', 0),
	(99, 52, 49, 1, 33.00, '2019-04-24 00:11:37', 0),
	(100, 52, 32, 1, 28.00, '2019-04-24 00:11:37', 0),
	(101, 52, 24, 1, 20.00, '2019-04-24 00:11:37', 0),
	(102, 52, 30, 1, 30.00, '2019-04-24 00:11:37', 0),
	(103, 52, 54, 2, 31.00, '2019-04-24 00:11:37', 0),
	(104, 53, 37, 1, 16.00, '2019-04-24 01:28:04', 0),
	(105, 53, 26, 5, 14.00, '2019-04-24 01:28:04', 0),
	(106, 53, 39, 1, 18.00, '2019-04-24 01:28:04', 0),
	(107, 53, 58, 1, 30.00, '2019-04-24 01:28:04', 0),
	(108, 53, 52, 1, 31.00, '2019-04-24 01:28:04', 0),
	(109, 54, 26, 1, 14.00, '2019-04-24 02:07:51', 0),
	(110, 55, 43, 2, 32.00, '2019-04-24 02:08:50', 0),
	(111, 55, 57, 2, 2.00, '2019-04-24 02:08:50', 0),
	(112, 56, 58, 1, 30.00, '2019-04-24 04:23:38', 0),
	(113, 56, 55, 1, 21.00, '2019-04-24 04:23:38', 0),
	(114, 56, 56, 1, 5.00, '2019-04-24 04:23:38', 0),
	(115, 56, 51, 2, 35.00, '2019-04-24 04:23:38', 0),
	(116, 56, 60, 1, 40.00, '2019-04-24 04:23:38', 0),
	(117, 57, 49, 4, 33.00, '2019-04-24 04:28:26', 0),
	(118, 57, 55, 1, 21.00, '2019-04-24 04:28:26', 0),
	(119, 57, 24, 2, 20.00, '2019-04-24 04:28:26', 0),
	(120, 58, 40, 1, 22.00, '2019-04-24 04:30:10', 0),
	(121, 59, 57, 1, 2.00, '2019-04-24 04:38:33', 0),
	(122, 59, 26, 4, 14.00, '2019-04-24 04:38:33', 0),
	(123, 59, 49, 1, 33.00, '2019-04-24 04:38:33', 0),
	(124, 60, 31, 5, 22.00, '2019-04-24 04:48:09', 0),
	(125, 60, 30, 1, 30.00, '2019-04-24 04:48:09', 0),
	(126, 60, 59, 1, 25082.00, '2019-04-24 04:48:09', 0),
	(127, 60, 60, 1, 40.00, '2019-04-24 04:48:09', 0),
	(128, 60, 18, 1, 70.50, '2019-04-24 04:48:09', 0),
	(129, 61, 56, 1, 5.00, '2019-04-24 10:11:25', 0),
	(130, 61, 61, 1, 20.00, '2019-04-24 10:11:25', 0),
	(131, 62, 60, 1, 40.00, '2019-04-24 10:15:28', 0),
	(132, 63, 58, 1, 30.00, '2019-04-24 10:16:07', 0),
	(133, 64, 55, 7, 21.00, '2019-04-24 11:56:53', 0),
	(134, 64, 57, 1, 2.00, '2019-04-24 11:56:53', 0),
	(135, 65, 40, 4, 22.00, '2019-04-24 12:01:41', 0),
	(136, 65, 57, 1, 2.00, '2019-04-24 12:01:41', 0),
	(137, 66, 26, 1, 14.00, '2019-04-24 13:53:26', 0),
	(138, 66, 37, 1, 16.00, '2019-04-24 13:53:26', 0),
	(139, 66, 57, 1, 2.00, '2019-04-24 13:53:26', 0),
	(140, 67, 42, 1, 30.00, '2019-04-24 13:54:13', 0),
	(141, 68, 41, 1, 24.00, '2019-04-24 13:54:35', 0),
	(142, 69, 64, 1, 45.00, '2019-04-24 13:56:24', 0),
	(143, 70, 55, 1, 21.00, '2019-04-24 16:04:33', 0),
	(144, 70, 49, 2, 33.00, '2019-04-24 16:04:33', 0),
	(145, 71, 51, 1, 35.00, '2019-04-24 21:56:50', 0),
	(146, 71, 55, 2, 21.00, '2019-04-24 21:56:50', 0),
	(147, 72, 34, 1, 13.00, '2019-04-24 21:56:54', 0),
	(148, 72, 58, 1, 30.00, '2019-04-24 21:56:54', 0),
	(149, 73, 55, 3, 21.00, '2019-04-24 22:11:32', 0),
	(150, 74, 55, 2, 21.00, '2019-04-24 22:14:04', 0),
	(151, 75, 26, 2, 14.00, '2019-04-24 22:23:46', 0),
	(152, 75, 30, 1, 30.00, '2019-04-24 22:23:46', 0),
	(153, 76, 36, 1, 11.00, '2019-04-24 22:33:05', 0),
	(154, 77, 60, 2, 40.00, '2019-04-24 22:41:29', 0),
	(155, 78, 60, 1, 40.00, '2019-04-24 22:42:34', 0),
	(156, 79, 40, 1, 22.00, '2019-04-24 22:46:47', 0),
	(157, 80, 40, 1, 22.00, '2019-04-24 22:49:40', 0),
	(158, 80, 60, 1, 40.00, '2019-04-24 22:49:40', 0),
	(159, 81, 60, 1, 40.00, '2019-04-24 22:51:47', 0),
	(160, 82, 36, 1, 11.00, '2019-04-24 23:40:18', 0),
	(161, 91, 30, 1, 30.00, '2019-04-25 12:06:02', 0),
	(162, 91, 42, 1, 30.00, '2019-04-25 12:06:02', 0),
	(163, 92, 52, 3, 31.00, '2019-04-25 16:42:56', 0),
	(164, 93, 36, 3, 11.00, '2019-04-25 16:47:17', 0),
	(165, 93, 56, 7, 5.00, '2019-04-25 16:47:17', 0),
	(166, 93, 39, 6, 18.00, '2019-04-25 16:47:17', 0),
	(167, 94, 60, 15, 40.00, '2019-04-25 19:15:32', 0),
	(168, 94, 53, 6, 34.00, '2019-04-25 19:15:32', 0),
	(169, 94, 61, 2, 20.00, '2019-04-25 19:15:32', 0),
	(170, 94, 57, 3, 2.00, '2019-04-25 19:15:32', 0),
	(171, 94, 58, 1, 30.00, '2019-04-25 19:15:32', 0),
	(172, 95, 61, 2, 20.00, '2019-04-25 19:56:07', 0),
	(173, 96, 57, 4, 2.00, '2019-04-25 19:56:50', 0),
	(174, 96, 36, 3, 11.00, '2019-04-25 19:56:50', 0),
	(175, 97, 33, 11, 20.00, '2019-04-25 20:00:37', 0),
	(176, 97, 32, 1, 28.00, '2019-04-25 20:00:37', 0),
	(177, 97, 60, 7, 40.00, '2019-04-25 20:00:37', 0),
	(178, 99, 32, 43, 28.00, '2019-04-25 20:28:13', 0),
	(179, 99, 51, 3, 35.00, '2019-04-25 20:28:13', 0),
	(180, 99, 33, 2, 20.00, '2019-04-25 20:28:13', 0),
	(181, 100, 61, 2, 20.00, '2019-04-25 21:38:46', 0),
	(182, 100, 50, 2, 28.00, '2019-04-25 21:38:46', 0),
	(183, 100, 30, 33, 30.00, '2019-04-25 21:38:46', 0),
	(184, 100, 40, 2, 22.00, '2019-04-25 21:38:46', 0),
	(185, 100, 48, 2, 37.00, '2019-04-25 21:38:46', 0),
	(186, 100, 55, 10, 21.00, '2019-04-25 21:38:46', 0),
	(187, 101, 31, 1, 22.00, '2019-04-25 21:56:04', 0),
	(188, 101, 61, 2, 20.00, '2019-04-25 21:56:04', 0),
	(189, 102, 48, 1, 37.00, '2019-04-25 22:01:22', 0),
	(190, 102, 52, 2, 31.00, '2019-04-25 22:01:22', 0),
	(191, 103, 57, 5, 2.00, '2019-04-25 22:02:30', 0),
	(192, 104, 36, 90, 11.00, '2019-04-25 22:12:11', 0),
	(193, 104, 60, 3, 40.00, '2019-04-25 22:12:11', 0),
	(194, 105, 36, 12, 11.00, '2019-04-25 22:28:33', 0),
	(195, 105, 37, 2, 16.00, '2019-04-25 22:28:33', 0),
	(196, 106, 57, 2, 2.00, '2019-04-25 23:30:34', 0),
	(197, 106, 30, 9, 30.00, '2019-04-25 23:30:34', 0),
	(198, 106, 32, 1, 28.00, '2019-04-25 23:30:34', 0),
	(199, 106, 33, 15, 20.00, '2019-04-25 23:30:34', 0),
	(200, 106, 49, 8, 33.00, '2019-04-25 23:30:34', 0),
	(201, 106, 42, 1, 30.00, '2019-04-25 23:30:34', 0),
	(202, 106, 43, 1, 32.00, '2019-04-25 23:30:34', 0),
	(203, 106, 41, 1, 24.00, '2019-04-25 23:30:34', 0),
	(204, 106, 64, 1, 45.00, '2019-04-25 23:30:34', 0),
	(205, 106, 47, 1, 24.00, '2019-04-25 23:30:34', 0),
	(206, 106, 54, 2, 31.00, '2019-04-25 23:30:34', 0),
	(207, 107, 65, 10, 500.00, '2019-04-25 23:35:07', 0),
	(208, 107, 55, 2, 21.00, '2019-04-25 23:35:07', 0),
	(209, 107, 56, 1, 5.00, '2019-04-25 23:35:07', 0),
	(210, 108, 60, 5, 40.00, '2019-04-25 23:35:37', 0),
	(211, 109, 31, 1, 22.00, '2019-04-26 00:12:35', 0),
	(212, 109, 43, 3, 32.00, '2019-04-26 00:12:35', 0),
	(213, 109, 40, 1, 22.00, '2019-04-26 00:12:35', 0),
	(214, 109, 42, 1, 30.00, '2019-04-26 00:12:35', 0),
	(215, 109, 64, 2, 45.00, '2019-04-26 00:12:35', 0),
	(216, 109, 44, 1, 27.00, '2019-04-26 00:12:35', 0),
	(217, 109, 45, 1, 35.00, '2019-04-26 00:12:35', 0),
	(218, 109, 36, 1, 11.00, '2019-04-26 00:12:35', 0),
	(219, 109, 65, 1, 500.00, '2019-04-26 00:12:35', 0),
	(220, 109, 26, 76, 14.00, '2019-04-26 00:12:35', 0),
	(221, 109, 49, 1, 33.00, '2019-04-26 00:12:35', 0),
	(222, 110, 49, 2, 33.00, '2019-04-26 01:58:08', 0),
	(223, 110, 61, 2, 20.00, '2019-04-26 01:58:08', 0),
	(224, 110, 40, 5, 22.00, '2019-04-26 01:58:08', 0),
	(225, 111, 55, 5, 21.00, '2019-04-26 01:59:54', 0),
	(226, 111, 61, 6, 20.00, '2019-04-26 01:59:54', 0),
	(227, 112, 57, 1, 2.00, '2019-04-26 02:53:54', 0),
	(228, 114, 43, 1, 32.00, '2019-04-26 02:55:15', 0),
	(229, 116, 36, 2, 11.00, '2019-04-26 03:03:06', 0),
	(230, 117, 36, 1, 11.00, '2019-04-26 03:06:42', 0),
	(231, 118, 31, 5, 22.00, '2019-04-26 03:10:39', 0),
	(232, 118, 57, 1, 2.00, '2019-04-26 03:10:39', 0),
	(233, 119, 35, 1, 14.00, '2019-04-26 03:11:29', 0),
	(234, 120, 60, 3, 40.00, '2019-04-26 03:19:38', 0),
	(235, 121, 30, 27, 30.00, '2019-04-26 03:20:42', 0),
	(236, 122, 60, 2, 40.00, '2019-04-26 10:29:10', 0),
	(237, 122, 56, 2, 5.00, '2019-04-26 10:29:10', 0),
	(238, 123, 36, 2, 11.00, '2019-04-26 10:29:46', 0),
	(239, 124, 57, 1, 2.00, '2019-04-26 10:30:04', 0),
	(240, 125, 31, 2, 22.00, '2019-04-26 11:05:18', 0),
	(241, 125, 55, 1, 21.00, '2019-04-26 11:05:18', 0),
	(242, 126, 50, 1, 28.00, '2019-04-26 12:32:23', 0),
	(243, 127, 61, 10, 20.00, '2019-04-26 13:56:27', 0),
	(244, 128, 31, 2, 22.00, '2019-04-26 15:59:56', 0),
	(245, 128, 60, 3, 40.00, '2019-04-26 15:59:56', 0),
	(246, 128, 47, 2, 24.00, '2019-04-26 15:59:56', 0),
	(247, 129, 60, 1, 40.00, '2019-04-26 16:01:28', 0),
	(248, 129, 37, 1, 16.00, '2019-04-26 16:01:28', 0),
	(249, 130, 32, 3, 28.00, '2019-04-26 20:00:41', 0),
	(250, 130, 42, 4, 30.00, '2019-04-26 20:00:41', 0),
	(251, 130, 47, 5, 24.00, '2019-04-26 20:00:41', 0),
	(252, 141, 57, 5, 2.00, '2019-04-26 20:04:38', 0),
	(253, 141, 36, 10, 11.00, '2019-04-26 20:04:38', 0),
	(254, 142, 30, 6, 30.00, '2019-04-26 20:05:01', 0),
	(255, 142, 43, 4, 32.00, '2019-04-26 20:05:01', 0),
	(256, 143, 40, 1, 22.00, '2019-04-26 20:05:21', 0),
	(257, 148, 36, 5, 11.00, '2019-04-26 20:11:55', 0),
	(258, 149, 30, 3, 30.00, '2019-04-26 20:42:08', 0),
	(259, 150, 40, 8, 22.00, '2019-04-26 21:54:34', 0),
	(260, 151, 37, 6, 16.00, '2019-04-26 22:14:50', 0),
	(261, 152, 37, 5, 16.00, '2019-04-26 22:17:12', 0),
	(262, 153, 48, 3, 37.00, '2019-04-27 00:04:59', 0),
	(263, 153, 60, 2, 40.00, '2019-04-27 00:04:59', 0),
	(264, 154, 46, 5, 17.00, '2019-04-27 01:20:01', 0),
	(265, 154, 31, 1, 22.00, '2019-04-27 01:20:01', 0),
	(266, 155, 40, 2, 22.00, '2019-04-27 01:23:36', 0),
	(267, 156, 18, 3, 70.50, '2019-04-27 01:24:58', 0),
	(268, 157, 55, 7, 21.00, '2019-04-27 05:14:34', 0),
	(269, 158, 65, 2, 500.00, '2019-04-27 05:22:22', 0),
	(270, 158, 42, 1, 30.00, '2019-04-27 05:22:22', 0),
	(271, 159, 57, 2, 2.00, '2019-04-27 09:39:00', 0),
	(272, 159, 60, 2, 40.00, '2019-04-27 09:39:00', 0),
	(273, 159, 61, 1, 20.00, '2019-04-27 09:39:00', 0),
	(274, 160, 57, 3, 2.00, '2019-04-27 10:20:51', 0),
	(275, 160, 47, 1, 24.00, '2019-04-27 10:20:51', 0),
	(276, 161, 49, 1, 33.00, '2019-04-27 11:50:09', 0),
	(277, 162, 35, 1, 14.00, '2019-04-27 12:50:03', 0),
	(278, 162, 64, 1, 45.00, '2019-04-27 12:50:03', 0);
/*!40000 ALTER TABLE `tbRequestsProducts` ENABLE KEYS */;

-- Copiando estrutura para tabela u672842222_food.tbUsers
DROP TABLE IF EXISTS `tbUsers`;
CREATE TABLE IF NOT EXISTS `tbUsers` (
  `idUser` int(11) NOT NULL AUTO_INCREMENT,
  `idCompany` int(11) NOT NULL,
  `desLogin` varchar(45) NOT NULL,
  `desPassword` varchar(45) NOT NULL,
  `dtRegister` datetime NOT NULL DEFAULT current_timestamp(),
  `isDeleted` tinyint(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`idUser`),
  KEY `fk_tbUsers_tbCompanies1_idx` (`idCompany`),
  CONSTRAINT `fk_tbUsers_tbCompanies1` FOREIGN KEY (`idCompany`) REFERENCES `tbCompanies` (`idCompany`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8;

-- Copiando dados para a tabela u672842222_food.tbUsers: ~12 rows (aproximadamente)
/*!40000 ALTER TABLE `tbUsers` DISABLE KEYS */;
REPLACE INTO `tbUsers` (`idUser`, `idCompany`, `desLogin`, `desPassword`, `dtRegister`, `isDeleted`) VALUES
	(1, 1, 'dev', 'a30c3ada16ecb5b34e49211bf06a4ec47e80d75d', '2019-04-01 21:44:28', 0),
	(18, 1, 'eduardop', '8cb2237d0679ca88db6464eac60da96345513964', '2019-04-04 13:57:00', 0),
	(19, 1, 'neli', '7631047c2fb847aaf4962e7b895429056ffaf91b', '2019-04-04 17:35:09', 0),
	(20, 1, 'csdf', 'ab0a9d53605d424611397d3795fdb294c1c29526', '2019-04-04 20:45:25', 0),
	(21, 1, 'teste', '40bd001563085fc35165329ea1ff5c5ecbdbbeef', '2019-04-05 11:32:52', 0),
	(22, 1, '1234567', '7c4a8d09ca3762af61e59520943dc26494f8941b', '2019-04-06 08:22:38', 0),
	(23, 1, '222223', '3315b97d8efd01d64fe397d01963409ea6aa6a06', '2019-04-06 08:25:35', 0),
	(24, 1, '23123132', '85fb9fc6ec34636068825b73feb70acdc6eac9ac', '2019-04-06 08:27:52', 0),
	(25, 1, 'everaldo', '40bd001563085fc35165329ea1ff5c5ecbdbbeef', '2019-04-06 09:02:46', 0),
	(26, 1, 'admin', 'd033e22ae348aeb5660fc2140aec35850c4da997', '2019-04-10 20:47:51', 0),
	(27, 1, 'marlon', '7110eda4d09e062aa5e4a390b0a572ac0d2c0220', '2019-04-18 02:51:58', 0),
	(28, 1, 'admin', '40bd001563085fc35165329ea1ff5c5ecbdbbeef', '2019-04-26 23:59:37', 0);
/*!40000 ALTER TABLE `tbUsers` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
