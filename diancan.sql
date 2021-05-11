/*
Navicat MySQL Data Transfer

Source Server         : my
Source Server Version : 50731
Source Host           : 47.101.189.229:3306
Source Database       : diancan

Target Server Type    : MYSQL
Target Server Version : 50731
File Encoding         : 65001

Date: 2021-04-22 21:13:48
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for admin_info
-- ----------------------------
DROP TABLE IF EXISTS `admin_info`;
CREATE TABLE `admin_info` (
  `admin` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL,
  `adminpassword` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '用户手机号'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='餐厅卖家信息表';

-- ----------------------------
-- Records of admin_info
-- ----------------------------
INSERT INTO `admin_info` VALUES ('lw', '12', '123');
INSERT INTO `admin_info` VALUES ('cs', 'cs', 'cs');
INSERT INTO `admin_info` VALUES ('123', '123', '123');

-- ----------------------------
-- Table structure for category
-- ----------------------------
DROP TABLE IF EXISTS `category`;
CREATE TABLE `category` (
  `ctype` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `cname` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`ctype`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of category
-- ----------------------------
INSERT INTO `category` VALUES ('0326ba6b-8c87-45ca-9a0b-0b67eb725687', '面点');
INSERT INTO `category` VALUES ('10494b58-34e7-491b-9f2b-c5460c34bc36', '饮品');
INSERT INTO `category` VALUES ('106a72ca-7f76-4f48-9a1b-e138ca148dd1', '早餐');
INSERT INTO `category` VALUES ('1697d1aa-2822-4e3e-ad89-244c4ef60d8f', '小菜');
INSERT INTO `category` VALUES ('1b0b0a85-a3de-4a19-bc69-f2b4cfd89fa2', '饭类');
INSERT INTO `category` VALUES ('5e1a8e25-2036-457c-a204-4cd2ff9d028a', '甜品');
INSERT INTO `category` VALUES ('a9af20f1-1c89-4375-bcb2-6329209a7f27', '金牌馄饨');
INSERT INTO `category` VALUES ('df7f32b8-6fa9-4ccb-b38b-73df6e16c059', '清粥');
INSERT INTO `category` VALUES ('e77d9fe6-64fa-4dfd-851b-82a48dda9340', '浓汤');

-- ----------------------------
-- Table structure for commodityitem
-- ----------------------------
DROP TABLE IF EXISTS `commodityitem`;
CREATE TABLE `commodityitem` (
  `commodityid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `cname` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `price` decimal(10,2) DEFAULT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `categoryid` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `categoryname` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `link` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `stock` int(10) DEFAULT NULL,
  `whetheronsell` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  PRIMARY KEY (`commodityid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of commodityitem
-- ----------------------------
INSERT INTO `commodityitem` VALUES ('0cd69581-8112-4f7a-8736-c86bddb260ba', '炸酱面', '12.00', '好吃', '0326ba6b-8c87-45ca-9a0b-0b67eb725687', '面点', 'https://www.ruyi-ht.com/images/product/401_1538188196743426.jpg', '50', 'true');
INSERT INTO `commodityitem` VALUES ('17373911-14f5-4b5d-86c1-cdf9a11662c0', '虾仁三鲜馄饨', '15.00', '好吃', 'a9af20f1-1c89-4375-bcb2-6329209a7f27', '金牌馄饨', 'https://www.ruyi-ht.com/images/product/429_1611029466088130.jpg', '30', 'true');
INSERT INTO `commodityitem` VALUES ('46ea451c-300d-48e6-806c-8789b5804498', '肉卤素鸡', '13.00', '好吃', '1697d1aa-2822-4e3e-ad89-244c4ef60d8f', '小菜', 'https://www.ruyi-ht.com/images/product/347_1538112701898234.jpg', '100', 'true');
INSERT INTO `commodityitem` VALUES ('539716d5-7343-4634-87d5-b4158f7cc4a7', '酸菜牛肉拌面', '12.00', '好吃', '0326ba6b-8c87-45ca-9a0b-0b67eb725687', '面点', 'https://www.ruyi-ht.com/images/product/391_1538187764178901.jpg', '100', 'true');
INSERT INTO `commodityitem` VALUES ('623afd61-aa03-4851-bedd-3d9b14d93517', '麻辣中馄饨', '15.00', '好吃', 'a9af20f1-1c89-4375-bcb2-6329209a7f27', '金牌馄饨', 'https://www.ruyi-ht.com/images/product/428_1611029309556678.jpg', '50', 'false');
INSERT INTO `commodityitem` VALUES ('6641a073-aebc-41a1-83ff-1751630a0abb', '桂花莲藕粥', '12.00', '好吃', 'df7f32b8-6fa9-4ccb-b38b-73df6e16c059', '清粥', 'https://www.ruyi-ht.com/images/product/336_1538112347957104.jpg', '50', 'true');
INSERT INTO `commodityitem` VALUES ('a6c4108d-a9be-4ba3-8f2b-f2169ddef221', '香菇滑鸡泡饭', '10.00', '好吃', '1b0b0a85-a3de-4a19-bc69-f2b4cfd89fa2', '饭类', 'https://www.ruyi-ht.com/images/product/422_1538190791506186.jpg', '20', 'true');
INSERT INTO `commodityitem` VALUES ('a865b81b-aeef-4433-8cae-34c3fcb7b0a0', '炸酱面', '12.00', '好吃', '0326ba6b-8c87-45ca-9a0b-0b67eb725687', '面点', 'https://www.ruyi-ht.com/images/product/401_1538188196743426.jpg', '50', 'true');
INSERT INTO `commodityitem` VALUES ('abaf9127-bc22-41a5-b659-25db64b4d900', '双椒排骨饭', '10.00', '好吃', '1b0b0a85-a3de-4a19-bc69-f2b4cfd89fa2', '饭类', 'https://www.ruyi-ht.com/images/product/424_1538191183384260.jpg', '20', 'true');
INSERT INTO `commodityitem` VALUES ('ae14c29d-556c-43eb-9cab-ddf8fc4c1586', '八宝粥', '12.00', '好吃', 'df7f32b8-6fa9-4ccb-b38b-73df6e16c059', '清粥', 'https://www.ruyi-ht.com/images/product/335_1538112330068762.jpg', '50', 'true');

-- ----------------------------
-- Table structure for orderdetail
-- ----------------------------
DROP TABLE IF EXISTS `orderdetail`;
CREATE TABLE `orderdetail` (
  `orderid` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `commodityid` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `commoditynum` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `commodityname` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of orderdetail
-- ----------------------------
INSERT INTO `orderdetail` VALUES ('12x99874emkg', '5b436e15-75c7-49eb-a861-a4ad19f77edf', '3', '馒头');
INSERT INTO `orderdetail` VALUES ('12x99874emkg', '953b8594-3cd8-4e29-8977-c3426d222ae7', '1', '骚烤');
INSERT INTO `orderdetail` VALUES ('12x99874emkg', 'd9c64190-a3c3-40bd-b409-acf1e6dc96bd', '3', '土豆');
INSERT INTO `orderdetail` VALUES ('12x99874emkg', 'e1c780c4-6963-45a3-8063-da0f36e916d7', '1', '饺子');
INSERT INTO `orderdetail` VALUES ('5jwgd3jrke00', '5b436e15-75c7-49eb-a861-a4ad19f77edf', '3', '馒头');
INSERT INTO `orderdetail` VALUES ('5jwgd3jrke00', '953b8594-3cd8-4e29-8977-c3426d222ae7', '2', '骚烤');
INSERT INTO `orderdetail` VALUES ('5jwgd3jrke00', 'd9c64190-a3c3-40bd-b409-acf1e6dc96bd', '2', '土豆');
INSERT INTO `orderdetail` VALUES ('3jpecpl3xag0', '5b436e15-75c7-49eb-a861-a4ad19f77edf', '3', '馒头');
INSERT INTO `orderdetail` VALUES ('5t2pavzxsgw0', '0cd69581-8112-4f7a-8736-c86bddb260ba', '1', '炸酱面');
INSERT INTO `orderdetail` VALUES ('5zueg2secx80', '0cd69581-8112-4f7a-8736-c86bddb260ba', '1', '炸酱面');
INSERT INTO `orderdetail` VALUES ('5zueg2secx80', '539716d5-7343-4634-87d5-b4158f7cc4a7', '1', '酸菜牛肉拌面');
INSERT INTO `orderdetail` VALUES ('6jk14nqnliw0', '0cd69581-8112-4f7a-8736-c86bddb260ba', '1', '炸酱面');
INSERT INTO `orderdetail` VALUES ('s8r6sse7nz4', '0cd69581-8112-4f7a-8736-c86bddb260ba', '1', '炸酱面');
INSERT INTO `orderdetail` VALUES ('s8r6sse7nz4', '539716d5-7343-4634-87d5-b4158f7cc4a7', '1', '酸菜牛肉拌面');
INSERT INTO `orderdetail` VALUES ('5ridqe27hvk0', '0cd69581-8112-4f7a-8736-c86bddb260ba', '1', '炸酱面');
INSERT INTO `orderdetail` VALUES ('7jmkordahbc0', '0cd69581-8112-4f7a-8736-c86bddb260ba', '1', '炸酱面');
INSERT INTO `orderdetail` VALUES ('7jmkordahbc0', '539716d5-7343-4634-87d5-b4158f7cc4a7', '1', '酸菜牛肉拌面');
INSERT INTO `orderdetail` VALUES ('7jmkordahbc0', 'a865b81b-aeef-4433-8cae-34c3fcb7b0a0', '1', '炸酱面');
INSERT INTO `orderdetail` VALUES ('2s8iw3gi0fi0', '0cd69581-8112-4f7a-8736-c86bddb260ba', '1', '炸酱面');
INSERT INTO `orderdetail` VALUES ('2s8iw3gi0fi0', '539716d5-7343-4634-87d5-b4158f7cc4a7', '1', '酸菜牛肉拌面');
INSERT INTO `orderdetail` VALUES ('4vllo3ze7fy0', '0cd69581-8112-4f7a-8736-c86bddb260ba', '1', '炸酱面');
INSERT INTO `orderdetail` VALUES ('4vllo3ze7fy0', '539716d5-7343-4634-87d5-b4158f7cc4a7', '1', '酸菜牛肉拌面');
INSERT INTO `orderdetail` VALUES ('6kkd4icmt340', '0cd69581-8112-4f7a-8736-c86bddb260ba', '1', '炸酱面');
INSERT INTO `orderdetail` VALUES ('6kkd4icmt340', '539716d5-7343-4634-87d5-b4158f7cc4a7', '1', '酸菜牛肉拌面');
INSERT INTO `orderdetail` VALUES ('4z5i8nlmgvg0', '0cd69581-8112-4f7a-8736-c86bddb260ba', '1', '炸酱面');
INSERT INTO `orderdetail` VALUES ('4z5i8nlmgvg0', '539716d5-7343-4634-87d5-b4158f7cc4a7', '1', '酸菜牛肉拌面');
INSERT INTO `orderdetail` VALUES ('3brgj8pb76a0', '0cd69581-8112-4f7a-8736-c86bddb260ba', '1', '炸酱面');
INSERT INTO `orderdetail` VALUES ('3brgj8pb76a0', '539716d5-7343-4634-87d5-b4158f7cc4a7', '1', '酸菜牛肉拌面');
INSERT INTO `orderdetail` VALUES ('3brgj8pb76a0', 'a865b81b-aeef-4433-8cae-34c3fcb7b0a0', '1', '炸酱面');
INSERT INTO `orderdetail` VALUES ('4vzok8wx3am0', '0cd69581-8112-4f7a-8736-c86bddb260ba', '1', '炸酱面');
INSERT INTO `orderdetail` VALUES ('4vzok8wx3am0', '539716d5-7343-4634-87d5-b4158f7cc4a7', '1', '酸菜牛肉拌面');
INSERT INTO `orderdetail` VALUES ('49z58ldrbou0', '0cd69581-8112-4f7a-8736-c86bddb260ba', '1', '炸酱面');
INSERT INTO `orderdetail` VALUES ('49z58ldrbou0', '539716d5-7343-4634-87d5-b4158f7cc4a7', '1', '酸菜牛肉拌面');
INSERT INTO `orderdetail` VALUES ('1l2da4hang2o', '0cd69581-8112-4f7a-8736-c86bddb260ba', '1', '炸酱面');
INSERT INTO `orderdetail` VALUES ('1l2da4hang2o', '539716d5-7343-4634-87d5-b4158f7cc4a7', '1', '酸菜牛肉拌面');
INSERT INTO `orderdetail` VALUES ('2jqsl2dns6s0', 'a865b81b-aeef-4433-8cae-34c3fcb7b0a0', '1', '炸酱面');
INSERT INTO `orderdetail` VALUES ('2jqsl2dns6s0', '0cd69581-8112-4f7a-8736-c86bddb260ba', '1', '炸酱面');
INSERT INTO `orderdetail` VALUES ('2jqsl2dns6s0', '539716d5-7343-4634-87d5-b4158f7cc4a7', '2', '酸菜牛肉拌面');
INSERT INTO `orderdetail` VALUES ('6z6y7b6kgsc0', '0cd69581-8112-4f7a-8736-c86bddb260ba', '2', '炸酱面');
INSERT INTO `orderdetail` VALUES ('5z5oq4qoozc0', '539716d5-7343-4634-87d5-b4158f7cc4a7', '2', '酸菜牛肉拌面');
INSERT INTO `orderdetail` VALUES ('2zxwbmt0uie0', '0cd69581-8112-4f7a-8736-c86bddb260ba', '1', '炸酱面');
INSERT INTO `orderdetail` VALUES ('1rwq4pszjp8g', '0cd69581-8112-4f7a-8736-c86bddb260ba', '1', '炸酱面');
INSERT INTO `orderdetail` VALUES ('1rwq4pszjp8g', '539716d5-7343-4634-87d5-b4158f7cc4a7', '1', '酸菜牛肉拌面');
INSERT INTO `orderdetail` VALUES ('1rwq4pszjp8g', 'a865b81b-aeef-4433-8cae-34c3fcb7b0a0', '1', '炸酱面');
INSERT INTO `orderdetail` VALUES ('fyy3nd99u54', '0cd69581-8112-4f7a-8736-c86bddb260ba', '1', '炸酱面');
INSERT INTO `orderdetail` VALUES ('fyy3nd99u54', '539716d5-7343-4634-87d5-b4158f7cc4a7', '1', '酸菜牛肉拌面');
INSERT INTO `orderdetail` VALUES ('4yltasabz4k0', '539716d5-7343-4634-87d5-b4158f7cc4a7', '1', '酸菜牛肉拌面');
INSERT INTO `orderdetail` VALUES ('4yltasabz4k0', '0cd69581-8112-4f7a-8736-c86bddb260ba', '1', '炸酱面');
INSERT INTO `orderdetail` VALUES ('63shgdbb4xk0', '0cd69581-8112-4f7a-8736-c86bddb260ba', '1', '炸酱面');
INSERT INTO `orderdetail` VALUES ('7bfvdz76e7c0', '0cd69581-8112-4f7a-8736-c86bddb260ba', '1', '炸酱面');
INSERT INTO `orderdetail` VALUES ('7bfvdz76e7c0', '539716d5-7343-4634-87d5-b4158f7cc4a7', '1', '酸菜牛肉拌面');
INSERT INTO `orderdetail` VALUES ('3dul56bs03m0', '0cd69581-8112-4f7a-8736-c86bddb260ba', '1', '炸酱面');
INSERT INTO `orderdetail` VALUES ('7l26425g6140', 'abaf9127-bc22-41a5-b659-25db64b4d900', '1', '双椒排骨饭');
INSERT INTO `orderdetail` VALUES ('6kwa18owlxw0', '0cd69581-8112-4f7a-8736-c86bddb260ba', '1', '炸酱面');
INSERT INTO `orderdetail` VALUES ('6kwa18owlxw0', '539716d5-7343-4634-87d5-b4158f7cc4a7', '1', '酸菜牛肉拌面');
INSERT INTO `orderdetail` VALUES ('6kwa18owlxw0', 'a865b81b-aeef-4433-8cae-34c3fcb7b0a0', '1', '炸酱面');
INSERT INTO `orderdetail` VALUES ('1j2l6wr03a4g', '0cd69581-8112-4f7a-8736-c86bddb260ba', '1', '炸酱面');
INSERT INTO `orderdetail` VALUES ('5synyyf7myo0', '0cd69581-8112-4f7a-8736-c86bddb260ba', '1', '炸酱面');
INSERT INTO `orderdetail` VALUES ('1y29pr592h34', '539716d5-7343-4634-87d5-b4158f7cc4a7', '1', '酸菜牛肉拌面');
INSERT INTO `orderdetail` VALUES ('1y29pr592h34', '0cd69581-8112-4f7a-8736-c86bddb260ba', '1', '炸酱面');
INSERT INTO `orderdetail` VALUES ('49v3wm0pp3c0', '0cd69581-8112-4f7a-8736-c86bddb260ba', '1', '炸酱面');
INSERT INTO `orderdetail` VALUES ('49v3wm0pp3c0', '539716d5-7343-4634-87d5-b4158f7cc4a7', '1', '酸菜牛肉拌面');
INSERT INTO `orderdetail` VALUES ('4a8aw9irx7q0', '0cd69581-8112-4f7a-8736-c86bddb260ba', '1', '炸酱面');
INSERT INTO `orderdetail` VALUES ('4a8aw9irx7q0', '539716d5-7343-4634-87d5-b4158f7cc4a7', '1', '酸菜牛肉拌面');
INSERT INTO `orderdetail` VALUES ('1mvqyqene5hc', '539716d5-7343-4634-87d5-b4158f7cc4a7', '1', '酸菜牛肉拌面');
INSERT INTO `orderdetail` VALUES ('1mvqyqene5hc', '0cd69581-8112-4f7a-8736-c86bddb260ba', '1', '炸酱面');
INSERT INTO `orderdetail` VALUES ('ldbci7ta8ps', '0cd69581-8112-4f7a-8736-c86bddb260ba', '1', '炸酱面');
INSERT INTO `orderdetail` VALUES ('6t7eug1scgw0', 'a865b81b-aeef-4433-8cae-34c3fcb7b0a0', '1', '炸酱面');
INSERT INTO `orderdetail` VALUES ('4c6zzs2c4cy0', '0cd69581-8112-4f7a-8736-c86bddb260ba', '1', '炸酱面');
INSERT INTO `orderdetail` VALUES ('4c6zzs2c4cy0', '539716d5-7343-4634-87d5-b4158f7cc4a7', '1', '酸菜牛肉拌面');
INSERT INTO `orderdetail` VALUES ('3mxah0038mq0', '0cd69581-8112-4f7a-8736-c86bddb260ba', '1', '炸酱面');

-- ----------------------------
-- Table structure for orders
-- ----------------------------
DROP TABLE IF EXISTS `orders`;
CREATE TABLE `orders` (
  `orderid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tablenum` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ordertime` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `dinnernum` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `remarks` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `totalprice` decimal(10,2) DEFAULT NULL,
  `username` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `statusone` varchar(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `statustwo` varchar(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`orderid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of orders
-- ----------------------------
INSERT INTO `orders` VALUES ('12x99874emkg', '1号桌', '2021-04-19 17:27:39', '8', '', '17.00', 'pony', '0', null);
INSERT INTO `orders` VALUES ('1j2l6wr03a4g', '3号桌', '2021-04-20 14:21:16', '1', '', '12.00', '123', '1', '0');
INSERT INTO `orders` VALUES ('1l2da4hang2o', '3号桌', '2021-04-19 17:27:41', '2', '', '24.00', 'bin', '0', null);
INSERT INTO `orders` VALUES ('1mvqyqene5hc', '3号桌', '2021-04-20 14:55:36', '2', '', '24.00', '123', '1', '0');
INSERT INTO `orders` VALUES ('1odpgko1cj4w', '1号桌', '2021-04-19 17:27:42', '6', 'haode', '12.00', 'pony', '0', null);
INSERT INTO `orders` VALUES ('1rwq4pszjp8g', '2号桌', '2021-04-19 17:27:42', '3', '', '36.00', 'bin', '0', null);
INSERT INTO `orders` VALUES ('1y29pr592h34', '3号桌', '2021-04-20 14:58:07', '2', '', '24.00', '123', '1', '0');
INSERT INTO `orders` VALUES ('21yhddum5j6o', '1号桌', '2021-04-20 01:22:12', '6', 'haode', '12.00', 'pony', '1', null);
INSERT INTO `orders` VALUES ('2jqsl2dns6s0', '2号桌', '2021-04-19 17:27:44', '4', '', '48.00', 'bin', '0', null);
INSERT INTO `orders` VALUES ('2s8iw3gi0fi0', '2号桌', '2021-04-19 17:27:45', '2', '', '24.00', 'bin', '0', null);
INSERT INTO `orders` VALUES ('2zxwbmt0uie0', '2号桌', '2021-04-20 01:20:36', '1', '', '12.00', 'bin', '1', null);
INSERT INTO `orders` VALUES ('3brgj8pb76a0', '2号桌', '2021-04-19 18:08:21', '3', '', '36.00', 'bin', '0', null);
INSERT INTO `orders` VALUES ('3dul56bs03m0', '4号桌', '2021-04-20 08:23:25', '1', '', '12.00', 'bin', '0', '0');
INSERT INTO `orders` VALUES ('3jpecpl3xag0', '2号桌', '2021-04-19 23:33:57', '3', '', '6.00', 'song', '1', null);
INSERT INTO `orders` VALUES ('3mxah0038mq0', '3号桌', '2021-04-22 22:39:10', '1', '', '12.00', '123', '0', '0');
INSERT INTO `orders` VALUES ('49v3wm0pp3c0', '3号桌', '2021-04-20 14:55:47', '2', '', '24.00', '123', '1', '0');
INSERT INTO `orders` VALUES ('49z58ldrbou0', '3号桌', '2021-04-20 01:20:07', '2', '', '24.00', 'bin', '1', null);
INSERT INTO `orders` VALUES ('4a8aw9irx7q0', '3号桌', '2021-04-20 14:58:05', '2', '', '24.00', '123', '1', '0');
INSERT INTO `orders` VALUES ('4c6zzs2c4cy0', '3号桌', '2021-04-22 22:38:55', '2', '', '24.00', '123', '0', '0');
INSERT INTO `orders` VALUES ('4vllo3ze7fy0', '2号桌', '2021-04-19 18:08:24', '2', '', '24.00', 'bin', '0', null);
INSERT INTO `orders` VALUES ('4vzok8wx3am0', '2号桌', '2021-04-19 23:32:26', '2', '', '24.00', 'bin', '1', null);
INSERT INTO `orders` VALUES ('4yltasabz4k0', '3号桌', '2021-04-19 23:32:51', '2', '', '24.00', 'bin', '1', '0');
INSERT INTO `orders` VALUES ('4z5i8nlmgvg0', '2号桌', '2021-04-19 18:48:00', '2', '', '24.00', 'bin', '1', null);
INSERT INTO `orders` VALUES ('5jwgd3jrke00', '4号桌', '2021-02-04 18:01:19', '7', '', '16.00', 'pony', null, null);
INSERT INTO `orders` VALUES ('5ridqe27hvk0', '2号桌', '2021-04-19 18:48:02', '1', '', '12.00', 'bin', '1', null);
INSERT INTO `orders` VALUES ('5synyyf7myo0', '3号桌', '2021-04-20 22:21:36', '1', '', '12.00', '123', '0', '0');
INSERT INTO `orders` VALUES ('5t2pavzxsgw0', '1号桌', '2021-04-19 18:48:03', '1', '', '12.00', 'bin', '1', null);
INSERT INTO `orders` VALUES ('5z5oq4qoozc0', '2号桌', '2021-04-20 01:14:13', '2', '', '24.00', 'bin', null, null);
INSERT INTO `orders` VALUES ('5zueg2secx80', '1号桌', '2021-04-19 04:40:57', '2', '', '24.00', 'bin', null, null);
INSERT INTO `orders` VALUES ('63shgdbb4xk0', '3号桌', '2021-04-20 05:06:03', '1', '', '12.00', '123', null, null);
INSERT INTO `orders` VALUES ('6jk14nqnliw0', '1号桌', '2021-04-19 16:34:41', '1', '', '12.00', 'bin', null, null);
INSERT INTO `orders` VALUES ('6kkd4icmt340', '2号桌', '2021-04-20 00:07:48', '2', '', '24.00', 'bin', null, null);
INSERT INTO `orders` VALUES ('6kwa18owlxw0', '2号桌', '2021-04-20 01:19:29', '3', '', '36.00', 'bin', '1', '0');
INSERT INTO `orders` VALUES ('6t7eug1scgw0', '3号桌', '2021-04-21 01:52:09', '1', '', '12.00', '123', '0', '0');
INSERT INTO `orders` VALUES ('6z6y7b6kgsc0', '2号桌', '2021-04-20 01:13:17', '2', '', '24.00', 'bin', null, null);
INSERT INTO `orders` VALUES ('74kmmthi0co0', '1号桌', '2021-02-04 17:58:46', '6', 'haode', '12.00', 'pony', null, null);
INSERT INTO `orders` VALUES ('7bfvdz76e7c0', '2号桌', '2021-04-20 01:19:53', '2', '', '24.00', 'bin', '1', '0');
INSERT INTO `orders` VALUES ('7jmkordahbc0', '2号桌', '2021-04-19 23:50:46', '3', '', '36.00', 'bin', null, null);
INSERT INTO `orders` VALUES ('7l26425g6140', '4号桌', '2021-04-20 01:19:39', '1', '', '10.00', 'bin', '1', '0');
INSERT INTO `orders` VALUES ('aobjv76tjc8', '1号桌', '2021-02-04 17:55:43', '6', 'haode', '12.00', 'pony', null, null);
INSERT INTO `orders` VALUES ('fyy3nd99u54', '2号桌', '2021-04-20 01:30:46', '2', '', '24.00', 'bin', null, null);
INSERT INTO `orders` VALUES ('ldbci7ta8ps', '3号桌', '2021-04-21 01:38:15', '1', '', '12.00', '123', '0', '0');
INSERT INTO `orders` VALUES ('s8r6sse7nz4', '4号桌', '2021-04-19 17:07:07', '2', '', '24.00', 'bin', null, null);

-- ----------------------------
-- Table structure for slide
-- ----------------------------
DROP TABLE IF EXISTS `slide`;
CREATE TABLE `slide` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `link` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of slide
-- ----------------------------
INSERT INTO `slide` VALUES ('22f6430e-0407-48e6-ae86-187d94ba7b86', '7', 'https://i8.meishichina.com/attachment/recipe/2014/12/22/20141222bdf2831550b7dda8.jpg?x-oss-process=style/p800');
INSERT INTO `slide` VALUES ('2dc778f6-7cd0-410b-a7db-7c87e8ecb375', '5', 'https://i8.meishichina.com/attachment/recipe/2017/12/28/2017122815144399302329124874.jpg?x-oss-process=style/p800');
INSERT INTO `slide` VALUES ('6b9fc06b-dc72-4605-9cc5-a12ef19619ee', '4', 'https://i8.meishichina.com/attachment/recipe/2014/07/18/20140718011500896477801.jpg?x-oss-process=style/p800');
INSERT INTO `slide` VALUES ('c0866e72-a1fa-476d-bdad-d691a77ee044', '6', 'https://i8.meishichina.com/attachment/recipe/2017/07/31/20170731150146859301013.png?x-oss-process=style/p800');

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `userid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `username` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `balance` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`userid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES ('3743b942-28c8-4eb3-a074-9df62c73e560', 'bin', '123', '8700.50');
INSERT INTO `users` VALUES ('3e9afd29-5176-4ac9-981f-12e576ee0367', '123', '123', '1951.00');
INSERT INTO `users` VALUES ('8e2453d5-cf41-4603-a905-7d2797c4f57d', 'qwe', 'qwe', '2000.00');
