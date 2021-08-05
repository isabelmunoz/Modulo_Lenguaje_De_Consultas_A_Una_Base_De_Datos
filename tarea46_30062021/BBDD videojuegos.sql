-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema videojuegos
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema videojuegos
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `videojuegos` DEFAULT CHARACTER SET utf8 ;
USE `videojuegos` ;

-- -----------------------------------------------------
-- Table `videojuegos`.`bodega`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `videojuegos`.`bodega` (
  `idBodega` INT NOT NULL AUTO_INCREMENT,
  `stockproducto` INT NULL,
  `nombreProducto` VARCHAR(45) NULL,
  `ubicacionProducto` VARCHAR(45) NULL,
  PRIMARY KEY (`idBodega`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `videojuegos`.`sucursal`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `videojuegos`.`sucursal` (
  `idSucursal` INT NOT NULL AUTO_INCREMENT,
  `nombreSucursal` VARCHAR(45) NULL,
  `direccionSucursal` VARCHAR(45) NULL,
  `productoVenta` VARCHAR(45) NULL,
  `idBodega` INT NULL,
  PRIMARY KEY (`idSucursal`),
  INDEX `fk_sucursal_bodega_idx` (`idBodega` ASC) VISIBLE,
  CONSTRAINT `fk_sucursal_bodega`
    FOREIGN KEY (`idBodega`)
    REFERENCES `videojuegos`.`bodega` (`idBodega`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `videojuegos`.`cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `videojuegos`.`cliente` (
  `idCliente` INT NOT NULL AUTO_INCREMENT,
  `nombreCliente` VARCHAR(45) NULL,
  `direccionCliente` VARCHAR(45) NULL,
  `runCliente` VARCHAR(45) NULL,
  `tipoCliente` VARCHAR(45) NULL,
  `idSucursal` INT NULL,
  PRIMARY KEY (`idCliente`),
  INDEX `fk_cliente_sucursal_idx` (`idSucursal` ASC) VISIBLE,
  CONSTRAINT `fk_cliente_sucursal`
    FOREIGN KEY (`idSucursal`)
    REFERENCES `videojuegos`.`sucursal` (`idSucursal`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `videojuegos`.`empleado`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `videojuegos`.`empleado` (
  `idEmpleado` INT NOT NULL AUTO_INCREMENT,
  `nombreEmpleado` VARCHAR(45) NULL,
  `runEmpleado` VARCHAR(45) NULL,
  `antiguedadEmpleado` VARCHAR(10) NULL,
  `cargoEmpleado` VARCHAR(45) NULL,
  `idSucursal` INT NULL,
  PRIMARY KEY (`idEmpleado`),
  INDEX `fk_empleado_sucursal_idx` (`idSucursal` ASC) VISIBLE,
  CONSTRAINT `fk_empleado_sucursal`
    FOREIGN KEY (`idSucursal`)
    REFERENCES `videojuegos`.`sucursal` (`idSucursal`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `videojuegos`.`producto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `videojuegos`.`producto` (
  `idProducto` INT NOT NULL AUTO_INCREMENT,
  `nombreProducto` VARCHAR(45) NULL,
  `codigoProducto` VARCHAR(45) NOT NULL,
  `cantidadProducto` INT NULL,
  `categoria` VARCHAR(45) NULL,
  PRIMARY KEY (`idProducto`, `codigoProducto`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `videojuegos`.`detalleVenta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `videojuegos`.`detalleVenta` (
  `idDetalleVenta` INT NOT NULL AUTO_INCREMENT,
  `idProducto` INT NULL,
  `idCliente` INT NULL,
  `formaPago` VARCHAR(45) NULL,
  PRIMARY KEY (`idDetalleVenta`),
  INDEX `ok_producto_cliente_idx` (`idCliente` ASC) VISIBLE,
  INDEX `fk_detalleVenta_producto_idx` (`idProducto` ASC) VISIBLE,
  CONSTRAINT `fk_detalleVenta_cliente`
    FOREIGN KEY (`idCliente`)
    REFERENCES `videojuegos`.`cliente` (`idCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_detalleVenta_producto`
    FOREIGN KEY (`idProducto`)
    REFERENCES `videojuegos`.`producto` (`idProducto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
