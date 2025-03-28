/*
 Navicat Premium Data Transfer

 Source Server         : 本地
 Source Server Type    : MySQL
 Source Server Version : 80041 (8.0.41)
 Source Host           : 127.0.0.1:3306
 Source Schema         : vpnmanager

 Target Server Type    : MySQL
 Target Server Version : 80041 (8.0.41)
 File Encoding         : 65001

 Date: 28/03/2025 21:23:17
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for casbin_rule
-- ----------------------------
DROP TABLE IF EXISTS `casbin_rule`;
CREATE TABLE `casbin_rule` (
  `ptype` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `v0` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `v1` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `v2` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `v3` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `v4` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `v5` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Records of casbin_rule
-- ----------------------------
BEGIN;
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', 'alice', 'data1', 'read', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', 'bob', 'data2', 'write', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', 'data2_admin', 'data2', 'read', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', 'data2_admin', 'data2', 'write', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('g', 'alice', 'data2_admin', '', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('g', '1', '1', '', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '9', '586', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '9', '475', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '9', '476', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '9', '477', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '9', '478', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '9', '479', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '9', '546', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '9', '547', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '9', '548', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '9', '549', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '9', '550', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '9', '551', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '9', '565', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '9', '566', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '9', '567', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '9', '568', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '9', '569', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '9', '570', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '9', '572', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '9', '573', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '9', '574', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '9', '575', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '9', '576', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '9', '608', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '9', '609', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '9', '610', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '9', '611', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '9', '612', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '9', '613', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '9', '588', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '9', '539', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '9', '540', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '9', '541', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '9', '542', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '9', '543', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '9', '544', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '9', '643', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '9', '644', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '9', '645', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '9', '646', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '9', '647', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '9', '655', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '9', '656', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '9', '657', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '9', '658', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '9', '659', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '9', '692', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '9', '622', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '9', '623', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '9', '624', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '9', '625', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '9', '626', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '9', '628', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '9', '629', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '9', '630', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '9', '631', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '9', '632', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '9', '633', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '9', '660', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '9', '481', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '9', '482', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '9', '483', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '9', '484', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '9', '485', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '9', '487', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '9', '488', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '9', '489', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '9', '490', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '9', '491', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '9', '637', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '9', '638', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '9', '639', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '9', '640', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '9', '641', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '9', '662', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '9', '663', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '9', '664', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '9', '665', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '9', '666', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '9', '584', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '9', '499', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '9', '500', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '9', '501', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '9', '502', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '9', '503', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '9', '504', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '9', '439', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '9', '440', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '9', '441', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '9', '442', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '9', '443', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '9', '506', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '9', '507', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '9', '508', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '9', '509', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '9', '510', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '9', '585', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '9', '512', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '9', '513', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '9', '514', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '9', '515', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '9', '516', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '9', '518', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '9', '519', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '9', '520', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '9', '521', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '9', '522', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '9', '523', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '9', '525', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '9', '526', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '9', '527', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '9', '528', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '9', '529', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '9', '530', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '9', '679', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '9', '674', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '9', '675', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '9', '676', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '9', '677', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '9', '678', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '9', '680', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '9', '681', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '9', '682', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '9', '683', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '9', '684', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '9', '589', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '9', '590', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '9', '591', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '9', '592', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '9', '593', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '9', '594', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '9', '596', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '9', '597', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '9', '598', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '9', '599', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '9', '600', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '9', '691', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '9', '40', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '9', '50', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '9', '51', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '9', '52', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '9', '53', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '9', '54', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '9', '26', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '9', '27', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '9', '29', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '9', '30', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '9', '31', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '9', '38', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '9', '61', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '9', '62', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '9', '39', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '9', '63', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '9', '64', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '9', '1', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '9', '686', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '9', '687', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '9', '688', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '9', '689', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '9', '690', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '9', '426', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '9', '427', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '9', '428', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '9', '429', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '9', '430', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '9', '431', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '9', '493', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '9', '494', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '9', '495', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '9', '496', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '9', '497', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '9', '86', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '9', '185', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '10', '586', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '10', '475', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '10', '476', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '10', '477', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '10', '478', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '10', '479', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '10', '546', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '10', '547', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '10', '548', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '10', '549', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '10', '550', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '10', '551', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '10', '565', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '10', '566', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '10', '567', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '10', '568', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '10', '569', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '10', '570', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '10', '572', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '10', '573', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '10', '574', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '10', '575', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '10', '576', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '10', '608', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '10', '609', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '10', '610', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '10', '611', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '10', '612', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '10', '613', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '10', '482', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '10', '483', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '10', '484', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '10', '485', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '10', '488', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '10', '489', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '10', '490', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '10', '491', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '10', '584', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '10', '499', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '10', '500', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '10', '501', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '10', '502', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '10', '503', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '10', '504', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '10', '439', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '10', '440', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '10', '441', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '10', '442', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '10', '443', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '10', '506', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '10', '507', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '10', '508', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '10', '509', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '10', '510', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '10', '679', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '10', '674', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '10', '675', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '10', '676', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '10', '677', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '10', '678', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '10', '680', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '10', '681', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '10', '682', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '10', '683', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '10', '684', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '10', '686', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '10', '687', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '10', '688', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '10', '689', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '10', '690', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '10', '426', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '10', '427', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '10', '428', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '10', '429', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '10', '430', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '10', '431', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '10', '493', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '10', '494', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '10', '495', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '10', '496', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '10', '497', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '10', '1', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '1', '588', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '1', '539', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '1', '540', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '1', '541', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '1', '542', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '1', '543', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '1', '544', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '1', '643', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '1', '644', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '1', '645', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '1', '646', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '1', '647', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '1', '660', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '1', '481', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '1', '482', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '1', '483', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '1', '484', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '1', '485', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '1', '493', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '1', '494', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '1', '495', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '1', '496', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '1', '497', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '1', '662', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '1', '663', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '1', '664', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '1', '665', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '1', '666', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '1', '691', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '1', '40', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '1', '50', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '1', '51', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '1', '52', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '1', '53', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '1', '54', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '1', '26', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '1', '27', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '1', '29', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '1', '30', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '1', '31', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '1', '38', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '1', '61', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '1', '62', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '1', '39', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '1', '63', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '1', '64', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '1', '86', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '1', '185', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '1', '75', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '1', '3', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '1', '34', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '1', '55', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '1', '36', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '1', '56', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '1', '57', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '1', '58', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '1', '59', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '1', '60', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '1', '5', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '1', '19', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '1', '20', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '1', '21', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '1', '22', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '1', '23', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '1', '24', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '1', '25', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '1', '6', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '1', '41', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '1', '42', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '1', '43', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '1', '8', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '1', '16', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '1', '17', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '1', '18', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '1', '76', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '1', '186', 'All', '', '', '');
INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES ('p', '1', '226', 'All', '', '', '');
COMMIT;

-- ----------------------------
-- Table structure for plugins_manage
-- ----------------------------
DROP TABLE IF EXISTS `plugins_manage`;
CREATE TABLE `plugins_manage` (
  `id` int unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `store_id` int DEFAULT NULL COMMENT '插件在商城中的id',
  `p_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '插件名称英文',
  `p_title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '插件名称',
  `p_description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '插件介绍',
  `p_auth` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '作者',
  `is_install` tinyint NOT NULL DEFAULT '0' COMMENT '是否安装',
  `status` tinyint NOT NULL DEFAULT '0' COMMENT '状态',
  `version` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '当前版本',
  `price` int unsigned NOT NULL DEFAULT '0' COMMENT '价格',
  `download_times` int unsigned NOT NULL DEFAULT '0' COMMENT '下载次数',
  `install_path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '安装路径（用于卸载）',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `storeIdUni` (`store_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='插件管理';

-- ----------------------------
-- Records of plugins_manage
-- ----------------------------
BEGIN;
INSERT INTO `plugins_manage` (`id`, `store_id`, `p_name`, `p_title`, `p_description`, `p_auth`, `is_install`, `status`, `version`, `price`, `download_times`, `install_path`) VALUES (34, 1, 'mail', '邮件发送', '邮件发送', 'demo01', 1, 1, '1.0.0', 1, 1248, 'plugins');
INSERT INTO `plugins_manage` (`id`, `store_id`, `p_name`, `p_title`, `p_description`, `p_auth`, `is_install`, `status`, `version`, `price`, `download_times`, `install_path`) VALUES (35, 2, 'wechat', '微信公众号', '微信小程序管理接口，包含关注回复、关键字回复、图文消息、素材管理、菜单管理等', 'demo01', 0, 0, '1.0.2', 1, 456, NULL);
INSERT INTO `plugins_manage` (`id`, `store_id`, `p_name`, `p_title`, `p_description`, `p_auth`, `is_install`, `status`, `version`, `price`, `download_times`, `install_path`) VALUES (36, 3, 'cms', 'cms管理系统', 'cms管理系统', 'gfast01', 0, 0, '3.2.8', 29900, 523, NULL);
INSERT INTO `plugins_manage` (`id`, `store_id`, `p_name`, `p_title`, `p_description`, `p_auth`, `is_install`, `status`, `version`, `price`, `download_times`, `install_path`) VALUES (37, 4, 'demo2', '免费测试', '666', 'demo01', 0, 0, '1.2', 0, 2, NULL);
INSERT INTO `plugins_manage` (`id`, `store_id`, `p_name`, `p_title`, `p_description`, `p_auth`, `is_install`, `status`, `version`, `price`, `download_times`, `install_path`) VALUES (38, 5, 'mail', '邮件发送', 'qq smtp邮件发送功能', 'wilgx0', 0, 0, '1.0.1', 1990, 113, NULL);
INSERT INTO `plugins_manage` (`id`, `store_id`, `p_name`, `p_title`, `p_description`, `p_auth`, `is_install`, `status`, `version`, `price`, `download_times`, `install_path`) VALUES (39, 6, 'wechat', '微信公众号', '微信小程序管理接口，包含关注回复、关键字回复、图文消息、素材管理、菜单管理等', 'gfast01', 0, 0, '1.0.1', 5900, 52, NULL);
INSERT INTO `plugins_manage` (`id`, `store_id`, `p_name`, `p_title`, `p_description`, `p_auth`, `is_install`, `status`, `version`, `price`, `download_times`, `install_path`) VALUES (40, 7, 'gencode', '代码生成', '代码生成功能完善，支持生成上传文件、图片及富文本编辑器功能', 'gfast01', 0, 0, '3.2.3', 19900, 397, NULL);
INSERT INTO `plugins_manage` (`id`, `store_id`, `p_name`, `p_title`, `p_description`, `p_auth`, `is_install`, `status`, `version`, `price`, `download_times`, `install_path`) VALUES (41, 8, 'im', '在线客服', '在线客服', 'wilgx0', 0, 0, '1.0.1', 9900, 22, NULL);
INSERT INTO `plugins_manage` (`id`, `store_id`, `p_name`, `p_title`, `p_description`, `p_auth`, `is_install`, `status`, `version`, `price`, `download_times`, `install_path`) VALUES (42, 9, 'doorkeeper', 'IP过滤', 'IP地址过滤，支持ipv4 ipv6 ,可设置访问ip白名单和黑名单', 'wilgx0', 0, 0, '1.0.1', 1990, 57, NULL);
INSERT INTO `plugins_manage` (`id`, `store_id`, `p_name`, `p_title`, `p_description`, `p_auth`, `is_install`, `status`, `version`, `price`, `download_times`, `install_path`) VALUES (43, 10, 'smsPlugin', '短信发送', '短信发送，支持网易云信、腾讯云、阿里云短信平台，可自定义配置。', 'wilgx0', 0, 0, '1.0.1', 1999, 42, NULL);
INSERT INTO `plugins_manage` (`id`, `store_id`, `p_name`, `p_title`, `p_description`, `p_auth`, `is_install`, `status`, `version`, `price`, `download_times`, `install_path`) VALUES (44, 11, 'wordFlow', '流程审批', '流程审批插件', 'gfast01', 0, 0, '1.0.1', 29900, 0, NULL);
INSERT INTO `plugins_manage` (`id`, `store_id`, `p_name`, `p_title`, `p_description`, `p_auth`, `is_install`, `status`, `version`, `price`, `download_times`, `install_path`) VALUES (45, 12, 'gfast-v3.2-donate', 'gfast-v3.2捐赠版', '基于全新Go Frame 2.3+Vue3+Element Plus开发的全栈前后端分离的管理系统', 'gfast01', 0, 0, '3.2.1', 6800, 80, NULL);
INSERT INTO `plugins_manage` (`id`, `store_id`, `p_name`, `p_title`, `p_description`, `p_auth`, `is_install`, `status`, `version`, `price`, `download_times`, `install_path`) VALUES (46, 13, 'gfast-v3.2-mandatep', 'gfast-v3.2-个人授权版', '基于全新Go Frame 2.3+Vue3+Element Plus开发的全栈前后端分离的管理系统', 'gfast01', 0, 0, '3.2.9', 29800, 488, NULL);
INSERT INTO `plugins_manage` (`id`, `store_id`, `p_name`, `p_title`, `p_description`, `p_auth`, `is_install`, `status`, `version`, `price`, `download_times`, `install_path`) VALUES (47, 14, 'gfast-v3.2-mandateu', 'gfast-v3.2-企业授权版', '基于全新Go Frame 2.3+Vue3+Element Plus开发的全栈前后端分离的管理系统', 'gfast01', 0, 0, '3.2.9', 58800, 175, NULL);
COMMIT;

-- ----------------------------
-- Table structure for sys_auth_rule
-- ----------------------------
DROP TABLE IF EXISTS `sys_auth_rule`;
CREATE TABLE `sys_auth_rule` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `pid` int unsigned NOT NULL DEFAULT '0' COMMENT '父ID',
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '规则名称',
  `title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '规则名称',
  `icon` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '图标',
  `condition` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '条件',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '备注',
  `menu_type` tinyint unsigned NOT NULL DEFAULT '0' COMMENT '类型 0目录 1菜单 2按钮',
  `weigh` int NOT NULL DEFAULT '0' COMMENT '权重',
  `status` tinyint unsigned NOT NULL DEFAULT '0' COMMENT '状态',
  `always_show` tinyint unsigned NOT NULL DEFAULT '0' COMMENT '显示状态',
  `path` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '路由地址',
  `jump_path` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '跳转路由',
  `component` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '组件路径',
  `is_frame` tinyint unsigned NOT NULL DEFAULT '0' COMMENT '是否外链 1是 0否',
  `module_type` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '所属模块',
  `model_id` int unsigned NOT NULL DEFAULT '0' COMMENT '模型ID',
  `created_at` datetime DEFAULT NULL COMMENT '创建日期',
  `updated_at` datetime DEFAULT NULL COMMENT '修改日期',
  `deleted_at` datetime DEFAULT NULL COMMENT '删除日期',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `name` (`name`) USING BTREE,
  KEY `weigh` (`weigh`) USING BTREE,
  KEY `pid` (`pid`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=717 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='菜单节点表';

-- ----------------------------
-- Records of sys_auth_rule
-- ----------------------------
BEGIN;
INSERT INTO `sys_auth_rule` (`id`, `pid`, `name`, `title`, `icon`, `condition`, `remark`, `menu_type`, `weigh`, `status`, `always_show`, `path`, `jump_path`, `component`, `is_frame`, `module_type`, `model_id`, `created_at`, `updated_at`, `deleted_at`) VALUES (3, 75, 'system/monitor', '系统监控', 'monitor', '', '', 0, 0, 1, 1, 'monitor', '', '', 0, 'sys_admin', 0, NULL, '2024-11-28 21:44:11', NULL);
INSERT INTO `sys_auth_rule` (`id`, `pid`, `name`, `title`, `icon`, `condition`, `remark`, `menu_type`, `weigh`, `status`, `always_show`, `path`, `jump_path`, `component`, `is_frame`, `module_type`, `model_id`, `created_at`, `updated_at`, `deleted_at`) VALUES (5, 75, 'system/config/dict/type/list', '字典管理', 'dict', '', '', 1, 0, 1, 1, 'dict/list', '', 'system/config/dict/list', 0, 'sys_admin', 0, NULL, '2024-10-17 20:34:40', NULL);
INSERT INTO `sys_auth_rule` (`id`, `pid`, `name`, `title`, `icon`, `condition`, `remark`, `menu_type`, `weigh`, `status`, `always_show`, `path`, `jump_path`, `component`, `is_frame`, `module_type`, `model_id`, `created_at`, `updated_at`, `deleted_at`) VALUES (6, 75, 'system/config/sysConfig/list', '参数管理', 'date-range', '', '', 1, 0, 1, 1, 'params/list', '', 'system/config/params/list', 0, 'sys_admin', 0, NULL, '2024-10-17 20:34:46', NULL);
INSERT INTO `sys_auth_rule` (`id`, `pid`, `name`, `title`, `icon`, `condition`, `remark`, `menu_type`, `weigh`, `status`, `always_show`, `path`, `jump_path`, `component`, `is_frame`, `module_type`, `model_id`, `created_at`, `updated_at`, `deleted_at`) VALUES (8, 75, 'system/auth/menuList', '菜单管理', 'nested', '', '', 1, 0, 1, 1, 'menuList', '', 'system/auth/menuList', 0, 'sys_admin', 0, NULL, '2024-10-17 20:36:23', NULL);
INSERT INTO `sys_auth_rule` (`id`, `pid`, `name`, `title`, `icon`, `condition`, `remark`, `menu_type`, `weigh`, `status`, `always_show`, `path`, `jump_path`, `component`, `is_frame`, `module_type`, `model_id`, `created_at`, `updated_at`, `deleted_at`) VALUES (16, 8, 'system/auth/addMenu', '添加菜单', '', '', '', 2, 0, 1, 1, '', '', '', 0, 'sys_admin', 0, NULL, '2021-07-20 09:02:20', NULL);
INSERT INTO `sys_auth_rule` (`id`, `pid`, `name`, `title`, `icon`, `condition`, `remark`, `menu_type`, `weigh`, `status`, `always_show`, `path`, `jump_path`, `component`, `is_frame`, `module_type`, `model_id`, `created_at`, `updated_at`, `deleted_at`) VALUES (17, 8, 'system/auth/editMenu', '修改菜单', '', '', '', 2, 0, 1, 1, '', '', '', 0, 'sys_admin', 0, NULL, NULL, NULL);
INSERT INTO `sys_auth_rule` (`id`, `pid`, `name`, `title`, `icon`, `condition`, `remark`, `menu_type`, `weigh`, `status`, `always_show`, `path`, `jump_path`, `component`, `is_frame`, `module_type`, `model_id`, `created_at`, `updated_at`, `deleted_at`) VALUES (18, 8, 'system/auth/deleteMenu', '删除菜单', '', '', '', 2, 0, 1, 1, '', '', '', 0, 'sys_admin', 0, NULL, NULL, NULL);
INSERT INTO `sys_auth_rule` (`id`, `pid`, `name`, `title`, `icon`, `condition`, `remark`, `menu_type`, `weigh`, `status`, `always_show`, `path`, `jump_path`, `component`, `is_frame`, `module_type`, `model_id`, `created_at`, `updated_at`, `deleted_at`) VALUES (19, 5, 'system/config/dict/type/add', '添加字典', '', '', '', 2, 0, 1, 1, '', '', '', 0, 'sys_admin', 0, NULL, '2021-07-20 08:56:29', NULL);
INSERT INTO `sys_auth_rule` (`id`, `pid`, `name`, `title`, `icon`, `condition`, `remark`, `menu_type`, `weigh`, `status`, `always_show`, `path`, `jump_path`, `component`, `is_frame`, `module_type`, `model_id`, `created_at`, `updated_at`, `deleted_at`) VALUES (20, 5, 'system/config/dict/type/edit', '修改字典', '', '', '', 2, 0, 1, 1, '', '', '', 0, 'sys_admin', 0, NULL, '2021-07-20 08:56:39', NULL);
INSERT INTO `sys_auth_rule` (`id`, `pid`, `name`, `title`, `icon`, `condition`, `remark`, `menu_type`, `weigh`, `status`, `always_show`, `path`, `jump_path`, `component`, `is_frame`, `module_type`, `model_id`, `created_at`, `updated_at`, `deleted_at`) VALUES (21, 5, 'system/config/dict/type/delete', '删除字典', '', '', '', 2, 0, 1, 1, '', '', '', 0, 'sys_admin', 0, NULL, '2021-07-20 08:56:49', NULL);
INSERT INTO `sys_auth_rule` (`id`, `pid`, `name`, `title`, `icon`, `condition`, `remark`, `menu_type`, `weigh`, `status`, `always_show`, `path`, `jump_path`, `component`, `is_frame`, `module_type`, `model_id`, `created_at`, `updated_at`, `deleted_at`) VALUES (22, 5, 'system/config/dict/data/list', '字典数据管理', '', '', '', 2, 0, 1, 1, 'dataList', '', '', 0, 'sys_admin', 0, NULL, '2021-07-20 08:57:25', NULL);
INSERT INTO `sys_auth_rule` (`id`, `pid`, `name`, `title`, `icon`, `condition`, `remark`, `menu_type`, `weigh`, `status`, `always_show`, `path`, `jump_path`, `component`, `is_frame`, `module_type`, `model_id`, `created_at`, `updated_at`, `deleted_at`) VALUES (23, 5, 'system/config/dict/data/add', '添加字典数据', '', '', '', 2, 0, 1, 1, '', '', '', 0, 'sys_admin', 0, NULL, '2021-07-20 08:58:06', NULL);
INSERT INTO `sys_auth_rule` (`id`, `pid`, `name`, `title`, `icon`, `condition`, `remark`, `menu_type`, `weigh`, `status`, `always_show`, `path`, `jump_path`, `component`, `is_frame`, `module_type`, `model_id`, `created_at`, `updated_at`, `deleted_at`) VALUES (24, 5, 'system/config/dict/data/edit', '修改字典数据', '', '', '', 2, 0, 1, 1, '', '', '', 0, 'sys_admin', 0, NULL, '2021-07-20 08:58:14', NULL);
INSERT INTO `sys_auth_rule` (`id`, `pid`, `name`, `title`, `icon`, `condition`, `remark`, `menu_type`, `weigh`, `status`, `always_show`, `path`, `jump_path`, `component`, `is_frame`, `module_type`, `model_id`, `created_at`, `updated_at`, `deleted_at`) VALUES (25, 5, 'system/config/dict/data/delete', '删除字典数据', '', '', '', 2, 0, 1, 1, '', '', '', 0, 'sys_admin', 0, NULL, '2021-07-20 08:58:22', NULL);
INSERT INTO `sys_auth_rule` (`id`, `pid`, `name`, `title`, `icon`, `condition`, `remark`, `menu_type`, `weigh`, `status`, `always_show`, `path`, `jump_path`, `component`, `is_frame`, `module_type`, `model_id`, `created_at`, `updated_at`, `deleted_at`) VALUES (26, 691, 'system/auth/roleList', '角色管理', 'logininfor', '', '', 1, 9, 1, 1, 'role', '', 'system/auth/roleList', 0, 'sys_admin', 0, NULL, '2024-11-29 10:22:12', NULL);
INSERT INTO `sys_auth_rule` (`id`, `pid`, `name`, `title`, `icon`, `condition`, `remark`, `menu_type`, `weigh`, `status`, `always_show`, `path`, `jump_path`, `component`, `is_frame`, `module_type`, `model_id`, `created_at`, `updated_at`, `deleted_at`) VALUES (27, 26, 'system/auth/addRole', '添加角色', '', '', '', 2, 0, 1, 1, '', '', '', 0, 'sys_admin', 0, NULL, NULL, NULL);
INSERT INTO `sys_auth_rule` (`id`, `pid`, `name`, `title`, `icon`, `condition`, `remark`, `menu_type`, `weigh`, `status`, `always_show`, `path`, `jump_path`, `component`, `is_frame`, `module_type`, `model_id`, `created_at`, `updated_at`, `deleted_at`) VALUES (29, 26, 'system/auth/editRole', '修改角色', '', '', '', 2, 0, 1, 1, '', '', '', 0, 'sys_admin', 0, NULL, NULL, NULL);
INSERT INTO `sys_auth_rule` (`id`, `pid`, `name`, `title`, `icon`, `condition`, `remark`, `menu_type`, `weigh`, `status`, `always_show`, `path`, `jump_path`, `component`, `is_frame`, `module_type`, `model_id`, `created_at`, `updated_at`, `deleted_at`) VALUES (30, 26, 'system/auth/statusSetRole', '设置角色状态', '', '', '', 2, 0, 1, 1, '', '', '', 0, 'sys_admin', 0, NULL, NULL, NULL);
INSERT INTO `sys_auth_rule` (`id`, `pid`, `name`, `title`, `icon`, `condition`, `remark`, `menu_type`, `weigh`, `status`, `always_show`, `path`, `jump_path`, `component`, `is_frame`, `module_type`, `model_id`, `created_at`, `updated_at`, `deleted_at`) VALUES (31, 26, 'system/auth/deleteRole', '删除角色', '', '', '', 2, 0, 1, 1, '', '', '', 0, 'sys_admin', 0, NULL, NULL, NULL);
INSERT INTO `sys_auth_rule` (`id`, `pid`, `name`, `title`, `icon`, `condition`, `remark`, `menu_type`, `weigh`, `status`, `always_show`, `path`, `jump_path`, `component`, `is_frame`, `module_type`, `model_id`, `created_at`, `updated_at`, `deleted_at`) VALUES (34, 3, 'system/monitor/online/list', '在线用户', 'cascader', '', '', 1, 0, 1, 1, 'online', '', 'system/monitor/online/list', 0, 'sys_admin', 0, NULL, NULL, NULL);
INSERT INTO `sys_auth_rule` (`id`, `pid`, `name`, `title`, `icon`, `condition`, `remark`, `menu_type`, `weigh`, `status`, `always_show`, `path`, `jump_path`, `component`, `is_frame`, `module_type`, `model_id`, `created_at`, `updated_at`, `deleted_at`) VALUES (36, 3, 'system/monitor/job', '定时任务', 'clipboard', '', '', 1, 0, 1, 1, 'job', '', 'system/monitor/job', 0, 'sys_admin', 0, NULL, NULL, NULL);
INSERT INTO `sys_auth_rule` (`id`, `pid`, `name`, `title`, `icon`, `condition`, `remark`, `menu_type`, `weigh`, `status`, `always_show`, `path`, `jump_path`, `component`, `is_frame`, `module_type`, `model_id`, `created_at`, `updated_at`, `deleted_at`) VALUES (38, 691, 'system/monitor/loginLog', '管理员登录', 'chart', '', '', 1, 0, 1, 1, 'logininfor', '', 'system/monitor/logininfor', 0, 'sys_admin', 0, NULL, '2024-11-29 10:22:29', NULL);
INSERT INTO `sys_auth_rule` (`id`, `pid`, `name`, `title`, `icon`, `condition`, `remark`, `menu_type`, `weigh`, `status`, `always_show`, `path`, `jump_path`, `component`, `is_frame`, `module_type`, `model_id`, `created_at`, `updated_at`, `deleted_at`) VALUES (39, 691, 'system/monitor/operLog', '管理员操作', 'dashboard', '', '', 1, 0, 1, 1, 'operlog', '', 'system/monitor/operlog', 0, 'sys_admin', 0, NULL, '2024-11-29 10:22:37', NULL);
INSERT INTO `sys_auth_rule` (`id`, `pid`, `name`, `title`, `icon`, `condition`, `remark`, `menu_type`, `weigh`, `status`, `always_show`, `path`, `jump_path`, `component`, `is_frame`, `module_type`, `model_id`, `created_at`, `updated_at`, `deleted_at`) VALUES (40, 691, 'system/auth/userList', '管理员', 'user', '', '', 1, 10, 1, 1, 'user', '', 'system/auth/userList', 0, 'sys_admin', 0, NULL, '2024-11-29 10:22:05', NULL);
INSERT INTO `sys_auth_rule` (`id`, `pid`, `name`, `title`, `icon`, `condition`, `remark`, `menu_type`, `weigh`, `status`, `always_show`, `path`, `jump_path`, `component`, `is_frame`, `module_type`, `model_id`, `created_at`, `updated_at`, `deleted_at`) VALUES (41, 6, 'system/config/sysConfig/add', '添加参数', '', '', '', 2, 0, 1, 1, '', '', '', 0, 'sys_admin', 0, NULL, '2021-07-20 08:59:09', NULL);
INSERT INTO `sys_auth_rule` (`id`, `pid`, `name`, `title`, `icon`, `condition`, `remark`, `menu_type`, `weigh`, `status`, `always_show`, `path`, `jump_path`, `component`, `is_frame`, `module_type`, `model_id`, `created_at`, `updated_at`, `deleted_at`) VALUES (42, 6, 'system/config/sysConfig/edit', '修改参数', '', '', '', 2, 0, 1, 1, '', '', '', 0, 'sys_admin', 0, NULL, '2021-07-20 08:59:17', NULL);
INSERT INTO `sys_auth_rule` (`id`, `pid`, `name`, `title`, `icon`, `condition`, `remark`, `menu_type`, `weigh`, `status`, `always_show`, `path`, `jump_path`, `component`, `is_frame`, `module_type`, `model_id`, `created_at`, `updated_at`, `deleted_at`) VALUES (43, 6, 'system/config/sysConfig/delete', '删除参数', '', '', '', 2, 0, 1, 1, '', '', '', 0, 'sys_admin', 0, NULL, '2021-07-20 08:59:25', NULL);
INSERT INTO `sys_auth_rule` (`id`, `pid`, `name`, `title`, `icon`, `condition`, `remark`, `menu_type`, `weigh`, `status`, `always_show`, `path`, `jump_path`, `component`, `is_frame`, `module_type`, `model_id`, `created_at`, `updated_at`, `deleted_at`) VALUES (50, 40, 'system/auth/addUser', '添加用户', '', '', '', 2, 0, 1, 1, '', '', '', 0, 'sys_admin', 0, NULL, NULL, NULL);
INSERT INTO `sys_auth_rule` (`id`, `pid`, `name`, `title`, `icon`, `condition`, `remark`, `menu_type`, `weigh`, `status`, `always_show`, `path`, `jump_path`, `component`, `is_frame`, `module_type`, `model_id`, `created_at`, `updated_at`, `deleted_at`) VALUES (51, 40, 'system/auth/editUser', '修改用户', '', '', '', 2, 0, 1, 1, '', '', '', 0, 'sys_admin', 0, NULL, NULL, NULL);
INSERT INTO `sys_auth_rule` (`id`, `pid`, `name`, `title`, `icon`, `condition`, `remark`, `menu_type`, `weigh`, `status`, `always_show`, `path`, `jump_path`, `component`, `is_frame`, `module_type`, `model_id`, `created_at`, `updated_at`, `deleted_at`) VALUES (52, 40, 'system/auth/resetUserPwd', '密码重置', '', '', '', 2, 0, 1, 1, '', '', '', 0, 'sys_admin', 0, NULL, NULL, NULL);
INSERT INTO `sys_auth_rule` (`id`, `pid`, `name`, `title`, `icon`, `condition`, `remark`, `menu_type`, `weigh`, `status`, `always_show`, `path`, `jump_path`, `component`, `is_frame`, `module_type`, `model_id`, `created_at`, `updated_at`, `deleted_at`) VALUES (53, 40, 'system/auth/changeUserStatus', '状态设置', '', '', '', 2, 0, 1, 1, '', '', '', 0, 'sys_admin', 0, NULL, NULL, NULL);
INSERT INTO `sys_auth_rule` (`id`, `pid`, `name`, `title`, `icon`, `condition`, `remark`, `menu_type`, `weigh`, `status`, `always_show`, `path`, `jump_path`, `component`, `is_frame`, `module_type`, `model_id`, `created_at`, `updated_at`, `deleted_at`) VALUES (54, 40, 'system/auth/deleteUser', '删除用户', '', '', '', 2, 0, 1, 1, '', '', '', 0, 'sys_admin', 0, NULL, '2021-07-20 09:06:16', NULL);
INSERT INTO `sys_auth_rule` (`id`, `pid`, `name`, `title`, `icon`, `condition`, `remark`, `menu_type`, `weigh`, `status`, `always_show`, `path`, `jump_path`, `component`, `is_frame`, `module_type`, `model_id`, `created_at`, `updated_at`, `deleted_at`) VALUES (55, 34, 'system/monitor/online/forceLogout', '强制退出', '', '', '', 2, 0, 1, 1, '', '', '', 0, 'sys_admin', 0, NULL, NULL, NULL);
INSERT INTO `sys_auth_rule` (`id`, `pid`, `name`, `title`, `icon`, `condition`, `remark`, `menu_type`, `weigh`, `status`, `always_show`, `path`, `jump_path`, `component`, `is_frame`, `module_type`, `model_id`, `created_at`, `updated_at`, `deleted_at`) VALUES (56, 36, 'system/monitor/job/add', '添加任务', '', '', '', 2, 0, 1, 1, '', '', '', 0, 'sys_admin', 0, NULL, NULL, NULL);
INSERT INTO `sys_auth_rule` (`id`, `pid`, `name`, `title`, `icon`, `condition`, `remark`, `menu_type`, `weigh`, `status`, `always_show`, `path`, `jump_path`, `component`, `is_frame`, `module_type`, `model_id`, `created_at`, `updated_at`, `deleted_at`) VALUES (57, 36, 'system/monitor/job/edit', '修改任务', '', '', '', 2, 0, 1, 1, '', '', '', 0, 'sys_admin', 0, NULL, NULL, NULL);
INSERT INTO `sys_auth_rule` (`id`, `pid`, `name`, `title`, `icon`, `condition`, `remark`, `menu_type`, `weigh`, `status`, `always_show`, `path`, `jump_path`, `component`, `is_frame`, `module_type`, `model_id`, `created_at`, `updated_at`, `deleted_at`) VALUES (58, 36, 'system/monitor/job/start', '开启任务', '', '', '', 2, 0, 1, 1, '', '', '', 0, 'sys_admin', 0, NULL, NULL, NULL);
INSERT INTO `sys_auth_rule` (`id`, `pid`, `name`, `title`, `icon`, `condition`, `remark`, `menu_type`, `weigh`, `status`, `always_show`, `path`, `jump_path`, `component`, `is_frame`, `module_type`, `model_id`, `created_at`, `updated_at`, `deleted_at`) VALUES (59, 36, 'system/monitor/job/stop', '停止任务', '', '', '', 2, 0, 1, 1, '', '', '', 0, 'sys_admin', 0, NULL, NULL, NULL);
INSERT INTO `sys_auth_rule` (`id`, `pid`, `name`, `title`, `icon`, `condition`, `remark`, `menu_type`, `weigh`, `status`, `always_show`, `path`, `jump_path`, `component`, `is_frame`, `module_type`, `model_id`, `created_at`, `updated_at`, `deleted_at`) VALUES (60, 36, 'system/monitor/job/delete', '删除任务', '', '', '', 2, 0, 1, 1, '', '', '', 0, 'sys_admin', 0, NULL, NULL, NULL);
INSERT INTO `sys_auth_rule` (`id`, `pid`, `name`, `title`, `icon`, `condition`, `remark`, `menu_type`, `weigh`, `status`, `always_show`, `path`, `jump_path`, `component`, `is_frame`, `module_type`, `model_id`, `created_at`, `updated_at`, `deleted_at`) VALUES (61, 38, 'system/monitor/loginLog/delete', '删除', '', '', '', 2, 0, 1, 1, '', '', '', 0, 'sys_admin', 0, NULL, '2021-07-20 09:08:10', NULL);
INSERT INTO `sys_auth_rule` (`id`, `pid`, `name`, `title`, `icon`, `condition`, `remark`, `menu_type`, `weigh`, `status`, `always_show`, `path`, `jump_path`, `component`, `is_frame`, `module_type`, `model_id`, `created_at`, `updated_at`, `deleted_at`) VALUES (62, 38, 'system/monitor/loginLog/clear', '清空', '', '', '', 2, 0, 1, 1, '', '', '', 0, 'sys_admin', 0, NULL, '2021-07-20 09:08:15', NULL);
INSERT INTO `sys_auth_rule` (`id`, `pid`, `name`, `title`, `icon`, `condition`, `remark`, `menu_type`, `weigh`, `status`, `always_show`, `path`, `jump_path`, `component`, `is_frame`, `module_type`, `model_id`, `created_at`, `updated_at`, `deleted_at`) VALUES (63, 39, 'system/monitor/operLog/delete', '删除', '', '', '', 2, 0, 1, 1, '', '', '', 0, 'sys_admin', 0, NULL, '2021-07-20 09:08:36', NULL);
INSERT INTO `sys_auth_rule` (`id`, `pid`, `name`, `title`, `icon`, `condition`, `remark`, `menu_type`, `weigh`, `status`, `always_show`, `path`, `jump_path`, `component`, `is_frame`, `module_type`, `model_id`, `created_at`, `updated_at`, `deleted_at`) VALUES (64, 39, 'system/monitor/operLog/clear', '清空', '', '', '', 2, 0, 1, 1, '', '', '', 0, 'sys_admin', 0, NULL, '2021-07-20 09:08:41', NULL);
INSERT INTO `sys_auth_rule` (`id`, `pid`, `name`, `title`, `icon`, `condition`, `remark`, `menu_type`, `weigh`, `status`, `always_show`, `path`, `jump_path`, `component`, `is_frame`, `module_type`, `model_id`, `created_at`, `updated_at`, `deleted_at`) VALUES (75, 0, 'system/tools', '开发工具', 'server', '', '', 0, 0, 1, 0, 'system/tools', '', '', 0, 'sys_admin', 0, NULL, '2025-03-28 21:22:09', NULL);
INSERT INTO `sys_auth_rule` (`id`, `pid`, `name`, `title`, `icon`, `condition`, `remark`, `menu_type`, `weigh`, `status`, `always_show`, `path`, `jump_path`, `component`, `is_frame`, `module_type`, `model_id`, `created_at`, `updated_at`, `deleted_at`) VALUES (76, 75, 'system/tools/build', '表单构建', 'build', '', '', 1, 0, 0, 0, 'build', '', 'system/tools/build', 0, 'sys_admin', 0, NULL, '2024-10-17 20:37:26', NULL);
INSERT INTO `sys_auth_rule` (`id`, `pid`, `name`, `title`, `icon`, `condition`, `remark`, `menu_type`, `weigh`, `status`, `always_show`, `path`, `jump_path`, `component`, `is_frame`, `module_type`, `model_id`, `created_at`, `updated_at`, `deleted_at`) VALUES (86, 0, 'system/config/sysWebSet', '配置', 'system', '', '', 1, 87, 1, 1, '/webSet', '', 'system/config/webSet', 0, 'sys_admin', 0, NULL, '2025-03-24 19:00:02', NULL);
INSERT INTO `sys_auth_rule` (`id`, `pid`, `name`, `title`, `icon`, `condition`, `remark`, `menu_type`, `weigh`, `status`, `always_show`, `path`, `jump_path`, `component`, `is_frame`, `module_type`, `model_id`, `created_at`, `updated_at`, `deleted_at`) VALUES (185, 86, 'system/config/sysWebSet/update', '站点配置更新', '', '', '', 2, 0, 1, 1, '', '', '', 0, 'sys_admin', 0, '2021-07-20 09:00:18', '2021-07-20 09:00:18', NULL);
INSERT INTO `sys_auth_rule` (`id`, `pid`, `name`, `title`, `icon`, `condition`, `remark`, `menu_type`, `weigh`, `status`, `always_show`, `path`, `jump_path`, `component`, `is_frame`, `module_type`, `model_id`, `created_at`, `updated_at`, `deleted_at`) VALUES (186, 75, 'system/tools/gen/tableList', '代码生成', 'code', '', '', 1, 0, 1, 1, 'gen', '', 'system/tools/gen', 0, 'sys_admin', 0, '2021-08-16 10:36:54', '2021-08-16 12:12:49', NULL);
INSERT INTO `sys_auth_rule` (`id`, `pid`, `name`, `title`, `icon`, `condition`, `remark`, `menu_type`, `weigh`, `status`, `always_show`, `path`, `jump_path`, `component`, `is_frame`, `module_type`, `model_id`, `created_at`, `updated_at`, `deleted_at`) VALUES (226, 75, 'system/tools/api', '系统接口', 'guide', '', '', 1, 0, 0, 0, 'api', '', 'system/tools/api', 0, 'sys_admin', 0, '2021-12-22 09:42:42', '2024-10-17 20:37:31', NULL);
INSERT INTO `sys_auth_rule` (`id`, `pid`, `name`, `title`, `icon`, `condition`, `remark`, `menu_type`, `weigh`, `status`, `always_show`, `path`, `jump_path`, `component`, `is_frame`, `module_type`, `model_id`, `created_at`, `updated_at`, `deleted_at`) VALUES (481, 660, 'vpn/vpnNode/list', '节点列表', 'list', '', '', 1, 9, 1, 1, 'vpnNodeList', '', 'vpn/vpnNode/list', 0, 'sys_admin', 0, NULL, '2024-10-12 11:14:14', NULL);
INSERT INTO `sys_auth_rule` (`id`, `pid`, `name`, `title`, `icon`, `condition`, `remark`, `menu_type`, `weigh`, `status`, `always_show`, `path`, `jump_path`, `component`, `is_frame`, `module_type`, `model_id`, `created_at`, `updated_at`, `deleted_at`) VALUES (482, 481, 'vpn/vpnNode/get', 'Vpn节点配置查询', '', '', 'Vpn节点配置查询', 2, 0, 1, 1, '', '', '', 0, 'sys_admin', 0, NULL, NULL, NULL);
INSERT INTO `sys_auth_rule` (`id`, `pid`, `name`, `title`, `icon`, `condition`, `remark`, `menu_type`, `weigh`, `status`, `always_show`, `path`, `jump_path`, `component`, `is_frame`, `module_type`, `model_id`, `created_at`, `updated_at`, `deleted_at`) VALUES (483, 481, 'vpn/vpnNode/add', 'Vpn节点配置添加', '', '', 'Vpn节点配置添加', 2, 0, 1, 1, '', '', '', 0, 'sys_admin', 0, NULL, NULL, NULL);
INSERT INTO `sys_auth_rule` (`id`, `pid`, `name`, `title`, `icon`, `condition`, `remark`, `menu_type`, `weigh`, `status`, `always_show`, `path`, `jump_path`, `component`, `is_frame`, `module_type`, `model_id`, `created_at`, `updated_at`, `deleted_at`) VALUES (484, 481, 'vpn/vpnNode/edit', 'Vpn节点配置修改', '', '', 'Vpn节点配置修改', 2, 0, 1, 1, '', '', '', 0, 'sys_admin', 0, NULL, NULL, NULL);
INSERT INTO `sys_auth_rule` (`id`, `pid`, `name`, `title`, `icon`, `condition`, `remark`, `menu_type`, `weigh`, `status`, `always_show`, `path`, `jump_path`, `component`, `is_frame`, `module_type`, `model_id`, `created_at`, `updated_at`, `deleted_at`) VALUES (485, 481, 'vpn/vpnNode/delete', 'Vpn节点配置删除', '', '', 'Vpn节点配置删除', 2, 0, 1, 1, '', '', '', 0, 'sys_admin', 0, NULL, NULL, NULL);
INSERT INTO `sys_auth_rule` (`id`, `pid`, `name`, `title`, `icon`, `condition`, `remark`, `menu_type`, `weigh`, `status`, `always_show`, `path`, `jump_path`, `component`, `is_frame`, `module_type`, `model_id`, `created_at`, `updated_at`, `deleted_at`) VALUES (493, 660, 'vpn/vpnNodeNation/list', '地区列表', 'list', '', '', 1, 3, 1, 1, 'vpnNodeNationList', '', 'vpn/vpnNodeNation/list', 0, 'sys_admin', 0, NULL, '2025-03-24 16:41:15', NULL);
INSERT INTO `sys_auth_rule` (`id`, `pid`, `name`, `title`, `icon`, `condition`, `remark`, `menu_type`, `weigh`, `status`, `always_show`, `path`, `jump_path`, `component`, `is_frame`, `module_type`, `model_id`, `created_at`, `updated_at`, `deleted_at`) VALUES (494, 493, 'vpn/vpnNodeNation/get', 'vpn ip 国家查询', '', '', 'vpn ip 国家查询', 2, 0, 1, 1, '', '', '', 0, 'sys_admin', 0, NULL, NULL, NULL);
INSERT INTO `sys_auth_rule` (`id`, `pid`, `name`, `title`, `icon`, `condition`, `remark`, `menu_type`, `weigh`, `status`, `always_show`, `path`, `jump_path`, `component`, `is_frame`, `module_type`, `model_id`, `created_at`, `updated_at`, `deleted_at`) VALUES (495, 493, 'vpn/vpnNodeNation/add', 'vpn ip 国家添加', '', '', 'vpn ip 国家添加', 2, 0, 1, 1, '', '', '', 0, 'sys_admin', 0, NULL, NULL, NULL);
INSERT INTO `sys_auth_rule` (`id`, `pid`, `name`, `title`, `icon`, `condition`, `remark`, `menu_type`, `weigh`, `status`, `always_show`, `path`, `jump_path`, `component`, `is_frame`, `module_type`, `model_id`, `created_at`, `updated_at`, `deleted_at`) VALUES (496, 493, 'vpn/vpnNodeNation/edit', 'vpn ip 国家修改', '', '', 'vpn ip 国家修改', 2, 0, 1, 1, '', '', '', 0, 'sys_admin', 0, NULL, NULL, NULL);
INSERT INTO `sys_auth_rule` (`id`, `pid`, `name`, `title`, `icon`, `condition`, `remark`, `menu_type`, `weigh`, `status`, `always_show`, `path`, `jump_path`, `component`, `is_frame`, `module_type`, `model_id`, `created_at`, `updated_at`, `deleted_at`) VALUES (497, 493, 'vpn/vpnNodeNation/delete', 'vpn ip 国家删除', '', '', 'vpn ip 国家删除', 2, 0, 1, 1, '', '', '', 0, 'sys_admin', 0, NULL, NULL, NULL);
INSERT INTO `sys_auth_rule` (`id`, `pid`, `name`, `title`, `icon`, `condition`, `remark`, `menu_type`, `weigh`, `status`, `always_show`, `path`, `jump_path`, `component`, `is_frame`, `module_type`, `model_id`, `created_at`, `updated_at`, `deleted_at`) VALUES (539, 588, 'vpn/vpnServer/list', '服务器管理', 'list', '', '', 1, 10, 1, 1, 'vpnServerList', '', 'vpn/vpnServer/list', 0, 'sys_admin', 0, NULL, '2023-11-18 17:20:11', NULL);
INSERT INTO `sys_auth_rule` (`id`, `pid`, `name`, `title`, `icon`, `condition`, `remark`, `menu_type`, `weigh`, `status`, `always_show`, `path`, `jump_path`, `component`, `is_frame`, `module_type`, `model_id`, `created_at`, `updated_at`, `deleted_at`) VALUES (540, 539, 'vpn/vpnServer/get', 'Vpn服务器查询', '', '', 'Vpn服务器查询', 2, 0, 1, 1, '', '', '', 0, 'sys_admin', 0, NULL, NULL, NULL);
INSERT INTO `sys_auth_rule` (`id`, `pid`, `name`, `title`, `icon`, `condition`, `remark`, `menu_type`, `weigh`, `status`, `always_show`, `path`, `jump_path`, `component`, `is_frame`, `module_type`, `model_id`, `created_at`, `updated_at`, `deleted_at`) VALUES (541, 539, 'vpn/vpnServer/add', 'Vpn服务器添加', '', '', 'Vpn服务器添加', 2, 0, 1, 1, '', '', '', 0, 'sys_admin', 0, NULL, NULL, NULL);
INSERT INTO `sys_auth_rule` (`id`, `pid`, `name`, `title`, `icon`, `condition`, `remark`, `menu_type`, `weigh`, `status`, `always_show`, `path`, `jump_path`, `component`, `is_frame`, `module_type`, `model_id`, `created_at`, `updated_at`, `deleted_at`) VALUES (542, 539, 'vpn/vpnServer/edit', 'Vpn服务器修改', '', '', 'Vpn服务器修改', 2, 0, 1, 1, '', '', '', 0, 'sys_admin', 0, NULL, NULL, NULL);
INSERT INTO `sys_auth_rule` (`id`, `pid`, `name`, `title`, `icon`, `condition`, `remark`, `menu_type`, `weigh`, `status`, `always_show`, `path`, `jump_path`, `component`, `is_frame`, `module_type`, `model_id`, `created_at`, `updated_at`, `deleted_at`) VALUES (543, 539, 'vpn/vpnServer/delete', 'Vpn服务器删除', '', '', 'Vpn服务器删除', 2, 0, 1, 1, '', '', '', 0, 'sys_admin', 0, NULL, NULL, NULL);
INSERT INTO `sys_auth_rule` (`id`, `pid`, `name`, `title`, `icon`, `condition`, `remark`, `menu_type`, `weigh`, `status`, `always_show`, `path`, `jump_path`, `component`, `is_frame`, `module_type`, `model_id`, `created_at`, `updated_at`, `deleted_at`) VALUES (544, 539, 'vpn/vpnServer/changeStatus', 'Vpn服务器状态修改', '', '', 'Vpn服务器状态修改', 2, 0, 1, 1, '', '', '', 0, 'sys_admin', 0, NULL, NULL, NULL);
INSERT INTO `sys_auth_rule` (`id`, `pid`, `name`, `title`, `icon`, `condition`, `remark`, `menu_type`, `weigh`, `status`, `always_show`, `path`, `jump_path`, `component`, `is_frame`, `module_type`, `model_id`, `created_at`, `updated_at`, `deleted_at`) VALUES (588, 0, 'vpnserver1', '服务器管理', 'build', '', '', 0, 99, 1, 1, 'vpnserver1', '', '', 0, 'sys_admin', 0, '2023-11-15 14:44:43', '2024-10-12 11:02:15', NULL);
INSERT INTO `sys_auth_rule` (`id`, `pid`, `name`, `title`, `icon`, `condition`, `remark`, `menu_type`, `weigh`, `status`, `always_show`, `path`, `jump_path`, `component`, `is_frame`, `module_type`, `model_id`, `created_at`, `updated_at`, `deleted_at`) VALUES (643, 588, 'vpn/vpnServerGroup/list', '服务器分组', 'list', '', '', 1, 10, 1, 1, 'vpnServerGroupList', '', 'vpn/vpnServerGroup/list', 0, 'sys_admin', 0, NULL, '2024-10-11 16:11:00', NULL);
INSERT INTO `sys_auth_rule` (`id`, `pid`, `name`, `title`, `icon`, `condition`, `remark`, `menu_type`, `weigh`, `status`, `always_show`, `path`, `jump_path`, `component`, `is_frame`, `module_type`, `model_id`, `created_at`, `updated_at`, `deleted_at`) VALUES (644, 643, 'system/vpnServerGroup/get', '服务器分组查询', '', '', '服务器分组查询', 2, 0, 1, 1, '', '', '', 0, 'sys_admin', 0, NULL, NULL, NULL);
INSERT INTO `sys_auth_rule` (`id`, `pid`, `name`, `title`, `icon`, `condition`, `remark`, `menu_type`, `weigh`, `status`, `always_show`, `path`, `jump_path`, `component`, `is_frame`, `module_type`, `model_id`, `created_at`, `updated_at`, `deleted_at`) VALUES (645, 643, 'system/vpnServerGroup/add', '服务器分组添加', '', '', '服务器分组添加', 2, 0, 1, 1, '', '', '', 0, 'sys_admin', 0, NULL, NULL, NULL);
INSERT INTO `sys_auth_rule` (`id`, `pid`, `name`, `title`, `icon`, `condition`, `remark`, `menu_type`, `weigh`, `status`, `always_show`, `path`, `jump_path`, `component`, `is_frame`, `module_type`, `model_id`, `created_at`, `updated_at`, `deleted_at`) VALUES (646, 643, 'system/vpnServerGroup/edit', '服务器分组修改', '', '', '服务器分组修改', 2, 0, 1, 1, '', '', '', 0, 'sys_admin', 0, NULL, NULL, NULL);
INSERT INTO `sys_auth_rule` (`id`, `pid`, `name`, `title`, `icon`, `condition`, `remark`, `menu_type`, `weigh`, `status`, `always_show`, `path`, `jump_path`, `component`, `is_frame`, `module_type`, `model_id`, `created_at`, `updated_at`, `deleted_at`) VALUES (647, 643, 'system/vpnServerGroup/delete', '服务器分组删除', '', '', '服务器分组删除', 2, 0, 1, 1, '', '', '', 0, 'sys_admin', 0, NULL, NULL, NULL);
INSERT INTO `sys_auth_rule` (`id`, `pid`, `name`, `title`, `icon`, `condition`, `remark`, `menu_type`, `weigh`, `status`, `always_show`, `path`, `jump_path`, `component`, `is_frame`, `module_type`, `model_id`, `created_at`, `updated_at`, `deleted_at`) VALUES (660, 0, 'nodes', '节点管理', 'date', '', '', 0, 99, 1, 1, 'nodes', '', '', 0, 'sys_admin', 0, '2024-10-12 11:03:17', '2024-10-12 11:03:34', NULL);
INSERT INTO `sys_auth_rule` (`id`, `pid`, `name`, `title`, `icon`, `condition`, `remark`, `menu_type`, `weigh`, `status`, `always_show`, `path`, `jump_path`, `component`, `is_frame`, `module_type`, `model_id`, `created_at`, `updated_at`, `deleted_at`) VALUES (662, 660, 'vpn/vpnNodePing/list', '测速配置', 'list', '', '', 1, 8, 1, 1, 'vpnNodePingList', '', 'vpn/vpnNodePing/list', 0, 'sys_admin', 0, NULL, '2025-03-28 13:35:55', NULL);
INSERT INTO `sys_auth_rule` (`id`, `pid`, `name`, `title`, `icon`, `condition`, `remark`, `menu_type`, `weigh`, `status`, `always_show`, `path`, `jump_path`, `component`, `is_frame`, `module_type`, `model_id`, `created_at`, `updated_at`, `deleted_at`) VALUES (663, 662, 'vpn/vpnNodePing/get', '测速配置查询', '', '', '测速配置查询', 2, 0, 1, 1, '', '', '', 0, 'sys_admin', 0, NULL, NULL, NULL);
INSERT INTO `sys_auth_rule` (`id`, `pid`, `name`, `title`, `icon`, `condition`, `remark`, `menu_type`, `weigh`, `status`, `always_show`, `path`, `jump_path`, `component`, `is_frame`, `module_type`, `model_id`, `created_at`, `updated_at`, `deleted_at`) VALUES (664, 662, 'vpn/vpnNodePing/add', '测速配置添加', '', '', '测速配置添加', 2, 0, 1, 1, '', '', '', 0, 'sys_admin', 0, NULL, NULL, NULL);
INSERT INTO `sys_auth_rule` (`id`, `pid`, `name`, `title`, `icon`, `condition`, `remark`, `menu_type`, `weigh`, `status`, `always_show`, `path`, `jump_path`, `component`, `is_frame`, `module_type`, `model_id`, `created_at`, `updated_at`, `deleted_at`) VALUES (665, 662, 'vpn/vpnNodePing/edit', '测速配置修改', '', '', '测速配置修改', 2, 0, 1, 1, '', '', '', 0, 'sys_admin', 0, NULL, NULL, NULL);
INSERT INTO `sys_auth_rule` (`id`, `pid`, `name`, `title`, `icon`, `condition`, `remark`, `menu_type`, `weigh`, `status`, `always_show`, `path`, `jump_path`, `component`, `is_frame`, `module_type`, `model_id`, `created_at`, `updated_at`, `deleted_at`) VALUES (666, 662, 'vpn/vpnNodePing/delete', '测速配置删除', '', '', '测速配置删除', 2, 0, 1, 1, '', '', '', 0, 'sys_admin', 0, NULL, NULL, NULL);
INSERT INTO `sys_auth_rule` (`id`, `pid`, `name`, `title`, `icon`, `condition`, `remark`, `menu_type`, `weigh`, `status`, `always_show`, `path`, `jump_path`, `component`, `is_frame`, `module_type`, `model_id`, `created_at`, `updated_at`, `deleted_at`) VALUES (691, 0, 'vpn/adminuser', '后台管理', 'peoples', '', '', 0, 89, 1, 0, 'vpn/adminuser', '', '', 0, 'sys_admin', 0, '2024-10-19 11:51:00', '2025-03-28 21:22:13', NULL);
INSERT INTO `sys_auth_rule` (`id`, `pid`, `name`, `title`, `icon`, `condition`, `remark`, `menu_type`, `weigh`, `status`, `always_show`, `path`, `jump_path`, `component`, `is_frame`, `module_type`, `model_id`, `created_at`, `updated_at`, `deleted_at`) VALUES (706, 660, 'vpn/vpnSubscription/list', '自定义订阅', 'list', '', '', 1, 0, 1, 1, 'vpnSubscriptionList', '', 'vpn/vpnSubscription/list', 0, 'sys_admin', 0, NULL, '2025-03-28 13:08:59', NULL);
INSERT INTO `sys_auth_rule` (`id`, `pid`, `name`, `title`, `icon`, `condition`, `remark`, `menu_type`, `weigh`, `status`, `always_show`, `path`, `jump_path`, `component`, `is_frame`, `module_type`, `model_id`, `created_at`, `updated_at`, `deleted_at`) VALUES (707, 706, 'vpn/vpnSubscription/get', '订阅管理查询', '', '', '订阅管理查询', 2, 0, 1, 1, '', '', '', 0, 'sys_admin', 0, NULL, NULL, NULL);
INSERT INTO `sys_auth_rule` (`id`, `pid`, `name`, `title`, `icon`, `condition`, `remark`, `menu_type`, `weigh`, `status`, `always_show`, `path`, `jump_path`, `component`, `is_frame`, `module_type`, `model_id`, `created_at`, `updated_at`, `deleted_at`) VALUES (708, 706, 'vpn/vpnSubscription/add', '订阅管理添加', '', '', '订阅管理添加', 2, 0, 1, 1, '', '', '', 0, 'sys_admin', 0, NULL, NULL, NULL);
INSERT INTO `sys_auth_rule` (`id`, `pid`, `name`, `title`, `icon`, `condition`, `remark`, `menu_type`, `weigh`, `status`, `always_show`, `path`, `jump_path`, `component`, `is_frame`, `module_type`, `model_id`, `created_at`, `updated_at`, `deleted_at`) VALUES (709, 706, 'vpn/vpnSubscription/edit', '订阅管理修改', '', '', '订阅管理修改', 2, 0, 1, 1, '', '', '', 0, 'sys_admin', 0, NULL, NULL, NULL);
INSERT INTO `sys_auth_rule` (`id`, `pid`, `name`, `title`, `icon`, `condition`, `remark`, `menu_type`, `weigh`, `status`, `always_show`, `path`, `jump_path`, `component`, `is_frame`, `module_type`, `model_id`, `created_at`, `updated_at`, `deleted_at`) VALUES (710, 706, 'vpn/vpnSubscription/delete', '订阅管理删除', '', '', '订阅管理删除', 2, 0, 1, 1, '', '', '', 0, 'sys_admin', 0, NULL, NULL, NULL);
INSERT INTO `sys_auth_rule` (`id`, `pid`, `name`, `title`, `icon`, `condition`, `remark`, `menu_type`, `weigh`, `status`, `always_show`, `path`, `jump_path`, `component`, `is_frame`, `module_type`, `model_id`, `created_at`, `updated_at`, `deleted_at`) VALUES (712, 660, 'vpn/vpnNodeGroup/list', '节点分组', 'list', '', '', 1, 7, 1, 1, 'vpnNodeGroupList', '', 'vpn/vpnNodeGroup/list', 0, 'sys_admin', 0, NULL, '2025-03-28 13:36:01', NULL);
INSERT INTO `sys_auth_rule` (`id`, `pid`, `name`, `title`, `icon`, `condition`, `remark`, `menu_type`, `weigh`, `status`, `always_show`, `path`, `jump_path`, `component`, `is_frame`, `module_type`, `model_id`, `created_at`, `updated_at`, `deleted_at`) VALUES (713, 712, 'vpn/vpnNodeGroup/get', '节点分组查询', '', '', '节点分组查询', 2, 0, 1, 1, '', '', '', 0, 'sys_admin', 0, NULL, NULL, NULL);
INSERT INTO `sys_auth_rule` (`id`, `pid`, `name`, `title`, `icon`, `condition`, `remark`, `menu_type`, `weigh`, `status`, `always_show`, `path`, `jump_path`, `component`, `is_frame`, `module_type`, `model_id`, `created_at`, `updated_at`, `deleted_at`) VALUES (714, 712, 'vpn/vpnNodeGroup/add', '节点分组添加', '', '', '节点分组添加', 2, 0, 1, 1, '', '', '', 0, 'sys_admin', 0, NULL, NULL, NULL);
INSERT INTO `sys_auth_rule` (`id`, `pid`, `name`, `title`, `icon`, `condition`, `remark`, `menu_type`, `weigh`, `status`, `always_show`, `path`, `jump_path`, `component`, `is_frame`, `module_type`, `model_id`, `created_at`, `updated_at`, `deleted_at`) VALUES (715, 712, 'vpn/vpnNodeGroup/edit', '节点分组修改', '', '', '节点分组修改', 2, 0, 1, 1, '', '', '', 0, 'sys_admin', 0, NULL, NULL, NULL);
INSERT INTO `sys_auth_rule` (`id`, `pid`, `name`, `title`, `icon`, `condition`, `remark`, `menu_type`, `weigh`, `status`, `always_show`, `path`, `jump_path`, `component`, `is_frame`, `module_type`, `model_id`, `created_at`, `updated_at`, `deleted_at`) VALUES (716, 712, 'vpn/vpnNodeGroup/delete', '节点分组删除', '', '', '节点分组删除', 2, 0, 1, 1, '', '', '', 0, 'sys_admin', 0, NULL, NULL, NULL);
COMMIT;

-- ----------------------------
-- Table structure for sys_config
-- ----------------------------
DROP TABLE IF EXISTS `sys_config`;
CREATE TABLE `sys_config` (
  `config_id` int unsigned NOT NULL AUTO_INCREMENT COMMENT '参数主键',
  `config_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '参数名称',
  `config_key` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '参数键名',
  `config_value` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '参数键值',
  `config_type` tinyint(1) DEFAULT '0' COMMENT '系统内置（Y是 N否）',
  `create_by` int unsigned DEFAULT '0' COMMENT '创建者',
  `update_by` int unsigned DEFAULT '0' COMMENT '更新者',
  `remark` varchar(5000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '备注',
  `created_at` datetime DEFAULT NULL COMMENT '创建时间',
  `updated_at` datetime DEFAULT NULL COMMENT '修改时间',
  `deleted_at` datetime DEFAULT NULL COMMENT '删除时间',
  PRIMARY KEY (`config_id`) USING BTREE,
  UNIQUE KEY `uni_config_key` (`config_key`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Records of sys_config
-- ----------------------------
BEGIN;
INSERT INTO `sys_config` (`config_id`, `config_name`, `config_key`, `config_value`, `config_type`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (1, '文件上传-文件大小', 'sys.uploadFile.fileSize', '500M', 1, 31, 49, '文件上传大小限制', NULL, '2024-03-04 17:07:10', NULL);
INSERT INTO `sys_config` (`config_id`, `config_name`, `config_key`, `config_value`, `config_type`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (2, '文件上传-文件类型', 'sys.uploadFile.fileType', 'app,pkg,dmg,apk,ipa,doc,docx,zip,xls,xlsx,rar,jpg,jpeg,gif,npm,png', 1, 31, 1, '文件上传后缀类型限制', NULL, '2023-11-23 18:43:36', NULL);
INSERT INTO `sys_config` (`config_id`, `config_name`, `config_key`, `config_value`, `config_type`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (3, '图片上传-图片类型', 'sys.uploadFile.imageType', 'jpg,jpeg,gif,npm,png', 1, 31, 0, '图片上传后缀类型限制', NULL, NULL, NULL);
INSERT INTO `sys_config` (`config_id`, `config_name`, `config_key`, `config_value`, `config_type`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (4, '图片上传-图片大小', 'sys.uploadFile.imageSize', '500M', 1, 31, 49, '图片上传大小限制', NULL, '2024-03-04 17:00:58', NULL);
INSERT INTO `sys_config` (`config_id`, `config_name`, `config_key`, `config_value`, `config_type`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (11, '静态资源', 'static.resource', '/', 1, 2, 0, '', NULL, NULL, NULL);
COMMIT;

-- ----------------------------
-- Table structure for sys_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_dept`;
CREATE TABLE `sys_dept` (
  `dept_id` bigint NOT NULL AUTO_INCREMENT COMMENT '部门id',
  `parent_id` bigint DEFAULT '0' COMMENT '父部门id',
  `ancestors` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '祖级列表',
  `dept_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '部门名称',
  `order_num` int DEFAULT '0' COMMENT '显示顺序',
  `leader` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '负责人',
  `phone` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '联系电话',
  `email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '邮箱',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '0' COMMENT '部门状态（0正常 1停用）',
  `created_by` bigint unsigned DEFAULT '0' COMMENT '创建人',
  `updated_by` bigint DEFAULT NULL COMMENT '修改人',
  `created_at` datetime DEFAULT NULL COMMENT '创建时间',
  `updated_at` datetime DEFAULT NULL COMMENT '修改时间',
  `deleted_at` datetime DEFAULT NULL COMMENT '删除时间',
  PRIMARY KEY (`dept_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=207 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='部门表';

-- ----------------------------
-- Records of sys_dept
-- ----------------------------
BEGIN;
INSERT INTO `sys_dept` (`dept_id`, `parent_id`, `ancestors`, `dept_name`, `order_num`, `leader`, `phone`, `email`, `status`, `created_by`, `updated_by`, `created_at`, `updated_at`, `deleted_at`) VALUES (100, 0, '0', '奇讯科技', 0, '若依', '15888888888', 'ry@qq.com', '1', 0, 31, '2021-07-13 15:56:52', '2021-07-13 15:57:05', NULL);
INSERT INTO `sys_dept` (`dept_id`, `parent_id`, `ancestors`, `dept_name`, `order_num`, `leader`, `phone`, `email`, `status`, `created_by`, `updated_by`, `created_at`, `updated_at`, `deleted_at`) VALUES (101, 100, '0,100', '深圳总公司', 1, '若依', '15888888888', 'ry@qq.com', '1', 0, NULL, '2021-07-13 15:56:52', '2021-07-13 15:56:52', NULL);
INSERT INTO `sys_dept` (`dept_id`, `parent_id`, `ancestors`, `dept_name`, `order_num`, `leader`, `phone`, `email`, `status`, `created_by`, `updated_by`, `created_at`, `updated_at`, `deleted_at`) VALUES (102, 100, '0,100', '长沙分公司', 2, '若依', '15888888888', 'ry@qq.com', '1', 0, NULL, '2021-07-13 15:56:52', '2021-07-13 15:56:52', NULL);
INSERT INTO `sys_dept` (`dept_id`, `parent_id`, `ancestors`, `dept_name`, `order_num`, `leader`, `phone`, `email`, `status`, `created_by`, `updated_by`, `created_at`, `updated_at`, `deleted_at`) VALUES (103, 101, '0,100,101', '研发部门', 1, '若依', '15888888888', 'ry@qq.com', '1', 0, NULL, '2021-07-13 15:56:52', '2021-07-13 15:56:52', NULL);
INSERT INTO `sys_dept` (`dept_id`, `parent_id`, `ancestors`, `dept_name`, `order_num`, `leader`, `phone`, `email`, `status`, `created_by`, `updated_by`, `created_at`, `updated_at`, `deleted_at`) VALUES (104, 101, '0,100,101', '市场部门', 2, '若依', '15888888888', 'ry@qq.com', '1', 0, NULL, '2021-07-13 15:56:52', '2021-07-13 15:56:52', NULL);
INSERT INTO `sys_dept` (`dept_id`, `parent_id`, `ancestors`, `dept_name`, `order_num`, `leader`, `phone`, `email`, `status`, `created_by`, `updated_by`, `created_at`, `updated_at`, `deleted_at`) VALUES (105, 101, '0,100,101', '测试部门', 3, '若依', '15888888888', 'ry@qq.com', '1', 0, NULL, '2021-07-13 15:56:52', '2021-07-13 15:56:52', NULL);
INSERT INTO `sys_dept` (`dept_id`, `parent_id`, `ancestors`, `dept_name`, `order_num`, `leader`, `phone`, `email`, `status`, `created_by`, `updated_by`, `created_at`, `updated_at`, `deleted_at`) VALUES (106, 101, '0,100,101', '财务部门', 4, '若依', '15888888888', 'ry@qq.com', '1', 0, NULL, '2021-07-13 15:56:52', '2021-07-13 15:56:52', NULL);
INSERT INTO `sys_dept` (`dept_id`, `parent_id`, `ancestors`, `dept_name`, `order_num`, `leader`, `phone`, `email`, `status`, `created_by`, `updated_by`, `created_at`, `updated_at`, `deleted_at`) VALUES (107, 101, '0,100,101', '运维部门', 5, '若依', '15888888888', 'ry@qq.com', '1', 0, NULL, '2021-07-13 15:56:52', '2021-07-13 15:56:52', NULL);
INSERT INTO `sys_dept` (`dept_id`, `parent_id`, `ancestors`, `dept_name`, `order_num`, `leader`, `phone`, `email`, `status`, `created_by`, `updated_by`, `created_at`, `updated_at`, `deleted_at`) VALUES (108, 102, '0,100,102', '市场部门', 1, '若依', '15888888888', 'ry@qq.com', '1', 0, NULL, '2021-07-13 15:56:52', '2021-07-13 15:56:52', NULL);
INSERT INTO `sys_dept` (`dept_id`, `parent_id`, `ancestors`, `dept_name`, `order_num`, `leader`, `phone`, `email`, `status`, `created_by`, `updated_by`, `created_at`, `updated_at`, `deleted_at`) VALUES (109, 102, '0,100,102', '财务部门', 2, '若依', '15888888888', 'ry@qq.com', '1', 0, NULL, '2021-07-13 15:56:52', '2021-07-13 15:56:52', NULL);
INSERT INTO `sys_dept` (`dept_id`, `parent_id`, `ancestors`, `dept_name`, `order_num`, `leader`, `phone`, `email`, `status`, `created_by`, `updated_by`, `created_at`, `updated_at`, `deleted_at`) VALUES (200, 100, '', '大数据', 1, '小刘', '18888888888', 'liou@qq.com', '1', 0, NULL, '2021-07-13 15:56:52', '2021-07-13 15:56:52', NULL);
INSERT INTO `sys_dept` (`dept_id`, `parent_id`, `ancestors`, `dept_name`, `order_num`, `leader`, `phone`, `email`, `status`, `created_by`, `updated_by`, `created_at`, `updated_at`, `deleted_at`) VALUES (201, 100, '', '开发', 1, '老李', '18888888888', 'li@qq.com', '1', 0, NULL, '2021-07-13 15:56:52', '2021-07-13 15:56:52', NULL);
INSERT INTO `sys_dept` (`dept_id`, `parent_id`, `ancestors`, `dept_name`, `order_num`, `leader`, `phone`, `email`, `status`, `created_by`, `updated_by`, `created_at`, `updated_at`, `deleted_at`) VALUES (202, 108, '', '外勤', 1, '小a', '18888888888', 'aa@qq.com', '1', 0, NULL, '2021-07-13 15:56:52', '2021-07-13 15:56:52', NULL);
INSERT INTO `sys_dept` (`dept_id`, `parent_id`, `ancestors`, `dept_name`, `order_num`, `leader`, `phone`, `email`, `status`, `created_by`, `updated_by`, `created_at`, `updated_at`, `deleted_at`) VALUES (203, 108, '', '行政', 0, 'aa', '18888888888', 'aa@qq.com', '0', 0, NULL, '2021-07-13 15:56:52', '2021-07-13 15:56:52', NULL);
INSERT INTO `sys_dept` (`dept_id`, `parent_id`, `ancestors`, `dept_name`, `order_num`, `leader`, `phone`, `email`, `status`, `created_by`, `updated_by`, `created_at`, `updated_at`, `deleted_at`) VALUES (204, 100, '', '测试一下', 0, '张三', '13688999888', '656@qq.com', '1', 0, NULL, '2021-07-13 15:56:52', '2021-07-13 15:56:52', '2021-07-12 10:12:00');
INSERT INTO `sys_dept` (`dept_id`, `parent_id`, `ancestors`, `dept_name`, `order_num`, `leader`, `phone`, `email`, `status`, `created_by`, `updated_by`, `created_at`, `updated_at`, `deleted_at`) VALUES (205, 100, '', '测试222', 0, '李四22', '13788556554', '1546@2ad.com', '1', 31, 31, '2021-07-13 15:56:52', '2021-07-13 15:56:52', '2021-07-12 10:12:20');
INSERT INTO `sys_dept` (`dept_id`, `parent_id`, `ancestors`, `dept_name`, `order_num`, `leader`, `phone`, `email`, `status`, `created_by`, `updated_by`, `created_at`, `updated_at`, `deleted_at`) VALUES (206, 205, '', 'asdasd', 0, 'dasd', '13699878797', '4654@aa.com', '1', 31, NULL, '2021-07-13 15:56:52', '2021-07-13 15:56:52', '2021-07-12 10:12:20');
COMMIT;

-- ----------------------------
-- Table structure for sys_dict_data
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_data`;
CREATE TABLE `sys_dict_data` (
  `dict_code` bigint NOT NULL AUTO_INCREMENT COMMENT '字典编码',
  `dict_sort` int DEFAULT '0' COMMENT '字典排序',
  `dict_label` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '字典标签',
  `dict_value` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '字典键值',
  `dict_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '字典类型',
  `css_class` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '样式属性（其他样式扩展）',
  `list_class` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '表格回显样式',
  `is_default` tinyint(1) DEFAULT '0' COMMENT '是否默认（1是 0否）',
  `status` tinyint(1) DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` bigint unsigned DEFAULT '0' COMMENT '创建者',
  `update_by` bigint unsigned DEFAULT '0' COMMENT '更新者',
  `remark` varchar(5000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '备注',
  `created_at` datetime DEFAULT NULL COMMENT '创建时间',
  `updated_at` datetime DEFAULT NULL COMMENT '修改时间',
  `deleted_at` datetime DEFAULT NULL COMMENT '删除时间',
  PRIMARY KEY (`dict_code`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=231 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='字典数据表';

-- ----------------------------
-- Records of sys_dict_data
-- ----------------------------
BEGIN;
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (1, 0, '男', '1', 'sys_user_sex', '', '', 0, 1, 31, 2, '备注信息', NULL, NULL, NULL);
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (2, 0, '女', '2', 'sys_user_sex', '', '', 0, 1, 31, 31, '备注信息', NULL, NULL, NULL);
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (3, 0, '保密', '0', 'sys_user_sex', '', '', 1, 1, 31, 31, '备注信息', NULL, NULL, NULL);
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (28, 0, '正常', '0', 'sys_job_status', '', 'default', 1, 1, 31, 0, '', NULL, NULL, NULL);
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (29, 0, '暂停', '1', 'sys_job_status', '', 'default', 0, 1, 31, 31, '', NULL, NULL, NULL);
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (30, 0, '默认', 'DEFAULT', 'sys_job_group', '', 'default', 1, 1, 31, 0, '', NULL, NULL, NULL);
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (31, 0, '系统', 'SYSTEM', 'sys_job_group', '', 'default', 0, 1, 31, 0, '', NULL, NULL, NULL);
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (32, 0, '成功', '1', 'admin_login_status', '', 'default', 0, 1, 31, 31, '', NULL, NULL, NULL);
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (33, 0, '失败', '0', 'admin_login_status', '', 'default', 0, 1, 31, 0, '', NULL, NULL, NULL);
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (34, 0, '成功', '1', 'sys_oper_log_status', '', 'default', 0, 1, 31, 0, '', NULL, NULL, NULL);
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (35, 0, '失败', '0', 'sys_oper_log_status', '', 'default', 0, 1, 31, 0, '', NULL, NULL, NULL);
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (36, 0, '重复执行', '1', 'sys_job_policy', '', 'default', 1, 1, 31, 0, '', NULL, NULL, NULL);
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (37, 0, '执行一次', '2', 'sys_job_policy', '', 'default', 1, 1, 31, 0, '', NULL, NULL, NULL);
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (38, 0, '显示', '1', 'sys_show_hide', NULL, 'default', 1, 1, 31, 0, NULL, NULL, NULL, NULL);
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (39, 0, '隐藏', '0', 'sys_show_hide', NULL, 'default', 0, 1, 31, 0, NULL, NULL, NULL, NULL);
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (40, 0, '正常', '1', 'sys_normal_disable', '', 'default', 1, 1, 31, 0, '', NULL, NULL, NULL);
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (41, 0, '停用', '0', 'sys_normal_disable', '', 'default', 0, 1, 31, 0, '', NULL, NULL, NULL);
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (49, 0, '是', '1', 'sys_yes_no', '', '', 1, 1, 31, 0, '', NULL, NULL, NULL);
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (50, 0, '否', '0', 'sys_yes_no', '', '', 0, 1, 31, 0, '', NULL, NULL, NULL);
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (61, 0, '政府工作目标', '1', 'gov_cate_models', '', '', 0, 1, 2, 0, '', NULL, NULL, NULL);
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (62, 0, '系统后台', 'sys_admin', 'menu_module_type', '', '', 1, 1, 2, 0, '', NULL, NULL, NULL);
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (63, 0, '政务工作', 'gov_work', 'menu_module_type', '', '', 0, 1, 2, 0, '', NULL, NULL, NULL);
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (65, 0, '[work]测试业务表', 'wf_news', 'flow_type', '', '', 0, 1, 2, 2, '', NULL, NULL, NULL);
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (66, 0, '回退修改', '-1', 'flow_status', '', '', 0, 1, 31, 0, '', NULL, NULL, NULL);
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (67, 0, '保存中', '0', 'flow_status', '', '', 0, 1, 31, 0, '', NULL, NULL, NULL);
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (68, 0, '流程中', '1', 'flow_status', '', '', 0, 1, 31, 0, '', NULL, NULL, NULL);
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (69, 0, '审批通过', '2', 'flow_status', '', '', 0, 1, 31, 2, '', NULL, NULL, NULL);
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (70, 2, '发布栏目', '2', 'sys_blog_sign', '', '', 0, 1, 31, 31, '', NULL, NULL, NULL);
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (71, 3, '跳转栏目', '3', 'sys_blog_sign', '', '', 0, 1, 31, 31, '', NULL, NULL, NULL);
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (72, 4, '单页栏目', '4', 'sys_blog_sign', '', '', 0, 1, 31, 31, '', NULL, NULL, NULL);
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (73, 2, '置顶', '1', 'sys_log_sign', '', '', 0, 1, 31, 31, '', NULL, NULL, NULL);
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (74, 3, '幻灯', '2', 'sys_log_sign', '', '', 0, 1, 31, 31, '', NULL, NULL, NULL);
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (75, 4, '推荐', '3', 'sys_log_sign', '', '', 0, 1, 31, 31, '', NULL, NULL, NULL);
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (76, 1, '一般', '0', 'sys_log_sign', '', '', 0, 1, 31, 31, '', NULL, NULL, NULL);
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (77, 1, '频道页', '1', 'sys_blog_sign', '', '', 0, 1, 31, 31, '', NULL, NULL, NULL);
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (78, 0, '普通', '0', 'flow_level', '', '', 0, 1, 31, 0, '', NULL, '2021-07-20 08:55:20', NULL);
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (79, 0, '加急', '1', 'flow_level', '', '', 0, 1, 31, 0, '', NULL, '2021-07-20 08:55:20', NULL);
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (80, 0, '紧急', '2', 'flow_level', '', '', 0, 1, 31, 0, '', NULL, '2021-07-20 08:55:20', NULL);
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (81, 0, '特急', '3', 'flow_level', '', '', 0, 1, 31, 31, '', NULL, '2021-07-20 08:55:25', NULL);
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (82, 0, '频道页', '1', 'sys_blog_type', '', '', 0, 1, 31, 0, '', NULL, NULL, NULL);
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (83, 0, '发布栏目', '2', 'sys_blog_type', '', '', 0, 1, 31, 0, '', NULL, NULL, NULL);
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (84, 0, '跳转栏目', '3', 'sys_blog_type', '', '', 0, 1, 31, 31, '', NULL, NULL, NULL);
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (85, 0, '单页栏目', '4', 'sys_blog_type', '', '', 0, 1, 31, 0, '', NULL, NULL, NULL);
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (87, 0, '[cms]文章表', 'cms_news', 'flow_type', '', '', 0, 1, 31, 0, '', NULL, NULL, NULL);
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (88, 0, 'windows', 'windows', 'user_device', '', '', 0, 1, 1, 0, '', '2023-10-06 20:27:17', '2023-10-06 20:27:17', NULL);
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (89, 0, 'macos', 'macos', 'user_device', '', '', 0, 1, 1, 1, '', '2023-10-06 20:27:24', '2024-11-30 17:37:18', NULL);
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (90, 0, 'android', 'android', 'user_device', '', '', 0, 1, 1, 0, '', '2023-10-06 20:27:30', '2023-10-06 20:27:30', NULL);
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (91, 0, 'ios', 'ios', 'user_device', '', '', 0, 1, 1, 0, '', '2023-10-06 20:27:37', '2023-10-06 20:27:37', NULL);
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (92, 0, '封禁', '-1', 'user_status', '', '', 0, 1, 1, 0, '', '2023-10-06 20:28:11', '2023-10-06 20:28:11', NULL);
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (93, 0, '正常', '1', 'user_status', '', '', 0, 1, 1, 0, '', '2023-10-06 20:28:22', '2023-10-06 20:28:22', NULL);
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (94, 0, '密码', 'password', 'sshLoginType', '', '', 0, 1, 1, 1, '', '2023-10-06 20:54:27', '2023-10-06 21:11:31', NULL);
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (95, 0, '秘钥', 'public_key', 'sshLoginType', '', '', 0, 1, 1, 1, '', '2023-10-06 20:54:32', '2023-10-06 21:11:44', NULL);
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (96, 0, '中国', 'China', 'nation', '', '', 0, 1, 1, 0, '', '2023-10-06 20:58:08', '2023-10-06 20:58:08', NULL);
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (97, 0, '日本', 'Japan', 'nation', '', '', 0, 1, 1, 0, '', '2023-10-06 20:58:17', '2023-10-06 20:58:17', NULL);
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (98, 0, '韩国', 'Korea', 'nation', '', '', 0, 1, 1, 0, '', '2023-10-06 20:58:28', '2023-10-06 20:58:28', NULL);
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (99, 0, '印度', 'India', 'nation', '', '', 0, 1, 1, 0, '', '2023-10-06 20:58:38', '2023-10-06 20:58:38', NULL);
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (100, 0, '美国', 'US', 'nation', '', '', 0, 1, 1, 0, '', '2023-10-06 20:58:46', '2023-10-06 20:58:46', NULL);
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (101, 0, '加拿大', 'Canada', 'nation', '', '', 0, 1, 1, 0, '', '2023-10-06 20:58:56', '2023-10-06 20:58:56', NULL);
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (102, 0, '澳大利亚', 'Australia', 'nation', '', '', 0, 1, 1, 0, '', '2023-10-06 20:59:08', '2023-10-06 20:59:08', NULL);
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (103, 0, '新西兰', 'NewZealand', 'nation', '', '', 0, 1, 1, 0, '', '2023-10-06 20:59:21', '2023-10-06 20:59:21', NULL);
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (104, 0, '英国', 'UK', 'nation', '', '', 0, 1, 1, 0, '', '2023-10-06 20:59:36', '2023-10-06 20:59:36', NULL);
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (105, 0, '法国', 'France', 'nation', '', '', 0, 1, 1, 0, '', '2023-10-06 20:59:46', '2023-10-06 20:59:46', NULL);
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (106, 0, '德国', 'Germany', 'nation', '', '', 0, 1, 1, 0, '', '2023-10-06 20:59:57', '2023-10-06 20:59:57', NULL);
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (107, 0, '意大利', 'Italy', 'nation', '', '', 0, 1, 1, 0, '', '2023-10-06 21:00:12', '2023-10-06 21:00:12', NULL);
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (108, 0, '俄罗斯', 'Russia', 'nation', '', '', 0, 1, 1, 0, '', '2023-10-06 21:00:27', '2023-10-06 21:00:27', NULL);
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (109, 0, '沙特阿拉伯', 'SaudiArabia', 'nation', '', '', 0, 1, 1, 0, '', '2023-10-06 21:00:41', '2023-10-06 21:00:41', NULL);
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (110, 0, '香港', 'HongKong', 'nation', '', '', 0, 1, 1, 0, '', '2023-10-06 21:01:41', '2023-10-06 21:01:41', NULL);
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (111, 0, '台湾', 'Taiwan', 'nation', '', '', 0, 1, 1, 0, '', '2023-10-06 21:01:51', '2023-10-06 21:01:51', NULL);
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (112, 0, '泰国', 'Thailand', 'nation', '', '', 0, 1, 1, 0, '', '2023-10-06 21:02:02', '2023-10-06 21:02:02', NULL);
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (113, 0, '新加坡', 'Singapore', 'nation', '', '', 0, 1, 1, 0, '', '2023-10-06 21:02:44', '2023-10-06 21:02:44', NULL);
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (114, 0, '越南', 'Vietnam', 'nation', '', '', 0, 1, 1, 0, '', '2023-10-06 21:03:01', '2023-10-06 21:03:01', NULL);
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (115, 0, '离线', '-1', 'vpn_status', '', '', 0, 1, 1, 0, '', '2023-10-06 21:05:10', '2023-10-06 21:05:10', NULL);
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (116, 0, '在线', '1', 'vpn_status', '', '', 0, 1, 1, 0, '', '2023-10-06 21:05:19', '2023-10-06 21:05:19', NULL);
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (117, 0, '否', '-1', 'isokrono', '', '', 0, 1, 1, 1, '', '2023-10-12 13:38:20', '2023-10-12 13:38:42', NULL);
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (118, 0, '是', '1', 'isokrono', '', '', 0, 1, 1, 0, '', '2023-10-12 13:38:34', '2023-10-12 13:38:34', NULL);
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (119, 0, '开启', '1', 'isonoroff', '', '', 0, 1, 1, 0, '', '2023-10-12 13:40:07', '2023-10-12 13:40:07', NULL);
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (120, 0, '关闭', '-1', 'isonoroff', '', '', 0, 1, 1, 0, '', '2023-10-12 13:40:14', '2023-10-12 13:40:14', NULL);
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (121, 0, 'vmess', 'vmess', 'vpnprotocol', '', '', 0, 1, 1, 0, '', '2023-10-12 13:46:28', '2023-10-12 13:46:28', NULL);
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (122, 1, 'shadowsocks', 'shadowsocks', 'vpnprotocol', '', '', 0, 1, 1, 49, '', '2023-10-12 13:46:42', '2024-03-06 14:32:48', NULL);
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (123, 0, 'dokodemo-door', 'dokodemo-door', 'transitprotocol', '', '', 0, 1, 1, 0, '', '2023-10-12 13:46:58', '2023-10-12 13:46:58', '2024-06-13 12:57:34');
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (124, 0, 'frp_kcp', 'frp_kcp', 'transitprotocol', '', '', 0, 1, 1, 1, '', '2023-10-12 13:47:05', '2023-11-17 18:00:11', NULL);
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (125, 0, '成功', '1', 'cengorshibai', '', '', 0, 1, 1, 0, '', '2023-10-12 14:13:35', '2023-10-12 14:13:35', NULL);
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (126, 0, '失败', '-1', 'cengorshibai', '', '', 0, 1, 1, 0, '', '2023-10-12 14:13:41', '2023-10-12 14:13:41', NULL);
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (127, 0, '允许', '1', 'yunxujujue', '', '', 0, 1, 1, 0, '', '2023-10-13 13:19:07', '2023-10-13 13:19:07', NULL);
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (128, 0, '拒绝', '-1', 'yunxujujue', '', '', 0, 1, 1, 0, '', '2023-10-13 13:19:18', '2023-10-13 13:19:18', NULL);
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (129, 0, '即将到期', '7', 'daoqisaixuan', '', '', 0, 1, 1, 1, '', '2023-10-13 13:29:14', '2023-10-13 13:31:23', NULL);
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (130, 0, '已经过期', '-1', 'daoqisaixuan', '', '', 0, 1, 1, 1, '', '2023-10-13 13:31:40', '2023-10-13 13:39:08', NULL);
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (131, 0, '注册', 'reg', 'huodongtype', '', '', 0, 1, 1, 0, '', '2023-10-26 13:56:44', '2023-10-26 13:56:44', NULL);
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (132, 0, '充值', 'pay', 'huodongtype', '', '', 0, 1, 1, 0, '', '2023-10-26 13:56:56', '2023-10-26 13:56:56', '2024-12-30 15:59:41');
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (133, 0, '邀请', 'invite', 'huodongtype', '', '', 0, 1, 1, 0, '', '2023-10-26 13:57:05', '2023-10-26 13:57:05', NULL);
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (134, 0, '余额', 'balance', 'award_type', '', '', 0, 1, 1, 0, '', '2023-10-26 13:58:17', '2023-10-26 13:58:17', NULL);
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (135, 0, '套餐', 'node', 'award_type', '', '', 0, 1, 1, 1, '', '2023-10-26 13:58:29', '2023-10-26 19:56:58', NULL);
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (136, 0, '普通', '1', 'node_type', '', '', 0, 1, 1, 0, '', '2023-10-26 20:23:21', '2023-10-26 20:23:21', NULL);
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (137, 0, '定制', '2', 'node_type', '', '', 0, 1, 1, 0, '', '2023-10-26 20:23:27', '2023-10-26 20:23:27', NULL);
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (138, 0, '节点套餐', '1', 'combo_type', '', '', 0, 1, 1, 0, '', '2023-10-26 21:51:00', '2023-10-26 21:51:00', NULL);
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (139, 0, '流量叠加包', '2', 'combo_type', '', '', 0, 1, 1, 1, '', '2023-10-26 21:51:07', '2023-10-26 21:51:20', NULL);
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (140, 0, '未用', '-1', 'tongyongshiyong', '', '', 0, 1, 1, 0, '', '2023-10-27 16:03:53', '2023-10-27 16:03:53', NULL);
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (141, 0, '已用', '1', 'tongyongshiyong', '', '', 0, 1, 1, 0, '', '2023-10-27 16:04:06', '2023-10-27 16:04:06', NULL);
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (142, 0, '绑定邮箱', '1', 'code_type', '', '', 0, 1, 1, 0, '', '2023-10-27 16:05:29', '2023-10-27 16:05:29', NULL);
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (143, 0, '验证邮件', '2', 'code_type', '', '', 0, 1, 1, 1, '', '2023-10-27 16:05:43', '2023-10-27 16:41:38', NULL);
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (144, 0, '待支付', '0', 'order_status', '', '', 0, 1, 1, 0, '', '2023-10-30 19:40:13', '2023-10-30 19:40:13', NULL);
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (145, 0, '支付失败', '-1', 'order_status', '', '', 0, 1, 1, 0, '', '2023-10-30 19:40:49', '2023-10-30 19:40:49', NULL);
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (146, 0, '成功', '1', 'order_status', '', '', 0, 1, 1, 0, '', '2023-10-30 19:41:00', '2023-10-30 19:41:00', NULL);
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (147, 0, '待交付', '2', 'order_status', '', '', 0, 1, 1, 0, '', '2023-10-30 19:41:14', '2023-10-30 19:41:14', NULL);
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (148, 0, '1MB', '1', 'bandwidths', '', '', 0, 1, 1, 0, '', '2023-10-30 20:10:32', '2023-10-30 20:10:32', NULL);
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (149, 0, '5MB', '5', 'bandwidths', '', '', 0, 1, 1, 1, '', '2023-10-30 20:10:41', '2023-10-30 20:10:54', NULL);
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (150, 0, '10MB', '10', 'bandwidths', '', '', 0, 1, 1, 1, '', '2023-10-30 20:10:49', '2023-10-30 20:10:57', NULL);
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (151, 0, '15MB', '15', 'bandwidths', '', '', 0, 1, 1, 0, '', '2023-10-30 20:11:06', '2023-10-30 20:11:06', NULL);
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (152, 0, '20MB', '20', 'bandwidths', '', '', 0, 1, 1, 0, '', '2023-10-30 20:11:18', '2023-10-30 20:11:18', NULL);
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (153, 0, '30MB', '30', 'bandwidths', '', '', 0, 1, 1, 0, '', '2023-10-30 20:11:25', '2023-10-30 20:11:25', NULL);
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (154, 0, '50MB', '50', 'bandwidths', '', '', 0, 1, 1, 0, '', '2023-10-30 20:11:32', '2023-10-30 20:11:32', NULL);
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (155, 0, '100MB', '100', 'bandwidths', '', '', 0, 1, 1, 0, '', '2023-10-30 20:11:40', '2023-10-30 20:11:40', NULL);
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (156, 0, '200MB', '200', 'bandwidths', '', '', 0, 1, 1, 0, '', '2023-10-30 20:11:47', '2023-10-30 20:11:47', NULL);
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (157, 0, '500MB', '500', 'bandwidths', '', '', 0, 1, 1, 0, '', '2023-10-30 20:11:54', '2023-10-30 20:11:54', NULL);
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (158, 0, '1GB', '1000', 'bandwidths', '', '', 0, 1, 1, 0, '', '2023-10-30 20:12:06', '2023-10-30 20:12:06', NULL);
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (159, 0, '2GB', '2000', 'bandwidths', '', '', 0, 1, 1, 0, '', '2023-10-30 20:12:20', '2023-10-30 20:12:20', NULL);
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (160, 0, '待支付', '-1', 'order_type', '', '', 0, 1, 1, 0, '', '2023-10-30 20:22:13', '2023-10-30 20:22:13', '2023-10-30 20:22:22');
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (161, 0, '余额充值', '1', 'order_type', '', '', 0, 1, 1, 0, '', '2023-10-30 20:22:41', '2023-10-30 20:22:41', NULL);
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (162, 0, '购买套餐', '2', 'order_type', '', '', 0, 1, 1, 0, '', '2023-10-30 20:22:53', '2023-10-30 20:22:53', NULL);
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (163, 0, '续费套餐', '3', 'order_type', '', '', 0, 1, 1, 1, '', '2023-10-30 20:23:02', '2025-01-01 10:29:59', NULL);
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (164, 0, 'frp_tcp', 'frp_tcp', 'transitprotocol', '', '', 0, 1, 1, 0, '', '2023-11-17 11:57:21', '2023-11-17 11:57:21', NULL);
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (165, 0, 'frp_quic', 'frp_quic', 'transitprotocol', '', '', 0, 1, 1, 0, '', '2023-11-17 11:58:09', '2023-11-17 11:58:09', NULL);
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (166, 0, '安卓APK', 'apk', 'kehuduanzhongduan', '', '', 0, 1, 1, 0, '', '2023-11-23 17:37:17', '2023-11-23 17:37:17', NULL);
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (167, 0, '安卓谷歌市场', 'google', 'kehuduanzhongduan', '', '', 0, 1, 1, 0, '', '2023-11-23 17:37:44', '2023-11-23 17:37:44', NULL);
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (168, 0, '苹果签名包', 'ipa', 'kehuduanzhongduan', '', '', 0, 1, 1, 0, '', '2023-11-23 17:38:20', '2023-11-23 17:38:20', NULL);
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (169, 0, '苹果应用市场', 'appStore', 'kehuduanzhongduan', '', '', 0, 1, 1, 1, '', '2023-11-23 17:38:59', '2023-11-23 18:32:13', NULL);
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (170, 0, 'Windows', 'windows', 'kehuduanzhongduan', '', '', 0, 1, 1, 1, '', '2023-11-23 17:39:29', '2023-11-23 18:32:00', NULL);
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (171, 0, 'MAC', 'mac', 'kehuduanzhongduan', '', '', 0, 1, 1, 1, '', '2023-11-23 17:41:10', '2024-04-18 16:34:58', NULL);
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (172, 0, 'MACStore', 'macStore', 'kehuduanzhongduan', '', '', 0, 1, 1, 1, '', '2023-11-23 17:41:47', '2024-04-18 16:35:58', NULL);
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (173, 0, '本地服务器', 'up', 'baobaocun', '', '', 0, 1, 1, 1, '', '2023-11-23 17:50:44', '2023-11-23 18:36:50', NULL);
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (174, 0, '远端链接', 'url', 'baobaocun', '', '', 0, 1, 1, 0, '', '2023-11-23 17:50:59', '2023-11-23 17:50:59', NULL);
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (175, 0, 'whatsapp', 'whatsapp', 'kefutype', '', '', 0, 1, 1, 0, '', '2023-11-24 11:02:12', '2023-11-24 11:02:12', NULL);
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (176, 0, 'telegram', 'telegram', 'kefutype', '', '', 0, 1, 1, 0, '', '2023-11-24 11:02:19', '2023-11-24 11:02:19', NULL);
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (177, 0, 'line', 'line', 'kefutype', '', '', 0, 1, 1, 0, '', '2023-11-24 11:02:26', '2023-11-24 11:02:26', NULL);
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (178, 0, '微信', 'wechat', 'kefutype', '', '', 0, 1, 1, 0, '', '2023-11-24 11:02:35', '2023-11-24 11:02:35', NULL);
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (179, 0, 'QQ', 'qq', 'kefutype', '', '', 0, 1, 1, 0, '', '2023-11-24 11:02:42', '2023-11-24 11:02:42', NULL);
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (180, 0, '邮件', 'gmail', 'kefutype', '', '', 0, 1, 1, 0, '', '2023-11-24 11:02:53', '2023-11-24 11:02:53', NULL);
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (181, 0, 'hysteria', 'hysteria', 'transitprotocol', '', '', 0, 1, 1, 1, '', '2023-12-07 20:03:46', '2024-06-13 14:41:27', NULL);
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (182, 0, '站外协议', 'external', 'transitprotocol', '', '', 0, 1, 49, 0, '', '2024-01-09 14:55:53', '2024-01-09 14:55:53', '2024-06-13 13:01:13');
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (183, 0, 'socks', 'socks', 'vpnprotocol', '', '', 0, 1, 49, 0, '', '2024-03-06 14:32:16', '2024-03-06 14:32:16', NULL);
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (184, 0, 'hysteria', 'hysteria', 'vpnprotocol', '', '', 0, 1, 49, 0, '', '2024-03-06 14:32:28', '2024-03-06 14:32:28', NULL);
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (185, 0, '中国大陆', 'cn', 'zhinengxuanzhe', '', '', 0, 1, 49, 49, '', '2024-03-08 13:12:43', '2024-03-08 14:00:09', NULL);
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (186, 0, '东南亚', '东南亚', 'zhinengxuanzhe', '', '', 0, 1, 49, 0, '', '2024-03-08 13:17:00', '2024-03-08 13:17:00', NULL);
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (187, 0, '美洲', '美洲', 'zhinengxuanzhe', '', '', 0, 1, 49, 49, '', '2024-03-08 13:17:20', '2024-03-08 13:17:39', NULL);
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (188, 0, '欧洲', '欧洲', 'zhinengxuanzhe', '', '', 0, 1, 49, 0, '', '2024-03-08 13:17:46', '2024-03-08 13:17:46', NULL);
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (189, 0, '东亚', '东亚', 'zhinengxuanzhe', '', '', 0, 1, 49, 0, '', '2024-03-08 13:17:53', '2024-03-08 13:17:53', NULL);
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (190, 0, '俄罗斯', '俄罗斯', 'zhinengxuanzhe', '', '', 0, 1, 49, 0, '', '2024-03-08 13:18:06', '2024-03-08 13:18:06', NULL);
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (191, 0, '绑定邮箱', 'bindGmail', 'huodongtype', '', '', 0, 1, 1, 1, '', '2024-04-01 12:51:07', '2024-04-01 12:51:17', '2024-12-30 15:59:38');
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (192, 0, 'Google Play', 'apk', 'mall_device', '', '', 0, 1, 1, 0, '', '2024-04-06 15:34:55', '2024-04-06 15:34:55', NULL);
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (193, 0, 'App Store', 'ipa', 'mall_device', '', '', 0, 1, 1, 0, '', '2024-04-06 15:35:27', '2024-04-06 15:35:27', NULL);
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (194, 0, '待解析', '0', 'parse_status', '', '', 0, 1, 1, 0, '', '2024-04-21 21:48:28', '2024-04-21 21:48:28', NULL);
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (195, 0, '失败', '-1', 'parse_status', '', '', 0, 1, 1, 0, '', '2024-04-21 21:48:46', '2024-04-21 21:48:46', NULL);
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (196, 0, '成功', '1', 'parse_status', '', '', 0, 1, 1, 0, '', '2024-04-21 21:48:54', '2024-04-21 21:48:54', NULL);
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (197, 0, '站内节点', '1', 'nodeGroupIdNodeType', '', '', 0, 1, 1, 0, '', '2024-05-05 13:02:06', '2024-05-05 13:03:22', NULL);
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (198, 0, '站外节点', '2', 'nodeGroupIdNodeType', '', '', 0, 1, 1, 0, '', '2024-05-05 13:02:12', '2024-05-05 13:03:22', NULL);
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (199, 0, 'mtalk.google.com:5228', '1', 'Donotrecorddomainnames', '', '', 0, 1, 1, 0, '', '2024-05-16 19:32:12', '2024-05-16 19:32:12', NULL);
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (200, 0, 'rt.applovin.com:443', '1', 'Donotrecorddomainnames', '', '', 0, 1, 1, 0, '', '2024-05-16 19:32:43', '2024-05-16 19:32:43', NULL);
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (201, 0, 'o-sdk.mediation.unity3d.com:', '1', 'Donotrecorddomainnames', '', '', 0, 1, 1, 0, '', '2024-05-16 19:33:37', '2024-05-16 19:33:37', NULL);
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (202, 0, 'cn', 'https+local://sm2.doh.pub/dns-query,https+local://doh.pub/dns-query,114.114.114.114,114.114.115.115', 'serverDNS', '', '', 0, 1, 1, 1, '', '2024-05-18 20:55:57', '2024-05-19 18:33:30', NULL);
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (203, 0, 'overseas', 'https+local://cloudflare-dns.com/dns-query,https+local://dns.google/dns-query,8.8.8.8,8.8.4.4', 'serverDNS', '', '', 0, 1, 1, 1, '', '2024-05-18 20:56:41', '2024-05-19 18:33:54', NULL);
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (204, 0, '網路客服', 'web', 'kefutype', '', '', 0, 1, 1, 1, '', '2024-05-30 15:22:10', '2024-05-30 15:23:00', NULL);
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (205, 0, 'aes-256-gcm', 'aes-256-gcm', 'method', '', '', 0, 1, 1, 0, '', '2024-06-09 15:06:55', '2024-06-09 15:06:55', NULL);
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (206, 0, 'aes-128-gcm', 'aes-128-gcm', 'method', '', '', 0, 1, 1, 0, '', '2024-06-09 15:07:08', '2024-06-09 15:07:08', NULL);
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (207, 0, 'chacha20-ietf-poly1305', 'chacha20-ietf-poly1305', 'method', '', '', 0, 1, 1, 0, '', '2024-06-09 15:07:18', '2024-06-09 15:07:18', NULL);
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (208, 0, 'xchacha20-ietf-poly1305', 'xchacha20-ietf-poly1305', 'method', '', '', 0, 1, 1, 0, '', '2024-06-09 15:07:40', '2024-06-09 15:07:40', NULL);
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (209, 0, 'hysteria_proxy', 'hysteria_proxy', 'transitprotocol', '', '', 0, 1, 1, 1, '', '2024-06-13 14:41:16', '2024-06-13 14:41:32', NULL);
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (210, 0, '腾讯云', '{\"serverName\":\"ID\",\"serverIp\":\"主IPv4公网IP\"}', 'servertxCSV', '', '', 0, 1, 1, 0, '', '2024-06-14 16:25:37', '2024-06-14 16:25:37', NULL);
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (211, 0, '云立方', '{\"serverName\":\"云服务器名\",\"serverAddress\":\"IP端口\"}', 'servertxCSV', '', '', 0, 1, 1, 0, '', '2024-06-14 16:35:14', '2024-06-14 16:35:14', NULL);
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (212, 0, 'frp_kcp', 'frp_kcp', 'frpprotocol', '', '', 0, 1, 1, 1, '', '2024-06-14 21:02:39', '2024-06-14 21:02:57', NULL);
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (213, 0, 'frp_tcp', 'frp_tcp', 'frpprotocol', '', '', 0, 1, 1, 0, '', '2024-06-14 21:02:49', '2024-06-14 21:02:49', NULL);
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (214, 0, 'frp_quic', 'frp_quic', 'frpprotocol', '', '', 0, 1, 1, 0, '', '2024-06-14 21:03:01', '2024-06-14 21:03:01', NULL);
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (215, 0, '2022-blake3-aes-128-gcm', '2022-blake3-aes-128-gcm', 'method', '', '', 0, 1, 1, 0, '', '2024-06-19 00:46:29', '2024-06-19 00:46:29', NULL);
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (216, 0, '2022-blake3-aes-256-gcm', '2022-blake3-aes-256-gcm', 'method', '', '', 0, 1, 1, 0, '', '2024-06-19 00:46:37', '2024-06-19 00:46:37', NULL);
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (217, 0, '2022-blake3-chacha20-poly1305', '2022-blake3-chacha20-poly1305', 'method', '', '', 0, 1, 1, 0, '', '2024-06-19 00:46:47', '2024-06-19 00:46:47', NULL);
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (218, 0, 'bovps', '{\"serverName\":\"产品类型,云服务器名\",\"serverAddress\":\"远程信息\"}', 'servertxCSV', '', '', 0, 1, 1, 0, '', '2024-07-04 14:27:50', '2024-07-04 14:27:50', NULL);
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (219, 0, '中文简体', 'zh_cn', 'langs', '', '', 0, 1, 1, 0, '', '2024-10-10 18:00:16', '2024-10-10 18:00:16', NULL);
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (220, 0, '中文繁體', 'zh-tw', 'langs', '', '', 0, 1, 1, 1, '', '2024-10-10 18:01:06', '2024-10-10 18:01:35', NULL);
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (221, 0, 'English', 'en', 'langs', '', '', 0, 1, 1, 0, '', '2024-10-10 18:02:00', '2024-10-10 18:02:00', NULL);
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (222, 0, '日本語', 'jp', 'langs', '', '', 0, 1, 1, 0, '', '2024-10-10 18:02:36', '2024-10-10 18:02:36', '2024-10-10 18:29:51');
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (223, 0, '한국인', 'ko', 'langs', '', '', 0, 1, 1, 0, '', '2024-10-10 18:03:07', '2024-10-10 18:03:07', NULL);
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (224, 0, 'عربي', 'ar', 'langs', '', '', 0, 1, 1, 0, '', '2024-10-10 18:04:50', '2024-10-10 18:04:50', '2024-10-13 16:42:51');
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (225, 0, '导航页', '1', 'banner', '', '', 0, 1, 1, 0, '', '2024-10-17 19:57:23', '2024-10-17 19:57:23', NULL);
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (226, 0, '首页', '2', 'banner', '', '', 0, 1, 1, 0, '', '2024-10-17 19:57:28', '2024-10-17 19:57:28', NULL);
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (227, 0, '我的套餐', '3', 'banner', '', '', 0, 1, 1, 0, '', '2024-10-17 19:57:34', '2024-10-17 19:57:34', NULL);
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (228, 0, '我的套餐', '我的套餐', 'rout', '', '', 0, 1, 1, 1, '', '2024-10-18 19:15:43', '2024-12-26 17:41:13', NULL);
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (229, 0, '购买套餐', '购买套餐', 'rout', '', '', 0, 1, 1, 1, '', '2024-10-18 19:15:52', '2024-12-26 17:41:21', NULL);
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (230, 0, '邀请好友', '邀请好友', 'rout', '', '', 0, 1, 1, 1, '', '2024-10-18 19:16:03', '2024-12-26 17:41:25', NULL);
COMMIT;

-- ----------------------------
-- Table structure for sys_dict_type
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_type`;
CREATE TABLE `sys_dict_type` (
  `dict_id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '字典主键',
  `dict_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '字典名称',
  `dict_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '字典类型',
  `status` tinyint unsigned DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` int unsigned DEFAULT '0' COMMENT '创建者',
  `update_by` int unsigned DEFAULT '0' COMMENT '更新者',
  `remark` varchar(5000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '备注',
  `created_at` datetime DEFAULT NULL COMMENT '创建日期',
  `updated_at` datetime DEFAULT NULL COMMENT '修改日期',
  `deleted_at` datetime DEFAULT NULL COMMENT '删除日期',
  PRIMARY KEY (`dict_id`) USING BTREE,
  UNIQUE KEY `dict_type` (`dict_type`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=72 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='字典类型表';

-- ----------------------------
-- Records of sys_dict_type
-- ----------------------------
BEGIN;
INSERT INTO `sys_dict_type` (`dict_id`, `dict_name`, `dict_type`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (1, '用户性别', 'sys_user_sex', 1, 31, 1, '用于选择用户性别', NULL, NULL, NULL);
INSERT INTO `sys_dict_type` (`dict_id`, `dict_name`, `dict_type`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (3, '任务状态', 'sys_job_status', 1, 31, 31, '任务状态列表', NULL, NULL, NULL);
INSERT INTO `sys_dict_type` (`dict_id`, `dict_name`, `dict_type`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (13, '任务分组', 'sys_job_group', 1, 31, 0, '', NULL, NULL, NULL);
INSERT INTO `sys_dict_type` (`dict_id`, `dict_name`, `dict_type`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (14, '管理员登录状态', 'admin_login_status', 1, 31, 0, '', NULL, NULL, NULL);
INSERT INTO `sys_dict_type` (`dict_id`, `dict_name`, `dict_type`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (15, '操作日志状态', 'sys_oper_log_status', 1, 31, 0, '', NULL, NULL, NULL);
INSERT INTO `sys_dict_type` (`dict_id`, `dict_name`, `dict_type`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (16, '任务策略', 'sys_job_policy', 1, 31, 0, '', NULL, NULL, NULL);
INSERT INTO `sys_dict_type` (`dict_id`, `dict_name`, `dict_type`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (17, '菜单状态', 'sys_show_hide', 1, 31, 0, '菜单状态', NULL, NULL, NULL);
INSERT INTO `sys_dict_type` (`dict_id`, `dict_name`, `dict_type`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (18, '系统开关', 'sys_normal_disable', 1, 31, 31, '系统开关', NULL, NULL, NULL);
INSERT INTO `sys_dict_type` (`dict_id`, `dict_name`, `dict_type`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (24, '系统内置', 'sys_yes_no', 1, 31, 0, '', NULL, NULL, NULL);
INSERT INTO `sys_dict_type` (`dict_id`, `dict_name`, `dict_type`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (29, '政务工作模型分类', 'gov_cate_models', 1, 2, 0, '', NULL, NULL, NULL);
INSERT INTO `sys_dict_type` (`dict_id`, `dict_name`, `dict_type`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (30, '菜单模块类型', 'menu_module_type', 1, 2, 0, '', NULL, NULL, NULL);
INSERT INTO `sys_dict_type` (`dict_id`, `dict_name`, `dict_type`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (31, '工作流程类型', 'flow_type', 1, 2, 0, '', NULL, NULL, NULL);
INSERT INTO `sys_dict_type` (`dict_id`, `dict_name`, `dict_type`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (32, '工作流程审批状态', 'flow_status', 1, 31, 0, '工作流程审批状态', NULL, NULL, NULL);
INSERT INTO `sys_dict_type` (`dict_id`, `dict_name`, `dict_type`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (33, '博客分类类型', 'sys_blog_type', 1, 31, 31, '博客分类中的标志', NULL, NULL, NULL);
INSERT INTO `sys_dict_type` (`dict_id`, `dict_name`, `dict_type`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (34, '博客日志标志', 'sys_log_sign', 1, 31, 0, '博客日志管理中的标志数据字典', NULL, NULL, NULL);
INSERT INTO `sys_dict_type` (`dict_id`, `dict_name`, `dict_type`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (35, '工作流紧急状态', 'flow_level', 1, 31, 31, '', NULL, '2021-07-20 08:55:20', NULL);
INSERT INTO `sys_dict_type` (`dict_id`, `dict_name`, `dict_type`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (36, '设备', 'user_device', 1, 1, 0, '', '2023-10-06 20:26:53', '2023-10-06 20:26:53', NULL);
INSERT INTO `sys_dict_type` (`dict_id`, `dict_name`, `dict_type`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (37, '用户状态', 'user_status', 1, 1, 0, '', '2023-10-06 20:27:59', '2023-10-06 20:27:59', NULL);
INSERT INTO `sys_dict_type` (`dict_id`, `dict_name`, `dict_type`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (38, 'shh登录方式', 'sshLoginType', 1, 1, 0, '', '2023-10-06 20:54:07', '2023-10-06 20:54:07', NULL);
INSERT INTO `sys_dict_type` (`dict_id`, `dict_name`, `dict_type`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (39, '国家', 'nation', 1, 1, 0, '', '2023-10-06 20:56:45', '2023-10-06 20:56:45', NULL);
INSERT INTO `sys_dict_type` (`dict_id`, `dict_name`, `dict_type`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (40, 'vpn状态', 'vpn_status', 1, 1, 0, '', '2023-10-06 21:04:52', '2023-10-06 21:04:52', NULL);
INSERT INTO `sys_dict_type` (`dict_id`, `dict_name`, `dict_type`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (41, '通用是否', 'isokrono', 1, 1, 0, '', '2023-10-12 13:38:06', '2023-10-12 13:38:06', NULL);
INSERT INTO `sys_dict_type` (`dict_id`, `dict_name`, `dict_type`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (42, '通用开关', 'isonoroff', 1, 1, 0, '', '2023-10-12 13:39:52', '2023-10-12 13:39:52', NULL);
INSERT INTO `sys_dict_type` (`dict_id`, `dict_name`, `dict_type`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (43, 'vpn协议', 'vpnprotocol', 1, 1, 0, '', '2023-10-12 13:40:57', '2023-10-12 13:40:57', NULL);
INSERT INTO `sys_dict_type` (`dict_id`, `dict_name`, `dict_type`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (44, '中转协议', 'transitprotocol', 1, 1, 0, '', '2023-10-12 13:41:15', '2023-10-12 13:41:15', NULL);
INSERT INTO `sys_dict_type` (`dict_id`, `dict_name`, `dict_type`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (45, '通用成功失败', 'cengorshibai', 1, 1, 0, '', '2023-10-12 14:13:17', '2023-10-12 14:13:17', NULL);
INSERT INTO `sys_dict_type` (`dict_id`, `dict_name`, `dict_type`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (46, '通用允许拒绝', 'yunxujujue', 1, 1, 0, '', '2023-10-13 13:18:55', '2023-10-13 13:18:55', NULL);
INSERT INTO `sys_dict_type` (`dict_id`, `dict_name`, `dict_type`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (47, '到期筛选', 'daoqisaixuan', 1, 1, 0, '', '2023-10-13 13:28:54', '2023-10-13 13:28:54', NULL);
INSERT INTO `sys_dict_type` (`dict_id`, `dict_name`, `dict_type`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (48, '活动类型', 'huodongtype', 1, 1, 0, '', '2023-10-26 13:56:20', '2023-10-26 13:56:20', NULL);
INSERT INTO `sys_dict_type` (`dict_id`, `dict_name`, `dict_type`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (49, '活动奖励类型', 'award_type', 1, 1, 0, '', '2023-10-26 13:57:50', '2023-10-26 13:57:50', NULL);
INSERT INTO `sys_dict_type` (`dict_id`, `dict_name`, `dict_type`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (50, '节点类型', 'node_type', 1, 1, 0, '', '2023-10-26 20:23:03', '2023-10-26 20:23:03', NULL);
INSERT INTO `sys_dict_type` (`dict_id`, `dict_name`, `dict_type`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (51, '套餐类型', 'combo_type', 1, 1, 0, '', '2023-10-26 21:44:36', '2023-10-26 21:44:36', NULL);
INSERT INTO `sys_dict_type` (`dict_id`, `dict_name`, `dict_type`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (52, '通用使用', 'tongyongshiyong', 1, 1, 0, '', '2023-10-27 16:03:35', '2023-10-27 16:03:35', NULL);
INSERT INTO `sys_dict_type` (`dict_id`, `dict_name`, `dict_type`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (53, '验证码类型', 'code_type', 1, 1, 0, '', '2023-10-27 16:05:12', '2023-10-27 16:05:12', NULL);
INSERT INTO `sys_dict_type` (`dict_id`, `dict_name`, `dict_type`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (54, '订单状态', 'order_status', 1, 1, 0, '', '2023-10-30 19:39:55', '2023-10-30 19:39:55', NULL);
INSERT INTO `sys_dict_type` (`dict_id`, `dict_name`, `dict_type`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (55, '带宽选择', 'bandwidths', 1, 1, 0, '', '2023-10-30 20:10:12', '2023-10-30 20:10:12', NULL);
INSERT INTO `sys_dict_type` (`dict_id`, `dict_name`, `dict_type`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (56, '订单类型', 'order_type', 1, 1, 0, '', '2023-10-30 20:21:58', '2023-10-30 20:21:58', NULL);
INSERT INTO `sys_dict_type` (`dict_id`, `dict_name`, `dict_type`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (57, '客户端终端', 'kehuduanzhongduan', 1, 1, 0, '', '2023-11-23 17:36:38', '2023-11-23 17:36:38', NULL);
INSERT INTO `sys_dict_type` (`dict_id`, `dict_name`, `dict_type`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (58, '包下载类型', 'baobaocun', 1, 1, 1, '', '2023-11-23 17:50:16', '2023-11-23 17:50:25', NULL);
INSERT INTO `sys_dict_type` (`dict_id`, `dict_name`, `dict_type`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (59, '客服类型', 'kefutype', 1, 1, 0, '', '2023-11-24 11:01:39', '2023-11-24 11:01:39', NULL);
INSERT INTO `sys_dict_type` (`dict_id`, `dict_name`, `dict_type`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (60, '智能选择分组', 'zhinengxuanzhe', 1, 49, 0, '', '2024-03-08 13:11:49', '2024-03-08 13:11:49', NULL);
INSERT INTO `sys_dict_type` (`dict_id`, `dict_name`, `dict_type`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (61, '商城平台', 'mall_device', 1, 1, 0, '', '2024-04-06 15:34:22', '2024-04-06 15:34:22', NULL);
INSERT INTO `sys_dict_type` (`dict_id`, `dict_name`, `dict_type`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (62, '解析状态', 'parse_status', 1, 1, 0, '', '2024-04-21 21:48:08', '2024-04-21 21:48:08', NULL);
INSERT INTO `sys_dict_type` (`dict_id`, `dict_name`, `dict_type`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (63, '分组类型', 'nodeGroupIdNodeType', 1, 1, 1, '', '2024-05-05 13:01:40', '2024-05-05 13:03:22', NULL);
INSERT INTO `sys_dict_type` (`dict_id`, `dict_name`, `dict_type`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (64, '不记录的域名', 'Donotrecorddomainnames', 1, 1, 0, '', '2024-05-16 19:30:57', '2024-05-16 19:30:57', NULL);
INSERT INTO `sys_dict_type` (`dict_id`, `dict_name`, `dict_type`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (65, 'DNS配置', 'serverDNS', 1, 1, 0, '', '2024-05-18 20:55:14', '2024-05-18 20:55:14', NULL);
INSERT INTO `sys_dict_type` (`dict_id`, `dict_name`, `dict_type`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (66, 'method', 'method', 1, 1, 0, '', '2024-06-09 15:06:40', '2024-06-09 15:06:40', NULL);
INSERT INTO `sys_dict_type` (`dict_id`, `dict_name`, `dict_type`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (67, '服务器CSV解析', 'servertxCSV', 1, 1, 0, '', '2024-06-14 16:22:38', '2024-06-14 16:22:38', NULL);
INSERT INTO `sys_dict_type` (`dict_id`, `dict_name`, `dict_type`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (68, '内网穿透协议', 'frpprotocol', 1, 1, 0, '', '2024-06-14 21:01:47', '2024-06-14 21:01:47', NULL);
INSERT INTO `sys_dict_type` (`dict_id`, `dict_name`, `dict_type`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (69, '多语言', 'langs', 1, 1, 0, '', '2024-10-10 17:59:58', '2024-10-10 17:59:58', NULL);
INSERT INTO `sys_dict_type` (`dict_id`, `dict_name`, `dict_type`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (70, 'banner', 'banner', 1, 1, 0, '', '2024-10-17 19:57:04', '2024-10-17 19:57:04', NULL);
INSERT INTO `sys_dict_type` (`dict_id`, `dict_name`, `dict_type`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (71, 'rout', 'rout', 1, 1, 0, '', '2024-10-18 19:14:04', '2024-10-18 19:14:04', NULL);
COMMIT;

-- ----------------------------
-- Table structure for sys_job
-- ----------------------------
DROP TABLE IF EXISTS `sys_job`;
CREATE TABLE `sys_job` (
  `job_id` bigint NOT NULL AUTO_INCREMENT COMMENT '任务ID',
  `job_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '任务名称',
  `job_params` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '参数',
  `job_group` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'DEFAULT' COMMENT '任务组名',
  `invoke_target` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调用目标字符串',
  `cron_expression` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT 'cron执行表达式',
  `misfire_policy` tinyint DEFAULT '1' COMMENT '计划执行策略（1多次执行 2执行一次）',
  `concurrent` tinyint DEFAULT '1' COMMENT '是否并发执行（0允许 1禁止）',
  `status` tinyint DEFAULT '0' COMMENT '状态（0正常 1暂停）',
  `create_by` bigint unsigned DEFAULT '0' COMMENT '创建者',
  `update_by` bigint unsigned DEFAULT '0' COMMENT '更新者',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '备注信息',
  `created_at` datetime DEFAULT NULL COMMENT '创建时间',
  `updated_at` datetime DEFAULT NULL COMMENT '更新时间',
  `deleted_at` datetime DEFAULT NULL COMMENT '删除时间',
  PRIMARY KEY (`job_id`,`job_name`,`job_group`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='定时任务调度表';

-- ----------------------------
-- Records of sys_job
-- ----------------------------
BEGIN;
INSERT INTO `sys_job` (`job_id`, `job_name`, `job_params`, `job_group`, `invoke_target`, `cron_expression`, `misfire_policy`, `concurrent`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (1, '节点在线状态检查', '', 'SYSTEM', 'nodeOnline', '*/5 * * * * ?', 1, 0, 1, 1, 1, '', NULL, '2023-11-23 16:07:55', '2024-01-22 22:26:01');
INSERT INTO `sys_job` (`job_id`, `job_name`, `job_params`, `job_group`, `invoke_target`, `cron_expression`, `misfire_policy`, `concurrent`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (2, '服务器在线状态检查', '', 'SYSTEM', 'serverOnline', '*/5 * * * * ?', 1, 0, 1, 1, 1, '备注', NULL, '2023-11-23 16:08:22', '2024-01-22 22:26:01');
INSERT INTO `sys_job` (`job_id`, `job_name`, `job_params`, `job_group`, `invoke_target`, `cron_expression`, `misfire_policy`, `concurrent`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (6, '测试任务3', 'hello|gfast', 'DEFAULT', 'test2', '* * * * * *', 1, 0, 1, 1, 31, '备注', NULL, NULL, '2021-07-16 16:51:20');
INSERT INTO `sys_job` (`job_id`, `job_name`, `job_params`, `job_group`, `invoke_target`, `cron_expression`, `misfire_policy`, `concurrent`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (8, '在线用户定时更新', '', 'DEFAULT', 'checkUserOnline', '5 */10 * * * ?', 1, 0, 0, 2, 1, '', NULL, '2021-07-19 08:57:24', NULL);
INSERT INTO `sys_job` (`job_id`, `job_name`, `job_params`, `job_group`, `invoke_target`, `cron_expression`, `misfire_policy`, `concurrent`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (9, '测试', 'arg1', 'DEFAULT', 'demo1', ' */5 * * * * ? ', 1, 1, 1, 31, 31, '', '2021-07-15 15:00:15', '2021-07-16 16:47:56', '2021-07-16 16:48:00');
INSERT INTO `sys_job` (`job_id`, `job_name`, `job_params`, `job_group`, `invoke_target`, `cron_expression`, `misfire_policy`, `concurrent`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (10, '测试', 'arg1', 'DEFAULT', 'demo1', ' */5 * * * * ? ', 2, 1, 1, 31, 31, '', '2021-07-15 22:12:15', '2021-07-16 16:47:52', '2021-07-16 16:48:00');
INSERT INTO `sys_job` (`job_id`, `job_name`, `job_params`, `job_group`, `invoke_target`, `cron_expression`, `misfire_policy`, `concurrent`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (11, '测试', 'arg1', 'DEFAULT', 'demo1', ' */5 * * * * ? ', 2, 1, 1, 31, 31, '', '2021-07-16 08:49:43', '2021-07-16 08:59:32', '2021-07-16 16:46:51');
INSERT INTO `sys_job` (`job_id`, `job_name`, `job_params`, `job_group`, `invoke_target`, `cron_expression`, `misfire_policy`, `concurrent`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (12, '测试366', 'arg1', 'DEFAULT', 'demo1', ' */5 * * * * ? ', 2, 1, 1, 31, 31, '', '2021-07-16 08:50:10', '2021-07-16 08:59:26', '2021-07-16 16:46:51');
INSERT INTO `sys_job` (`job_id`, `job_name`, `job_params`, `job_group`, `invoke_target`, `cron_expression`, `misfire_policy`, `concurrent`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (13, '用户到期套餐删除', '', 'SYSTEM', 'userNodeMaturity', '*/5 * * * * ?', 1, 1, 1, 1, 0, '', '2023-11-23 16:08:58', '2023-11-23 16:08:58', '2024-01-22 22:26:01');
INSERT INTO `sys_job` (`job_id`, `job_name`, `job_params`, `job_group`, `invoke_target`, `cron_expression`, `misfire_policy`, `concurrent`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (14, '流量重置', '', 'SYSTEM', 'checkUserOnline', '0 0 * * * ?', 1, 1, 1, 1, 0, '', '2023-11-25 14:48:35', '2023-11-25 14:48:35', '2024-01-22 23:16:07');
INSERT INTO `sys_job` (`job_id`, `job_name`, `job_params`, `job_group`, `invoke_target`, `cron_expression`, `misfire_policy`, `concurrent`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (15, '节点ping', '', 'SYSTEM', 'nodeSpeedTestTask', '20 */1 * * * ?', 1, 0, 1, 1, 1, '', '2023-11-25 14:48:35', '2024-01-11 11:18:42', '2024-01-22 22:26:01');
INSERT INTO `sys_job` (`job_id`, `job_name`, `job_params`, `job_group`, `invoke_target`, `cron_expression`, `misfire_policy`, `concurrent`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (16, '定时拨号', '', 'SYSTEM', 'nodeServersPppoeReStartTask', '0 0 * * * ?', 1, 1, 0, 1, 0, '', '2023-12-29 17:33:46', '2023-12-29 17:33:46', NULL);
INSERT INTO `sys_job` (`job_id`, `job_name`, `job_params`, `job_group`, `invoke_target`, `cron_expression`, `misfire_policy`, `concurrent`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (17, '更新服务器用量', '', 'SYSTEM', 'globalTrafficsTask', '*/1 * * * * ?', 1, 1, 1, 1, 1, '', '2024-01-21 18:40:13', '2024-01-21 19:36:04', '2024-01-22 22:26:01');
INSERT INTO `sys_job` (`job_id`, `job_name`, `job_params`, `job_group`, `invoke_target`, `cron_expression`, `misfire_policy`, `concurrent`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (18, '更新用户用量', '', 'SYSTEM', 'emailTrafficsTask', '*/1 * * * * ?', 1, 1, 1, 1, 1, '', '2024-01-21 18:40:40', '2024-01-21 19:36:12', '2024-01-22 22:26:01');
INSERT INTO `sys_job` (`job_id`, `job_name`, `job_params`, `job_group`, `invoke_target`, `cron_expression`, `misfire_policy`, `concurrent`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (19, 'VPN服务节点监控', '', 'DEFAULT', 'serverInfoRobot', '0 0 1 1 * ?', 2, 1, 0, 1, 1, '', '2024-01-25 16:15:08', '2024-01-25 17:07:42', NULL);
COMMIT;

-- ----------------------------
-- Table structure for sys_login_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_login_log`;
CREATE TABLE `sys_login_log` (
  `info_id` bigint NOT NULL AUTO_INCREMENT COMMENT '访问ID',
  `login_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '登录账号',
  `ipaddr` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '登录IP地址',
  `login_location` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '登录地点',
  `browser` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '浏览器类型',
  `os` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '操作系统',
  `status` tinyint DEFAULT '0' COMMENT '登录状态（0成功 1失败）',
  `msg` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '提示消息',
  `login_time` datetime DEFAULT NULL COMMENT '登录时间',
  `module` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '登录模块',
  PRIMARY KEY (`info_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=81 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='系统访问记录';

-- ----------------------------
-- Records of sys_login_log
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for sys_model_info
-- ----------------------------
DROP TABLE IF EXISTS `sys_model_info`;
CREATE TABLE `sys_model_info` (
  `model_id` int unsigned NOT NULL AUTO_INCREMENT COMMENT '模型ID',
  `model_category_id` int unsigned NOT NULL DEFAULT '0' COMMENT '模板分类id',
  `model_name` char(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '模型标识',
  `model_title` char(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '模型名称',
  `model_pk` char(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '主键字段',
  `model_order` char(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '默认排序字段',
  `model_sort` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '表单字段排序',
  `model_list` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '列表显示字段，为空显示全部',
  `model_edit` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '可编辑字段，为空则除主键外均可以编辑',
  `model_indexes` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '索引字段',
  `search_list` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '高级搜索的字段',
  `create_time` bigint unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` bigint unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `model_status` tinyint unsigned NOT NULL DEFAULT '0' COMMENT '状态',
  `model_engine` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'MyISAM' COMMENT '数据库引擎',
  `create_by` bigint unsigned NOT NULL DEFAULT '0' COMMENT '创建人',
  `update_by` bigint unsigned NOT NULL DEFAULT '0' COMMENT '修改人',
  PRIMARY KEY (`model_id`) USING BTREE,
  UNIQUE KEY `name_uni` (`model_name`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='文档模型表';

-- ----------------------------
-- Records of sys_model_info
-- ----------------------------
BEGIN;
INSERT INTO `sys_model_info` (`model_id`, `model_category_id`, `model_name`, `model_title`, `model_pk`, `model_order`, `model_sort`, `model_list`, `model_edit`, `model_indexes`, `search_list`, `create_time`, `update_time`, `model_status`, `model_engine`, `create_by`, `update_by`) VALUES (1, 5, 'house_info', '房屋信息', 'house_id', 'hi_order', 'house_id', 'house_id,belong_houses,belong_house_type,door_number', 'belong_houses,belong_house_type,door_number', 'door_number', 'belong_houses,belong_house_type,door_number', 1498101800, 1605838046, 1, 'MyISAM', 0, 1);
INSERT INTO `sys_model_info` (`model_id`, `model_category_id`, `model_name`, `model_title`, `model_pk`, `model_order`, `model_sort`, `model_list`, `model_edit`, `model_indexes`, `search_list`, `create_time`, `update_time`, `model_status`, `model_engine`, `create_by`, `update_by`) VALUES (9, 6, 'cms_news_attr', '文章模型', 'art_id', '', 'art_id', 'news_info,text_demo', 'news_content,thumbnail,news_files,news_file,news_imgs,news_title,news_info,text_demo,time_demo', '', 'news_info,text_demo', 1595316217, 1596095352, 1, 'InnoDB', 1, 31);
INSERT INTO `sys_model_info` (`model_id`, `model_category_id`, `model_name`, `model_title`, `model_pk`, `model_order`, `model_sort`, `model_list`, `model_edit`, `model_indexes`, `search_list`, `create_time`, `update_time`, `model_status`, `model_engine`, `create_by`, `update_by`) VALUES (10, 1, 'gov_work_report', '政府工作报告', 'matter_id', 'matter_id', '', 'title,content,sponsor,organizer', 'title,content,sponsor,organizer', 'matter_id', 'title', 1596528880, 1599701551, 1, 'InnoDB', 2, 31);
INSERT INTO `sys_model_info` (`model_id`, `model_category_id`, `model_name`, `model_title`, `model_pk`, `model_order`, `model_sort`, `model_list`, `model_edit`, `model_indexes`, `search_list`, `create_time`, `update_time`, `model_status`, `model_engine`, `create_by`, `update_by`) VALUES (12, 1, 'gov_work_major_project', '重大项目', 'matter_id', 'matter_id', '', 'project_no,title,content,sponsor,total_investment,annual_investment,progress_status', 'project_no,title,content,sponsor,total_investment,annual_investment,progress_status', 'matter_id', 'title', 1599702575, 1605512186, 1, 'InnoDB', 31, 1);
INSERT INTO `sys_model_info` (`model_id`, `model_category_id`, `model_name`, `model_title`, `model_pk`, `model_order`, `model_sort`, `model_list`, `model_edit`, `model_indexes`, `search_list`, `create_time`, `update_time`, `model_status`, `model_engine`, `create_by`, `update_by`) VALUES (13, 1, 'gov_work_important_documents', '重要文件办理', 'matter_id', 'matter_id', '', 'title,original_unit,document_number,receive_time,sponsor,content', 'title,original_unit,document_number,receive_time,sponsor,content', 'matter_id', 'title', 1599710390, 1599710390, 1, 'InnoDB', 31, 0);
INSERT INTO `sys_model_info` (`model_id`, `model_category_id`, `model_name`, `model_title`, `model_pk`, `model_order`, `model_sort`, `model_list`, `model_edit`, `model_indexes`, `search_list`, `create_time`, `update_time`, `model_status`, `model_engine`, `create_by`, `update_by`) VALUES (14, 1, 'gov_work_livelihood', '民生目标', 'matter_id', 'matter_id', '', 'title,type,content,sponsor,organizer', 'title,type,content,sponsor,organizer', 'matter_id', 'title', 1599721999, 1599721999, 1, 'InnoDB', 31, 0);
INSERT INTO `sys_model_info` (`model_id`, `model_category_id`, `model_name`, `model_title`, `model_pk`, `model_order`, `model_sort`, `model_list`, `model_edit`, `model_indexes`, `search_list`, `create_time`, `update_time`, `model_status`, `model_engine`, `create_by`, `update_by`) VALUES (15, 1, 'gov_work_meeting', '会议议定', 'matter_id', 'matter_id', '', 'title,content,sponsor,organizer', 'title,content,sponsor,organizer', 'matter_id', 'title', 1599722042, 1605512125, 1, 'InnoDB', 31, 1);
INSERT INTO `sys_model_info` (`model_id`, `model_category_id`, `model_name`, `model_title`, `model_pk`, `model_order`, `model_sort`, `model_list`, `model_edit`, `model_indexes`, `search_list`, `create_time`, `update_time`, `model_status`, `model_engine`, `create_by`, `update_by`) VALUES (16, 1, 'gov_work_assigned_leader', '领导交办', 'matter_id', 'matter_id', '', 'title,number,content,sponsor,organizer,instruction_time,instruction_leader', 'title,number,content,sponsor,organizer,instruction_time,instruction_leader', 'matter_id', 'title', 1599722097, 1599722097, 1, 'InnoDB', 31, 0);
INSERT INTO `sys_model_info` (`model_id`, `model_category_id`, `model_name`, `model_title`, `model_pk`, `model_order`, `model_sort`, `model_list`, `model_edit`, `model_indexes`, `search_list`, `create_time`, `update_time`, `model_status`, `model_engine`, `create_by`, `update_by`) VALUES (17, 1, 'gov_work_other', '其它任务', 'matter_id', 'matter_id', '', 'title,content,sponsor,organizer', 'title,content,sponsor,organizer', 'matter_id', 'title', 1599722127, 1599722127, 1, 'InnoDB', 31, 0);
INSERT INTO `sys_model_info` (`model_id`, `model_category_id`, `model_name`, `model_title`, `model_pk`, `model_order`, `model_sort`, `model_list`, `model_edit`, `model_indexes`, `search_list`, `create_time`, `update_time`, `model_status`, `model_engine`, `create_by`, `update_by`) VALUES (18, 1, 'gov_work_investment', '招商引资', 'matter_id', 'matter_id', '', 'project_type,title,company_name,investment_volume,paid_in_investment,content,address,project_progress,project_target,manage_leader,responsible_department,sponsor,organizer,remark', 'project_type,title,company_name,investment_volume,paid_in_investment,content,address,project_progress,project_target,manage_leader,responsible_department,sponsor,organizer,remark', '', 'title', 1611542517, 1611542540, 1, 'InnoDB', 1, 1);
COMMIT;

-- ----------------------------
-- Table structure for sys_oper_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_oper_log`;
CREATE TABLE `sys_oper_log` (
  `oper_id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '日志主键',
  `title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '模块标题',
  `business_type` int DEFAULT '0' COMMENT '业务类型（0其它 1新增 2修改 3删除）',
  `method` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '方法名称',
  `request_method` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '请求方式',
  `operator_type` int DEFAULT '0' COMMENT '操作类别（0其它 1后台用户 2手机端用户）',
  `oper_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '操作人员',
  `dept_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '部门名称',
  `oper_url` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '请求URL',
  `oper_ip` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `oper_location` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '操作地点',
  `oper_param` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '请求参数',
  `json_result` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '返回参数',
  `status` int DEFAULT '0' COMMENT '操作状态（0正常 1异常）',
  `error_msg` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '错误消息',
  `oper_time` datetime DEFAULT NULL COMMENT '操作时间',
  PRIMARY KEY (`oper_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=68778 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='操作日志记录';

-- ----------------------------
-- Records of sys_oper_log
-- ----------------------------
BEGIN;
INSERT INTO `sys_oper_log` (`oper_id`, `title`, `business_type`, `method`, `request_method`, `operator_type`, `oper_name`, `dept_name`, `oper_url`, `oper_ip`, `oper_location`, `oper_param`, `json_result`, `status`, `error_msg`, `oper_time`) VALUES (68760, '', 0, '/system/user/getInfo', 'GET', 1, 'admin', '深圳总公司', '/system/user/getInfo', '127.0.0.1', '内网IP', '{}', '{\"code\":0,\"msg\":\"success\"}', 1, '', '2025-03-25 15:40:29');
INSERT INTO `sys_oper_log` (`oper_id`, `title`, `business_type`, `method`, `request_method`, `operator_type`, `oper_name`, `dept_name`, `oper_url`, `oper_ip`, `oper_location`, `oper_param`, `json_result`, `status`, `error_msg`, `oper_time`) VALUES (68761, '', 0, '/system/user/getRouters', 'GET', 1, 'admin', '深圳总公司', '/system/user/getRouters', '127.0.0.1', '内网IP', '{}', '{\"code\":0,\"msg\":\"success\"}', 1, '', '2025-03-25 15:40:29');
INSERT INTO `sys_oper_log` (`oper_id`, `title`, `business_type`, `method`, `request_method`, `operator_type`, `oper_name`, `dept_name`, `oper_url`, `oper_ip`, `oper_location`, `oper_param`, `json_result`, `status`, `error_msg`, `oper_time`) VALUES (68762, '', 0, '/system/config/dict/data/GetDictData', 'GET', 1, 'admin', '深圳总公司', '/system/config/dict/data/GetDictData?dictType=isonoroff&defaultValue=', '127.0.0.1', '内网IP', '{\"defaultValue\":\"\",\"dictType\":\"isonoroff\"}', '{\"code\":0,\"msg\":\"success\"}', 1, '', '2025-03-25 15:40:29');
INSERT INTO `sys_oper_log` (`oper_id`, `title`, `business_type`, `method`, `request_method`, `operator_type`, `oper_name`, `dept_name`, `oper_url`, `oper_ip`, `oper_location`, `oper_param`, `json_result`, `status`, `error_msg`, `oper_time`) VALUES (68763, '', 0, '/system/config/dict/data/GetDictData', 'GET', 1, 'admin', '深圳总公司', '/system/config/dict/data/GetDictData?dictType=vpn_status&defaultValue=', '127.0.0.1', '内网IP', '{\"defaultValue\":\"\",\"dictType\":\"vpn_status\"}', '{\"code\":0,\"msg\":\"success\"}', 1, '', '2025-03-25 15:40:29');
INSERT INTO `sys_oper_log` (`oper_id`, `title`, `business_type`, `method`, `request_method`, `operator_type`, `oper_name`, `dept_name`, `oper_url`, `oper_ip`, `oper_location`, `oper_param`, `json_result`, `status`, `error_msg`, `oper_time`) VALUES (68764, '', 0, '/system/config/dict/data/GetDictData', 'GET', 1, 'admin', '深圳总公司', '/system/config/dict/data/GetDictData?dictType=frpprotocol&defaultValue=', '127.0.0.1', '内网IP', '{\"defaultValue\":\"\",\"dictType\":\"frpprotocol\"}', '{\"code\":0,\"msg\":\"success\"}', 1, '', '2025-03-25 15:40:29');
INSERT INTO `sys_oper_log` (`oper_id`, `title`, `business_type`, `method`, `request_method`, `operator_type`, `oper_name`, `dept_name`, `oper_url`, `oper_ip`, `oper_location`, `oper_param`, `json_result`, `status`, `error_msg`, `oper_time`) VALUES (68765, '地区列表', 0, '/vpn/vpnNodeNation/list', 'GET', 1, 'admin', '深圳总公司', '/vpn/vpnNodeNation/list?pageSize=10000', '127.0.0.1', '内网IP', '{\"pageSize\":\"10000\"}', '{\"code\":0,\"msg\":\"success\"}', 1, '', '2025-03-25 15:40:29');
INSERT INTO `sys_oper_log` (`oper_id`, `title`, `business_type`, `method`, `request_method`, `operator_type`, `oper_name`, `dept_name`, `oper_url`, `oper_ip`, `oper_location`, `oper_param`, `json_result`, `status`, `error_msg`, `oper_time`) VALUES (68766, '', 0, '/system/config/dict/data/GetDictData', 'GET', 1, 'admin', '深圳总公司', '/system/config/dict/data/GetDictData?dictType=method&defaultValue=', '127.0.0.1', '内网IP', '{\"defaultValue\":\"\",\"dictType\":\"method\"}', '{\"code\":0,\"msg\":\"success\"}', 1, '', '2025-03-25 15:40:29');
INSERT INTO `sys_oper_log` (`oper_id`, `title`, `business_type`, `method`, `request_method`, `operator_type`, `oper_name`, `dept_name`, `oper_url`, `oper_ip`, `oper_location`, `oper_param`, `json_result`, `status`, `error_msg`, `oper_time`) VALUES (68767, '服务器管理', 0, '/vpn/vpnServer/list', 'GET', 1, 'admin', '深圳总公司', '/vpn/vpnServer/list?pageSize=10000', '127.0.0.1', '内网IP', '{\"pageSize\":\"10000\"}', '{\"code\":0,\"msg\":\"success\"}', 1, '', '2025-03-25 15:40:29');
INSERT INTO `sys_oper_log` (`oper_id`, `title`, `business_type`, `method`, `request_method`, `operator_type`, `oper_name`, `dept_name`, `oper_url`, `oper_ip`, `oper_location`, `oper_param`, `json_result`, `status`, `error_msg`, `oper_time`) VALUES (68768, '节点列表', 0, '/vpn/vpnNode/list', 'GET', 1, 'admin', '深圳总公司', '/vpn/vpnNode/list?pageNum=1&pageSize=10&orderBy=vpn_node.nation_id+desc,vpn_node.node_id+desc', '127.0.0.1', '内网IP', '{\"orderBy\":\"vpn_node.nation_id desc,vpn_node.node_id desc\",\"pageNum\":\"1\",\"pageSize\":\"10\"}', '{\"code\":0,\"msg\":\"success\"}', 1, '', '2025-03-25 15:40:29');
INSERT INTO `sys_oper_log` (`oper_id`, `title`, `business_type`, `method`, `request_method`, `operator_type`, `oper_name`, `dept_name`, `oper_url`, `oper_ip`, `oper_location`, `oper_param`, `json_result`, `status`, `error_msg`, `oper_time`) VALUES (68769, '服务器管理', 0, '/vpn/vpnServer/list', 'GET', 1, 'admin', '深圳总公司', '/vpn/vpnServer/list?pageSize=10&orderBy=vpn_server.server_group_id+desc,vpn_server.server_group_id+desc&search=&pageNum=1', '127.0.0.1', '内网IP', '{\"orderBy\":\"vpn_server.server_group_id desc,vpn_server.server_group_id desc\",\"pageNum\":\"1\",\"pageSize\":\"10\",\"search\":\"\"}', '{\"code\":0,\"msg\":\"success\"}', 1, '', '2025-03-25 15:40:29');
INSERT INTO `sys_oper_log` (`oper_id`, `title`, `business_type`, `method`, `request_method`, `operator_type`, `oper_name`, `dept_name`, `oper_url`, `oper_ip`, `oper_location`, `oper_param`, `json_result`, `status`, `error_msg`, `oper_time`) VALUES (68770, '服务器管理', 0, '/vpn/vpnServer/list', 'GET', 1, 'admin', '深圳总公司', '/vpn/vpnServer/list?pageSize=10000', '127.0.0.1', '内网IP', '{\"pageSize\":\"10000\"}', '{\"code\":0,\"msg\":\"success\"}', 1, '', '2025-03-25 15:40:29');
INSERT INTO `sys_oper_log` (`oper_id`, `title`, `business_type`, `method`, `request_method`, `operator_type`, `oper_name`, `dept_name`, `oper_url`, `oper_ip`, `oper_location`, `oper_param`, `json_result`, `status`, `error_msg`, `oper_time`) VALUES (68771, '服务器管理', 0, '/vpn/vpnServer/list', 'GET', 1, 'admin', '深圳总公司', '/vpn/vpnServer/list?pageSize=10000', '127.0.0.1', '内网IP', '{\"pageSize\":\"10000\"}', '{\"code\":0,\"msg\":\"success\"}', 1, '', '2025-03-25 15:40:29');
INSERT INTO `sys_oper_log` (`oper_id`, `title`, `business_type`, `method`, `request_method`, `operator_type`, `oper_name`, `dept_name`, `oper_url`, `oper_ip`, `oper_location`, `oper_param`, `json_result`, `status`, `error_msg`, `oper_time`) VALUES (68772, '', 0, '/system/dashboard/info', 'GET', 1, 'admin', '深圳总公司', '/system/dashboard/info', '127.0.0.1', '内网IP', '{}', '{\"code\":0,\"msg\":\"success\"}', 1, '', '2025-03-25 15:40:32');
INSERT INTO `sys_oper_log` (`oper_id`, `title`, `business_type`, `method`, `request_method`, `operator_type`, `oper_name`, `dept_name`, `oper_url`, `oper_ip`, `oper_location`, `oper_param`, `json_result`, `status`, `error_msg`, `oper_time`) VALUES (68773, '', 0, '/system/config/dict/data/GetDictData', 'GET', 1, 'admin', '深圳总公司', '/system/config/dict/data/GetDictData?dictType=sshLoginType&defaultValue=', '127.0.0.1', '内网IP', '{\"defaultValue\":\"\",\"dictType\":\"sshLoginType\"}', '{\"code\":0,\"msg\":\"success\"}', 1, '', '2025-03-25 15:40:34');
INSERT INTO `sys_oper_log` (`oper_id`, `title`, `business_type`, `method`, `request_method`, `operator_type`, `oper_name`, `dept_name`, `oper_url`, `oper_ip`, `oper_location`, `oper_param`, `json_result`, `status`, `error_msg`, `oper_time`) VALUES (68774, '', 0, '/system/config/dict/data/GetDictData', 'GET', 1, 'admin', '深圳总公司', '/system/config/dict/data/GetDictData?dictType=vpn_status&defaultValue=', '127.0.0.1', '内网IP', '{\"defaultValue\":\"\",\"dictType\":\"vpn_status\"}', '{\"code\":0,\"msg\":\"success\"}', 1, '', '2025-03-25 15:40:34');
INSERT INTO `sys_oper_log` (`oper_id`, `title`, `business_type`, `method`, `request_method`, `operator_type`, `oper_name`, `dept_name`, `oper_url`, `oper_ip`, `oper_location`, `oper_param`, `json_result`, `status`, `error_msg`, `oper_time`) VALUES (68775, '', 0, '/system/config/dict/data/GetDictData', 'GET', 1, 'admin', '深圳总公司', '/system/config/dict/data/GetDictData?dictType=isokrono&defaultValue=', '127.0.0.1', '内网IP', '{\"defaultValue\":\"\",\"dictType\":\"isokrono\"}', '{\"code\":0,\"msg\":\"success\"}', 1, '', '2025-03-25 15:40:34');
INSERT INTO `sys_oper_log` (`oper_id`, `title`, `business_type`, `method`, `request_method`, `operator_type`, `oper_name`, `dept_name`, `oper_url`, `oper_ip`, `oper_location`, `oper_param`, `json_result`, `status`, `error_msg`, `oper_time`) VALUES (68776, '', 0, '/system/config/dict/data/GetDictData', 'GET', 1, 'admin', '深圳总公司', '/system/config/dict/data/GetDictData?dictType=shifouzhici&defaultValue=', '127.0.0.1', '内网IP', '{\"defaultValue\":\"\",\"dictType\":\"shifouzhici\"}', '{\"code\":0,\"msg\":\"success\"}', 1, '', '2025-03-25 15:40:34');
INSERT INTO `sys_oper_log` (`oper_id`, `title`, `business_type`, `method`, `request_method`, `operator_type`, `oper_name`, `dept_name`, `oper_url`, `oper_ip`, `oper_location`, `oper_param`, `json_result`, `status`, `error_msg`, `oper_time`) VALUES (68777, '服务器管理', 0, '/vpn/vpnServer/list', 'GET', 1, 'admin', '深圳总公司', '/vpn/vpnServer/list?pageNum=1&pageSize=10', '127.0.0.1', '内网IP', '{\"pageNum\":\"1\",\"pageSize\":\"10\"}', '{\"code\":0,\"msg\":\"success\"}', 1, '', '2025-03-25 15:40:34');
COMMIT;

-- ----------------------------
-- Table structure for sys_post
-- ----------------------------
DROP TABLE IF EXISTS `sys_post`;
CREATE TABLE `sys_post` (
  `post_id` bigint NOT NULL AUTO_INCREMENT COMMENT '岗位ID',
  `post_code` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '岗位编码',
  `post_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '岗位名称',
  `post_sort` int NOT NULL COMMENT '显示顺序',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '状态（0正常 1停用）',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '备注',
  `created_by` bigint unsigned NOT NULL DEFAULT '0' COMMENT '创建人',
  `updated_by` bigint unsigned NOT NULL DEFAULT '0' COMMENT '修改人',
  `created_at` datetime DEFAULT NULL COMMENT '创建时间',
  `updated_at` datetime DEFAULT NULL COMMENT '修改时间',
  `deleted_at` datetime DEFAULT NULL COMMENT '删除时间',
  PRIMARY KEY (`post_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='岗位信息表';

-- ----------------------------
-- Records of sys_post
-- ----------------------------
BEGIN;
INSERT INTO `sys_post` (`post_id`, `post_code`, `post_name`, `post_sort`, `status`, `remark`, `created_by`, `updated_by`, `created_at`, `updated_at`, `deleted_at`) VALUES (1, 'ceo', '董事长', 1, '1', '', 0, 0, '2021-07-11 11:32:58', NULL, NULL);
INSERT INTO `sys_post` (`post_id`, `post_code`, `post_name`, `post_sort`, `status`, `remark`, `created_by`, `updated_by`, `created_at`, `updated_at`, `deleted_at`) VALUES (2, 'se', '项目经理', 2, '1', '', 0, 0, '2021-07-12 11:01:26', NULL, NULL);
INSERT INTO `sys_post` (`post_id`, `post_code`, `post_name`, `post_sort`, `status`, `remark`, `created_by`, `updated_by`, `created_at`, `updated_at`, `deleted_at`) VALUES (3, 'hr', '人力资源', 3, '1', '', 0, 0, '2021-07-12 11:01:30', NULL, NULL);
INSERT INTO `sys_post` (`post_id`, `post_code`, `post_name`, `post_sort`, `status`, `remark`, `created_by`, `updated_by`, `created_at`, `updated_at`, `deleted_at`) VALUES (4, 'user', '普通员工', 4, '1', '', 0, 0, '2021-07-12 11:01:33', NULL, NULL);
INSERT INTO `sys_post` (`post_id`, `post_code`, `post_name`, `post_sort`, `status`, `remark`, `created_by`, `updated_by`, `created_at`, `updated_at`, `deleted_at`) VALUES (5, 'it', 'IT部', 5, '1', '信息部', 31, 31, '2021-07-12 11:09:42', '2021-07-12 11:21:00', NULL);
INSERT INTO `sys_post` (`post_id`, `post_code`, `post_name`, `post_sort`, `status`, `remark`, `created_by`, `updated_by`, `created_at`, `updated_at`, `deleted_at`) VALUES (6, 'asd', 'aaa', 100, '0', '', 31, 0, '2021-07-12 11:21:12', '2021-07-12 11:21:12', '2021-07-12 11:24:49');
INSERT INTO `sys_post` (`post_id`, `post_code`, `post_name`, `post_sort`, `status`, `remark`, `created_by`, `updated_by`, `created_at`, `updated_at`, `deleted_at`) VALUES (7, 'asda', 'ddd', 222, '0', 'asdas', 31, 31, '2021-07-12 11:21:18', '2021-07-12 11:21:27', '2021-07-12 11:24:49');
INSERT INTO `sys_post` (`post_id`, `post_code`, `post_name`, `post_sort`, `status`, `remark`, `created_by`, `updated_by`, `created_at`, `updated_at`, `deleted_at`) VALUES (8, 'dasd', 'dasd', 3444, '0', 'asdas', 31, 31, '2021-07-12 11:21:22', '2021-07-12 11:21:31', '2021-07-12 11:24:45');
COMMIT;

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `status` tinyint unsigned NOT NULL DEFAULT '0' COMMENT '状态;0:禁用;1:正常',
  `list_order` float NOT NULL DEFAULT '0' COMMENT '排序',
  `name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '角色名称',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '备注',
  `data_scope` tinyint unsigned NOT NULL DEFAULT '3' COMMENT '数据范围（1：全部数据权限 2：自定数据权限 3：本部门数据权限 4：本部门及以下数据权限）',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `status` (`status`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='角色表';

-- ----------------------------
-- Records of sys_role
-- ----------------------------
BEGIN;
INSERT INTO `sys_role` (`id`, `status`, `list_order`, `name`, `remark`, `data_scope`) VALUES (1, 1, 0, '超级管理员', '备注', 3);
INSERT INTO `sys_role` (`id`, `status`, `list_order`, `name`, `remark`, `data_scope`) VALUES (9, 1, 0, '管理员', '', 3);
INSERT INTO `sys_role` (`id`, `status`, `list_order`, `name`, `remark`, `data_scope`) VALUES (10, 1, 0, '业务员', '', 1);
COMMIT;

-- ----------------------------
-- Table structure for sys_role_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_dept`;
CREATE TABLE `sys_role_dept` (
  `role_id` bigint NOT NULL COMMENT '角色ID',
  `dept_id` bigint NOT NULL COMMENT '部门ID',
  PRIMARY KEY (`role_id`,`dept_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='角色和部门关联表';

-- ----------------------------
-- Records of sys_role_dept
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_name` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '用户名',
  `mobile` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '中国手机不带国家代码，国际手机号格式为：国家代码-手机号',
  `user_nickname` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '用户昵称',
  `birthday` int NOT NULL DEFAULT '0' COMMENT '生日',
  `user_password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '登录密码;cmf_password加密',
  `user_salt` char(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '加密盐',
  `user_status` tinyint unsigned NOT NULL DEFAULT '1' COMMENT '用户状态;0:禁用,1:正常,2:未验证',
  `user_email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '用户登录邮箱',
  `sex` tinyint NOT NULL DEFAULT '0' COMMENT '性别;0:保密,1:男,2:女',
  `avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '用户头像',
  `dept_id` bigint unsigned NOT NULL DEFAULT '0' COMMENT '部门id',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '备注',
  `is_admin` tinyint NOT NULL DEFAULT '1' COMMENT '是否后台管理员 1 是  0   否',
  `address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '联系地址',
  `describe` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT ' 描述信息',
  `phone_num` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '联系电话',
  `last_login_ip` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '最后登录ip',
  `last_login_time` datetime DEFAULT NULL COMMENT '最后登录时间',
  `created_at` datetime DEFAULT NULL COMMENT '创建时间',
  `updated_at` datetime DEFAULT NULL COMMENT '更新时间',
  `deleted_at` datetime DEFAULT NULL COMMENT '删除时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `user_login` (`user_name`) USING BTREE,
  KEY `user_nickname` (`user_nickname`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=52 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='用户表';

-- ----------------------------
-- Records of sys_user
-- ----------------------------
BEGIN;
INSERT INTO `sys_user` (`id`, `user_name`, `mobile`, `user_nickname`, `birthday`, `user_password`, `user_salt`, `user_status`, `user_email`, `sex`, `avatar`, `dept_id`, `remark`, `is_admin`, `address`, `describe`, `phone_num`, `last_login_ip`, `last_login_time`, `created_at`, `updated_at`, `deleted_at`) VALUES (1, 'admin', '13578342363', '超级管理员', 0, 'd2869e355bde4832d1c9cdd3388300e2', 'KdfHn13SO3', 1, 'aaaaa@qq.com', 1, 'https://yxh-1301841944.cos.ap-chongqing.myqcloud.com/gfast/2021-07-19/ccwpeuqz1i2s769hua.jpeg', 101, '', 1, 'asdasfdsaf大发放打发士大夫发按时', '描述信息', '18611111111', '127.0.0.1', '2025-03-28 13:02:41', '2021-06-22 17:58:00', '2024-10-19 11:46:37', NULL);
INSERT INTO `sys_user` (`id`, `user_name`, `mobile`, `user_nickname`, `birthday`, `user_password`, `user_salt`, `user_status`, `user_email`, `sex`, `avatar`, `dept_id`, `remark`, `is_admin`, `address`, `describe`, `phone_num`, `last_login_ip`, `last_login_time`, `created_at`, `updated_at`, `deleted_at`) VALUES (42, 'ceshi', '', 'ceshi', 0, 'cf8bf73a4de7d8d194fb99793ff56dd0', 'UH3cmEVshx', 1, 'ceshi@qq.com', 0, '', 0, '', 0, '', '', '', '', NULL, '2023-10-06 20:10:51', '2023-10-06 20:10:51', '2023-10-06 20:11:00');
INSERT INTO `sys_user` (`id`, `user_name`, `mobile`, `user_nickname`, `birthday`, `user_password`, `user_salt`, `user_status`, `user_email`, `sex`, `avatar`, `dept_id`, `remark`, `is_admin`, `address`, `describe`, `phone_num`, `last_login_ip`, `last_login_time`, `created_at`, `updated_at`, `deleted_at`) VALUES (49, 'vlinkadmin', '', '管理员', 0, 'f7359c48781458e5d390ba59240b8bba', 'w4qTqV1aNa', 1, 'vlink@gmail.com', 0, '', 0, '', 1, '', '', '', '91.149.202.201', '2024-03-29 10:55:06', '2023-12-18 18:32:05', '2023-12-18 18:32:05', '2024-03-30 21:33:59');
INSERT INTO `sys_user` (`id`, `user_name`, `mobile`, `user_nickname`, `birthday`, `user_password`, `user_salt`, `user_status`, `user_email`, `sex`, `avatar`, `dept_id`, `remark`, `is_admin`, `address`, `describe`, `phone_num`, `last_login_ip`, `last_login_time`, `created_at`, `updated_at`, `deleted_at`) VALUES (50, 'heiqi123', '', 'heiqi', 0, '108e52bb5e86da39142cb45209fd232f', 'l7xCRMceu4', 1, 'heiqi@gmail.com', 0, '', 0, '', 1, '', '', '', '194.135.104.76', '2024-04-01 10:26:42', '2024-04-01 10:23:42', '2024-04-01 10:23:42', '2024-04-01 20:49:49');
INSERT INTO `sys_user` (`id`, `user_name`, `mobile`, `user_nickname`, `birthday`, `user_password`, `user_salt`, `user_status`, `user_email`, `sex`, `avatar`, `dept_id`, `remark`, `is_admin`, `address`, `describe`, `phone_num`, `last_login_ip`, `last_login_time`, `created_at`, `updated_at`, `deleted_at`) VALUES (51, 'MINIXIONG', '', '小熊', 0, '4dc32214196c870eb8b31847ea2869d0', 'mAHgigT2Ih', 1, '1123@qq.com', 0, '', 0, '', 1, '', '', '', '202.190.254.113', '2024-06-17 20:59:02', '2024-04-01 20:51:52', '2024-10-19 11:46:33', '2025-03-24 21:09:09');
COMMIT;

-- ----------------------------
-- Table structure for sys_user_online
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_online`;
CREATE TABLE `sys_user_online` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `uuid` char(32) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL DEFAULT '' COMMENT '用户标识',
  `token` varchar(255) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL DEFAULT '' COMMENT '用户token',
  `create_time` datetime DEFAULT NULL COMMENT '登录时间',
  `user_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '用户名',
  `ip` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '登录ip',
  `explorer` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '浏览器',
  `os` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '操作系统',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uni_token` (`token`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=17500 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='用户在线状态表';

-- ----------------------------
-- Records of sys_user_online
-- ----------------------------
BEGIN;
INSERT INTO `sys_user_online` (`id`, `uuid`, `token`, `create_time`, `user_name`, `ip`, `explorer`, `os`) VALUES (17499, '2520b9dc14e3d9ddb751fe552ae9aeff', 'jbYKl72cbOGvbVRwIqM4r6eoirw8f1JRD44+4D5E/UTIrzGFkEPAvPHM3NHyNNAYFFm7drtaOuAa0zCM0y8mGS5Yi+S6MRk5UARS00R+2uQ4yrkCw5v/i9XdRdvv3JmaAUukHoWUwbw4K2fHJ63Kzg==', '2025-03-28 13:02:41', 'admin', '127.0.0.1', 'Chrome', 'Intel Mac OS X 10_15_7');
COMMIT;

-- ----------------------------
-- Table structure for sys_user_post
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_post`;
CREATE TABLE `sys_user_post` (
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `post_id` bigint NOT NULL COMMENT '岗位ID',
  PRIMARY KEY (`user_id`,`post_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='用户与岗位关联表';

-- ----------------------------
-- Records of sys_user_post
-- ----------------------------
BEGIN;
INSERT INTO `sys_user_post` (`user_id`, `post_id`) VALUES (1, 2);
INSERT INTO `sys_user_post` (`user_id`, `post_id`) VALUES (1, 3);
COMMIT;

-- ----------------------------
-- Table structure for sys_web_set
-- ----------------------------
DROP TABLE IF EXISTS `sys_web_set`;
CREATE TABLE `sys_web_set` (
  `web_id` int NOT NULL AUTO_INCREMENT COMMENT '主键',
  `web_content` json DEFAULT NULL COMMENT '站点信息',
  PRIMARY KEY (`web_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Records of sys_web_set
-- ----------------------------
BEGIN;
INSERT INTO `sys_web_set` (`web_id`, `web_content`) VALUES (1, '{\"smtp\": {\"smtpTls\": 1, \"stencil\": {\"en\": \"<body tabindex=\\\"0\\\" role=\\\"listitem\\\">\\n<table width=\\\"700\\\" border=\\\"0\\\" align=\\\"center\\\" cellspacing=\\\"0\\\" style=\\\"width:700px; background-color: #f9f9f9; border: 1px solid #ddd; border-radius: 8px; padding: 20px;\\\">\\n    <tbody>\\n    <tr>\\n        <td>\\n            <div style=\\\"width:100%;margin:0 auto;border-bottom:1px solid #ccc;padding-bottom:20px;\\\">\\n                <p style=\\\"font-size:20px; font-weight:bold; color:#333; text-align:center;\\\">VLinkVPN Verification Code</p>\\n            </div>\\n\\n            <div style=\\\"width:100%;padding:20px 0;margin:0 auto;\\\">\\n                <div style=\\\"line-height:1.8;font-size:16px;margin-bottom:25px;color:#333;\\\">\\n                    <p style=\\\"margin-bottom:15px; font-weight:bold;\\\">Dear VLinkVPN User,</p>\\n                    <p style=\\\"margin-bottom:20px;\\\">\\n                        Your verification code is:\\n                        <span style=\\\"color:#f60;font-size: 24px; font-weight:bold;\\\">_VerificationCode_</span>.\\n                        Please use this code to complete your operation. This code is valid for\\n                        <span style=\\\"color:red;font-weight:bold;\\\">5 minutes</span>.\\n                    </p>\\n                </div>\\n            </div>\\n\\n            <div style=\\\"width:100%; background-color:#fefefe; border: 1px solid #eee; padding:15px; border-radius: 5px; margin-bottom:20px;\\\">\\n                <p style=\\\"font-size:14px; color:#555; line-height:1.6; margin-bottom:10px;\\\">\\n                    <strong style=\\\"color:#333;\\\">Why did you receive this email?</strong><br>\\n                    You are attempting an operation that requires verification, such as password recovery, password change, or email binding.\\n                </p>\\n                <p style=\\\"font-size:14px; color:#555; line-height:1.6; margin-bottom:10px;\\\">\\n                    <strong style=\\\"color:#333;\\\">If this wasn\'t you:</strong><br>\\n                    Please ignore this email or contact us immediately to secure your account.\\n                </p>\\n                <p style=\\\"font-size:14px; color:#555; line-height:1.6;\\\">\\n                    <strong style=\\\"color:#333;\\\">Security Reminder:</strong><br>\\n                    Do not share your verification code with anyone. Our team will never ask for your code. If you suspect unauthorized activity, please change your password promptly.\\n                </p>\\n            </div>\\n\\n            <div style=\\\"width:100%;padding:10px;border-top:1px solid #ccc;color:#747474;line-height:1.5;font-size:12px;\\\">\\n                <p style=\\\"margin-bottom:10px;\\\">\\n                    This is an automated email, please do not reply.<br>\\n                    Please keep your email safe to avoid account theft.\\n                </p>\\n                <p style=\\\"text-align:right; font-weight:bold;\\\">The VLinkVPN Team</p>\\n            </div>\\n        </td>\\n    </tr>\\n    </tbody>\\n</table>\\n</body>\\n\", \"jp\": \"<body tabindex=\\\"0\\\" role=\\\"listitem\\\">\\n<table width=\\\"700\\\" border=\\\"0\\\" align=\\\"center\\\" cellspacing=\\\"0\\\" style=\\\"width:700px; background-color: #f9f9f9; border: 1px solid #ddd; border-radius: 8px; padding: 20px;\\\">\\n    <tbody>\\n    <tr>\\n        <td>\\n            <div style=\\\"width:100%;margin:0 auto;border-bottom:1px solid #ccc;padding-bottom:20px;\\\">\\n                <p style=\\\"font-size:20px; font-weight:bold; color:#333; text-align:center;\\\">VLinkVPN 認証コード通知</p>\\n            </div>\\n\\n            <div style=\\\"width:100%;padding:20px 0;margin:0 auto;\\\">\\n                <div style=\\\"line-height:1.8;font-size:16px;margin-bottom:25px;color:#333;\\\">\\n                    <p style=\\\"margin-bottom:15px; font-weight:bold;\\\">VLinkVPN ユーザー様、</p>\\n                    <p style=\\\"margin-bottom:20px;\\\">\\n                        認証コードは:\\n                        <span style=\\\"color:#f60;font-size: 24px; font-weight:bold;\\\">_VerificationCode_</span> です。\\n                        このコードを使用して操作を完了してください。このコードは\\n                        <span style=\\\"color:red;font-weight:bold;\\\">5分間</span> 有効です。\\n                    </p>\\n                </div>\\n            </div>\\n\\n            <div style=\\\"width:100%; background-color:#fefefe; border: 1px solid #eee; padding:15px; border-radius: 5px; margin-bottom:20px;\\\">\\n                <p style=\\\"font-size:14px; color:#555; line-height:1.6; margin-bottom:10px;\\\">\\n                    <strong style=\\\"color:#333;\\\">なぜこのメールを受け取ったのですか？</strong><br>\\n                    パスワードの復元、変更、メールのバインドなどの操作を行ったためです。\\n                </p>\\n                <p style=\\\"font-size:14px; color:#555; line-height:1.6; margin-bottom:10px;\\\">\\n                    <strong style=\\\"color:#333;\\\">もしご本人でない場合：</strong><br>\\n                    このメールを無視するか、アカウントの安全を確保するために直ちにご連絡ください。\\n                </p>\\n                <p style=\\\"font-size:14px; color:#555; line-height:1.6;\\\">\\n                    <strong style=\\\"color:#333;\\\">セキュリティのヒント:</strong><br>\\n                    認証コードを他人と共有しないでください。当社のスタッフがコードを要求することはありません。不審な活動がある場合は、直ちにパスワードを変更してください。\\n                </p>\\n            </div>\\n\\n            <div style=\\\"width:100%;padding:10px;border-top:1px solid #ccc;color:#747474;line-height:1.5;font-size:12px;\\\">\\n                <p style=\\\"margin-bottom:10px;\\\">\\n                    これはシステムメールです。返信しないでください。<br>\\n                    メールを安全に保管し、アカウントの盗難を防いでください。\\n                </p>\\n                <p style=\\\"text-align:right; font-weight:bold;\\\">VLinkVPN チーム</p>\\n            </div>\\n        </td>\\n    </tr>\\n    </tbody>\\n</table>\\n</body>\\n\", \"ko\": \"<body tabindex=\\\"0\\\" role=\\\"listitem\\\">\\n<table width=\\\"700\\\" border=\\\"0\\\" align=\\\"center\\\" cellspacing=\\\"0\\\" style=\\\"width:700px; background-color: #f9f9f9; border: 1px solid #ddd; border-radius: 8px; padding: 20px;\\\">\\n    <tbody>\\n    <tr>\\n        <td>\\n            <div style=\\\"width:100%;margin:0 auto;border-bottom:1px solid #ccc;padding-bottom:20px;\\\">\\n                <p style=\\\"font-size:20px; font-weight:bold; color:#333; text-align:center;\\\">VLinkVPN 인증 코드 알림</p>\\n            </div>\\n\\n            <div style=\\\"width:100%;padding:20px 0;margin:0 auto;\\\">\\n                <div style=\\\"line-height:1.8;font-size:16px;margin-bottom:25px;color:#333;\\\">\\n                    <p style=\\\"margin-bottom:15px; font-weight:bold;\\\">VLinkVPN 사용자님,</p>\\n                    <p style=\\\"margin-bottom:20px;\\\">\\n                        인증 코드는:\\n                        <span style=\\\"color:#f60;font-size: 24px; font-weight:bold;\\\">_VerificationCode_</span> 입니다.\\n                        이 코드는\\n                        <span style=\\\"color:red;font-weight:bold;\\\">5분</span> 동안 유효합니다.\\n                    </p>\\n                </div>\\n            </div>\\n\\n            <div style=\\\"width:100%; background-color:#fefefe; border: 1px solid #eee; padding:15px; border-radius: 5px; margin-bottom:20px;\\\">\\n                <p style=\\\"font-size:14px; color:#555; line-height:1.6; margin-bottom:10px;\\\">\\n                    <strong style=\\\"color:#333;\\\">왜 이 이메일을 받았나요?</strong><br>\\n                    비밀번호 복구, 변경, 이메일 바인딩 등의 작업을 시도했기 때문입니다.\\n                </p>\\n                <p style=\\\"font-size:14px; color:#555; line-height:1.6; margin-bottom:10px;\\\">\\n                    <strong style=\\\"color:#333;\\\">본인이 아닌 경우:</strong><br>\\n                    이 이메일을 무시하거나 계정 보안을 위해 즉시 저희에게 연락하세요.\\n                </p>\\n                <p style=\\\"font-size:14px; color:#555; line-height:1.6;\\\">\\n                    <strong style=\\\"color:#333;\\\">보안 알림:</strong><br>\\n                    인증 코드를 다른 사람과 공유하지 마십시오. 저희 팀은 인증 코드를 요청하지 않습니다. 의심스러운 활동이 있는 경우 비밀번호를 즉시 변경하세요.\\n                </p>\\n            </div>\\n\\n            <div style=\\\"width:100%;padding:10px;border-top:1px solid #ccc;color:#747474;line-height:1.5;font-size:12px;\\\">\\n                <p style=\\\"margin-bottom:10px;\\\">\\n                    이 이메일은 자동으로 발송된 것입니다. 회신하지 마세요.<br>\\n                    이메일을 안전하게 보관하여 계정 도용을 방지하세요.\\n                </p>\\n                <p style=\\\"text-align:right; font-weight:bold;\\\">VLinkVPN 팀</p>\\n            </div>\\n        </td>\\n    </tr>\\n    </tbody>\\n</table>\\n</body>\\n\", \"zh_cn\": \"<body tabindex=\\\"0\\\" role=\\\"listitem\\\">\\n<table width=\\\"700\\\" border=\\\"0\\\" align=\\\"center\\\" cellspacing=\\\"0\\\" style=\\\"width:700px; background-color: #f9f9f9; border: 1px solid #ddd; border-radius: 8px; padding: 20px;\\\">\\n    <tbody>\\n    <tr>\\n        <td>\\n            <!-- 标题部分 -->\\n            <div style=\\\"width:100%;margin:0 auto;border-bottom:1px solid #ccc;padding-bottom:20px;\\\">\\n                <p style=\\\"font-size:20px; font-weight:bold; color:#333; text-align:center;\\\">VLinkVPN 验证码通知</p>\\n            </div>\\n\\n            <!-- 核心内容部分 -->\\n            <div style=\\\"width:100%;padding:20px 0;margin:0 auto;\\\">\\n                <div style=\\\"line-height:1.8;font-size:16px;margin-bottom:25px;color:#333;\\\">\\n                    <p style=\\\"margin-bottom:15px; font-weight:bold;\\\">尊敬的 VLinkVPN 用户，您好！</p>\\n                    <p style=\\\"margin-bottom:20px;\\\">\\n                        您的验证码是：\\n                        <span style=\\\"color:#f60;font-size: 24px; font-weight:bold;\\\">_VerificationCode_</span>。\\n                        请使用此验证码完成操作。验证码有效期为\\n                        <span style=\\\"color:red;font-weight:bold;\\\">5分钟</span>。\\n                    </p>\\n                </div>\\n            </div>\\n\\n            <!-- 说明和提示部分 -->\\n            <div style=\\\"width:100%; background-color:#fefefe; border: 1px solid #eee; padding:15px; border-radius: 5px; margin-bottom:20px;\\\">\\n                <p style=\\\"font-size:14px; color:#555; line-height:1.6; margin-bottom:10px;\\\">\\n                    <strong style=\\\"color:#333;\\\">为什么您会收到这封邮件？</strong><br>\\n                    您正在尝试进行需要验证的操作，例如找回密码、修改密码、绑定邮箱等。\\n                </p>\\n                <p style=\\\"font-size:14px; color:#555; line-height:1.6; margin-bottom:10px;\\\">\\n                    <strong style=\\\"color:#333;\\\">如果这不是您的操作：</strong><br>\\n                    请忽略此邮件或及时联系我们以确保账户安全。\\n                </p>\\n                <p style=\\\"font-size:14px; color:#555; line-height:1.6;\\\">\\n                    <strong style=\\\"color:#333;\\\">安全提示：</strong><br>\\n                    请勿将验证码泄露给他人。我们的工作人员不会向您索取验证码。如发现异常，请及时修改密码。\\n                </p>\\n            </div>\\n\\n            <!-- 系统提示部分 -->\\n            <div style=\\\"width:100%;padding:10px;border-top:1px solid #ccc;color:#747474;line-height:1.5;font-size:12px;\\\">\\n                <p style=\\\"margin-bottom:10px;\\\">\\n                    此为系统邮件，请勿回复。<br>\\n                    请妥善保管您的邮箱，避免账号被他人盗用。\\n                </p>\\n                <p style=\\\"text-align:right; font-weight:bold;\\\">VLinkVPN 团队</p>\\n            </div>\\n        </td>\\n    </tr>\\n    </tbody>\\n</table>\\n</body>\\n\", \"zh_tw\": \"<body tabindex=\\\"0\\\" role=\\\"listitem\\\">\\n<table width=\\\"700\\\" border=\\\"0\\\" align=\\\"center\\\" cellspacing=\\\"0\\\" style=\\\"width:700px; background-color: #f9f9f9; border: 1px solid #ddd; border-radius: 8px; padding: 20px;\\\">\\n    <tbody>\\n    <tr>\\n        <td>\\n            <div style=\\\"width:100%;margin:0 auto;border-bottom:1px solid #ccc;padding-bottom:20px;\\\">\\n                <p style=\\\"font-size:20px; font-weight:bold; color:#333; text-align:center;\\\">VLinkVPN 驗證碼通知</p>\\n            </div>\\n\\n            <div style=\\\"width:100%;padding:20px 0;margin:0 auto;\\\">\\n                <div style=\\\"line-height:1.8;font-size:16px;margin-bottom:25px;color:#333;\\\">\\n                    <p style=\\\"margin-bottom:15px; font-weight:bold;\\\">尊敬的 VLinkVPN 用戶，您好！</p>\\n                    <p style=\\\"margin-bottom:20px;\\\">\\n                        您的驗證碼是：\\n                        <span style=\\\"color:#f60;font-size: 24px; font-weight:bold;\\\">_VerificationCode_</span>。\\n                        請使用此驗證碼完成操作。驗證碼有效期為\\n                        <span style=\\\"color:red;font-weight:bold;\\\">5分鐘</span>。\\n                    </p>\\n                </div>\\n            </div>\\n\\n            <div style=\\\"width:100%; background-color:#fefefe; border: 1px solid #eee; padding: 15px; border-radius: 5px; margin-bottom:20px;\\\">\\n                <p style=\\\"font-size:14px; color:#555; line-height:1.6; margin-bottom:10px;\\\">\\n                    <strong style=\\\"color:#333;\\\">為什麼您會收到這封郵件？</strong><br>\\n                    您正在嘗試進行需要驗證的操作，例如找回密碼、修改密碼、綁定郵箱等。\\n                </p>\\n                <p style=\\\"font-size:14px; color:#555; line-height:1.6; margin-bottom:10px;\\\">\\n                    <strong style=\\\"color:#333;\\\">如果這不是您的操作：</strong><br>\\n                    請忽略此郵件或及時聯繫我們以確保帳戶安全。\\n                </p>\\n                <p style=\\\"font-size:14px; color:#555; line-height:1.6;\\\">\\n                    <strong style=\\\"color:#333;\\\">安全提示：</strong><br>\\n                    請勿將驗證碼洩露給他人。我們的工作人員不會向您索取驗證碼。如發現異常，請及時修改密碼。\\n                </p>\\n            </div>\\n\\n            <div style=\\\"width:100%;padding:10px;border-top:1px solid #ccc;color:#747474;line-height:1.5;font-size:12px;\\\">\\n                <p style=\\\"margin-bottom:10px;\\\">\\n                    此為系統郵件，請勿回復。<br>\\n                    請妥善保管您的郵箱，避免帳號被他人盜用。\\n                </p>\\n                <p style=\\\"text-align:right; font-weight:bold;\\\">VLinkVPN 團隊</p>\\n            </div>\\n        </td>\\n    </tr>\\n    </tbody>\\n</table>\\n</body>\\n\"}, \"smtpHost\": \"smtpdm-ap-southeast-1.aliyun.com\", \"smtpPort\": 465, \"smtpUser\": \"verify@vlinkvpn.net\", \"smtpUserPass\": \"ZM62123asdTYs\"}, \"agent\": {\"commonUUID\": \"59ed0246-2f72-45c1-8f21-a88dce52048e\", \"agentApiUrl\": \"http://13.200.154.248:18200\", \"mqttAgentPass\": \"ZM433299qq\", \"mqttAgentUser\": \"xiaobaibai\", \"agentMqttAddress\": \"tcp://13.200.154.248:11190\"}, \"other\": {\"other\": {\"shareUrl\": \"shareUrl\"}, \"notifyUrl\": \"https://www.vlinkvpn.com\"}, \"webId\": 1, \"client\": {\"email\": \"verify@vlinkvpn.net\", \"website\": \"https://www.vlinkvpn.com\", \"currency\": [{\"symbol\": \"¥\", \"currency\": \"rmb\", \"exchangeRate\": 7.31}, {\"symbol\": \"$\", \"currency\": \"usd\", \"exchangeRate\": 1}, {\"symbol\": \"€\", \"currency\": \"eur\", \"exchangeRate\": 0.93}], \"language\": [{\"mark\": \"zh_cn\", \"currency\": \"rmb\", \"language\": \"简体中文\"}, {\"mark\": \"zh_tw\", \"currency\": \"usd\", \"language\": \"中文繁體\"}, {\"mark\": \"en\", \"currency\": \"usd\", \"language\": \"English\"}, {\"mark\": \"ko\", \"currency\": \"usd\", \"language\": \"한국인\"}, {\"mark\": \"jp\", \"currency\": \"usd\", \"language\": \"日本語\"}], \"shareUrl\": \"https://www.vlinkvpn.com\", \"telegram\": \"@vlinkvpn\", \"commission\": 7.1, \"commonUUID\": \"aad8279a-99d7-44e8-bd14-c5dd763920ee\", \"customerUrl\": \"https://kf.vlinkr.xyz\", \"generateURL\": \"http://127.0.0.1:6061/generate_204\", \"currencyMain\": \"usd\", \"speedTestURL\": \"http://127.0.0.1:6061/speed_test\", \"defaultDomain\": [\"*.baidu.com\", \"*.google.com\"], \"clientMqttPass\": \"ZM433299qq\", \"clientMqttUser\": \"xiaobaibai\", \"clientStaticUrl\": \"https://www.vlinkvpn.com\", \"clientMqttAddress\": \"tcp://da3c0763.xxmycdn.com:508\"}}');
COMMIT;

-- ----------------------------
-- Table structure for tools_gen_table
-- ----------------------------
DROP TABLE IF EXISTS `tools_gen_table`;
CREATE TABLE `tools_gen_table` (
  `table_id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `table_name` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT '' COMMENT '表名称',
  `table_comment` varchar(500) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT '' COMMENT '表描述',
  `class_name` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT '' COMMENT '实体类名称',
  `tpl_category` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT 'crud' COMMENT '使用的模板（crud单表操作 tree树表操作）',
  `package_name` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '生成包路径',
  `module_name` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '生成模块名',
  `business_name` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '生成业务名',
  `function_name` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '生成功能名',
  `function_author` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '生成功能作者',
  `options` varchar(1000) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '其它生成选项',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`table_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=184 DEFAULT CHARSET=utf8mb3 COMMENT='代码生成业务表';

-- ----------------------------
-- Records of tools_gen_table
-- ----------------------------
BEGIN;
INSERT INTO `tools_gen_table` (`table_id`, `table_name`, `table_comment`, `class_name`, `tpl_category`, `package_name`, `module_name`, `business_name`, `function_name`, `function_author`, `options`, `create_time`, `update_time`, `remark`) VALUES (183, 'vpn_node_group', '节点分组', 'VpnNodeGroup', 'crud', 'gfast/app/vpn', 'vpn', 'vpn_node_group', '节点分组', 'gfast', '', '2025-03-28 13:34:00', '2025-03-28 13:34:49', '');
COMMIT;

-- ----------------------------
-- Table structure for tools_gen_table_column
-- ----------------------------
DROP TABLE IF EXISTS `tools_gen_table_column`;
CREATE TABLE `tools_gen_table_column` (
  `column_id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `table_id` bigint DEFAULT NULL COMMENT '归属表编号',
  `column_name` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '列名称',
  `column_comment` varchar(500) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '列描述',
  `column_type` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '列类型',
  `go_type` varchar(500) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT 'Go类型',
  `go_field` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT 'Go字段名',
  `html_field` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT 'html字段名',
  `is_pk` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '是否主键（1是）',
  `is_increment` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '是否自增（1是）',
  `is_required` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '是否必填（1是）',
  `is_insert` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '是否为插入字段（1是）',
  `is_edit` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '是否编辑字段（1是）',
  `is_list` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '是否列表字段（1是）',
  `is_query` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '是否查询字段（1是）',
  `query_type` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT 'EQ' COMMENT '查询方式（等于、不等于、大于、小于、范围）',
  `html_type` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '显示类型（文本框、文本域、下拉框、复选框、单选框、日期控件）',
  `dict_type` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT '' COMMENT '字典类型',
  `sort` int DEFAULT NULL COMMENT '排序',
  `link_table_name` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '关联表名',
  `link_table_class` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '关联表类名',
  `link_table_package` varchar(150) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '关联表包名',
  `link_label_id` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '关联表键名',
  `link_label_name` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '关联表字段值',
  PRIMARY KEY (`column_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1660 DEFAULT CHARSET=utf8mb3 COMMENT='代码生成业务表字段';

-- ----------------------------
-- Records of tools_gen_table_column
-- ----------------------------
BEGIN;
INSERT INTO `tools_gen_table_column` (`column_id`, `table_id`, `column_name`, `column_comment`, `column_type`, `go_type`, `go_field`, `html_field`, `is_pk`, `is_increment`, `is_required`, `is_insert`, `is_edit`, `is_list`, `is_query`, `query_type`, `html_type`, `dict_type`, `sort`, `link_table_name`, `link_table_class`, `link_table_package`, `link_label_id`, `link_label_name`) VALUES (1658, 183, 'node_group_id', 'ID', 'int', 'int', 'NodeGroupId', 'nodeGroupId', '1', '1', '', '1', '0', '1', '1', 'EQ', 'input', '', 1, '', '', '', '', '');
INSERT INTO `tools_gen_table_column` (`column_id`, `table_id`, `column_name`, `column_comment`, `column_type`, `go_type`, `go_field`, `html_field`, `is_pk`, `is_increment`, `is_required`, `is_insert`, `is_edit`, `is_list`, `is_query`, `query_type`, `html_type`, `dict_type`, `sort`, `link_table_name`, `link_table_class`, `link_table_package`, `link_label_id`, `link_label_name`) VALUES (1659, 183, 'node_group_name', '分组名', 'varchar(255)', 'string', 'NodeGroupName', 'nodeGroupName', '0', '0', '1', '1', '1', '1', '1', 'LIKE', 'input', '', 2, '', '', '', '', '');
COMMIT;

-- ----------------------------
-- Table structure for vpn_node
-- ----------------------------
DROP TABLE IF EXISTS `vpn_node`;
CREATE TABLE `vpn_node` (
  `node_id` int NOT NULL AUTO_INCREMENT,
  `magnification` double(10,2) DEFAULT NULL COMMENT '用户消耗流量倍率',
  `nation_id` int DEFAULT NULL COMMENT '国家id',
  `transit_port` int DEFAULT NULL COMMENT '中转服务器端口',
  `transit_protocol` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '中转服务协议',
  `up` bigint NOT NULL DEFAULT '0' COMMENT '上行流量',
  `down` bigint NOT NULL DEFAULT '0' COMMENT '下行流量',
  `domain_id` int DEFAULT '0' COMMENT '域名ID',
  `otu_type` int DEFAULT NULL COMMENT '1默认IP 2指定IP 3指定节点ID',
  `out_ip` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '出口IP',
  `out_node_id` int DEFAULT NULL COMMENT '出口节点ID',
  `protocol` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '协议',
  `vpn_port` int DEFAULT NULL COMMENT 'vpn端口',
  `ping` json NOT NULL COMMENT 'ping数据',
  `method` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '加密方式',
  `frp_protocol` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '内网穿透协议',
  `frp_port` int DEFAULT NULL COMMENT '内网穿透端口',
  `frp_server_id` int NOT NULL DEFAULT '0' COMMENT '内网穿透服务器ID',
  `server_id` int NOT NULL DEFAULT '0' COMMENT '服务器ID',
  `server_core` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '核心',
  `clash_transit_node_ids` json DEFAULT NULL COMMENT 'clash多级中转',
  `transit_server_id` int NOT NULL DEFAULT '0' COMMENT '中转服务器ID',
  `transit_hysteria_server_id` int NOT NULL DEFAULT '0' COMMENT 'hysteria 服务端id',
  `other` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '注释',
  `created_at` datetime DEFAULT NULL COMMENT '创建时间',
  `updated_at` datetime DEFAULT NULL COMMENT '更新时间',
  `clash_proxie` json DEFAULT NULL,
  `transport_protocol` varchar(255) DEFAULT NULL,
  `stream_settings_host` varchar(255) DEFAULT NULL,
  `stream_settings_path` varchar(255) DEFAULT NULL,
  `stream_settings_service_name` varchar(255) DEFAULT NULL,
  `stream_settings_reality` int DEFAULT NULL,
  `stream_settings_congestion_control` varchar(255) DEFAULT NULL,
  `node_group_id` int DEFAULT NULL,
  PRIMARY KEY (`node_id`) USING BTREE,
  UNIQUE KEY `idx_vpn_node_node_id` (`node_id`) USING BTREE,
  KEY `idx_transit_server_protocol` (`transit_server_id`,`transit_protocol`) USING BTREE,
  KEY `3` (`node_id`) USING BTREE,
  KEY `idx_server_transit_server_id` (`server_id`,`transit_server_id`) USING BTREE,
  KEY `idx_transit_protocol` (`transit_protocol`) USING BTREE,
  KEY `idx_server_id_group_id` (`server_id`) USING BTREE,
  KEY `idx_server_id_node_id_group_id` (`server_id`,`node_id`) USING BTREE,
  KEY `idx_vpn_node_transit_hysteria_server_id_protocol` (`transit_hysteria_server_id`,`transit_protocol`) USING BTREE,
  KEY `idx_vpn_node_server_id` (`server_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=5313 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Vpn节点配置';

-- ----------------------------
-- Records of vpn_node
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for vpn_node_group
-- ----------------------------
DROP TABLE IF EXISTS `vpn_node_group`;
CREATE TABLE `vpn_node_group` (
  `node_group_id` int NOT NULL AUTO_INCREMENT,
  `node_group_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  PRIMARY KEY (`node_group_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of vpn_node_group
-- ----------------------------
BEGIN;
INSERT INTO `vpn_node_group` (`node_group_id`, `node_group_name`) VALUES (1, '测试');
COMMIT;

-- ----------------------------
-- Table structure for vpn_node_nation
-- ----------------------------
DROP TABLE IF EXISTS `vpn_node_nation`;
CREATE TABLE `vpn_node_nation` (
  `nation_id` int NOT NULL AUTO_INCREMENT,
  `nation_name` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `nation_img` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  PRIMARY KEY (`nation_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='vpn ip 国家';

-- ----------------------------
-- Records of vpn_node_nation
-- ----------------------------
BEGIN;
INSERT INTO `vpn_node_nation` (`nation_id`, `nation_name`, `nation_img`) VALUES (1, '中国', ' 🇨🇳');
INSERT INTO `vpn_node_nation` (`nation_id`, `nation_name`, `nation_img`) VALUES (2, '台湾', ' 🇨🇳');
INSERT INTO `vpn_node_nation` (`nation_id`, `nation_name`, `nation_img`) VALUES (3, '香港', ' 🇭🇰');
INSERT INTO `vpn_node_nation` (`nation_id`, `nation_name`, `nation_img`) VALUES (4, '韩国', ' 🇰🇷');
INSERT INTO `vpn_node_nation` (`nation_id`, `nation_name`, `nation_img`) VALUES (5, '美国', ' 🇺🇸');
INSERT INTO `vpn_node_nation` (`nation_id`, `nation_name`, `nation_img`) VALUES (6, '英国', ' 🇬🇧');
INSERT INTO `vpn_node_nation` (`nation_id`, `nation_name`, `nation_img`) VALUES (7, '新加坡', ' 🇸🇬');
INSERT INTO `vpn_node_nation` (`nation_id`, `nation_name`, `nation_img`) VALUES (8, '日本', ' 🇯🇵');
INSERT INTO `vpn_node_nation` (`nation_id`, `nation_name`, `nation_img`) VALUES (9, '马来西亚', ' 🇲🇾');
INSERT INTO `vpn_node_nation` (`nation_id`, `nation_name`, `nation_img`) VALUES (10, '俄罗斯', '🇷🇺');
INSERT INTO `vpn_node_nation` (`nation_id`, `nation_name`, `nation_img`) VALUES (11, '阿曼', ' 🇴🇲');
INSERT INTO `vpn_node_nation` (`nation_id`, `nation_name`, `nation_img`) VALUES (13, '越南', '🇻🇳');
INSERT INTO `vpn_node_nation` (`nation_id`, `nation_name`, `nation_img`) VALUES (14, '印尼', '🇮🇩');
INSERT INTO `vpn_node_nation` (`nation_id`, `nation_name`, `nation_img`) VALUES (15, '泰國', '🇹🇭');
INSERT INTO `vpn_node_nation` (`nation_id`, `nation_name`, `nation_img`) VALUES (16, '土耳其', '🇹🇷 ');
INSERT INTO `vpn_node_nation` (`nation_id`, `nation_name`, `nation_img`) VALUES (17, '法国', ' 🇫🇷');
INSERT INTO `vpn_node_nation` (`nation_id`, `nation_name`, `nation_img`) VALUES (18, '德国', '🇩🇪');
INSERT INTO `vpn_node_nation` (`nation_id`, `nation_name`, `nation_img`) VALUES (19, '印度', '🇮🇳');
INSERT INTO `vpn_node_nation` (`nation_id`, `nation_name`, `nation_img`) VALUES (20, '迪拜', '🇦🇪');
INSERT INTO `vpn_node_nation` (`nation_id`, `nation_name`, `nation_img`) VALUES (21, '西班牙', '🇪🇸');
INSERT INTO `vpn_node_nation` (`nation_id`, `nation_name`, `nation_img`) VALUES (22, '加拿大', '🇨🇦');
INSERT INTO `vpn_node_nation` (`nation_id`, `nation_name`, `nation_img`) VALUES (23, '荷兰', ' 🇳🇱');
INSERT INTO `vpn_node_nation` (`nation_id`, `nation_name`, `nation_img`) VALUES (24, '巴西', '🇧🇷');
INSERT INTO `vpn_node_nation` (`nation_id`, `nation_name`, `nation_img`) VALUES (25, '葡萄牙', '🇵🇹');
COMMIT;

-- ----------------------------
-- Table structure for vpn_node_ping
-- ----------------------------
DROP TABLE IF EXISTS `vpn_node_ping`;
CREATE TABLE `vpn_node_ping` (
  `ping_id` int NOT NULL AUTO_INCREMENT,
  `server_id` int NOT NULL COMMENT '服务器ID',
  `nation_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '地区名称',
  `ping_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'pingURL',
  `speed_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '测速URL',
  PRIMARY KEY (`ping_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='节点延迟配置';

-- ----------------------------
-- Records of vpn_node_ping
-- ----------------------------
BEGIN;
INSERT INTO `vpn_node_ping` (`ping_id`, `server_id`, `nation_name`, `ping_url`, `speed_url`) VALUES (1, 839, '测试', 'http://127.0.0.1:2061/generate_204', 'http://127.0.0.1:2061/speed_test?byte=5024000');
COMMIT;

-- ----------------------------
-- Table structure for vpn_node_transfer
-- ----------------------------
DROP TABLE IF EXISTS `vpn_node_transfer`;
CREATE TABLE `vpn_node_transfer` (
  `transfer_id` int NOT NULL AUTO_INCREMENT,
  `node_id` int NOT NULL,
  `entrance_server_id` int NOT NULL,
  `entrance_server_ip` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `exit_server_id` int NOT NULL,
  `exit_server_ip` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  PRIMARY KEY (`transfer_id`) USING BTREE,
  KEY `1` (`node_id`) USING BTREE,
  KEY `2` (`entrance_server_id`) USING BTREE,
  KEY `3` (`exit_server_id`) USING BTREE,
  KEY `4` (`entrance_server_id`,`exit_server_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=175 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of vpn_node_transfer
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for vpn_server
-- ----------------------------
DROP TABLE IF EXISTS `vpn_server`;
CREATE TABLE `vpn_server` (
  `server_id` int NOT NULL AUTO_INCREMENT,
  `server_name` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '服务器名称',
  `server_ip` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '服务器IP',
  `server_group_id` int NOT NULL COMMENT '分组',
  `service_merchants_id` int DEFAULT NULL COMMENT '服务器商',
  `server_ssh_prot` int DEFAULT NULL COMMENT '服务器ssh端口',
  `server_ssh_user` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '用户名',
  `server_ssh_passwrod` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '服务器ssh密码',
  `server_ssh_public_key` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci COMMENT '服务器ssh秘钥',
  `server_ssh_login_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '登录方式 password ro  public_key',
  `nation_id` int DEFAULT NULL COMMENT '国家id',
  `status` int DEFAULT NULL COMMENT '状态 -1离线 1在线',
  `up` bigint DEFAULT NULL COMMENT '上行流量 字节',
  `down` bigint DEFAULT NULL COMMENT '下行流量 字节',
  `other` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '注释',
  `is_pppoe` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '是否是拨号服务器',
  `pppoe_restart` int DEFAULT NULL COMMENT '是否定时重拨',
  `pppoe_hour` int DEFAULT NULL COMMENT '几点钟重拨',
  `pppoe_cycle` int DEFAULT NULL COMMENT '间隔周期单位天',
  `pppoe_retime` datetime DEFAULT NULL COMMENT '上次重启时间',
  `real_up` bigint DEFAULT NULL COMMENT '实时',
  `real_down` bigint DEFAULT NULL COMMENT '实时',
  `ipv6` int DEFAULT NULL COMMENT '是否支持ipv6',
  `real_cpu` double(10,2) DEFAULT NULL,
  `real_disk` double(10,2) DEFAULT NULL,
  `real_mem` double(10,2) DEFAULT NULL,
  `server_dns` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT 'dns',
  `proxy_addr` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT 'ssh代理',
  `updated_at` datetime DEFAULT NULL COMMENT '更新时间',
  `created_at` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`server_id`) USING BTREE,
  UNIQUE KEY `1` (`server_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=840 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Vpn服务器';

-- ----------------------------
-- Records of vpn_server
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for vpn_server_group
-- ----------------------------
DROP TABLE IF EXISTS `vpn_server_group`;
CREATE TABLE `vpn_server_group` (
  `server_group_id` int NOT NULL AUTO_INCREMENT,
  `server_group_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '分组名',
  PRIMARY KEY (`server_group_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='服务器分组';

-- ----------------------------
-- Records of vpn_server_group
-- ----------------------------
BEGIN;
INSERT INTO `vpn_server_group` (`server_group_id`, `server_group_name`) VALUES (8, '测试服务器');
COMMIT;

-- ----------------------------
-- Table structure for vpn_subscription
-- ----------------------------
DROP TABLE IF EXISTS `vpn_subscription`;
CREATE TABLE `vpn_subscription` (
  `subscription_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `node_group_ids` json DEFAULT NULL,
  `uuid` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`subscription_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of vpn_subscription
-- ----------------------------
BEGIN;
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
