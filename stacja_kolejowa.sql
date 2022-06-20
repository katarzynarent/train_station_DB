-- phpMyAdmin SQL Dump
-- version 5.0.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Czas generowania: 20 Cze 2022, 12:22
-- Wersja serwera: 10.4.17-MariaDB
-- Wersja PHP: 8.0.2

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Baza danych: `stacja_kolejowa`
--

DELIMITER $$
--
-- Procedury
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `ile_jest_stacji` (OUT `ile` INT)  NO SQL
BEGIN
SELECT COUNT(*) FROM stacje 
INTO ile;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `najdluzszy_postoj_na_stacji` (OUT `najdluzszy_postoj` TIME)  NO SQL
BEGIN

SELECT TIMEDIFF(godzina_odjazdu, godzina_przyjazdu)
FROM perony p, przyjazdy, odjazdy, pociagi
WHERE p.id_peronu = przyjazdy.id_peronu &&
przyjazdy.pociag_nr = pociagi.id_pociagu &&
pociagi.id_pociagu = odjazdy.pociag_nr
ORDER BY TIMEDIFF(godzina_odjazdu, godzina_przyjazdu) DESC
LIMIT 1
INTO najdluzszy_postoj;

END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `logi`
--

CREATE TABLE `logi` (
  `id_l` int(6) NOT NULL,
  `operacja` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `czas` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Zrzut danych tabeli `logi`
--

INSERT INTO `logi` (`id_l`, `operacja`, `czas`) VALUES
(1, 'Dopisano rekord do tabeli poci', '2021-05-25 10:50:02'),
(2, 'Dopisano rekord do tabeli poci', '2021-05-25 10:50:02'),
(3, 'Dopisano rekord do tabeli poci', '2021-05-25 10:50:02'),
(4, 'Dopisano rekord do tabeli poci', '2021-05-25 10:50:02'),
(5, 'Dopisano rekord do tabeli poci', '2021-05-25 10:50:02'),
(6, 'Dopisano rekord do tabeli poci', '2021-05-25 10:50:02'),
(7, 'Dopisano rekord do tabeli poci', '2021-05-25 10:50:02'),
(8, 'Dopisano rekord do tabeli poci', '2021-05-25 10:50:02'),
(9, 'Dopisano rekord do tabeli poci', '2021-05-25 10:50:02'),
(10, 'Dopisano rekord do tabeli poci', '2021-05-25 10:50:02'),
(11, 'Dopisano rekord do tabeli poci', '2021-05-25 10:50:02'),
(12, 'Dopisano rekord do tabeli poci', '2021-05-25 10:50:02'),
(13, 'Dopisano rekord do tabeli poci', '2021-05-25 10:50:02'),
(14, 'Dopisano rekord do tabeli poci', '2021-05-25 10:50:02');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `odjazdy`
--

CREATE TABLE `odjazdy` (
  `id_odjazdu` int(6) NOT NULL,
  `pociag_nr` int(6) DEFAULT NULL,
  `godzina_odjazdu` time NOT NULL,
  `id_peronu` int(6) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Zrzut danych tabeli `odjazdy`
--

INSERT INTO `odjazdy` (`id_odjazdu`, `pociag_nr`, `godzina_odjazdu`, `id_peronu`) VALUES
(1, 5, '07:40:00', 3),
(2, 9, '08:55:00', 4),
(3, 11, '09:15:00', 8),
(4, 12, '09:54:00', 7),
(5, 4, '10:38:00', 3),
(6, 1, '11:08:00', 2),
(7, 6, '12:01:00', 1),
(8, 3, '12:59:00', 8),
(9, 2, '14:25:00', 6),
(10, 7, '15:10:00', 5),
(11, 10, '15:37:00', 4),
(12, 8, '17:57:00', 7),
(13, 13, '18:49:00', 1),
(14, 14, '20:10:00', 6);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `perony`
--

CREATE TABLE `perony` (
  `id_peronu` int(6) NOT NULL,
  `peron` char(6) COLLATE utf8_unicode_ci DEFAULT NULL,
  `tor` int(2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Zrzut danych tabeli `perony`
--

INSERT INTO `perony` (`id_peronu`, `peron`, `tor`) VALUES
(1, 'I', 7),
(2, 'I', 9),
(3, 'II', 1),
(4, 'II', 3),
(5, 'III', 2),
(6, 'III', 4),
(7, 'IV', 8),
(8, 'IV', 10);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `pociagi`
--

CREATE TABLE `pociagi` (
  `id_pociagu` int(6) NOT NULL,
  `numer` int(11) NOT NULL,
  `id_przewoznika` int(11) DEFAULT NULL,
  `nazwa` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ze_stacji` int(11) DEFAULT NULL,
  `do_stacji` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Zrzut danych tabeli `pociagi`
--

INSERT INTO `pociagi` (`id_pociagu`, `numer`, `id_przewoznika`, `nazwa`, `ze_stacji`, `do_stacji`) VALUES
(1, 40502, 2, 'S41', 6, 8),
(2, 3806, 3, 'Malczewski', 2, 11),
(3, 63104, 3, 'Kossak', 1, 4),
(4, 40655, 2, 'S1', 7, 3),
(5, 42902, 4, 'Trojan', 13, 9),
(6, 94703, 2, 'S5', 12, 17),
(7, 43302, 4, 'Hańba', 5, 4),
(8, 111, 3, 'Silesia', 15, 1),
(9, 94256, 2, 'Karlik', 7, 2),
(10, 36102, 1, 'Sudety', 1, 5),
(11, 4552, 1, 'Heweliusz', 10, 16),
(12, 42334, 3, 'Ostaniec', 1, 18),
(13, 3507, 3, 'Załuski', 11, 17),
(14, 45561, 4, 'Malaga', 8, 13);

--
-- Wyzwalacze `pociagi`
--
DELIMITER $$
CREATE TRIGGER `after_pociagi_insert` AFTER INSERT ON `pociagi` FOR EACH ROW BEGIN

insert into logi(operacja, czas)

VALUES ('Dopisano rekord do tabeli pociągi', now());

END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `przewoznicy`
--

CREATE TABLE `przewoznicy` (
  `id_przewoznika` int(11) NOT NULL,
  `kod_przewoznika` char(3) COLLATE utf8_unicode_ci NOT NULL,
  `nazwa` varchar(20) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Zrzut danych tabeli `przewoznicy`
--

INSERT INTO `przewoznicy` (`id_przewoznika`, `kod_przewoznika`, `nazwa`) VALUES
(1, 'TLK', 'Twoje Linie Kolejowe'),
(2, 'KS', 'Koleje Śląskie'),
(3, 'IC', 'InterCity'),
(4, 'R', 'InterRegio');

--
-- Wyzwalacze `przewoznicy`
--
DELIMITER $$
CREATE TRIGGER `before_przewoznicy_update` BEFORE UPDATE ON `przewoznicy` FOR EACH ROW BEGIN
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT = 'Nie można tu robić update';
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `przyjazdy`
--

CREATE TABLE `przyjazdy` (
  `id_przyjazdu` int(6) NOT NULL,
  `pociag_nr` int(6) DEFAULT NULL,
  `godzina_przyjazdu` time NOT NULL,
  `id_peronu` int(6) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Zrzut danych tabeli `przyjazdy`
--

INSERT INTO `przyjazdy` (`id_przyjazdu`, `pociag_nr`, `godzina_przyjazdu`, `id_peronu`) VALUES
(1, 5, '07:34:00', 3),
(2, 9, '08:45:00', 4),
(3, 11, '09:07:00', 8),
(4, 12, '09:50:00', 7),
(5, 4, '10:37:00', 3),
(6, 1, '11:03:00', 2),
(7, 6, '11:51:00', 1),
(8, 3, '12:37:00', 8),
(9, 2, '13:45:00', 6),
(10, 7, '14:40:00', 5),
(11, 10, '15:07:00', 4),
(12, 8, '17:47:00', 7),
(13, 13, '18:29:00', 1),
(14, 14, '19:58:00', 6);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `stacje`
--

CREATE TABLE `stacje` (
  `id_stacji` int(11) NOT NULL,
  `nazwa` varchar(30) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Zrzut danych tabeli `stacje`
--

INSERT INTO `stacje` (`id_stacji`, `nazwa`) VALUES
(1, 'Warszawa Wschodnia'),
(2, 'Oświęcim'),
(3, 'Częstochowa'),
(4, 'Kraków Główny'),
(5, 'Jelenia Góra'),
(6, 'Sosnowiec'),
(7, 'Gliwice'),
(8, 'Tychy Lodowisko'),
(9, 'Czechowice-Dziedzice'),
(10, 'Sosnowiec Główny'),
(11, 'Kołobrzeg'),
(12, 'Chałupki'),
(13, 'Kielce'),
(14, 'Zwardoń'),
(15, 'Kluczbork'),
(16, 'Gdynia Główna'),
(17, 'Żywiec'),
(18, 'Busko-Zdrój');

--
-- Indeksy dla zrzutów tabel
--

--
-- Indeksy dla tabeli `logi`
--
ALTER TABLE `logi`
  ADD PRIMARY KEY (`id_l`);

--
-- Indeksy dla tabeli `odjazdy`
--
ALTER TABLE `odjazdy`
  ADD PRIMARY KEY (`id_odjazdu`),
  ADD KEY `pociag_nr` (`pociag_nr`),
  ADD KEY `id_peronu` (`id_peronu`);

--
-- Indeksy dla tabeli `perony`
--
ALTER TABLE `perony`
  ADD PRIMARY KEY (`id_peronu`),
  ADD KEY `idx_nrperonu` (`peron`,`tor`);

--
-- Indeksy dla tabeli `pociagi`
--
ALTER TABLE `pociagi`
  ADD PRIMARY KEY (`id_pociagu`),
  ADD KEY `id_przewoznika` (`id_przewoznika`),
  ADD KEY `do_stacji` (`do_stacji`),
  ADD KEY `idx_nrpociagu` (`numer`),
  ADD KEY `idx_pstacji` (`ze_stacji`);

--
-- Indeksy dla tabeli `przewoznicy`
--
ALTER TABLE `przewoznicy`
  ADD PRIMARY KEY (`id_przewoznika`);

--
-- Indeksy dla tabeli `przyjazdy`
--
ALTER TABLE `przyjazdy`
  ADD PRIMARY KEY (`id_przyjazdu`),
  ADD KEY `pociag_nr` (`pociag_nr`),
  ADD KEY `id_peronu` (`id_peronu`);

--
-- Indeksy dla tabeli `stacje`
--
ALTER TABLE `stacje`
  ADD PRIMARY KEY (`id_stacji`),
  ADD KEY `idx_stacji` (`nazwa`(5));

--
-- AUTO_INCREMENT dla zrzuconych tabel
--

--
-- AUTO_INCREMENT dla tabeli `logi`
--
ALTER TABLE `logi`
  MODIFY `id_l` int(6) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT dla tabeli `odjazdy`
--
ALTER TABLE `odjazdy`
  MODIFY `id_odjazdu` int(6) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT dla tabeli `perony`
--
ALTER TABLE `perony`
  MODIFY `id_peronu` int(6) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT dla tabeli `pociagi`
--
ALTER TABLE `pociagi`
  MODIFY `id_pociagu` int(6) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT dla tabeli `przewoznicy`
--
ALTER TABLE `przewoznicy`
  MODIFY `id_przewoznika` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT dla tabeli `przyjazdy`
--
ALTER TABLE `przyjazdy`
  MODIFY `id_przyjazdu` int(6) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT dla tabeli `stacje`
--
ALTER TABLE `stacje`
  MODIFY `id_stacji` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- Ograniczenia dla zrzutów tabel
--

--
-- Ograniczenia dla tabeli `odjazdy`
--
ALTER TABLE `odjazdy`
  ADD CONSTRAINT `odjazdy_ibfk_1` FOREIGN KEY (`pociag_nr`) REFERENCES `pociagi` (`id_pociagu`),
  ADD CONSTRAINT `odjazdy_ibfk_2` FOREIGN KEY (`id_peronu`) REFERENCES `perony` (`id_peronu`);

--
-- Ograniczenia dla tabeli `pociagi`
--
ALTER TABLE `pociagi`
  ADD CONSTRAINT `pociagi_ibfk_1` FOREIGN KEY (`id_przewoznika`) REFERENCES `przewoznicy` (`id_przewoznika`),
  ADD CONSTRAINT `pociagi_ibfk_2` FOREIGN KEY (`ze_stacji`) REFERENCES `stacje` (`id_stacji`),
  ADD CONSTRAINT `pociagi_ibfk_3` FOREIGN KEY (`do_stacji`) REFERENCES `stacje` (`id_stacji`);

--
-- Ograniczenia dla tabeli `przyjazdy`
--
ALTER TABLE `przyjazdy`
  ADD CONSTRAINT `przyjazdy_ibfk_1` FOREIGN KEY (`pociag_nr`) REFERENCES `pociagi` (`id_pociagu`),
  ADD CONSTRAINT `przyjazdy_ibfk_2` FOREIGN KEY (`id_peronu`) REFERENCES `perony` (`id_peronu`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
