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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- Copiando dados para a tabela u672842222_food.tbBoards: ~1 rows (aproximadamente)
/*!40000 ALTER TABLE `tbBoards` DISABLE KEYS */;
REPLACE INTO `tbBoards` (`idBoard`, `idCompany`, `vlBoard`, `qtPlaces`, `isActive`, `dtRegister`, `isDeleted`) VALUES
	(1, 1, '1', 4, 1, '2019-04-13 14:55:22', 0);
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
	(1, 1, 'TI', '2019-04-01 21:43:39', 0, 0);
/*!40000 ALTER TABLE `tbDepartments` ENABLE KEYS */;

-- Copiando estrutura para tabela u672842222_food.tbDevices
DROP TABLE IF EXISTS `tbDevices`;
CREATE TABLE IF NOT EXISTS `tbDevices` (
  `idDevice` int(11) NOT NULL AUTO_INCREMENT,
  `idCompany` int(11) NOT NULL,
  `desName` text NOT NULL,
  `desLogin` text NOT NULL,
  `desPassword` text NOT NULL,
  `isActive` tinyint(4) NOT NULL DEFAULT 0,
  `dtRegister` datetime NOT NULL DEFAULT current_timestamp(),
  `isDeleted` tinyint(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`idDevice`),
  KEY `FK1_companys` (`idCompany`),
  CONSTRAINT `FK1_companys` FOREIGN KEY (`idCompany`) REFERENCES `tbCompanies` (`idCompany`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- Copiando dados para a tabela u672842222_food.tbDevices: ~2 rows (aproximadamente)
/*!40000 ALTER TABLE `tbDevices` DISABLE KEYS */;
REPLACE INTO `tbDevices` (`idDevice`, `idCompany`, `desName`, `desLogin`, `desPassword`, `isActive`, `dtRegister`, `isDeleted`) VALUES
	(2, 1, 'Mesa - 011', 'ipad01', '7110eda4d09e062aa5e4a390b0a572ac0d2c0220', 1, '2019-04-15 22:02:39', 0),
	(3, 1, 'Mesa - 02', 'mesa01', '7110eda4d09e062aa5e4a390b0a572ac0d2c0220', 1, '2019-04-15 22:05:03', 0);
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
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;

-- Copiando dados para a tabela u672842222_food.tbEmployees: ~9 rows (aproximadamente)
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
	(19, 1, 1, 27, 'Marlon', '03979255589', '1996-02-11', 1, '2019-04-18 02:51:58', 0);
/*!40000 ALTER TABLE `tbEmployees` ENABLE KEYS */;

-- Copiando estrutura para tabela u672842222_food.tbOrders
DROP TABLE IF EXISTS `tbOrders`;
CREATE TABLE IF NOT EXISTS `tbOrders` (
  `idOrder` int(11) NOT NULL AUTO_INCREMENT,
  `idCompany` int(11) NOT NULL,
  `idUser` int(11) NOT NULL,
  `idBoard` int(11) NOT NULL,
  `desName` varchar(50) NOT NULL,
  `vlDiscount` decimal(3,1) DEFAULT 0.0,
  `vlStatus` int(11) DEFAULT 0,
  `dtRegister` datetime NOT NULL DEFAULT current_timestamp(),
  `isDeleted` tinyint(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`idOrder`),
  KEY `fk_tbComandas_tbFuncionarios1_idx` (`idUser`),
  KEY `fk_tbComandas_tbEmpresas1_idx` (`idCompany`),
  KEY `fk_tbComandas_tbMesas1_idx` (`idBoard`),
  CONSTRAINT `fk_tbComandas_tbEmpresas1` FOREIGN KEY (`idCompany`) REFERENCES `tbCompanies` (`idCompany`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_tbComandas_tbFuncionarios1` FOREIGN KEY (`idUser`) REFERENCES `tbEmployees` (`idUser`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_tbComandas_tbMesas1` FOREIGN KEY (`idBoard`) REFERENCES `tbBoards` (`idBoard`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

-- Copiando dados para a tabela u672842222_food.tbOrders: ~7 rows (aproximadamente)
/*!40000 ALTER TABLE `tbOrders` DISABLE KEYS */;
REPLACE INTO `tbOrders` (`idOrder`, `idCompany`, `idUser`, `idBoard`, `desName`, `vlDiscount`, `vlStatus`, `dtRegister`, `isDeleted`) VALUES
	(3, 1, 1, 1, 'Matheus', 0.0, 0, '2019-04-13 15:45:40', 0),
	(4, 1, 1, 1, 'Elder', 0.0, 2, '2019-04-15 21:02:53', 0),
	(5, 1, 1, 1, 'Matheus', 0.0, 0, '2019-04-17 23:11:21', 0),
	(6, 1, 1, 1, 'Trste', 0.0, 0, '2019-04-18 01:18:41', 0),
	(7, 1, 1, 1, 'Matheus', 0.0, 0, '2019-04-18 02:47:50', 0),
	(8, 1, 1, 1, 'Huh', 0.0, 0, '2019-04-18 11:40:01', 0),
	(9, 1, 1, 1, 'teste2', 0.0, 0, '2019-04-19 00:33:26', 0);
/*!40000 ALTER TABLE `tbOrders` ENABLE KEYS */;

-- Copiando estrutura para tabela u672842222_food.tbPrivileges
DROP TABLE IF EXISTS `tbPrivileges`;
CREATE TABLE IF NOT EXISTS `tbPrivileges` (
  `idPrivilege` int(11) NOT NULL AUTO_INCREMENT,
  `idEmployee` int(11) NOT NULL,
  `viewProducts` int(11) NOT NULL DEFAULT 1,
  `viewOrders` int(11) NOT NULL DEFAULT 1,
  `viewEmployees` int(11) NOT NULL,
  `viewReports` int(11) NOT NULL,
  `viewConfigs` int(11) NOT NULL,
  PRIMARY KEY (`idPrivilege`),
  KEY `fkEtbPrivileges_tbEmployees1_idx` (`idEmployee`),
  CONSTRAINT `fkEtbPrivileges_tbEmployees1` FOREIGN KEY (`idEmployee`) REFERENCES `tbEmployees` (`idEmployee`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

-- Copiando dados para a tabela u672842222_food.tbPrivileges: ~9 rows (aproximadamente)
/*!40000 ALTER TABLE `tbPrivileges` DISABLE KEYS */;
REPLACE INTO `tbPrivileges` (`idPrivilege`, `idEmployee`, `viewProducts`, `viewOrders`, `viewEmployees`, `viewReports`, `viewConfigs`) VALUES
	(1, 1, 1, 1, 1, 1, 1),
	(2, 10, 1, 1, 1, 1, 0),
	(3, 11, 0, 0, 1, 0, 1),
	(4, 12, 1, 0, 0, 1, 0),
	(5, 13, 1, 1, 1, 1, 1),
	(6, 16, 0, 1, 1, 1, 1),
	(7, 17, 1, 1, 1, 1, 0),
	(8, 18, 1, 1, 0, 0, 0),
	(9, 19, 1, 1, 1, 1, 1);
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
  `desImagePath` varchar(250) DEFAULT NULL,
  `isActive` tinyint(4) NOT NULL DEFAULT 1,
  `dtRegister` datetime NOT NULL DEFAULT current_timestamp(),
  `isDeleted` tinyint(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`idProduct`),
  KEY `fk_tbProdutos_tbCategoriasProdutos1_idx` (`idProductCategory`),
  KEY `fk_tbProdutos_tbEmpresas1_idx` (`idCompany`),
  CONSTRAINT `fk_tbProdutos_tbCategoriasProdutos1` FOREIGN KEY (`idProductCategory`) REFERENCES `tbProductsCategories` (`idProductCategory`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_tbProdutos_tbEmpresas1` FOREIGN KEY (`idCompany`) REFERENCES `tbCompanies` (`idCompany`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=56 DEFAULT CHARSET=utf8;

-- Copiando dados para a tabela u672842222_food.tbProducts: ~44 rows (aproximadamente)
/*!40000 ALTER TABLE `tbProducts` DISABLE KEYS */;
REPLACE INTO `tbProducts` (`idProduct`, `idCompany`, `idProductCategory`, `vlUnity`, `desName`, `desNote`, `desImagePath`, `isActive`, `dtRegister`, `isDeleted`) VALUES
	(12, 1, 8, 0.00, 'jhjkh', 'jkhkjhkj', 'res/uploads/products/1554344672_UseCase Diagram0.jpg', 1, '2019-04-03 23:24:32', 1),
	(13, 1, 11, 890.00, 'Diego', '20938', 'res/uploads/products/1555108931_unnamed.jpg', 1, '2019-04-03 23:27:55', 1),
	(14, 1, 8, 98.00, 'Lanche da Ma', 'kljlk', 'res/uploads/products/1555030650_images.jpg', 1, '2019-04-03 23:28:44', 1),
	(15, 1, 8, 897.00, 'djhd', 'ksaljdlkasjdklajsdklasjdklajskldjalksdjaskldjalksd', 'res/admin/img/sem_foto.png', 1, '2019-04-03 23:29:24', 1),
	(16, 1, 8, 994.69, 'czc', 'jnjknj', 'res/admin/img/sem_foto.png', 1, '2019-04-03 23:31:52', 1),
	(17, 1, 9, 14.00, 'X - Burguer', 'Big burguer, x-burguer salada especial da Vi', 'res/admin/img/sem_foto.png', 1, '2019-04-04 07:49:24', 1),
	(18, 1, 11, 70.50, 'X Burguer 2', 'X burger 2 em 1', 'res/uploads/products/1554386244_x-burguer bem feito.png', 1, '2019-04-04 10:57:24', 0),
	(19, 1, 9, 89.00, 'jkhkj', 'hkjhkjh', 'res/uploads/products/1555030500_download-2.jpeg', 1, '2019-04-04 10:58:34', 1),
	(20, 1, 8, 78.00, 'kjhjhj', 'hjhjk', 'res/admin/img/sem_foto.png', 1, '2019-04-05 19:04:20', 1),
	(21, 1, 9, 3156.00, 'Baconn', 'ajsdkj', 'res/uploads/products/1555107351_images.jpg', 0, '2019-04-12 19:15:51', 1),
	(22, 1, 10, 123.00, 'Testeeeee', 'testeett', 'res/uploads/products/1555107392_adesivo-lanchonete-lanche-hamburguer-artesanal-fast-food-hd-adesivo-food.jpg', 0, '2019-04-12 19:16:32', 1),
	(23, 1, 11, 25.00, 'X Tudo', 'teste', 'res/uploads/products/1555114808_images.jpg', 1, '2019-04-12 21:20:08', 0),
	(24, 1, 11, 20.00, 'X Salada', 'salada', 'res/uploads/products/1555114819_images.jpg', 1, '2019-04-12 21:20:19', 0),
	(25, 1, 11, 15.00, 'Teste1', 'teste1', 'res/uploads/products/1555114834_adesivo-lanchonete-lanche-hamburguer-artesanal-fast-food-hd-adesivo-food.jpg', 1, '2019-04-12 21:20:34', 1),
	(26, 1, 11, 14.00, 'Hamburguer completo', 'Completo!', 'res/uploads/products/1555114849_adesivo-lanchonete-lanche-hamburguer-artesanal-fast-food-hd-adesivo-food.jpg', 1, '2019-04-12 21:20:49', 0),
	(27, 1, 8, 12.00, 'teste4', 'teste4', 'res/admin/img/sem_foto.png', 1, '2019-04-12 21:29:57', 1),
	(28, 1, 8, 10.00, 'teste5', 'teste5', 'res/admin/img/sem_foto.png', 1, '2019-04-12 21:30:07', 1),
	(29, 1, 8, 20.00, 'teste6', 'teste6', 'res/admin/img/sem_foto.png', 1, '2019-04-12 21:30:17', 1),
	(30, 1, 8, 30.00, 'Jack Daniels', 'Daniels Jack', 'res/uploads/products/1555553780_ci-jack-daniels-old-no-7-92707d5e737cf4ac.jpeg', 1, '2019-04-18 02:16:20', 0),
	(31, 1, 8, 22.00, 'Amarula', 'amarula 1 litro', 'res/uploads/products/1555553861_amarula.jpg', 1, '2019-04-18 02:17:41', 0),
	(32, 1, 8, 28.00, 'Especial Alcool', 'bebida especial da casa', 'res/uploads/products/1555553886_586074.png', 1, '2019-04-18 02:18:06', 0),
	(33, 1, 8, 20.00, 'Vodka', 'vodka especial', 'res/uploads/products/1555553957_5432286_1GG.jpg', 1, '2019-04-18 02:19:17', 0),
	(34, 1, 9, 13.00, 'Ramen', 'massa ramen', 'res/uploads/products/1555554175_58931-ramen.jpg', 1, '2019-04-18 02:22:55', 0),
	(35, 1, 9, 14.00, 'Massa Italiana', 'Massa do tipo italiana', 'res/uploads/products/1555554203_222massa.jpg', 1, '2019-04-18 02:23:23', 0),
	(36, 1, 9, 11.00, 'Capa Massa', 'Massa capa especial', 'res/uploads/products/1555554230_Capa-Massa.jpg', 1, '2019-04-18 02:23:50', 0),
	(37, 1, 9, 10.00, 'Massa da casa', 'especial caseira', 'res/uploads/products/1555554277_massa1.jpg', 1, '2019-04-18 02:24:24', 0),
	(38, 1, 9, 16.00, 'Vernicelli', 'Do tipo vernicelli', 'res/uploads/products/1555554367_vermicelli_upma_semiya_upma_recipe_gluten_free.jpg', 1, '2019-04-18 02:26:07', 0),
	(39, 1, 9, 18.00, 'Uppa Vernicelli', 'Vernicelli tipo 2', 'res/uploads/products/1555554410_Vermicelli upma1.JPG', 1, '2019-04-18 02:26:50', 0),
	(40, 1, 10, 22.00, 'Batata Frita', 'Porção comum de batata frita', 'res/uploads/products/1555554500_5716e77f-0da4-4b4a-b492-4064ac1f1305.jpg', 1, '2019-04-18 02:28:20', 0),
	(41, 1, 10, 24.00, 'Mandioca Frita', 'Porção de mandioca frita', 'res/uploads/products/1555554527_964494000000-Mandioca-frita.jpg', 1, '2019-04-18 02:28:48', 0),
	(42, 1, 10, 30.00, 'Batata Frita com Bacon', 'Porção de fritas com bacon', 'res/uploads/products/1555554557_porcao-de-batatas-fritas-grande-com-bancon-rechlanches-joinville.jpg', 1, '2019-04-18 02:29:17', 0),
	(43, 1, 10, 32.00, 'Dupla mista', 'Porção de dupla mista', 'res/uploads/products/1555554612_porcaoduplamistaa.png', 1, '2019-04-18 02:30:12', 0),
	(44, 1, 10, 27.00, 'Porção Torresmo', 'De torresmo especial', 'res/uploads/products/1555554684_porcao-de-torresmo.jpg', 1, '2019-04-18 02:31:24', 0),
	(45, 1, 10, 35.00, 'Porção de peixe', 'De peixe', 'res/uploads/products/1555554745_downloadpeixeporcao.jpg', 1, '2019-04-18 02:32:25', 0),
	(46, 1, 10, 17.00, 'Porção de Frios', 'Apenas frios', 'res/uploads/products/1555554804_58ef6b39-0698-49a0-bde7-0bdeac1f1e06.jpg', 1, '2019-04-18 02:33:24', 0),
	(47, 1, 10, 24.00, 'Frango a passarinho', 'Porção de frango a passarinho', 'res/uploads/products/1555554862_5716e77f-33f0-40ab-a9e0-4064ac1f1305.jpg', 1, '2019-04-18 02:34:22', 0),
	(48, 1, 12, 37.00, 'Pizza Italiana', 'Italiana apenas', 'res/uploads/products/1555554955_pizzaita.jpg', 1, '2019-04-18 02:35:55', 0),
	(49, 1, 12, 33.00, 'Pizza Morango e Chocolate', 'Morango com chocolate', 'res/uploads/products/1555554988_pizza-de-chocolate.jpg', 1, '2019-04-18 02:36:28', 0),
	(50, 1, 12, 28.00, 'Pizza de Chocolate', 'Apenas chocolate', 'res/uploads/products/1555555022_pizza-chocolate.jpg', 1, '2019-04-18 02:37:02', 0),
	(51, 1, 12, 35.00, 'Pizza de Morango', 'Com morango apenas', 'res/uploads/products/1555555052_1506701024-massa-de-pizza_616x462.jpg', 1, '2019-04-18 02:37:32', 0),
	(52, 1, 12, 31.00, 'Pizza 3 queijos', 'De 3 queijos', 'res/uploads/products/1555555086_pizza-de-3-queijos-15244.jpg', 1, '2019-04-18 02:38:06', 0),
	(53, 1, 12, 34.00, 'Pizza Requeijão', 'Com requeijão', 'res/uploads/products/1555555131_pizzademilhoerequeijao-2.jpg', 1, '2019-04-18 02:38:52', 0),
	(54, 1, 10, 31.00, 'Mandioca e carne seca', 'Mandioca com carne seca!', 'res/uploads/products/1555555211_Mandiocacarneseca.jpg', 1, '2019-04-18 02:40:11', 0),
	(55, 1, 11, 21.00, 'Burguer Vegano', 'Com carne de soja', 'res/uploads/products/1555555331_roasted-veggie-burgers-with-carrot-ketchup-XL-RECIPE0517.jpg', 1, '2019-04-18 02:42:11', 0);
/*!40000 ALTER TABLE `tbProducts` ENABLE KEYS */;

-- Copiando estrutura para tabela u672842222_food.tbProductsCategories
DROP TABLE IF EXISTS `tbProductsCategories`;
CREATE TABLE IF NOT EXISTS `tbProductsCategories` (
  `idProductCategory` int(11) NOT NULL AUTO_INCREMENT,
  `idCompany` int(11) NOT NULL,
  `desName` varchar(45) NOT NULL,
  `dtRegister` datetime NOT NULL DEFAULT current_timestamp(),
  `isDeleted` tinyint(4) NOT NULL DEFAULT 0,
  `isActive` tinyint(4) NOT NULL DEFAULT 1,
  PRIMARY KEY (`idProductCategory`),
  KEY `fk_tbProductsCategories_tbCompanies1_idx` (`idCompany`),
  CONSTRAINT `fk_tbProductsCategories_tbCompanies1` FOREIGN KEY (`idCompany`) REFERENCES `tbCompanies` (`idCompany`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;

-- Copiando dados para a tabela u672842222_food.tbProductsCategories: ~6 rows (aproximadamente)
/*!40000 ALTER TABLE `tbProductsCategories` DISABLE KEYS */;
REPLACE INTO `tbProductsCategories` (`idProductCategory`, `idCompany`, `desName`, `dtRegister`, `isDeleted`, `isActive`) VALUES
	(8, 1, 'Bebidas', '2019-04-03 19:13:57', 0, 1),
	(9, 1, 'Massas', '2019-04-03 19:14:01', 0, 1),
	(10, 1, 'Porções', '2019-04-03 23:33:04', 0, 1),
	(11, 1, 'Lanches', '2019-04-04 10:58:56', 0, 1),
	(12, 1, 'Pizzas', '2019-04-18 02:34:55', 0, 1),
	(13, 1, 'Teste', '2019-04-18 18:54:29', 1, 1);
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
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8;

-- Copiando dados para a tabela u672842222_food.tbRequests: ~17 rows (aproximadamente)
/*!40000 ALTER TABLE `tbRequests` DISABLE KEYS */;
REPLACE INTO `tbRequests` (`idRequest`, `idOrder`, `desNote`, `vlStatus`, `dtRegister`, `isDeleted`) VALUES
	(1, 3, NULL, 0, '2019-04-13 16:08:39', 0),
	(2, 3, NULL, 0, '2019-04-13 16:08:53', 0),
	(3, 3, NULL, 0, '2019-04-13 16:09:14', 0),
	(4, 3, NULL, 0, '2019-04-13 16:09:28', 0),
	(5, 3, NULL, 0, '2019-04-13 16:10:09', 0),
	(6, 3, NULL, 0, '2019-04-13 16:10:18', 0),
	(7, 4, NULL, 0, '2019-04-15 21:03:20', 0),
	(8, 5, NULL, 0, '2019-04-17 23:11:36', 0),
	(9, 5, NULL, 0, '2019-04-17 23:17:23', 0),
	(10, 5, NULL, 0, '2019-04-17 23:17:34', 0),
	(11, 5, NULL, 0, '2019-04-17 23:17:48', 0),
	(12, 5, NULL, 0, '2019-04-17 23:17:58', 0),
	(13, 5, NULL, 0, '2019-04-17 23:19:02', 0),
	(14, 6, NULL, 0, '2019-04-18 01:18:49', 0),
	(15, 7, NULL, 0, '2019-04-18 02:48:22', 0),
	(16, 8, NULL, 0, '2019-04-18 11:40:11', 0),
	(17, 9, NULL, 0, '2019-04-19 00:33:39', 0);
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
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8;

-- Copiando dados para a tabela u672842222_food.tbRequestsProducts: ~35 rows (aproximadamente)
/*!40000 ALTER TABLE `tbRequestsProducts` DISABLE KEYS */;
REPLACE INTO `tbRequestsProducts` (`idRequestProduct`, `idRequest`, `idProduct`, `qtProduct`, `vlUnity`, `dtRegister`, `isDeleted`) VALUES
	(1, 4, 25, 1, 15.00, '2019-04-13 16:09:28', 0),
	(2, 4, 29, 1, 20.00, '2019-04-13 16:09:28', 0),
	(3, 4, 14, 1, 98.00, '2019-04-13 16:09:28', 0),
	(4, 4, 28, 1, 10.00, '2019-04-13 16:09:28', 0),
	(5, 4, 27, 1, 12.00, '2019-04-13 16:09:28', 0),
	(6, 5, 13, 1, 890.00, '2019-04-13 16:10:09', 0),
	(7, 5, 27, 1, 12.00, '2019-04-13 16:10:09', 0),
	(8, 6, 13, 2, 890.00, '2019-04-13 16:10:18', 0),
	(9, 6, 25, 2, 15.00, '2019-04-13 16:10:18', 0),
	(10, 6, 29, 1, 20.00, '2019-04-13 16:10:18', 0),
	(11, 7, 13, 1, 890.00, '2019-04-15 21:03:20', 0),
	(12, 7, 14, 1, 98.00, '2019-04-15 21:03:20', 0),
	(13, 7, 27, 1, 12.00, '2019-04-15 21:03:20', 0),
	(14, 8, 14, 2, 98.00, '2019-04-17 23:11:36', 0),
	(15, 8, 27, 1, 12.00, '2019-04-17 23:11:36', 0),
	(16, 8, 26, 1, 15.00, '2019-04-17 23:11:36', 0),
	(17, 8, 24, 1, 20.00, '2019-04-17 23:11:36', 0),
	(18, 9, 14, 2, 98.00, '2019-04-17 23:17:23', 0),
	(19, 9, 13, 2, 890.00, '2019-04-17 23:17:23', 0),
	(20, 9, 27, 1, 12.00, '2019-04-17 23:17:23', 0),
	(21, 10, 27, 1, 12.00, '2019-04-17 23:17:34', 0),
	(22, 10, 26, 1, 15.00, '2019-04-17 23:17:34', 0),
	(23, 11, 26, 2, 15.00, '2019-04-17 23:17:48', 0),
	(24, 11, 29, 1, 20.00, '2019-04-17 23:17:48', 0),
	(25, 12, 22, 2, 123.00, '2019-04-17 23:17:58', 0),
	(26, 12, 26, 1, 15.00, '2019-04-17 23:17:58', 0),
	(27, 13, 22, 3, 123.00, '2019-04-17 23:19:02', 0),
	(28, 13, 29, 1, 20.00, '2019-04-17 23:19:02', 0),
	(29, 14, 21, 3, 3156.00, '2019-04-18 01:18:49', 0),
	(30, 15, 31, 2, 22.00, '2019-04-18 02:48:22', 0),
	(31, 15, 40, 1, 22.00, '2019-04-18 02:48:22', 0),
	(32, 16, 31, 2, 22.00, '2019-04-18 11:40:11', 0),
	(33, 16, 40, 1, 22.00, '2019-04-18 11:40:11', 0),
	(34, 17, 40, 1, 22.00, '2019-04-19 00:33:39', 0),
	(35, 17, 42, 1, 30.00, '2019-04-19 00:33:39', 0);
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
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8;

-- Copiando dados para a tabela u672842222_food.tbUsers: ~11 rows (aproximadamente)
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
	(27, 1, 'marlon', '7110eda4d09e062aa5e4a390b0a572ac0d2c0220', '2019-04-18 02:51:58', 0);
/*!40000 ALTER TABLE `tbUsers` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
