-- phpMyAdmin SQL Dump
-- version 3.0.1.1
-- http://www.phpmyadmin.net
--
-- 服务器版本: 5.1.29
-- PHP 版本: 5.2.6

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";

-- --------------------------------------------------------

-- ----------------------------
-- Table structure for `admin`
-- ----------------------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin` (
  `username` varchar(20) NOT NULL DEFAULT '',
  `password` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_admin
-- ----------------------------
INSERT INTO `admin` VALUES ('a', 'a'); 

CREATE TABLE IF NOT EXISTS `t_userInfo` (
  `user_name` varchar(30)  NOT NULL COMMENT 'user_name',
  `password` varchar(30)  NOT NULL COMMENT '登录密码',
  `name` varchar(20)  NOT NULL COMMENT '姓名',
  `gender` varchar(4)  NOT NULL COMMENT '性别',
  `birthDate` varchar(20)  NULL COMMENT '出生日期',
  `userPhoto` varchar(60)  NOT NULL COMMENT '用户照片',
  `telephone` varchar(20)  NOT NULL COMMENT '联系电话',
  `email` varchar(50)  NOT NULL COMMENT '邮箱',
  `address` varchar(80)  NULL COMMENT '家庭地址',
  `regTime` varchar(20)  NULL COMMENT '注册时间',
  PRIMARY KEY (`user_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `t_jiaofei` (
  `jiaofeiId` int(11) NOT NULL AUTO_INCREMENT COMMENT '缴费id',
  `jiaofeiTypeObj` int(11) NOT NULL COMMENT '缴费类型',
  `jiaofeiName` varchar(20)  NOT NULL COMMENT '缴费名称',
  `jiaofeiMoney` float NOT NULL COMMENT '缴费金额',
  `userObj` varchar(30)  NOT NULL COMMENT '缴费学员',
  `jiaofeiTime` varchar(20)  NULL COMMENT '缴费时间',
  `jiaofeiMemo` varchar(800)  NULL COMMENT '缴费备注',
  PRIMARY KEY (`jiaofeiId`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

CREATE TABLE IF NOT EXISTS `t_jiaofeiType` (
  `typeId` int(11) NOT NULL AUTO_INCREMENT COMMENT '类型id',
  `typeName` varchar(20)  NOT NULL COMMENT '类型名称',
  PRIMARY KEY (`typeId`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

CREATE TABLE IF NOT EXISTS `t_coach` (
  `coachNo` varchar(30)  NOT NULL COMMENT 'coachNo',
  `name` varchar(20)  NOT NULL COMMENT '姓名',
  `gender` varchar(4)  NOT NULL COMMENT '性别',
  `birthDate` varchar(20)  NULL COMMENT '出生日期',
  `coachPhoto` varchar(60)  NOT NULL COMMENT '教练照片',
  `workYears` varchar(20)  NOT NULL COMMENT '工作经验',
  `telephone` varchar(20)  NOT NULL COMMENT '联系电话',
  `address` varchar(80)  NULL COMMENT '家庭地址',
  `coachDesc` varchar(8000)  NOT NULL COMMENT '教练介绍',
  PRIMARY KEY (`coachNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `t_exam` (
  `examId` int(11) NOT NULL AUTO_INCREMENT COMMENT '考试id',
  `examName` varchar(20)  NOT NULL COMMENT '考试名称',
  `kemu` varchar(20)  NOT NULL COMMENT '考试科目',
  `userObj` varchar(30)  NOT NULL COMMENT '考试学员',
  `examDate` varchar(20)  NULL COMMENT '考试日期',
  `startTime` varchar(20)  NOT NULL COMMENT '考试开始时间',
  `examPlace` varchar(20)  NOT NULL COMMENT '考试地点',
  `coachObj` varchar(30)  NOT NULL COMMENT '教练',
  `examMemo` varchar(800)  NULL COMMENT '考试备注',
  PRIMARY KEY (`examId`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

CREATE TABLE IF NOT EXISTS `t_leaveword` (
  `leaveWordId` int(11) NOT NULL AUTO_INCREMENT COMMENT '留言id',
  `leaveTitle` varchar(80)  NOT NULL COMMENT '留言标题',
  `leaveContent` varchar(2000)  NOT NULL COMMENT '留言内容',
  `userObj` varchar(30)  NOT NULL COMMENT '留言人',
  `leaveTime` varchar(20)  NULL COMMENT '留言时间',
  `replyContent` varchar(1000)  NULL COMMENT '管理回复',
  `replyTime` varchar(20)  NULL COMMENT '回复时间',
  PRIMARY KEY (`leaveWordId`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

CREATE TABLE IF NOT EXISTS `t_notice` (
  `noticeId` int(11) NOT NULL AUTO_INCREMENT COMMENT '公告id',
  `title` varchar(80)  NOT NULL COMMENT '标题',
  `content` varchar(5000)  NOT NULL COMMENT '公告内容',
  `publishDate` varchar(20)  NULL COMMENT '发布时间',
  PRIMARY KEY (`noticeId`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

ALTER TABLE t_jiaofei ADD CONSTRAINT FOREIGN KEY (jiaofeiTypeObj) REFERENCES t_jiaofeiType(typeId);
ALTER TABLE t_jiaofei ADD CONSTRAINT FOREIGN KEY (userObj) REFERENCES t_userInfo(user_name);
ALTER TABLE t_exam ADD CONSTRAINT FOREIGN KEY (userObj) REFERENCES t_userInfo(user_name);
ALTER TABLE t_exam ADD CONSTRAINT FOREIGN KEY (coachObj) REFERENCES t_coach(coachNo);
ALTER TABLE t_leaveword ADD CONSTRAINT FOREIGN KEY (userObj) REFERENCES t_userInfo(user_name);


