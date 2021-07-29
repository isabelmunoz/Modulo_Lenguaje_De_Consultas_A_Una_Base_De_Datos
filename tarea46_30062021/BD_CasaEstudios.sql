-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema casa_de_estudio
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema casa_de_estudio
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `casa_de_estudio` DEFAULT CHARACTER SET utf8 ;
USE `casa_de_estudio` ;

-- -----------------------------------------------------
-- Table `casa_de_estudio`.`bodega`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `casa_de_estudio`.`bodega` (
  `idBodega` INT NOT NULL AUTO_INCREMENT,
  `stockProducto` INT NULL,
  `nombreProducto` VARCHAR(45) NULL,
  `ubicacionProducto` VARCHAR(45) NULL,
  PRIMARY KEY (`idBodega`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `casa_de_estudio`.`sucursal`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `casa_de_estudio`.`sucursal` (
  `idSucursal` INT NOT NULL AUTO_INCREMENT,
  `nombreSucursal` VARCHAR(45) NULL,
  `direccionSucursal` VARCHAR(45) NULL,
  `productoVenta` VARCHAR(45) NULL,
  `idBodega` INT NULL,
  PRIMARY KEY (`idSucursal`),
  INDEX `fk_sucursal_bodega_idx` (`idBodega` ASC),
  CONSTRAINT `fk_sucursal_bodega`
    FOREIGN KEY (`idBodega`)
    REFERENCES `casa_de_estudio`.`bodega` (`idBodega`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `casa_de_estudio`.`empleado`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `casa_de_estudio`.`empleado` (
  `idempleado` INT NOT NULL AUTO_INCREMENT,
  `nombreEmpleado` VARCHAR(45) NULL,
  `runEmpleado` VARCHAR(45) NULL,
  `antiguedadEmpleado` VARCHAR(10) NULL,
  `cargoEmpleado` VARCHAR(45) NULL,
  `idSucursal` INT NULL,
  PRIMARY KEY (`idempleado`),
  INDEX `fk_empleado_sucursal_idx` (`idSucursal` ASC),
  CONSTRAINT `fk_empleado_sucursal`
    FOREIGN KEY (`idSucursal`)
    REFERENCES `casa_de_estudio`.`sucursal` (`idSucursal`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `casa_de_estudio`.`cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `casa_de_estudio`.`cliente` (
  `idCliente` INT NOT NULL AUTO_INCREMENT,
  `nombreCliente` VARCHAR(45) NULL,
  `direccionCliente` VARCHAR(45) NULL,
  `runCliente` VARCHAR(10) NULL,
  `tipoCliente` VARCHAR(45) NULL,
  `idSucursal` INT NULL,
  `clientecol` VARCHAR(45) NULL,
  PRIMARY KEY (`idCliente`),
  INDEX `fk_cliente_sucursal_idx` (`idSucursal` ASC),
  CONSTRAINT `fk_cliente_sucursal`
    FOREIGN KEY (`idSucursal`)
    REFERENCES `casa_de_estudio`.`sucursal` (`idSucursal`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `casa_de_estudio`.`producto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `casa_de_estudio`.`producto` (
  `idProducto` INT NOT NULL AUTO_INCREMENT,
  `nombreProducto` VARCHAR(45) NULL,
  `codigoProducto` VARCHAR(45) NULL,
  `cantidadProducto` VARCHAR(45) NULL,
  `categoria` VARCHAR(45) NULL,
  PRIMARY KEY (`idProducto`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `casa_de_estudio`.`detalleVenta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `casa_de_estudio`.`detalleVenta` (
  `idDetalleVenta` INT NOT NULL AUTO_INCREMENT,
  `idProducto` INT NOT NULL,
  `idCliente` INT NOT NULL,
  PRIMARY KEY (`idDetalleVenta`),
  INDEX `fk_DetalleVenta_Cliente_idx` (`idCliente` ASC),
  INDEX `fk_DetalleVenta_Producto_idx` (`idProducto` ASC),
  CONSTRAINT `fk_DetalleVenta_Cliente`
    FOREIGN KEY (`idCliente`)
    REFERENCES `casa_de_estudio`.`cliente` (`idCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_DetalleVenta_Producto`
    FOREIGN KEY (`idProducto`)
    REFERENCES `casa_de_estudio`.`producto` (`idProducto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `casa_de_estudio`.`casa estudios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `casa_de_estudio`.`casa estudios` (
  `idCasaEstudios` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NULL,
  `direccion` VARCHAR(45) NULL,
  PRIMARY KEY (`idCasaEstudios`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `casa_de_estudio`.`carrera`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `casa_de_estudio`.`carrera` (
  `idCarrera` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NULL,
  `duracion` INT NULL,
  `idCasaEstudios` INT NULL,
  PRIMARY KEY (`idCarrera`),
  INDEX `fk_carrera_casaestudios_idx` (`idCasaEstudios` ASC),
  CONSTRAINT `fk_carrera_casaestudios`
    FOREIGN KEY (`idCasaEstudios`)
    REFERENCES `casa_de_estudio`.`casa estudios` (`idCasaEstudios`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `casa_de_estudio`.`alumno`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `casa_de_estudio`.`alumno` (
  `idAlumno` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(10) NULL,
  `run` VARCHAR(3) NULL,
  `direccion` VARCHAR(45) NULL,
  `edad` INT NULL,
  `idCasaEstudios` INT NULL,
  `idCarrera` INT NULL,
  `alumnocol` VARCHAR(45) NULL,
  PRIMARY KEY (`idAlumno`),
  INDEX `fk_alumno_casaestudios_idx` (`idCasaEstudios` ASC),
  INDEX `fk_alumno_carrera_idx` (`idCarrera` ASC),
  CONSTRAINT `fk_alumno_casaestudios`
    FOREIGN KEY (`idCasaEstudios`)
    REFERENCES `casa_de_estudio`.`casa estudios` (`idCasaEstudios`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_alumno_carrera`
    FOREIGN KEY (`idCarrera`)
    REFERENCES `casa_de_estudio`.`carrera` (`idCarrera`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `casa_de_estudio`.`semestre`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `casa_de_estudio`.`semestre` (
  `idSemestre` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NULL,
  `idCarrera` INT NULL,
  PRIMARY KEY (`idSemestre`),
  INDEX `fk_semestre:carrera_idx` (`idCarrera` ASC),
  CONSTRAINT `fk_semestre:carrera`
    FOREIGN KEY (`idCarrera`)
    REFERENCES `casa_de_estudio`.`carrera` (`idCarrera`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `casa_de_estudio`.`profesor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `casa_de_estudio`.`profesor` (
  `idProfesor` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NULL,
  `edad` INT NULL,
  `profesion` VARCHAR(45) NULL,
  PRIMARY KEY (`idProfesor`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `casa_de_estudio`.`asignatura`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `casa_de_estudio`.`asignatura` (
  `idAsignatura` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NULL,
  `notas` VARCHAR(45) NULL,
  `idSemestre` INT NULL,
  `profesor_idProfesor` INT NOT NULL,
  PRIMARY KEY (`idAsignatura`),
  INDEX `fk_semestres_asignatura_idx` (`idSemestre` ASC),
  INDEX `fk_asignatura_profesor1_idx` (`profesor_idProfesor` ASC),
  CONSTRAINT `fk_semestres_asignatura`
    FOREIGN KEY (`idSemestre`)
    REFERENCES `casa_de_estudio`.`semestre` (`idSemestre`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_asignatura_profesor1`
    FOREIGN KEY (`profesor_idProfesor`)
    REFERENCES `casa_de_estudio`.`profesor` (`idProfesor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
