-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema videoclub
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `videoclub` ;

-- -----------------------------------------------------
-- Schema videoclub
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `videoclub` DEFAULT CHARACTER SET utf8 ;
USE `videoclub` ;

-- -----------------------------------------------------
-- Table `videoclub`.`actor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `videoclub`.`actor` (
  `idActor` INT(11) NOT NULL AUTO_INCREMENT,
  `nameActor` VARCHAR(45) NULL,
  `ActorCount` INT(11) NULL,
  PRIMARY KEY (`idActor`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `videoclub`.`category`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `videoclub`.`category` (
  `idCategory` INT(11) NOT NULL AUTO_INCREMENT,
  `nameCategory` VARCHAR(45) NULL,
  `categoryCount` INT(11) NULL,
  PRIMARY KEY (`idCategory`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `videoclub`.`video`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `videoclub`.`video` (
  `idVideo` INT(11) NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(45) NULL,
  PRIMARY KEY (`idVideo`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `videoclub`.`relvideoactor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `videoclub`.`relvideoactor` (
  `idVideo` INT(11) NOT NULL,
  `idActor` INT(11) NOT NULL,
  PRIMARY KEY (`idActor`, `idVideo`),
  CONSTRAINT `fk_RelVideoActor_1`
    FOREIGN KEY (`idVideo`)
    REFERENCES `videoclub`.`video` (`idVideo`)
    ON UPDATE CASCADE,
  CONSTRAINT `fk_RelVideoActor_2`
    FOREIGN KEY (`idActor`)
    REFERENCES `videoclub`.`actor` (`idActor`)
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `videoclub`.`relvideocategory`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `videoclub`.`relvideocategory` (
  `idVideo` INT(11) NOT NULL,
  `idCategory` INT(11) NOT NULL,
  PRIMARY KEY (`idVideo`, `idCategory`),
  CONSTRAINT `fk_RelVideoCategory_1`
    FOREIGN KEY (`idVideo`)
    REFERENCES `videoclub`.`video` (`idVideo`)
    ON UPDATE CASCADE,
  CONSTRAINT `fk_RelVideoCategory_2`
    FOREIGN KEY (`idCategory`)
    REFERENCES `videoclub`.`category` (`idCategory`)
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `videoclub`.`actor`
-- -----------------------------------------------------
START TRANSACTION;
USE `videoclub`;
INSERT INTO `videoclub`.`actor` (`idActor`, `nameActor`, `ActorCount`) VALUES (DEFAULT, 'nombre1', 1);
INSERT INTO `videoclub`.`actor` (`idActor`, `nameActor`, `ActorCount`) VALUES (DEFAULT, 'nombre2', 1);
INSERT INTO `videoclub`.`actor` (`idActor`, `nameActor`, `ActorCount`) VALUES (DEFAULT, 'nombre3', 1);
INSERT INTO `videoclub`.`actor` (`idActor`, `nameActor`, `ActorCount`) VALUES (DEFAULT, 'nombre4', 1);
INSERT INTO `videoclub`.`actor` (`idActor`, `nameActor`, `ActorCount`) VALUES (DEFAULT, 'nombre5', 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `videoclub`.`category`
-- -----------------------------------------------------
START TRANSACTION;
USE `videoclub`;
INSERT INTO `videoclub`.`category` (`idCategory`, `nameCategory`, `categoryCount`) VALUES (DEFAULT, 'categoria1', 1);
INSERT INTO `videoclub`.`category` (`idCategory`, `nameCategory`, `categoryCount`) VALUES (DEFAULT, 'categoria2', 1);
INSERT INTO `videoclub`.`category` (`idCategory`, `nameCategory`, `categoryCount`) VALUES (DEFAULT, 'categoria3', 1);
INSERT INTO `videoclub`.`category` (`idCategory`, `nameCategory`, `categoryCount`) VALUES (DEFAULT, 'categoria4', 1);
INSERT INTO `videoclub`.`category` (`idCategory`, `nameCategory`, `categoryCount`) VALUES (DEFAULT, 'categoria5', 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `videoclub`.`video`
-- -----------------------------------------------------
START TRANSACTION;
USE `videoclub`;
INSERT INTO `videoclub`.`video` (`idVideo`, `Name`) VALUES (DEFAULT, 'video1');
INSERT INTO `videoclub`.`video` (`idVideo`, `Name`) VALUES (DEFAULT, 'video2');
INSERT INTO `videoclub`.`video` (`idVideo`, `Name`) VALUES (DEFAULT, 'video3');
INSERT INTO `videoclub`.`video` (`idVideo`, `Name`) VALUES (DEFAULT, 'video4');
INSERT INTO `videoclub`.`video` (`idVideo`, `Name`) VALUES (DEFAULT, 'video5');

COMMIT;


-- -----------------------------------------------------
-- Data for table `videoclub`.`relvideoactor`
-- -----------------------------------------------------
START TRANSACTION;
USE `videoclub`;
INSERT INTO `videoclub`.`relvideoactor` (`idVideo`, `idActor`) VALUES (1, 1);
INSERT INTO `videoclub`.`relvideoactor` (`idVideo`, `idActor`) VALUES (2, 2);
INSERT INTO `videoclub`.`relvideoactor` (`idVideo`, `idActor`) VALUES (3, 3);
INSERT INTO `videoclub`.`relvideoactor` (`idVideo`, `idActor`) VALUES (4, 4);
INSERT INTO `videoclub`.`relvideoactor` (`idVideo`, `idActor`) VALUES (5, 5);

COMMIT;


-- -----------------------------------------------------
-- Data for table `videoclub`.`relvideocategory`
-- -----------------------------------------------------
START TRANSACTION;
USE `videoclub`;
INSERT INTO `videoclub`.`relvideocategory` (`idVideo`, `idCategory`) VALUES (1, 1);
INSERT INTO `videoclub`.`relvideocategory` (`idVideo`, `idCategory`) VALUES (2, 2);
INSERT INTO `videoclub`.`relvideocategory` (`idVideo`, `idCategory`) VALUES (3, 3);
INSERT INTO `videoclub`.`relvideocategory` (`idVideo`, `idCategory`) VALUES (4, 4);
INSERT INTO `videoclub`.`relvideocategory` (`idVideo`, `idCategory`) VALUES (5, 5);

COMMIT;

-- 1- BORRADO EN CASCADA
-- Si borramos un video, también tendremos que borrar las relaciones con actor y categorías.
-- comprobación
CREATE TABLE IF NOT EXISTS video_backup_BD (
  `idVideo` INT(11) NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(45) NULL,
  PRIMARY KEY (`idVideo`));
  
 DROP TRIGGER IF EXISTS video_backup_BD;
delimiter //
CREATE TRIGGER video_backup_BD BEFORE DELETE ON video	
for each row
BEGIN
	INSERT INTO video_backup_BD (DEFAULT, OLD.NAME, NOW ()); 
	
END $$; 
DELIMITER  ; 
	
    SELECT * FROM VIDEO; 
    SET SQL_SAFE_UPDATES = 0;
    -- used to automatically remove the matching records from the child table when we delete the rows from the parent table
    DELETE * 
    FROM VIDEO WHERE IDVIDEO = 1; 

-- 2- ACTUALIZACIÓN DE UN REGISTRO
-- Cada vez que se cree o elimine una relación Categoría-Video, añadiremos o disminuiremos
-- una unidad en el registro “categoryCount”
-- comprobación INSERT
-- comprobación DELETE
-- 3- AUTODESTRUCCIÓN
-- Borra el actor que no tenga asignado ninguna película
-- Si se borra una relación de un actor con una película, se resta una unidad
-- en el campo “actorCount” y si es igual a cero, se borra el actor
-- comprobación