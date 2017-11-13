CREATE DATABASE `mysns` /*!40100 DEFAULT CHARACTER SET utf8 */;
CREATE TABLE `s_member` (
  `uid` varchar(10) NOT NULL,
  `name` varchar(15) NOT NULL,
  `password` varchar(12) NOT NULL,
  `email` varchar(45) DEFAULT NULL,
  `date` date NOT NULL,
  PRIMARY KEY (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `s_message` (
  `mid` int(11) NOT NULL AUTO_INCREMENT,
  `uid` varchar(15) NOT NULL,
  `msg` varchar(100) NOT NULL,
  `favcount` int(11) DEFAULT '0',
  `replycount` int(11) DEFAULT '0',
  `date` datetime NOT NULL,
  `s_member_uid` varchar(10) NOT NULL,
  PRIMARY KEY (`mid`),
  KEY `fk_s_message_s_member1_idx` (`s_member_uid`),
  CONSTRAINT `fk_s_message_s_member1` FOREIGN KEY (`s_member_uid`) REFERENCES `s_member` (`uid`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `s_reply` (
  `rid` int(11) NOT NULL AUTO_INCREMENT,
  `mid` int(11) NOT NULL,
  `uid` varchar(12) NOT NULL,
  `date` datetime NOT NULL,
  `rmsg` varchar(50) NOT NULL,
  `message_FK_idx` int(11) NOT NULL,
  PRIMARY KEY (`rid`),
  KEY `message_FK_idx` (`message_FK_idx`),
  CONSTRAINT `fk_s_reply_s_message` FOREIGN KEY (`message_FK_idx`) REFERENCES `s_message` (`mid`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
