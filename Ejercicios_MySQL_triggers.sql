DROP SCHEMA IF EXISTS `BIBLIOTECA` ;
CREATE SCHEMA IF NOT EXISTS `BIBLIOTECA` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE `BIBLIOTECA` ;

-- -----------------------------------------------------
-- Table `BIBLIOTECA`.`LIBRO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BIBLIOTECA`.`LIBRO` (
  `idLibro` INT NOT NULL,
  `Titulo` VARCHAR(45) NULL,
  `Editorial` VARCHAR(45) NULL,
  PRIMARY KEY (`idLibro`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci;


-- -----------------------------------------------------
-- Table `BIBLIOTECA`.`AUTOR`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BIBLIOTECA`.`AUTOR` (
  `idAutor` INT NOT NULL,
  `Nombre` VARCHAR(45) NULL,
  `Nacionalidad` VARCHAR(45) NULL,
  PRIMARY KEY (`idAutor`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci;


-- -----------------------------------------------------
-- Table `BIBLIOTECA`.`LIB_AUT`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BIBLIOTECA`.`LIB_AUT` (
  `idAutor` INT NOT NULL,
  `idLibro` INT NULL,
  PRIMARY KEY (`idAutor`),
  CONSTRAINT `fk_LIB_AUT_1`
    FOREIGN KEY (`idLibro`)
    REFERENCES `BIBLIOTECA`.`LIBRO` (`idLibro`),
  CONSTRAINT `fk_LIB_AUT_AUTOR1`
    FOREIGN KEY (`idAutor`)
    REFERENCES `BIBLIOTECA`.`AUTOR` (`idAutor`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci;


-- -----------------------------------------------------
-- Table `BIBLIOTECA`.`ESTUDIANTE`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BIBLIOTECA`.`ESTUDIANTE` (
  `idLector` INT NOT NULL,
  `NombreApels` VARCHAR(45) NULL,
  `Dirección` VARCHAR(45) NULL,
  `Estudios` VARCHAR(45) NULL,
  `Edad` INT NULL,
  PRIMARY KEY (`idLector`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci;


-- -----------------------------------------------------
-- Table `BIBLIOTECA`.`PRESTAMO`
-- -----------------------------------------------------
DROP TABLE `BIBLIOTECA`.`PRESTAMO`; 
CREATE TABLE IF NOT EXISTS `BIBLIOTECA`.`PRESTAMO` (
  `idLector` INT NOT NULL,
  `idLibro` INT NULL,
  `FechaPrestamo` DATE NULL,
  `FechaDevolucion` DATETIME NULL,
  `Devuelto` TINYINT(1) NULL,
  PRIMARY KEY (`idLector`),
  CONSTRAINT `fk_PRESTAMO_1`
    FOREIGN KEY (`idLibro`)
    REFERENCES `BIBLIOTECA`.`LIBRO` (`idLibro`),
  CONSTRAINT `fk_PRESTAMO_ESTUDIANTE1`
    FOREIGN KEY (`idLector`)
    REFERENCES `BIBLIOTECA`.`ESTUDIANTE` (`idLector`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci;

-- ------ -----------------------------------------------------
-- Data for table `BIBLIOTECA`.`LIBRO`
-- -----------------------------------------------------

INSERT INTO `BIBLIOTECA`.`LIBRO` (`idLIBRO`, `Titulo`, `Editorial`) VALUES (1, 'El Amante Japonés', 'Plaza & Janes');
INSERT INTO `BIBLIOTECA`.`LIBRO` (`idLIBRO`, `Titulo`, `Editorial`) VALUES (2, 'Diario de Greg, 9', 'RBA Molino');
INSERT INTO `BIBLIOTECA`.`LIBRO` (`idLIBRO`, `Titulo`, `Editorial`) VALUES (3, 'La Templanza', 'Planeta');
INSERT INTO `BIBLIOTECA`.`LIBRO` (`idLIBRO`, `Titulo`, `Editorial`) VALUES (4, 'Hombres Buenos', 'Alfaguara');
INSERT INTO `BIBLIOTECA`.`LIBRO` (`idLIBRO`, `Titulo`, `Editorial`) VALUES (5, 'Algo tan sencillo', 'Planeta');


-- -------------------------------------------------
-- Data for table `BIBLIOTECA`.`ESTUDIANTE`
-- -----------------------------------------------------

INSERT INTO `BIBLIOTECA`.`ESTUDIANTE` (`idLector`, `NombreApels`, `Dirección`, `Estudios`, `Edad`) VALUES (1, 'Juan López', 'Mayor 4', 'BACH', 19);
INSERT INTO `BIBLIOTECA`.`ESTUDIANTE` (`idLector`, `NombreApels`, `Dirección`, `Estudios`, `Edad`) VALUES (2, 'Iván Santaner', 'Via Augusta 4', 'BACH', 18);
INSERT INTO `BIBLIOTECA`.`ESTUDIANTE` (`idLector`, `NombreApels`, `Dirección`, `Estudios`, `Edad`) VALUES (3, 'Jesús Senra', 'Balmes 12', 'L.Periodismo', 24);
INSERT INTO `BIBLIOTECA`.`ESTUDIANTE` (`idLector`, `NombreApels`, `Dirección`, `Estudios`, `Edad`) VALUES (4, 'Ariadna Pérez', 'Aribau 33', 'Ingeniero', 32);
INSERT INTO `BIBLIOTECA`.`ESTUDIANTE` (`idLector`, `NombreApels`, `Dirección`, `Estudios`, `Edad`) VALUES (5, 'Silvia Martínez', 'Travessera Gracia 123', 'L.Derecho', 45);
INSERT INTO `BIBLIOTECA`.`ESTUDIANTE` (`idLector`, `NombreApels`, `Dirección`, `Estudios`, `Edad`) VALUES (6, 'Juan Molina', 'Diagonal 322', 'L.Filosofía', 54);
INSERT INTO `BIBLIOTECA`.`ESTUDIANTE` (`idLector`, `NombreApels`, `Dirección`, `Estudios`, `Edad`) VALUES (7, 'Edurne Sánchez', 'Aragón 33', 'Ingeniero Tec.', 23);
INSERT INTO `BIBLIOTECA`.`ESTUDIANTE` (`idLector`, `NombreApels`, `Dirección`, `Estudios`, `Edad`) VALUES (8, 'Maria Gallart', 'Plaza Iglésia 2', 'L.Turismo', 42);

-- -----------------------------------------------------
-- Data for table `BIBLIOTECA`.`PRESTAMO`
-- -----------------------------------------------------

INSERT INTO `BIBLIOTECA`.`PRESTAMO` (`idLector`, `idLibro`, `FechaPrestamo`, `FechaDevolucion`, `Devuelto`) VALUES (1, 1, '2022-06-01', '2022-06-03', true);
INSERT INTO `BIBLIOTECA`.`PRESTAMO` (`idLector`, `idLibro`, `FechaPrestamo`, `FechaDevolucion`, `Devuelto`) VALUES (2, 2, '2022-06-01', '2022-06-04', true);
INSERT INTO `BIBLIOTECA`.`PRESTAMO` (`idLector`, `idLibro`, `FechaPrestamo`, `FechaDevolucion`, `Devuelto`) VALUES (3, 1, '2022-06-04', '2022-06-10', true);
INSERT INTO `BIBLIOTECA`.`PRESTAMO` (`idLector`, `idLibro`, `FechaPrestamo`, `FechaDevolucion`, `Devuelto`) VALUES (4, 3, '2022-06-02', '2022-06-04', true);
INSERT INTO `BIBLIOTECA`.`PRESTAMO` (`idLector`, `idLibro`, `FechaPrestamo`, `FechaDevolucion`, `Devuelto`) VALUES (5, 5, '2022-06-01', '2022-06-02', true);
INSERT INTO `BIBLIOTECA`.`PRESTAMO` (`idLector`, `idLibro`, `FechaPrestamo`, `FechaDevolucion`, `Devuelto`) VALUES (6, 4, '2022-06-02', '2022-06-06', true);
INSERT INTO `BIBLIOTECA`.`PRESTAMO` (`idLector`, `idLibro`, `FechaPrestamo`, `FechaDevolucion`, `Devuelto`) VALUES (7, 3, '2022-06-06', '2022-06-07', true);
INSERT INTO `BIBLIOTECA`.`PRESTAMO` (`idLector`, `idLibro`, `FechaPrestamo`, `FechaDevolucion`, `Devuelto`) VALUES (8, 1, '2022-06-11', '2022-06-12', true);

-- -----------------------------------------------------
-- Data for table `BIBLIOTECA`.`AUTOR`
-- -----------------------------------------------------

INSERT INTO `BIBLIOTECA`.`AUTOR` (`idAutor`, `Nombre`, `Nacionalidad`) VALUES (1, 'Isabel Allende', 'Chile');
INSERT INTO `BIBLIOTECA`.`AUTOR` (`idAutor`, `Nombre`, `Nacionalidad`) VALUES (2, 'Jeff Kinney', 'EEUU');
INSERT INTO `BIBLIOTECA`.`AUTOR` (`idAutor`, `Nombre`, `Nacionalidad`) VALUES (3, 'Maria Dueñas', 'España');
INSERT INTO `BIBLIOTECA`.`AUTOR` (`idAutor`, `Nombre`, `Nacionalidad`) VALUES (4, 'Arturo P. Reverte', 'España');
INSERT INTO `BIBLIOTECA`.`AUTOR` (`idAutor`, `Nombre`, `Nacionalidad`) VALUES (5, 'Blue Jeans', 'EEUU');

-- -----------------------------------------------------
-- Data for table `BIBLIOTECA`.`LIB_AUT`
-- -----------------------------------------------------

INSERT INTO `BIBLIOTECA`.`LIB_AUT` (`idAutor`, `idLibro`) VALUES (1, 1);
INSERT INTO `BIBLIOTECA`.`LIB_AUT` (`idAutor`, `idLibro`) VALUES (2, 2);
INSERT INTO `BIBLIOTECA`.`LIB_AUT` (`idAutor`, `idLibro`) VALUES (3, 3);
INSERT INTO `BIBLIOTECA`.`LIB_AUT` (`idAutor`, `idLibro`) VALUES (4, 4);
INSERT INTO `BIBLIOTECA`.`LIB_AUT` (`idAutor`, `idLibro`) VALUES (5, 5);

-- EXAMEN

-- 1) PROCEDIMIENTO 1

DROP PROCEDURE PROC1; 

DELIMITER //
CREATE PROCEDURE PROC1 (IN ID INT, IN TITULO VARCHAR (79), IN EDITORIAL VARCHAR (49))
BEGIN	
	INSERT INTO LIBRO VALUES (DEFAULT, TITULO, EDITORIAL);
END //;

DELIMITER ; 

INSERT INTO LIBRO VALUES (6, "CIEN AÑOS DE SOLEDAD", "PLANETA");
SELECT * FROM LIBRO;

-- 2) PROCEDIMIENTO 2

DROP procedure PROC2;
DELIMITER //
CREATE PROCEDURE PROC2 (IN IDLECTOR INT, IN IDLIBRO INT, IN FechaDevolucion DATE)
BEGIN 
	UPDATE PRESTAMO SET FechaDevolucion = now()
    WHERE IDLIBRO = IDLIBRO; 
    UPDATE PRESTAMO SET DEVUELTO = TRUE
    WHERE IDLIBRO = IDLIBRO; 
END // 
DELIMITER ; 


SET FOREIGN_KEY_CHECKS = 0; -- quita error 1451 
SET SQL_SAFE_UPDATES = 0; -- quita error 1175

CALL PROC2 (2,2, 2022-09-15);
SELECT * FROM PRESTAMO;

-- 3) PROCEDIMIENTO 3

DROP PROCEDURE PROC3; 
DELIMITER // 
CREATE PROCEDURE PROC3 (IN IDAUTOR INT, OUT OUT_NOMBRE VARCHAR (49))
BEGIN
	INSERT INTO AUTOR VALUES (6, "GABRIEL GARCIA MARQUEZ", "COLOMBIA"); 
    SET OUT_NOMBRE = (SELECT NOMBRE FROM AUTOR WHERE IDAUTOR = IDAUTOR);
END // 
DELIMITER ;

SELECT * FROM AUTOR; 
CALL PROC3 (6, @out_NOMBRE);

-- 4) PROCEDIMIENTO 4

SELECT * FROM PRESTAMO; 
DROP PROCEDURE PROC4 ; 
DELIMITER //
CREATE PROCEDURE PROC4 (IN IDLECTOR INT)
BEGIN
    UPDATE PRESTAMO SET DEVUELTO = FALSE 
    WHERE IDLIBRO = 5;
    
END //
DELIMITER ;
SET SQL_SAFE_UPDATES = 0;
SET FOREIGN_KEY_CHECKS = 0; -- quita error 1451 
SET SQL_SAFE_UPDATES = 0; -- quita error 1175


SELECT * FROM PRESTAMO; 
CALL PROC4 (5); 

-- 5) PROCEDIMIENTO 5
SELECT * FROM ESTUDIANTE; 
DROP PROCEDURE PROC5; 
DELIMITER //
CREATE procedure PROC5 (out MEDIA_EDAD INT)
BEGIN
    SET MEDIA_EDAD = (SELECT avg(EDAD) FROM ESTUDIANTE); 
END // 
DELIMITER ; 

CALL PROC5 (@MEDIA_E);
select @MEDIA_E;

-- TRIGGERS 
-- 1 
DROP TABLE TABLA_SEGURIDAD;
CREATE TABLE TABLA_SEGURIDAD (
IDLIBRO INT, 
IDESTUDIANTE INT (49), 
FECHAPRESTAMO DATEtime
);

DROP TRIGGER TABLA_SEGURIDAD; 
DELIMITER //
CREATE TRIGGER TABLA_SEGURIDAD AFTER INSERT ON PRESTAMO
FOR EACH ROW
BEGIN 
	INSERT INTO TABLA_SEGURIDAD VALUES (NEW.IDLIBRO, NEW.IDLECTOR, NOW());
END //
DELIMITER ;

INSERT INTO PRESTAMO VALUES (11, 5, 2022-09-25, now(), FALSE);
SELECT * FROM TABLA_SEGURIDAD; 
SELECT * FROM PRESTAMO;

-- TRIGGER 2
DROP TABLE NVOS_LIBROS;
CREATE TABLE Nvos_Libros (
IDLIBRO INT PRIMARY KEY AUTO_INCREMENT NOT NULL, 
TITULO VARCHAR (49), 
EDITORIAL VARCHAR (49),
NOMBRE VARCHAR (45), 
NACIONALIDAD VARCHAR (49),
IDAUTOR INT NOT NULL
); 
SELECT * FROM NVOS_LIBROS; 

DROP TRIGGER NVOS_LIBROS; 
DELIMITER // 
CREATE TRIGGER NVOS_LIBROS AFTER INSERT ON LIBRO 
FOR EACH ROW 
BEGIN 
	
    INSERT INTO LIB_AUT VALUES (IDAUTOR, NEW.IDLIBRO);
    INSERT INTO NVOS_LIBROS VALUES (NEW.IDLIBRO, NEW.TITULO, NEW.EDITORIAL, NOMBRE, NACIONALIDAD, IDAUTOR);

END //
DELIMITER ; 

DROP TABLE NVOS_AUTORES;
CREATE TABLE Nvos_Autores (
IDAUTOR INT NOT NULL, 
NOMBRE VARCHAR (49), 
NACIONALIDAD VARCHAR (49)
); 

DROP TRIGGER NVOS_AUTORES; 
DELIMITER // 
CREATE TRIGGER NVOS_AUTORES AFTER INSERT ON AUTOR
FOR EACH ROW 
BEGIN 
	
    INSERT INTO LIB_AUT VALUES (NEW.IDAUTOR, IDLIBRO);
    INSERT INTO NVOS_AUTORES VALUES ( NEW.IDAUTOR, NEW.NOMBRE, NEW.NACIONALIDAD);

END //
DELIMITER ; 

INSERT INTO AUTOR VALUES (27, "MANDELA", "SUDRAFICA");
SELECT * FROM AUTOR;
SELECT * FROM NVOS_AUTORES; 

    