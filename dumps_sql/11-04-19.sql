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
	(1, 'Whoollie Services - ME', '147258369147257', 'whoollie', 1, '2019-04-01 21:43:30', 0);
/*!40000 ALTER TABLE `tbcompanies` ENABLE KEYS */;

-- Copiando estrutura para tabela u672842222_food.tbdepartments
DROP TABLE IF EXISTS `tbdepartments`;
CREATE TABLE IF NOT EXISTS `tbdepartments` (
  `idDepartment` int(11) NOT NULL AUTO_INCREMENT,
  `idCompany` int(11) NOT NULL,
  `desName` varchar(45) NOT NULL,
  `dtRegister` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `isDeleted` tinyint(4) NOT NULL DEFAULT '0',
  `isActive` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`idDepartment`),
  KEY `fk_tbDepartamentos_tbEmpresas1_idx` (`idCompany`),
  CONSTRAINT `fk_tbDepartamentos_tbEmpresas1` FOREIGN KEY (`idCompany`) REFERENCES `tbcompanies` (`idCompany`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- Copiando dados para a tabela u672842222_food.tbdepartments: ~1 rows (aproximadamente)
/*!40000 ALTER TABLE `tbdepartments` DISABLE KEYS */;
REPLACE INTO `tbdepartments` (`idDepartment`, `idCompany`, `desName`, `dtRegister`, `isDeleted`, `isActive`) VALUES
	(1, 1, 'TI', '2019-04-01 21:43:39', 0, 0);
/*!40000 ALTER TABLE `tbdepartments` ENABLE KEYS */;

-- Copiando estrutura para tabela u672842222_food.tbemployees
DROP TABLE IF EXISTS `tbemployees`;
CREATE TABLE IF NOT EXISTS `tbemployees` (
  `idEmployee` int(11) NOT NULL AUTO_INCREMENT,
  `idCompany` int(11) NOT NULL,
  `idDepartment` int(11) NOT NULL,
  `idUser` int(11) DEFAULT NULL,
  `desName` varchar(100) NOT NULL,
  `desCPF` varchar(11) NOT NULL,
  `dtBirth` date NOT NULL,
  `isActive` tinyint(4) NOT NULL DEFAULT '1',
  `dtRegister` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `isDeleted` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`idEmployee`),
  KEY `fk_tbFuncionarios_tbDepartamentos1_idx` (`idDepartment`),
  KEY `fk_tbFuncionarios_tbUsuarios1_idx` (`idUser`),
  KEY `fk_tbEmployees_tbCompanies1_idx` (`idCompany`),
  CONSTRAINT `fk_tbEmployees_tbCompanies1` FOREIGN KEY (`idCompany`) REFERENCES `tbcompanies` (`idCompany`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_tbFuncionarios_tbDepartamentos1` FOREIGN KEY (`idDepartment`) REFERENCES `tbdepartments` (`idDepartment`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_tbFuncionarios_tbUsuarios1` FOREIGN KEY (`idUser`) REFERENCES `tbusers` (`idUser`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;

-- Copiando dados para a tabela u672842222_food.tbemployees: ~8 rows (aproximadamente)
/*!40000 ALTER TABLE `tbemployees` DISABLE KEYS */;
REPLACE INTO `tbemployees` (`idEmployee`, `idCompany`, `idDepartment`, `idUser`, `desName`, `desCPF`, `dtBirth`, `isActive`, `dtRegister`, `isDeleted`) VALUES
	(1, 1, 1, 1, 'Matheus1', '47169948800', '1999-03-01', 1, '2019-04-01 21:43:56', 0),
	(10, 1, 1, 18, 'Eduardo12', '44694640827', '1996-12-05', 1, '2019-04-04 13:57:00', 0),
	(11, 1, 1, 19, 'Neli', '34567890', '4567-03-12', 0, '2019-04-04 17:35:09', 0),
	(12, 1, 1, 20, 'dsdasd', '342423', '1233-03-12', 0, '2019-04-04 20:45:25', 0),
	(13, 1, 1, 21, 'Funcionario', '45678', '6777-05-04', 1, '2019-04-05 11:32:53', 0),
	(16, 1, 1, 24, 'fxgfcg64654646465464564', '23123123', '1222-12-12', 0, '2019-04-06 08:27:52', 1),
	(17, 1, 1, 25, 'Everaldo', '1234567', '4555-03-12', 1, '2019-04-06 09:02:46', 1),
	(18, 1, 1, 26, 'czxcklj', '12345', '5666-04-23', 0, '2019-04-10 20:47:51', 0);
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
  CONSTRAINT `fk_tbComandas_tbFuncionarios1` FOREIGN KEY (`idEmployee`) REFERENCES `tbemployees` (`idEmployee`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_tbComandas_tbMesas1` FOREIGN KEY (`idBoard`) REFERENCES `tbboards` (`idBoard`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Copiando dados para a tabela u672842222_food.tborders: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `tborders` DISABLE KEYS */;
/*!40000 ALTER TABLE `tborders` ENABLE KEYS */;

-- Copiando estrutura para tabela u672842222_food.tbprivileges
DROP TABLE IF EXISTS `tbprivileges`;
CREATE TABLE IF NOT EXISTS `tbprivileges` (
  `idPrivilege` int(11) NOT NULL AUTO_INCREMENT,
  `idEmployee` int(11) NOT NULL,
  `viewProducts` int(11) NOT NULL DEFAULT '1',
  `viewOrders` int(11) NOT NULL DEFAULT '1',
  `viewEmployees` int(11) NOT NULL,
  `viewReports` int(11) NOT NULL,
  `viewConfigs` int(11) NOT NULL,
  PRIMARY KEY (`idPrivilege`),
  KEY `fk_tbPrivileges_tbEmployees1_idx` (`idEmployee`),
  CONSTRAINT `fk_tbPrivileges_tbEmployees1` FOREIGN KEY (`idEmployee`) REFERENCES `tbemployees` (`idEmployee`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

-- Copiando dados para a tabela u672842222_food.tbprivileges: ~8 rows (aproximadamente)
/*!40000 ALTER TABLE `tbprivileges` DISABLE KEYS */;
REPLACE INTO `tbprivileges` (`idPrivilege`, `idEmployee`, `viewProducts`, `viewOrders`, `viewEmployees`, `viewReports`, `viewConfigs`) VALUES
	(1, 1, 1, 1, 1, 1, 1),
	(2, 10, 1, 1, 1, 1, 0),
	(3, 11, 1, 1, 1, 0, 1),
	(4, 12, 1, 0, 0, 1, 0),
	(5, 13, 1, 1, 1, 1, 1),
	(6, 16, 0, 1, 1, 1, 1),
	(7, 17, 1, 1, 1, 1, 0),
	(8, 18, 1, 1, 0, 0, 0);
/*!40000 ALTER TABLE `tbprivileges` ENABLE KEYS */;

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
  `isActive` tinyint(4) NOT NULL DEFAULT '1',
  `dtRegister` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `isDeleted` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`idProduct`),
  KEY `fk_tbProdutos_tbCategoriasProdutos1_idx` (`idProductCategory`),
  KEY `fk_tbProdutos_tbEmpresas1_idx` (`idCompany`),
  CONSTRAINT `fk_tbProdutos_tbCategoriasProdutos1` FOREIGN KEY (`idProductCategory`) REFERENCES `tbproductscategories` (`idProductCategory`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_tbProdutos_tbEmpresas1` FOREIGN KEY (`idCompany`) REFERENCES `tbcompanies` (`idCompany`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;

-- Copiando dados para a tabela u672842222_food.tbproducts: ~9 rows (aproximadamente)
/*!40000 ALTER TABLE `tbproducts` DISABLE KEYS */;
REPLACE INTO `tbproducts` (`idProduct`, `idCompany`, `idProductCategory`, `vlUnity`, `desName`, `desNote`, `desImagePath`, `isActive`, `dtRegister`, `isDeleted`) VALUES
	(12, 1, 8, 0.00, 'jhjkh', 'jkhkjhkj', 'res/uploads/products/1554344672_UseCase Diagram0.jpg', 1, '2019-04-03 23:24:32', 0),
	(13, 1, 9, 890.00, 'Diego', '20938', 'res/admin/img/sem_foto.png', 1, '2019-04-03 23:27:55', 0),
	(14, 1, 8, 98.00, 'Lanche da Ma', 'kljlk', 'res/admin/img/sem_foto.png', 1, '2019-04-03 23:28:44', 0),
	(15, 1, 8, 897.00, 'djhd', 'ksaljdlkasjdklajsdklasjdklajskldjalksdjaskldjalksd', 'res/admin/img/sem_foto.png', 1, '2019-04-03 23:29:24', 0),
	(16, 1, 8, 994.69, 'czc', 'jnjknj', 'res/admin/img/sem_foto.png', 1, '2019-04-03 23:31:52', 0),
	(17, 1, 9, 14.00, 'X - Burguer', 'Big burguer, x-burguer salada especial da Villa, x', 'res/uploads/products/1555029182_unnamed.jpg', 1, '2019-04-04 07:49:24', 0),
	(18, 1, 8, 70.00, 'X Burguer 2', 'skjdkalsjdk', 'res/uploads/products/1554386244_x-burguer bem feito.png', 1, '2019-04-04 10:57:24', 0),
	(19, 1, 9, 89.00, 'jkhkj', 'hkjhkjh', 'res/admin/img/sem_foto.png', 1, '2019-04-04 10:58:34', 0),
	(20, 1, 8, 78.00, 'kjhjhj', 'hjhjk', 'res/admin/img/sem_foto.png', 1, '2019-04-05 19:04:20', 0);
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
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;

-- Copiando dados para a tabela u672842222_food.tbproductscategories: ~4 rows (aproximadamente)
/*!40000 ALTER TABLE `tbproductscategories` DISABLE KEYS */;
REPLACE INTO `tbproductscategories` (`idProductCategory`, `idCompany`, `desName`, `dtRegister`, `isDeleted`) VALUES
	(8, 1, 'Bebidas', '2019-04-03 19:13:57', 0),
	(9, 1, 'Massas', '2019-04-03 19:14:01', 0),
	(10, 1, 'PorÃ§Ãµes', '2019-04-03 23:33:04', 0),
	(11, 1, 'Teste', '2019-04-04 10:58:56', 0);
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
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8;

-- Copiando dados para a tabela u672842222_food.tbusers: ~10 rows (aproximadamente)
/*!40000 ALTER TABLE `tbusers` DISABLE KEYS */;
REPLACE INTO `tbusers` (`idUser`, `idCompany`, `desLogin`, `desPassword`, `dtRegister`, `isDeleted`) VALUES
	(1, 1, 'dev', 'a30c3ada16ecb5b34e49211bf06a4ec47e80d75d', '2019-04-01 21:44:28', 0),
	(18, 1, 'eduardop', '8cb2237d0679ca88db6464eac60da96345513964', '2019-04-04 13:57:00', 0),
	(19, 1, 'neli', '7631047c2fb847aaf4962e7b895429056ffaf91b', '2019-04-04 17:35:09', 0),
	(20, 1, 'csdf', 'ab0a9d53605d424611397d3795fdb294c1c29526', '2019-04-04 20:45:25', 0),
	(21, 1, 'teste', '40bd001563085fc35165329ea1ff5c5ecbdbbeef', '2019-04-05 11:32:52', 0),
	(22, 1, '1234567', '7c4a8d09ca3762af61e59520943dc26494f8941b', '2019-04-06 08:22:38', 0),
	(23, 1, '222223', '3315b97d8efd01d64fe397d01963409ea6aa6a06', '2019-04-06 08:25:35', 0),
	(24, 1, '23123132', '85fb9fc6ec34636068825b73feb70acdc6eac9ac', '2019-04-06 08:27:52', 0),
	(25, 1, 'everaldo', '40bd001563085fc35165329ea1ff5c5ecbdbbeef', '2019-04-06 09:02:46', 0),
	(26, 1, 'admin', 'd033e22ae348aeb5660fc2140aec35850c4da997', '2019-04-10 20:47:51', 0);
/*!40000 ALTER TABLE `tbusers` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
