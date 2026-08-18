-- phpMyAdmin SQL Dump
-- version 5.2.3
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost
-- Tiempo de generación: 18-08-2026 a las 23:17:49
-- Versión del servidor: 10.11.10-MariaDB-log
-- Versión de PHP: 8.3.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `cotizadordb`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `audit_logs`
--

CREATE TABLE `audit_logs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `event_type` varchar(100) NOT NULL,
  `module` varchar(100) NOT NULL,
  `action` varchar(100) NOT NULL,
  `entity_type` varchar(100) DEFAULT NULL,
  `entity_id` bigint(20) UNSIGNED DEFAULT NULL,
  `description` varchar(500) NOT NULL,
  `old_values` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`old_values`)),
  `new_values` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`new_values`)),
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` varchar(1000) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

--
-- Volcado de datos para la tabla `audit_logs`
--

INSERT INTO `audit_logs` (`id`, `user_id`, `event_type`, `module`, `action`, `entity_type`, `entity_id`, `description`, `old_values`, `new_values`, `ip_address`, `user_agent`, `created_at`) VALUES
(1, 1, 'install_admin', 'auth', 'install_admin', 'users', 1, 'Se creó el administrador inicial', NULL, NULL, '190.53.248.170', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-17 21:23:29'),
(2, 1, 'create', 'quotes', 'create', 'projects', 1, 'Creó cotización COT-2026-00001', NULL, '{\"name\":\"Sitio Insight\",\"total_cost\":1410,\"final_price\":1321.875}', '190.53.248.170', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-17 21:24:28'),
(3, 1, 'update', 'quotes', 'update', 'projects', 1, 'Actualizó cotización Sitio Insight', '{\"id\":1,\"public_code\":\"COT-2026-00001\",\"name\":\"Sitio Insight\",\"country_id\":1,\"currency_id\":null,\"methodology\":\"cuantitativo\",\"category_id\":null,\"status\":\"draft\",\"sample_size\":2,\"proposed_margin_percent\":\"25.0000\",\"approved_discount_percent\":\"25.0000\",\"total_cost\":\"1410.00\",\"total_margin\":\"352.50\",\"final_price\":\"1321.88\",\"calculation_data\":\"{\\\"sample_size\\\":2,\\\"field_unit_cost\\\":130,\\\"telecom_cost\\\":150,\\\"materials_cost\\\":1000,\\\"difficulty_score\\\":5}\",\"created_by\":1,\"updated_by\":1,\"finalized_at\":null,\"created_at\":\"2026-08-17 21:24:28\",\"updated_at\":\"2026-08-17 21:24:28\",\"deleted_at\":null}', '{\"total_cost\":1410,\"final_price\":1321.875}', '190.53.248.170', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-17 21:24:31'),
(4, 1, 'create_cost', 'catalogs', 'create_cost', 'country_costs', 1, 'Agregó tarifa hola', NULL, NULL, '190.53.248.170', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-17 21:25:03'),
(5, 1, 'import', 'catalogs', 'import', NULL, NULL, 'Importó 6 registros: countries', NULL, '{\"file\":\"List_Paises.csv\",\"records\":6}', '190.53.248.170', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-17 21:30:27'),
(6, 1, 'import', 'catalogs', 'import', NULL, NULL, 'Importó 11 registros: currencies', NULL, '{\"file\":\"List_moneda.csv\",\"records\":11}', '190.53.248.170', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-17 21:30:40'),
(7, 1, 'import', 'catalogs', 'import', NULL, NULL, 'Importó 0 registros: population', NULL, '{\"file\":\"List_Poblacion.csv\",\"records\":0}', '190.53.248.170', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-17 21:30:51'),
(8, 1, 'import', 'catalogs', 'import', NULL, NULL, 'Importó 0 registros: parameters', NULL, '{\"file\":\"List_PartTb.csv\",\"records\":0}', '190.53.248.170', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-17 21:31:02'),
(9, 1, 'import', 'catalogs', 'import', NULL, NULL, 'Importó 195 registros: costs', NULL, '{\"file\":\"Cotizador_Estudio_Cuanti_Campo.csv\",\"records\":195}', '190.53.248.170', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-17 21:31:09'),
(10, 1, 'login', 'auth', 'login', 'users', 1, 'Inicio de sesión', NULL, NULL, '190.53.248.170', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-17 22:57:57'),
(11, 1, 'login', 'auth', 'login', 'users', 1, 'Inicio de sesión', NULL, NULL, '190.53.248.170', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-17 22:58:37'),
(12, 1, 'login', 'auth', 'login', 'users', 1, 'Inicio de sesión', NULL, NULL, '190.53.248.170', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-17 23:29:22'),
(13, 1, 'login', 'auth', 'login', 'users', 1, 'Inicio de sesión', NULL, NULL, '190.53.248.170', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-18 03:04:05'),
(14, 1, 'login', 'auth', 'login', 'users', 1, 'Inicio de sesión', NULL, NULL, '190.53.248.170', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-18 04:51:49'),
(15, 1, 'logout', 'auth', 'logout', NULL, NULL, 'Cierre de sesión', NULL, NULL, '190.53.248.170', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-18 04:51:54'),
(16, 1, 'login', 'auth', 'login', 'users', 1, 'Inicio de sesión', NULL, NULL, '190.53.248.170', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-18 04:51:56'),
(17, 1, 'login', 'auth', 'login', 'users', 1, 'Inicio de sesión', NULL, NULL, '190.53.248.170', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-18 04:52:31'),
(18, 1, 'logout', 'auth', 'logout', NULL, NULL, 'Cierre de sesión', NULL, NULL, '190.53.248.170', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-18 04:52:33'),
(19, 1, 'login', 'auth', 'login', 'users', 1, 'Inicio de sesión', NULL, NULL, '190.53.248.170', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-18 04:52:36'),
(20, 1, 'login', 'auth', 'login', 'users', 1, 'Inicio de sesión', NULL, NULL, '190.53.248.170', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-18 04:52:57'),
(21, 1, 'login', 'auth', 'login', 'users', 1, 'Inicio de sesión', NULL, NULL, '190.53.248.170', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', '2026-08-18 05:25:27'),
(22, 1, 'create', 'quotes', 'create', 'projects', 7, 'Creó cotización COT-2026-7FDD0F', NULL, '{\"name\":\"asdas\",\"total_cost\":69755,\"final_price\":72545.2}', '190.53.248.170', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', '2026-08-18 05:27:17'),
(23, 1, 'create', 'quotes', 'create', 'projects', 8, 'Creó cotización COT-2026-0226FF', NULL, '{\"name\":\"asdas\",\"total_cost\":24259.17,\"final_price\":31536.92}', '190.53.248.170', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', '2026-08-18 05:42:57'),
(24, 1, 'create_cost', 'catalogs', 'create_cost', 'country_costs', 197, 'Agregó tarifa Tarifa de cada celular', NULL, NULL, '190.53.248.170', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', '2026-08-18 05:43:59');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `b2b_profiles`
--

CREATE TABLE `b2b_profiles` (
  `id` tinyint(3) UNSIGNED NOT NULL,
  `code` varchar(40) NOT NULL,
  `name` varchar(180) NOT NULL,
  `difficulty_score` decimal(3,1) NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `b2b_profiles`
--

INSERT INTO `b2b_profiles` (`id`, `code`, `name`, `difficulty_score`, `is_active`, `created_at`) VALUES
(1, 'low', 'Profesionales/gerentes/empresarios bajo perfil (Micro y pequena empresa)', 3.0, 1, '2026-08-18 06:39:58'),
(2, 'high', 'Profesionales/gerentes/empresarios de alto perfil (mediana y gran empresa)', 4.0, 1, '2026-08-18 06:39:58'),
(3, 'opinion_leaders', 'Target lideres de opinion, profesionales especializados', 5.0, 1, '2026-08-18 06:39:58');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `categories`
--

CREATE TABLE `categories` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `sector_code` varchar(40) DEFAULT NULL,
  `category_code` varchar(40) DEFAULT NULL,
  `sector` varchar(180) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `market_penetration` decimal(8,5) DEFAULT NULL,
  `penetration_score` tinyint(3) UNSIGNED DEFAULT NULL,
  `difficulty_level` varchar(100) DEFAULT NULL,
  `difficulty_score` decimal(10,3) DEFAULT NULL,
  `sort_order` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

--
-- Volcado de datos para la tabla `categories`
--

INSERT INTO `categories` (`id`, `sector_code`, `category_code`, `sector`, `name`, `market_penetration`, `penetration_score`, `difficulty_level`, `difficulty_score`, `sort_order`, `is_active`, `created_at`, `updated_at`) VALUES
(1, NULL, NULL, 'Consumo masivo', 'Producto de consumo masivo (alimentos y bebidas no alcohólicas)', 1.00000, 1, NULL, 1.000, 0, 0, '2026-08-17 23:11:18', '2026-08-18 14:24:33'),
(2, NULL, NULL, 'Cuidado personal', 'Productos de cuidado personal', 1.00000, 1, NULL, 1.000, 0, 0, '2026-08-17 23:11:18', '2026-08-18 14:24:33'),
(3, NULL, NULL, 'Bebidas', 'Bebidas alcohólicas (Cervezas)', 1.00000, 1, NULL, 1.000, 0, 0, '2026-08-17 23:11:18', '2026-08-18 14:24:33'),
(4, NULL, NULL, 'Bebidas', 'Bebidas alcohólicas (licores)', 1.00000, 1, NULL, 1.000, 0, 0, '2026-08-17 23:11:18', '2026-08-18 14:24:33'),
(5, NULL, NULL, 'Electrónica', 'Productos electrónicos (celulares, accesorios, tabletas, consolas de video juegos, etc….)', 1.00000, 1, NULL, 1.000, 0, 0, '2026-08-17 23:11:18', '2026-08-18 14:24:33'),
(6, NULL, NULL, 'Educación', 'Educación', 1.00000, 1, NULL, 1.000, 0, 0, '2026-08-17 23:11:18', '2026-08-18 14:24:33'),
(7, NULL, NULL, 'Mascotas', 'Productos de cuidado de mascotas', 2.00000, 1, NULL, 2.000, 0, 0, '2026-08-17 23:11:18', '2026-08-18 14:24:33'),
(8, NULL, NULL, 'Servicios', 'Servicios (varios)', 2.00000, 1, NULL, 2.000, 0, 0, '2026-08-17 23:11:18', '2026-08-18 14:24:33'),
(9, NULL, NULL, 'Línea blanca', 'Productos de línea blanca', 2.00000, 1, NULL, 2.000, 0, 0, '2026-08-17 23:11:18', '2026-08-18 14:24:33'),
(10, NULL, NULL, 'Finanzas', 'Productos financieros', 3.00000, 1, NULL, 3.000, 0, 0, '2026-08-17 23:11:18', '2026-08-18 14:24:33'),
(11, NULL, NULL, 'Automotriz', 'Industria automovilística (Venta de automóviles)', 3.00000, 1, NULL, 3.000, 0, 0, '2026-08-17 23:11:18', '2026-08-18 14:24:33'),
(12, NULL, NULL, 'Farmacéuticos', 'Productos farmacéuticos', 4.00000, 1, NULL, 4.000, 0, 0, '2026-08-17 23:11:18', '2026-08-18 14:24:33'),
(13, NULL, NULL, 'Construcción', 'Productos de construcción', 5.00000, 1, NULL, 5.000, 0, 0, '2026-08-17 23:11:18', '2026-08-18 14:24:33'),
(14, NULL, NULL, 'Lujo', 'Productos de lujo', 5.00000, 1, NULL, 5.000, 0, 0, '2026-08-17 23:11:18', '2026-08-18 14:24:33'),
(15, NULL, NULL, 'Target', 'Producto de consumo masivo (alimentos y bebidas no alcohólicas)', 0.25000, 4, NULL, 1.000, 1, 1, '2026-08-18 01:09:14', '2026-08-18 06:39:58'),
(16, NULL, NULL, 'Target', 'Productos de cuidado personal', 0.30000, 4, NULL, 1.200, 2, 1, '2026-08-18 01:09:14', '2026-08-18 06:39:58'),
(17, NULL, NULL, 'Target', 'Bebidas alcohólicas (Cervezas)', 0.18000, 5, NULL, 1.000, 3, 1, '2026-08-18 01:09:14', '2026-08-18 06:39:58'),
(18, NULL, NULL, 'Target', 'Bebidas alcohólicas (licores)', 0.15000, 5, NULL, 1.500, 4, 1, '2026-08-18 01:09:14', '2026-08-18 06:39:58'),
(19, NULL, NULL, 'Target', 'Productos electrónicos (celulares, accesorios, tabletas, consolas de video juegos, etc….)', 0.22000, 4, NULL, 1.400, 5, 1, '2026-08-18 01:09:14', '2026-08-18 06:39:58'),
(20, NULL, NULL, 'Target', 'Educación', 0.20000, 5, NULL, 1.100, 6, 1, '2026-08-18 01:09:14', '2026-08-18 06:39:58'),
(21, NULL, NULL, 'Target', 'Productos de cuidado de mascotas', 0.35000, 4, NULL, 2.200, 7, 1, '2026-08-18 01:09:14', '2026-08-18 06:39:58'),
(22, NULL, NULL, 'Target', 'Servicios (varios)', 0.38000, 4, NULL, 2.400, 8, 1, '2026-08-18 01:09:14', '2026-08-18 06:39:58'),
(23, NULL, NULL, 'Target', 'Productos de línea blanca', 0.26000, 4, NULL, 2.000, 9, 1, '2026-08-18 01:09:14', '2026-08-18 06:39:58'),
(24, NULL, NULL, 'Target', 'Productos financieros', 0.40000, 4, NULL, 3.100, 10, 1, '2026-08-18 01:09:14', '2026-08-18 06:39:58'),
(25, NULL, NULL, 'Target', 'Industria automovilística (Venta de automóviles)', 0.34000, 4, NULL, 3.000, 11, 1, '2026-08-18 01:09:14', '2026-08-18 06:39:58'),
(26, NULL, NULL, 'Target', 'Productos farmacéuticos', 0.45000, 3, NULL, 4.000, 12, 1, '2026-08-18 01:09:14', '2026-08-18 06:39:58'),
(27, NULL, NULL, 'Target', 'Productos de construcción', 0.50000, 3, NULL, 5.000, 13, 1, '2026-08-18 01:09:14', '2026-08-18 06:39:58'),
(28, NULL, NULL, 'Target', 'Productos de lujo', 0.55000, 3, NULL, 5.000, 14, 1, '2026-08-18 01:09:14', '2026-08-18 06:39:58'),
(29, NULL, NULL, 'Target', 'Producto de consumo masivo (alimentos y bebidas no alcohólicas)', 0.25000, 4, NULL, 1.000, 1, 0, '2026-08-18 01:09:24', '2026-08-18 14:24:33'),
(30, NULL, NULL, 'Target', 'Productos de cuidado personal', 0.30000, 4, NULL, 1.200, 2, 0, '2026-08-18 01:09:24', '2026-08-18 14:24:33'),
(31, NULL, NULL, 'Target', 'Bebidas alcohólicas (Cervezas)', 0.18000, 5, NULL, 1.000, 3, 0, '2026-08-18 01:09:24', '2026-08-18 14:24:33'),
(32, NULL, NULL, 'Target', 'Bebidas alcohólicas (licores)', 0.15000, 5, NULL, 1.500, 4, 0, '2026-08-18 01:09:24', '2026-08-18 14:24:33'),
(33, NULL, NULL, 'Target', 'Productos electrónicos (celulares, accesorios, tabletas, consolas de video juegos, etc….)', 0.22000, 4, NULL, 1.400, 5, 0, '2026-08-18 01:09:24', '2026-08-18 14:24:33'),
(34, NULL, NULL, 'Target', 'Educación', 0.20000, 5, NULL, 1.100, 6, 0, '2026-08-18 01:09:24', '2026-08-18 14:24:33'),
(35, NULL, NULL, 'Target', 'Productos de cuidado de mascotas', 0.35000, 4, NULL, 2.200, 7, 0, '2026-08-18 01:09:24', '2026-08-18 14:24:33'),
(36, NULL, NULL, 'Target', 'Servicios (varios)', 0.38000, 4, NULL, 2.400, 8, 0, '2026-08-18 01:09:24', '2026-08-18 14:24:33'),
(37, NULL, NULL, 'Target', 'Productos de línea blanca', 0.26000, 4, NULL, 2.000, 9, 0, '2026-08-18 01:09:24', '2026-08-18 14:24:33'),
(38, NULL, NULL, 'Target', 'Productos financieros', 0.40000, 4, NULL, 3.100, 10, 0, '2026-08-18 01:09:24', '2026-08-18 14:24:33'),
(39, NULL, NULL, 'Target', 'Industria automovilística (Venta de automóviles)', 0.34000, 4, NULL, 3.000, 11, 0, '2026-08-18 01:09:24', '2026-08-18 14:24:33'),
(40, NULL, NULL, 'Target', 'Productos farmacéuticos', 0.45000, 3, NULL, 4.000, 12, 0, '2026-08-18 01:09:24', '2026-08-18 14:24:33'),
(41, NULL, NULL, 'Target', 'Productos de construcción', 0.50000, 3, NULL, 5.000, 13, 0, '2026-08-18 01:09:24', '2026-08-18 14:24:33'),
(42, NULL, NULL, 'Target', 'Productos de lujo', 0.55000, 3, NULL, 5.000, 14, 0, '2026-08-18 01:09:24', '2026-08-18 14:24:33');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `countries`
--

CREATE TABLE `countries` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `code` char(3) DEFAULT NULL,
  `name` varchar(100) NOT NULL,
  `population` bigint(20) UNSIGNED DEFAULT NULL,
  `female_population` bigint(20) UNSIGNED DEFAULT NULL,
  `male_population` bigint(20) UNSIGNED DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `deleted_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

--
-- Volcado de datos para la tabla `countries`
--

INSERT INTO `countries` (`id`, `code`, `name`, `population`, `female_population`, `male_population`, `is_active`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'HND', 'Honduras', 9574376, 4915717, 4658659, 1, '2026-08-17 21:04:52', '2026-08-17 21:04:52', NULL),
(2, 'ELS', 'El Salvador', NULL, NULL, NULL, 1, '2026-08-17 21:30:27', '2026-08-18 06:11:22', NULL),
(3, 'CH', 'Chile', NULL, NULL, NULL, 1, '2026-08-17 21:30:27', '2026-08-18 06:11:28', NULL),
(4, 'MX', 'Mexico', NULL, NULL, NULL, 1, '2026-08-17 21:30:27', '2026-08-18 06:11:32', NULL),
(5, 'GT', 'Guatemala', NULL, NULL, NULL, 1, '2026-08-17 21:30:27', '2026-08-18 06:11:36', NULL),
(6, 'MT', 'Martin', NULL, NULL, NULL, 0, '2026-08-17 21:30:27', '2026-08-18 14:24:33', '2026-08-18 14:24:33'),
(7, 'CO', 'Colombia', NULL, NULL, NULL, 1, '2026-08-17 21:30:40', '2026-08-18 06:11:46', NULL),
(8, 'CR', 'Costa Rica', NULL, NULL, NULL, 1, '2026-08-17 21:30:40', '2026-08-18 06:11:49', NULL),
(9, 'PN', 'Panama', NULL, NULL, NULL, 1, '2026-08-17 21:30:40', '2026-08-18 06:11:53', NULL),
(10, 'PR', 'Peru', NULL, NULL, NULL, 1, '2026-08-17 21:30:40', '2026-08-18 06:11:56', NULL),
(11, 'RD', 'Republica Dominicana', NULL, NULL, NULL, 1, '2026-08-17 21:30:40', '2026-08-18 06:12:00', NULL),
(12, 'EC', 'Ecuador', NULL, NULL, NULL, 1, '2026-08-17 21:30:40', '2026-08-18 06:12:03', NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `country_costs`
--

CREATE TABLE `country_costs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `country_id` bigint(20) UNSIGNED NOT NULL,
  `currency_id` bigint(20) UNSIGNED DEFAULT NULL,
  `cost_key` varchar(150) NOT NULL,
  `label` varchar(200) NOT NULL,
  `amount` decimal(18,4) NOT NULL DEFAULT 0.0000,
  `category` varchar(100) DEFAULT NULL,
  `effective_from` date NOT NULL,
  `effective_to` date DEFAULT NULL,
  `is_current` tinyint(1) NOT NULL DEFAULT 1,
  `updated_by` bigint(20) UNSIGNED DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

--
-- Volcado de datos para la tabla `country_costs`
--

INSERT INTO `country_costs` (`id`, `country_id`, `currency_id`, `cost_key`, `label`, `amount`, `category`, `effective_from`, `effective_to`, `is_current`, `updated_by`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 'pago', 'hola', 123.0000, 'telecom', '2026-08-17', '2026-08-18', 0, 1, '2026-08-17 21:25:03', '2026-08-18 14:24:33'),
(2, 1, 1, 'coste_espacio_en_la_nube', 'Coste espacio en la nube', 210.0000, 'Importado', '2026-08-17', NULL, 1, 1, '2026-08-17 21:31:09', '2026-08-17 21:31:09'),
(3, 1, 1, 'coste_encuestas', 'Coste encuestas', 210.0000, 'Importado', '2026-08-17', NULL, 1, 1, '2026-08-17 21:31:09', '2026-08-17 21:31:09'),
(4, 1, 1, 'coste_paquete_diario_llamadas_y_datos', 'Coste paquete diario llamadas y datos', 100.0000, 'Importado', '2026-08-17', NULL, 1, 1, '2026-08-17 21:31:09', '2026-08-17 21:31:09'),
(5, 1, 1, 'precio_computadora', 'Precio_computadora', 3000.0000, 'Importado', '2026-08-17', NULL, 0, 1, '2026-08-17 21:31:09', '2026-08-17 21:31:09'),
(6, 1, 1, 'precio_de_canasta_basica', 'Precio_de_Canasta básica', 0.0000, 'Importado', '2026-08-17', NULL, 0, 1, '2026-08-17 21:31:09', '2026-08-17 21:31:09'),
(7, 1, 1, 'salario_minimo_mensual_servicios', 'Salario_mínimo_mensual_servicios', 8500.0000, 'Importado', '2026-08-17', NULL, 0, 1, '2026-08-17 21:31:09', '2026-08-17 21:31:09'),
(8, 1, 1, 'ratio_incremento_salario_minimo', 'Ratio_incremento_salario_minimo', 12.0000, 'Importado', '2026-08-17', NULL, 0, 1, '2026-08-17 21:31:09', '2026-08-17 21:31:09'),
(9, 1, 1, 'salario_mensual_encuestador_campo', 'Salario_mensual_Encuestador_Campo', 10.2000, 'Importado', '2026-08-17', NULL, 0, 1, '2026-08-17 21:31:09', '2026-08-17 21:31:09'),
(10, 1, 1, 'salario_mensual_supervisor_campo', 'Salario_mensual_Supervisor_Campo', 12.2400, 'Importado', '2026-08-17', NULL, 0, 1, '2026-08-17 21:31:09', '2026-08-17 21:31:09'),
(11, 1, 1, 'salario_mensual_coordinador_procesado', 'Salario_mensual_Coordinador_Procesado', 12.0000, 'Importado', '2026-08-17', NULL, 0, 1, '2026-08-17 21:31:09', '2026-08-17 21:31:09'),
(12, 1, 1, 'salario_mensual_responsable_procesado', 'Salario_mensual_Responsable_Procesado', 10.5000, 'Importado', '2026-08-17', NULL, 0, 1, '2026-08-17 21:31:09', '2026-08-17 21:31:09'),
(13, 1, 1, 'salario_mensual_coordinador_operaciones', 'Salario_mensual_Coordinador_Operaciones', 12.0000, 'Importado', '2026-08-17', NULL, 0, 1, '2026-08-17 21:31:09', '2026-08-17 21:31:09'),
(14, 1, 1, 'salario_mensual_responsable_operaciones', 'Salario mensual Responsable Operaciones', 10.5000, 'Importado', '2026-08-17', NULL, 0, 1, '2026-08-17 21:31:09', '2026-08-17 21:31:09'),
(15, 1, 1, 'salario_mensual_coordinador_auditoria', 'Salario_mensual_Coordinador_Auditoria', 11.5000, 'Importado', '2026-08-17', NULL, 0, 1, '2026-08-17 21:31:09', '2026-08-17 21:31:09'),
(16, 1, 1, 'salario_mensual_responsable_auditoria', 'Salario mensual Responsable Auditoría', 10.5000, 'Importado', '2026-08-17', NULL, 0, 1, '2026-08-17 21:31:09', '2026-08-17 21:31:09'),
(17, 1, 1, 'salario_mensual_analistas_y_soporte', 'Salario mensual Analistas y Soporte', 11.0000, 'Importado', '2026-08-17', NULL, 0, 1, '2026-08-17 21:31:09', '2026-08-17 21:31:09'),
(18, 1, 1, 'salario_mensual_ejecutivo', 'Salario mensual Ejecutivo', 15.0000, 'Importado', '2026-08-17', NULL, 0, 1, '2026-08-17 21:31:09', '2026-08-17 21:31:09'),
(19, 1, 1, 'pago_dia_oficina', 'Pago día oficina', 75.0000, 'Importado', '2026-08-17', NULL, 0, 1, '2026-08-17 21:31:09', '2026-08-17 21:31:09'),
(20, 1, 1, 'dias_minimos_laborales_mes', 'Díás mínimos laborales mes', 24.0000, 'Importado', '2026-08-17', NULL, 0, 1, '2026-08-17 21:31:09', '2026-08-17 21:31:09'),
(21, 1, 1, 'pago_dia_encuestadores_campo', 'Pago día Encuestadores Campo', 425.0000, 'Importado', '2026-08-17', NULL, 0, 1, '2026-08-17 21:31:09', '2026-08-17 21:31:09'),
(22, 1, 1, 'pago_dia_supervisores_campo', 'Pago día Supervisores Campo', 510.0000, 'Importado', '2026-08-17', NULL, 0, 1, '2026-08-17 21:31:09', '2026-08-17 21:31:09'),
(23, 1, 1, 'pago_dia_coordinador_procesado', 'Pago_dia_Coordinador_Procesado', 500.0000, 'Importado', '2026-08-17', NULL, 0, 1, '2026-08-17 21:31:09', '2026-08-17 21:31:09'),
(24, 1, 1, 'pago_dia_responsable_procesado', 'Pago_dia_Responsable_Procesado', 438.0000, 'Importado', '2026-08-17', NULL, 0, 1, '2026-08-17 21:31:09', '2026-08-17 21:31:09'),
(25, 1, 1, 'pago_dia_coordinador_operaciones', 'Pago_día_Coordinador_Operaciones', 500.0000, 'Importado', '2026-08-17', NULL, 0, 1, '2026-08-17 21:31:09', '2026-08-17 21:31:09'),
(26, 1, 1, 'pago_dia_responsable_operaciones', 'Pago_dia_Responsable _Operaciones', 438.0000, 'Importado', '2026-08-17', NULL, 0, 1, '2026-08-17 21:31:09', '2026-08-17 21:31:09'),
(27, 1, 1, 'pago_dia_coordinador_auditoria', 'Pago_dia_Coordinador_Auditoria', 479.0000, 'Importado', '2026-08-17', NULL, 0, 1, '2026-08-17 21:31:09', '2026-08-17 21:31:09'),
(28, 1, 1, 'pago_dia_responsable_auditoria', 'Pago_dia_Responsable_Auditoria', 438.0000, 'Importado', '2026-08-17', NULL, 0, 1, '2026-08-17 21:31:09', '2026-08-17 21:31:09'),
(29, 1, 1, 'pago_dia_analistas_y_soporte', 'Pago_dia_Analistas_y_Soporte', 458.0000, 'Importado', '2026-08-17', NULL, 0, 1, '2026-08-17 21:31:09', '2026-08-17 21:31:09'),
(30, 1, 1, 'pago_dia_ejecutivo', 'Pago_día_Ejecutivo', 625.0000, 'Importado', '2026-08-17', NULL, 0, 1, '2026-08-17 21:31:09', '2026-08-17 21:31:09'),
(31, 1, 1, 'pago_dia_oficina2', 'Pago día oficina2', 3.1250, 'Importado', '2026-08-17', NULL, 0, 1, '2026-08-17 21:31:09', '2026-08-17 21:31:09'),
(32, 1, 1, 'pasaje_de_ida_y_vuelta_zona_1', 'Pasaje_de_ida_y_vuelta_(ZONA_1)', 240.0000, 'Importado', '2026-08-17', NULL, 0, 1, '2026-08-17 21:31:09', '2026-08-17 21:31:09'),
(33, 1, 1, 'pasaje_de_ida_y_vuelta_zona_2', 'Pasaje de ida y vuelta (ZONA 2)', 350.0000, 'Importado', '2026-08-17', NULL, 0, 1, '2026-08-17 21:31:09', '2026-08-17 21:31:09'),
(34, 1, 1, 'pasaje_de_ida_y_vuelta_zona_3', 'Pasaje de ida y vuelta (ZONA 3)', 500.0000, 'Importado', '2026-08-17', NULL, 0, 1, '2026-08-17 21:31:09', '2026-08-17 21:31:09'),
(35, 1, 1, 'pasaje_de_ida_y_vuelta_zona_4', 'Pasaje de ida y vuelta (ZONA 4)', 4.8000, 'Importado', '2026-08-17', NULL, 0, 1, '2026-08-17 21:31:09', '2026-08-17 21:31:09'),
(36, 1, 1, 'hospedaje_zona_1', 'Hospedaje (ZONA 1)', 350.0000, 'Importado', '2026-08-17', NULL, 0, 1, '2026-08-17 21:31:09', '2026-08-17 21:31:09'),
(37, 1, 1, 'hospedaje_zona_2', 'Hospedaje (ZONA 2)', 200.0000, 'Importado', '2026-08-17', NULL, 0, 1, '2026-08-17 21:31:09', '2026-08-17 21:31:09'),
(38, 1, 1, 'hospedaje_zona_3', 'Hospedaje (ZONA 3)', 450.0000, 'Importado', '2026-08-17', NULL, 0, 1, '2026-08-17 21:31:09', '2026-08-17 21:31:09'),
(39, 1, 1, 'hospedaje_zona_4', 'Hospedaje (ZONA 4)', 2.2000, 'Importado', '2026-08-17', NULL, 0, 1, '2026-08-17 21:31:09', '2026-08-17 21:31:09'),
(40, 1, 1, 'alimentacion_diaria_sin_desayuno', 'Alimentación diaria (sin desayuno)', 150.0000, 'Importado', '2026-08-17', NULL, 0, 1, '2026-08-17 21:31:09', '2026-08-17 21:31:09'),
(41, 1, 1, 'transporte_interno_c_principales', 'Transporte_interno_(C.PRINCIPALES)', 25.0000, 'Importado', '2026-08-17', NULL, 0, 1, '2026-08-17 21:31:09', '2026-08-17 21:31:09'),
(42, 1, 1, 'transporte_interno_zonas_1_a_3', 'Transporte_interno_(ZONAS 1 A 3)', 30.0000, 'Importado', '2026-08-17', NULL, 0, 1, '2026-08-17 21:31:09', '2026-08-17 21:31:09'),
(43, 1, 1, 'transporte_interno_zona_4', 'Transporte_interno_(ZONA 4)', 100.0000, 'Importado', '2026-08-17', NULL, 0, 1, '2026-08-17 21:31:09', '2026-08-17 21:31:09'),
(44, 1, 1, 'transporte_a_terminal_y_regreso', 'Transporte_a_terminal_y_regreso', 240.0000, 'Importado', '2026-08-17', NULL, 0, 1, '2026-08-17 21:31:09', '2026-08-17 21:31:09'),
(45, 1, 1, 'combo_big_macdonalds', 'Combo BIG MacDonalds', 75.0000, 'Importado', '2026-08-17', NULL, 0, 1, '2026-08-17 21:31:09', '2026-08-17 21:31:09'),
(46, 1, 1, 'copias_de_papel_blanco_y_negro_1_ud', 'Copias de papel blanco y negro (1 ud.)', 50.0000, 'Importado', '2026-08-17', NULL, 0, 1, '2026-08-17 21:31:09', '2026-08-17 21:31:09'),
(47, 1, 1, 'copias_de_papel_color_1_ud', 'Copias de papel color (1 ud.)', 2.0000, 'Importado', '2026-08-17', NULL, 0, 1, '2026-08-17 21:31:09', '2026-08-17 21:31:09'),
(48, 1, 1, 'impresion_de_recibos_1_ud', 'Impresion_de_recibos_(1_ud)', 1.0000, 'Importado', '2026-08-17', NULL, 0, 1, '2026-08-17 21:31:09', '2026-08-17 21:31:09'),
(49, 1, 1, 'agua_botellon_5_gal', 'Agua (botellón 5 Gal.)', 40.0000, 'Importado', '2026-08-17', NULL, 0, 1, '2026-08-17 21:31:09', '2026-08-17 21:31:09'),
(50, 1, 1, 'bolsas_paquete_50_ud', 'Bolsas (paquete 50 ud.)', 10.0000, 'Importado', '2026-08-17', NULL, 0, 1, '2026-08-17 21:31:09', '2026-08-17 21:31:09'),
(51, 1, 1, 'hielo_bolsa_grande', 'Hielo (bolsa grande)', 25.0000, 'Importado', '2026-08-17', NULL, 0, 1, '2026-08-17 21:31:09', '2026-08-17 21:31:09'),
(52, 1, 1, 'marcadores_1_ud', 'Marcadores (1 ud.)', 18.0000, 'Importado', '2026-08-17', NULL, 0, 1, '2026-08-17 21:31:09', '2026-08-17 21:31:09'),
(53, 1, 1, 'boligrafos_1_ud', 'Bolígrafos (1 ud.)', 5.0000, 'Importado', '2026-08-17', NULL, 0, 1, '2026-08-17 21:31:09', '2026-08-17 21:31:09'),
(54, 1, 1, 'galletas_paquete', 'Galletas (paquete)', 25.0000, 'Importado', '2026-08-17', NULL, 0, 1, '2026-08-17 21:31:09', '2026-08-17 21:31:09'),
(55, 1, 1, 'vasos_pequenos_bolsa_50_ud', 'Vasos pequeños (bolsa 50 ud.)', 30.0000, 'Importado', '2026-08-17', NULL, 0, 1, '2026-08-17 21:31:09', '2026-08-17 21:31:09'),
(56, 1, 1, 'vasos_grandes_bolda_50_ud', 'Vasos grandes (bolda 50 ud.)', 35.0000, 'Importado', '2026-08-17', NULL, 0, 1, '2026-08-17 21:31:09', '2026-08-17 21:31:09'),
(57, 1, 1, 'servilletas_bolsa_50_ud', 'Servilletas (bolsa 50 ud.)', 20.0000, 'Importado', '2026-08-17', NULL, 0, 1, '2026-08-17 21:31:09', '2026-08-17 21:31:09'),
(58, 1, 1, 'encuesta_muy_sencilla_8_10_minutos', 'Encuesta muy sencilla (8-10 minutos)', 35.0000, 'Importado', '2026-08-17', NULL, 0, 1, '2026-08-17 21:31:09', '2026-08-17 21:31:09'),
(59, 1, 1, 'encuesta_sencilla_10_15_minutos', 'Encuesta sencilla (10-15 minutos)', 45.0000, 'Importado', '2026-08-17', NULL, 0, 1, '2026-08-17 21:31:09', '2026-08-17 21:31:09'),
(60, 1, 1, 'encuesta_intermedia_15_25_minutos', 'Encuesta intermedia (15-25 minutos)', 55.0000, 'Importado', '2026-08-17', NULL, 0, 1, '2026-08-17 21:31:09', '2026-08-17 21:31:09'),
(61, 1, 1, 'encuesta_compleja_25_40_minutos', 'Encuesta compleja (25-40 minutos)', 75.0000, 'Importado', '2026-08-17', NULL, 0, 1, '2026-08-17 21:31:09', '2026-08-17 21:31:09'),
(62, 1, 1, 'encuesta_muy_compleja_40_minutos', 'Encuesta muy compleja (>40 minutos)', 100.0000, 'Importado', '2026-08-17', NULL, 0, 1, '2026-08-17 21:31:09', '2026-08-17 21:31:09'),
(63, 1, 1, 'incentivos_perfil_bajo', 'Incentivos Perfil Bajo', 150.0000, 'Importado', '2026-08-17', NULL, 0, 1, '2026-08-17 21:31:09', '2026-08-17 21:31:09'),
(64, 1, 1, 'incentivos_perfil_medio', 'Incentivos Perfil Medio', 300.0000, 'Importado', '2026-08-17', NULL, 0, 1, '2026-08-17 21:31:09', '2026-08-17 21:31:09'),
(65, 1, 1, 'incentivos_perfil_alto', 'Incentivos Perfil Alto', 800.0000, 'Importado', '2026-08-17', NULL, 0, 1, '2026-08-17 21:31:09', '2026-08-17 21:31:09'),
(66, 1, 1, 'incentivos_perfil_muy_alto', 'Incentivos Perfil Muy Alto', 1.5000, 'Importado', '2026-08-17', NULL, 0, 1, '2026-08-17 21:31:09', '2026-08-17 21:31:09'),
(67, 1, 1, 'salon_grande_para_50_personas_1_dia', 'Salón grande (para 50 personas 1 día)', 2.5000, 'Importado', '2026-08-17', NULL, 0, 1, '2026-08-17 21:31:09', '2026-08-17 21:31:09'),
(68, 1, 1, 'salon_pequeno_para_20_personas_1_dia', 'Salón pequeño (para 20 personas 1 día)', 1.2000, 'Importado', '2026-08-17', NULL, 0, 1, '2026-08-17 21:31:09', '2026-08-17 21:31:09'),
(69, 2, 2, 'precio_computadora', 'Precio_computadora', 300.0000, 'Importado', '2026-08-17', '2026-08-18', 0, 1, '2026-08-17 21:31:09', '2026-08-18 14:24:33'),
(70, 2, 5, 'precio_de_canasta_basica', 'Precio_de_Canasta básica', 3500.0000, 'Importado', '2026-08-17', NULL, 1, 1, '2026-08-17 21:31:09', '2026-08-18 14:24:33'),
(71, 2, 5, 'salario_minimo_mensual_servicios', 'Salario_mínimo_mensual_servicios', 300.0000, 'Importado', '2026-08-17', '2026-08-18', 0, 1, '2026-08-17 21:31:09', '2026-08-18 14:24:33'),
(72, 2, 5, 'ratio_incremento_salario_minimo', 'Ratio_incremento_salario_minimo', 300.0000, 'Importado', '2026-08-17', '2026-08-18', 0, 1, '2026-08-17 21:31:09', '2026-08-18 14:24:33'),
(73, 2, 5, 'salario_mensual_encuestador_campo', 'Salario_mensual_Encuestador_Campo', 300.0000, 'Importado', '2026-08-17', '2026-08-18', 0, 1, '2026-08-17 21:31:09', '2026-08-18 14:24:33'),
(74, 2, 5, 'salario_mensual_supervisor_campo', 'Salario_mensual_Supervisor_Campo', 300.0000, 'Importado', '2026-08-17', '2026-08-18', 0, 1, '2026-08-17 21:31:09', '2026-08-18 14:24:33'),
(75, 2, 5, 'salario_mensual_coordinador_procesado', 'Salario_mensual_Coordinador_Procesado', 300.0000, 'Importado', '2026-08-17', '2026-08-18', 0, 1, '2026-08-17 21:31:09', '2026-08-18 14:24:33'),
(76, 2, 5, 'salario_mensual_responsable_procesado', 'Salario_mensual_Responsable_Procesado', 300.0000, 'Importado', '2026-08-17', '2026-08-18', 0, 1, '2026-08-17 21:31:09', '2026-08-18 14:24:33'),
(77, 2, 5, 'salario_mensual_coordinador_operaciones', 'Salario_mensual_Coordinador_Operaciones', 300.0000, 'Importado', '2026-08-17', '2026-08-18', 0, 1, '2026-08-17 21:31:09', '2026-08-18 14:24:33'),
(78, 2, 5, 'salario_mensual_responsable_operaciones', 'Salario mensual Responsable Operaciones', 300.0000, 'Importado', '2026-08-17', '2026-08-18', 0, 1, '2026-08-17 21:31:09', '2026-08-18 14:24:33'),
(79, 2, 5, 'salario_mensual_coordinador_auditoria', 'Salario_mensual_Coordinador_Auditoria', 300.0000, 'Importado', '2026-08-17', '2026-08-18', 0, 1, '2026-08-17 21:31:09', '2026-08-18 14:24:33'),
(80, 2, 5, 'salario_mensual_responsable_auditoria', 'Salario mensual Responsable Auditoría', 300.0000, 'Importado', '2026-08-17', '2026-08-18', 0, 1, '2026-08-17 21:31:09', '2026-08-18 14:24:33'),
(81, 2, 5, 'salario_mensual_analistas_y_soporte', 'Salario mensual Analistas y Soporte', 300.0000, 'Importado', '2026-08-17', '2026-08-18', 0, 1, '2026-08-17 21:31:09', '2026-08-18 14:24:33'),
(82, 2, 5, 'salario_mensual_ejecutivo', 'Salario mensual Ejecutivo', 300.0000, 'Importado', '2026-08-17', '2026-08-18', 0, 1, '2026-08-17 21:31:09', '2026-08-18 14:24:33'),
(83, 2, 5, 'pago_dia_oficina', 'Pago día oficina', 300.0000, 'Importado', '2026-08-17', '2026-08-18', 0, 1, '2026-08-17 21:31:09', '2026-08-18 14:24:33'),
(84, 2, 5, 'dias_minimos_laborales_mes', 'Díás mínimos laborales mes', 300.0000, 'Importado', '2026-08-17', '2026-08-18', 0, 1, '2026-08-17 21:31:09', '2026-08-18 14:24:33'),
(85, 2, 5, 'pago_dia_encuestadores_campo', 'Pago día Encuestadores Campo', 300.0000, 'Importado', '2026-08-17', '2026-08-18', 0, 1, '2026-08-17 21:31:09', '2026-08-18 14:24:33'),
(86, 2, 5, 'pago_dia_supervisores_campo', 'Pago día Supervisores Campo', 300.0000, 'Importado', '2026-08-17', '2026-08-18', 0, 1, '2026-08-17 21:31:09', '2026-08-18 14:24:33'),
(87, 2, 5, 'pago_dia_coordinador_procesado', 'Pago_dia_Coordinador_Procesado', 300.0000, 'Importado', '2026-08-17', '2026-08-18', 0, 1, '2026-08-17 21:31:09', '2026-08-18 14:24:33'),
(88, 2, 5, 'pago_dia_responsable_procesado', 'Pago_dia_Responsable_Procesado', 300.0000, 'Importado', '2026-08-17', '2026-08-18', 0, 1, '2026-08-17 21:31:09', '2026-08-18 14:24:33'),
(89, 2, 5, 'pago_dia_coordinador_operaciones', 'Pago_día_Coordinador_Operaciones', 300.0000, 'Importado', '2026-08-17', '2026-08-18', 0, 1, '2026-08-17 21:31:09', '2026-08-18 14:24:33'),
(90, 2, 5, 'pago_dia_responsable_operaciones', 'Pago_dia_Responsable _Operaciones', 300.0000, 'Importado', '2026-08-17', '2026-08-18', 0, 1, '2026-08-17 21:31:09', '2026-08-18 14:24:33'),
(91, 2, 5, 'pago_dia_coordinador_auditoria', 'Pago_dia_Coordinador_Auditoria', 300.0000, 'Importado', '2026-08-17', '2026-08-18', 0, 1, '2026-08-17 21:31:09', '2026-08-18 14:24:33'),
(92, 2, 5, 'pago_dia_responsable_auditoria', 'Pago_dia_Responsable_Auditoria', 300.0000, 'Importado', '2026-08-17', '2026-08-18', 0, 1, '2026-08-17 21:31:09', '2026-08-18 14:24:33'),
(93, 2, 5, 'pago_dia_analistas_y_soporte', 'Pago_dia_Analistas_y_Soporte', 300.0000, 'Importado', '2026-08-17', '2026-08-18', 0, 1, '2026-08-17 21:31:09', '2026-08-18 14:24:33'),
(94, 2, 5, 'pago_dia_ejecutivo', 'Pago_día_Ejecutivo', 300.0000, 'Importado', '2026-08-17', '2026-08-18', 0, 1, '2026-08-17 21:31:09', '2026-08-18 14:24:33'),
(95, 2, 5, 'pago_dia_oficina2', 'Pago día oficina2', 300.0000, 'Importado', '2026-08-17', '2026-08-18', 0, 1, '2026-08-17 21:31:09', '2026-08-18 14:24:33'),
(96, 2, 5, 'pasaje_de_ida_y_vuelta_zona_1', 'Pasaje_de_ida_y_vuelta_(ZONA_1)', 300.0000, 'Importado', '2026-08-17', '2026-08-18', 0, 1, '2026-08-17 21:31:09', '2026-08-18 14:24:33'),
(97, 2, 5, 'pasaje_de_ida_y_vuelta_zona_2', 'Pasaje de ida y vuelta (ZONA 2)', 300.0000, 'Importado', '2026-08-17', '2026-08-18', 0, 1, '2026-08-17 21:31:09', '2026-08-18 14:24:33'),
(98, 2, 5, 'pasaje_de_ida_y_vuelta_zona_3', 'Pasaje de ida y vuelta (ZONA 3)', 300.0000, 'Importado', '2026-08-17', '2026-08-18', 0, 1, '2026-08-17 21:31:09', '2026-08-18 14:24:33'),
(99, 2, 5, 'pasaje_de_ida_y_vuelta_zona_4', 'Pasaje de ida y vuelta (ZONA 4)', 300.0000, 'Importado', '2026-08-17', '2026-08-18', 0, 1, '2026-08-17 21:31:09', '2026-08-18 14:24:33'),
(100, 2, 5, 'hospedaje_zona_1', 'Hospedaje (ZONA 1)', 300.0000, 'Importado', '2026-08-17', '2026-08-18', 0, 1, '2026-08-17 21:31:09', '2026-08-18 14:24:33'),
(101, 2, 5, 'hospedaje_zona_2', 'Hospedaje (ZONA 2)', 300.0000, 'Importado', '2026-08-17', '2026-08-18', 0, 1, '2026-08-17 21:31:09', '2026-08-18 14:24:33'),
(102, 2, 5, 'hospedaje_zona_3', 'Hospedaje (ZONA 3)', 300.0000, 'Importado', '2026-08-17', '2026-08-18', 0, 1, '2026-08-17 21:31:09', '2026-08-18 14:24:33'),
(103, 2, 5, 'hospedaje_zona_4', 'Hospedaje (ZONA 4)', 300.0000, 'Importado', '2026-08-17', '2026-08-18', 0, 1, '2026-08-17 21:31:09', '2026-08-18 14:24:33'),
(104, 2, 5, 'alimentacion_diaria_sin_desayuno', 'Alimentación diaria (sin desayuno)', 300.0000, 'Importado', '2026-08-17', '2026-08-18', 0, 1, '2026-08-17 21:31:09', '2026-08-18 14:24:33'),
(105, 2, 5, 'transporte_interno_c_principales', 'Transporte_interno_(C.PRINCIPALES)', 300.0000, 'Importado', '2026-08-17', '2026-08-18', 0, 1, '2026-08-17 21:31:09', '2026-08-18 14:24:33'),
(106, 2, 5, 'transporte_interno_zonas_1_a_3', 'Transporte_interno_(ZONAS 1 A 3)', 300.0000, 'Importado', '2026-08-17', '2026-08-18', 0, 1, '2026-08-17 21:31:09', '2026-08-18 14:24:33'),
(107, 2, 5, 'transporte_interno_zona_4', 'Transporte_interno_(ZONA 4)', 300.0000, 'Importado', '2026-08-17', '2026-08-18', 0, 1, '2026-08-17 21:31:09', '2026-08-18 14:24:33'),
(108, 2, 5, 'transporte_a_terminal_y_regreso', 'Transporte_a_terminal_y_regreso', 300.0000, 'Importado', '2026-08-17', '2026-08-18', 0, 1, '2026-08-17 21:31:09', '2026-08-18 14:24:33'),
(109, 2, 5, 'combo_big_macdonalds', 'Combo BIG MacDonalds', 300.0000, 'Importado', '2026-08-17', '2026-08-18', 0, 1, '2026-08-17 21:31:09', '2026-08-18 14:24:33'),
(110, 2, 5, 'copias_de_papel_blanco_y_negro_1_ud', 'Copias de papel blanco y negro (1 ud.)', 300.0000, 'Importado', '2026-08-17', '2026-08-18', 0, 1, '2026-08-17 21:31:09', '2026-08-18 14:24:33'),
(111, 2, 5, 'copias_de_papel_color_1_ud', 'Copias de papel color (1 ud.)', 300.0000, 'Importado', '2026-08-17', '2026-08-18', 0, 1, '2026-08-17 21:31:09', '2026-08-18 14:24:33'),
(112, 2, 5, 'impresion_de_recibos_1_ud', 'Impresion_de_recibos_(1_ud)', 300.0000, 'Importado', '2026-08-17', '2026-08-18', 0, 1, '2026-08-17 21:31:09', '2026-08-18 14:24:33'),
(113, 2, 5, 'agua_botellon_5_gal', 'Agua (botellón 5 Gal.)', 300.0000, 'Importado', '2026-08-17', '2026-08-18', 0, 1, '2026-08-17 21:31:09', '2026-08-18 14:24:33'),
(114, 2, 5, 'bolsas_paquete_50_ud', 'Bolsas (paquete 50 ud.)', 300.0000, 'Importado', '2026-08-17', '2026-08-18', 0, 1, '2026-08-17 21:31:09', '2026-08-18 14:24:33'),
(115, 2, 5, 'hielo_bolsa_grande', 'Hielo (bolsa grande)', 300.0000, 'Importado', '2026-08-17', '2026-08-18', 0, 1, '2026-08-17 21:31:09', '2026-08-18 14:24:33'),
(116, 2, 5, 'marcadores_1_ud', 'Marcadores (1 ud.)', 300.0000, 'Importado', '2026-08-17', '2026-08-18', 0, 1, '2026-08-17 21:31:09', '2026-08-18 14:24:33'),
(117, 2, 5, 'boligrafos_1_ud', 'Bolígrafos (1 ud.)', 300.0000, 'Importado', '2026-08-17', '2026-08-18', 0, 1, '2026-08-17 21:31:09', '2026-08-18 14:24:33'),
(118, 2, 5, 'galletas_paquete', 'Galletas (paquete)', 300.0000, 'Importado', '2026-08-17', '2026-08-18', 0, 1, '2026-08-17 21:31:09', '2026-08-18 14:24:33'),
(119, 2, 5, 'vasos_pequenos_bolsa_50_ud', 'Vasos pequeños (bolsa 50 ud.)', 300.0000, 'Importado', '2026-08-17', '2026-08-18', 0, 1, '2026-08-17 21:31:09', '2026-08-18 14:24:33'),
(120, 2, 5, 'vasos_grandes_bolda_50_ud', 'Vasos grandes (bolda 50 ud.)', 300.0000, 'Importado', '2026-08-17', '2026-08-18', 0, 1, '2026-08-17 21:31:09', '2026-08-18 14:24:33'),
(121, 2, 5, 'servilletas_bolsa_50_ud', 'Servilletas (bolsa 50 ud.)', 300.0000, 'Importado', '2026-08-17', '2026-08-18', 0, 1, '2026-08-17 21:31:09', '2026-08-18 14:24:33'),
(122, 2, 5, 'encuesta_muy_sencilla_8_10_minutos', 'Encuesta muy sencilla (8-10 minutos)', 300.0000, 'Importado', '2026-08-17', '2026-08-18', 0, 1, '2026-08-17 21:31:09', '2026-08-18 14:24:33'),
(123, 2, 5, 'encuesta_sencilla_10_15_minutos', 'Encuesta sencilla (10-15 minutos)', 300.0000, 'Importado', '2026-08-17', '2026-08-18', 0, 1, '2026-08-17 21:31:09', '2026-08-18 14:24:33'),
(124, 2, 5, 'encuesta_intermedia_15_25_minutos', 'Encuesta intermedia (15-25 minutos)', 300.0000, 'Importado', '2026-08-17', '2026-08-18', 0, 1, '2026-08-17 21:31:09', '2026-08-18 14:24:33'),
(125, 2, 5, 'encuesta_compleja_25_40_minutos', 'Encuesta compleja (25-40 minutos)', 300.0000, 'Importado', '2026-08-17', '2026-08-18', 0, 1, '2026-08-17 21:31:09', '2026-08-18 14:24:33'),
(126, 2, 5, 'encuesta_muy_compleja_40_minutos', 'Encuesta muy compleja (>40 minutos)', 300.0000, 'Importado', '2026-08-17', '2026-08-18', 0, 1, '2026-08-17 21:31:09', '2026-08-18 14:24:33'),
(127, 2, 5, 'incentivos_perfil_bajo', 'Incentivos Perfil Bajo', 300.0000, 'Importado', '2026-08-17', '2026-08-18', 0, 1, '2026-08-17 21:31:09', '2026-08-18 14:24:33'),
(128, 2, 5, 'incentivos_perfil_medio', 'Incentivos Perfil Medio', 300.0000, 'Importado', '2026-08-17', '2026-08-18', 0, 1, '2026-08-17 21:31:09', '2026-08-18 14:24:33'),
(129, 2, 5, 'incentivos_perfil_alto', 'Incentivos Perfil Alto', 300.0000, 'Importado', '2026-08-17', '2026-08-18', 0, 1, '2026-08-17 21:31:09', '2026-08-18 14:24:33'),
(130, 2, 5, 'incentivos_perfil_muy_alto', 'Incentivos Perfil Muy Alto', 300.0000, 'Importado', '2026-08-17', '2026-08-18', 0, 1, '2026-08-17 21:31:09', '2026-08-18 14:24:33'),
(131, 2, 5, 'salon_grande_para_50_personas_1_dia', 'Salón grande (para 50 personas 1 día)', 300.0000, 'Importado', '2026-08-17', '2026-08-18', 0, 1, '2026-08-17 21:31:09', '2026-08-18 14:24:33'),
(132, 2, 5, 'salon_pequeno_para_20_personas_1_dia', 'Salón pequeño (para 20 personas 1 día)', 300.0000, 'Importado', '2026-08-17', '2026-08-18', 0, 1, '2026-08-17 21:31:09', '2026-08-18 14:24:33'),
(133, 1, 1, 'precio_computadora', 'Precio_computadora', 20000.0000, 'Importado', '2026-08-17', NULL, 1, 1, '2026-08-17 21:31:09', '2026-08-17 21:31:09'),
(134, 1, 1, 'precio_de_canasta_basica', 'Precio_de_Canasta básica', 12000.0000, 'Importado', '2026-08-17', NULL, 1, 1, '2026-08-17 21:31:09', '2026-08-17 21:31:09'),
(135, 1, 1, 'salario_minimo_mensual_servicios', 'Salario_mínimo_mensual_servicios', 8500.0000, 'Importado', '2026-08-17', NULL, 1, 1, '2026-08-17 21:31:09', '2026-08-17 21:31:09'),
(136, 1, 1, 'ratio_incremento_salario_minimo', 'Ratio_incremento_salario_minimo', 1.2000, 'Importado', '2026-08-17', NULL, 1, 1, '2026-08-17 21:31:09', '2026-08-17 21:31:09'),
(137, 1, 1, 'salario_mensual_encuestador_campo', 'Salario_mensual_Encuestador_Campo', 10.2000, 'Importado', '2026-08-17', NULL, 1, 1, '2026-08-17 21:31:09', '2026-08-17 21:31:09'),
(138, 1, 1, 'salario_mensual_supervisor_campo', 'Salario_mensual_Supervisor_Campo', 12.2400, 'Importado', '2026-08-17', NULL, 1, 1, '2026-08-17 21:31:09', '2026-08-17 21:31:09'),
(139, 1, 1, 'salario_mensual_coordinador_procesado', 'Salario_mensual_Coordinador_Procesado', 12.0000, 'Importado', '2026-08-17', NULL, 1, 1, '2026-08-17 21:31:09', '2026-08-17 21:31:09'),
(140, 1, 1, 'salario_mensual_responsable_procesado', 'Salario_mensual_Responsable_Procesado', 10.5000, 'Importado', '2026-08-17', NULL, 1, 1, '2026-08-17 21:31:09', '2026-08-17 21:31:09'),
(141, 1, 1, 'salario_mensual_coordinador_operaciones', 'Salario_mensual_Coordinador_Operaciones', 12.0000, 'Importado', '2026-08-17', NULL, 1, 1, '2026-08-17 21:31:09', '2026-08-17 21:31:09'),
(142, 1, 1, 'salario_mensual_responsable_operaciones', 'Salario mensual Responsable Operaciones', 10.5000, 'Importado', '2026-08-17', NULL, 1, 1, '2026-08-17 21:31:09', '2026-08-17 21:31:09'),
(143, 1, 1, 'salario_mensual_coordinador_auditoria', 'Salario_mensual_Coordinador_Auditoria', 11.5000, 'Importado', '2026-08-17', NULL, 1, 1, '2026-08-17 21:31:09', '2026-08-17 21:31:09'),
(144, 1, 1, 'salario_mensual_responsable_auditoria', 'Salario mensual Responsable Auditoría', 10.5000, 'Importado', '2026-08-17', NULL, 1, 1, '2026-08-17 21:31:09', '2026-08-17 21:31:09'),
(145, 1, 1, 'salario_mensual_analistas_y_soporte', 'Salario mensual Analistas y Soporte', 11.0000, 'Importado', '2026-08-17', NULL, 1, 1, '2026-08-17 21:31:09', '2026-08-17 21:31:09'),
(146, 1, 1, 'salario_mensual_ejecutivo', 'Salario mensual Ejecutivo', 15.0000, 'Importado', '2026-08-17', NULL, 1, 1, '2026-08-17 21:31:09', '2026-08-17 21:31:09'),
(147, 1, 1, 'pago_dia_oficina', 'Pago día oficina', 75.0000, 'Importado', '2026-08-17', NULL, 1, 1, '2026-08-17 21:31:09', '2026-08-17 21:31:09'),
(148, 1, 1, 'dias_minimos_laborales_mes', 'Díás mínimos laborales mes', 24.0000, 'Importado', '2026-08-17', NULL, 1, 1, '2026-08-17 21:31:09', '2026-08-17 21:31:09'),
(149, 1, 1, 'pago_dia_encuestadores_campo', 'Pago día Encuestadores Campo', 425.0000, 'Importado', '2026-08-17', NULL, 1, 1, '2026-08-17 21:31:09', '2026-08-17 21:31:09'),
(150, 1, 1, 'pago_dia_supervisores_campo', 'Pago día Supervisores Campo', 510.0000, 'Importado', '2026-08-17', NULL, 1, 1, '2026-08-17 21:31:09', '2026-08-17 21:31:09'),
(151, 1, 1, 'pago_dia_coordinador_procesado', 'Pago_dia_Coordinador_Procesado', 500.0000, 'Importado', '2026-08-17', NULL, 1, 1, '2026-08-17 21:31:09', '2026-08-17 21:31:09'),
(152, 1, 1, 'pago_dia_responsable_procesado', 'Pago_dia_Responsable_Procesado', 437.5000, 'Importado', '2026-08-17', NULL, 1, 1, '2026-08-17 21:31:09', '2026-08-17 21:31:09'),
(153, 1, 1, 'pago_dia_coordinador_operaciones', 'Pago_día_Coordinador_Operaciones', 500.0000, 'Importado', '2026-08-17', NULL, 1, 1, '2026-08-17 21:31:09', '2026-08-17 21:31:09'),
(154, 1, 1, 'pago_dia_responsable_operaciones', 'Pago_dia_Responsable _Operaciones', 437.5000, 'Importado', '2026-08-17', NULL, 1, 1, '2026-08-17 21:31:09', '2026-08-17 21:31:09'),
(155, 1, 1, 'pago_dia_coordinador_auditoria', 'Pago_dia_Coordinador_Auditoria', 479.1667, 'Importado', '2026-08-17', NULL, 1, 1, '2026-08-17 21:31:09', '2026-08-17 21:31:09'),
(156, 1, 1, 'pago_dia_responsable_auditoria', 'Pago_dia_Responsable_Auditoria', 437.5000, 'Importado', '2026-08-17', NULL, 1, 1, '2026-08-17 21:31:09', '2026-08-17 21:31:09'),
(157, 1, 1, 'pago_dia_analistas_y_soporte', 'Pago_dia_Analistas_y_Soporte', 458.3333, 'Importado', '2026-08-17', NULL, 1, 1, '2026-08-17 21:31:09', '2026-08-17 21:31:09'),
(158, 1, 1, 'pago_dia_ejecutivo', 'Pago_día_Ejecutivo', 625.0000, 'Importado', '2026-08-17', NULL, 1, 1, '2026-08-17 21:31:09', '2026-08-17 21:31:09'),
(159, 1, 1, 'pago_dia_oficina2', 'Pago día oficina2', 3.1250, 'Importado', '2026-08-17', NULL, 1, 1, '2026-08-17 21:31:09', '2026-08-17 21:31:09'),
(160, 1, 1, 'pasaje_de_ida_y_vuelta_zona_1', 'Pasaje_de_ida_y_vuelta_(ZONA_1)', 20.0000, 'Importado', '2026-08-17', NULL, 1, 1, '2026-08-17 21:31:09', '2026-08-17 21:31:09'),
(161, 1, 1, 'pasaje_de_ida_y_vuelta_zona_2', 'Pasaje de ida y vuelta (ZONA 2)', 20.0000, 'Importado', '2026-08-17', NULL, 1, 1, '2026-08-17 21:31:09', '2026-08-17 21:31:09'),
(162, 1, 1, 'pasaje_de_ida_y_vuelta_zona_3', 'Pasaje de ida y vuelta (ZONA 3)', 20.0000, 'Importado', '2026-08-17', NULL, 1, 1, '2026-08-17 21:31:09', '2026-08-17 21:31:09'),
(163, 1, 1, 'pasaje_de_ida_y_vuelta_zona_4', 'Pasaje de ida y vuelta (ZONA 4)', 20.0000, 'Importado', '2026-08-17', NULL, 1, 1, '2026-08-17 21:31:09', '2026-08-17 21:31:09'),
(164, 1, 1, 'hospedaje_zona_1', 'Hospedaje (ZONA 1)', 20.0000, 'Importado', '2026-08-17', NULL, 1, 1, '2026-08-17 21:31:09', '2026-08-17 21:31:09'),
(165, 1, 1, 'hospedaje_zona_2', 'Hospedaje (ZONA 2)', 20.0000, 'Importado', '2026-08-17', NULL, 1, 1, '2026-08-17 21:31:09', '2026-08-17 21:31:09'),
(166, 1, 1, 'hospedaje_zona_3', 'Hospedaje (ZONA 3)', 20.0000, 'Importado', '2026-08-17', NULL, 1, 1, '2026-08-17 21:31:09', '2026-08-17 21:31:09'),
(167, 1, 1, 'hospedaje_zona_4', 'Hospedaje (ZONA 4)', 20.0000, 'Importado', '2026-08-17', NULL, 1, 1, '2026-08-17 21:31:09', '2026-08-17 21:31:09'),
(168, 1, 1, 'alimentacion_diaria_sin_desayuno', 'Alimentación diaria (sin desayuno)', 20.0000, 'Importado', '2026-08-17', NULL, 1, 1, '2026-08-17 21:31:09', '2026-08-17 21:31:09'),
(169, 1, 1, 'transporte_interno_c_principales', 'Transporte_interno_(C.PRINCIPALES)', 20.0000, 'Importado', '2026-08-17', NULL, 1, 1, '2026-08-17 21:31:09', '2026-08-17 21:31:09'),
(170, 1, 1, 'transporte_interno_zonas_1_a_3', 'Transporte_interno_(ZONAS 1 A 3)', 20.0000, 'Importado', '2026-08-17', NULL, 1, 1, '2026-08-17 21:31:09', '2026-08-17 21:31:09'),
(171, 1, 1, 'transporte_interno_zona_4', 'Transporte_interno_(ZONA 4)', 20.0000, 'Importado', '2026-08-17', NULL, 1, 1, '2026-08-17 21:31:09', '2026-08-17 21:31:09'),
(172, 1, 1, 'transporte_a_terminal_y_regreso', 'Transporte_a_terminal_y_regreso', 20.0000, 'Importado', '2026-08-17', NULL, 1, 1, '2026-08-17 21:31:09', '2026-08-17 21:31:09'),
(173, 1, 1, 'combo_big_macdonalds', 'Combo BIG MacDonalds', 20.0000, 'Importado', '2026-08-17', NULL, 1, 1, '2026-08-17 21:31:09', '2026-08-17 21:31:09'),
(174, 1, 1, 'copias_de_papel_blanco_y_negro_1_ud', 'Copias de papel blanco y negro (1 ud.)', 20.0000, 'Importado', '2026-08-17', NULL, 1, 1, '2026-08-17 21:31:09', '2026-08-17 21:31:09'),
(175, 1, 1, 'copias_de_papel_color_1_ud', 'Copias de papel color (1 ud.)', 20.0000, 'Importado', '2026-08-17', NULL, 1, 1, '2026-08-17 21:31:09', '2026-08-17 21:31:09'),
(176, 1, 1, 'impresion_de_recibos_1_ud', 'Impresion_de_recibos_(1_ud)', 20.0000, 'Importado', '2026-08-17', NULL, 1, 1, '2026-08-17 21:31:09', '2026-08-17 21:31:09'),
(177, 1, 1, 'agua_botellon_5_gal', 'Agua (botellón 5 Gal.)', 20.0000, 'Importado', '2026-08-17', NULL, 1, 1, '2026-08-17 21:31:09', '2026-08-17 21:31:09'),
(178, 1, 1, 'bolsas_paquete_50_ud', 'Bolsas (paquete 50 ud.)', 20.0000, 'Importado', '2026-08-17', NULL, 1, 1, '2026-08-17 21:31:09', '2026-08-17 21:31:09'),
(179, 1, 1, 'hielo_bolsa_grande', 'Hielo (bolsa grande)', 20.0000, 'Importado', '2026-08-17', NULL, 1, 1, '2026-08-17 21:31:09', '2026-08-17 21:31:09'),
(180, 1, 1, 'marcadores_1_ud', 'Marcadores (1 ud.)', 20.0000, 'Importado', '2026-08-17', NULL, 1, 1, '2026-08-17 21:31:09', '2026-08-17 21:31:09'),
(181, 1, 1, 'boligrafos_1_ud', 'Bolígrafos (1 ud.)', 20.0000, 'Importado', '2026-08-17', NULL, 1, 1, '2026-08-17 21:31:09', '2026-08-17 21:31:09'),
(182, 1, 1, 'galletas_paquete', 'Galletas (paquete)', 20.0000, 'Importado', '2026-08-17', NULL, 1, 1, '2026-08-17 21:31:09', '2026-08-17 21:31:09'),
(183, 1, 1, 'vasos_pequenos_bolsa_50_ud', 'Vasos pequeños (bolsa 50 ud.)', 20.0000, 'Importado', '2026-08-17', NULL, 1, 1, '2026-08-17 21:31:09', '2026-08-17 21:31:09'),
(184, 1, 1, 'vasos_grandes_bolda_50_ud', 'Vasos grandes (bolda 50 ud.)', 20.0000, 'Importado', '2026-08-17', NULL, 1, 1, '2026-08-17 21:31:09', '2026-08-17 21:31:09'),
(185, 1, 1, 'servilletas_bolsa_50_ud', 'Servilletas (bolsa 50 ud.)', 20.0000, 'Importado', '2026-08-17', NULL, 1, 1, '2026-08-17 21:31:09', '2026-08-17 21:31:09'),
(186, 1, 1, 'encuesta_muy_sencilla_8_10_minutos', 'Encuesta muy sencilla (8-10 minutos)', 20.0000, 'Importado', '2026-08-17', NULL, 1, 1, '2026-08-17 21:31:09', '2026-08-17 21:31:09'),
(187, 1, 1, 'encuesta_sencilla_10_15_minutos', 'Encuesta sencilla (10-15 minutos)', 20.0000, 'Importado', '2026-08-17', NULL, 1, 1, '2026-08-17 21:31:09', '2026-08-17 21:31:09'),
(188, 1, 1, 'encuesta_intermedia_15_25_minutos', 'Encuesta intermedia (15-25 minutos)', 20.0000, 'Importado', '2026-08-17', NULL, 1, 1, '2026-08-17 21:31:09', '2026-08-17 21:31:09'),
(189, 1, 1, 'encuesta_compleja_25_40_minutos', 'Encuesta compleja (25-40 minutos)', 20.0000, 'Importado', '2026-08-17', NULL, 1, 1, '2026-08-17 21:31:09', '2026-08-17 21:31:09'),
(190, 1, 1, 'encuesta_muy_compleja_40_minutos', 'Encuesta muy compleja (>40 minutos)', 20.0000, 'Importado', '2026-08-17', NULL, 1, 1, '2026-08-17 21:31:09', '2026-08-17 21:31:09'),
(191, 1, 1, 'incentivos_perfil_bajo', 'Incentivos Perfil Bajo', 20.0000, 'Importado', '2026-08-17', NULL, 1, 1, '2026-08-17 21:31:09', '2026-08-17 21:31:09'),
(192, 1, 1, 'incentivos_perfil_medio', 'Incentivos Perfil Medio', 20.0000, 'Importado', '2026-08-17', NULL, 1, 1, '2026-08-17 21:31:09', '2026-08-17 21:31:09'),
(193, 1, 1, 'incentivos_perfil_alto', 'Incentivos Perfil Alto', 20.0000, 'Importado', '2026-08-17', NULL, 1, 1, '2026-08-17 21:31:09', '2026-08-17 21:31:09'),
(194, 1, 1, 'incentivos_perfil_muy_alto', 'Incentivos Perfil Muy Alto', 20.0000, 'Importado', '2026-08-17', NULL, 1, 1, '2026-08-17 21:31:09', '2026-08-17 21:31:09'),
(195, 1, 1, 'salon_grande_para_50_personas_1_dia', 'Salón grande (para 50 personas 1 día)', 20.0000, 'Importado', '2026-08-17', NULL, 1, 1, '2026-08-17 21:31:09', '2026-08-17 21:31:09'),
(196, 1, 1, 'salon_pequeno_para_20_personas_1_dia', 'Salón pequeño (para 20 personas 1 día)', 20.0000, 'Importado', '2026-08-17', NULL, 1, 1, '2026-08-17 21:31:09', '2026-08-17 21:31:09'),
(197, 3, 2, 'Pago_celular', 'Tarifa de cada celular', 100.0000, 'Telecom', '2026-08-18', NULL, 1, 1, '2026-08-18 05:43:59', '2026-08-18 14:24:33');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `country_cost_history`
--

CREATE TABLE `country_cost_history` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `country_cost_id` bigint(20) UNSIGNED NOT NULL,
  `old_amount` decimal(18,4) NOT NULL,
  `new_amount` decimal(18,4) NOT NULL,
  `changed_by` bigint(20) UNSIGNED DEFAULT NULL,
  `changed_at` datetime NOT NULL DEFAULT current_timestamp(),
  `reason` varchar(500) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `currencies`
--

CREATE TABLE `currencies` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `country_id` bigint(20) UNSIGNED DEFAULT NULL,
  `code` char(3) NOT NULL,
  `symbol` varchar(10) NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

--
-- Volcado de datos para la tabla `currencies`
--

INSERT INTO `currencies` (`id`, `country_id`, `code`, `symbol`, `name`, `is_active`, `created_at`, `updated_at`) VALUES
(1, 1, 'HNL', 'L.', 'Lempira hondureno', 1, '2026-08-17 21:04:52', '2026-08-17 21:04:52'),
(2, 3, 'CLP', '', NULL, 1, '2026-08-17 21:30:40', '2026-08-18 15:11:12'),
(3, 7, 'COP', '', NULL, 1, '2026-08-17 21:30:40', '2026-08-18 15:11:16'),
(4, 8, 'CRC', '', NULL, 1, '2026-08-17 21:30:40', '2026-08-18 15:11:19'),
(5, 2, 'USD', '', NULL, 1, '2026-08-17 21:30:40', '2026-08-18 15:11:22'),
(6, 5, 'GTQ', 'Q.', NULL, 1, '2026-08-17 21:30:40', '2026-08-18 06:13:23'),
(7, 4, 'MXN', '', NULL, 1, '2026-08-17 21:30:40', '2026-08-18 15:11:28'),
(8, 9, 'USD', '', NULL, 1, '2026-08-17 21:30:40', '2026-08-18 15:11:39'),
(9, 10, 'PEN', '', NULL, 1, '2026-08-17 21:30:40', '2026-08-18 15:11:43'),
(10, 11, 'DOP', '', NULL, 1, '2026-08-17 21:30:40', '2026-08-18 15:11:45'),
(11, 12, 'USD', '', NULL, 1, '2026-08-17 21:30:40', '2026-08-18 15:11:48');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `difficulty_options`
--

CREATE TABLE `difficulty_options` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `question_id` bigint(20) UNSIGNED NOT NULL,
  `external_code` varchar(60) DEFAULT NULL,
  `option_text` text NOT NULL,
  `difficulty_value` decimal(10,3) NOT NULL DEFAULT 0.000,
  `weight` decimal(10,3) NOT NULL DEFAULT 1.000,
  `sort_order` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `difficulty_questions`
--

CREATE TABLE `difficulty_questions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `methodology` varchar(30) NOT NULL COMMENT 'cuantitativo o cualitativo',
  `external_code` varchar(50) DEFAULT NULL,
  `question_text` text NOT NULL,
  `input_type` enum('single','multiple','slider','number','text') NOT NULL DEFAULT 'single',
  `max_weight` decimal(10,3) DEFAULT NULL,
  `sort_order` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `exchange_rates`
--

CREATE TABLE `exchange_rates` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `currency_id` bigint(20) UNSIGNED NOT NULL,
  `rate_to_usd` decimal(18,6) NOT NULL,
  `effective_date` date NOT NULL,
  `is_current` tinyint(1) NOT NULL DEFAULT 1,
  `created_by` bigint(20) UNSIGNED DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

--
-- Volcado de datos para la tabla `exchange_rates`
--

INSERT INTO `exchange_rates` (`id`, `currency_id`, `rate_to_usd`, `effective_date`, `is_current`, `created_by`, `created_at`) VALUES
(1, 1, 24.579100, '2026-08-17', 0, NULL, '2026-08-17 21:04:52'),
(2, 1, 24.579100, '2026-08-17', 1, 1, '2026-08-17 21:30:40');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `locations`
--

CREATE TABLE `locations` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `country_id` bigint(20) UNSIGNED NOT NULL,
  `zone_code` varchar(50) DEFAULT NULL,
  `location_code` varchar(50) DEFAULT NULL,
  `zone_name` varchar(150) DEFAULT NULL,
  `city` varchar(150) NOT NULL,
  `hotel_cost` decimal(18,2) NOT NULL DEFAULT 0.00,
  `food_cost` decimal(18,2) NOT NULL DEFAULT 0.00,
  `intercity_transport_cost` decimal(18,2) NOT NULL DEFAULT 0.00,
  `local_transport_cost` decimal(18,2) NOT NULL DEFAULT 0.00,
  `bw_copy_cost` decimal(18,2) NOT NULL DEFAULT 0.00,
  `color_copy_cost` decimal(18,2) NOT NULL DEFAULT 0.00,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `parameters`
--

CREATE TABLE `parameters` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `parameter_key` varchar(150) NOT NULL,
  `label` varchar(200) NOT NULL,
  `value_decimal` decimal(18,6) DEFAULT NULL,
  `value_text` text DEFAULT NULL,
  `unit` varchar(30) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `updated_by` bigint(20) UNSIGNED DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

--
-- Volcado de datos para la tabla `parameters`
--

INSERT INTO `parameters` (`id`, `parameter_key`, `label`, `value_decimal`, `value_text`, `unit`, `description`, `is_active`, `updated_by`, `created_at`, `updated_at`) VALUES
(1, 'specialized_difficult_profile_surveys', 'Encuestas Perfil Especializado Dificil', 1.000000, NULL, 'factor', NULL, 1, NULL, '2026-08-17 21:04:52', '2026-08-17 21:04:52'),
(2, 'specialized_medium_profile_surveys', 'Encuestas Perfil Especializado Medio', 2.000000, NULL, 'factor', NULL, 1, NULL, '2026-08-17 21:04:52', '2026-08-17 21:04:52'),
(3, 'specialized_easy_profile_surveys', 'Encuestas Perfil Especializado Facil', 4.000000, NULL, 'factor', NULL, 1, NULL, '2026-08-17 21:04:52', '2026-08-17 21:04:52'),
(4, 'questionnaire_coherence_minutes_per_25', 'Tiempo revisar coherencia cuestionario 25 preguntas', 5.000000, NULL, 'minutos', NULL, 1, NULL, '2026-08-17 21:04:52', '2026-08-17 21:04:52'),
(5, 'open_question_coding_minutes', 'Tiempo codificar 1 pregunta abierta', 3.000000, NULL, 'minutos', NULL, 1, NULL, '2026-08-17 21:04:52', '2026-08-17 21:04:52'),
(6, 'audit_processing_workday_hours', 'Hora de trabajo jornada auditoria y procesado', 8.500000, NULL, 'horas', NULL, 1, NULL, '2026-08-17 21:04:52', '2026-08-17 21:04:52'),
(7, 'audit_survey_time_ratio', 'Ratio de tiempo para auditar encuesta', 2.000000, NULL, 'factor', NULL, 1, NULL, '2026-08-17 21:04:52', '2026-08-17 21:04:52');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `password_reset_tokens`
--

CREATE TABLE `password_reset_tokens` (
  `email` varchar(190) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `permissions`
--

CREATE TABLE `permissions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `code` varchar(100) NOT NULL,
  `name` varchar(150) NOT NULL,
  `module` varchar(60) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

--
-- Volcado de datos para la tabla `permissions`
--

INSERT INTO `permissions` (`id`, `code`, `name`, `module`, `created_at`) VALUES
(1, 'dashboard.view', 'Ver panel principal', 'dashboard', '2026-08-17 21:04:52'),
(2, 'quotes.view', 'Ver cotizaciones', 'quotes', '2026-08-17 21:04:52'),
(3, 'quotes.create', 'Crear cotizaciones', 'quotes', '2026-08-17 21:04:52'),
(4, 'quotes.update', 'Editar cotizaciones', 'quotes', '2026-08-17 21:04:52'),
(5, 'quotes.export', 'Exportar cotizaciones', 'quotes', '2026-08-17 21:04:52'),
(6, 'quotes.finalize', 'Finalizar cotizaciones', 'quotes', '2026-08-17 21:04:52'),
(7, 'quotes.approve', 'Aprobar cotizaciones', 'quotes', '2026-08-17 21:04:52'),
(8, 'users.view', 'Ver usuarios', 'users', '2026-08-17 21:04:52'),
(9, 'users.manage', 'Administrar usuarios', 'users', '2026-08-17 21:04:52'),
(10, 'roles.manage', 'Administrar roles y permisos', 'roles', '2026-08-17 21:04:52'),
(11, 'catalogs.view', 'Ver catalogos', 'catalogs', '2026-08-17 21:04:52'),
(12, 'catalogs.manage', 'Administrar catalogos y tarifas', 'catalogs', '2026-08-17 21:04:52'),
(13, 'parameters.manage', 'Administrar parametros', 'parameters', '2026-08-17 21:04:52'),
(14, 'audit.view', 'Consultar bitacora', 'audit', '2026-08-17 21:04:52'),
(15, 'reports.view', 'Ver reportes', 'reports', '2026-08-17 21:04:52');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `projects`
--

CREATE TABLE `projects` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `public_code` varchar(30) NOT NULL,
  `name` varchar(255) NOT NULL,
  `country_id` bigint(20) UNSIGNED NOT NULL,
  `currency_id` bigint(20) UNSIGNED DEFAULT NULL,
  `methodology` varchar(30) NOT NULL DEFAULT 'cuantitativo',
  `category_id` bigint(20) UNSIGNED DEFAULT NULL,
  `target_type_id` tinyint(3) UNSIGNED DEFAULT NULL,
  `b2b_profile_id` tinyint(3) UNSIGNED DEFAULT NULL,
  `target_age_range_id` tinyint(3) UNSIGNED DEFAULT NULL,
  `target_gender_id` tinyint(3) UNSIGNED DEFAULT NULL,
  `target_nse_id` tinyint(3) UNSIGNED DEFAULT NULL,
  `target_penetration` decimal(10,3) DEFAULT NULL,
  `category_penetration_score` tinyint(3) UNSIGNED DEFAULT NULL,
  `target_duration` decimal(10,3) DEFAULT NULL,
  `target_difficulty` decimal(10,3) DEFAULT NULL,
  `target_difficulty_score` decimal(4,1) DEFAULT NULL,
  `study_difficulty_score` decimal(4,1) DEFAULT NULL,
  `coverage_population` bigint(20) UNSIGNED DEFAULT NULL,
  `coverage_response_effectiveness` decimal(10,3) DEFAULT NULL,
  `coverage_sample_size_f2f` bigint(20) UNSIGNED DEFAULT NULL,
  `coverage_daily_productivity` decimal(10,3) DEFAULT NULL,
  `coverage_execution_days` decimal(10,3) DEFAULT NULL,
  `project_cost_field` decimal(18,2) NOT NULL DEFAULT 0.00,
  `project_cost_telecom` decimal(18,2) NOT NULL DEFAULT 0.00,
  `project_cost_materials` decimal(18,2) NOT NULL DEFAULT 0.00,
  `project_cost_total` decimal(18,2) NOT NULL DEFAULT 0.00,
  `quote_margin_percent` decimal(10,3) NOT NULL DEFAULT 0.000,
  `quote_discount_percent` decimal(10,3) NOT NULL DEFAULT 0.000,
  `quote_final_price` decimal(18,2) NOT NULL DEFAULT 0.00,
  `status` enum('draft','finalized','approved','cancelled') NOT NULL DEFAULT 'draft',
  `sample_size` int(10) UNSIGNED DEFAULT NULL,
  `proposed_margin_percent` decimal(8,4) DEFAULT NULL,
  `approved_discount_percent` decimal(8,4) DEFAULT NULL,
  `total_cost` decimal(18,2) NOT NULL DEFAULT 0.00,
  `total_margin` decimal(18,2) NOT NULL DEFAULT 0.00,
  `final_price` decimal(18,2) NOT NULL DEFAULT 0.00,
  `calculation_data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`calculation_data`)),
  `created_by` bigint(20) UNSIGNED NOT NULL,
  `updated_by` bigint(20) UNSIGNED DEFAULT NULL,
  `finalized_at` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `deleted_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

--
-- Volcado de datos para la tabla `projects`
--

INSERT INTO `projects` (`id`, `public_code`, `name`, `country_id`, `currency_id`, `methodology`, `category_id`, `target_type_id`, `b2b_profile_id`, `target_age_range_id`, `target_gender_id`, `target_nse_id`, `target_penetration`, `category_penetration_score`, `target_duration`, `target_difficulty`, `target_difficulty_score`, `study_difficulty_score`, `coverage_population`, `coverage_response_effectiveness`, `coverage_sample_size_f2f`, `coverage_daily_productivity`, `coverage_execution_days`, `project_cost_field`, `project_cost_telecom`, `project_cost_materials`, `project_cost_total`, `quote_margin_percent`, `quote_discount_percent`, `quote_final_price`, `status`, `sample_size`, `proposed_margin_percent`, `approved_discount_percent`, `total_cost`, `total_margin`, `final_price`, `calculation_data`, `created_by`, `updated_by`, `finalized_at`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'COT-2026-00001', 'Sitio Insight', 1, NULL, 'cuantitativo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, 1.0, 1.0, NULL, NULL, NULL, NULL, NULL, 0.00, 0.00, 0.00, 0.00, 0.000, 0.000, 0.00, 'draft', 2, 25.0000, 25.0000, 1410.00, 352.50, 1321.88, '{\"sample_size\":2,\"field_unit_cost\":130,\"telecom_cost\":150,\"materials_cost\":1000,\"difficulty_score\":5}', 1, 1, NULL, '2026-08-17 21:24:28', '2026-08-18 06:39:58', NULL),
(2, 'COT-8D52CC2C', 'Sitio Insight', 1, NULL, 'cuantitativo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, 1.0, 1.0, NULL, NULL, NULL, NULL, NULL, 0.00, 0.00, 0.00, 2.00, 0.000, 0.000, 0.00, 'draft', NULL, NULL, NULL, 2.00, 0.00, 2.02, '{\"target_difficulty\":38}', 1, NULL, NULL, '2026-08-18 04:04:39', '2026-08-18 06:39:58', NULL),
(3, 'COT-8192159B', 'asd', 3, NULL, 'cuantitativo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, 25.000, 25.0, 25.0, NULL, NULL, NULL, NULL, NULL, 0.00, 0.00, 0.00, 0.00, 2.000, 2.000, 0.00, 'draft', NULL, NULL, NULL, 0.00, 0.00, 0.00, '{\"target\":{\"category_factor\":\"1\",\"duration_factor\":\"22\",\"target_factor\":\"2\",\"target_difficulty\":25},\"coverage\":{\"coverage_population\":null,\"coverage_response_effectiveness\":null,\"coverage_sample_size_f2f\":null,\"coverage_execution_days\":null}}', 1, NULL, NULL, '2026-08-18 04:26:43', '2026-08-18 06:39:58', NULL),
(4, 'COT-80F22DA9', 'Sitio Insight', 7, NULL, 'cuantitativo', 16, 2, 1, 3, 2, 2, 23.000, 23, 2.000, 0.000, 0.0, 0.0, 23, 23.000, 23, NULL, 23.000, 2323.00, 23.00, 232.00, 2578.00, 23.000, 22.000, 2473.33, 'draft', NULL, NULL, NULL, 2578.00, 0.00, 2473.33, '{\"target\":{\"name\":\"Sitio Insight\",\"country_id\":\"7\",\"target_type_id\":\"2\",\"category_id\":\"2\",\"category_factor\":\"12\",\"duration_factor\":\"2\",\"target_factor\":\"332\",\"target_penetration\":\"23\",\"target_duration\":\"2\",\"target_age_range_id\":\"3\",\"target_gender_id\":\"2\",\"target_nse_id\":\"2\"},\"coverage\":{\"name\":\"Sitio Insight\",\"country_id\":\"7\",\"coverage_population\":\"23\",\"coverage_response_effectiveness\":\"23\",\"coverage_sample_size_f2f\":\"23\",\"coverage_execution_days\":\"23\"},\"field\":{\"name\":\"Sitio Insight\",\"country_id\":\"7\",\"field_cost\":\"2323\",\"field_travel_cost\":\"23\"},\"telecom\":{\"name\":\"Sitio Insight\",\"country_id\":\"7\",\"telecom_cost\":\"23\",\"telecom_coordination\":\"23\"},\"materials\":{\"name\":\"Sitio Insight\",\"country_id\":\"7\",\"materials_cost\":\"232\",\"material_others\":\"2323\"},\"summary\":{\"name\":\"Sitio Insight\",\"country_id\":\"7\"},\"payments\":{\"name\":\"Sitio Insight\",\"country_id\":\"7\",\"margin_percent\":\"23.000\",\"discount_percent\":\"22.000\"}}', 1, NULL, NULL, '2026-08-18 04:27:01', '2026-08-18 14:24:33', NULL),
(5, 'COT-E8BE78C6', 'a', 3, NULL, 'cuantitativo', 16, 1, NULL, 5, 2, 2, 2.000, 2, 2.000, 0.000, 0.0, 0.0, 0, 0.000, 0, NULL, 0.000, 0.00, 0.00, 0.00, 0.00, 0.000, 0.000, 0.00, 'draft', NULL, NULL, NULL, 0.00, 0.00, 0.00, '{\"target\":{\"name\":\"a\",\"country_id\":\"3\",\"target_type_id\":\"1\",\"category_id\":\"2\",\"category_factor\":\"1\",\"duration_factor\":\"2\",\"target_factor\":\"2\",\"target_penetration\":\"2\",\"target_duration\":\"2\",\"target_age_range_id\":\"5\",\"target_gender_id\":\"2\",\"target_nse_id\":\"2\"},\"coverage\":{\"name\":\"a\",\"country_id\":\"3\",\"coverage_population\":\"0\",\"coverage_response_effectiveness\":\"0\",\"coverage_sample_size_f2f\":\"0\",\"coverage_execution_days\":\"0\"},\"field\":{\"name\":\"a\",\"country_id\":\"3\",\"field_cost\":\"0.00\",\"field_travel_cost\":\"0\"},\"telecom\":{\"name\":\"a\",\"country_id\":\"3\",\"telecom_cost\":\"0.00\",\"telecom_coordination\":\"0\"},\"materials\":{\"name\":\"a\",\"country_id\":\"3\",\"materials_cost\":\"0.00\",\"material_others\":\"0\"}}', 1, NULL, NULL, '2026-08-18 04:46:31', '2026-08-18 14:24:33', NULL),
(6, 'COT-98186F72', 'as', 1, NULL, 'cuantitativo', 15, 1, NULL, 1, 1, 2, 0.000, 5, 0.000, 1.000, 1.0, 1.0, NULL, NULL, NULL, NULL, NULL, 0.00, 0.00, 0.00, 0.00, 0.000, 0.000, 0.00, 'draft', NULL, NULL, NULL, 0.00, 0.00, 0.00, '{\"target\":{\"name\":\"as\",\"country_id\":\"1\",\"target_type_id\":\"1\",\"category_id\":\"1\",\"category_factor\":\"1\",\"duration_factor\":\"0\",\"target_factor\":\"0\",\"target_penetration\":\"0\",\"target_duration\":\"0\",\"target_age_range_id\":\"1\",\"target_gender_id\":\"1\",\"target_nse_id\":\"2\"},\"coverage\":{\"coverage_population\":null,\"coverage_response_effectiveness\":null,\"coverage_sample_size_f2f\":null,\"coverage_execution_days\":null}}', 1, NULL, NULL, '2026-08-18 04:48:14', '2026-08-18 14:24:33', NULL),
(7, 'COT-2026-7FDD0F', 'asdas', 1, 1, 'cualitativo', 26, 1, NULL, 1, 1, 1, 12.000, 12, 10.000, 1.000, 1.0, 1.0, 2333, 80.000, NULL, 12.000, 34.000, 0.00, 0.00, 0.00, 0.00, 0.000, 0.000, 0.00, 'draft', 400, 30.0000, 20.0000, 69755.00, 20926.50, 72545.20, '{\"country_id\":1,\"sample_size\":400,\"duration\":10,\"nse\":1,\"daily_productivity\":12,\"difficulty\":1,\"margin\":30,\"discount\":20,\"target\":[],\"coverage\":[],\"project\":{\"scope\":\"  asdasd\",\"deliverables\":\"  asda\"},\"commercial\":{\"validity\":\"15 días\",\"payment_terms\":\"50% anticipo \\/ 50% contra entrega\"},\"calculation\":{\"lines\":[{\"section\":\"Campo\",\"key\":\"encuesta_muy_sencilla_8_10_minutos\",\"description\":\"Aplicación de encuestas según duración\",\"quantity\":400,\"unit_cost\":20,\"total\":8000},{\"section\":\"Campo\",\"key\":\"pago_dia_supervisores_campo\",\"description\":\"Supervisión de campo\",\"quantity\":17,\"unit_cost\":510,\"total\":8670},{\"section\":\"Campo\",\"key\":\"pago_dia_encuestadores_campo\",\"description\":\"Coordinación de encuestadores\",\"quantity\":12,\"unit_cost\":425,\"total\":5100},{\"section\":\"Telecom\",\"key\":\"coste_paquete_diario_llamadas_y_datos\",\"description\":\"Conectividad y paquetes diarios\",\"quantity\":34,\"unit_cost\":100,\"total\":3400},{\"section\":\"Telecom\",\"key\":\"coste_espacio_en_la_nube\",\"description\":\"Plataforma y almacenamiento\",\"quantity\":1,\"unit_cost\":210,\"total\":210},{\"section\":\"Materiales\",\"key\":\"incentivos_perfil_bajo\",\"description\":\"Incentivos de participantes\",\"quantity\":400,\"unit_cost\":20,\"total\":8000},{\"section\":\"Materiales\",\"key\":\"copias_de_papel_blanco_y_negro_1_ud\",\"description\":\"Materiales e impresiones\",\"quantity\":400,\"unit_cost\":20,\"total\":8000},{\"section\":\"Operaciones\",\"key\":\"pago_dia_coordinador_operaciones\",\"description\":\"Coordinación operativa\",\"quantity\":17,\"unit_cost\":500,\"total\":8500},{\"section\":\"Procesado\",\"key\":\"pago_dia_coordinador_procesado\",\"description\":\"Procesamiento y tabulación\",\"quantity\":17,\"unit_cost\":500,\"total\":8500},{\"section\":\"Auditoría\",\"key\":\"pago_dia_coordinador_auditoria\",\"description\":\"Control de calidad y auditoría\",\"quantity\":12,\"unit_cost\":479.1667,\"total\":5750},{\"section\":\"Ejecutivo\",\"key\":\"pago_dia_ejecutivo\",\"description\":\"Gestión ejecutiva y proyecto\",\"quantity\":9,\"unit_cost\":625,\"total\":5625}],\"days\":34,\"difficulty\":1,\"sample_size\":400,\"total_cost\":69755,\"total_margin\":20926.5,\"final_price\":72545.2,\"margin\":30,\"discount\":20}}', 1, 1, NULL, '2026-08-18 05:27:17', '2026-08-18 14:24:33', NULL),
(8, 'COT-2026-0226FF', 'asdas', 1, 1, 'cualitativo', 19, 2, 1, 1, 2, 1, 2.000, 2, 10.000, 2.800, 2.8, 2.8, 233333, 80.000, NULL, 2.000, 1.000, 0.00, 0.00, 0.00, 0.00, 0.000, 0.000, 0.00, 'draft', 2, 30.0000, 0.0000, 24259.17, 7277.75, 31536.92, '{\"country_id\":1,\"category_id\":5,\"target_type_id\":2,\"target_age_range_id\":1,\"target_gender_id\":2,\"target_nse_id\":1,\"target_penetration\":2,\"sample_size\":2,\"duration\":10,\"nse\":1,\"daily_productivity\":2,\"difficulty\":1,\"margin\":30,\"discount\":0,\"telecom\":{\"connection_days\":\"3\",\"devices\":\"1\",\"cloud\":\"1\"},\"materials\":{\"incentives\":\"1\",\"copies_per_participant\":\"2\",\"kits\":\"2\"},\"target\":[],\"coverage\":[],\"project\":{\"scope\":\"  2\",\"deliverables\":\"  2\"},\"commercial\":{\"validity\":\"15 días\",\"payment_terms\":\"50% anticipo \\/ 50% contra entrega\"},\"calculation\":{\"lines\":[{\"section\":\"Campo\",\"key\":\"encuesta_muy_sencilla_8_10_minutos\",\"description\":\"Aplicación de encuestas según duración\",\"quantity\":2,\"unit_cost\":20,\"total\":40},{\"section\":\"Campo\",\"key\":\"pago_dia_supervisores_campo\",\"description\":\"Supervisión de campo\",\"quantity\":2,\"unit_cost\":510,\"total\":1020},{\"section\":\"Campo\",\"key\":\"pago_dia_encuestadores_campo\",\"description\":\"Coordinación de encuestadores\",\"quantity\":1,\"unit_cost\":425,\"total\":425},{\"section\":\"Telecom\",\"key\":\"coste_paquete_diario_llamadas_y_datos\",\"description\":\"Paquetes de llamadas y datos\",\"quantity\":3,\"unit_cost\":100,\"total\":300},{\"section\":\"Telecom\",\"key\":\"coste_espacio_en_la_nube\",\"description\":\"Plataforma y almacenamiento\",\"quantity\":1,\"unit_cost\":210,\"total\":210},{\"section\":\"Telecom\",\"key\":\"precio_computadora\",\"description\":\"Equipos y dispositivos\",\"quantity\":1,\"unit_cost\":20000,\"total\":20000},{\"section\":\"Materiales\",\"key\":\"incentivos_perfil_bajo\",\"description\":\"Incentivos de participantes\",\"quantity\":2,\"unit_cost\":20,\"total\":40},{\"section\":\"Materiales\",\"key\":\"copias_de_papel_blanco_y_negro_1_ud\",\"description\":\"Copias e impresiones\",\"quantity\":4,\"unit_cost\":20,\"total\":80},{\"section\":\"Materiales\",\"key\":\"bolsas_paquete_50_ud\",\"description\":\"Kits y suministros de campo\",\"quantity\":2,\"unit_cost\":20,\"total\":40},{\"section\":\"Operaciones\",\"key\":\"pago_dia_coordinador_operaciones\",\"description\":\"Coordinación operativa\",\"quantity\":1,\"unit_cost\":500,\"total\":500},{\"section\":\"Procesado\",\"key\":\"pago_dia_coordinador_procesado\",\"description\":\"Procesamiento y tabulación\",\"quantity\":1,\"unit_cost\":500,\"total\":500},{\"section\":\"Auditoría\",\"key\":\"pago_dia_coordinador_auditoria\",\"description\":\"Control de calidad y auditoría\",\"quantity\":1,\"unit_cost\":479.1667,\"total\":479.17},{\"section\":\"Ejecutivo\",\"key\":\"pago_dia_ejecutivo\",\"description\":\"Gestión ejecutiva y proyecto\",\"quantity\":1,\"unit_cost\":625,\"total\":625}],\"days\":1,\"difficulty\":2.8,\"sample_size\":2,\"total_cost\":24259.17,\"total_margin\":7277.75,\"final_price\":31536.92,\"margin\":30,\"discount\":0}}', 1, 1, NULL, '2026-08-18 05:42:57', '2026-08-18 14:24:33', NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `project_answers`
--

CREATE TABLE `project_answers` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `project_id` bigint(20) UNSIGNED NOT NULL,
  `question_id` bigint(20) UNSIGNED NOT NULL,
  `option_id` bigint(20) UNSIGNED DEFAULT NULL,
  `numeric_value` decimal(18,4) DEFAULT NULL,
  `text_value` text DEFAULT NULL,
  `calculated_score` decimal(10,3) NOT NULL DEFAULT 0.000,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `project_b2b_profiles`
--

CREATE TABLE `project_b2b_profiles` (
  `project_id` bigint(20) UNSIGNED NOT NULL,
  `b2b_profile_id` tinyint(3) UNSIGNED NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `project_b2b_profiles`
--

INSERT INTO `project_b2b_profiles` (`project_id`, `b2b_profile_id`, `created_at`) VALUES
(4, 1, '2026-08-18 06:39:58'),
(8, 1, '2026-08-18 06:39:58');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `project_target_ages`
--

CREATE TABLE `project_target_ages` (
  `project_id` bigint(20) UNSIGNED NOT NULL,
  `age_range_id` tinyint(3) UNSIGNED NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `project_target_ages`
--

INSERT INTO `project_target_ages` (`project_id`, `age_range_id`, `created_at`) VALUES
(4, 3, '2026-08-18 06:39:58'),
(5, 5, '2026-08-18 06:39:58'),
(6, 1, '2026-08-18 06:39:58'),
(7, 1, '2026-08-18 06:39:58'),
(8, 1, '2026-08-18 06:39:58');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `project_target_nse_levels`
--

CREATE TABLE `project_target_nse_levels` (
  `project_id` bigint(20) UNSIGNED NOT NULL,
  `nse_level_id` tinyint(3) UNSIGNED NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `project_target_nse_levels`
--

INSERT INTO `project_target_nse_levels` (`project_id`, `nse_level_id`, `created_at`) VALUES
(4, 2, '2026-08-18 06:39:58'),
(5, 2, '2026-08-18 06:39:58'),
(6, 2, '2026-08-18 06:39:58'),
(7, 1, '2026-08-18 06:39:58'),
(8, 1, '2026-08-18 06:39:58');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `project_versions`
--

CREATE TABLE `project_versions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `project_id` bigint(20) UNSIGNED NOT NULL,
  `version_number` int(10) UNSIGNED NOT NULL,
  `snapshot` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`snapshot`)),
  `change_note` varchar(500) DEFAULT NULL,
  `created_by` bigint(20) UNSIGNED DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

--
-- Volcado de datos para la tabla `project_versions`
--

INSERT INTO `project_versions` (`id`, `project_id`, `version_number`, `snapshot`, `change_note`, `created_by`, `created_at`) VALUES
(1, 7, 1, '{\"country_id\":1,\"sample_size\":400,\"duration\":10,\"nse\":1,\"daily_productivity\":12,\"difficulty\":1,\"margin\":30,\"discount\":20,\"target\":[],\"coverage\":[],\"project\":{\"scope\":\"  asdasd\",\"deliverables\":\"  asda\"},\"commercial\":{\"validity\":\"15 días\",\"payment_terms\":\"50% anticipo \\/ 50% contra entrega\"},\"calculation\":{\"lines\":[{\"section\":\"Campo\",\"key\":\"encuesta_muy_sencilla_8_10_minutos\",\"description\":\"Aplicación de encuestas según duración\",\"quantity\":400,\"unit_cost\":20,\"total\":8000},{\"section\":\"Campo\",\"key\":\"pago_dia_supervisores_campo\",\"description\":\"Supervisión de campo\",\"quantity\":17,\"unit_cost\":510,\"total\":8670},{\"section\":\"Campo\",\"key\":\"pago_dia_encuestadores_campo\",\"description\":\"Coordinación de encuestadores\",\"quantity\":12,\"unit_cost\":425,\"total\":5100},{\"section\":\"Telecom\",\"key\":\"coste_paquete_diario_llamadas_y_datos\",\"description\":\"Conectividad y paquetes diarios\",\"quantity\":34,\"unit_cost\":100,\"total\":3400},{\"section\":\"Telecom\",\"key\":\"coste_espacio_en_la_nube\",\"description\":\"Plataforma y almacenamiento\",\"quantity\":1,\"unit_cost\":210,\"total\":210},{\"section\":\"Materiales\",\"key\":\"incentivos_perfil_bajo\",\"description\":\"Incentivos de participantes\",\"quantity\":400,\"unit_cost\":20,\"total\":8000},{\"section\":\"Materiales\",\"key\":\"copias_de_papel_blanco_y_negro_1_ud\",\"description\":\"Materiales e impresiones\",\"quantity\":400,\"unit_cost\":20,\"total\":8000},{\"section\":\"Operaciones\",\"key\":\"pago_dia_coordinador_operaciones\",\"description\":\"Coordinación operativa\",\"quantity\":17,\"unit_cost\":500,\"total\":8500},{\"section\":\"Procesado\",\"key\":\"pago_dia_coordinador_procesado\",\"description\":\"Procesamiento y tabulación\",\"quantity\":17,\"unit_cost\":500,\"total\":8500},{\"section\":\"Auditoría\",\"key\":\"pago_dia_coordinador_auditoria\",\"description\":\"Control de calidad y auditoría\",\"quantity\":12,\"unit_cost\":479.1667,\"total\":5750},{\"section\":\"Ejecutivo\",\"key\":\"pago_dia_ejecutivo\",\"description\":\"Gestión ejecutiva y proyecto\",\"quantity\":9,\"unit_cost\":625,\"total\":5625}],\"days\":34,\"difficulty\":1,\"sample_size\":400,\"total_cost\":69755,\"total_margin\":20926.5,\"final_price\":72545.2,\"margin\":30,\"discount\":20}}', 'Cálculo automático guardado', 1, '2026-08-18 05:27:17'),
(2, 8, 1, '{\"country_id\":1,\"category_id\":5,\"target_type_id\":2,\"target_age_range_id\":1,\"target_gender_id\":2,\"target_nse_id\":1,\"target_penetration\":2,\"sample_size\":2,\"duration\":10,\"nse\":1,\"daily_productivity\":2,\"difficulty\":1,\"margin\":30,\"discount\":0,\"telecom\":{\"connection_days\":\"3\",\"devices\":\"1\",\"cloud\":\"1\"},\"materials\":{\"incentives\":\"1\",\"copies_per_participant\":\"2\",\"kits\":\"2\"},\"target\":[],\"coverage\":[],\"project\":{\"scope\":\"  2\",\"deliverables\":\"  2\"},\"commercial\":{\"validity\":\"15 días\",\"payment_terms\":\"50% anticipo \\/ 50% contra entrega\"},\"calculation\":{\"lines\":[{\"section\":\"Campo\",\"key\":\"encuesta_muy_sencilla_8_10_minutos\",\"description\":\"Aplicación de encuestas según duración\",\"quantity\":2,\"unit_cost\":20,\"total\":40},{\"section\":\"Campo\",\"key\":\"pago_dia_supervisores_campo\",\"description\":\"Supervisión de campo\",\"quantity\":2,\"unit_cost\":510,\"total\":1020},{\"section\":\"Campo\",\"key\":\"pago_dia_encuestadores_campo\",\"description\":\"Coordinación de encuestadores\",\"quantity\":1,\"unit_cost\":425,\"total\":425},{\"section\":\"Telecom\",\"key\":\"coste_paquete_diario_llamadas_y_datos\",\"description\":\"Paquetes de llamadas y datos\",\"quantity\":3,\"unit_cost\":100,\"total\":300},{\"section\":\"Telecom\",\"key\":\"coste_espacio_en_la_nube\",\"description\":\"Plataforma y almacenamiento\",\"quantity\":1,\"unit_cost\":210,\"total\":210},{\"section\":\"Telecom\",\"key\":\"precio_computadora\",\"description\":\"Equipos y dispositivos\",\"quantity\":1,\"unit_cost\":20000,\"total\":20000},{\"section\":\"Materiales\",\"key\":\"incentivos_perfil_bajo\",\"description\":\"Incentivos de participantes\",\"quantity\":2,\"unit_cost\":20,\"total\":40},{\"section\":\"Materiales\",\"key\":\"copias_de_papel_blanco_y_negro_1_ud\",\"description\":\"Copias e impresiones\",\"quantity\":4,\"unit_cost\":20,\"total\":80},{\"section\":\"Materiales\",\"key\":\"bolsas_paquete_50_ud\",\"description\":\"Kits y suministros de campo\",\"quantity\":2,\"unit_cost\":20,\"total\":40},{\"section\":\"Operaciones\",\"key\":\"pago_dia_coordinador_operaciones\",\"description\":\"Coordinación operativa\",\"quantity\":1,\"unit_cost\":500,\"total\":500},{\"section\":\"Procesado\",\"key\":\"pago_dia_coordinador_procesado\",\"description\":\"Procesamiento y tabulación\",\"quantity\":1,\"unit_cost\":500,\"total\":500},{\"section\":\"Auditoría\",\"key\":\"pago_dia_coordinador_auditoria\",\"description\":\"Control de calidad y auditoría\",\"quantity\":1,\"unit_cost\":479.1667,\"total\":479.17},{\"section\":\"Ejecutivo\",\"key\":\"pago_dia_ejecutivo\",\"description\":\"Gestión ejecutiva y proyecto\",\"quantity\":1,\"unit_cost\":625,\"total\":625}],\"days\":1,\"difficulty\":2.8,\"sample_size\":2,\"total_cost\":24259.17,\"total_margin\":7277.75,\"final_price\":31536.92,\"margin\":30,\"discount\":0}}', 'Cálculo automático guardado', 1, '2026-08-18 05:42:57');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `quote_lines`
--

CREATE TABLE `quote_lines` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `project_id` bigint(20) UNSIGNED NOT NULL,
  `cost_section` varchar(100) NOT NULL,
  `cost_key` varchar(150) DEFAULT NULL,
  `description` varchar(255) NOT NULL,
  `quantity` decimal(18,4) NOT NULL DEFAULT 1.0000,
  `unit_cost` decimal(18,4) NOT NULL DEFAULT 0.0000,
  `total_cost` decimal(18,2) NOT NULL DEFAULT 0.00,
  `formula_text` text DEFAULT NULL,
  `sort_order` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

--
-- Volcado de datos para la tabla `quote_lines`
--

INSERT INTO `quote_lines` (`id`, `project_id`, `cost_section`, `cost_key`, `description`, `quantity`, `unit_cost`, `total_cost`, `formula_text`, `sort_order`, `created_at`, `updated_at`) VALUES
(4, 1, 'Campo', NULL, 'Campo', 2.0000, 130.0000, 260.00, NULL, 0, '2026-08-17 21:24:31', '2026-08-17 21:24:31'),
(5, 1, 'Telecom', NULL, 'Telecom', 1.0000, 150.0000, 150.00, NULL, 1, '2026-08-17 21:24:31', '2026-08-17 21:24:31'),
(6, 1, 'Materiales', NULL, 'Materiales', 1.0000, 1000.0000, 1000.00, NULL, 2, '2026-08-17 21:24:31', '2026-08-17 21:24:31'),
(7, 7, 'Campo', 'encuesta_muy_sencilla_8_10_minutos', 'Aplicación de encuestas según duración', 400.0000, 20.0000, 8000.00, 'Cantidad x tarifa vigente', 0, '2026-08-18 05:27:17', '2026-08-18 05:27:17'),
(8, 7, 'Campo', 'pago_dia_supervisores_campo', 'Supervisión de campo', 17.0000, 510.0000, 8670.00, 'Cantidad x tarifa vigente', 1, '2026-08-18 05:27:17', '2026-08-18 05:27:17'),
(9, 7, 'Campo', 'pago_dia_encuestadores_campo', 'Coordinación de encuestadores', 12.0000, 425.0000, 5100.00, 'Cantidad x tarifa vigente', 2, '2026-08-18 05:27:17', '2026-08-18 05:27:17'),
(10, 7, 'Telecom', 'coste_paquete_diario_llamadas_y_datos', 'Conectividad y paquetes diarios', 34.0000, 100.0000, 3400.00, 'Cantidad x tarifa vigente', 3, '2026-08-18 05:27:17', '2026-08-18 05:27:17'),
(11, 7, 'Telecom', 'coste_espacio_en_la_nube', 'Plataforma y almacenamiento', 1.0000, 210.0000, 210.00, 'Cantidad x tarifa vigente', 4, '2026-08-18 05:27:17', '2026-08-18 05:27:17'),
(12, 7, 'Materiales', 'incentivos_perfil_bajo', 'Incentivos de participantes', 400.0000, 20.0000, 8000.00, 'Cantidad x tarifa vigente', 5, '2026-08-18 05:27:17', '2026-08-18 05:27:17'),
(13, 7, 'Materiales', 'copias_de_papel_blanco_y_negro_1_ud', 'Materiales e impresiones', 400.0000, 20.0000, 8000.00, 'Cantidad x tarifa vigente', 6, '2026-08-18 05:27:17', '2026-08-18 05:27:17'),
(14, 7, 'Operaciones', 'pago_dia_coordinador_operaciones', 'Coordinación operativa', 17.0000, 500.0000, 8500.00, 'Cantidad x tarifa vigente', 7, '2026-08-18 05:27:17', '2026-08-18 05:27:17'),
(15, 7, 'Procesado', 'pago_dia_coordinador_procesado', 'Procesamiento y tabulación', 17.0000, 500.0000, 8500.00, 'Cantidad x tarifa vigente', 8, '2026-08-18 05:27:17', '2026-08-18 05:27:17'),
(16, 7, 'Auditoría', 'pago_dia_coordinador_auditoria', 'Control de calidad y auditoría', 12.0000, 479.1667, 5750.00, 'Cantidad x tarifa vigente', 9, '2026-08-18 05:27:17', '2026-08-18 05:27:17'),
(17, 7, 'Ejecutivo', 'pago_dia_ejecutivo', 'Gestión ejecutiva y proyecto', 9.0000, 625.0000, 5625.00, 'Cantidad x tarifa vigente', 10, '2026-08-18 05:27:17', '2026-08-18 05:27:17'),
(18, 8, 'Campo', 'encuesta_muy_sencilla_8_10_minutos', 'Aplicación de encuestas según duración', 2.0000, 20.0000, 40.00, 'Cantidad x tarifa vigente', 0, '2026-08-18 05:42:57', '2026-08-18 05:42:57'),
(19, 8, 'Campo', 'pago_dia_supervisores_campo', 'Supervisión de campo', 2.0000, 510.0000, 1020.00, 'Cantidad x tarifa vigente', 1, '2026-08-18 05:42:57', '2026-08-18 05:42:57'),
(20, 8, 'Campo', 'pago_dia_encuestadores_campo', 'Coordinación de encuestadores', 1.0000, 425.0000, 425.00, 'Cantidad x tarifa vigente', 2, '2026-08-18 05:42:57', '2026-08-18 05:42:57'),
(21, 8, 'Telecom', 'coste_paquete_diario_llamadas_y_datos', 'Paquetes de llamadas y datos', 3.0000, 100.0000, 300.00, 'Cantidad x tarifa vigente', 3, '2026-08-18 05:42:57', '2026-08-18 05:42:57'),
(22, 8, 'Telecom', 'coste_espacio_en_la_nube', 'Plataforma y almacenamiento', 1.0000, 210.0000, 210.00, 'Cantidad x tarifa vigente', 4, '2026-08-18 05:42:57', '2026-08-18 05:42:57'),
(23, 8, 'Telecom', 'precio_computadora', 'Equipos y dispositivos', 1.0000, 20000.0000, 20000.00, 'Cantidad x tarifa vigente', 5, '2026-08-18 05:42:57', '2026-08-18 05:42:57'),
(24, 8, 'Materiales', 'incentivos_perfil_bajo', 'Incentivos de participantes', 2.0000, 20.0000, 40.00, 'Cantidad x tarifa vigente', 6, '2026-08-18 05:42:57', '2026-08-18 05:42:57'),
(25, 8, 'Materiales', 'copias_de_papel_blanco_y_negro_1_ud', 'Copias e impresiones', 4.0000, 20.0000, 80.00, 'Cantidad x tarifa vigente', 7, '2026-08-18 05:42:57', '2026-08-18 05:42:57'),
(26, 8, 'Materiales', 'bolsas_paquete_50_ud', 'Kits y suministros de campo', 2.0000, 20.0000, 40.00, 'Cantidad x tarifa vigente', 8, '2026-08-18 05:42:57', '2026-08-18 05:42:57'),
(27, 8, 'Operaciones', 'pago_dia_coordinador_operaciones', 'Coordinación operativa', 1.0000, 500.0000, 500.00, 'Cantidad x tarifa vigente', 9, '2026-08-18 05:42:57', '2026-08-18 05:42:57'),
(28, 8, 'Procesado', 'pago_dia_coordinador_procesado', 'Procesamiento y tabulación', 1.0000, 500.0000, 500.00, 'Cantidad x tarifa vigente', 10, '2026-08-18 05:42:57', '2026-08-18 05:42:57'),
(29, 8, 'Auditoría', 'pago_dia_coordinador_auditoria', 'Control de calidad y auditoría', 1.0000, 479.1667, 479.17, 'Cantidad x tarifa vigente', 11, '2026-08-18 05:42:57', '2026-08-18 05:42:57'),
(30, 8, 'Ejecutivo', 'pago_dia_ejecutivo', 'Gestión ejecutiva y proyecto', 1.0000, 625.0000, 625.00, 'Cantidad x tarifa vigente', 12, '2026-08-18 05:42:57', '2026-08-18 05:42:57');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `roles`
--

CREATE TABLE `roles` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `code` varchar(50) NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

--
-- Volcado de datos para la tabla `roles`
--

INSERT INTO `roles` (`id`, `code`, `name`, `description`, `created_at`, `updated_at`) VALUES
(1, 'administrator', 'Administrador', 'Acceso total al sistema, configuracion, usuarios y bitacora.', '2026-08-17 21:04:52', '2026-08-17 21:04:52'),
(2, 'employee', 'Empleado', 'Acceso al cotizador sin administracion de usuarios, bitacora ni catalogos globales.', '2026-08-17 21:04:52', '2026-08-17 21:04:52');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `role_permissions`
--

CREATE TABLE `role_permissions` (
  `role_id` bigint(20) UNSIGNED NOT NULL,
  `permission_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

--
-- Volcado de datos para la tabla `role_permissions`
--

INSERT INTO `role_permissions` (`role_id`, `permission_id`, `created_at`) VALUES
(1, 1, '2026-08-17 21:04:52'),
(1, 2, '2026-08-17 21:04:52'),
(1, 3, '2026-08-17 21:04:52'),
(1, 4, '2026-08-17 21:04:52'),
(1, 5, '2026-08-17 21:04:52'),
(1, 6, '2026-08-17 21:04:52'),
(1, 7, '2026-08-17 21:04:52'),
(1, 8, '2026-08-17 21:04:52'),
(1, 9, '2026-08-17 21:04:52'),
(1, 10, '2026-08-17 21:04:52'),
(1, 11, '2026-08-17 21:04:52'),
(1, 12, '2026-08-17 21:04:52'),
(1, 13, '2026-08-17 21:04:52'),
(1, 14, '2026-08-17 21:04:52'),
(1, 15, '2026-08-17 21:04:52'),
(2, 1, '2026-08-17 21:04:52'),
(2, 2, '2026-08-17 21:04:52'),
(2, 3, '2026-08-17 21:04:52'),
(2, 4, '2026-08-17 21:04:52'),
(2, 5, '2026-08-17 21:04:52'),
(2, 6, '2026-08-17 21:04:52'),
(2, 11, '2026-08-17 21:04:52'),
(2, 15, '2026-08-17 21:04:52');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `target_age_ranges`
--

CREATE TABLE `target_age_ranges` (
  `id` tinyint(3) UNSIGNED NOT NULL,
  `label` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

--
-- Volcado de datos para la tabla `target_age_ranges`
--

INSERT INTO `target_age_ranges` (`id`, `label`) VALUES
(1, '10 - 17 años'),
(2, '18 - 30 años'),
(3, '31 - 40 años'),
(4, '41 - 50 años'),
(5, '51 - 60 años'),
(6, '61 - 70 años'),
(7, '71 - 80 años');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `target_genders`
--

CREATE TABLE `target_genders` (
  `id` tinyint(3) UNSIGNED NOT NULL,
  `label` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

--
-- Volcado de datos para la tabla `target_genders`
--

INSERT INTO `target_genders` (`id`, `label`) VALUES
(3, 'Ambos'),
(1, 'Hombre'),
(2, 'Mujer');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `target_nse_levels`
--

CREATE TABLE `target_nse_levels` (
  `id` tinyint(3) UNSIGNED NOT NULL,
  `label` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

--
-- Volcado de datos para la tabla `target_nse_levels`
--

INSERT INTO `target_nse_levels` (`id`, `label`) VALUES
(1, 'A/B'),
(2, 'C+'),
(4, 'C-'),
(3, 'CC'),
(5, 'D/E');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `target_types`
--

CREATE TABLE `target_types` (
  `id` tinyint(3) UNSIGNED NOT NULL,
  `name` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

--
-- Volcado de datos para la tabla `target_types`
--

INSERT INTO `target_types` (`id`, `name`) VALUES
(2, 'B2B'),
(1, 'B2C'),
(3, 'Mixto');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(120) NOT NULL,
  `email` varchar(190) NOT NULL,
  `password` varchar(255) NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `last_login_at` datetime DEFAULT NULL,
  `last_login_ip` varchar(45) DEFAULT NULL,
  `failed_login_attempts` smallint(5) UNSIGNED NOT NULL DEFAULT 0,
  `locked_until` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `deleted_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

--
-- Volcado de datos para la tabla `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `password`, `is_active`, `last_login_at`, `last_login_ip`, `failed_login_attempts`, `locked_until`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'Ariel Geovanny Andino Chinchilla', 'soporteadministracion@insightlatam.com', '$2y$10$zz/Ea4R56j4e.91afXWdvOlpPnXxB8HXc4JvblFu7ZWLFhP.tP5X2', 1, '2026-08-18 05:25:27', '190.53.248.170', 0, NULL, '2026-08-17 21:23:29', '2026-08-18 05:25:27', NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `user_roles`
--

CREATE TABLE `user_roles` (
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `role_id` bigint(20) UNSIGNED NOT NULL,
  `assigned_by` bigint(20) UNSIGNED DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

--
-- Volcado de datos para la tabla `user_roles`
--

INSERT INTO `user_roles` (`user_id`, `role_id`, `assigned_by`, `created_at`) VALUES
(1, 1, 1, '2026-08-17 21:23:29');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `audit_logs`
--
ALTER TABLE `audit_logs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_audit_logs_user_date` (`user_id`,`created_at`),
  ADD KEY `idx_audit_logs_entity` (`entity_type`,`entity_id`),
  ADD KEY `idx_audit_logs_module_date` (`module`,`created_at`);

--
-- Indices de la tabla `b2b_profiles`
--
ALTER TABLE `b2b_profiles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_b2b_profiles_code` (`code`);

--
-- Indices de la tabla `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_categories_code` (`category_code`),
  ADD KEY `idx_categories_sector` (`sector_code`),
  ADD KEY `idx_categories_active` (`is_active`),
  ADD KEY `idx_categories_penetration_score` (`penetration_score`);

--
-- Indices de la tabla `countries`
--
ALTER TABLE `countries`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_countries_name` (`name`),
  ADD UNIQUE KEY `uq_countries_code` (`code`);

--
-- Indices de la tabla `country_costs`
--
ALTER TABLE `country_costs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_country_costs_lookup` (`country_id`,`cost_key`,`is_current`),
  ADD KEY `fk_country_costs_currency` (`currency_id`),
  ADD KEY `fk_country_costs_user` (`updated_by`);

--
-- Indices de la tabla `country_cost_history`
--
ALTER TABLE `country_cost_history`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_country_cost_history_cost` (`country_cost_id`,`changed_at`),
  ADD KEY `fk_cost_history_user` (`changed_by`);

--
-- Indices de la tabla `currencies`
--
ALTER TABLE `currencies`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_currencies_code_country` (`code`,`country_id`),
  ADD KEY `fk_currencies_country` (`country_id`);

--
-- Indices de la tabla `difficulty_options`
--
ALTER TABLE `difficulty_options`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_difficulty_option_code` (`external_code`),
  ADD KEY `idx_difficulty_options_question` (`question_id`,`is_active`);

--
-- Indices de la tabla `difficulty_questions`
--
ALTER TABLE `difficulty_questions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_difficulty_question_code` (`external_code`),
  ADD KEY `idx_difficulty_questions_methodology` (`methodology`,`is_active`);

--
-- Indices de la tabla `exchange_rates`
--
ALTER TABLE `exchange_rates`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_exchange_rates_current` (`currency_id`,`is_current`,`effective_date`),
  ADD KEY `fk_exchange_rates_user` (`created_by`);

--
-- Indices de la tabla `locations`
--
ALTER TABLE `locations`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_locations_code` (`location_code`),
  ADD KEY `idx_locations_country` (`country_id`,`is_active`);

--
-- Indices de la tabla `parameters`
--
ALTER TABLE `parameters`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_parameters_key` (`parameter_key`),
  ADD KEY `fk_parameters_user` (`updated_by`);

--
-- Indices de la tabla `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD PRIMARY KEY (`email`),
  ADD KEY `idx_password_reset_created_at` (`created_at`);

--
-- Indices de la tabla `permissions`
--
ALTER TABLE `permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_permissions_code` (`code`),
  ADD KEY `idx_permissions_module` (`module`);

--
-- Indices de la tabla `projects`
--
ALTER TABLE `projects`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_projects_public_code` (`public_code`),
  ADD KEY `idx_projects_owner_status` (`created_by`,`status`),
  ADD KEY `idx_projects_country_date` (`country_id`,`created_at`),
  ADD KEY `fk_projects_currency` (`currency_id`),
  ADD KEY `fk_projects_category` (`category_id`),
  ADD KEY `fk_projects_updated_by` (`updated_by`),
  ADD KEY `fk_projects_target_type` (`target_type_id`),
  ADD KEY `fk_projects_target_age` (`target_age_range_id`),
  ADD KEY `fk_projects_target_gender` (`target_gender_id`),
  ADD KEY `fk_projects_target_nse` (`target_nse_id`),
  ADD KEY `idx_projects_b2b_profile` (`b2b_profile_id`),
  ADD KEY `idx_projects_target_scores` (`category_penetration_score`,`target_difficulty_score`,`study_difficulty_score`);

--
-- Indices de la tabla `project_answers`
--
ALTER TABLE `project_answers`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_project_answers_project` (`project_id`),
  ADD KEY `fk_project_answers_question` (`question_id`),
  ADD KEY `fk_project_answers_option` (`option_id`);

--
-- Indices de la tabla `project_b2b_profiles`
--
ALTER TABLE `project_b2b_profiles`
  ADD PRIMARY KEY (`project_id`),
  ADD KEY `fk_project_b2b_profile` (`b2b_profile_id`);

--
-- Indices de la tabla `project_target_ages`
--
ALTER TABLE `project_target_ages`
  ADD PRIMARY KEY (`project_id`,`age_range_id`),
  ADD KEY `fk_project_target_ages_age` (`age_range_id`);

--
-- Indices de la tabla `project_target_nse_levels`
--
ALTER TABLE `project_target_nse_levels`
  ADD PRIMARY KEY (`project_id`,`nse_level_id`),
  ADD KEY `fk_project_target_nse_level` (`nse_level_id`);

--
-- Indices de la tabla `project_versions`
--
ALTER TABLE `project_versions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_project_versions` (`project_id`,`version_number`),
  ADD KEY `fk_project_versions_user` (`created_by`);

--
-- Indices de la tabla `quote_lines`
--
ALTER TABLE `quote_lines`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_quote_lines_project_section` (`project_id`,`cost_section`);

--
-- Indices de la tabla `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_roles_code` (`code`);

--
-- Indices de la tabla `role_permissions`
--
ALTER TABLE `role_permissions`
  ADD PRIMARY KEY (`role_id`,`permission_id`),
  ADD KEY `fk_role_permissions_permission` (`permission_id`);

--
-- Indices de la tabla `target_age_ranges`
--
ALTER TABLE `target_age_ranges`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_target_age_ranges_label` (`label`);

--
-- Indices de la tabla `target_genders`
--
ALTER TABLE `target_genders`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_target_genders_label` (`label`);

--
-- Indices de la tabla `target_nse_levels`
--
ALTER TABLE `target_nse_levels`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_target_nse_levels_label` (`label`);

--
-- Indices de la tabla `target_types`
--
ALTER TABLE `target_types`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_target_types_name` (`name`);

--
-- Indices de la tabla `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_users_email` (`email`),
  ADD KEY `idx_users_active` (`is_active`,`deleted_at`);

--
-- Indices de la tabla `user_roles`
--
ALTER TABLE `user_roles`
  ADD PRIMARY KEY (`user_id`,`role_id`),
  ADD KEY `fk_user_roles_role` (`role_id`),
  ADD KEY `fk_user_roles_assigned_by` (`assigned_by`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `audit_logs`
--
ALTER TABLE `audit_logs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT de la tabla `b2b_profiles`
--
ALTER TABLE `b2b_profiles`
  MODIFY `id` tinyint(3) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `categories`
--
ALTER TABLE `categories`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=43;

--
-- AUTO_INCREMENT de la tabla `countries`
--
ALTER TABLE `countries`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT de la tabla `country_costs`
--
ALTER TABLE `country_costs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=198;

--
-- AUTO_INCREMENT de la tabla `country_cost_history`
--
ALTER TABLE `country_cost_history`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `currencies`
--
ALTER TABLE `currencies`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT de la tabla `difficulty_options`
--
ALTER TABLE `difficulty_options`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `difficulty_questions`
--
ALTER TABLE `difficulty_questions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `exchange_rates`
--
ALTER TABLE `exchange_rates`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `locations`
--
ALTER TABLE `locations`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `parameters`
--
ALTER TABLE `parameters`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `permissions`
--
ALTER TABLE `permissions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT de la tabla `projects`
--
ALTER TABLE `projects`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `project_answers`
--
ALTER TABLE `project_answers`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `project_versions`
--
ALTER TABLE `project_versions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `quote_lines`
--
ALTER TABLE `quote_lines`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT de la tabla `roles`
--
ALTER TABLE `roles`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `target_age_ranges`
--
ALTER TABLE `target_age_ranges`
  MODIFY `id` tinyint(3) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `target_genders`
--
ALTER TABLE `target_genders`
  MODIFY `id` tinyint(3) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `target_nse_levels`
--
ALTER TABLE `target_nse_levels`
  MODIFY `id` tinyint(3) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `target_types`
--
ALTER TABLE `target_types`
  MODIFY `id` tinyint(3) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `audit_logs`
--
ALTER TABLE `audit_logs`
  ADD CONSTRAINT `fk_audit_logs_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Filtros para la tabla `country_costs`
--
ALTER TABLE `country_costs`
  ADD CONSTRAINT `fk_country_costs_country` FOREIGN KEY (`country_id`) REFERENCES `countries` (`id`),
  ADD CONSTRAINT `fk_country_costs_currency` FOREIGN KEY (`currency_id`) REFERENCES `currencies` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_country_costs_user` FOREIGN KEY (`updated_by`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Filtros para la tabla `country_cost_history`
--
ALTER TABLE `country_cost_history`
  ADD CONSTRAINT `fk_cost_history_cost` FOREIGN KEY (`country_cost_id`) REFERENCES `country_costs` (`id`),
  ADD CONSTRAINT `fk_cost_history_user` FOREIGN KEY (`changed_by`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Filtros para la tabla `currencies`
--
ALTER TABLE `currencies`
  ADD CONSTRAINT `fk_currencies_country` FOREIGN KEY (`country_id`) REFERENCES `countries` (`id`) ON DELETE SET NULL;

--
-- Filtros para la tabla `difficulty_options`
--
ALTER TABLE `difficulty_options`
  ADD CONSTRAINT `fk_difficulty_options_question` FOREIGN KEY (`question_id`) REFERENCES `difficulty_questions` (`id`);

--
-- Filtros para la tabla `exchange_rates`
--
ALTER TABLE `exchange_rates`
  ADD CONSTRAINT `fk_exchange_rates_currency` FOREIGN KEY (`currency_id`) REFERENCES `currencies` (`id`),
  ADD CONSTRAINT `fk_exchange_rates_user` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Filtros para la tabla `locations`
--
ALTER TABLE `locations`
  ADD CONSTRAINT `fk_locations_country` FOREIGN KEY (`country_id`) REFERENCES `countries` (`id`);

--
-- Filtros para la tabla `parameters`
--
ALTER TABLE `parameters`
  ADD CONSTRAINT `fk_parameters_user` FOREIGN KEY (`updated_by`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Filtros para la tabla `projects`
--
ALTER TABLE `projects`
  ADD CONSTRAINT `fk_projects_b2b_profile` FOREIGN KEY (`b2b_profile_id`) REFERENCES `b2b_profiles` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_projects_category` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_projects_country` FOREIGN KEY (`country_id`) REFERENCES `countries` (`id`),
  ADD CONSTRAINT `fk_projects_created_by` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `fk_projects_currency` FOREIGN KEY (`currency_id`) REFERENCES `currencies` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_projects_target_age` FOREIGN KEY (`target_age_range_id`) REFERENCES `target_age_ranges` (`id`),
  ADD CONSTRAINT `fk_projects_target_gender` FOREIGN KEY (`target_gender_id`) REFERENCES `target_genders` (`id`),
  ADD CONSTRAINT `fk_projects_target_nse` FOREIGN KEY (`target_nse_id`) REFERENCES `target_nse_levels` (`id`),
  ADD CONSTRAINT `fk_projects_target_type` FOREIGN KEY (`target_type_id`) REFERENCES `target_types` (`id`),
  ADD CONSTRAINT `fk_projects_updated_by` FOREIGN KEY (`updated_by`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Filtros para la tabla `project_answers`
--
ALTER TABLE `project_answers`
  ADD CONSTRAINT `fk_project_answers_option` FOREIGN KEY (`option_id`) REFERENCES `difficulty_options` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_project_answers_project` FOREIGN KEY (`project_id`) REFERENCES `projects` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_project_answers_question` FOREIGN KEY (`question_id`) REFERENCES `difficulty_questions` (`id`);

--
-- Filtros para la tabla `project_b2b_profiles`
--
ALTER TABLE `project_b2b_profiles`
  ADD CONSTRAINT `fk_project_b2b_profile` FOREIGN KEY (`b2b_profile_id`) REFERENCES `b2b_profiles` (`id`),
  ADD CONSTRAINT `fk_project_b2b_project` FOREIGN KEY (`project_id`) REFERENCES `projects` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `project_target_ages`
--
ALTER TABLE `project_target_ages`
  ADD CONSTRAINT `fk_project_target_ages_age` FOREIGN KEY (`age_range_id`) REFERENCES `target_age_ranges` (`id`),
  ADD CONSTRAINT `fk_project_target_ages_project` FOREIGN KEY (`project_id`) REFERENCES `projects` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `project_target_nse_levels`
--
ALTER TABLE `project_target_nse_levels`
  ADD CONSTRAINT `fk_project_target_nse_level` FOREIGN KEY (`nse_level_id`) REFERENCES `target_nse_levels` (`id`),
  ADD CONSTRAINT `fk_project_target_nse_project` FOREIGN KEY (`project_id`) REFERENCES `projects` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `project_versions`
--
ALTER TABLE `project_versions`
  ADD CONSTRAINT `fk_project_versions_project` FOREIGN KEY (`project_id`) REFERENCES `projects` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_project_versions_user` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Filtros para la tabla `quote_lines`
--
ALTER TABLE `quote_lines`
  ADD CONSTRAINT `fk_quote_lines_project` FOREIGN KEY (`project_id`) REFERENCES `projects` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `role_permissions`
--
ALTER TABLE `role_permissions`
  ADD CONSTRAINT `fk_role_permissions_permission` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`),
  ADD CONSTRAINT `fk_role_permissions_role` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`);

--
-- Filtros para la tabla `user_roles`
--
ALTER TABLE `user_roles`
  ADD CONSTRAINT `fk_user_roles_assigned_by` FOREIGN KEY (`assigned_by`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_user_roles_role` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`),
  ADD CONSTRAINT `fk_user_roles_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
