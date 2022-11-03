-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema cursor1
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `cursor1` ;

-- -----------------------------------------------------
-- Schema cursor1
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `cursor1` DEFAULT CHARACTER SET utf8 ;
USE `cursor1` ;

-- -----------------------------------------------------
-- Table `cursor1`.`alumno`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cursor1`.`alumno` (
  `idalumno` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NULL,
  PRIMARY KEY (`idalumno`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cursor1`.`modulo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cursor1`.`modulo` (
  `idmodulo` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NULL,
  PRIMARY KEY (`idmodulo`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cursor1`.`notas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cursor1`.`notas` (
  `idalumno` INT NOT NULL,
  `idmodulo` INT NOT NULL,
  `nota` INT NULL,
  PRIMARY KEY (`idalumno`, `idmodulo`),
  CONSTRAINT `fk_alumno_has_modulos_alumno`
    FOREIGN KEY (`idalumno`)
    REFERENCES `cursor1`.`alumno` (`idalumno`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_alumno_has_modulos_modulos1`
    FOREIGN KEY (`idmodulo`)
    REFERENCES `cursor1`.`modulo` (`idmodulo`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `cursor1`.`alumno`
-- -----------------------------------------------------
START TRANSACTION;
USE `cursor1`;
INSERT INTO `cursor1`.`alumno` (`idalumno`, `nombre`) VALUES (DEFAULT, 'Alumno1');
INSERT INTO `cursor1`.`alumno` (`idalumno`, `nombre`) VALUES (DEFAULT, 'Alumno2');
INSERT INTO `cursor1`.`alumno` (`idalumno`, `nombre`) VALUES (DEFAULT, 'Alumno3');

COMMIT;


-- -----------------------------------------------------
-- Data for table `cursor1`.`modulo`
-- -----------------------------------------------------
START TRANSACTION;
USE `cursor1`;
INSERT INTO `cursor1`.`modulo` (`idmodulo`, `nombre`) VALUES (DEFAULT, 'Modulo1');
INSERT INTO `cursor1`.`modulo` (`idmodulo`, `nombre`) VALUES (DEFAULT, 'Modulo2');
INSERT INTO `cursor1`.`modulo` (`idmodulo`, `nombre`) VALUES (DEFAULT, 'Modulo3');

COMMIT;


-- -----------------------------------------------------
-- Data for table `cursor1`.`notas`
-- -----------------------------------------------------
START TRANSACTION;
USE `cursor1`;
INSERT INTO `cursor1`.`notas` (`idalumno`, `idmodulo`, `nota`) VALUES (1, 1, 5);
INSERT INTO `cursor1`.`notas` (`idalumno`, `idmodulo`, `nota`) VALUES (1, 2, 8);
INSERT INTO `cursor1`.`notas` (`idalumno`, `idmodulo`, `nota`) VALUES (1, 3, 3);
INSERT INTO `cursor1`.`notas` (`idalumno`, `idmodulo`, `nota`) VALUES (2, 1, 7);
INSERT INTO `cursor1`.`notas` (`idalumno`, `idmodulo`, `nota`) VALUES (2, 2, 2);
INSERT INTO `cursor1`.`notas` (`idalumno`, `idmodulo`, `nota`) VALUES (2, 3, 10);
INSERT INTO `cursor1`.`notas` (`idalumno`, `idmodulo`, `nota`) VALUES (3, 1, 3);
INSERT INTO `cursor1`.`notas` (`idalumno`, `idmodulo`, `nota`) VALUES (3, 2, 5);
INSERT INTO `cursor1`.`notas` (`idalumno`, `idmodulo`, `nota`) VALUES (3, 3, 10);

COMMIT;

SELECT * FROM ALUMNO; 
SELECT * FROM MODULO;
SELECT* FROM NOTAS;

-- OBTENER EL NOMBRE DEL ALUMNO CON MEJOR NOTA DEL MODULO 1
-- AQUI NO SERVIRIA 
SELECT ALUMNO.NOMBRE, NOTAS.NOTA  FROM ALUMNO JOIN NOTAS ON ALUMNO.IDALUMNO = NOTAS.IDALUMNO
WHERE IDMODULO=1
ORDER BY NOTA DESC LIMIT 1;

-- OBTENER EL NOMBRE DEL ALUMNO CON MEJOR NOTA DEL MODULO 3 -- OTRA FORMA DE HACERLO POR QUE EN EL MODULO 3 TENIAMOS DOS ALUMNOS CON 10, SI USAMOS EL METODO ANTERIOR, SOLO OBTENEMOS EL DE MAXIMA NOTA Y YA. Por lo tanto aqui lo resolvemos con un select anidado. 
-- 1er hacemos el select, hacemos union de tablas con JOIN,no nos hace falta un RIGHT/LEFT por que no tendremos notas con valor NULL.
SELECT ALUMNO.NOMBRE, NOTAS.NOTA  FROM ALUMNO JOIN NOTAS ON ALUMNO.IDALUMNO = NOTAS.IDALUMNO
WHERE NOTAS.NOTA =(SELECT MAX(NOTA)  FROM NOTAS WHERE IDMODULO =3); 

-- CURSORES -- -------------------------------------------ESTRUCTURA SEMANTICA ----------------------------------------------------------------------------------

-- AHORA VAMOS A APLICAR CURSORES PARA OBTENER LA MISMA SOLUCION. ESTO NOS PERMMITIRIA ANALIZAR MAS PROFUNDAMENTE LOS DAATOS EN EL CASO QUE TUVIERAMOS MAS COLUMNAS A ANALIZAR. - TAL COMO SOSPECHABAS MI AMOR- 

-- TAREA>>>>>>>OBTENER EL NOMBRE DEL ALUMNO CON MEJOR NOTA DEL MODULO
-- TABLA QUE EL CURSOR ALMACENA LAS NOTAS MAXIMAS

CREATE TABLE NOTA_MAX (
ID INT PRIMARY KEY AUTO_INCREMENT, 
NOMBRE VARCHAR (45), 
NOTA INT); 

DROP PROCEDURE IF EXISTS PROC_MEJOR_NOTA;
DELIMITER //
CREATE PROCEDURE PROC_MEJOR_NOTA (IN MODULO INT)
BEGIN
	-- DECLARACION DE VARIABLES 
    
    -- LAS VARIABLES ASIGNADAS DEBEN COINCIDT CON EL NUMERO DE COLUMNAS QUE ESTAMOS PIDIENDO. DECLARAMOS DOS VARIABLES (NOMBRE Y NOTA) Y EN EL SELECT ANIDADO, TB LE PEDIMOS DOS COLUMNAS (NOTA Y NOMBRE)
    
    -- DECLARACION VARIABLES
    DECLARE DONE BOOLEAN DEFAULT FALSE;
    DECLARE NOMBRE_ALUMNO VARCHAR (45);
    DECLARE NOTA_ALUMNO INT;
    
    -- DECLARACION VARIABLES TEMPORALES
	DECLARE TEMP_NOMBRE_ALUMNO VARCHAR (45);
    DECLARE TEMP_NOTA INT DEFAULT (select max(nota) from notas where idmodulo = modulo);
    
    -- DECLARAR CURSOR PARA LA CONSULTA
    DECLARE CURSOR_MEJOR_NOTA CURSOR FOR  
    SELECT ALUMNO.NOMBRE, NOTAS.NOTA FROM ALUMNO JOIN NOTAS ON ALUMNO.IDALUMNO=NOTAS.IDMODULO
    WHERE NOTA.IDMODULO = MODULO;
    
    -- DECLARAR EL HANDLER / MANEJADOR DEl ERROR TIPO --  'NOT FOUND'--
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET DONE = TRUE;
        
    -- ABRIR CURSOS
    OPEN CURSOR_MEJOR_NOTA;     
    -- LECTURA DE LAS FILAS MEDIANTE BUCLE 
    LOOP_LECTURA: LOOP
     -- LECTURA DE LA PRIMERA FILA
     FETCH CURSOR_MEJOR_NOTA INTO NOMBRE_ALUMNO, NOTA_ALUMNO;
    -- SI EL CURSOR DETECTA QUE NO HAY FILA PARA LEER, SALIMOS DEL LOOP
    IF DONE THEN	
		LEAVE LOOP_LECTURA;
	END IF;
    -- GESTION DE LA MEJOR NOTA (CON VARIABLE TEMPORAL)
    IF NOTA_ALUMNO = TEMP_NOTA THEN 
				SET TEMP_NOTA_ALUMNO = NOMBRE_ALUMNO;
				SET TEMP_NOTA = NOTA_ALUMNO;
		INSERT INTO NOTA_MAX VALUES (DEFAULT, TEMP_NOMBRE_ALUMNO, TEMP_NOTA);
    END IF;
    END LOOP;
    
    -- CERRA EL CURSOR
    CLOSE CURSOR_MEJOR_NOTA;
END//	

DELIMITER ; 
-- AQUI HACEMOS LA LLAMADA DEL MUDULO 3 --
CALL PROC_MEJOR_NOTA (3);