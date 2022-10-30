SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `mydb` ;

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Tarifas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Tarifas` (
  `Tipo_plan` VARCHAR(10) NOT NULL,
  `BM_0_30` DECIMAL(3,2) NOT NULL,
  `BE_30_2` DECIMAL(3,2) NOT NULL,
  `BM_30_2` DECIMAL(3,2) NOT NULL,
  `BEM_2` INT NOT NULL,
  `BE_0_30` DECIMAL(3) NOT NULL,
  `Tarifa_anual` INT NOT NULL,
  PRIMARY KEY (`Tarifa_anual`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Usuario` (
  `Nombre_Completo` VARCHAR(150) NOT NULL,
  `NIE` VARCHAR(9) ,
  `Fecha_Alta` DATE NOT NULL,
  `Telefono` INT(9) ,
  `Tarifas_A50_PlanA50` VARCHAR(10) NOT NULL,
  `Pago_idPago` INT NOT NULL,
  `Tarifas_Tarifa_anual` INT NOT NULL,
  PRIMARY KEY (`NIE`),
  CONSTRAINT `fk_Usuario_Tarifas1`
    FOREIGN KEY (`Tarifas_Tarifa_anual`)
    REFERENCES `mydb`.`Tarifas` (`Tarifa_anual`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Acceso_Usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Acceso_Usuario` (
  `mail` VARCHAR(150) ,
  `Password` VARCHAR(45) NOT NULL,
  `Usuario_NIE` VARCHAR(9) ,
  PRIMARY KEY (`mail`),
  CONSTRAINT `fk_Acceso_Usuario_Usuario1`
    FOREIGN KEY (`Usuario_NIE`)
    REFERENCES `mydb`.`Usuario` (`NIE`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Datos_Bancarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Datos_Bancarios` (
  `Tipo_Trajeta` VARCHAR(15) ,
  `Caducidad` DATE ,
  `Nro_Tarjeta` BIGINT NOT NULL,
  `Usuario_NIE` VARCHAR(9),
  PRIMARY KEY (`Nro_Tarjeta`),
   CONSTRAINT `fk_Datos_Bancarios_Usuario1`
    FOREIGN KEY (`Usuario_NIE`)
    REFERENCES `mydb`.`Usuario` (`NIE`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Bicicletas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Bicicletas` (
  `idBicicletas` INT NOT NULL,
  `Tipo_Bicicleta` VARCHAR(45) NOT NULL,
  `Inicio_Estacion` VARCHAR(45) NOT NULL,
  `Fin_Estacion` VARCHAR(45) NOT NULL,
  `Fecha_Mantenimiento` DATE NOT NULL,
  PRIMARY KEY (`Tipo_Bicicleta`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Mantenimiento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Mantenimiento` (
  `idBicicletas` INT NOT NULL,
  `Fecha_Alta` DATE NOT NULL,
  `Fecha_Mantenimiento` DATE NOT NULL,
  `Estado_Bicicleta` BIT(1) NOT NULL,
  `Bicicletas_Tipo_Bicicleta` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idBicicletas`),
  CONSTRAINT `fk_Mantenimiento_Bicicletas1`
    FOREIGN KEY (`Bicicletas_Tipo_Bicicleta`)
    REFERENCES `mydb`.`Bicicletas` (`Tipo_Bicicleta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Alquiler`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Alquiler` (
  `Usuario_Pago_idPago` INT NOT NULL AUTO_INCREMENT,
  `Usuario_Tarifas_A50_PlanA50` VARCHAR(10) NOT NULL,
  `Bicicletas_idBicicletas` INT NOT NULL,
  `Inicio_Tramo` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `Fin_Tramo` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `Tiempo_Total` TIME NOT NULL,
  `Usuario_NIE` VARCHAR(9) NOT NULL,
  `Bicicletas_Tipo_Bicicleta` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Usuario_Pago_idPago`),
  CONSTRAINT `fk_Alquiler_Usuario1`
    FOREIGN KEY (`Usuario_NIE`)
    REFERENCES `mydb`.`Usuario` (`NIE`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Alquiler_Bicicletas1`
    FOREIGN KEY (`Bicicletas_Tipo_Bicicleta`)
    REFERENCES `mydb`.`Bicicletas` (`Tipo_Bicicleta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `mydb`.`Tarifas`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`Tarifas` (`Tipo_plan`, `BM_0_30`, `BE_30_2`, `BM_30_2`, `BEM_2`, `BE_0_30`, `Tarifa_anual`) VALUES ('Plan_A50', 0.01, 0.90, 0.70, 5, 0.35, 50);
INSERT INTO `mydb`.`Tarifas` (`Tipo_plan`, `BM_0_30`, `BE_30_2`, `BM_30_2`, `BEM_2`, `BE_0_30`, `Tarifa_anual`) VALUES ('Plan_A35', 0.05, 0.90, 0.70, 5, 0.55, 35);

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`Usuario`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`Usuario` (`Nombre_Completo`, `NIE`, `Fecha_Alta`, `Telefono`, `Tarifas_A50_PlanA50`, `Pago_idPago`, `Tarifas_Tarifa_anual`) VALUES ('Jose Ligero ', 'Y6587665Q', '2022-02-03', 610034761, 'PlanA50', 1234, 50);
INSERT INTO `mydb`.`Usuario` (`Nombre_Completo`, `NIE`, `Fecha_Alta`, `Telefono`, `Tarifas_A50_PlanA50`, `Pago_idPago`, `Tarifas_Tarifa_anual`) VALUES ('Mandraque Gloton', 'Y6587666Q', '2022-02-04', 610034762, 'PlanA50', 2345, 50);
INSERT INTO `mydb`.`Usuario` (`Nombre_Completo`, `NIE`, `Fecha_Alta`, `Telefono`, `Tarifas_A50_PlanA50`, `Pago_idPago`, `Tarifas_Tarifa_anual`) VALUES ('Magoya Habilidosa', 'Y6585661K', '2022-01-10', 615534762, 'PlanA30', 4567, 35);
INSERT INTO `mydb`.`Usuario` (`Nombre_Completo`, `NIE`, `Fecha_Alta`, `Telefono`, `Tarifas_A50_PlanA50`, `Pago_idPago`, `Tarifas_Tarifa_anual`) VALUES ('Pedro Tapon', 'Y6585661A', '2022-01-13', 615534992, 'PlanA30', 9978, 35);

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`Acceso_Usuario`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`Acceso_Usuario` (`mail`, `Password`, `Usuario_NIE`) VALUES ('ligeroJose1@gmail.com', 'lalala123', 'Y6587666Q');
INSERT INTO `mydb`.`Acceso_Usuario` (`mail`, `Password`, `Usuario_NIE`) VALUES ('ligeroJose@gmail.com', 'lalala124', 'Y6587665Q');
INSERT INTO `mydb`.`Acceso_Usuario` (`mail`, `Password`, `Usuario_NIE`) VALUES ('habilmagoya@gmail.com', 'lelele23', 'Y6585661K');
INSERT INTO `mydb`.`Acceso_Usuario` (`mail`, `Password`, `Usuario_NIE`) VALUES ('pedrotapon@gmail.com', 'lilili89', 'Y6585661A');

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`Datos_Bancarios`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`Datos_Bancarios` (`Tipo_Trajeta`, `Caducidad`, `Nro_Tarjeta`, `Usuario_NIE`) VALUES ('Debito', '2024-09-21', 1234567891234567, 'Y6587665Q');
INSERT INTO `mydb`.`Datos_Bancarios` (`Tipo_Trajeta`, `Caducidad`, `Nro_Tarjeta`, `Usuario_NIE`) VALUES ('Debito', '2025-08-15', 2345678912345678, 'Y6587666Q');
INSERT INTO `mydb`.`Datos_Bancarios` (`Tipo_Trajeta`, `Caducidad`, `Nro_Tarjeta`, `Usuario_NIE`) VALUES ('Credito', '2026-06-05', 3456789123456789, 'Y6585661K');
INSERT INTO `mydb`.`Datos_Bancarios` (`Tipo_Trajeta`, `Caducidad`, `Nro_Tarjeta`, `Usuario_NIE`) VALUES ('Debito', '2022-11-10', 4567890123456789, 'Y6585661A');

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`Bicicletas`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`Bicicletas` (`idBicicletas`, `Tipo_Bicicleta`, `Inicio_Estacion`, `Fin_Estacion`, `Fecha_Mantenimiento`) VALUES (0001, 'Mecanica1', 'Av.Diagonal 134', 'Rambla catalunya 23', '2022-08-10');
INSERT INTO `mydb`.`Bicicletas` (`idBicicletas`, `Tipo_Bicicleta`, `Inicio_Estacion`, `Fin_Estacion`, `Fecha_Mantenimiento`) VALUES (0002, 'Mecanica2', 'Muntaner 45', 'Provenca 67', '2022-10-09');
INSERT INTO `mydb`.`Bicicletas` (`idBicicletas`, `Tipo_Bicicleta`, `Inicio_Estacion`, `Fin_Estacion`, `Fecha_Mantenimiento`) VALUES (0003, 'Electrica3', 'Gracia 341', 'Raval 65', '2022-11-01');
INSERT INTO `mydb`.`Bicicletas` (`idBicicletas`, `Tipo_Bicicleta`, `Inicio_Estacion`, `Fin_Estacion`, `Fecha_Mantenimiento`) VALUES (0004, 'Electrica4', 'Balmes 21', 'Layetana 78', '2022-09-15');

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`Mantenimiento`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`Mantenimiento` (`idBicicletas`, `Fecha_Alta`, `Fecha_Mantenimiento`, `Estado_Bicicleta`, `Bicicletas_Tipo_Bicicleta`) VALUES (0001, '2020-08-20', '2022-08-10', 0, 'Mecanica1');
INSERT INTO `mydb`.`Mantenimiento` (`idBicicletas`, `Fecha_Alta`, `Fecha_Mantenimiento`, `Estado_Bicicleta`, `Bicicletas_Tipo_Bicicleta`) VALUES (0002, '2019-03-11', '2022-10-09', 1, 'Mecanica2');
INSERT INTO `mydb`.`Mantenimiento` (`idBicicletas`, `Fecha_Alta`, `Fecha_Mantenimiento`, `Estado_Bicicleta`, `Bicicletas_Tipo_Bicicleta`) VALUES (0003, '2021-02-23', '2022-11-01', 1, 'Electrica3');
INSERT INTO `mydb`.`Mantenimiento` (`idBicicletas`, `Fecha_Alta`, `Fecha_Mantenimiento`, `Estado_Bicicleta`, `Bicicletas_Tipo_Bicicleta`) VALUES (0004, '2019-09-30', '2022-09-15', 0, 'Electrica4');

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`Alquiler`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`Alquiler` (`Usuario_Pago_idPago`, `Usuario_Tarifas_A50_PlanA50`, `Bicicletas_idBicicletas`, `Inicio_Tramo`, `Fin_Tramo`, `Tiempo_Total`, `Usuario_NIE`, `Bicicletas_Tipo_Bicicleta`) VALUES (DEFAULT, 'PlanA50', 0001, '2022-09-03 14:30:12', '2022-09-03 15:15:15', '00:45:03', 'Y6587665Q', 'Mecanica1');
INSERT INTO `mydb`.`Alquiler` (`Usuario_Pago_idPago`, `Usuario_Tarifas_A50_PlanA50`, `Bicicletas_idBicicletas`, `Inicio_Tramo`, `Fin_Tramo`, `Tiempo_Total`, `Usuario_NIE`, `Bicicletas_Tipo_Bicicleta`) VALUES (DEFAULT, 'PlanA50', 0002, '2022-07-15 11:30:30', '2022-07-15 13:30:50', '02:00:20', 'Y6587666Q', 'Mecanica2');
INSERT INTO `mydb`.`Alquiler` (`Usuario_Pago_idPago`, `Usuario_Tarifas_A50_PlanA50`, `Bicicletas_idBicicletas`, `Inicio_Tramo`, `Fin_Tramo`, `Tiempo_Total`, `Usuario_NIE`, `Bicicletas_Tipo_Bicicleta`) VALUES (DEFAULT, 'PlanA30', 0003, '2022-09-02 09:14:12', '2022-09-02 09:32:32', '00:18:20', 'Y6585661K', 'Electrica3');
INSERT INTO `mydb`.`Alquiler` (`Usuario_Pago_idPago`, `Usuario_Tarifas_A50_PlanA50`, `Bicicletas_idBicicletas`, `Inicio_Tramo`, `Fin_Tramo`, `Tiempo_Total`, `Usuario_NIE`, `Bicicletas_Tipo_Bicicleta`) VALUES (DEFAULT, 'PlanA30', 0004, '2022-11-20 20:50:03', '2022-11-20 21:30:33', '00:40:30', 'Y6585661A', 'Electrica4');
INSERT INTO `mydb`.`Alquiler` (`Usuario_Pago_idPago`, `Usuario_Tarifas_A50_PlanA50`, `Bicicletas_idBicicletas`, `Inicio_Tramo`, `Fin_Tramo`, `Tiempo_Total`, `Usuario_NIE`, `Bicicletas_Tipo_Bicicleta`) VALUES (DEFAULT, 'PlanA30', 0004, '2022-12-20 20:55:03', '2022-12-20 21:45:33', '00:40:30', 'Y6585661A', 'Electrica4');
COMMIT;

-- consultas 

