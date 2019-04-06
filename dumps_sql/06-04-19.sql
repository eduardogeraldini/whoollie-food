-- phpMyAdmin SQL Dump
-- version 4.8.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: 06-Abr-2019 às 14:10
-- Versão do servidor: 10.1.34-MariaDB
-- PHP Version: 7.2.8

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `u672842222_food`
--

-- --------------------------------------------------------

--
-- Estrutura da tabela `tbboards`
--

CREATE TABLE `tbboards` (
  `idBoard` int(11) NOT NULL,
  `idCompany` int(11) NOT NULL,
  `qtPlaces` int(11) NOT NULL,
  `isActive` tinyint(4) NOT NULL DEFAULT '1',
  `dtRegister` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `isDeleted` tinyint(4) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura da tabela `tbcompanies`
--

CREATE TABLE `tbcompanies` (
  `idCompany` int(11) NOT NULL,
  `desName` varchar(60) NOT NULL,
  `desCNPJ` varchar(15) NOT NULL,
  `desChanel` varchar(45) NOT NULL,
  `isActive` tinyint(4) NOT NULL DEFAULT '1',
  `dtRegister` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `isDeleted` tinyint(4) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `tbcompanies`
--

INSERT INTO `tbcompanies` (`idCompany`, `desName`, `desCNPJ`, `desChanel`, `isActive`, `dtRegister`, `isDeleted`) VALUES
(1, 'Whoollie Services - ME', '147258369147257', 'whoollie', 1, '2019-04-01 21:43:30', 0);

-- --------------------------------------------------------

--
-- Estrutura da tabela `tbdepartments`
--

CREATE TABLE `tbdepartments` (
  `idDepartment` int(11) NOT NULL,
  `idCompany` int(11) NOT NULL,
  `desName` varchar(45) NOT NULL,
  `dtRegister` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `isDeleted` tinyint(4) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `tbdepartments`
--

INSERT INTO `tbdepartments` (`idDepartment`, `idCompany`, `desName`, `dtRegister`, `isDeleted`) VALUES
(1, 1, 'TI', '2019-04-01 21:43:39', 0);

-- --------------------------------------------------------

--
-- Estrutura da tabela `tbemployees`
--

CREATE TABLE `tbemployees` (
  `idEmployees` int(11) NOT NULL,
  `idCompany` int(11) NOT NULL,
  `idDepartment` int(11) NOT NULL,
  `idLogin` int(11) DEFAULT NULL,
  `desName` varchar(100) NOT NULL,
  `desCPF` varchar(11) NOT NULL,
  `dtBirth` date NOT NULL,
  `isActive` tinyint(4) NOT NULL DEFAULT '1',
  `dtRegister` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `isDeleted` tinyint(4) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `tbemployees`
--

INSERT INTO `tbemployees` (`idEmployees`, `idCompany`, `idDepartment`, `idLogin`, `desName`, `desCPF`, `dtBirth`, `isActive`, `dtRegister`, `isDeleted`) VALUES
(1, 1, 1, 1, 'Matheus', '47169948800', '1999-03-01', 1, '2019-04-01 21:43:56', 0),
(10, 1, 1, 18, 'Eduardo', '44694640827', '1996-12-05', 1, '2019-04-04 13:57:00', 0),
(11, 1, 1, 19, 'Neli', '34567890', '4567-03-12', 1, '2019-04-04 17:35:09', 0),
(12, 1, 1, 20, 'dsdasd', '342423', '1233-03-12', 1, '2019-04-04 20:45:25', 0),
(13, 1, 1, 21, 'Funcionario', '45678', '6777-05-04', 1, '2019-04-05 11:32:53', 0),
(16, 1, 1, 24, 'fxgfcgfcfg', '23123123', '1222-12-12', 1, '2019-04-06 08:27:52', 0),
(17, 1, 1, 25, 'Everaldo', '1234567', '4555-03-12', 1, '2019-04-06 09:02:46', 0);

-- --------------------------------------------------------

--
-- Estrutura da tabela `tborders`
--

CREATE TABLE `tborders` (
  `idOrder` int(11) NOT NULL,
  `idCompany` int(11) NOT NULL,
  `idEmployee` int(11) NOT NULL,
  `idBoard` int(11) NOT NULL,
  `vlDiscount` decimal(3,1) DEFAULT '0.0',
  `vlStatus` int(11) NOT NULL DEFAULT '0',
  `dtRegister` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `isDeleted` tinyint(4) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura da tabela `tbprivileges`
--

CREATE TABLE `tbprivileges` (
  `idPrivilege` int(11) NOT NULL,
  `idEmployee` int(11) NOT NULL,
  `viewProducts` int(11) NOT NULL DEFAULT '1',
  `viewOrders` int(11) NOT NULL DEFAULT '1',
  `viewEmployees` int(11) NOT NULL,
  `viewReports` int(11) NOT NULL,
  `viewConfigs` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `tbprivileges`
--

INSERT INTO `tbprivileges` (`idPrivilege`, `idEmployee`, `viewProducts`, `viewOrders`, `viewEmployees`, `viewReports`, `viewConfigs`) VALUES
(1, 1, 1, 1, 1, 1, 1),
(2, 10, 1, 1, 1, 1, 0),
(3, 11, 1, 1, 1, 0, 1),
(4, 12, 0, 0, 0, 1, 0),
(5, 13, 1, 1, 1, 1, 1),
(6, 16, 0, 1, 1, 1, 1),
(7, 17, 1, 1, 1, 1, 0);

-- --------------------------------------------------------

--
-- Estrutura da tabela `tbproducts`
--

CREATE TABLE `tbproducts` (
  `idProduct` int(11) NOT NULL,
  `idCompany` int(11) NOT NULL,
  `idProductCategory` int(11) NOT NULL,
  `vlUnity` decimal(8,2) NOT NULL DEFAULT '0.00',
  `desName` varchar(45) NOT NULL,
  `desNote` varchar(50) NOT NULL,
  `desImagePath` varchar(250) DEFAULT NULL,
  `qtStock` int(11) NOT NULL,
  `isActive` tinyint(4) NOT NULL DEFAULT '1',
  `dtRegister` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `isDeleted` tinyint(4) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `tbproducts`
--

INSERT INTO `tbproducts` (`idProduct`, `idCompany`, `idProductCategory`, `vlUnity`, `desName`, `desNote`, `desImagePath`, `qtStock`, `isActive`, `dtRegister`, `isDeleted`) VALUES
(11, 1, 8, '20.00', 'asdsa', 'sdaa', NULL, 8, 1, '2019-04-03 19:19:26', 0),
(12, 1, 8, '0.00', 'jhjkh', 'jkhkjhkj', 'res/uploads/products/1554344672_UseCase Diagram0.jpg', 0, 1, '2019-04-03 23:24:32', 0),
(13, 1, 9, '890.00', 'teste', '20938', 'res/uploads/products/1554344875_UseCase Diagram0.jpg', 2323, 1, '2019-04-03 23:27:55', 0),
(14, 1, 8, '98.00', 'kjlk', 'kljlk', 'res/admin/img/sem_foto.png', 23, 1, '2019-04-03 23:28:44', 0),
(15, 1, 8, '897.00', 'djhd', 'ksaljdlkasjdklajsdklasjdklajskldjalksdjaskldjalksd', 'res/admin/img/sem_foto.png', 77, 1, '2019-04-03 23:29:24', 0),
(16, 1, 8, '994.69', 'czc', 'jnjknj', 'res/admin/img/sem_foto.png', 3, 1, '2019-04-03 23:31:52', 0),
(17, 1, 9, '14.00', 'X - Burguer', 'Big burguer, x-burguer salada especial da Villa, x', 'res/uploads/products/1554374964_x-burguer bem feito.png', 45, 1, '2019-04-04 07:49:24', 0),
(18, 1, 8, '70.00', 'X Burguer 2', 'skjdkalsjdk', 'res/uploads/products/1554386244_x-burguer bem feito.png', 3, 1, '2019-04-04 10:57:24', 0),
(19, 1, 9, '89.00', 'jkhkj', 'hkjhkjh', 'res/admin/img/sem_foto.png', 0, 1, '2019-04-04 10:58:34', 0),
(20, 1, 8, '78.00', 'kjhjhj', 'hjhjk', 'res/admin/img/sem_foto.png', 2, 1, '2019-04-05 19:04:20', 0);

-- --------------------------------------------------------

--
-- Estrutura da tabela `tbproductscategories`
--

CREATE TABLE `tbproductscategories` (
  `idProductCategory` int(11) NOT NULL,
  `idCompany` int(11) NOT NULL,
  `desName` varchar(45) NOT NULL,
  `dtRegister` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `isDeleted` tinyint(4) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `tbproductscategories`
--

INSERT INTO `tbproductscategories` (`idProductCategory`, `idCompany`, `desName`, `dtRegister`, `isDeleted`) VALUES
(8, 1, 'Bebidas', '2019-04-03 19:13:57', 0),
(9, 1, 'Massas', '2019-04-03 19:14:01', 0),
(10, 1, 'PorÃ§Ãµes', '2019-04-03 23:33:04', 0),
(11, 1, 'Teste', '2019-04-04 10:58:56', 0);

-- --------------------------------------------------------

--
-- Estrutura da tabela `tbrequests`
--

CREATE TABLE `tbrequests` (
  `idRequest` int(11) NOT NULL,
  `idOrder` int(11) NOT NULL,
  `desNote` varchar(250) DEFAULT NULL,
  `vlStatus` int(11) NOT NULL DEFAULT '0',
  `dtRegister` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `isDeleted` tinyint(4) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura da tabela `tbrequestsproducts`
--

CREATE TABLE `tbrequestsproducts` (
  `idRequestProduct` int(11) NOT NULL,
  `idRequest` int(11) NOT NULL,
  `idProduct` int(11) NOT NULL,
  `qtProduct` int(11) NOT NULL DEFAULT '1',
  `vlUnity` decimal(8,2) NOT NULL DEFAULT '0.00',
  `dtRegister` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `isDeleted` tinyint(4) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura da tabela `tbusers`
--

CREATE TABLE `tbusers` (
  `idUser` int(11) NOT NULL,
  `idCompany` int(11) NOT NULL,
  `desLogin` varchar(45) NOT NULL,
  `desPassword` varchar(45) NOT NULL,
  `dtRegister` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `isDeleted` tinyint(4) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `tbusers`
--

INSERT INTO `tbusers` (`idUser`, `idCompany`, `desLogin`, `desPassword`, `dtRegister`, `isDeleted`) VALUES
(1, 1, 'dev', 'a30c3ada16ecb5b34e49211bf06a4ec47e80d75d', '2019-04-01 21:44:28', 0),
(18, 1, 'eduardo', 'a30c3ada16ecb5b34e49211bf06a4ec47e80d75d', '2019-04-04 13:57:00', 0),
(19, 1, 'neli', '7631047c2fb847aaf4962e7b895429056ffaf91b', '2019-04-04 17:35:09', 0),
(20, 1, 'csdf', 'ab0a9d53605d424611397d3795fdb294c1c29526', '2019-04-04 20:45:25', 0),
(21, 1, 'teste', '40bd001563085fc35165329ea1ff5c5ecbdbbeef', '2019-04-05 11:32:52', 0),
(22, 1, '1234567', '7c4a8d09ca3762af61e59520943dc26494f8941b', '2019-04-06 08:22:38', 0),
(23, 1, '222223', '3315b97d8efd01d64fe397d01963409ea6aa6a06', '2019-04-06 08:25:35', 0),
(24, 1, '23123132', '85fb9fc6ec34636068825b73feb70acdc6eac9ac', '2019-04-06 08:27:52', 0),
(25, 1, 'everaldo', '40bd001563085fc35165329ea1ff5c5ecbdbbeef', '2019-04-06 09:02:46', 0);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `tbboards`
--
ALTER TABLE `tbboards`
  ADD PRIMARY KEY (`idBoard`),
  ADD KEY `fk_tbMesas_tbEmpresas1_idx` (`idCompany`);

--
-- Indexes for table `tbcompanies`
--
ALTER TABLE `tbcompanies`
  ADD PRIMARY KEY (`idCompany`);

--
-- Indexes for table `tbdepartments`
--
ALTER TABLE `tbdepartments`
  ADD PRIMARY KEY (`idDepartment`),
  ADD KEY `fk_tbDepartamentos_tbEmpresas1_idx` (`idCompany`);

--
-- Indexes for table `tbemployees`
--
ALTER TABLE `tbemployees`
  ADD PRIMARY KEY (`idEmployees`),
  ADD KEY `fk_tbFuncionarios_tbDepartamentos1_idx` (`idDepartment`),
  ADD KEY `fk_tbFuncionarios_tbUsuarios1_idx` (`idLogin`),
  ADD KEY `fk_tbEmployees_tbCompanies1_idx` (`idCompany`);

--
-- Indexes for table `tborders`
--
ALTER TABLE `tborders`
  ADD PRIMARY KEY (`idOrder`),
  ADD KEY `fk_tbComandas_tbFuncionarios1_idx` (`idEmployee`),
  ADD KEY `fk_tbComandas_tbEmpresas1_idx` (`idCompany`),
  ADD KEY `fk_tbComandas_tbMesas1_idx` (`idBoard`);

--
-- Indexes for table `tbprivileges`
--
ALTER TABLE `tbprivileges`
  ADD PRIMARY KEY (`idPrivilege`),
  ADD KEY `fk_tbPrivileges_tbEmployees1_idx` (`idEmployee`);

--
-- Indexes for table `tbproducts`
--
ALTER TABLE `tbproducts`
  ADD PRIMARY KEY (`idProduct`),
  ADD KEY `fk_tbProdutos_tbCategoriasProdutos1_idx` (`idProductCategory`),
  ADD KEY `fk_tbProdutos_tbEmpresas1_idx` (`idCompany`);

--
-- Indexes for table `tbproductscategories`
--
ALTER TABLE `tbproductscategories`
  ADD PRIMARY KEY (`idProductCategory`),
  ADD KEY `fk_tbProductsCategories_tbCompanies1_idx` (`idCompany`);

--
-- Indexes for table `tbrequests`
--
ALTER TABLE `tbrequests`
  ADD PRIMARY KEY (`idRequest`),
  ADD KEY `fk_tbPedidos_tbComandas_idx` (`idOrder`);

--
-- Indexes for table `tbrequestsproducts`
--
ALTER TABLE `tbrequestsproducts`
  ADD PRIMARY KEY (`idRequestProduct`),
  ADD KEY `fk_tbPedidos_has_tbProdutos_tbProdutos1_idx` (`idProduct`),
  ADD KEY `fk_tbPedidos_has_tbProdutos_tbPedidos1_idx` (`idRequest`);

--
-- Indexes for table `tbusers`
--
ALTER TABLE `tbusers`
  ADD PRIMARY KEY (`idUser`),
  ADD KEY `fk_tbUsers_tbCompanies1_idx` (`idCompany`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `tbboards`
--
ALTER TABLE `tbboards`
  MODIFY `idBoard` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tbcompanies`
--
ALTER TABLE `tbcompanies`
  MODIFY `idCompany` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `tbdepartments`
--
ALTER TABLE `tbdepartments`
  MODIFY `idDepartment` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `tbemployees`
--
ALTER TABLE `tbemployees`
  MODIFY `idEmployees` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `tborders`
--
ALTER TABLE `tborders`
  MODIFY `idOrder` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tbprivileges`
--
ALTER TABLE `tbprivileges`
  MODIFY `idPrivilege` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `tbproducts`
--
ALTER TABLE `tbproducts`
  MODIFY `idProduct` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `tbproductscategories`
--
ALTER TABLE `tbproductscategories`
  MODIFY `idProductCategory` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `tbrequests`
--
ALTER TABLE `tbrequests`
  MODIFY `idRequest` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tbrequestsproducts`
--
ALTER TABLE `tbrequestsproducts`
  MODIFY `idRequestProduct` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tbusers`
--
ALTER TABLE `tbusers`
  MODIFY `idUser` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- Constraints for dumped tables
--

--
-- Limitadores para a tabela `tbboards`
--
ALTER TABLE `tbboards`
  ADD CONSTRAINT `fk_tbMesas_tbEmpresas1` FOREIGN KEY (`idCompany`) REFERENCES `tbcompanies` (`idCompany`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Limitadores para a tabela `tbdepartments`
--
ALTER TABLE `tbdepartments`
  ADD CONSTRAINT `fk_tbDepartamentos_tbEmpresas1` FOREIGN KEY (`idCompany`) REFERENCES `tbcompanies` (`idCompany`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Limitadores para a tabela `tbemployees`
--
ALTER TABLE `tbemployees`
  ADD CONSTRAINT `fk_tbEmployees_tbCompanies1` FOREIGN KEY (`idCompany`) REFERENCES `tbcompanies` (`idCompany`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_tbFuncionarios_tbDepartamentos1` FOREIGN KEY (`idDepartment`) REFERENCES `tbdepartments` (`idDepartment`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_tbFuncionarios_tbUsuarios1` FOREIGN KEY (`idLogin`) REFERENCES `tbusers` (`idUser`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Limitadores para a tabela `tborders`
--
ALTER TABLE `tborders`
  ADD CONSTRAINT `fk_tbComandas_tbEmpresas1` FOREIGN KEY (`idCompany`) REFERENCES `tbcompanies` (`idCompany`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_tbComandas_tbFuncionarios1` FOREIGN KEY (`idEmployee`) REFERENCES `tbemployees` (`idEmployees`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_tbComandas_tbMesas1` FOREIGN KEY (`idBoard`) REFERENCES `tbboards` (`idBoard`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Limitadores para a tabela `tbprivileges`
--
ALTER TABLE `tbprivileges`
  ADD CONSTRAINT `fk_tbPrivileges_tbEmployees1` FOREIGN KEY (`idEmployee`) REFERENCES `tbemployees` (`idEmployees`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Limitadores para a tabela `tbproducts`
--
ALTER TABLE `tbproducts`
  ADD CONSTRAINT `fk_tbProdutos_tbCategoriasProdutos1` FOREIGN KEY (`idProductCategory`) REFERENCES `tbproductscategories` (`idProductCategory`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_tbProdutos_tbEmpresas1` FOREIGN KEY (`idCompany`) REFERENCES `tbcompanies` (`idCompany`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Limitadores para a tabela `tbproductscategories`
--
ALTER TABLE `tbproductscategories`
  ADD CONSTRAINT `fk_tbProductsCategories_tbCompanies1` FOREIGN KEY (`idCompany`) REFERENCES `tbcompanies` (`idCompany`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Limitadores para a tabela `tbrequests`
--
ALTER TABLE `tbrequests`
  ADD CONSTRAINT `fk_tbPedidos_tbComandas` FOREIGN KEY (`idOrder`) REFERENCES `tborders` (`idOrder`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Limitadores para a tabela `tbrequestsproducts`
--
ALTER TABLE `tbrequestsproducts`
  ADD CONSTRAINT `fk_tbPedidos_has_tbProdutos_tbPedidos1` FOREIGN KEY (`idRequest`) REFERENCES `tbrequests` (`idRequest`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_tbPedidos_has_tbProdutos_tbProdutos1` FOREIGN KEY (`idProduct`) REFERENCES `tbproducts` (`idProduct`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Limitadores para a tabela `tbusers`
--
ALTER TABLE `tbusers`
  ADD CONSTRAINT `fk_tbUsers_tbCompanies1` FOREIGN KEY (`idCompany`) REFERENCES `tbcompanies` (`idCompany`) ON DELETE NO ACTION ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
