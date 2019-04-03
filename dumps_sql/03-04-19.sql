-- --------------------------------------------------------
-- Servidor:                     127.0.0.1
-- Versão do servidor:           10.1.37-MariaDB - mariadb.org binary distribution
-- OS do Servidor:               Win32
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

-- Copiando estrutura para tabela u672842222_food.tbboards
DROP TABLE IF EXISTS `tbboards`;
CREATE TABLE IF NOT EXISTS `tbboards` (
  `idBoard` int(11) NOT NULL AUTO_INCREMENT,
  `idCompany` int(11) NOT NULL,
  `qtPlaces` int(11) NOT NULL,
  `isActive` tinyint(4) NOT NULL DEFAULT '1',
  `dtRegister` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `isDeleted` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`idBoard`),
  KEY `fk_tbMesas_tbEmpresas1_idx` (`idCompany`),
  CONSTRAINT `fk_tbMesas_tbEmpresas1` FOREIGN KEY (`idCompany`) REFERENCES `tbcompanies` (`idCompany`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Copiando dados para a tabela u672842222_food.tbboards: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `tbboards` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbboards` ENABLE KEYS */;

-- Copiando estrutura para tabela u672842222_food.tbcompanies
DROP TABLE IF EXISTS `tbcompanies`;
CREATE TABLE IF NOT EXISTS `tbcompanies` (
  `idCompany` int(11) NOT NULL AUTO_INCREMENT,
  `desName` varchar(60) NOT NULL,
  `desCNPJ` varchar(15) NOT NULL,
  `desChanel` varchar(45) NOT NULL,
  `isActive` tinyint(4) NOT NULL DEFAULT '1',
  `dtRegister` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `isDeleted` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`idCompany`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- Copiando dados para a tabela u672842222_food.tbcompanies: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `tbcompanies` DISABLE KEYS */;
REPLACE INTO `tbcompanies` (`idCompany`, `desName`, `desCNPJ`, `desChanel`, `isActive`, `dtRegister`, `isDeleted`) VALUES
	(1, 'Whoollie', '147258369147258', 'whoollie', 1, '2019-04-01 21:43:30', 0);
/*!40000 ALTER TABLE `tbcompanies` ENABLE KEYS */;

-- Copiando estrutura para tabela u672842222_food.tbdepartments
DROP TABLE IF EXISTS `tbdepartments`;
CREATE TABLE IF NOT EXISTS `tbdepartments` (
  `idDepartment` int(11) NOT NULL AUTO_INCREMENT,
  `idCompany` int(11) NOT NULL,
  `desName` varchar(45) NOT NULL,
  `dtRegister` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `isDeleted` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`idDepartment`),
  KEY `fk_tbDepartamentos_tbEmpresas1_idx` (`idCompany`),
  CONSTRAINT `fk_tbDepartamentos_tbEmpresas1` FOREIGN KEY (`idCompany`) REFERENCES `tbcompanies` (`idCompany`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- Copiando dados para a tabela u672842222_food.tbdepartments: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `tbdepartments` DISABLE KEYS */;
REPLACE INTO `tbdepartments` (`idDepartment`, `idCompany`, `desName`, `dtRegister`, `isDeleted`) VALUES
	(1, 1, 'TI', '2019-04-01 21:43:39', 0);
/*!40000 ALTER TABLE `tbdepartments` ENABLE KEYS */;

-- Copiando estrutura para tabela u672842222_food.tbemployees
DROP TABLE IF EXISTS `tbemployees`;
CREATE TABLE IF NOT EXISTS `tbemployees` (
  `idEmployees` int(11) NOT NULL AUTO_INCREMENT,
  `idCompany` int(11) NOT NULL,
  `idDepartment` int(11) NOT NULL,
  `idLogin` int(11) DEFAULT NULL,
  `desName` varchar(100) NOT NULL,
  `desCPF` varchar(11) NOT NULL,
  `dtBirth` date NOT NULL,
  `isActive` tinyint(4) NOT NULL DEFAULT '1',
  `dtRegister` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `isDeleted` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`idEmployees`),
  KEY `fk_tbFuncionarios_tbDepartamentos1_idx` (`idDepartment`),
  KEY `fk_tbFuncionarios_tbUsuarios1_idx` (`idLogin`),
  KEY `fk_tbEmployees_tbCompanies1_idx` (`idCompany`),
  CONSTRAINT `fk_tbEmployees_tbCompanies1` FOREIGN KEY (`idCompany`) REFERENCES `tbcompanies` (`idCompany`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_tbFuncionarios_tbDepartamentos1` FOREIGN KEY (`idDepartment`) REFERENCES `tbdepartments` (`idDepartment`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_tbFuncionarios_tbUsuarios1` FOREIGN KEY (`idLogin`) REFERENCES `tbusers` (`idUser`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- Copiando dados para a tabela u672842222_food.tbemployees: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `tbemployees` DISABLE KEYS */;
REPLACE INTO `tbemployees` (`idEmployees`, `idCompany`, `idDepartment`, `idLogin`, `desName`, `desCPF`, `dtBirth`, `isActive`, `dtRegister`, `isDeleted`) VALUES
	(1, 1, 1, 1, 'Matheus', '47169948800', '1999-03-01', 1, '2019-04-01 21:43:56', 0);
/*!40000 ALTER TABLE `tbemployees` ENABLE KEYS */;

-- Copiando estrutura para tabela u672842222_food.tborders
DROP TABLE IF EXISTS `tborders`;
CREATE TABLE IF NOT EXISTS `tborders` (
  `idOrder` int(11) NOT NULL AUTO_INCREMENT,
  `idCompany` int(11) NOT NULL,
  `idEmployee` int(11) NOT NULL,
  `idBoard` int(11) NOT NULL,
  `vlDiscount` decimal(3,1) DEFAULT '0.0',
  `vlStatus` int(11) NOT NULL DEFAULT '0',
  `dtRegister` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `isDeleted` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`idOrder`),
  KEY `fk_tbComandas_tbFuncionarios1_idx` (`idEmployee`),
  KEY `fk_tbComandas_tbEmpresas1_idx` (`idCompany`),
  KEY `fk_tbComandas_tbMesas1_idx` (`idBoard`),
  CONSTRAINT `fk_tbComandas_tbEmpresas1` FOREIGN KEY (`idCompany`) REFERENCES `tbcompanies` (`idCompany`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_tbComandas_tbFuncionarios1` FOREIGN KEY (`idEmployee`) REFERENCES `tbemployees` (`idEmployees`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_tbComandas_tbMesas1` FOREIGN KEY (`idBoard`) REFERENCES `tbboards` (`idBoard`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Copiando dados para a tabela u672842222_food.tborders: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `tborders` DISABLE KEYS */;
/*!40000 ALTER TABLE `tborders` ENABLE KEYS */;

-- Copiando estrutura para tabela u672842222_food.tbproducts
DROP TABLE IF EXISTS `tbproducts`;
CREATE TABLE IF NOT EXISTS `tbproducts` (
  `idProduct` int(11) NOT NULL AUTO_INCREMENT,
  `idCompany` int(11) NOT NULL,
  `idProductCategory` int(11) NOT NULL,
  `vlUnity` decimal(8,2) NOT NULL DEFAULT '0.00',
  `desName` varchar(45) NOT NULL,
  `desNote` varchar(50) NOT NULL,
  `desImagePath` varchar(250) DEFAULT NULL,
  `qtStock` int(11) NOT NULL,
  `isActive` tinyint(4) NOT NULL DEFAULT '1',
  `dtRegister` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `isDeleted` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`idProduct`),
  KEY `fk_tbProdutos_tbCategoriasProdutos1_idx` (`idProductCategory`),
  KEY `fk_tbProdutos_tbEmpresas1_idx` (`idCompany`),
  CONSTRAINT `fk_tbProdutos_tbCategoriasProdutos1` FOREIGN KEY (`idProductCategory`) REFERENCES `tbproductscategories` (`idProductCategory`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_tbProdutos_tbEmpresas1` FOREIGN KEY (`idCompany`) REFERENCES `tbcompanies` (`idCompany`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;

-- Copiando dados para a tabela u672842222_food.tbproducts: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `tbproducts` DISABLE KEYS */;
REPLACE INTO `tbproducts` (`idProduct`, `idCompany`, `idProductCategory`, `vlUnity`, `desName`, `desNote`, `desImagePath`, `qtStock`, `isActive`, `dtRegister`, `isDeleted`) VALUES
	(11, 1, 8, 20.00, 'asdsa', 'sdaa', NULL, 8, 1, '2019-04-03 19:19:26', 0);
/*!40000 ALTER TABLE `tbproducts` ENABLE KEYS */;

-- Copiando estrutura para tabela u672842222_food.tbproductscategories
DROP TABLE IF EXISTS `tbproductscategories`;
CREATE TABLE IF NOT EXISTS `tbproductscategories` (
  `idProductCategory` int(11) NOT NULL AUTO_INCREMENT,
  `idCompany` int(11) NOT NULL,
  `desName` varchar(45) NOT NULL,
  `dtRegister` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `isDeleted` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`idProductCategory`),
  KEY `fk_tbProductsCategories_tbCompanies1_idx` (`idCompany`),
  CONSTRAINT `fk_tbProductsCategories_tbCompanies1` FOREIGN KEY (`idCompany`) REFERENCES `tbcompanies` (`idCompany`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

-- Copiando dados para a tabela u672842222_food.tbproductscategories: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `tbproductscategories` DISABLE KEYS */;
REPLACE INTO `tbproductscategories` (`idProductCategory`, `idCompany`, `desName`, `dtRegister`, `isDeleted`) VALUES
	(8, 1, 'Bebidas', '2019-04-03 19:13:57', 0),
	(9, 1, 'Massas', '2019-04-03 19:14:01', 0);
/*!40000 ALTER TABLE `tbproductscategories` ENABLE KEYS */;

-- Copiando estrutura para tabela u672842222_food.tbrequests
DROP TABLE IF EXISTS `tbrequests`;
CREATE TABLE IF NOT EXISTS `tbrequests` (
  `idRequest` int(11) NOT NULL AUTO_INCREMENT,
  `idOrder` int(11) NOT NULL,
  `desNote` varchar(250) DEFAULT NULL,
  `vlStatus` int(11) NOT NULL DEFAULT '0',
  `dtRegister` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `isDeleted` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`idRequest`),
  KEY `fk_tbPedidos_tbComandas_idx` (`idOrder`),
  CONSTRAINT `fk_tbPedidos_tbComandas` FOREIGN KEY (`idOrder`) REFERENCES `tborders` (`idOrder`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Copiando dados para a tabela u672842222_food.tbrequests: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `tbrequests` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbrequests` ENABLE KEYS */;

-- Copiando estrutura para tabela u672842222_food.tbrequestsproducts
DROP TABLE IF EXISTS `tbrequestsproducts`;
CREATE TABLE IF NOT EXISTS `tbrequestsproducts` (
  `idRequestProduct` int(11) NOT NULL AUTO_INCREMENT,
  `idRequest` int(11) NOT NULL,
  `idProduct` int(11) NOT NULL,
  `qtProduct` int(11) NOT NULL DEFAULT '1',
  `vlUnity` decimal(8,2) NOT NULL DEFAULT '0.00',
  `dtRegister` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `isDeleted` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`idRequestProduct`),
  KEY `fk_tbPedidos_has_tbProdutos_tbProdutos1_idx` (`idProduct`),
  KEY `fk_tbPedidos_has_tbProdutos_tbPedidos1_idx` (`idRequest`),
  CONSTRAINT `fk_tbPedidos_has_tbProdutos_tbPedidos1` FOREIGN KEY (`idRequest`) REFERENCES `tbrequests` (`idRequest`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_tbPedidos_has_tbProdutos_tbProdutos1` FOREIGN KEY (`idProduct`) REFERENCES `tbproducts` (`idProduct`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Copiando dados para a tabela u672842222_food.tbrequestsproducts: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `tbrequestsproducts` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbrequestsproducts` ENABLE KEYS */;

-- Copiando estrutura para tabela u672842222_food.tbusers
DROP TABLE IF EXISTS `tbusers`;
CREATE TABLE IF NOT EXISTS `tbusers` (
  `idUser` int(11) NOT NULL AUTO_INCREMENT,
  `idCompany` int(11) NOT NULL,
  `desLogin` varchar(45) NOT NULL,
  `desPassword` varchar(45) NOT NULL,
  `dtRegister` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `isDeleted` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`idUser`),
  KEY `fk_tbUsers_tbCompanies1_idx` (`idCompany`),
  CONSTRAINT `fk_tbUsers_tbCompanies1` FOREIGN KEY (`idCompany`) REFERENCES `tbcompanies` (`idCompany`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- Copiando dados para a tabela u672842222_food.tbusers: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `tbusers` DISABLE KEYS */;
REPLACE INTO `tbusers` (`idUser`, `idCompany`, `desLogin`, `desPassword`, `dtRegister`, `isDeleted`) VALUES
	(1, 1, 'dev', 'a30c3ada16ecb5b34e49211bf06a4ec47e80d75d', '2019-04-01 21:44:28', 0);
/*!40000 ALTER TABLE `tbusers` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
