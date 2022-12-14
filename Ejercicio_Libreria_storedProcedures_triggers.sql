
SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema libreria
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `libreria` ;

-- -----------------------------------------------------
-- Schema libreria
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `libreria` DEFAULT CHARACTER SET utf8 ;
USE `libreria` ;

-- -----------------------------------------------------
-- Table `libreria`.`libros`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `libreria`.`libros` (
  `codigo` INT NOT NULL AUTO_INCREMENT,
  `titulo` VARCHAR(45) NULL,
  `autor` VARCHAR(45) NULL,
  `editorial` VARCHAR(45) NULL,
  `precio` FLOAT NULL,
  PRIMARY KEY (`codigo`))
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `libreria`.`libros`
-- -----------------------------------------------------
START TRANSACTION;
USE `libreria`;
INSERT INTO `libreria`.`libros` (`codigo`, `titulo`, `autor`, `editorial`, `precio`) VALUES (DEFAULT, 'Uno', 'Richard Bach', 'Planeta', 15);
INSERT INTO `libreria`.`libros` (`codigo`, `titulo`, `autor`, `editorial`, `precio`) VALUES (DEFAULT, 'Ilusiones', 'Richard Bach', 'Planeta', 12);
INSERT INTO `libreria`.`libros` (`codigo`, `titulo`, `autor`, `editorial`, `precio`) VALUES (DEFAULT, 'El aleph', 'Borges', 'Emece', 25);
INSERT INTO `libreria`.`libros` (`codigo`, `titulo`, `autor`, `editorial`, `precio`) VALUES (DEFAULT, 'Aprenda PHP', 'Mario Molina', 'Nuevo Siglo', 50);
INSERT INTO `libreria`.`libros` (`codigo`, `titulo`, `autor`, `editorial`, `precio`) VALUES (DEFAULT, 'Matem??ticas', 'Paenza', 'Nuevo Siglo', 18);
INSERT INTO `libreria`.`libros` (`codigo`, `titulo`, `autor`, `editorial`, `precio`) VALUES (DEFAULT, 'Puente al inficnito', 'Richard Bach', 'Sudamericana', 14);
INSERT INTO `libreria`.`libros` (`codigo`, `titulo`, `autor`, `editorial`, `precio`) VALUES (DEFAULT, 'Antolog??a', 'Borges', 'Paidos', 24);
INSERT INTO `libreria`.`libros` (`codigo`, `titulo`, `autor`, `editorial`, `precio`) VALUES (DEFAULT, 'Java en 10 minutos', 'Mario Molina', 'Siglo XXI', 45);
INSERT INTO `libreria`.`libros` (`codigo`, `titulo`, `autor`, `editorial`, `precio`) VALUES (DEFAULT, 'Cervantes y el Quijote', 'Borges', 'Planeta', 34);

COMMIT;

SELECT * FROM LIBROS;

DROP PROCEDURE IF EXISTS DESC_LIBROS;
DELIMITER $$
CREATE PROCEDURE DESC_LIBROS (IN DESCUENTO INT, IN EDITORIAL_PARAM VARCHAR (20), OUT CANT INT)
BEGIN
	IF EDITORIAL_PARAM = "TODOS" THEN
			UPDATE LIBROS set PRECIO = PRECIO * (1-DESCUENTO/100);
			SET CANT = (SELECT COUNT (*) FROM LIBROS);
	ELSE
            UPDATE LIBROS set PRECIO = PRECIO * (1-DESCUENTO/100) WHERE EDITORIAL = "EDITORIAL_PARAM";
			SET CANT = (SELECT COUNT (*) FROM LIBROS) WHERE EDITORIAL = "EDITORIAL_PARAM";
	END IF;
END $$ 
DELIMITER ; 


CALL DESC_LIBROS ( 5, "PLANETA", @CANT);
SELECT CONCAT ("HAN SIDO AFECTADOS ", @CANT, " LIBROS"); 

--  Procedimiento que aplica un descuento en (%),  enviando ese descuento el nombre de la editorial
-- Si recibe, el string "todos", aplica el descuento a todos los libros
-- El proc. me devuelve el n??mero de libros afectados por el descuento en @cant


-- trigger que valida la edad de un nuevo dato. es automatico
-- 1. sila edad es negativa, se inserta un NULL EN ESE CAMPO
-- A??ADE UN MSJE DE ERROR 
-- INSERTA EN UNA TABLA -ERRORES- EL ID DEL REGISTRO Y LA FECHA 

create table usuarios (
ID int primary key AUTO_INCREMENT, 
nombre varchar (45),
edad int);

CREATE TABLE ERRORES ( 
ID int primary key AUTO_INCREMENT, 
ID_USUARIO INT, 
FECHA DATETIME); 

-- BI = Before Insert
drop trigger if exists valida_edad_BI;
delimiter $$
create trigger valida_edad_BI before insert on USUARIOS 
FOR EACH ROW 
BEGIN 
	IF NEW.EDAD < 0 THEN
    SET NEW.EDAD = NULL; 
    SELECT "EDAD INCORRECTA";
    INSERT INTO USUARIOS VALUES (DEFAULT, NEW.ID, now());
END IF;

END $$

DELIMITER ; 

INSERT INTO USUARIOS VALUES (NULL, "PEPE", -40); 
SELECT * FROM USUARIOS;