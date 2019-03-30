-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema u672842222_food
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema u672842222_food
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `u672842222_food` DEFAULT CHARACTER SET utf8 ;
USE `u672842222_food` ;

-- -----------------------------------------------------
-- Table `u672842222_food`.`tbCompanies`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `u672842222_food`.`tbCompanies` (
  `idCompany` INT NOT NULL AUTO_INCREMENT,
  `desName` VARCHAR(60) NOT NULL,
  `desCNPJ` VARCHAR(15) NOT NULL,
  `desChanel` VARCHAR(45) NOT NULL,
  `isActive` TINYINT NOT NULL DEFAULT 1,
  `dtRegister` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `isDeleted` TINYINT NOT NULL DEFAULT 0,
  PRIMARY KEY (`idCompany`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `u672842222_food`.`tbDepartments`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `u672842222_food`.`tbDepartments` (
  `idDepartment` INT NOT NULL AUTO_INCREMENT,
  `idCompany` INT NOT NULL,
  `desName` VARCHAR(45) NOT NULL,
  `dtRegister` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `isDeleted` TINYINT NOT NULL DEFAULT 0,
  PRIMARY KEY (`idDepartment`),
  INDEX `fk_tbDepartamentos_tbEmpresas1_idx` (`idCompany` ASC),
  CONSTRAINT `fk_tbDepartamentos_tbEmpresas1`
    FOREIGN KEY (`idCompany`)
    REFERENCES `u672842222_food`.`tbCompanies` (`idCompany`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `u672842222_food`.`tbUsers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `u672842222_food`.`tbUsers` (
  `idUser` INT NOT NULL AUTO_INCREMENT,
  `idCompany` INT NOT NULL,
  `desLogin` VARCHAR(45) NOT NULL,
  `desPassword` VARCHAR(45) NOT NULL,
  `dtRegister` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `isDeleted` TINYINT NOT NULL DEFAULT 0,
  PRIMARY KEY (`idUser`),
  INDEX `fk_tbUsers_tbCompanies1_idx` (`idCompany` ASC),
  CONSTRAINT `fk_tbUsers_tbCompanies1`
    FOREIGN KEY (`idCompany`)
    REFERENCES `u672842222_food`.`tbCompanies` (`idCompany`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `u672842222_food`.`tbEmployees`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `u672842222_food`.`tbEmployees` (
  `idEmployees` INT NOT NULL AUTO_INCREMENT,
  `idCompany` INT NOT NULL,
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
  INDEX `fk_tbFuncionarios_tbUsuarios1_idx` (`idLogin` ASC),
  INDEX `fk_tbEmployees_tbCompanies1_idx` (`idCompany` ASC),
  CONSTRAINT `fk_tbFuncionarios_tbDepartamentos1`
    FOREIGN KEY (`idDepartment`)
    REFERENCES `u672842222_food`.`tbDepartments` (`idDepartment`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tbFuncionarios_tbUsuarios1`
    FOREIGN KEY (`idLogin`)
    REFERENCES `u672842222_food`.`tbUsers` (`idUser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tbEmployees_tbCompanies1`
    FOREIGN KEY (`idCompany`)
    REFERENCES `u672842222_food`.`tbCompanies` (`idCompany`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `u672842222_food`.`tbBoards`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `u672842222_food`.`tbBoards` (
  `idBoard` INT NOT NULL AUTO_INCREMENT,
  `idCompany` INT NOT NULL,
  `qtPlaces` INT NOT NULL,
  `isActive` TINYINT NOT NULL DEFAULT 1,
  `dtRegister` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `isDeleted` TINYINT NOT NULL DEFAULT 0,
  PRIMARY KEY (`idBoard`),
  INDEX `fk_tbMesas_tbEmpresas1_idx` (`idCompany` ASC),
  CONSTRAINT `fk_tbMesas_tbEmpresas1`
    FOREIGN KEY (`idCompany`)
    REFERENCES `u672842222_food`.`tbCompanies` (`idCompany`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `u672842222_food`.`tbOrders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `u672842222_food`.`tbOrders` (
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
  INDEX `fk_tbComandas_tbMesas1_idx` (`idBoard` ASC),
  CONSTRAINT `fk_tbComandas_tbFuncionarios1`
    FOREIGN KEY (`idEmployee`)
    REFERENCES `u672842222_food`.`tbEmployees` (`idEmployees`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tbComandas_tbEmpresas1`
    FOREIGN KEY (`idCompany`)
    REFERENCES `u672842222_food`.`tbCompanies` (`idCompany`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tbComandas_tbMesas1`
    FOREIGN KEY (`idBoard`)
    REFERENCES `u672842222_food`.`tbBoards` (`idBoard`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `u672842222_food`.`tbRequests`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `u672842222_food`.`tbRequests` (
  `idRequest` INT NOT NULL AUTO_INCREMENT,
  `idOrder` INT NOT NULL,
  `desNote` VARCHAR(250) NULL,
  `vlStatus` INT NOT NULL DEFAULT 0,
  `dtRegister` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `isDeleted` TINYINT NOT NULL DEFAULT 0,
  PRIMARY KEY (`idRequest`),
  INDEX `fk_tbPedidos_tbComandas_idx` (`idOrder` ASC),
  CONSTRAINT `fk_tbPedidos_tbComandas`
    FOREIGN KEY (`idOrder`)
    REFERENCES `u672842222_food`.`tbOrders` (`idOrder`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `u672842222_food`.`tbProductsCategories`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `u672842222_food`.`tbProductsCategories` (
  `idProductCategory` INT NOT NULL AUTO_INCREMENT,
  `desName` VARCHAR(45) NOT NULL,
  `dtRegister` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `isDeleted` TINYINT NOT NULL DEFAULT 0,
  PRIMARY KEY (`idProductCategory`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `u672842222_food`.`tbProducts`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `u672842222_food`.`tbProducts` (
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
  INDEX `fk_tbProdutos_tbEmpresas1_idx` (`idCompany` ASC),
  CONSTRAINT `fk_tbProdutos_tbCategoriasProdutos1`
    FOREIGN KEY (`idProductCategory`)
    REFERENCES `u672842222_food`.`tbProductsCategories` (`idProductCategory`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tbProdutos_tbEmpresas1`
    FOREIGN KEY (`idCompany`)
    REFERENCES `u672842222_food`.`tbCompanies` (`idCompany`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `u672842222_food`.`tbRequestsProducts`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `u672842222_food`.`tbRequestsProducts` (
  `idRequestProduct` INT NOT NULL AUTO_INCREMENT,
  `idRequest` INT NOT NULL,
  `idProduct` INT NOT NULL,
  `qtProduct` INT NOT NULL DEFAULT 1,
  `vlUnity` DECIMAL(8,2) NOT NULL DEFAULT 0.00,
  `dtRegister` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `isDeleted` TINYINT NOT NULL DEFAULT 0,
  INDEX `fk_tbPedidos_has_tbProdutos_tbProdutos1_idx` (`idProduct` ASC),
  INDEX `fk_tbPedidos_has_tbProdutos_tbPedidos1_idx` (`idRequest` ASC),
  PRIMARY KEY (`idRequestProduct`),
  CONSTRAINT `fk_tbPedidos_has_tbProdutos_tbPedidos1`
    FOREIGN KEY (`idRequest`)
    REFERENCES `u672842222_food`.`tbRequests` (`idRequest`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tbPedidos_has_tbProdutos_tbProdutos1`
    FOREIGN KEY (`idProduct`)
    REFERENCES `u672842222_food`.`tbProducts` (`idProduct`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
