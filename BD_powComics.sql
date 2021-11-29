-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 29-11-2021 a las 21:44:07
-- Versión del servidor: 10.4.21-MariaDB
-- Versión de PHP: 8.0.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `api_powcomics`
--
CREATE DATABASE IF NOT EXISTS `api_powcomics` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `api_powcomics`;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `arriendos`
--

CREATE TABLE `arriendos` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `rut` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `id_comic` bigint(20) UNSIGNED NOT NULL,
  `fecha_termino` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `arriendos`
--

INSERT INTO `arriendos` (`id`, `rut`, `id_comic`, `fecha_termino`) VALUES
(1, '20440790-8', 10, '2021-11-20'),
(2, '20440790-8', 7, '2021-11-17'),
(3, '20182176-2', 4, '2021-11-29'),
(4, '20182176-2', 1, '2021-11-30');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `comics`
--

CREATE TABLE `comics` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `nombre_comic` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `universo` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `edicion` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `precio` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `comics`
--

INSERT INTO `comics` (`id`, `nombre_comic`, `universo`, `edicion`, `precio`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'The amazing fantasy #15', 'Marvel', 'Regular', 15000, NULL, NULL, NULL),
(2, 'Joker', 'DC', 'Limitada', 32500, NULL, NULL, NULL),
(3, 'The infinity gauntlet', 'Marvel', 'Limitada', 29999, NULL, NULL, NULL),
(4, 'FlashPoint', 'DC', 'Regular', 16000, NULL, NULL, NULL),
(5, 'Civil War', 'Marvel', 'Regular', 10900, NULL, NULL, NULL),
(6, 'Absolute Carnage', 'Marvel', 'Limitada', 25000, NULL, NULL, NULL),
(7, 'Damian son of Batman', 'DC', 'Regular', 4000, NULL, NULL, NULL),
(8, 'Infinite Crisis', 'DC', 'Limitada', 45000, NULL, NULL, NULL),
(9, 'John Constantine Hellblazer original sins', 'DC', 'Regular', 13900, NULL, NULL, NULL),
(10, 'The new Teen Titans', 'DC', 'Limitada', 59000, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2019_12_14_000001_create_personal_access_tokens_table', 1),
(2, '2021_11_16_205543_create_users_table', 1),
(3, '2021_11_16_205607_create_comics_table', 1),
(4, '2021_11_16_211511_create_arriendos_table', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `users`
--

CREATE TABLE `users` (
  `rut` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nombre_usuario` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `celular` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `users`
--

INSERT INTO `users` (`rut`, `nombre_usuario`, `celular`, `created_at`, `updated_at`, `deleted_at`) VALUES
('12345678-9', 'Spidey', 975695187, NULL, NULL, NULL),
('17353145-1', 'JJ Rojas', 945678912, NULL, NULL, NULL),
('20182176-2', 'Juancho', 995701086, NULL, NULL, NULL),
('20440790-8', 'M-Croyar', 933804830, NULL, NULL, NULL),
('4495436-2', 'BIG JJ Rojas', 933669945, NULL, NULL, NULL),
('8851644-3', 'Patoq', 945615920, NULL, NULL, NULL);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `arriendos`
--
ALTER TABLE `arriendos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `arriendos_rut_foreign` (`rut`),
  ADD KEY `arriendos_id_comic_foreign` (`id_comic`);

--
-- Indices de la tabla `comics`
--
ALTER TABLE `comics`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`);

--
-- Indices de la tabla `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`rut`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `arriendos`
--
ALTER TABLE `arriendos`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `comics`
--
ALTER TABLE `comics`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `arriendos`
--
ALTER TABLE `arriendos`
  ADD CONSTRAINT `arriendos_id_comic_foreign` FOREIGN KEY (`id_comic`) REFERENCES `comics` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `arriendos_rut_foreign` FOREIGN KEY (`rut`) REFERENCES `users` (`rut`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
