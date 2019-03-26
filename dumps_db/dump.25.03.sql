-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema dbWhoollieFood
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema dbWhoollieFood
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `dbWhoollieFood` DEFAULT CHARACTER SET utf8 ;
USE `dbWhoollieFood` ;

-- -----------------------------------------------------
-- Table `dbWhoollieFood`.`tbCompanies`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dbWhoollieFood`.`tbCompanies` (
  `idCompany` INT NOT NULL AUTO_INCREMENT,
  `desName` VARCHAR(60) NOT NULL,
  `desCNPJ` VARCHAR(15) NOT NULL,
  `isActive` TINYINT NOT NULL DEFAULT 1,
  `dtRegister` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `isDeleted` TINYINT NOT NULL DEFAULT 0,
  PRIMARY KEY (`idCompany`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dbWhoollieFood`.`tbDepartments`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dbWhoollieFood`.`tbDepartments` (
  `idDepartment` INT NOT NULL AUTO_INCREMENT,
  `idCompany` INT NOT NULL,
  `desName` VARCHAR(45) NOT NULL,
  `dtRegister` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `isDeleted` TINYINT NOT NULL DEFAULT 0,
  PRIMARY KEY (`idDepartment`),
  INDEX `fk_tbDepartamentos_tbEmpresas1_idx` (`idCompany` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dbWhoollieFood`.`tbUsers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dbWhoollieFood`.`tbUsers` (
  `idUser` INT NOT NULL AUTO_INCREMENT,
  `desLogin` VARCHAR(45) NOT NULL,
  `desPassword` VARCHAR(45) NOT NULL,
  `dtRegister` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `isDeleted` TINYINT NOT NULL DEFAULT 0,
  PRIMARY KEY (`idUser`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dbWhoollieFood`.`tbEmployees`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dbWhoollieFood`.`tbEmployees` (
  `idEmployees` INT NOT NULL AUTO_INCREMENT,
  `idDepartment` INT NOT NULL,
  `idLogin` INT NULL,
  `desName` VARCHAR(100) NOT NULL,
  `desCPF` VARCHAR(11) NOT NULL,
  `dtBirth` DATE NOT NULL,
  `isActive` TINYINT NOT NULL DEFAULT 1,
  `dtRegister` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `isDeleted` TINYINT NOT NULL DEFAULT 0,
  PRIMARY KEY (`idEmployees`),
  INDEX `fk_tbFuncionarios_tbDepartamentos1_idx` (`idDepartment` ASC),
  INDEX `fk_tbFuncionarios_tbUsuarios1_idx` (`idLogin` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dbWhoollieFood`.`tbBoards`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dbWhoollieFood`.`tbBoards` (
  `idBoard` INT NOT NULL AUTO_INCREMENT,
  `idCompany` INT NOT NULL,
  `qtPlaces` INT NOT NULL,
  `isActive` TINYINT NOT NULL DEFAULT 1,
  `dtRegister` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `isDeleted` TINYINT NOT NULL DEFAULT 0,
  PRIMARY KEY (`idBoard`),
  INDEX `fk_tbMesas_tbEmpresas1_idx` (`idCompany` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dbWhoollieFood`.`tbOrders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dbWhoollieFood`.`tbOrders` (
  `idOrder` INT NOT NULL AUTO_INCREMENT,
  `idCompany` INT NOT NULL,
  `idEmployee` INT NOT NULL,
  `idBoard` INT NOT NULL,
  `vlDiscount` DECIMAL(3,1) NULL DEFAULT 0.00,
  `vlStatus` INT NOT NULL DEFAULT 0,
  `dtRegister` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `isDeleted` TINYINT NOT NULL DEFAULT 0,
  PRIMARY KEY (`idOrder`),
  INDEX `fk_tbComandas_tbFuncionarios1_idx` (`idEmployee` ASC),
  INDEX `fk_tbComandas_tbEmpresas1_idx` (`idCompany` ASC),
  INDEX `fk_tbComandas_tbMesas1_idx` (`idBoard` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dbWhoollieFood`.`tbRequests`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dbWhoollieFood`.`tbRequests` (
  `idRequest` INT NOT NULL AUTO_INCREMENT,
  `idOrder` INT NOT NULL,
  `desNote` VARCHAR(250) NULL,
  `vlStatus` INT NOT NULL DEFAULT 0,
  `dtRegister` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `isDeleted` TINYINT NOT NULL DEFAULT 0,
  PRIMARY KEY (`idRequest`),
  INDEX `fk_tbPedidos_tbComandas_idx` (`idOrder` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dbWhoollieFood`.`tbProductsCategories`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dbWhoollieFood`.`tbProductsCategories` (
  `idProductCategory` INT NOT NULL AUTO_INCREMENT,
  `desName` VARCHAR(45) NOT NULL,
  `dtRegister` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `isDeleted` TINYINT NOT NULL DEFAULT 0,
  PRIMARY KEY (`idProductCategory`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dbWhoollieFood`.`tbProducts`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dbWhoollieFood`.`tbProducts` (
  `idProduct` INT NOT NULL AUTO_INCREMENT,
  `idCompany` INT NOT NULL,
  `idProductCategory` INT NOT NULL,
  `vlUnity` DECIMAL(8,2) NOT NULL DEFAULT 0.00,
  `desName` VARCHAR(45) NOT NULL,
  `desNote` VARCHAR(50) NOT NULL,
  `qtStock` INT NOT NULL,
  `isActive` TINYINT NOT NULL DEFAULT 1,
  `dtRegister` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `isDeleted` TINYINT NOT NULL DEFAULT 0,
  PRIMARY KEY (`idProduct`),
  INDEX `fk_tbProdutos_tbCategoriasProdutos1_idx` (`idProductCategory` ASC),
  INDEX `fk_tbProdutos_tbEmpresas1_idx` (`idCompany` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dbWhoollieFood`.`tbRequestsProducts`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dbWhoollieFood`.`tbRequestsProducts` (
  `idRequestProduct` INT NOT NULL AUTO_INCREMENT,
  `idRequest` INT NOT NULL,
  `idProduct` INT NOT NULL,
  `qtProduct` INT NOT NULL DEFAULT 1,
  `vlUnity` DECIMAL(8,2) NOT NULL DEFAULT 0.00,
  `dtRegister` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `isDeleted` TINYINT NOT NULL DEFAULT 0,
  INDEX `fk_tbPedidos_has_tbProdutos_tbProdutos1_idx` (`idProduct` ASC),
  INDEX `fk_tbPedidos_has_tbProdutos_tbPedidos1_idx` (`idRequest` ASC),
  PRIMARY KEY (`idRequestProduct`))
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
