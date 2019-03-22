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
-- Table `dbWhoollieFood`.`tbEmpresas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dbWhoollieFood`.`tbEmpresas` (
  `idEmpresa` INT NOT NULL AUTO_INCREMENT,
  `desNome` VARCHAR(60) NOT NULL,
  `desCNPJ` VARCHAR(15) NOT NULL,
  `eAtivo` TINYINT NOT NULL DEFAULT 1,
  `dtRegistro` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `eDeletado` TINYINT NOT NULL DEFAULT 0,
  PRIMARY KEY (`idEmpresa`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dbWhoollieFood`.`tbDepartamentos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dbWhoollieFood`.`tbDepartamentos` (
  `idDepartamento` INT NOT NULL AUTO_INCREMENT,
  `idEmpresa` INT NOT NULL,
  `desDescricao` VARCHAR(45) NOT NULL,
  `dtRegistro` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `eDeletado` TINYINT NOT NULL DEFAULT 0,
  PRIMARY KEY (`idDepartamento`),
  INDEX `fk_tbDepartamentos_tbEmpresas1_idx` (`idEmpresa` ASC),
  CONSTRAINT `fk_tbDepartamentos_tbEmpresas1`
    FOREIGN KEY (`idEmpresa`)
    REFERENCES `dbWhoollieFood`.`tbEmpresas` (`idEmpresa`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dbWhoollieFood`.`tbUsuarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dbWhoollieFood`.`tbUsuarios` (
  `idUsuario` INT NOT NULL AUTO_INCREMENT,
  `desLogin` VARCHAR(45) NOT NULL,
  `desSenha` VARCHAR(45) NOT NULL,
  `dtRegistro` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `eDeletado` TINYINT NOT NULL DEFAULT 0,
  PRIMARY KEY (`idUsuario`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dbWhoollieFood`.`tbFuncionarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dbWhoollieFood`.`tbFuncionarios` (
  `idFuncionario` INT NOT NULL AUTO_INCREMENT,
  `idDepartamento` INT NOT NULL,
  `idLogin` INT NULL,
  `desNome` VARCHAR(100) NOT NULL,
  `desCPF` VARCHAR(11) NOT NULL,
  `dtNascimento` DATE NOT NULL,
  `eAtivo` TINYINT NOT NULL DEFAULT 1,
  `dtRegistro` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `eDeletado` TINYINT NOT NULL DEFAULT 0,
  PRIMARY KEY (`idFuncionario`),
  INDEX `fk_tbFuncionarios_tbDepartamentos1_idx` (`idDepartamento` ASC),
  INDEX `fk_tbFuncionarios_tbUsuarios1_idx` (`idLogin` ASC),
  CONSTRAINT `fk_tbFuncionarios_tbDepartamentos1`
    FOREIGN KEY (`idDepartamento`)
    REFERENCES `dbWhoollieFood`.`tbDepartamentos` (`idDepartamento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tbFuncionarios_tbUsuarios1`
    FOREIGN KEY (`idLogin`)
    REFERENCES `dbWhoollieFood`.`tbUsuarios` (`idUsuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dbWhoollieFood`.`tbMesas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dbWhoollieFood`.`tbMesas` (
  `idMesa` INT NOT NULL AUTO_INCREMENT,
  `idEmpresa` INT NOT NULL,
  `qtdLugares` INT NOT NULL,
  `eAtivo` TINYINT NOT NULL DEFAULT 1,
  `dtRegistro` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `eDeletado` TINYINT NOT NULL DEFAULT 0,
  PRIMARY KEY (`idMesa`),
  INDEX `fk_tbMesas_tbEmpresas1_idx` (`idEmpresa` ASC),
  CONSTRAINT `fk_tbMesas_tbEmpresas1`
    FOREIGN KEY (`idEmpresa`)
    REFERENCES `dbWhoollieFood`.`tbEmpresas` (`idEmpresa`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dbWhoollieFood`.`tbComandas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dbWhoollieFood`.`tbComandas` (
  `idComanda` INT NOT NULL AUTO_INCREMENT,
  `idEmpresa` INT NOT NULL,
  `idFuncionario` INT NOT NULL,
  `idMesa` INT NOT NULL,
  `vlDesconto` DECIMAL(3,1) NULL DEFAULT 0.00,
  `vlStatus` INT NOT NULL DEFAULT 0,
  `dtRegistro` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `eDeletado` TINYINT NOT NULL DEFAULT 0,
  PRIMARY KEY (`idComanda`),
  INDEX `fk_tbComandas_tbFuncionarios1_idx` (`idFuncionario` ASC),
  INDEX `fk_tbComandas_tbEmpresas1_idx` (`idEmpresa` ASC),
  INDEX `fk_tbComandas_tbMesas1_idx` (`idMesa` ASC),
  CONSTRAINT `fk_tbComandas_tbFuncionarios1`
    FOREIGN KEY (`idFuncionario`)
    REFERENCES `dbWhoollieFood`.`tbFuncionarios` (`idFuncionario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tbComandas_tbEmpresas1`
    FOREIGN KEY (`idEmpresa`)
    REFERENCES `dbWhoollieFood`.`tbEmpresas` (`idEmpresa`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tbComandas_tbMesas1`
    FOREIGN KEY (`idMesa`)
    REFERENCES `dbWhoollieFood`.`tbMesas` (`idMesa`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dbWhoollieFood`.`tbPedidos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dbWhoollieFood`.`tbPedidos` (
  `idPedido` INT NOT NULL AUTO_INCREMENT,
  `idComanda` INT NOT NULL,
  `desObservacao` VARCHAR(250) NULL,
  `vlStatus` INT NOT NULL DEFAULT 0,
  `dtRegistro` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `eDeletado` TINYINT NOT NULL DEFAULT 0,
  PRIMARY KEY (`idPedido`),
  INDEX `fk_tbPedidos_tbComandas_idx` (`idComanda` ASC),
  CONSTRAINT `fk_tbPedidos_tbComandas`
    FOREIGN KEY (`idComanda`)
    REFERENCES `dbWhoollieFood`.`tbComandas` (`idComanda`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dbWhoollieFood`.`tbCategoriasProdutos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dbWhoollieFood`.`tbCategoriasProdutos` (
  `idCategoriaProduto` INT NOT NULL AUTO_INCREMENT,
  `desDescricao` VARCHAR(45) NOT NULL,
  `dtRegistro` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `eDeletado` TINYINT NOT NULL DEFAULT 0,
  PRIMARY KEY (`idCategoriaProduto`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dbWhoollieFood`.`tbProdutos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dbWhoollieFood`.`tbProdutos` (
  `idProduto` INT NOT NULL AUTO_INCREMENT,
  `idEmpresa` INT NOT NULL,
  `idCategoriaProduto` INT NOT NULL,
  `vlUnitario` DECIMAL(8,2) NOT NULL DEFAULT 0.00,
  `desDescricao` VARCHAR(50) NOT NULL,
  `eAtivo` TINYINT NOT NULL DEFAULT 1,
  `dtRegistro` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `eDeletado` TINYINT NOT NULL DEFAULT 0,
  PRIMARY KEY (`idProduto`),
  INDEX `fk_tbProdutos_tbCategoriasProdutos1_idx` (`idCategoriaProduto` ASC),
  INDEX `fk_tbProdutos_tbEmpresas1_idx` (`idEmpresa` ASC),
  CONSTRAINT `fk_tbProdutos_tbCategoriasProdutos1`
    FOREIGN KEY (`idCategoriaProduto`)
    REFERENCES `dbWhoollieFood`.`tbCategoriasProdutos` (`idCategoriaProduto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tbProdutos_tbEmpresas1`
    FOREIGN KEY (`idEmpresa`)
    REFERENCES `dbWhoollieFood`.`tbEmpresas` (`idEmpresa`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dbWhoollieFood`.`tbPedidosProdutos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dbWhoollieFood`.`tbPedidosProdutos` (
  `idPedidoProduto` INT NOT NULL AUTO_INCREMENT,
  `idPedido` INT NOT NULL,
  `idProduto` INT NOT NULL,
  `qtdProduto` INT NOT NULL DEFAULT 1,
  `vlUnitario` DECIMAL(8,2) NOT NULL DEFAULT 0.00,
  `dtRegistro` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `eDeletado` TINYINT NOT NULL DEFAULT 0,
  INDEX `fk_tbPedidos_has_tbProdutos_tbProdutos1_idx` (`idProduto` ASC),
  INDEX `fk_tbPedidos_has_tbProdutos_tbPedidos1_idx` (`idPedido` ASC),
  PRIMARY KEY (`idPedidoProduto`),
  CONSTRAINT `fk_tbPedidos_has_tbProdutos_tbPedidos1`
    FOREIGN KEY (`idPedido`)
    REFERENCES `dbWhoollieFood`.`tbPedidos` (`idPedido`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tbPedidos_has_tbProdutos_tbProdutos1`
    FOREIGN KEY (`idProduto`)
    REFERENCES `dbWhoollieFood`.`tbProdutos` (`idProduto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
