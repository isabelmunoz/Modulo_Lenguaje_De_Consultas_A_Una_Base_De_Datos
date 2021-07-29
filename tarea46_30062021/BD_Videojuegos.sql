-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`bodega`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`bodega` (
  `idBodega` INT NOT NULL AUTO_INCREMENT,
  `stockProducto` INT NULL,
  `nombreProducto` VARCHAR(45) NULL,
  `ubicacionProducto` VARCHAR(45) NULL,
  PRIMARY KEY (`idBodega`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`sucursal`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`sucursal` (
  `idSucursal` INT NOT NULL AUTO_INCREMENT,
  `nombreSucursal` VARCHAR(45) NULL,
  `direccionSucursal` VARCHAR(45) NULL,
  `productoVenta` VARCHAR(45) NULL,
  `idBodega` INT NULL,
  PRIMARY KEY (`idSucursal`),
  INDEX `fk_sucursal_bodega_idx` (`idBodega` ASC) VISIBLE,
  CONSTRAINT `fk_sucursal_bodega`
    FOREIGN KEY (`idBodega`)
    REFERENCES `mydb`.`bodega` (`idBodega`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`empleado`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`empleado` (
  `idempleado` INT NOT NULL AUTO_INCREMENT,
  `nombreEmpleado` VARCHAR(45) NULL,
  `runEmpleado` VARCHAR(45) NULL,
  `antiguedadEmpleado` VARCHAR(10) NULL,
  `cargoEmpleado` VARCHAR(45) NULL,
  `idSucursal` INT NULL,
  PRIMARY KEY (`idempleado`),
  INDEX `fk_empleado_sucursal_idx` (`idSucursal` ASC) VISIBLE,
  CONSTRAINT `fk_empleado_sucursal`
    FOREIGN KEY (`idSucursal`)
    REFERENCES `mydb`.`sucursal` (`idSucursal`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`cliente` (
  `idCliente` INT NOT NULL AUTO_INCREMENT,
  `nombreCliente` VARCHAR(45) NULL,
  `direccionCliente` VARCHAR(45) NULL,
  `runCliente` VARCHAR(10) NULL,
  `tipoCliente` VARCHAR(45) NULL,
  `idSucursal` INT NULL,
  `clientecol` VARCHAR(45) NULL,
  PRIMARY KEY (`idCliente`),
  INDEX `fk_cliente_sucursal_idx` (`idSucursal` ASC) VISIBLE,
  CONSTRAINT `fk_cliente_sucursal`
    FOREIGN KEY (`idSucursal`)
    REFERENCES `mydb`.`sucursal` (`idSucursal`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`producto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`producto` (
  `idProducto` INT NOT NULL AUTO_INCREMENT,
  `nombreProducto` VARCHAR(45) NULL,
  `codigoProducto` VARCHAR(45) NULL,
  `cantidadProducto` VARCHAR(45) NULL,
  `categoria` VARCHAR(45) NULL,
  PRIMARY KEY (`idProducto`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`detalleVenta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`detalleVenta` (
  `idDetalleVenta` INT NOT NULL AUTO_INCREMENT,
  `idProducto` INT NOT NULL,
  `idCliente` INT NOT NULL,
  PRIMARY KEY (`idDetalleVenta`),
  INDEX `fk_DetalleVenta_Cliente_idx` (`idCliente` ASC) VISIBLE,
  INDEX `fk_DetalleVenta_Producto_idx` (`idProducto` ASC) VISIBLE,
  CONSTRAINT `fk_DetalleVenta_Cliente`
    FOREIGN KEY (`idCliente`)
    REFERENCES `mydb`.`cliente` (`idCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_DetalleVenta_Producto`
    FOREIGN KEY (`idProducto`)
    REFERENCES `mydb`.`producto` (`idProducto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
