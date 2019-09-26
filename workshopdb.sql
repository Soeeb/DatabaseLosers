/*
 Navicat Premium Data Transfer

 Source Server         : MySQL
 Source Server Type    : MySQL
 Source Server Version : 50722
 Source Host           : localhost:3306
 Source Schema         : workshopdb

 Target Server Type    : MySQL
 Target Server Version : 50722
 File Encoding         : 65001

 Date: 27/09/2019 09:44:25
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for tblroles
-- ----------------------------
DROP TABLE IF EXISTS `tblroles`;
CREATE TABLE `tblroles`  (
  `RoleID` int(11) NOT NULL AUTO_INCREMENT,
  `Role` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`RoleID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tblroles
-- ----------------------------
INSERT INTO `tblroles` VALUES (1, 'admin');
INSERT INTO `tblroles` VALUES (2, 'teacher');
INSERT INTO `tblroles` VALUES (3, 'student');

-- ----------------------------
-- Table structure for tblusers
-- ----------------------------
DROP TABLE IF EXISTS `tblusers`;
CREATE TABLE `tblusers`  (
  `userId` int(11) NOT NULL AUTO_INCREMENT,
  `firstName` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `familyName` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `roleId` int(11) NULL DEFAULT NULL,
  `email` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `mobileNumber` int(11) NULL DEFAULT NULL,
  `username` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `password` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`userId`) USING BTREE,
  INDEX `roles`(`roleId`) USING BTREE,
  CONSTRAINT `roles` FOREIGN KEY (`roleId`) REFERENCES `tblroles` (`RoleID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tblusers
-- ----------------------------
INSERT INTO `tblusers` VALUES (1, 'Expert', 'Haxor', 1, 'admin@admin.admin', 1, 'admin', '21232f297a57a5a743894a0e4a801fc3');
INSERT INTO `tblusers` VALUES (2, 'Jared', 'Smith', 3, 'jared@student.co', 120130, 'jaredIsCool', '202cb962ac59075b964b07152d234b70');
INSERT INTO `tblusers` VALUES (3, 'Samuel', 'Jackson', 2, 'jackson@teacher.co', 123001230, 'coolCat', '202cb962ac59075b964b07152d234b70');
INSERT INTO `tblusers` VALUES (6, 'DANCE', 'dance', 3, 'danskemoblerkesjd@chair.com', 123, 'uwu', '202cb962ac59075b964b07152d234b70');

-- ----------------------------
-- Table structure for tblworkshopassign
-- ----------------------------
DROP TABLE IF EXISTS `tblworkshopassign`;
CREATE TABLE `tblworkshopassign`  (
  `assignId` int(11) NOT NULL AUTO_INCREMENT,
  `workshopId` int(11) NOT NULL,
  `userId` int(11) NOT NULL,
  PRIMARY KEY (`assignId`) USING BTREE,
  INDEX `workshop`(`workshopId`) USING BTREE,
  INDEX `user`(`userId`) USING BTREE,
  CONSTRAINT `user` FOREIGN KEY (`userId`) REFERENCES `tblusers` (`userId`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `workshop` FOREIGN KEY (`workshopId`) REFERENCES `tblworkshops` (`workshopId`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tblworkshopassign
-- ----------------------------
INSERT INTO `tblworkshopassign` VALUES (3, 1, 1);
INSERT INTO `tblworkshopassign` VALUES (4, 1, 1);
INSERT INTO `tblworkshopassign` VALUES (5, 1, 1);
INSERT INTO `tblworkshopassign` VALUES (6, 4, 1);
INSERT INTO `tblworkshopassign` VALUES (8, 2, 6);

-- ----------------------------
-- Table structure for tblworkshops
-- ----------------------------
DROP TABLE IF EXISTS `tblworkshops`;
CREATE TABLE `tblworkshops`  (
  `workshopId` int(11) NOT NULL AUTO_INCREMENT,
  `date` datetime(0) NULL DEFAULT NULL,
  `room` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `subject` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `teacherId` int(3) NULL DEFAULT NULL,
  `summary` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `maxStudents` int(255) NULL DEFAULT NULL,
  PRIMARY KEY (`workshopId`) USING BTREE,
  INDEX `teacherId`(`teacherId`) USING BTREE,
  CONSTRAINT `tblworkshops_ibfk_1` FOREIGN KEY (`teacherId`) REFERENCES `tblusers` (`userId`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tblworkshops
-- ----------------------------
INSERT INTO `tblworkshops` VALUES (1, '2019-07-25 09:09:50', '12B', 'Maths', 2, 'A quick breakdown of maths', 12);
INSERT INTO `tblworkshops` VALUES (2, '2019-07-31 14:33:50', '12A', 'engliush', 2, 'asda', 2);
INSERT INTO `tblworkshops` VALUES (3, '2019-08-14 14:34:17', '13A', 'asd', 2, 'asd', 11);
INSERT INTO `tblworkshops` VALUES (4, '2019-08-09 14:34:32', '14B', 'dsds', 2, 'sds', 1);
INSERT INTO `tblworkshops` VALUES (5, '2019-08-21 14:34:53', '15A', 'dghfh', 2, 'adsahg', 12);
INSERT INTO `tblworkshops` VALUES (6, '2019-08-28 14:34:56', '1B', 'fghgfh', 2, 'fghgfh', 12);
INSERT INTO `tblworkshops` VALUES (7, '2019-07-31 09:56:48', '5A', 'asdhtrh', 2, 'fhytrumh', 21);

SET FOREIGN_KEY_CHECKS = 1;
