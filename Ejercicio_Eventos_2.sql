-- borra campos de una tabla a una determinada frecuencia de tiempo.alte


create table cuentas (
ID int primary key auto_increment, 
nombre varchar (45), 
any date
); 

insert into cuentas values (default, "cuenta 1", 2022);
insert into cuentas values (default, "cuenta 2", 2022);
insert into cuentas values (default, "cuenta 3", 2022);

drop event if exists borra2022; 
create event borra2022
on schedule at now()+ interval 20 second
on
	delete from cuentas where any = 2022
    
    
    drop eventi if exists inserta2022; 
    create event if exists inserta2022;
    