DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_chequeahab`(IN iUsuario varchar(255) ,IN iPass varchar(255), OUT oHabilitado INT)
begin
 

	if EXISTS(select * from beltranvigilancia.usuarios where mail = iUsuario and contrasenia = iPass)
	THEN
		SELECT 0 ;
	ELSE
    SELECT 
     habilitado	INTO oHabilitado
     FROM
	 beltranvigilancia.usuarios 
     WHERE mail = iUsuario;
      SELECT 1;
	END IF;
 END$$
DELIMITER ;