-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 13-11-2020 a las 22:44:27
-- Versión del servidor: 10.4.14-MariaDB
-- Versión de PHP: 7.2.33

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `beltranvigilancia`
--
CREATE DATABASE IF NOT EXISTS `beltranvigilancia` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `beltranvigilancia`;

DELIMITER $$
--
-- Procedimientos
--
DROP PROCEDURE IF EXISTS `sp_chequeahab`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_chequeahab` (IN `iUsuario` VARCHAR(255), IN `iPass` VARCHAR(255), OUT `oHabilitado` INT)  begin
 

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

DROP PROCEDURE IF EXISTS `sp_in_login`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_in_login` (IN `iUsuario` VARCHAR(255), IN `iPass` VARCHAR(255), OUT `oFallido` INT)  begin
 
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

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `alumnos`
--

DROP TABLE IF EXISTS `alumnos`;
CREATE TABLE `alumnos` (
  `legajo` int(11) NOT NULL,
  `nombre` varchar(99) NOT NULL,
  `apellido` varchar(99) NOT NULL,
  `mail` varchar(255) NOT NULL,
  `fechainscripcion` date NOT NULL,
  `telefono` varchar(99) NOT NULL,
  `dni` int(11) NOT NULL,
  `direccion` varchar(99) NOT NULL,
  `habilitado` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `alumnos`
--

INSERT INTO `alumnos` (`legajo`, `nombre`, `apellido`, `mail`, `fechainscripcion`, `telefono`, `dni`, `direccion`, `habilitado`) VALUES
(1, 'Francos', 'Colavella', 'Y29sYXZlbGxhMjJAZ21haWwuY29t', '2020-11-12', '1153522563', 21523526, 'hfafgaf', 1),
(2, 'Nicolas', 'avenazi', 'Y29sYXZlbGxhMjNAZ21haWwuY29t', '2020-11-10', '3263262', 356263261, 'avellaneda', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `asignacionaluas`
--

DROP TABLE IF EXISTS `asignacionaluas`;
CREATE TABLE `asignacionaluas` (
  `idasignacion` int(11) NOT NULL,
  `idpersonal` int(11) NOT NULL,
  `id_materia` int(11) NOT NULL,
  `idaula` int(11) NOT NULL,
  `horainicio` varchar(8) DEFAULT NULL,
  `horafin` varchar(8) DEFAULT NULL,
  `fechadesde` date DEFAULT NULL,
  `fechahasta` date DEFAULT NULL,
  `fechaaprobacion` date DEFAULT NULL,
  `asignacionanual` int(11) DEFAULT NULL,
  `habilitado` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `aulas`
--

DROP TABLE IF EXISTS `aulas`;
CREATE TABLE `aulas` (
  `idaula` int(11) NOT NULL,
  `piso` int(11) DEFAULT NULL,
  `idtipoaula` int(11) NOT NULL,
  `habilitado` tinyint(1) DEFAULT NULL,
  `capacidad` varchar(255) DEFAULT NULL,
  `fecharegistro` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `carrera`
--

DROP TABLE IF EXISTS `carrera`;
CREATE TABLE `carrera` (
  `idcarrera` int(11) NOT NULL,
  `descripcion` varchar(255) NOT NULL,
  `coordinador` varchar(255) NOT NULL,
  `habilitado` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `entregamateriales`
--

DROP TABLE IF EXISTS `entregamateriales`;
CREATE TABLE `entregamateriales` (
  `identrega` int(11) NOT NULL,
  `idpersonal` int(11) NOT NULL,
  `descripcion` varchar(255) DEFAULT NULL,
  `fechaentrega` date DEFAULT NULL,
  `fechadevolucion` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ingresosegresosalumnos`
--

DROP TABLE IF EXISTS `ingresosegresosalumnos`;
CREATE TABLE `ingresosegresosalumnos` (
  `legajo` int(11) NOT NULL,
  `fechaingreso` date DEFAULT NULL,
  `fechaegreso` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ingresosegresospersonal`
--

DROP TABLE IF EXISTS `ingresosegresospersonal`;
CREATE TABLE `ingresosegresospersonal` (
  `idpersonal` int(11) NOT NULL,
  `fechaingreso` date DEFAULT NULL,
  `fechaegreso` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `materiales`
--

DROP TABLE IF EXISTS `materiales`;
CREATE TABLE `materiales` (
  `idmaterial` int(11) NOT NULL,
  `descripcion` varchar(255) NOT NULL,
  `cantidad` int(11) NOT NULL,
  `habilitado` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `materias`
--

DROP TABLE IF EXISTS `materias`;
CREATE TABLE `materias` (
  `id_materia` int(11) NOT NULL,
  `descripcion` varchar(255) DEFAULT NULL,
  `anio` int(11) DEFAULT NULL,
  `idcarrera` int(11) NOT NULL,
  `turno` varchar(1) DEFAULT NULL,
  `habilitado` tinyint(1) DEFAULT NULL,
  `horainicio` varchar(8) DEFAULT NULL,
  `horafin` varchar(8) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `materiasdocente`
--

DROP TABLE IF EXISTS `materiasdocente`;
CREATE TABLE `materiasdocente` (
  `id_materia` int(11) NOT NULL,
  `idpersonal` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `notificacion`
--

DROP TABLE IF EXISTS `notificacion`;
CREATE TABLE `notificacion` (
  `idnotificacion` int(11) NOT NULL,
  `descripcion` varchar(255) NOT NULL,
  `fecha` date NOT NULL,
  `mail` varchar(99) NOT NULL,
  `enviado` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `permisos`
--

DROP TABLE IF EXISTS `permisos`;
CREATE TABLE `permisos` (
  `id_permiso` int(11) NOT NULL,
  `nombre` varchar(255) NOT NULL,
  `habilitado` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `permisos`
--

INSERT INTO `permisos` (`id_permiso`, `nombre`, `habilitado`) VALUES
(1, 'Aulas', 1),
(2, 'Usuarios', 1),
(3, 'alumnos', 1),
(4, 'Personal', 1),
(5, 'Materias', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `permisos_roles`
--

DROP TABLE IF EXISTS `permisos_roles`;
CREATE TABLE `permisos_roles` (
  `id_permiso` int(11) NOT NULL,
  `id_rol` int(11) NOT NULL,
  `insertar` tinyint(1) DEFAULT NULL,
  `modificar` tinyint(1) DEFAULT NULL,
  `eliminar` tinyint(1) DEFAULT NULL,
  `listar` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `permisos_roles`
--

INSERT INTO `permisos_roles` (`id_permiso`, `id_rol`, `insertar`, `modificar`, `eliminar`, `listar`) VALUES
(1, 1, 1, 1, 1, 1),
(2, 1, 1, 1, 1, 1),
(3, 1, 1, 1, 1, 1),
(3, 2, 1, 1, 0, 1),
(1, 2, 1, 0, 0, 1),
(2, 2, 1, 1, 1, 1),
(4, 2, 1, 1, 0, 1),
(5, 2, 1, 1, 0, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `permisos_usuarios`
--

DROP TABLE IF EXISTS `permisos_usuarios`;
CREATE TABLE `permisos_usuarios` (
  `id_permiso` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `insertar` tinyint(1) DEFAULT NULL,
  `modificar` tinyint(1) DEFAULT NULL,
  `eliminar` tinyint(1) DEFAULT NULL,
  `listar` tinyint(1) DEFAULT NULL,
  `dias` int(11) DEFAULT NULL,
  `fechadealta` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `personal`
--

DROP TABLE IF EXISTS `personal`;
CREATE TABLE `personal` (
  `idpersonal` int(11) NOT NULL,
  `nombre` varchar(99) DEFAULT NULL,
  `apellido` varchar(99) DEFAULT NULL,
  `cargo` varchar(99) DEFAULT NULL,
  `fecharregistro` date DEFAULT NULL,
  `ficha` int(11) DEFAULT NULL,
  `domicilio` varchar(99) DEFAULT NULL,
  `dni` int(11) DEFAULT NULL,
  `mail` varchar(255) DEFAULT NULL,
  `idtipopersonal` int(11) NOT NULL,
  `habilitado` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `roles`
--

DROP TABLE IF EXISTS `roles`;
CREATE TABLE `roles` (
  `id_rol` int(11) NOT NULL,
  `nombre` varchar(255) NOT NULL,
  `habilitado` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `roles`
--

INSERT INTO `roles` (`id_rol`, `nombre`, `habilitado`) VALUES
(1, 'Administrador', 1),
(2, 'UsuarioB', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `roles_usuarios`
--

DROP TABLE IF EXISTS `roles_usuarios`;
CREATE TABLE `roles_usuarios` (
  `id_rol` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `roles_usuarios`
--

INSERT INTO `roles_usuarios` (`id_rol`, `id_usuario`) VALUES
(2, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipoaulas`
--

DROP TABLE IF EXISTS `tipoaulas`;
CREATE TABLE `tipoaulas` (
  `idtipoaula` int(11) NOT NULL,
  `descripcion` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipopersonal`
--

DROP TABLE IF EXISTS `tipopersonal`;
CREATE TABLE `tipopersonal` (
  `idtipopersonal` int(11) NOT NULL,
  `descripcion` varchar(255) NOT NULL,
  `habilitado` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

DROP TABLE IF EXISTS `usuarios`;
CREATE TABLE `usuarios` (
  `id_usuario` int(11) NOT NULL,
  `nombre` varchar(99) NOT NULL,
  `apellido` varchar(99) NOT NULL,
  `contrasenia` varchar(255) NOT NULL,
  `mail` varchar(255) NOT NULL,
  `fallidos` int(11) NOT NULL,
  `habilitado` tinyint(1) NOT NULL,
  `fecharegistro` date NOT NULL,
  `telefono` varchar(99) NOT NULL,
  `dni` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id_usuario`, `nombre`, `apellido`, `contrasenia`, `mail`, `fallidos`, `habilitado`, `fecharegistro`, `telefono`, `dni`) VALUES
(1, 'efwf', 'wfwfwf', '16892d5e22916f3ae196c8d6c71f0075', 'wfwfwf', 34, 1, '2020-10-06', '2414', 2414);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `alumnos`
--
ALTER TABLE `alumnos`
  ADD PRIMARY KEY (`legajo`);

--
-- Indices de la tabla `asignacionaluas`
--
ALTER TABLE `asignacionaluas`
  ADD PRIMARY KEY (`idasignacion`),
  ADD KEY `idpersonal` (`idpersonal`),
  ADD KEY `id_materia` (`id_materia`),
  ADD KEY `idaula` (`idaula`);

--
-- Indices de la tabla `aulas`
--
ALTER TABLE `aulas`
  ADD PRIMARY KEY (`idaula`),
  ADD KEY `idtipoaula` (`idtipoaula`);

--
-- Indices de la tabla `carrera`
--
ALTER TABLE `carrera`
  ADD PRIMARY KEY (`idcarrera`);

--
-- Indices de la tabla `entregamateriales`
--
ALTER TABLE `entregamateriales`
  ADD PRIMARY KEY (`identrega`),
  ADD KEY `idpersonal` (`idpersonal`);

--
-- Indices de la tabla `ingresosegresosalumnos`
--
ALTER TABLE `ingresosegresosalumnos`
  ADD KEY `legajo` (`legajo`);

--
-- Indices de la tabla `ingresosegresospersonal`
--
ALTER TABLE `ingresosegresospersonal`
  ADD KEY `idpersonal` (`idpersonal`);

--
-- Indices de la tabla `materiales`
--
ALTER TABLE `materiales`
  ADD PRIMARY KEY (`idmaterial`);

--
-- Indices de la tabla `materias`
--
ALTER TABLE `materias`
  ADD PRIMARY KEY (`id_materia`),
  ADD KEY `idcarrera` (`idcarrera`);

--
-- Indices de la tabla `materiasdocente`
--
ALTER TABLE `materiasdocente`
  ADD KEY `id_materia` (`id_materia`),
  ADD KEY `idpersonal` (`idpersonal`);

--
-- Indices de la tabla `notificacion`
--
ALTER TABLE `notificacion`
  ADD PRIMARY KEY (`idnotificacion`);

--
-- Indices de la tabla `permisos`
--
ALTER TABLE `permisos`
  ADD PRIMARY KEY (`id_permiso`);

--
-- Indices de la tabla `permisos_roles`
--
ALTER TABLE `permisos_roles`
  ADD KEY `id_permiso` (`id_permiso`),
  ADD KEY `id_rol` (`id_rol`);

--
-- Indices de la tabla `permisos_usuarios`
--
ALTER TABLE `permisos_usuarios`
  ADD KEY `id_permiso` (`id_permiso`),
  ADD KEY `id_usuario` (`id_usuario`);

--
-- Indices de la tabla `personal`
--
ALTER TABLE `personal`
  ADD PRIMARY KEY (`idpersonal`),
  ADD KEY `idtipopersonal` (`idtipopersonal`);

--
-- Indices de la tabla `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id_rol`);

--
-- Indices de la tabla `roles_usuarios`
--
ALTER TABLE `roles_usuarios`
  ADD KEY `id_rol` (`id_rol`),
  ADD KEY `id_usuario` (`id_usuario`);

--
-- Indices de la tabla `tipoaulas`
--
ALTER TABLE `tipoaulas`
  ADD PRIMARY KEY (`idtipoaula`);

--
-- Indices de la tabla `tipopersonal`
--
ALTER TABLE `tipopersonal`
  ADD PRIMARY KEY (`idtipopersonal`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id_usuario`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `alumnos`
--
ALTER TABLE `alumnos`
  MODIFY `legajo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `asignacionaluas`
--
ALTER TABLE `asignacionaluas`
  MODIFY `idasignacion` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `carrera`
--
ALTER TABLE `carrera`
  MODIFY `idcarrera` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `entregamateriales`
--
ALTER TABLE `entregamateriales`
  MODIFY `identrega` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `materiales`
--
ALTER TABLE `materiales`
  MODIFY `idmaterial` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `materias`
--
ALTER TABLE `materias`
  MODIFY `id_materia` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `notificacion`
--
ALTER TABLE `notificacion`
  MODIFY `idnotificacion` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `permisos`
--
ALTER TABLE `permisos`
  MODIFY `id_permiso` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `personal`
--
ALTER TABLE `personal`
  MODIFY `idpersonal` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `roles`
--
ALTER TABLE `roles`
  MODIFY `id_rol` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `tipoaulas`
--
ALTER TABLE `tipoaulas`
  MODIFY `idtipoaula` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `tipopersonal`
--
ALTER TABLE `tipopersonal`
  MODIFY `idtipopersonal` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id_usuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `asignacionaluas`
--
ALTER TABLE `asignacionaluas`
  ADD CONSTRAINT `asignacionaluas_ibfk_1` FOREIGN KEY (`idpersonal`) REFERENCES `personal` (`idpersonal`),
  ADD CONSTRAINT `asignacionaluas_ibfk_2` FOREIGN KEY (`id_materia`) REFERENCES `materias` (`id_materia`),
  ADD CONSTRAINT `asignacionaluas_ibfk_3` FOREIGN KEY (`idaula`) REFERENCES `aulas` (`idaula`);

--
-- Filtros para la tabla `aulas`
--
ALTER TABLE `aulas`
  ADD CONSTRAINT `aulas_ibfk_1` FOREIGN KEY (`idtipoaula`) REFERENCES `tipoaulas` (`idtipoaula`);

--
-- Filtros para la tabla `entregamateriales`
--
ALTER TABLE `entregamateriales`
  ADD CONSTRAINT `entregamateriales_ibfk_1` FOREIGN KEY (`idpersonal`) REFERENCES `personal` (`idpersonal`);

--
-- Filtros para la tabla `ingresosegresosalumnos`
--
ALTER TABLE `ingresosegresosalumnos`
  ADD CONSTRAINT `ingresosegresosalumnos_ibfk_1` FOREIGN KEY (`legajo`) REFERENCES `alumnos` (`legajo`);

--
-- Filtros para la tabla `ingresosegresospersonal`
--
ALTER TABLE `ingresosegresospersonal`
  ADD CONSTRAINT `ingresosegresospersonal_ibfk_1` FOREIGN KEY (`idpersonal`) REFERENCES `personal` (`idpersonal`);

--
-- Filtros para la tabla `materias`
--
ALTER TABLE `materias`
  ADD CONSTRAINT `materias_ibfk_1` FOREIGN KEY (`idcarrera`) REFERENCES `carrera` (`idcarrera`);

--
-- Filtros para la tabla `materiasdocente`
--
ALTER TABLE `materiasdocente`
  ADD CONSTRAINT `materiasdocente_ibfk_1` FOREIGN KEY (`id_materia`) REFERENCES `materias` (`id_materia`),
  ADD CONSTRAINT `materiasdocente_ibfk_2` FOREIGN KEY (`idpersonal`) REFERENCES `personal` (`idpersonal`);

--
-- Filtros para la tabla `permisos_roles`
--
ALTER TABLE `permisos_roles`
  ADD CONSTRAINT `permisos_roles_ibfk_1` FOREIGN KEY (`id_permiso`) REFERENCES `permisos` (`id_permiso`),
  ADD CONSTRAINT `permisos_roles_ibfk_2` FOREIGN KEY (`id_rol`) REFERENCES `roles` (`id_rol`);

--
-- Filtros para la tabla `permisos_usuarios`
--
ALTER TABLE `permisos_usuarios`
  ADD CONSTRAINT `permisos_usuarios_ibfk_1` FOREIGN KEY (`id_permiso`) REFERENCES `permisos` (`id_permiso`),
  ADD CONSTRAINT `permisos_usuarios_ibfk_2` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`);

--
-- Filtros para la tabla `personal`
--
ALTER TABLE `personal`
  ADD CONSTRAINT `personal_ibfk_1` FOREIGN KEY (`idtipopersonal`) REFERENCES `tipopersonal` (`idtipopersonal`);

--
-- Filtros para la tabla `roles_usuarios`
--
ALTER TABLE `roles_usuarios`
  ADD CONSTRAINT `roles_usuarios_ibfk_1` FOREIGN KEY (`id_rol`) REFERENCES `roles` (`id_rol`),
  ADD CONSTRAINT `roles_usuarios_ibfk_2` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
