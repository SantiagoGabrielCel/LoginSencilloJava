DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_in_login`(IN iUsuario varchar(255) ,IN iPass varchar(255), OUT oFallido INT)
begin
 
 DECLARE contador INT;

	if EXISTS(select * from beltranvigilancia.usuarios where mail = iUsuario and contrasenia = iPass)
	THEN
		SELECT 0 ;
	ELSE
    SELECT 
     @contador := fallidos 
     FROM
	 beltranvigilancia.usuarios 
     WHERE mail = iUsuario;
     SET contador = @contador+1;
     
        UPDATE beltranvigilancia.usuarios 
        SET fallidos = contador
        WHERE mail = iUsuario; 
        
			UPDATE beltranvigilancia.usuarios
            SET habilitado = if(fallidos > 3 , 0 , habilitado)
            WHERE mail = iUsuario ;

        SELECT contador INTO oFallido;
      SELECT 1;
	END IF;
 END$$
DELIMITER ;