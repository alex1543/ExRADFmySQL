CREATE DATABASE IF NOT EXISTS test;
USE test;

CREATE TABLE `files` (
  `id_file` int(11) NOT NULL,
  `id_my` int(11) NOT NULL,
  `description` text NOT NULL,
  `name_origin` text NOT NULL,
  `path` text NOT NULL,
  `date_upload` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=cp1251;


CREATE TABLE `myarttable` (
  `id` int(11) NOT NULL,
  `text` text NOT NULL,
  `description` text NOT NULL,
  `keywords` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=cp1251;


INSERT INTO `myarttable` (`id`, `text`, `description`, `keywords`) VALUES
(15, 'at1', 'at2', 'at3'),
(16, 'Name1', 'Desc.', 'key1, 2 ...'),
(17, 'Name1', 'Desc.', 'key1, 2 ...'),
(18, 'Name1', 'Desc.', 'key1, 2 ...'),
(19, 'Name1', 'Desc.', 'key1, 2 ...'),
(20, 'Иванов', 'сантехник', '4-й раз.'),
(21, 'Лифанов', 'электрик', '5-й раз.'),
(22, 'Субботин', 'программист', '2-й кат.');

ALTER TABLE `files`
  ADD PRIMARY KEY (`id_file`),
  ADD KEY `id_my` (`id_my`);

ALTER TABLE `myarttable`
  ADD PRIMARY KEY (`id`);


ALTER TABLE `files`
  MODIFY `id_file` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;


ALTER TABLE `myarttable`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- Ограничения внешнего ключа таблицы `files`
--
ALTER TABLE `files`
  ADD CONSTRAINT `files_ibfk_1` FOREIGN KEY (`id_my`) REFERENCES `myarttable` (`id`);
COMMIT;

