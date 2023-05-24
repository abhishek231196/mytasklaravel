-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: May 24, 2023 at 06:41 PM
-- Server version: 8.0.31
-- PHP Version: 7.4.33

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `mytask`
--

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

DROP TABLE IF EXISTS `failed_jobs`;
CREATE TABLE IF NOT EXISTS `failed_jobs` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `uuid` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

DROP TABLE IF EXISTS `migrations`;
CREATE TABLE IF NOT EXISTS `migrations` (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `migration` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2014_10_12_000000_create_users_table', 1),
(2, '2014_10_12_100000_create_password_resets_table', 1),
(3, '2019_08_19_000000_create_failed_jobs_table', 1),
(4, '2023_05_24_153324_create_project_master', 1),
(5, '2023_05_24_155246_create_transaction_history', 2);

-- --------------------------------------------------------

--
-- Table structure for table `password_resets`
--

DROP TABLE IF EXISTS `password_resets`;
CREATE TABLE IF NOT EXISTS `password_resets` (
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  KEY `password_resets_email_index` (`email`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `project_masters`
--

DROP TABLE IF EXISTS `project_masters`;
CREATE TABLE IF NOT EXISTS `project_masters` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `booking_amount` double NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `project_masters`
--

INSERT INTO `project_masters` (`id`, `name`, `booking_amount`, `created_at`, `updated_at`) VALUES
(1, 'Project1', 500000, '2023-05-24 16:12:36', '2023-05-24 16:12:36'),
(2, 'Project2', 700000, '2023-05-24 16:12:36', '2023-05-24 16:12:36'),
(3, 'Project3', 800000, '2023-05-24 16:12:36', '2023-05-24 16:12:36'),
(4, 'Project4', 100000, '2023-05-24 16:12:36', '2023-05-24 16:12:36');

-- --------------------------------------------------------

--
-- Table structure for table `transaction_histories`
--

DROP TABLE IF EXISTS `transaction_histories`;
CREATE TABLE IF NOT EXISTS `transaction_histories` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `project_id` bigint NOT NULL,
  `from_account_no` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `to_account_no` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `transaction_amount` double NOT NULL,
  `transaction_date` date NOT NULL,
  `opening_balance` double NOT NULL,
  `closing_balance` double NOT NULL,
  `payment_status` enum('A','P','R') COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `transaction_history_project_id_index` (`project_id`)
) ENGINE=MyISAM AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `transaction_histories`
--

INSERT INTO `transaction_histories` (`id`, `project_id`, `from_account_no`, `to_account_no`, `transaction_amount`, `transaction_date`, `opening_balance`, `closing_balance`, `payment_status`, `created_at`, `updated_at`) VALUES
(1, 1, '8944445488', '111111111111', 50000, '2023-05-24', 0, 50000, 'A', '2023-05-24 11:27:40', '2023-05-24 11:27:40'),
(2, 1, '8944445488', '111111111111', 50000, '2023-05-24', 50000, 100000, 'A', '2023-05-24 11:28:16', '2023-05-24 11:37:58'),
(3, 1, '8944445488', '111111111111', 70000, '2023-05-24', 100000, 170000, 'A', '2023-05-24 12:23:00', '2023-05-24 12:23:33'),
(4, 1, '8944445488', '111111111111', 23000, '2023-05-24', 170000, 193000, 'A', '2023-05-24 12:24:59', '2023-05-24 12:27:43'),
(5, 1, '8944445488', '111111111111', 25000, '2023-05-24', 193000, 218000, 'A', '2023-05-24 12:25:06', '2023-05-24 12:27:44'),
(6, 1, '8944445488', '111111111111', 30000, '2023-05-24', 218000, 248000, 'A', '2023-05-24 12:25:11', '2023-05-24 12:27:44'),
(7, 1, '8944445488', '111111111111', 40000, '2023-05-24', 248000, 288000, 'A', '2023-05-24 12:25:16', '2023-05-24 12:27:44'),
(8, 2, '8944445488', '111111111111', 40000, '2023-05-24', 288000, 328000, 'A', '2023-05-24 12:28:19', '2023-05-24 12:28:56'),
(9, 3, '8944445488', '111111111111', 40000, '2023-05-24', 328000, 368000, 'A', '2023-05-24 12:28:24', '2023-05-24 12:29:12'),
(10, 4, '8944445488', '111111111111', 40000, '2023-05-24', 368000, 408000, 'A', '2023-05-24 12:28:37', '2023-05-24 12:29:27');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
