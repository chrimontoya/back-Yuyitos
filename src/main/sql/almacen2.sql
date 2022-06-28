-- MySQL Script generated by MySQL Workbench
-- Tue Jun 28 02:44:40 2022
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema almacen
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema almacen
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `almacen` DEFAULT CHARACTER SET utf8mb3 ;
USE `almacen` ;

-- -----------------------------------------------------
-- Table `almacen`.`categoria`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `almacen`.`categoria` ;

CREATE TABLE IF NOT EXISTS `almacen`.`categoria` (
                                                     `id_categoria` INT NOT NULL AUTO_INCREMENT,
                                                     `nombre` VARCHAR(100) NOT NULL,
                                                     PRIMARY KEY (`id_categoria`))
    ENGINE = InnoDB
    DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `almacen`.`fiado`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `almacen`.`fiado` ;

CREATE TABLE IF NOT EXISTS `almacen`.`fiado` (
                                                 `id_deuda` INT NOT NULL AUTO_INCREMENT,
                                                 `estado` TINYINT NOT NULL,
                                                 PRIMARY KEY (`id_deuda`))
    ENGINE = InnoDB
    DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `almacen`.`cliente`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `almacen`.`cliente` ;

CREATE TABLE IF NOT EXISTS `almacen`.`cliente` (
                                                   `id_cliente` INT NOT NULL AUTO_INCREMENT,
                                                   `rut` INT NOT NULL,
                                                   `dv` VARCHAR(1) NOT NULL,
                                                   `nombres` VARCHAR(100) NULL DEFAULT NULL,
                                                   `apellido_paterno` VARCHAR(100) NULL DEFAULT NULL,
                                                   `apellido_materno` VARCHAR(100) NULL DEFAULT NULL,
                                                   `FIADO_id_fiado` INT NOT NULL,
                                                   PRIMARY KEY (`id_cliente`),
                                                   INDEX `fk_CLIENTE_DEUDA1_idx` (`FIADO_id_fiado` ASC) VISIBLE,
                                                   CONSTRAINT `fk_CLIENTE_DEUDA1`
                                                       FOREIGN KEY (`FIADO_id_fiado`)
                                                           REFERENCES `almacen`.`fiado` (`id_deuda`))
    ENGINE = InnoDB
    DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `almacen`.`rubro`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `almacen`.`rubro` ;

CREATE TABLE IF NOT EXISTS `almacen`.`rubro` (
                                                 `id_rubro` INT NOT NULL AUTO_INCREMENT,
                                                 `nombre` VARCHAR(100) NOT NULL,
                                                 PRIMARY KEY (`id_rubro`))
    ENGINE = InnoDB
    DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `almacen`.`proveedor`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `almacen`.`proveedor` ;

CREATE TABLE IF NOT EXISTS `almacen`.`proveedor` (
                                                     `id_proveedor` INT NOT NULL AUTO_INCREMENT,
                                                     `rut` INT NOT NULL,
                                                     `dv` VARCHAR(1) NOT NULL,
                                                     `nombre` VARCHAR(100) NOT NULL,
                                                     `RUBRO_id_rubro` INT NOT NULL,
                                                     PRIMARY KEY (`id_proveedor`),
                                                     INDEX `fk_PROVEEDOR_RUBRO1_idx` (`RUBRO_id_rubro` ASC) VISIBLE,
                                                     CONSTRAINT `fk_PROVEEDOR_RUBRO1`
                                                         FOREIGN KEY (`RUBRO_id_rubro`)
                                                             REFERENCES `almacen`.`rubro` (`id_rubro`)
                                                             ON DELETE CASCADE
                                                             ON UPDATE CASCADE)
    ENGINE = InnoDB
    DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `almacen`.`contacto`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `almacen`.`contacto` ;

CREATE TABLE IF NOT EXISTS `almacen`.`contacto` (
                                                    `id_contacto` INT NOT NULL AUTO_INCREMENT,
                                                    `email` VARCHAR(100) NOT NULL,
                                                    `telefono` INT NOT NULL,
                                                    `PROVEEDOR_id_proveedor` INT NOT NULL,
                                                    PRIMARY KEY (`id_contacto`),
                                                    INDEX `fk_CONTACTO_PROVEEDOR1_idx` (`PROVEEDOR_id_proveedor` ASC) VISIBLE,
                                                    CONSTRAINT `fk_CONTACTO_PROVEEDOR1`
                                                        FOREIGN KEY (`PROVEEDOR_id_proveedor`)
                                                            REFERENCES `almacen`.`proveedor` (`id_proveedor`)
                                                            ON DELETE CASCADE
                                                            ON UPDATE CASCADE)
    ENGINE = InnoDB
    DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `almacen`.`orden`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `almacen`.`orden` ;

