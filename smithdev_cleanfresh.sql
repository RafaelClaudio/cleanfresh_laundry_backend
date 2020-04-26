-- phpMyAdmin SQL Dump
-- version 4.9.4
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Apr 25, 2020 at 10:33 PM
-- Server version: 10.3.22-MariaDB
-- PHP Version: 7.3.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `smithdev_cleanfresh`
--

-- --------------------------------------------------------

--
-- Table structure for table `data_employee`
--

CREATE TABLE `data_employee` (
  `id` int(10) NOT NULL,
  `name` varchar(100) NOT NULL,
  `phone` varchar(15) NOT NULL,
  `email` varchar(50) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `gender` varchar(30) NOT NULL,
  `api_token` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `data_employee`
--

INSERT INTO `data_employee` (`id`, `name`, `phone`, `email`, `username`, `password`, `gender`, `api_token`) VALUES
(1, 'Pande Employee', '08928372332', 'pradnyadarsana13@gmail.com', 'pande123', '12345', 'Male', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJJRCI6IjEiLCJ1c2VybmFtZSI6InBhbmRlMTIzIn0.TjFUZ6fviPwtR2O43IX-j_Ll-9KPbkFLLaevCdFqol8'),
(2, 'Meichella', '0182783912', 'meichella4599@gmail.com', 'meichella123', '1234', 'Female', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJJRCI6IjIiLCJ1c2VybmFtZSI6Im1laWNoZWxsYTEyMyJ9.kqaLHPz_vd3PgLjSuFBqqXk0J9XQr5pv-yLd5riXqQI');

-- --------------------------------------------------------

--
-- Table structure for table `data_order`
--

CREATE TABLE `data_order` (
  `id` int(10) NOT NULL,
  `username` varchar(50) NOT NULL,
  `phone` varchar(15) NOT NULL,
  `address` varchar(100) NOT NULL,
  `price_cat` varchar(50) NOT NULL,
  `weight` int(50) NOT NULL,
  `price` int(50) NOT NULL,
  `status` varchar(50) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `data_order`
--

INSERT INTO `data_order` (`id`, `username`, `phone`, `address`, `price_cat`, `weight`, `price`, `status`, `created_at`) VALUES
(14, 'pradnyadarsana', '0128312832', 'jalan sesama', 'SlowButSure', 7, 28000, 'Unprocessed', '2019-11-20 19:18:02'),
(15, 'pradnyadarsana', '08213872321', 'jalan seturan raya 3', 'SlowButSure', 2, 8000, 'Unprocessed', '2019-11-21 14:35:12'),
(16, 'pawlaundry', '082173621821', 'jalan perumnas 3', 'Saving', 1, 3500, 'Unprocessed', '2019-11-21 14:57:02'),
(18, 'michael', '12345', 'asd', 'Express', 6, 36000, 'Unprocessed', '2019-11-24 06:01:49'),
(19, 'michael', '1234567', 'zxc', 'SlowButSure', 7, 28000, 'Unprocessed', '2019-11-24 06:08:23'),
(20, 'nando', '123', 'jalan halu', 'PROMAX', 2, 15000, 'Complete', '2019-11-24 07:53:42'),
(21, 'nando', '123', 'jalan galauuuuu', 'SlowButSure', 3, 12000, 'In Progress', '2019-11-24 07:53:58'),
(22, 'nando', '123', 'jalan stress', 'Express', 3, 18000, 'Unprocessed', '2019-11-24 07:54:13'),
(23, 'nando20', '12334343', 'babarsari', 'SlowButSure', 2, 8000, 'Complete', '2019-11-28 03:08:36'),
(26, 'pande', '12342423432', 'terusan suez', 'Saving', 3, 10500, 'Unprocessed', '2020-03-27 08:46:29'),
(27, 'pande', '12342423432', 'ikhd mantap', 'Saving', 2, 7000, 'Unprocessed', '2020-03-27 08:49:57'),
(28, 'pande', '12342423432', 'jalan merak', 'SlowButSure', 4, 16000, 'Unprocessed', '2020-03-27 14:24:28'),
(29, 'pande', '12342423432', 'palu', 'PROMAX', 2, 15000, 'Unprocessed', '2020-03-27 14:25:02'),
(30, 'pande', '12342423432', 'jl batu mejan', 'Express', 2, 12000, 'Unprocessed', '2020-03-30 11:37:42');

-- --------------------------------------------------------

--
-- Table structure for table `data_pricelist`
--

CREATE TABLE `data_pricelist` (
  `id` int(10) NOT NULL,
  `category` varchar(50) NOT NULL,
  `duration` int(10) NOT NULL,
  `price` int(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `data_pricelist`
--

INSERT INTO `data_pricelist` (`id`, `category`, `duration`, `price`) VALUES
(3, 'Express', 2, 6000),
(6, 'SlowButSure', 4, 4000),
(7, 'Saving', 5, 3500),
(8, 'PROMAX', 1, 7500),
(9, 'Kencang', 2, 100000000);

-- --------------------------------------------------------

--
-- Table structure for table `data_review`
--

CREATE TABLE `data_review` (
  `id` int(10) NOT NULL,
  `username` varchar(50) NOT NULL,
  `rate` int(10) NOT NULL,
  `category` varchar(50) NOT NULL,
  `description` varchar(256) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `data_review`
--

INSERT INTO `data_review` (`id`, `username`, `rate`, `category`, `description`, `created_at`) VALUES
(8, 'pradnyadarsana', 4, 'Duration', 'very fast, very very very fasttt!!!', '2019-11-21 14:36:01'),
(10, 'pradnyadarsana', 3, 'Duration', 'goodgoodgood', '2019-11-23 06:25:03'),
(11, 'michael', 4, 'Duration', 'That was good', '2019-11-24 06:02:41'),
(12, 'michael', 5, 'Packaging', 'Bagus parah Packingnya ', '2019-11-24 06:10:36'),
(14, 'nando', 5, 'Perfume Aroma', 'wanginya semerbak sampe 1 RT', '2019-11-24 07:55:24'),
(16, 'pande', 3, 'Service', 'test', '2020-04-02 04:49:39');

-- --------------------------------------------------------

--
-- Table structure for table `data_user`
--

CREATE TABLE `data_user` (
  `id` int(10) NOT NULL,
  `name` varchar(100) NOT NULL,
  `phone` varchar(15) NOT NULL,
  `email` varchar(50) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `gender` varchar(30) NOT NULL,
  `activation_status` int(10) NOT NULL,
  `verif_code` varchar(255) NOT NULL,
  `api_token` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `data_user`
--

INSERT INTO `data_user` (`id`, `name`, `phone`, `email`, `username`, `password`, `gender`, `activation_status`, `verif_code`, `api_token`) VALUES
(56, 'Pradnya Darsana', '08123912837', 'pradnyadarsana13@gmail.com', 'pradnyadarsana', '$2y$10$Iz6iDhqYaioPHtbz12U17e.OwOKFIxbcniMYvoYn7VgKc9Kp8mSGW', 'Male', 1, 'u243mfHh9jSPEkQNyWXo', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJJRCI6IjU2IiwidXNlcm5hbWUiOiJwcmFkbnlhZGFyc2FuYSJ9.3qvOaaNpAU-Pc2r3rBO3JbqC25FLDiWvlvmncSPQ74Q'),
(83, 'paw laundry', '08237263213', 'pawlaundry1@gmail.com', 'pawlaundry', '$2y$10$wZpUhhK9ASVxGHQCGha9oOcnRgrTUkUE5UJZf8zggfJ79b5HjvxAS', 'Male', 1, 'YrgQe8Wstau1Go7mhkwB', NULL),
(87, 'gusde', '085858657674', 'dwivekadananjaya16@gmail.com', 'dwivekadananjaya', '$2y$10$ykOE2RYDoTtdu/fitXgQE.Zy1N7ayBJCFVEoMAidynKih4XKbUNPW', 'Male', 1, 'KUEmLn6wa1jilDo8GqvJ', NULL),
(90, 'michaeljo', '1234567', 'michaeljo2511@gmail.com', 'michael', '$2y$10$MdAQ6I0Ux1HmAHmcNHkr4.4bMnpNUtq8rR9fX/BlwwueP2RzX.1bu', 'Male', 1, '8tg4VZ1qozpNdAjDcI2s', NULL),
(91, 'asd', '1234566', 'g0h4nzzz@gmail.com', 'asd', '$2y$10$fAcLN/mYUQ80C6DBbIngoujLeR/mVk4mFTlDLVLKz/crKJPXLWcQu', 'Male', 0, 'byl1HOoZtIvSr6aCQexk', NULL),
(94, 'nando123', '08392423', 'arnandobs@yahoo.com', 'nando20', '$2y$10$4mopb8SHzPIXyCekKn0aJ.KwKRzVGMbFRVbrFozxFOQGKyw1XLfH6', 'Female', 1, '4DBbs6X5cC1yTrjKxtzh', NULL),
(95, 'pande', '12342423432', 'qpwoeiqwp@asds.asda', 'pande', '$2y$10$h3betB07gBKncAyfPj.RmO7JjDAAH4hvxRf/04ARvL160RsZ3hNcC', 'Male', 1, 'rWD71Y3gjfHtzIlPhUEm', NULL),
(96, 'edi', '078975864', '213423ewrwer@adasd.tyur', 'edi', '$2y$10$MpXLTD16UYdtH8DoRyamkuX8Jf/xklciVnsEPdg1wUQ4klaWueqdu', 'Female', 0, 'ZyOeD7fMCsUHo3EdgpjX', NULL),
(97, 'adi', '09213812', 'asjdkasd@asdfaf.fgh', 'adi', '$2y$10$pofW9e2eKkX.npzTRLAtLevJEzgdeA7A.0DnmavhJeR57Nx1duXhW', 'Female', 0, 'HMZhxFseBm5QkItrVgUE', NULL),
(102, 'koming', '019273182', 'komink_pande@yahoo.com', 'koming', '$2y$10$iVYgAvH2vabMGDrq1r9lROPUJYX39jmS95o00SXbO5LrTxBoKn0FK', 'Male', 1, 'hCO6rNUSPeDH9zIjg7Ri', NULL),
(103, 'mek', '9923232', 'jackfrans11@gmail.com', 'meki', '$2y$10$GYo5MEDouNQyDhQjtSLAC.RDPgtvuZnp5dWeUltX8LF3IO8wp9Xyi', 'Male', 0, 'PJde3jpuyK6GC5m1wLYN', NULL);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `data_employee`
--
ALTER TABLE `data_employee`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`,`username`);

--
-- Indexes for table `data_order`
--
ALTER TABLE `data_order`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `data_pricelist`
--
ALTER TABLE `data_pricelist`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `nama_paket` (`category`);

--
-- Indexes for table `data_review`
--
ALTER TABLE `data_review`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `data_user`
--
ALTER TABLE `data_user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`,`username`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `data_employee`
--
ALTER TABLE `data_employee`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `data_order`
--
ALTER TABLE `data_order`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT for table `data_pricelist`
--
ALTER TABLE `data_pricelist`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `data_review`
--
ALTER TABLE `data_review`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `data_user`
--
ALTER TABLE `data_user`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=104;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
