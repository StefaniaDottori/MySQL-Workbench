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
USE `videoclub`;
SET FOREIGN_KEY_CHECKS = 0; -- quita error 1451
SET SQL_SAFE_UPDATES = 0; -- quita error 1175

-- 1- BORRADO EN CASCADA; Si borramos un video, también tendremos que borrar las relaciones con actor y categorías.
-- comprobación
USE `videoclub`;
DROP TRIGGER IF EXISTS deleteVideo ON Video
DELIMITER //
CREATE TRIGGER deleteVideo AFTER DELETE on VIDEO 
FOR EACH row
BEGIN
    DELETE FROM RELVIDEOACTOR WHERE IdVideo  = OLD.idVideo;
    DELETE FROM RELVIDEOCATEGORY WHERE IdVideo = OLD.IdVideo; 
END //
DELIMITER ; 

-- COMPROBACION 
USE `videoclub`;
SELECT * FROM VIDEO; 
USE `videoclub`;
DELETE FROM VIDEO WHERE iDVideo = 1; 
USE `videoclub`;
SELECT * FROM vIDEO;


-- 2- ACTUALIZACIÓN DE UN REGISTRO
-- Cada vez que se cree- INSERT  o elimine - DELETE  una relación Categoría-Video, añadiremos o disminuiremos
-- una unidad en el registro “categoryCount”
-- comprobación INSERT
-- comprobación DELETE

USE `videoclub`;
DROP TRIGGER IF EXISTS ddRelVideoCategory; 
DELIMITER //
CREATE TRIGGER ddRelVideoCategory AFTER INSERT ON RELVIDEOCATEGORY 
FOR EACH row
BEGIN 
    UPDATE CATEGORY SET CategoryCount = CategoryCount + 1
    WHERE idCategory = new.idCategory; 

END //
DELIMITER ; 

-- COMPROBACION 
USE `videoclub`;
SELECT * FROM RELVIDEOCATEGORY; 
USE `videoclub`;
INSERT INTO RELVIDEOCATEGORY VALUES (2,4);
USE `videoclub`;
SELECT * FROM RELVIDEOCATEGORY;
USE `videoclub`;
SELECT * FROM CATEGORY; 
USE `videoclub`;
INSERT INTO RELVIDEOCATEGORY VALUES (3,4);
USE `videoclub`;
SELECT * FROM CATEGORY; 

-- FUNCIONA, CADA VEZ QUE SE ADICIONA UNA PELICULA, SE HACE UN INSERT, SE SUMA UN COUNT MAS A LA CATEGORIA Q LE CORRESP

-- 3- AUTODESTRUCCIÓN
-- Borra el actor que no tenga asignado ninguna película
-- Si se borra.- condicion del trigger- una relación de un actor con una película, se resta una unidad en el campo 
-- “actorCount” , es decir planteamos una ACTUALIZACION DEL DATO -- osea q tendremos un UPDATE
-- y si es igual a cero, se borra el actor

USE `videoclub`;
DROP TRIGGER IF EXISTS deleteActor; 
DELIMITER // 
CREATE TRIGGER deleteActor ON RELVIDEOACTOR AFTER DELETE 
FOR EACH row
BEGIN 
    update actor set actorCount = actorCount - 1
    where idActor = old.idActor;
    delete from actor where idActor = old.idActor and actorCount = 0;
end //

delimiter ;
-- comprobación
USE `videoclub`;
delete from relvideoactor where idVideo = 5 and idActor = 5;
USE `videoclub`;
select * from relvideoactor;
USE `videoclub`;
select * from actor;