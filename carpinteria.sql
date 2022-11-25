#CREATE DATABASE carpinteria;
USE carpinteria;

-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema carpinteria
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `carpinteria` ;

-- -----------------------------------------------------
-- Schema carpinteria
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `carpinteria` DEFAULT CHARACTER SET utf8 ;
USE `carpinteria` ;

-- -----------------------------------------------------
-- Table `carpinteria`.`productos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `carpinteria`.`productos` (
  `productos_id` INT NOT NULL AUTO_INCREMENT,
  `modelo` VARCHAR(255) NOT NULL,
  `precio_en_pesos` INT NOT NULL,
  PRIMARY KEY (`productos_id`));


-- -----------------------------------------------------
-- Table `carpinteria`.`almacen`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `carpinteria`.`almacen` (
  `almacen_id` INT NOT NULL AUTO_INCREMENT,
  `productos_id` INT NOT NULL,
  `cantidad` INT NOT NULL,
  `fecha` DATETIME NOT NULL,
  PRIMARY KEY (`almacen_id`),
  INDEX `fk_almacen_productos1_idx` (`productos_id` ASC) VISIBLE,
  CONSTRAINT `fk_almacen_productos1`
    FOREIGN KEY (`productos_id`)
    REFERENCES `carpinteria`.`productos` (`productos_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `carpinteria`.`clientes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `carpinteria`.`clientes` (
  `cliente_id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(40) NOT NULL,
  `email` VARCHAR(255) NOT NULL,
  `telefono` BIGINT(13) NOT NULL,
  PRIMARY KEY (`cliente_id`));


-- -----------------------------------------------------
-- Table `carpinteria`.`pedidos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `carpinteria`.`pedidos` (
  `pedido_id` INT NOT NULL AUTO_INCREMENT,
  `cantidad` INT NOT NULL,
  `fecha` DATETIME NOT NULL,
  `almacen_id` INT NOT NULL,
  `cliente_id` INT NOT NULL,
  PRIMARY KEY (`pedido_id`),
  INDEX `fk_pedidos_clientes_idx` (`cliente_id` ASC) VISIBLE,
  INDEX `fk_pedidos_almacen1_idx` (`almacen_id` ASC) VISIBLE,
  CONSTRAINT `fk_pedidos_clientes`
    FOREIGN KEY (`cliente_id`)
    REFERENCES `carpinteria`.`clientes` (`cliente_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pedidos_almacen1`
    FOREIGN KEY (`almacen_id`)
    REFERENCES `carpinteria`.`almacen` (`almacen_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;


#-------Ingresando Datos-------#

#Clientes
INSERT INTO `carpinteria`.`clientes` (`nombre`, `email`, `telefono`)
VALUES ('Oscar Lopez', 'o.lopez@gmail.com', '2604472728'), ('Alberto Garcia',
'a.garcia@gmail.com', '2604734859');

#Productos
INSERT INTO `carpinteria`.`productos` (`modelo`, `precio_en_pesos`)
VALUES ( 'Mesa', '5000'), ('Silla', '1000'), ('Mesa y 6 sillas', '10000'), ('Mesa y 8 sillas', '12000');

#Almacen
INSERT INTO `carpinteria`.`almacen` (`productos_id`, `cantidad`, `fecha`)
VALUES ('1', '10', current_timestamp());
INSERT INTO `carpinteria`.`almacen` (`productos_id`, `cantidad`, `fecha`)
VALUES ('2', '30', current_timestamp());
INSERT INTO `carpinteria`.`almacen` (`productos_id`, `cantidad`, `fecha`)
VALUES ('3', '5', current_timestamp());
INSERT INTO `carpinteria`.`almacen` (`productos_id`, `cantidad`, `fecha`)
VALUES ('4', '2', current_timestamp());

#Pedidos
INSERT INTO `carpinteria`.`pedidos` (`cantidad`, `almacen_id`, `cliente_id`, `fecha`)
VALUES (4,'2', '1', current_date());
INSERT INTO `carpinteria`.`pedidos` (`cantidad`, `almacen_id`, `cliente_id`, `fecha`)
VALUES (1, '4', '2', current_date());
INSERT INTO `carpinteria`.`pedidos` (`cantidad`, `almacen_id`, `cliente_id`, `fecha`)
VALUES (1, '1', '1', current_date());


#-------Consultas-------#

#Consulta de producción en una determinada fecha
SELECT * FROM almacen WHERE fecha= DATE('2013-05-10');

#Consulta de pedidos diarios
SELECT * FROM pedidos WHERE fecha = DATE('2022-09-23');