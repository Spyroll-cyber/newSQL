-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Mar 22, 2024 at 06:53 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `carwashapp`
--

-- --------------------------------------------------------

--
-- Table structure for table `admin`
--

CREATE TABLE `admin` (
  `id` int(11) NOT NULL,
  `UserName` varchar(100) DEFAULT NULL,
  `Password` varchar(100) DEFAULT NULL,
  `updationDate` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `admin`
--

INSERT INTO `admin` (`id`, `UserName`, `Password`, `updationDate`) VALUES
(1, 'admin', '5f4dcc3b5aa765d61d8327deb882cf99', '2020-12-10 11:18:49');

-- --------------------------------------------------------

--
-- Table structure for table `payment`
--

CREATE TABLE `payment` (
  `id` int(11) NOT NULL,
  `Order_ID` int(11) DEFAULT NULL,
  `MerchantRequestID` varchar(255) DEFAULT NULL,
  `CheckoutRequestID` varchar(255) DEFAULT NULL,
  `ResultCode` int(11) DEFAULT NULL,
  `ResultDesc` varchar(255) DEFAULT NULL,
  `PhoneNumber` varchar(20) DEFAULT NULL,
  `Amount` decimal(10,2) DEFAULT NULL,
  `MpesaReceiptNumber` varchar(255) DEFAULT NULL,
  `TransactionDate` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `payment`
--

INSERT INTO `payment` (`id`, `Order_ID`, `MerchantRequestID`, `CheckoutRequestID`, `ResultCode`, `ResultDesc`, `PhoneNumber`, `Amount`, `MpesaReceiptNumber`, `TransactionDate`) VALUES
(1, 4597, 'c0d2-4b9a-a71a-12bae346ef6e451732', 'ws_CO_08032024191613079704813341', 0, 'The service request is processed successfully.', '254704813341', 1.00, 'SC87F8RPLB', '2024-03-08 19:17:16'),
(4, 316460298, 'c0d2-4b9a-a71a-12bae346ef6e451732', 'ws_CO_08032024191613079704813341', 0, 'The service request is processed successfully.', '254704813341', 1.00, 'SC87F8RPLB', '2024-03-08 19:17:16'),
(5, 440337019, 'c0d2-4b9a-a71a-12bae346ef6e451732', 'ws_CO_08032024191613079704813341', 0, 'The service request is processed successfully.', '254704813341', 1.00, 'SC87F8RPLB', '2024-03-08 19:17:16');

-- --------------------------------------------------------

--
-- Table structure for table `payment_status`
--

CREATE TABLE `payment_status` (
  `id` int(11) NOT NULL,
  `Order_ID` int(11) NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `payment_date` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `payment_status`
--

INSERT INTO `payment_status` (`id`, `Order_ID`, `amount`, `payment_date`) VALUES
(1, 783971257, 1.00, '2024-03-09 09:18:00'),
(2, 827062697, 1.00, '2024-03-09 09:27:16'),
(3, 2178, 1.00, '2024-03-09 09:28:06'),
(4, 743950623, 1.00, '2024-03-09 09:30:42'),
(5, 557460868, 2.00, '2024-03-09 09:39:36'),
(6, 462791364, 1.00, '2024-03-09 11:08:41'),
(7, 627731523, 1.00, '2024-03-09 11:08:41'),
(8, 1011, 1.00, '2024-03-09 11:41:04'),
(9, 1402, 2.00, '2024-03-09 11:49:37'),
(10, 2005, 1.00, '2024-03-10 17:26:56'),
(11, 641757453, 3.00, '2024-03-18 19:09:55'),
(12, 624363722, 3.00, '2024-03-18 19:09:55'),
(13, 926195438, 2.00, '2024-03-18 19:11:56');

--
-- Triggers `payment_status`
--
DELIMITER $$
CREATE TRIGGER `update_payment` AFTER INSERT ON `payment_status` FOR EACH ROW BEGIN
    UPDATE tblcarwashbooking
    SET paid = 'paid'
    WHERE bookingId = NEW.Order_ID;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `tblcarwashbooking`
--

CREATE TABLE `tblcarwashbooking` (
  `id` int(11) NOT NULL,
  `bookingId` bigint(20) DEFAULT NULL,
  `packageType` varchar(120) DEFAULT NULL,
  `carWashPoint` int(11) DEFAULT NULL,
  `fullName` varchar(150) DEFAULT NULL,
  `mobileNumber` bigint(20) DEFAULT NULL,
  `washDate` date DEFAULT NULL,
  `washTime` time DEFAULT NULL,
  `message` mediumtext DEFAULT NULL,
  `status` varchar(120) DEFAULT NULL,
  `adminRemark` mediumtext DEFAULT NULL,
  `paymentMode` varchar(120) DEFAULT NULL,
  `txnNumber` varchar(120) DEFAULT NULL,
  `postingDate` timestamp NULL DEFAULT current_timestamp(),
  `lastUpdationDate` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp(),
  `paid` varchar(10) DEFAULT 'NOT PAID'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `tblcarwashbooking`
--

INSERT INTO `tblcarwashbooking` (`id`, `bookingId`, `packageType`, `carWashPoint`, `fullName`, `mobileNumber`, `washDate`, `washTime`, `message`, `status`, `adminRemark`, `paymentMode`, `txnNumber`, `postingDate`, `lastUpdationDate`, `paid`) VALUES
(1, 316460298, '1', 1, 'ANuj kumar', 1234567890, '2021-12-16', '11:45:00', 'NA', 'Completed', 'Washing completed', 'e-Wallet', '345345345', '2021-12-13 19:14:22', '2024-03-09 07:19:28', 'paid'),
(2, 647869499, '3', 2, 'Anuj kumar', 1234567890, '2021-12-30', '15:47:00', 'na', 'New', NULL, NULL, NULL, '2021-12-13 19:14:47', '2021-12-14 17:20:56', 'NOT PAID'),
(3, 215755984, '2', 3, 'AMit', 9874563210, '2021-12-19', '15:05:00', 'NA', 'Completed', 'work done and payment succesful', 'UPI', '54632', '2021-12-13 19:16:19', '2024-03-09 12:36:57', 'NOT PAID'),
(4, 440337019, '1', 2, 'Sarita', 6987412360, '2022-01-01', '19:37:00', 'NA', 'Completed', 'well done job', 'UPI', '', '2021-12-14 17:01:55', '2024-03-09 07:35:47', 'paid'),
(5, 783971257, '2', 2, 'John Doe', 1234567890, '2021-12-25', '13:31:00', 'NA', 'Completed', 'done', 'UPI', '345', '2021-12-14 19:00:44', '2024-03-01 06:45:03', 'NOT PAID'),
(9, 827062697, '1', 2, 'blare', 713264598, '2024-02-14', '17:24:00', 'no message', 'Completed', 'good', 'UPI', '3445', '2024-02-12 14:22:32', '2024-03-09 12:38:32', 'paid'),
(10, 1195, '1', 2, 'blare', 713264598, '2024-03-21', '22:47:00', 'grtttttt', 'New', NULL, NULL, NULL, '2024-03-07 16:47:57', NULL, 'NOT PAID'),
(11, 2178, '2', 2, 'odhiambo geophrey', 713264598, '2024-03-14', '01:38:00', '', 'New', NULL, NULL, NULL, '2024-03-08 08:36:34', '2024-03-09 09:28:06', 'paid'),
(12, 116733675, '1', 1, 'fxhcgvh', 713264598, '2024-03-07', '11:42:00', '', 'New', NULL, NULL, NULL, '2024-03-08 08:40:10', NULL, 'NOT PAID'),
(13, 260837763, '1', 1, 'alex test', 704813341, '2024-03-13', '16:18:00', 'test', 'Completed', 'WORK WELL DONE', 'UPI', '', '2024-03-08 13:16:58', '2024-03-09 12:30:17', 'NOT PAID'),
(14, 563716230, '1', 1, 'blare', 704813341, '2024-03-08', '16:24:00', 'test', 'New', NULL, NULL, NULL, '2024-03-08 13:23:25', NULL, 'NOT PAID'),
(15, 789843273, '1', 1, 'blare', 254704813341, '2024-03-09', '16:30:00', 'test', 'New', NULL, NULL, NULL, '2024-03-08 13:28:30', NULL, 'NOT PAID'),
(16, 574806713, '1', 1, 'test2', 254704813341, '2024-03-07', '16:44:00', 'test2', 'Completed', 'done', 'UPI', '2005', '2024-03-08 13:42:31', '2024-03-10 17:28:28', 'NOT PAID'),
(17, 676882541, '1', 1, 'test payment', 254704813341, '2024-03-13', '19:22:00', 'test', 'Completed', 'compleletd', 'e-Wallet', '3445', '2024-03-08 16:21:33', '2024-03-14 10:10:59', 'NOT PAID'),
(18, 154827469, '1', 2, 'test payment', 254704813341, '2024-03-13', '19:22:00', 'test', 'New', NULL, NULL, NULL, '2024-03-08 16:31:25', NULL, 'NOT PAID'),
(19, 650197287, '1', 2, 'test payment', 254704813341, '2024-03-13', '19:22:00', 'test', 'New', NULL, NULL, NULL, '2024-03-08 16:36:48', NULL, 'NOT PAID'),
(20, 897022393, '1', 2, 'odhiambo geophrey', 254704813341, '2024-03-23', '19:53:00', '', 'New', NULL, NULL, NULL, '2024-03-08 16:53:34', NULL, 'NOT PAID'),
(21, 743950623, '1', 1, 'test q12', 254704813341, '2024-03-16', '12:33:00', 'testq12', 'New', NULL, NULL, NULL, '2024-03-09 09:30:41', '2024-03-09 09:30:42', 'paid'),
(22, 557460868, '2', 1, 'fxhcgvh', 254704813341, '2024-03-07', '12:41:00', '', 'New', NULL, NULL, NULL, '2024-03-09 09:39:34', '2024-03-09 09:39:36', 'paid'),
(23, 627731523, '1', 1, 'felix', 254718999503, '2024-03-02', '14:10:00', '', 'New', NULL, NULL, NULL, '2024-03-09 11:08:33', '2024-03-09 11:08:41', 'paid'),
(24, 462791364, '1', 1, 'felix', 254718999503, '2024-03-02', '14:10:00', '', 'New', NULL, NULL, NULL, '2024-03-09 11:08:36', '2024-03-09 11:08:41', 'paid'),
(25, 1011, '1', 2, 'odhiambo geophrey', 254718999503, '2024-03-22', '02:40:00', '', 'New', NULL, NULL, NULL, '2024-03-09 11:41:03', '2024-03-09 11:41:04', 'paid'),
(26, 1402, '2', 2, 'odhiambo geophrey2', 254718999503, '2024-03-01', '14:50:00', '', 'New', NULL, NULL, NULL, '2024-03-09 11:49:33', '2024-03-09 11:49:37', 'paid'),
(28, 610622097, '1', 1, 'session', 713264598, '2024-03-08', '00:43:00', '', 'New', NULL, NULL, NULL, '2024-03-15 09:39:41', NULL, 'NOT PAID'),
(29, 931777981, '2', 1, 'odhiambo geophrey', 713264598, '2024-03-08', '12:44:00', '', 'New', NULL, NULL, NULL, '2024-03-15 09:41:35', NULL, 'NOT PAID'),
(30, 854709736, '2', 1, 'odhiambo geophrey', 713264598, '2024-03-08', '12:44:00', '', 'New', NULL, NULL, NULL, '2024-03-15 09:42:42', NULL, 'NOT PAID'),
(31, 1747, '1', 2, 'xffff', 254718999503, '2024-03-19', '21:53:00', '', 'New', NULL, NULL, NULL, '2024-03-18 18:49:30', NULL, 'NOT PAID'),
(32, 624363722, '3 ', 3, 'hjkkk', 254718999503, '2024-03-14', '22:13:00', '', 'New', NULL, NULL, NULL, '2024-03-18 19:09:49', '2024-03-18 19:09:55', 'paid'),
(33, 641757453, '3 ', 3, 'hjkkk', 254718999503, '2024-03-14', '22:13:00', '', 'New', NULL, NULL, NULL, '2024-03-18 19:09:52', '2024-03-18 19:09:55', 'paid'),
(34, 926195438, '2', 2, 'hjjjjj', 254718999503, '2024-03-30', '22:14:00', '', 'New', NULL, NULL, NULL, '2024-03-18 19:11:54', '2024-03-18 19:11:56', 'paid'),
(35, 554696071, '3 ', 2, 'odhiambo geophrey', 254718999503, '2024-03-08', '08:49:00', '', 'New', NULL, NULL, NULL, '2024-03-22 05:46:30', NULL, 'NOT PAID');

-- --------------------------------------------------------

--
-- Table structure for table `tblenquiry`
--

CREATE TABLE `tblenquiry` (
  `id` int(11) NOT NULL,
  `FullName` varchar(100) DEFAULT NULL,
  `EmailId` varchar(100) DEFAULT NULL,
  `Subject` varchar(100) DEFAULT NULL,
  `Description` mediumtext DEFAULT NULL,
  `PostingDate` timestamp NULL DEFAULT current_timestamp(),
  `Status` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `tblenquiry`
--

INSERT INTO `tblenquiry` (`id`, `FullName`, `EmailId`, `Subject`, `Description`, `PostingDate`, `Status`) VALUES
(4, 'Anuj kumar', 'anuj@gmail.com', 'General Enquiry', 'I want to know the price of car wash', '2021-12-13 18:27:53', 1),
(5, 'Amit', 'amit@gmail.com', 'Test', 'Test', '2021-12-14 19:14:22', 1);

-- --------------------------------------------------------

--
-- Table structure for table `tblpages`
--

CREATE TABLE `tblpages` (
  `id` int(11) NOT NULL,
  `type` varchar(255) DEFAULT '',
  `detail` longtext DEFAULT NULL,
  `openignHrs` varchar(255) DEFAULT NULL,
  `phoneNumber` bigint(20) DEFAULT NULL,
  `emailId` varchar(120) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `tblpages`
--

INSERT INTO `tblpages` (`id`, `type`, `detail`, `openignHrs`, `phoneNumber`, `emailId`) VALUES
(3, 'aboutus', '																																								<div style=\"text-align: justify;\"><span style=\"color: rgb(0, 0, 0); font-family: Georgia; font-size: 15px;\">CAr Wash Management System is a brand which is literally going to change the way people think about car cleaning. It is a unique mechanized car cleaning concept where cars are getting pampered by the latest equipments including high pressure cleaning machines, spray injection and extraction machines, high powered vacuum cleaners, steam cleaners and so on.</span></div><div style=\"text-align: justify;\"><span style=\"color: rgb(0, 0, 0); font-family: Georgia; font-size: 15px;\"><br></span></div><div style=\"text-align: justify;\"><span style=\"color: rgb(0, 0, 0); font-family: Georgia; font-size: 15px;\">Car Wash&nbsp; Management System is a brand that is literally going to change the way people think about car cleaning. It is a unique mechanized car cleaning concept where cars are getting pampered by the latest equipments including high pressure cleaning machines, spray injection and extraction machines, high powered vacuum cleaners, steam cleaners and so on.&nbsp;</span><br></div><div></div>\r\n										\r\n										\r\n										\r\n										', NULL, NULL, NULL),
(11, 'contact', '123 Street, mombasa,nairobi, Kenya', 'Mon - Fri, 8:00 AM - 9:00 PM', 718999503, 'chagatifelix@gmail.com');

-- --------------------------------------------------------

--
-- Table structure for table `tblwashingpoints`
--

CREATE TABLE `tblwashingpoints` (
  `id` int(11) NOT NULL,
  `washingPointName` varchar(255) DEFAULT NULL,
  `washingPointAddress` varchar(255) DEFAULT NULL,
  `contactNumber` bigint(20) DEFAULT NULL,
  `creationDate` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `tblwashingpoints`
--

INSERT INTO `tblwashingpoints` (`id`, `washingPointName`, `washingPointAddress`, `contactNumber`, `creationDate`) VALUES
(1, 'kibaoni Car Washing Point', 'pwani universityb', 718999503, '2021-12-13 16:21:20'),
(2, 'misufini c Car Washing Point', 'misufini centre,kilifi', 718999503, '2021-12-13 16:22:38'),
(3, ' Mnarani Car washing Point ', 'kilifi', 718999503, '2021-12-13 16:24:28');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `email_verified_at`, `password`, `remember_token`, `created_at`, `updated_at`) VALUES
(3, 'Admin', 'admin@gmail.com', NULL, '5f4dcc3b5aa765d61d8327deb882cf99', NULL, NULL, NULL),
(9, 'dan', 'dan@yahoo.com', NULL, '9180b4da3f0c7e80975fad685f7f134e', NULL, NULL, NULL),
(10, 'BLARE', 'eddy@gmail.com', NULL, '81dc9bdb52d04dc20036dbd8313ed055', NULL, NULL, NULL),
(11, 'joe', 'joe@gmail.com', NULL, '81dc9bdb52d04dc20036dbd8313ed055', NULL, NULL, NULL),
(12, 'javan', 'javan@gmail.com', NULL, '81dc9bdb52d04dc20036dbd8313ed055', NULL, NULL, NULL),
(13, 'aston', 'aston@gmail.com', NULL, '6796ebbb111298d042de1a20a7b9b6eb', NULL, NULL, NULL),
(14, 'BLARE', 'blare@gmail.com', NULL, '81dc9bdb52d04dc20036dbd8313ed055', NULL, NULL, NULL),
(15, 'yoo', 'yoo@gmail.com', NULL, '81dc9bdb52d04dc20036dbd8313ed055', NULL, NULL, NULL),
(16, 'fsdd', 'gan@gmail.com', NULL, '81dc9bdb52d04dc20036dbd8313ed055', NULL, NULL, NULL),
(17, 'dshsg', 'ben@gmail.com', NULL, '19517e6a43e3c76ced8e3c9ec6447b4f', NULL, NULL, NULL),
(18, 'Felix owin', 'gana@gmail.com', NULL, '827ccb0eea8a706c4c34a16891f84e7b', NULL, NULL, NULL),
(19, 'sjjhj', 'ann@gmail.com', NULL, 'bb2495c2b8e05a7b27d14bdf986ec113', NULL, NULL, NULL),
(20, 'fdf', 'bec@gmail.com', NULL, '096c15e912a8a181c4ad54c3aae0be12', NULL, NULL, NULL),
(21, 'ghhjj', 'bena@gmail.com', NULL, '4a7d1ed414474e4033ac29ccb8653d9b', NULL, NULL, NULL),
(22, 'bejjgdjj', 'jackson@gmail.com', NULL, 'b59c67bf196a4758191e42f76670ceba', NULL, NULL, NULL),
(23, 'test', 'alex@gmail.com', NULL, '81dc9bdb52d04dc20036dbd8313ed055', NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `washing_stations`
--

CREATE TABLE `washing_stations` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `latitude` decimal(10,8) NOT NULL,
  `longitude` decimal(11,8) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `washing_stations`
--

INSERT INTO `washing_stations` (`id`, `name`, `latitude`, `longitude`) VALUES
(1, 'Kibaoni washing station', -3.62098400, 39.84935800),
(2, 'Misufini washing station', -3.60696100, 39.84453400),
(3, 'Mnarani washing station', -3.64012500, 39.85076300);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `payment`
--
ALTER TABLE `payment`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `payment_status`
--
ALTER TABLE `payment_status`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tblcarwashbooking`
--
ALTER TABLE `tblcarwashbooking`
  ADD PRIMARY KEY (`id`),
  ADD KEY `carWashPoint` (`carWashPoint`);

--
-- Indexes for table `tblenquiry`
--
ALTER TABLE `tblenquiry`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tblpages`
--
ALTER TABLE `tblpages`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tblwashingpoints`
--
ALTER TABLE `tblwashingpoints`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- Indexes for table `washing_stations`
--
ALTER TABLE `washing_stations`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admin`
--
ALTER TABLE `admin`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `payment`
--
ALTER TABLE `payment`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `payment_status`
--
ALTER TABLE `payment_status`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `tblcarwashbooking`
--
ALTER TABLE `tblcarwashbooking`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=36;

--
-- AUTO_INCREMENT for table `tblenquiry`
--
ALTER TABLE `tblenquiry`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `tblpages`
--
ALTER TABLE `tblpages`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `tblwashingpoints`
--
ALTER TABLE `tblwashingpoints`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT for table `washing_stations`
--
ALTER TABLE `washing_stations`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `tblcarwashbooking`
--
ALTER TABLE `tblcarwashbooking`
  ADD CONSTRAINT `washingpointid` FOREIGN KEY (`carWashPoint`) REFERENCES `tblwashingpoints` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
