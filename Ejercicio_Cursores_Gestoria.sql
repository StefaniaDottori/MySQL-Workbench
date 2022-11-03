-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema gestoria
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `gestoria` ;

-- -----------------------------------------------------
-- Schema gestoria
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `gestoria` DEFAULT CHARACTER SET utf8 ;
USE `gestoria` ;

-- -----------------------------------------------------
-- Table `gestoria`.`vendedor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `gestoria`.`vendedor` (
  `idvendedor` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NULL,
  `apellidos` VARCHAR(45) NULL,
  `dirección` VARCHAR(45) NULL,
  `telefono` VARCHAR(45) NULL,
  `email` VARCHAR(45) NULL,
  PRIMARY KEY (`idvendedor`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `gestoria`.`producto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `gestoria`.`producto` (
  `idproducto` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NULL,
  `descripcion` VARCHAR(45) NULL,
  `precio` FLOAT NULL,
  `stock` INT NULL,
  PRIMARY KEY (`idproducto`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `gestoria`.`detalle_factura`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `gestoria`.`detalle_factura` (
  `idvendedor` INT NOT NULL,
  `idproducto` INT NOT NULL,
  `fecha` DATE NULL,
  `unidades` INT NULL,
  `importe` FLOAT NULL,
  PRIMARY KEY (`idvendedor`, `idproducto`),
    CONSTRAINT `fk_vendedor_has_producto_vendedor`
    FOREIGN KEY (`idvendedor`)
    REFERENCES `gestoria`.`vendedor` (`idvendedor`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_vendedor_has_producto_producto1`
    FOREIGN KEY (`idproducto`)
    REFERENCES `gestoria`.`producto` (`idproducto`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `gestoria`.`vendedor`
-- -----------------------------------------------------
START TRANSACTION;
USE `gestoria`;
INSERT INTO `gestoria`.`vendedor` (`idvendedor`, `nombre`, `apellidos`, `dirección`, `telefono`, `email`) VALUES (DEFAULT, 'Nombre1', 'Apellidos1', 'Calle1', '611111111', 'nombre1@gmail.com');
INSERT INTO `gestoria`.`vendedor` (`idvendedor`, `nombre`, `apellidos`, `dirección`, `telefono`, `email`) VALUES (DEFAULT, 'Nombre2', 'Apellidos2', 'Calle2', '622222222', 'nombre2@gmail.com');
INSERT INTO `gestoria`.`vendedor` (`idvendedor`, `nombre`, `apellidos`, `dirección`, `telefono`, `email`) VALUES (DEFAULT, 'Nombre3', 'Apellidos3', 'Calle3', '633333333', 'nombre3@gmail.com');
INSERT INTO `gestoria`.`vendedor` (`idvendedor`, `nombre`, `apellidos`, `dirección`, `telefono`, `email`) VALUES (DEFAULT, 'Nombre4', 'Apellidos4', 'Calle4', '644444444', 'nombre4@gmail.com');
INSERT INTO `gestoria`.`vendedor` (`idvendedor`, `nombre`, `apellidos`, `dirección`, `telefono`, `email`) VALUES (DEFAULT, 'Nombre5', 'Apellidos5', 'Calle5', '655555555', 'nombre5@gmail.com');

COMMIT;


-- -----------------------------------------------------
-- Data for table `gestoria`.`producto`
-- -----------------------------------------------------
START TRANSACTION;
USE `gestoria`;
INSERT INTO `gestoria`.`producto` (`idproducto`, `nombre`, `descripcion`, `precio`, `stock`) VALUES (DEFAULT, 'Producto1', 'Descripción producto1', 10, 5);
INSERT INTO `gestoria`.`producto` (`idproducto`, `nombre`, `descripcion`, `precio`, `stock`) VALUES (DEFAULT, 'Producto2', 'Descripción producto2', 20, 5);
INSERT INTO `gestoria`.`producto` (`idproducto`, `nombre`, `descripcion`, `precio`, `stock`) VALUES (DEFAULT, 'Producto3', 'Descripción producto3', 30, 5);
INSERT INTO `gestoria`.`producto` (`idproducto`, `nombre`, `descripcion`, `precio`, `stock`) VALUES (DEFAULT, 'Producto4', 'Descripción producto4', 40, 5);
INSERT INTO `gestoria`.`producto` (`idproducto`, `nombre`, `descripcion`, `precio`, `stock`) VALUES (DEFAULT, 'Producto5', 'Descripción producto5', 50, 5);

COMMIT;

INSERT INTO VENDEDOR VALUES (DEFAULT, 'Blas', 'Bessone', 'Calle1', '611111111', 'Blas1@gmail.com');
INSERT INTO VENDEDOR VALUES (DEFAULT, 'Constantino', 'Dottori', 'Calle2', '622222222', 'Constantino2@gmail.com');
INSERT INTO VENDEDOR VALUES (DEFAULT, 'Michael', 'Jackson', 'Calle3', '633333333', 'Michael3@gmail.com');
INSERT INTO VENDEDOR VALUES (DEFAULT, 'Jorge', 'Drexler', 'Calle4', '644444444', 'Jorge4@gmail.com');
INSERT INTO VENDEDOR VALUES (DEFAULT, 'Amelie', 'Maw', 'Calle5', '655555555', 'Amelie5@gmail.com');

SELECT * FROM VENDEDOR;

INSERT INTO PRODUCTO VALUES (DEFAULT, 'Calado BN', 'Cuadro calado a mano', 120, 5);
INSERT INTO PRODUCTO VALUES (DEFAULT, 'Cuadro Mujer', 'Cuadro enmarcado y calado', 320, 5);
INSERT INTO PRODUCTO VALUES (DEFAULT, 'Planta Ornamental', 'Helecho Adimitis', 430, 5);
INSERT INTO PRODUCTO VALUES (DEFAULT, 'Marco DecoNovia', 'Marco madera con rosas', 540, 5);
INSERT INTO PRODUCTO VALUES (DEFAULT, 'Luces LED', 'Luces navideñas 10 mt', 650, 5);

DELETE FROM PRODUCTO WHERE IDPRODUCTO= 6;
DELETE FROM PRODUCTO WHERE IDPRODUCTO= 7;
SELECT * FROM PRODUCTO;

-- Simular las ventas con este código SQL : adicionamos productos X a diferentes vendedores 

set @vendedor = 1;
SELECT * FROM VENDEDOR;
set @producto = 1;
set @fecha = '2020-2-1';
set @unidades = 3;
set @precio = (select precio from producto where idproducto = @producto);
set @importe = @precio * @unidades;
insert into detalle_factura values (@vendedor,@producto,@fecha,@unidades,@importe);
-- comprobación
select * from detalle_factura;

set @vendedor = 6;
SELECT * FROM VENDEDOR;
set @producto = 8;
set @fecha = '2020-3-1';
set @unidades = 6;
set @precio = (select precio from producto where idproducto = @producto);
set @importe = @precio * @unidades;
insert into detalle_factura values (@vendedor,@producto,@fecha,@unidades,@importe);

select * from detalle_factura;

set @vendedor = 7;
SELECT * FROM VENDEDOR;
set @producto = 9;
set @fecha = '2020-2-15';
set @unidades = 10;
set @precio = (select precio from producto where idproducto = @producto);
set @importe = @precio * @unidades;
insert into detalle_factura values (@vendedor,@producto,@fecha,@unidades,@importe);

select * from detalle_factura;

set @vendedor = 8;
SELECT * FROM VENDEDOR;
set @producto = 10;
set @fecha = '2020-2-11';
set @unidades = 15;
set @precio = (select precio from producto where idproducto = @producto);
set @importe = @precio * @unidades;
insert into detalle_factura values (@vendedor,@producto,@fecha,@unidades,@importe);

select * from detalle_factura;
DELETE FROM DETALLE_FACTURA WHERE IDPRODUCTO = 12;
set @vendedor = 10;
SELECT * FROM VENDEDOR;
set @producto = 1;
set @fecha = '2020-2-09';
set @unidades = 5;
set @precio = (select precio from producto where idproducto = @producto);
set @importe = @precio * @unidades;
insert into detalle_factura values (@vendedor,@producto,@fecha,@unidades,@importe);

select * from detalle_factura;

set @vendedor = 6;
SELECT * FROM VENDEDOR;
set @producto = 9;
set @fecha = '2020-03-31';
set @unidades = 7;
set @precio = (select precio from producto where idproducto = @producto);
set @importe = @precio * @unidades;
insert into detalle_factura values (@vendedor,@producto,@fecha,@unidades,@importe);

set @vendedor = 7;
set @producto = 10;
set @fecha = '2020-02-31';
set @unidades = 10;
set @precio = (select precio from producto where idproducto = @producto);
set @importe = @precio * @unidades;
insert into detalle_factura values (@vendedor,@producto,@fecha,@unidades,@importe);

select * from detalle_factura;

set @vendedor = 8;
set @producto = 1;
set @fecha = '2020-02-01';
set @unidades = 5;
set @precio = (select precio from producto where idproducto = @producto);
set @importe = @precio * @unidades;
insert into detalle_factura values (@vendedor,@producto,@fecha,@unidades,@importe);

set @vendedor = 11;
SELECT * FROM VENDEDOR;
set @producto = 10;
set @fecha = '2020-2-10';
set @unidades = 20;
set @precio = (select precio from producto where idproducto = @producto);
set @importe = @precio * @unidades;
insert into detalle_factura values (@vendedor,@producto,@fecha,@unidades,@importe);

select * from detalle_factura;
SELECT DETALLE_FACTURA.IDVENDEDOR, VENDEDOR.NOMBRE, DETALLE_FACTURA.IMPORTE 
FROM DETALLE_FACTURA JOIN VENDEDOR ON DETALLE_FACTURA.IDVENDEDOR = VENDEDOR.IDVENDEDOR; 	

SELECT * FROM VENDEDOR;
UPDATE VENDEDOR SET NOMBRE = "OLIVER" , APELLIDOS = "FONTANRROSA", EMAIL = 'OLIVER6@GMAIL.COM', DIRECCIÓN = 'CALLE 13' WHERE IDVENDEDOR = 11; 
SELECT * FROM VENDEDOR;

-- EJERCICIO 

-- CREAR UN CURSOR QUE NOS DEVUELVA EL NOMBRE DEL MEJOR VENDEDOR Y EL IMPORTE DE VENTAS ENTRE DOS FECHAS. EJEMPLO DE LLAMADA AL PROCEDURE:
-- 1er paso . vamos a crear una tabla de registro de los resultados. ALMACENARA LOS DATOS DE NOMBRE DEL VENDEDOR, ID Y TOTAL DE VENTAS ALCANZADAS EN TAL PERIODO DEL TIEMPO

-- 1)
CREATE TABLE BEST_SELLER ( 
ID INT PRIMARY KEY AUTO_INCREMENT, 
NOMBRE_VENDEDOR VARCHAR (45), 
total FLOAT); 
-- 2)
DROP PROCEDURE IF EXISTS MEJOR_VENDEDOR;
DELIMITER //
CREATE PROCEDURE MEJOR_VENDEDOR (IN FECHA_INICIO DATE, FECHA_FIN DATE)
BEGIN
	-- DECLARACION DE VARIABLES 
    
    -- LAS VARIABLES ASIGNADAS DEBEN COINCIDT CON EL NUMERO DE COLUMNAS QUE ESTAMOS PIDIENDO. DECLARAMOS DOS VARIABLES (NOMBRE Y NOTA) Y EN EL SELECT ANIDADO, TB LE PEDIMOS DOS COLUMNAS (NOTA Y NOMBRE)
    
    -- DECLARACION VARIABLES
    DECLARE DONE BOOLEAN DEFAULT FALSE;
    DECLARE NOMBRE_VENDEDOR VARCHAR (45);
    DECLARE TOTAL_VENDEDOR FLOAT Default 0;
    
    -- DECLARACION VARIABLES TEMPORALES -- es la inicializacion
	DECLARE TEMP_NOMBRE_VENDEDOR VARCHAR (45);
    DECLARE TEMP_TOTAL FLOAT DEFAULT -- esto permite inicializar el valor Temporal Total a un valor que le demos atraves de una consulta. 
		(select sum(importe) as importMax from detalle_factura;
    
    -- DECLARAR CURSOR PARA LA CONSULTA
    
    DECLARE CURSOR_MEJOR_VENDEDOR CURSOR FOR  
    SELECT VENDEDOR.NOMBRE, SUM(DETALLE_FACTURA.IMPORTE) AS TOTAL FROM VENDEDOR JOIN DETALLE_FACTURA ON VENDEDOR.IDVENDEDOR=	DETALLE_fACTURA.IDVENDEDOR 
    WHERE DETALLE_FACTURA.FECHA BETWEEN '2020-02-1' AND'2020-03-31' GROUP BY VENDEDOR.IDVENDEDOR ORDER BY TOTAL DESC;     
   
    -- DECLARAR EL HANDLER / MANEJADOR DEl ERROR TIPO --  'NOT FOUND'--
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET DONE = TRUE;
        
    -- ABRIR CURSOR
    OPEN CURSOR_MEJOR_VENDEDOR;     
    -- LECTURA DE LAS FILAS MEDIANTE BUCLE 
    LOOP_LECTURA: LOOP
     -- LECTURA DE LA PRIMERA FILA
     FETCH CURSOR_MEJOR_VENDEDOR INTO NOMBRE_VENDEDOR, TOTAl_VENDEDOR;
    -- SI EL CURSOR DETECTA QUE NO HAY FILA PARA LEER, SALIMOS DEL LOOP
    IF DONE THEN	
		LEAVE LOOP_LECTURA;
	END IF;
    -- GESTION DE LA MEJOR NOTA (CON VARIABLE TEMPORAL)
    IF TOTAL_VENDEDOR > TEMP_TOTAL THEN 
				SET TEMP_TOTAL >= TEMP_NOMBRE_VENDEDOR;
				SET TEMP_TOTAL = TOTAL_VENDEDOR;
		INSERT INTO BEST_SELLER VALUES (DEFAULT, TEMP_NOMBRE_VENDEDOR, TEMP_total);
    END IF;
    END LOOP;
    
    -- CERRA EL CURSOR
    CLOSE CURSOR_MEJOR_VENDEDOR;
END//	

DELIMITER ; 
-- AQUI HACEMOS LA LLAMADA DEL MUDULO 3 --

call mejor_vendedor('2020-02-1','2020-03-31');

SELECT * FROM DETALLE_FACTURA;
-- SE DECLARA LA CONSULTA PARA METER DESPUES EN EL CURSOR. ESTO NOS DEMUESTRA QUE LO QUE LE VAMOS A PEDIR AL CURSOR FUNCIONA. LA APLICAMOS EN LINEA >>
SELECT VENDEDOR.NOMBRE, SUM(DETALLE_FACTURA.IMPORTE) AS TOTAL FROM VENDEDOR JOIN DETALLE_FACTURA ON VENDEDOR.IDVENDEDOR=DETALLE_fACTURA.IDVENDEDOR WHERE DETALLE_FACTURA.FECHA BETWEEN '2020-02-1' AND'2020-03-31' GROUP BY VENDEDOR.IDVENDEDOR ORDER BY TOTAL DESC; 