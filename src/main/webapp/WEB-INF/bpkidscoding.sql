-- phpMyAdmin SQL Dump
-- version 4.6.6deb5
-- https://www.phpmyadmin.net/
--
-- 主機: localhost:3306
-- 產生時間： 2019 年 08 月 04 日 21:53
-- 伺服器版本: 5.7.26-0ubuntu0.18.04.1
-- PHP 版本： 7.2.17-0ubuntu0.18.04.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- 資料庫： `bpkidscoding`
--
CREATE DATABASE IF NOT EXISTS `bpkidscoding` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE `bpkidscoding`;

-- --------------------------------------------------------

--
-- 資料表結構 `characters`
--

DROP TABLE IF EXISTS `characters`;
CREATE TABLE `characters` (
  `ID` int(11) NOT NULL,
  `STORY` varchar(255) DEFAULT NULL,
  `CONTENT` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 資料表新增前先清除舊資料 `characters`
--

TRUNCATE TABLE `characters`;
--
-- 資料表的匯出資料 `characters`
--

INSERT INTO `characters` (`ID`, `STORY`, `CONTENT`) VALUES
(1, '1', '{ \"time\": 1563781369246, \"blocks\": [{ \"type\": \"characterQuote\", \"data\": { \"character\": \"test2\", \"message\": \"111\" } }], \"version\": \"2.15.0\" }');

-- --------------------------------------------------------

--
-- 資料表結構 `story`
--

DROP TABLE IF EXISTS `story`;
CREATE TABLE `story` (
  `ID` varchar(255) NOT NULL,
  `AUTHOR` int(11) DEFAULT NULL,
  `CREATED_DATE` varchar(8) DEFAULT NULL,
  `LAST_EDITED_DATE` varchar(8) DEFAULT NULL,
  `TITLE` varchar(255) DEFAULT NULL,
  `SUMMARY` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 資料表新增前先清除舊資料 `story`
--

TRUNCATE TABLE `story`;
--
-- 資料表的匯出資料 `story`
--

INSERT INTO `story` (`ID`, `AUTHOR`, `CREATED_DATE`, `LAST_EDITED_DATE`, `TITLE`, `SUMMARY`) VALUES
('1', 1, '20190101', '20190101', 'Super Monkey', 'summary');

-- --------------------------------------------------------

--
-- 資料表結構 `storycontent`
--

DROP TABLE IF EXISTS `storycontent`;
CREATE TABLE `storycontent` (
  `ID` int(11) NOT NULL,
  `STORY` varchar(255) DEFAULT NULL,
  `PAGE` int(11) DEFAULT NULL,
  `CONTENT` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 資料表新增前先清除舊資料 `storycontent`
--

TRUNCATE TABLE `storycontent`;
--
-- 資料表的匯出資料 `storycontent`
--

INSERT INTO `storycontent` (`ID`, `STORY`, `PAGE`, `CONTENT`) VALUES
(1, '1', 0, '{ \"time\": 1563781369246, \"blocks\": [{ \"type\": \"characterQuote\", \"data\": { \"character\": \"test2\", \"message\": \"111\" } }, { \"type\": \"os\", \"data\": { \"message\": \"12121\" } }, { \"type\": \"separator\", \"data\": {} }], \"version\": \"2.15.0\" }'),
(2, '1', 1, '{ \"time\": 1563781369246, \"blocks\": [{ \"type\": \"characterQuote\", \"data\": { \"character\": \"test2\", \"message\": \"111\" } }, { \"type\": \"os\", \"data\": { \"message\": \"12121\" } }, { \"type\": \"separator\", \"data\": {} }], \"version\": \"2.15.0\" }'),
(3, '1', 2, '{ \"time\": 1563781369246, \"blocks\": [{ \"type\": \"characterQuote\", \"data\": { \"character\": \"test2\", \"message\": \"113\" } }, { \"type\": \"os\", \"data\": { \"message\": \"12121\" } }, { \"type\": \"separator\", \"data\": {} }], \"version\": \"2.15.0\" }');

-- --------------------------------------------------------

--
-- 資料表結構 `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `ID` int(11) NOT NULL,
  `USER_ID` varchar(255) DEFAULT NULL,
  `EMAIL` varchar(255) DEFAULT NULL,
  `JOIN_DATE` varchar(8) DEFAULT NULL,
  `LAST_LOGIN` varchar(8) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 資料表新增前先清除舊資料 `users`
--

TRUNCATE TABLE `users`;
--
-- 資料表的匯出資料 `users`
--

INSERT INTO `users` (`ID`, `USER_ID`, `EMAIL`, `JOIN_DATE`, `LAST_LOGIN`) VALUES
(1, 'lendle', 'lendle.tseng@gmail.com', '20190101', '20190101');

--
-- 已匯出資料表的索引
--

--
-- 資料表索引 `characters`
--
ALTER TABLE `characters`
  ADD PRIMARY KEY (`ID`);

--
-- 資料表索引 `story`
--
ALTER TABLE `story`
  ADD PRIMARY KEY (`ID`);

--
-- 資料表索引 `storycontent`
--
ALTER TABLE `storycontent`
  ADD PRIMARY KEY (`ID`);

--
-- 資料表索引 `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`ID`);

--
-- 在匯出的資料表使用 AUTO_INCREMENT
--

--
-- 使用資料表 AUTO_INCREMENT `characters`
--
ALTER TABLE `characters`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;
--
-- 使用資料表 AUTO_INCREMENT `storycontent`
--
ALTER TABLE `storycontent`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- 使用資料表 AUTO_INCREMENT `users`
--
ALTER TABLE `users`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