CREATE TABLE IF NOT EXISTS `almacen`.`orden` (
                                                 `id_orden` INT NOT NULL AUTO_INCREMENT,
                                                 `fecha` DATE NOT NULL,
                                                 `estado` TINYINT NOT NULL,
                                                 `PROVEEDOR_id_proveedor` INT NOT NULL,
                                                 PRIMARY KEY (`id_orden`),
                                                 INDEX `fk_ORDEN_PROVEEDOR1_idx` (`PROVEEDOR_id_proveedor` ASC) VISIBLE,
                                                 CONSTRAINT `fk_ORDEN_PROVEEDOR1`
                                                     FOREIGN KEY (`PROVEEDOR_id_proveedor`)
                                                         REFERENCES `almacen`.`proveedor` (`id_proveedor`))
    ENGINE = InnoDB
    DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `almacen`.`tipo_categoria`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `almacen`.`tipo_categoria` ;

CREATE TABLE IF NOT EXISTS `almacen`.`tipo_categoria` (
                                                          `id_tipo_categoria` INT NOT NULL AUTO_INCREMENT,
                                                          `nombre` VARCHAR(100) NOT NULL,
                                                          `CATEGORIA_id_categoria` INT NOT NULL,
                                                          PRIMARY KEY (`id_tipo_categoria`),
                                                          INDEX `fk_TIPO_CATEGORIA_CATEGORIA1_idx` (`CATEGORIA_id_categoria` ASC) VISIBLE,
                                                          CONSTRAINT `fk_TIPO_CATEGORIA_CATEGORIA1`
                                                              FOREIGN KEY (`CATEGORIA_id_categoria`)
                                                                  REFERENCES `almacen`.`categoria` (`id_categoria`))
    ENGINE = InnoDB
    DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `almacen`.`producto`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `almacen`.`producto` ;

CREATE TABLE IF NOT EXISTS `almacen`.`producto` (
                                                    `id_producto` INT NOT NULL AUTO_INCREMENT,
                                                    `nombre` VARCHAR(100) NOT NULL,
                                                    `cantidad` INT NOT NULL,
                                                    `fecha_vencimiento` DATE NULL DEFAULT NULL,
                                                    `imagen` BLOB NULL DEFAULT NULL,
                                                    `TIPO_CATEGORIA_id_tipo_categoria` INT NOT NULL,
                                                    `precio` INT NOT NULL,
                                                    PRIMARY KEY (`id_producto`),
                                                    INDEX `fk_PRODUCTO_TIPO_CATEGORIA1_idx` (`TIPO_CATEGORIA_id_tipo_categoria` ASC) VISIBLE,
                                                    CONSTRAINT `fk_PRODUCTO_TIPO_CATEGORIA1`
                                                        FOREIGN KEY (`TIPO_CATEGORIA_id_tipo_categoria`)
                                                            REFERENCES `almacen`.`tipo_categoria` (`id_tipo_categoria`))
    ENGINE = InnoDB
    DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `almacen`.`detalle_orden`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `almacen`.`detalle_orden` ;

CREATE TABLE IF NOT EXISTS `almacen`.`detalle_orden` (
                                                         `id_detalle_orden` INT NOT NULL AUTO_INCREMENT,
                                                         `cantidad` INT NOT NULL,
                                                         `monto` INT NOT NULL,
                                                         `fecha_vencimiento` DATE NOT NULL,
                                                         `PRODUCTO_id_producto` INT NOT NULL,
                                                         `ORDEN_id_orden` INT NOT NULL,
                                                         PRIMARY KEY (`id_detalle_orden`),
                                                         INDEX `fk_DETALLE_ORDEN_PRODUCTO1_idx` (`PRODUCTO_id_producto` ASC) VISIBLE,
                                                         INDEX `fk_DETALLE_ORDEN_ORDEN1_idx` (`ORDEN_id_orden` ASC) VISIBLE,
                                                         CONSTRAINT `fk_DETALLE_ORDEN_ORDEN1`
                                                             FOREIGN KEY (`ORDEN_id_orden`)
                                                                 REFERENCES `almacen`.`orden` (`id_orden`),
                                                         CONSTRAINT `fk_DETALLE_ORDEN_PRODUCTO1`
                                                             FOREIGN KEY (`PRODUCTO_id_producto`)
                                                                 REFERENCES `almacen`.`producto` (`id_producto`))
    ENGINE = InnoDB
    DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `almacen`.`venta`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `almacen`.`venta` ;

