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
-- -----------------------------------------------------
-- Schema casa_de_estudios
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema casa_de_estudios
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `casa_de_estudios` ;
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

USE `casa_de_estudios` ;

-- -----------------------------------------------------
-- Table `casa_de_estudios`.`casa_estudios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `casa_de_estudios`.`casa_estudios` (
  `idCasaEstudios` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NULL,
  `direccion` VARCHAR(45) NULL,
  PRIMARY KEY (`idCasaEstudios`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `casa_de_estudios`.`carrera`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `casa_de_estudios`.`carrera` (
  `idCarrera` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NULL,
  `duracionSemestres` INT NULL,
  `idCasaEstudios` INT NOT NULL,
  PRIMARY KEY (`idCarrera`),
  INDEX `fk_carrera_casa_estudios1_idx` (`idCasaEstudios` ASC) VISIBLE,
  CONSTRAINT `fk_carrera_casa_estudios1`
    FOREIGN KEY (`idCasaEstudios`)
    REFERENCES `casa_de_estudios`.`casa_estudios` (`idCasaEstudios`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `casa_de_estudios`.`alumno`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `casa_de_estudios`.`alumno` (
  `idAlumno` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NULL,
  `run` VARCHAR(10) NULL,
  `direccion` VARCHAR(45) NULL,
  `idCasaEstudios` INT NOT NULL,
  `idCarrera` INT NOT NULL,
  PRIMARY KEY (`idAlumno`),
  INDEX `fk_alumno_casa_estudios1_idx` (`idCasaEstudios` ASC) VISIBLE,
  INDEX `fk_alumno_carrera1_idx` (`idCarrera` ASC) VISIBLE,
  CONSTRAINT `fk_alumno_casa_estudios1`
    FOREIGN KEY (`idCasaEstudios`)
    REFERENCES `casa_de_estudios`.`casa_estudios` (`idCasaEstudios`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_alumno_carrera1`
    FOREIGN KEY (`idCarrera`)
    REFERENCES `casa_de_estudios`.`carrera` (`idCarrera`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `casa_de_estudios`.`semestre`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `casa_de_estudios`.`semestre` (
  `idSemestre` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NULL,
  `idCarrera` INT NOT NULL,
  PRIMARY KEY (`idSemestre`),
  INDEX `fk_semestre_carrera1_idx` (`idCarrera` ASC) VISIBLE,
  CONSTRAINT `fk_semestre_carrera1`
    FOREIGN KEY (`idCarrera`)
    REFERENCES `casa_de_estudios`.`carrera` (`idCarrera`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `casa_de_estudios`.`profesor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `casa_de_estudios`.`profesor` (
  `idProfesor` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NULL,
  `edad` INT NULL,
  `profesion` VARCHAR(45) NULL,
  PRIMARY KEY (`idProfesor`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `casa_de_estudios`.`asignatura`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `casa_de_estudios`.`asignatura` (
  `idAsignatura` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NULL,
  `notas` INT NULL,
  `iidProfesor` INT NOT NULL,
  `idSemestre` INT NOT NULL,
  PRIMARY KEY (`idAsignatura`),
  INDEX `fk_asignatura_profesor_idx` (`iidProfesor` ASC) VISIBLE,
  INDEX `fk_asignatura_semestre_idx` (`idSemestre` ASC) VISIBLE,
  CONSTRAINT `fk_asignatura_profesor`
    FOREIGN KEY (`iidProfesor`)
    REFERENCES `casa_de_estudios`.`profesor` (`idProfesor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_asignatura_semestre`
    FOREIGN KEY (`idSemestre`)
    REFERENCES `casa_de_estudios`.`semestre` (`idSemestre`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