CREATE TABLE IF NOT EXISTS `almacen`.`venta` (
                                                 `id_venta` INT NOT NULL AUTO_INCREMENT,
                                                 `fecha` DATE NOT NULL,
                                                 `CLIENTE_id_cliente` INT NOT NULL,
                                                 PRIMARY KEY (`id_venta`),
                                                 INDEX `fk_VENTA_CLIENTE1_idx` (`CLIENTE_id_cliente` ASC) VISIBLE,
                                                 CONSTRAINT `fk_VENTA_CLIENTE1`
                                                     FOREIGN KEY (`CLIENTE_id_cliente`)
                                                         REFERENCES `almacen`.`cliente` (`id_cliente`))
    ENGINE = InnoDB
    DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `almacen`.`detalle_venta`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `almacen`.`detalle_venta` ;

CREATE TABLE IF NOT EXISTS `almacen`.`detalle_venta` (
                                                         `id_detalle_venta` INT NOT NULL AUTO_INCREMENT,
                                                         `cantidad` INT NOT NULL,
                                                         `VENTA_id_venta` INT NOT NULL,
                                                         `PRODUCTO_id_producto` INT NOT NULL,
                                                         PRIMARY KEY (`id_detalle_venta`),
                                                         INDEX `fk_DETALLE_VENTA_VENTA1_idx` (`VENTA_id_venta` ASC) VISIBLE,
                                                         INDEX `fk_PRODUCTO_producto_idx` (`PRODUCTO_id_producto` ASC) VISIBLE,
                                                         CONSTRAINT `fk_DETALLE_VENTA_VENTA1`
                                                             FOREIGN KEY (`VENTA_id_venta`)
                                                                 REFERENCES `almacen`.`venta` (`id_venta`),
                                                         CONSTRAINT `fk_PRODUCTO_producto`
                                                             FOREIGN KEY (`PRODUCTO_id_producto`)
                                                                 REFERENCES `almacen`.`producto` (`id_producto`)
                                                                 ON DELETE RESTRICT
                                                                 ON UPDATE RESTRICT)
    ENGINE = InnoDB
    DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `almacen`.`deuda`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `almacen`.`deuda` ;

CREATE TABLE IF NOT EXISTS `almacen`.`deuda` (
                                                 `id_deuda` INT NOT NULL,
                                                 `id_venta` INT NOT NULL,
                                                 `id_cliente` INT NOT NULL,
                                                 PRIMARY KEY (`id_deuda`))
    ENGINE = InnoDB
    DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `almacen`.`recepcion`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `almacen`.`recepcion` ;

CREATE TABLE IF NOT EXISTS `almacen`.`recepcion` (
                                                     `id_recepcion` INT NOT NULL AUTO_INCREMENT,
                                                     `id_producto` INT NOT NULL,
                                                     `id_orden` INT NOT NULL,
                                                     `fecha` DATE NOT NULL,
                                                     PRIMARY KEY (`id_recepcion`))
    ENGINE = InnoDB
    DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `almacen`.`rol`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `almacen`.`rol` ;

CREATE TABLE IF NOT EXISTS `almacen`.`rol` (
                                               `id_rol` INT NOT NULL AUTO_INCREMENT,
                                               `usuario` VARCHAR(45) NOT NULL,
                                               PRIMARY KEY (`id_rol`),
                                               UNIQUE INDEX `id_rol_UNIQUE` (`id_rol` ASC) VISIBLE)
    ENGINE = InnoDB
    DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `almacen`.`usuario`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `almacen`.`usuario` ;

CREATE TABLE IF NOT EXISTS `almacen`.`usuario` (
                                                   `id_usuario` INT NOT NULL AUTO_INCREMENT,
                                                   `usuario` VARCHAR(45) NOT NULL,
                                                   `password` VARCHAR(45) NULL DEFAULT NULL,
                                                   `ROL_id_rol` INT NOT NULL,
                                                   PRIMARY KEY (`id_usuario`),
                                                   UNIQUE INDEX `id_usuario_UNIQUE` (`id_usuario` ASC) VISIBLE,
                                                   INDEX `fk_usuario_rol1_idx` (`ROL_id_rol` ASC) VISIBLE,
                                                   CONSTRAINT `fk_usuario_rol1`
                                                       FOREIGN KEY (`ROL_id_rol`)
                                                           REFERENCES `almacen`.`rol` (`id_rol`))
    ENGINE = InnoDB
    DEFAULT CHARACTER SET = utf8mb3;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
