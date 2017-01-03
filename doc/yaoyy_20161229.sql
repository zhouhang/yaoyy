/*
Navicat MySQL Data Transfer

Source Server         : 药优优-生产
Source Server Version : 50550
Source Host           : 139.224.104.121:3306
Source Database       : yaoyy

Target Server Type    : MYSQL
Target Server Version : 50550
File Encoding         : 65001

Date: 2016-12-29 19:03:21
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for ad
-- ----------------------------
DROP TABLE IF EXISTS `ad`;
CREATE TABLE `ad` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type_id` int(11) DEFAULT NULL COMMENT '广告类型ID',
  `name` varchar(64) DEFAULT NULL COMMENT '广告描述',
  `href` varchar(256) DEFAULT NULL COMMENT '广告链接',
  `sort` int(11) DEFAULT NULL,
  `picture_url` varchar(256) DEFAULT NULL COMMENT '广告图片url',
  `create_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `create_mem` int(11) DEFAULT NULL,
  `update_mem` int(11) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8 COMMENT='广告';

-- ----------------------------
-- Records of ad
-- ----------------------------
INSERT INTO `ad` VALUES ('3', '2', '三棱专场', 'http://www.yaobest.com/special/2', '100', '/opt/resources/yaobest/publicity/2016/11/8642fdae-9856-4fe4-8451-e56096b3d7d0.jpg', '2016-10-28 18:19:11', '2016-11-26 11:05:40', '0', '0', '1');
INSERT INTO `ad` VALUES ('4', '2', '白芍专场', 'http://www.yaobest.com/special/3', '50', '/opt/resources/yaobest/publicity/2016/11/0a0fd272-5a6a-461b-8044-062f27941ce2.jpg', '2016-10-28 18:19:45', '2016-11-26 11:06:11', '0', '0', '1');
INSERT INTO `ad` VALUES ('9', '1', '供货资源', 'http://www.yaobest.com/html/introduce', '60', '/opt/resources/yaobest/publicity/2016/11/6dc5e7a5-52c9-427a-87e5-ac01441c5d59.jpg', '2016-11-10 18:03:56', '2016-11-26 11:06:06', '0', '0', '1');
INSERT INTO `ad` VALUES ('10', '1', '底价直采', 'http://www.yaobest.com/html/introduce', '70', '/opt/resources/yaobest/publicity/2016/11/bb4d728d-abb2-4644-80be-9c7e1a122068.jpg', '2016-11-22 10:23:55', '2016-11-26 11:05:55', '0', '0', '1');
INSERT INTO `ad` VALUES ('11', '2', '半夏专场', 'http://www.yaobest.com/special/1', '80', '/opt/resources/yaobest/publicity/2016/11/6234fcbf-407d-4ff0-bf3e-731ad46904d1.jpg', '2016-11-22 10:25:41', '2016-11-26 11:05:46', '0', '0', '1');

-- ----------------------------
-- Table structure for ad_type
-- ----------------------------
DROP TABLE IF EXISTS `ad_type`;
CREATE TABLE `ad_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='广告类型';

-- ----------------------------
-- Records of ad_type
-- ----------------------------
INSERT INTO `ad_type` VALUES ('1', '首页banner', '2016-10-26 17:36:11');
INSERT INTO `ad_type` VALUES ('2', '专场广告', '2016-10-26 17:36:19');

-- ----------------------------
-- Table structure for article
-- ----------------------------
DROP TABLE IF EXISTS `article`;
CREATE TABLE `article` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(50) CHARACTER SET utf8 NOT NULL COMMENT '标题',
  `content` text CHARACTER SET utf8,
  `url` varchar(256) CHARACTER SET utf8 DEFAULT NULL COMMENT '链接',
  `status` int(5) NOT NULL DEFAULT '1' COMMENT '状态 1上架，0下架',
  `create_mem` int(11) DEFAULT NULL COMMENT '创建者',
  `create_time` datetime DEFAULT NULL,
  `update_mem` int(11) DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1 COMMENT='文章表';

-- ----------------------------
-- Records of article
-- ----------------------------
INSERT INTO `article` VALUES ('1', '联系我们', '&ltp&gt联系我们&lt/p&gt&ltp&gt&ltbr/&gt&lt/p&gt', null, '1', null, '2016-11-01 11:05:22', null, '2016-11-25 17:36:02');
INSERT INTO `article` VALUES ('2', '质量保证', '<p>\r\n    我们平台具有从源头产地到加工储运到质量检测都是有严格的管理体系。\r\n</p>\r\n<p>\r\n    产地：我们是联合道地产区的药农种植，采用适宜时间采收，确保了货源的品质。\r\n</p>\r\n<p>\r\n    加工：趁鲜加工，严格按照药典要求生产，确保各项指标均超过先行版药典。\r\n</p>\r\n<p>\r\n    检测：我们有三大企业沪谯，美誉，天济的检测支撑，做到入库品种批批检测。确保了入库品种100%全检合格。\r\n</p>\r\n<p>\r\n    储运：我们有10多万平方的仓储达到国家要求，以及严格的养护体系。\r\n</p>\r\n<p>\r\n    <br/>\r\n</p>', null, '1', null, '2016-11-01 11:06:07', null, '2016-12-01 10:10:10');
INSERT INTO `article` VALUES ('3', '合作协议', '<p>合作协议</p>', null, '1', null, '2016-11-01 11:06:22', null, '2016-11-01 11:06:22');
INSERT INTO `article` VALUES ('4', '关于我们', '<p><span style=\"font-family: arial, tahoma, &quot;Microsoft Yahei&quot;, 宋体; font-size: 12px; white-space: normal;\">关于我们</span></p>', null, '1', null, '2016-11-01 11:06:37', null, '2016-11-01 11:06:37');

-- ----------------------------
-- Table structure for category
-- ----------------------------
DROP TABLE IF EXISTS `category`;
CREATE TABLE `category` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pid` int(11) DEFAULT NULL COMMENT '父类id',
  `variety` varchar(128) NOT NULL COMMENT '品种名',
  `title` varchar(255) NOT NULL COMMENT '标题',
  `price_desc` varchar(100) DEFAULT NULL COMMENT '价格描述',
  `unit` varchar(10) DEFAULT NULL COMMENT '价格单位',
  `sort` int(10) NOT NULL,
  `create_time` datetime NOT NULL,
  `picture_url` varchar(512) NOT NULL,
  `status` int(11) NOT NULL DEFAULT '0' COMMENT '0锛氫笅鏋讹紝1锛氫笂鏋',
  `level` int(11) NOT NULL,
  `update_time` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8 COMMENT='商品分类表';

-- ----------------------------
-- Records of category
-- ----------------------------
INSERT INTO `category` VALUES ('1', '0', '根茎类', '根茎类', '', '', '0', '2016-10-13 17:35:09', '', '1', '1', '2016-10-13 17:35:18');
INSERT INTO `category` VALUES ('2', '0', '果实籽仁类', '果实籽仁类', '', '', '0', '2016-08-11 17:04:40', '', '1', '1', '2016-10-18 18:10:17');
INSERT INTO `category` VALUES ('3', '0', '花叶全草类', '花类', '', '', '0', '2016-08-11 17:04:40', '', '1', '1', '2016-10-18 18:10:23');
INSERT INTO `category` VALUES ('4', '0', '藤皮类', '树皮类', '', '', '0', '2016-08-11 17:04:42', '', '1', '1', '2016-10-18 18:10:25');
INSERT INTO `category` VALUES ('5', '0', '树脂菌藻类', '树脂类', '', '', '0', '2016-08-11 17:04:42', '', '1', '1', '2016-10-18 18:10:27');
INSERT INTO `category` VALUES ('6', '0', '矿石动物类', '动物类', '', '', '0', '2016-08-11 17:04:43', '', '1', '1', '2016-10-18 18:10:30');
INSERT INTO `category` VALUES ('7', '0', '其他类', '其他类', '', '', '0', '2016-09-09 17:56:41', '', '1', '1', '2016-10-18 18:10:32');
INSERT INTO `category` VALUES ('19', '1', '三棱', '浙江三棱  去毛  润  浸出物   1年生  无硫', '10.5-18', '公斤', '2', '2016-11-18 18:01:07', '/opt/resources/yaobest/category/2016/11/e955595c-82d1-4fbb-9c80-4d38f3085244.jpg', '1', '2', '2016-11-28 08:21:21');
INSERT INTO `category` VALUES ('20', '1', '半夏', '甘肃半夏 旱半夏  浸出物   1年生 正品 无硫', '105-150', '公斤', '3', '2016-11-20 17:09:27', '/opt/resources/yaobest/category/2016/11/260f3392-21b5-47d3-98f5-95d1e5567b66.jpg', '1', '2', '2016-11-28 08:21:06');
INSERT INTO `category` VALUES ('21', '1', '白芍', '亳白芍选片 趁鲜加工  芍药苷3.0%   5年生  无硫', null, null, '4', '2016-11-22 21:40:59', '/opt/resources/yaobest/category/2016/11/802c15d7-f31f-48e0-a2b1-7e63ea603931.jpg', '1', '2', '2016-11-23 17:16:19');
INSERT INTO `category` VALUES ('22', '2', '补骨脂', '云南补骨脂，5年陈货，含量1.0以上', null, null, '5', '2016-11-28 08:56:47', '/opt/resources/yaobest/category/2016/11/2682bfcc-5063-4979-aa6c-1b3ee2c3e94e.jpg', '1', '2', '2016-11-28 10:27:19');
INSERT INTO `category` VALUES ('23', '1', '白附子', '河南白附子  浸出物 无硫', null, null, '6', '2016-12-01 14:06:31', '/opt/resources/yaobest/category/2016/12/245abd01-b214-4264-b04c-29bb83cb87af.jpg', '1', '2', '2016-12-01 14:06:31');

-- ----------------------------
-- Table structure for code
-- ----------------------------
DROP TABLE IF EXISTS `code`;
CREATE TABLE `code` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(32) CHARACTER SET utf8 DEFAULT NULL,
  `name` varchar(64) CHARACTER SET utf8 DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of code
-- ----------------------------
INSERT INTO `code` VALUES ('1', 'UNIT', '公斤', '2016-10-26 16:07:54');
INSERT INTO `code` VALUES ('2', 'UNIT', '吨', '2016-10-26 16:07:57');
INSERT INTO `code` VALUES ('4', 'UNIT', '袋', '2016-10-26 16:08:29');

-- ----------------------------
-- Table structure for commodity
-- ----------------------------
DROP TABLE IF EXISTS `commodity`;
CREATE TABLE `commodity` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(256) NOT NULL COMMENT '标题',
  `name` varchar(128) NOT NULL COMMENT '商品名称',
  `har_year` varchar(20) NOT NULL COMMENT '采收年份',
  `origin` varchar(256) NOT NULL COMMENT '产地',
  `spec` varchar(255) NOT NULL COMMENT '规格等级',
  `process` varchar(255) DEFAULT NULL COMMENT '加工方式',
  `exterior` varchar(255) DEFAULT NULL COMMENT '性状特征',
  `executive_standard` varchar(255) DEFAULT NULL COMMENT '执行标准',
  `category_id` int(11) NOT NULL,
  `picture_url` varchar(255) NOT NULL,
  `detail` text NOT NULL,
  `status` int(11) NOT NULL DEFAULT '1',
  `attribute` text,
  `price` decimal(10,2) DEFAULT NULL,
  `unit` varchar(30) NOT NULL,
  `sort` int(11) DEFAULT NULL,
  `mark` smallint(10) NOT NULL DEFAULT '0' COMMENT '鏍囪?鏄?惁閲忓ぇ浠蜂紭',
  `create_time` datetime NOT NULL,
  `update_time` datetime NOT NULL,
  `minimum_quantity` int(11) DEFAULT NULL COMMENT '最小起购量',
  `slogan` varchar(45) DEFAULT NULL COMMENT '标语',
  `thumbnail_url` varchar(255) NOT NULL,
  `supplier_id` int(11) DEFAULT NULL COMMENT '供应商id',
  `price_update_time` datetime DEFAULT NULL COMMENT '价格更新时间',
  PRIMARY KEY (`id`),
  KEY `category_id` (`category_id`),
  CONSTRAINT `commodity_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `category` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8 COMMENT='商品表';

-- ----------------------------
-- Records of commodity
-- ----------------------------
INSERT INTO `commodity` VALUES ('1', '三棱，个，浙江，鳞皮去毛，呈圆锥形，略扁，长3cm-6cm直径3cm-4cm ', '三棱', '2016年10月', '浙江', '去毛统个、长2cm-6cm、直径2cm-4cm', null, null, null, '19', '/opt/resources/yaobest/commodity/2016/11/71a7db7b-f381-4874-9f7a-95e13f0bd24bCrop.jpg', '<p><img src=\"http://static.yaobest.com/ueditor/2016/11/363cbed7-4ac4-4a34-be01-b6c944716067.jpg\" _src=\"http://static.yaobest.com/ueditor/2016/11/363cbed7-4ac4-4a34-be01-b6c944716067.jpg\" style=\"\"/></p><p><img src=\"http://static.yaobest.com/ueditor/2016/11/a87a93fa-ea39-480f-ac36-157723fd0781.jpg\" _src=\"http://static.yaobest.com/ueditor/2016/11/a87a93fa-ea39-480f-ac36-157723fd0781.jpg\" style=\"\"/></p><p><img src=\"http://static.yaobest.com/ueditor/2016/11/cc822e9d-e3dc-481a-a41e-f7e6f6ddab8a.jpg\" _src=\"http://static.yaobest.com/ueditor/2016/11/cc822e9d-e3dc-481a-a41e-f7e6f6ddab8a.jpg\" style=\"\"/></p><p><br/></p><p><br/></p><p><br/></p>', '1', '{\"加工方式\":\"去毛、干燥\",\"生长年限\":\"1年\",\"采收时间\":\"2016年10月\",\"含硫情况\":\"无硫\",\"性状鉴别\":\"圆锥形，略扁，长2cm-6cm直径2cm-4cm，表面黄白色或灰黄色，有刀削痕，须根痕小点呈横向排列\",\"质量标准\":\"现行版《中国药典》\",\"水分\":\"9.7%\",\"浸出物\":\"8.1%\",\"总灰分\":\"2.4%\"}', '15.00', '1', '0', '0', '2016-11-18 18:08:23', '2016-12-06 11:37:02', '50', '', 'http://static.yaobest.com/temp/2016/11/ab078b3c-fab5-4201-9e63-b44428714cfdCrop.jpg', null, null);
INSERT INTO `commodity` VALUES ('2', '三棱，统个，浙江，长2cm-6cm直径2cm-4cm，火燎或撞去毛，有些许残留的毛须', '三棱', '2016年10月', '浙江', '统个、火燎或撞毛、长2cm-6cm、直径2cm-4cm', null, null, null, '19', '/opt/resources/yaobest/commodity/2016/11/0d0aac35-156c-4add-a058-eb37dc84c531Crop.jpg', '<p><img src=\"http://static.yaobest.com/ueditor/2016/11/8939d26f-87c3-42a8-ba8a-ac11e483bf81.jpg\" _src=\"http://static.yaobest.com/ueditor/2016/11/8939d26f-87c3-42a8-ba8a-ac11e483bf81.jpg\" style=\"\"/></p><p><img src=\"http://static.yaobest.com/ueditor/2016/11/34bd7132-6d66-440d-8452-e471c4f03967.jpg\" _src=\"http://static.yaobest.com/ueditor/2016/11/34bd7132-6d66-440d-8452-e471c4f03967.jpg\" style=\"\"/></p><p><img src=\"http://static.yaobest.com/ueditor/2016/11/9177f6a9-579c-41cf-b11e-d7cb500b24ef.jpg\" _src=\"http://static.yaobest.com/ueditor/2016/11/9177f6a9-579c-41cf-b11e-d7cb500b24ef.jpg\" style=\"\"/></p><p><br/></p>', '1', '{\"加工方式\":\"火燎或撞去毛、干燥\",\"生长年限\":\"1年\",\"采收时间\":\"2016年10月\",\"含硫情况\":\"无硫\",\"性状特征\":\"圆锥形，略扁，长2cm-6cm直径2cm-4cm，表面黄白色或灰黄色，有刀削痕，须根痕小点呈横向排列\",\"质量标准\":\"现行版《中国药典》\",\"水分\":\"9.7%\",\"浸出物\":\"8.1%\",\"总灰分\":\"2.4%\"}', '10.50', '1', '1', '0', '2016-11-18 18:15:18', '2016-12-15 17:40:56', '50', '', 'http://static.yaobest.com/temp/2016/11/7e12d9da-920b-4853-9d85-62aa963aaa13Crop.jpg', null, '2016-12-15 17:40:56');
INSERT INTO `commodity` VALUES ('3', '三棱，片，浙江，过4号筛，直径1cm以上', '三棱', '2016.10', '浙江', '过4号筛，直径1cm以上', null, null, null, '19', '/opt/resources/yaobest/commodity/2016/11/7a92874a-75ac-4b17-9776-fc0eb8eca0f0Crop.jpg', '<p><img src=\"http://static.yaobest.com/ueditor/2016/11/2b4208a4-18f9-4bda-b8b6-9b3c92387674.jpg\" _src=\"http://static.yaobest.com/ueditor/2016/11/2b4208a4-18f9-4bda-b8b6-9b3c92387674.jpg\" style=\"\"/></p><p><img src=\"http://static.yaobest.com/ueditor/2016/11/ea4fbfde-617f-45e3-a24f-4d34d4527e2b.jpg\" _src=\"http://static.yaobest.com/ueditor/2016/11/ea4fbfde-617f-45e3-a24f-4d34d4527e2b.jpg\" style=\"\"/></p><p><img src=\"http://static.yaobest.com/ueditor/2016/11/ef0f578e-1c3a-46e3-a6df-9341e360553b.jpg\" _src=\"http://static.yaobest.com/ueditor/2016/11/ef0f578e-1c3a-46e3-a6df-9341e360553b.jpg\" style=\"\"/></p><p><br/></p>', '1', '{\"加工方式\":\"去毛、干燥\",\"生长年限\":\"1年\",\"采收时间\":\"2016年10月\",\"含硫情况\":\"无硫\",\"性状特征\":\"圆锥形，略扁，长2cm-6cm直径2cm-4cm，表面黄白色或灰黄色，有刀削痕，须根痕小点呈横向排列\",\"质量标准\":\"现行版《中国药典》\",\"水分\":\"9.7%\",\"浸出物\":\"8.1%\",\"总灰分\":\"2.4%\"}', '10.50', '1', '2', '0', '2016-11-18 18:24:13', '2016-12-06 11:39:20', '50', '', 'http://static.yaobest.com/temp/2016/11/0bf21a3b-cdce-44e3-b7ac-298e8cdbebfdCrop.jpg', null, null);
INSERT INTO `commodity` VALUES ('4', '三棱，片，浙江，过20号筛，直径2cm以上', '三棱', '2016年10月', '浙江', '过20号筛，直径2cm以上', null, null, null, '19', '/opt/resources/yaobest/commodity/2016/11/6c39dd87-5d64-4552-96fe-6c0ae973a783Crop.jpg', '<p><img src=\"http://static.yaobest.com/ueditor/2016/11/c95a5eaf-48c1-4d8f-9d82-7d5df88f0c38.jpg\" _src=\"http://static.yaobest.com/ueditor/2016/11/c95a5eaf-48c1-4d8f-9d82-7d5df88f0c38.jpg\" style=\"\"/></p><p><img src=\"http://static.yaobest.com/ueditor/2016/11/eebe63b6-1946-4229-a08c-096f94031b8e.jpg\" _src=\"http://static.yaobest.com/ueditor/2016/11/eebe63b6-1946-4229-a08c-096f94031b8e.jpg\" style=\"\"/></p><p><img src=\"http://static.yaobest.com/ueditor/2016/11/5aed6878-6deb-4956-ae2c-49ba5d43a730.jpg\" _src=\"http://static.yaobest.com/ueditor/2016/11/5aed6878-6deb-4956-ae2c-49ba5d43a730.jpg\" style=\"\"/></p><p><br/></p>', '1', '{\"加工方式\":\"去毛、干燥\",\"生长年限\":\"1年\",\"采收时间\":\"2016年10月\",\"含硫情况\":\"无硫\",\"性状特征\":\"圆锥形，略扁，长2cm-6cm直径2cm-4cm，表面黄白色或灰黄色，有刀削痕，须根痕小点呈横向排列\",\"质量标准\":\"现行版《中国药典》\",\"水分\":\"9.7%\",\"浸出物\":\"8.1%\",\"总灰分\":\"2.4%\"}', '18.00', '1', '3', '0', '2016-11-18 18:29:05', '2016-12-06 11:40:01', '50', '', 'http://static.yaobest.com/temp/2016/11/8482da57-fcfe-4d9c-9f2e-3a6f07c72879Crop.jpg', null, null);
INSERT INTO `commodity` VALUES ('5', '旱半夏，统个，甘肃，过4号筛，直径0.4cm~1.4cm', '半夏', '2016年8月', '甘肃', '统货，过4号筛，直径0.4cm~1.4cm', null, null, null, '20', '/opt/resources/yaobest/commodity/2016/11/d92ad1c9-4671-4b58-93e5-4f98ecf18a8eCrop.jpg', '<p><img src=\"http://static.yaobest.com/ueditor/2016/11/af34926f-0793-4d22-8528-578281d9e373.jpg\" _src=\"http://static.yaobest.com/ueditor/2016/11/af34926f-0793-4d22-8528-578281d9e373.jpg\" style=\"\"/></p><p><img src=\"http://static.yaobest.com/ueditor/2016/11/f0513146-457e-4c3d-bc3e-046fac65da3e.jpg\" _src=\"http://static.yaobest.com/ueditor/2016/11/f0513146-457e-4c3d-bc3e-046fac65da3e.jpg\" style=\"\"/></p><p><img src=\"http://static.yaobest.com/ueditor/2016/11/a31b99d6-b3fc-4aa8-af4a-fb8efdefe02c.jpg\" _src=\"http://static.yaobest.com/ueditor/2016/11/a31b99d6-b3fc-4aa8-af4a-fb8efdefe02c.jpg\" style=\"\"/></p><p><br/></p><p><br/></p>', '1', '{\"加工方式\":\"去外皮，干燥 \",\"生长年限\":\"1年\",\"采收时间\":\"2016年08月\",\"性状特征\":\"类球形形，白色或浅黄色，顶端有凹陷的茎痕，周围密布麻点状根痕；下面钝圆，较光滑。质坚实，断面洁白，富粉性\",\"质量标准\":\"现行版《中国药典》\",\"含硫情况\":\"无硫\"}', '105.00', '1', '0', '0', '2016-11-20 17:15:27', '2016-12-01 14:21:44', '50', '', 'http://static.yaobest.com/temp/2016/11/ecbd1eff-aa82-4701-b2ba-0b735ec50cbbCrop.jpg', null, null);
INSERT INTO `commodity` VALUES ('6', '旱半夏，个，丙级，甘肃，6号筛-10号筛之间，直径0.6cm-1cm', '半夏', '2016.08', '甘肃', '丙级，6号筛-10号筛之间，直径0.6cm-1cm', null, null, null, '20', '/opt/resources/yaobest/commodity/2016/11/d25683f4-306b-428e-8c2d-eede24b09516Crop.jpg', '<p><img src=\"http://static.yaobest.com/ueditor/2016/11/08af040e-c32b-49ca-9bce-a04d0d0655fd.jpg\" _src=\"http://static.yaobest.com/ueditor/2016/11/08af040e-c32b-49ca-9bce-a04d0d0655fd.jpg\" style=\"\"/></p><p><img src=\"http://static.yaobest.com/ueditor/2016/11/675090bc-1714-4801-a53a-ce5929781d33.jpg\" _src=\"http://static.yaobest.com/ueditor/2016/11/675090bc-1714-4801-a53a-ce5929781d33.jpg\" style=\"\"/></p><p><img src=\"http://static.yaobest.com/ueditor/2016/11/a362f5d1-4b1b-4c9d-af37-62fbede1ca7c.jpg\" _src=\"http://static.yaobest.com/ueditor/2016/11/a362f5d1-4b1b-4c9d-af37-62fbede1ca7c.jpg\" style=\"\"/></p><p><br/></p><p><br/></p>', '1', '{\"加工方式\":\"去外皮，干燥 \",\"生长年限\":\"1年\",\"采收时间\":\"2016年08月\",\"性状特征\":\"类球形形，白色或浅黄色，顶端有凹陷的茎痕，周围密布麻点状根痕；下面钝圆，较光滑。质坚实，断面洁白，富粉性\",\"质量标准\":\"现行版《中国药典》\",\"含硫情况\":\"无硫\"}', '120.00', '1', '1', '0', '2016-11-20 17:24:24', '2016-12-01 14:21:29', '50', '', 'http://static.yaobest.com/temp/2016/11/a546d791-f40f-4a1c-b17a-eff4ced9a27bCrop.jpg', null, null);
INSERT INTO `commodity` VALUES ('7', '乙级，10号筛-12号筛之间，直径1.0cm-1.2cm', '半夏', '2016.08', '甘肃', '乙级，10号筛-12号筛之间，直径1.0cm-1.2cm', null, null, null, '20', '/opt/resources/yaobest/commodity/2016/11/fe97db42-7a9c-456d-a749-d422aa60be7dCrop.jpg', '<p><img src=\"http://static.yaobest.com/ueditor/2016/11/95839440-7b4f-4c60-8c44-ba91e9e6746d.jpg\" _src=\"http://static.yaobest.com/ueditor/2016/11/95839440-7b4f-4c60-8c44-ba91e9e6746d.jpg\" style=\"\"/></p><p><img src=\"http://static.yaobest.com/ueditor/2016/11/7f20f6cc-502a-4219-9f7e-787510b07d24.jpg\" _src=\"http://static.yaobest.com/ueditor/2016/11/7f20f6cc-502a-4219-9f7e-787510b07d24.jpg\" style=\"\"/></p><p><img src=\"http://static.yaobest.com/ueditor/2016/11/bec98382-9e3a-4166-86a1-b25b95cd9b3b.jpg\" _src=\"http://static.yaobest.com/ueditor/2016/11/bec98382-9e3a-4166-86a1-b25b95cd9b3b.jpg\" style=\"\"/></p><p><br/></p>', '1', '{\"加工方式\":\"去外皮，干燥\",\"生长年限\":\"1年\",\"采收时间\":\"2016.08\",\"性状\":\"类球形形，白色或浅黄色，顶端有凹陷的茎痕，周围密布麻点状根痕；下面钝圆，较光滑。质坚实，断面洁白，富粉性\",\"质量规范\":\"现行版《中国药典》\",\"含硫情况\":\"无硫\"}', '125.00', '1', '2', '0', '2016-11-20 17:27:46', '2016-12-01 14:21:15', '50', '', 'http://static.yaobest.com/temp/2016/11/77b328fc-9840-41fa-83f4-906a3e1f8d95Crop.jpg', null, null);
INSERT INTO `commodity` VALUES ('8', '旱半夏，个，甲级，甘肃，12号筛-14号筛之间，直径1.2-1.4cm', '半夏', '2016年08月', '甘肃', '甲级，12号筛-14号筛之间，直径1.2-cm1.4cm', null, null, null, '20', '/opt/resources/yaobest/commodity/2016/11/20a7a200-8dbf-4b82-a5c1-a5abc70097a1Crop.jpg', '<p><img src=\"http://static.yaobest.com/ueditor/2016/11/2152a4cc-20d6-46a2-9396-fe123a06150e.jpg\" _src=\"http://static.yaobest.com/ueditor/2016/11/2152a4cc-20d6-46a2-9396-fe123a06150e.jpg\" style=\"\"/></p><p><img src=\"http://static.yaobest.com/ueditor/2016/11/e578151a-86db-4a67-82dd-196dcc17f16f.jpg\" _src=\"http://static.yaobest.com/ueditor/2016/11/e578151a-86db-4a67-82dd-196dcc17f16f.jpg\" style=\"\"/></p><p><img src=\"http://static.yaobest.com/ueditor/2016/11/0fbad8fd-0085-4e85-b1ba-81704b908c86.jpg\" _src=\"http://static.yaobest.com/ueditor/2016/11/0fbad8fd-0085-4e85-b1ba-81704b908c86.jpg\" style=\"\"/></p><p><br/></p><p><br/></p>', '1', '{\"加工方式\":\"去外皮，干燥\",\"生长年限\":\"1年\",\"采收时间\":\"2016年08月\",\"性状特征\":\"类球形形，白色或浅黄色，顶端有凹陷的茎痕，周围密布麻点状根痕；下面钝圆，较光滑。质坚实，断面洁白，富粉性\",\"质量标准\":\"现行版《中国药典》\",\"含硫情况\":\"无硫\"}', '150.00', '1', '3', '0', '2016-11-20 17:31:01', '2016-12-01 14:21:02', '50', '', 'http://static.yaobest.com/temp/2016/11/625d5378-7a95-404b-9571-8fa2be236c5eCrop.jpg', null, null);
INSERT INTO `commodity` VALUES ('10', '亳白芍，选片，亳州，14-16号筛，趁鲜加工，5年生，无硫', '白芍', '2016年9月', '亳州', '14-16号筛，直径1.4cm-1.6cm', null, null, null, '21', '/opt/resources/yaobest/commodity/2016/11/2c6a4c81-7ec5-4301-8c3c-4ad171c6dab7Crop.jpg', '<p><img src=\"http://static.yaobest.com/ueditor/2016/11/204534f3-2364-4a88-967d-ecf8882101cb.jpg\" _src=\"http://static.yaobest.com/ueditor/2016/11/204534f3-2364-4a88-967d-ecf8882101cb.jpg\" style=\"\"/></p><p><img src=\"http://static.yaobest.com/ueditor/2016/11/942af4f3-a99b-43f9-8526-a54cd40959e2.jpg\" _src=\"http://static.yaobest.com/ueditor/2016/11/942af4f3-a99b-43f9-8526-a54cd40959e2.jpg\" style=\"\"/></p><p><img src=\"http://static.yaobest.com/ueditor/2016/11/9ea385e4-2e65-411d-b5d1-e54d2ea2d536.jpg\" _src=\"http://static.yaobest.com/ueditor/2016/11/9ea385e4-2e65-411d-b5d1-e54d2ea2d536.jpg\" style=\"\"/></p><p><br/></p>', '1', '{\"加工方式\":\"趁鲜加工\",\"生长年限\":\"5年\",\"含量\":\"芍药苷3.0%（药典含量1.2%）\",\"性状特征\":\"圆形薄片，断面类白色或淡棕红色，形成层环较明显，隆起筋脉呈放射状排列\",\"质量标准\":\"现行版《中国药典》\"}', '37.00', '1', '1', '0', '2016-11-23 09:07:28', '2016-12-01 14:20:46', '50', '', 'http://static.yaobest.com/temp/2016/11/a5876e20-51f7-431f-b7e7-001a5c807232Crop.jpg', null, null);
INSERT INTO `commodity` VALUES ('12', '云南补骨脂，5年陈货，含量1.0以上', '补骨脂', '2011年10月', '云南', '过风车，净 长3mm～5mm，宽2mm～4mm', null, null, null, '22', '/opt/resources/yaobest/commodity/2016/11/4458a958-871a-4dd3-855c-c9932e0761d2Crop.jpg', '<p><img src=\"http://static.yaobest.com/ueditor/2016/11/c11855f3-05e9-4f25-9c20-97e516a21a6a.jpg\" _src=\"http://static.yaobest.com/ueditor/2016/11/c11855f3-05e9-4f25-9c20-97e516a21a6a.jpg\" style=\"\"/></p><p><img src=\"http://static.yaobest.com/ueditor/2016/11/6e1b1def-699a-4459-af7b-fb1eff29cfa1.jpg\" _src=\"http://static.yaobest.com/ueditor/2016/11/6e1b1def-699a-4459-af7b-fb1eff29cfa1.jpg\" style=\"\"/></p><p><img src=\"http://static.yaobest.com/ueditor/2016/11/ce805647-d071-4f15-b007-b5608d845c62.jpg\" _src=\"http://static.yaobest.com/ueditor/2016/11/ce805647-d071-4f15-b007-b5608d845c62.jpg\" style=\"\"/></p><p><img src=\"http://static.yaobest.com/ueditor/2016/11/ddaa1317-9a8b-4805-ad65-14fa3c55766b.jpg\" _src=\"http://static.yaobest.com/ueditor/2016/11/ddaa1317-9a8b-4805-ad65-14fa3c55766b.jpg\" style=\"\"/></p><p><br/></p>', '1', '{\"加工方式\":\"除杂，晒干\",\"生长年限\":\"1年\",\"性状特征\":\"表面黑色或黑褐色，微鼓起。气微香，味微咸\",\"质量标准\":\"现行版《中国药典》\"}', '11.50', '1', '0', '0', '2016-11-28 09:35:48', '2016-12-01 14:20:34', '50', '', 'http://static.yaobest.com/temp/2016/11/e882503f-1a6a-4fbb-9e54-9b4a3bc0968dCrop.jpg', null, null);
INSERT INTO `commodity` VALUES ('13', '亳白芍选片6-16号筛  趁鲜加工  芍药苷1.6 %   5年生  无硫', '白芍', '2016年6月', '亳州', '过6-16号筛，直径0.6-1.6cm，厚度2-3mm ', null, null, null, '21', '/opt/resources/yaobest/commodity/2016/12/0020589c-809d-4b63-81f3-52a35d8443e7Crop.jpg', '<p><img src=\"http://static.yaobest.com/ueditor/2016/12/6767f2e5-b6be-4259-9e8a-ec4883b5ef32.jpg\" _src=\"http://static.yaobest.com/ueditor/2016/12/6767f2e5-b6be-4259-9e8a-ec4883b5ef32.jpg\" style=\"\"/></p><p><img src=\"http://static.yaobest.com/ueditor/2016/12/a6c3ad89-e721-471d-a859-f26e2a00fca7.jpg\" _src=\"http://static.yaobest.com/ueditor/2016/12/a6c3ad89-e721-471d-a859-f26e2a00fca7.jpg\" style=\"\"/></p><p><img src=\"http://static.yaobest.com/ueditor/2016/12/14182ca6-46f2-44cd-ab0a-57a3d17fda7b.jpg\" _src=\"http://static.yaobest.com/ueditor/2016/12/14182ca6-46f2-44cd-ab0a-57a3d17fda7b.jpg\" style=\"\"/></p><p><br/></p>', '1', '{\"加工方式\":\"产地收购，趁鲜加工\",\"生长年限\":\"5年\",\"含硫情况\":\"无硫\",\"芍药苷含量\":\"1.6%（药典要求含量不低于1.2%）\",\"性状特征\":\"圆形薄片，断面类白色或淡棕红色，形成层环较明显，隆起筋脉呈放射状排列\",\"质量标准\":\"现行版《中国药典》\"}', '18.00', '1', '2', '0', '2016-12-01 13:55:20', '2016-12-01 14:20:18', '50', '', 'http://static.yaobest.com/temp/2016/12/eced8ca2-626f-4efb-b01d-a44259f8af67Crop.jpg', null, null);
INSERT INTO `commodity` VALUES ('14', '亳白芍统货  2号筛以上  趁鲜加工  芍药苷1.6 %   5年生  无硫', '白芍', '2016年6月', '亳州', ' 统货，2号筛以上，直径0.2cm以上，厚度2-3mm', null, null, null, '21', '/opt/resources/yaobest/commodity/2016/12/e09dcb2b-ab6a-4b9a-829f-27ab9349ae47Crop.jpg', '<p><img src=\"http://static.yaobest.com/ueditor/2016/12/4d7bc98b-7a3d-448b-bb61-eb68c18f3a6b.jpg\" _src=\"http://static.yaobest.com/ueditor/2016/12/4d7bc98b-7a3d-448b-bb61-eb68c18f3a6b.jpg\" style=\"\"/></p><p><img src=\"http://static.yaobest.com/ueditor/2016/12/07478c2c-fc69-48ad-9e47-aefd5ccf01b0.jpg\" _src=\"http://static.yaobest.com/ueditor/2016/12/07478c2c-fc69-48ad-9e47-aefd5ccf01b0.jpg\" style=\"\"/></p><p><img src=\"http://static.yaobest.com/ueditor/2016/12/cf17cb2e-6754-42a8-9b35-c7796f1a6117.jpg\" _src=\"http://static.yaobest.com/ueditor/2016/12/cf17cb2e-6754-42a8-9b35-c7796f1a6117.jpg\"/></p><p><br/></p>', '1', '{\"加工方式\":\"产地收购，趁鲜加工\",\"生长年限\":\"5年\",\"含硫情况\":\"无硫\",\"芍药苷含量\":\"1.6%（药典含量要求不低于1.2%）\",\"性状特征\":\"圆形薄片，断面类白色或淡棕红色，形成层环较明显，隆起筋脉呈放射状排列\",\"质量标准\":\"现行版《中国药典》\"}', '15.00', '1', '0', '0', '2016-12-01 14:01:15', '2016-12-05 09:51:28', '50', '', 'http://static.yaobest.com/temp/2016/12/b6ba7e4e-5ae8-4ef4-9659-065b9bdc5d4cCrop.jpg', null, null);
INSERT INTO `commodity` VALUES ('15', '河南白附子 个 浸出物 无硫', '白附子', '2016年10月', '河南', '统个，长2-5cm，直径1-3cm', null, null, null, '23', '/opt/resources/yaobest/commodity/2016/12/2e389884-ed91-4eea-abce-424ac7583ef7Crop.jpg', '<p><img src=\"http://static.yaobest.com/ueditor/2016/12/ba43e01b-9c9d-49a6-96b4-11b0a71de43b.jpg\" _src=\"http://static.yaobest.com/ueditor/2016/12/ba43e01b-9c9d-49a6-96b4-11b0a71de43b.jpg\" style=\"\"/></p><p><img src=\"http://static.yaobest.com/ueditor/2016/12/4344caa0-2c8a-4d0c-bfa4-dcfad3e4702f.jpg\" _src=\"http://static.yaobest.com/ueditor/2016/12/4344caa0-2c8a-4d0c-bfa4-dcfad3e4702f.jpg\" style=\"\"/></p><p><img src=\"http://static.yaobest.com/ueditor/2016/12/3d6311b3-0dac-4342-841d-3029f650b572.jpg\" _src=\"http://static.yaobest.com/ueditor/2016/12/3d6311b3-0dac-4342-841d-3029f650b572.jpg\" style=\"\"/></p><p><br/></p>', '1', '{\"加工方式\":\"去皮，干燥\",\"生长年限\":\"1年\",\"含硫情况\":\"无硫\",\"浸出物\":\"7.2%（药典要求含量不少于7%）\",\"性状特征\":\"椭圆形或卵圆形，表面白色至黄白色，略粗糙，有环纹及须根痕，顶端有茎痕或芽痕。质坚硬，断面白色，粉性。\",\"质量标准\":\"现行版《中国药典》\"}', '30.00', '1', '0', '0', '2016-12-01 14:12:03', '2016-12-02 15:55:19', '50', '', 'http://static.yaobest.com/temp/2016/12/869607af-787e-4df8-8bf2-8b7eab2c8190Crop.jpg', null, null);
INSERT INTO `commodity` VALUES ('16', '河南制白附子 厚片 浸出物 无硫', '制白附子', '2016年10月', '河南', '厚片2-4mm，过四号筛', null, null, null, '23', '/opt/resources/yaobest/commodity/2016/12/7b2b6149-b141-43cd-a9e2-a2b24d006a78Crop.jpg', '<p><img src=\"http://static.yaobest.com/ueditor/2016/12/a960d9fb-b499-4b3d-95a6-fc9558d3e049.jpg\" _src=\"http://static.yaobest.com/ueditor/2016/12/a960d9fb-b499-4b3d-95a6-fc9558d3e049.jpg\" style=\"\"/></p><p><img src=\"http://static.yaobest.com/ueditor/2016/12/7dd35606-fd73-40dc-a05e-a94a4e7cfdaa.jpg\" _src=\"http://static.yaobest.com/ueditor/2016/12/7dd35606-fd73-40dc-a05e-a94a4e7cfdaa.jpg\" style=\"\"/></p><p><img src=\"http://static.yaobest.com/ueditor/2016/12/b4ab2dc7-f2e5-4e5e-92bd-8d0eee6df592.jpg\" _src=\"http://static.yaobest.com/ueditor/2016/12/b4ab2dc7-f2e5-4e5e-92bd-8d0eee6df592.jpg\" style=\"\"/></p><p><br/></p>', '1', '{\"加工方式\":\"浸泡，切片，干燥\",\"生长年限\":\"1年\",\"含硫情况\":\"无硫\",\"浸出物\":\"浸出物18%（药典含量不少于15%）\",\"性状特征\":\"圆形或椭圆形厚片，外表皮淡棕色，切面黄色，角质。\",\"质量标准\":\"现行版《中国药典》\"}', '48.00', '1', '1', '0', '2016-12-01 14:17:27', '2016-12-02 15:55:54', '50', '', 'http://static.yaobest.com/temp/2016/12/ad7e48da-55bd-4e7e-9910-138b1bd8841aCrop.jpg', null, null);

-- ----------------------------
-- Table structure for follow_commodity
-- ----------------------------
DROP TABLE IF EXISTS `follow_commodity`;
CREATE TABLE `follow_commodity` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `commodity_id` int(11) DEFAULT NULL,
  `price` decimal(10,2) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `status` int(11) DEFAULT '0' COMMENT '标识商品价格是否有改变，0无，1有',
  PRIMARY KEY (`id`),
  KEY `follow_commodity_ibfk` (`commodity_id`),
  CONSTRAINT `follow_commodity_ibfk` FOREIGN KEY (`commodity_id`) REFERENCES `commodity` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of follow_commodity
-- ----------------------------
INSERT INTO `follow_commodity` VALUES ('1', '5', '105.00', '17', '2016-12-15 13:48:44', '0');
INSERT INTO `follow_commodity` VALUES ('2', '7', '125.00', '17', '2016-12-15 13:48:57', '0');
INSERT INTO `follow_commodity` VALUES ('3', '2', '10.50', '17', '2016-12-15 13:49:08', '0');
INSERT INTO `follow_commodity` VALUES ('4', '4', '18.00', '17', '2016-12-15 13:49:27', '0');
INSERT INTO `follow_commodity` VALUES ('5', '1', '15.00', '129', '2016-12-15 13:56:01', '0');

-- ----------------------------
-- Table structure for gradient
-- ----------------------------
DROP TABLE IF EXISTS `gradient`;
CREATE TABLE `gradient` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `commodity_id` int(11) NOT NULL,
  `start` float NOT NULL,
  `end` float NOT NULL,
  `price` decimal(10,0) NOT NULL,
  `unit` varchar(30) DEFAULT NULL,
  `create_time` datetime NOT NULL,
  `update_time` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='商品价格梯度表';

-- ----------------------------
-- Records of gradient
-- ----------------------------

-- ----------------------------
-- Table structure for history_commodity
-- ----------------------------
DROP TABLE IF EXISTS `history_commodity`;
CREATE TABLE `history_commodity` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(256) CHARACTER SET utf8 NOT NULL,
  `name` varchar(128) CHARACTER SET utf8 NOT NULL,
  `commodity_id` int(11) NOT NULL COMMENT '商品id',
  `origin` varchar(256) CHARACTER SET utf8 NOT NULL,
  `spec` varchar(255) CHARACTER SET utf8 NOT NULL,
  `price` decimal(10,0) NOT NULL,
  `unit` varchar(30) CHARACTER SET utf8 NOT NULL,
  `picture_url` varchar(255) CHARACTER SET utf8 NOT NULL,
  `thumbnail_url` varchar(255) CHARACTER SET utf8 NOT NULL,
  `create_time` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=57 DEFAULT CHARSET=latin1 COMMENT='历史商品信息表';

-- ----------------------------
-- Records of history_commodity
-- ----------------------------
INSERT INTO `history_commodity` VALUES ('33', '统货，过4号筛，直径0.4~1.4cm', '半夏', '5', '甘肃', '统货，过4号筛，直径0.4~1.4cm', '105', '公斤', 'http://static.yaobest.com/commodity/2016/11/d92ad1c9-4671-4b58-93e5-4f98ecf18a8eCrop.jpg', 'http://static.yaobest.com/temp/2016/11/ecbd1eff-aa82-4701-b2ba-0b735ec50cbbCrop.jpg', '2016-11-23 09:40:36');
INSERT INTO `history_commodity` VALUES ('34', '统货，过4号筛，直径0.4~1.4cm', '半夏', '5', '甘肃', '统货，过4号筛，直径0.4~1.4cm', '105', '公斤', 'http://static.yaobest.com/commodity/2016/11/d92ad1c9-4671-4b58-93e5-4f98ecf18a8eCrop.jpg', 'http://static.yaobest.com/temp/2016/11/ecbd1eff-aa82-4701-b2ba-0b735ec50cbbCrop.jpg', '2016-11-23 09:45:45');
INSERT INTO `history_commodity` VALUES ('35', '统货，过4号筛，直径0.4~1.4cm', '半夏', '5', '甘肃', '统货，过4号筛，直径0.4~1.4cm', '105', '公斤', 'http://static.yaobest.com/commodity/2016/11/d92ad1c9-4671-4b58-93e5-4f98ecf18a8eCrop.jpg', 'http://static.yaobest.com/temp/2016/11/ecbd1eff-aa82-4701-b2ba-0b735ec50cbbCrop.jpg', '2016-11-23 18:44:15');
INSERT INTO `history_commodity` VALUES ('36', '统货，过4号筛，直径0.4~1.4cm', '半夏', '5', '甘肃', '统货，过4号筛，直径0.4~1.4cm', '105', '公斤', 'http://static.yaobest.com/commodity/2016/11/d92ad1c9-4671-4b58-93e5-4f98ecf18a8eCrop.jpg', 'http://static.yaobest.com/temp/2016/11/ecbd1eff-aa82-4701-b2ba-0b735ec50cbbCrop.jpg', '2016-11-23 18:46:03');
INSERT INTO `history_commodity` VALUES ('37', '亳白芍，选片，亳州，14-16号筛，趁鲜加工，5年生，无硫', '白芍', '10', '亳州', '14-16号筛，直径1.4cm-1.6cm', '37', '公斤', 'http://static.yaobest.com/commodity/2016/11/2c6a4c81-7ec5-4301-8c3c-4ad171c6dab7Crop.jpg', 'http://static.yaobest.com/temp/2016/11/a5876e20-51f7-431f-b7e7-001a5c807232Crop.jpg', '2016-11-25 07:57:12');
INSERT INTO `history_commodity` VALUES ('38', '三棱，个，浙江，鳞皮去毛，呈圆锥形，略扁，长3cm-6cm直径3cm-4cm ', '三棱', '1', '浙江', '去毛统个、长2cm-6cm、直径2cm-4cm', '15', '公斤', 'http://static.yaobest.com/commodity/2016/11/71a7db7b-f381-4874-9f7a-95e13f0bd24bCrop.jpg', 'http://static.yaobest.com/temp/2016/11/ab078b3c-fab5-4201-9e63-b44428714cfdCrop.jpg', '2016-11-25 16:38:32');
INSERT INTO `history_commodity` VALUES ('39', '三棱，个，浙江，鳞皮去毛，呈圆锥形，略扁，长3cm-6cm直径3cm-4cm ', '三棱', '1', '浙江', '去毛统个、长2cm-6cm、直径2cm-4cm', '15', '公斤', 'http://static.yaobest.com/commodity/2016/11/71a7db7b-f381-4874-9f7a-95e13f0bd24bCrop.jpg', 'http://static.yaobest.com/temp/2016/11/ab078b3c-fab5-4201-9e63-b44428714cfdCrop.jpg', '2016-11-25 17:11:11');
INSERT INTO `history_commodity` VALUES ('40', '旱半夏，统个，甘肃，过4号筛，直径0.4cm~1.4cm', '半夏', '5', '甘肃', '统货，过4号筛，直径0.4cm~1.4cm', '105', '公斤', 'http://static.yaobest.com/commodity/2016/11/d92ad1c9-4671-4b58-93e5-4f98ecf18a8eCrop.jpg', 'http://static.yaobest.com/temp/2016/11/ecbd1eff-aa82-4701-b2ba-0b735ec50cbbCrop.jpg', '2016-11-28 15:37:56');
INSERT INTO `history_commodity` VALUES ('41', '三棱，片，浙江，过20号筛，直径2cm以上', '三棱', '4', '浙江', '过20号筛，直径2cm以上', '18', '公斤', 'http://static.yaobest.com/commodity/2016/11/6c39dd87-5d64-4552-96fe-6c0ae973a783Crop.jpg', 'http://static.yaobest.com/temp/2016/11/8482da57-fcfe-4d9c-9f2e-3a6f07c72879Crop.jpg', '2016-11-29 00:15:30');
INSERT INTO `history_commodity` VALUES ('42', '三棱，统个，浙江，长2cm-6cm直径2cm-4cm，火燎或撞去毛，有些许残留的毛须', '三棱', '2', '浙江', '统个、火燎或撞毛、长2cm-6cm、直径2cm-4cm', '11', '公斤', 'http://static.yaobest.com/commodity/2016/11/0d0aac35-156c-4add-a058-eb37dc84c531Crop.jpg', 'http://static.yaobest.com/temp/2016/11/7e12d9da-920b-4853-9d85-62aa963aaa13Crop.jpg', '2016-11-29 18:41:11');
INSERT INTO `history_commodity` VALUES ('43', '三棱，个，浙江，鳞皮去毛，呈圆锥形，略扁，长3cm-6cm直径3cm-4cm ', '三棱', '1', '浙江', '去毛统个、长2cm-6cm、直径2cm-4cm', '15', '公斤', 'http://static.yaobest.com/commodity/2016/11/71a7db7b-f381-4874-9f7a-95e13f0bd24bCrop.jpg', 'http://static.yaobest.com/temp/2016/11/ab078b3c-fab5-4201-9e63-b44428714cfdCrop.jpg', '2016-12-07 13:52:15');
INSERT INTO `history_commodity` VALUES ('44', '乙级，10号筛-12号筛之间，直径1.0cm-1.2cm', '半夏', '7', '甘肃', '乙级，10号筛-12号筛之间，直径1.0cm-1.2cm', '125', '公斤', 'http://static.yaobest.com/commodity/2016/11/fe97db42-7a9c-456d-a749-d422aa60be7dCrop.jpg', 'http://static.yaobest.com/temp/2016/11/77b328fc-9840-41fa-83f4-906a3e1f8d95Crop.jpg', '2016-12-07 14:10:24');
INSERT INTO `history_commodity` VALUES ('45', '乙级，10号筛-12号筛之间，直径1.0cm-1.2cm', '半夏', '7', '甘肃', '乙级，10号筛-12号筛之间，直径1.0cm-1.2cm', '125', '公斤', 'http://static.yaobest.com/commodity/2016/11/fe97db42-7a9c-456d-a749-d422aa60be7dCrop.jpg', 'http://static.yaobest.com/temp/2016/11/77b328fc-9840-41fa-83f4-906a3e1f8d95Crop.jpg', '2016-12-07 14:16:08');
INSERT INTO `history_commodity` VALUES ('46', '三棱，统个，浙江，长2cm-6cm直径2cm-4cm，火燎或撞去毛，有些许残留的毛须', '三棱', '2', '浙江', '统个、火燎或撞毛、长2cm-6cm、直径2cm-4cm', '11', '公斤', 'http://static.yaobest.com/commodity/2016/11/0d0aac35-156c-4add-a058-eb37dc84c531Crop.jpg', 'http://static.yaobest.com/temp/2016/11/7e12d9da-920b-4853-9d85-62aa963aaa13Crop.jpg', '2016-12-07 14:41:15');
INSERT INTO `history_commodity` VALUES ('47', '三棱，个，浙江，鳞皮去毛，呈圆锥形，略扁，长3cm-6cm直径3cm-4cm ', '三棱', '1', '浙江', '去毛统个、长2cm-6cm、直径2cm-4cm', '15', '公斤', 'http://static.yaobest.com/commodity/2016/11/71a7db7b-f381-4874-9f7a-95e13f0bd24bCrop.jpg', 'http://static.yaobest.com/temp/2016/11/ab078b3c-fab5-4201-9e63-b44428714cfdCrop.jpg', '2016-12-08 14:28:02');
INSERT INTO `history_commodity` VALUES ('48', '亳白芍选片6-16号筛  趁鲜加工  芍药苷1.6 %   5年生  无硫', '白芍', '13', '亳州', '过6-16号筛，直径0.6-1.6cm，厚度2-3mm ', '18', '公斤', 'http://static.yaobest.com/commodity/2016/12/0020589c-809d-4b63-81f3-52a35d8443e7Crop.jpg', 'http://static.yaobest.com/temp/2016/12/eced8ca2-626f-4efb-b01d-a44259f8af67Crop.jpg', '2016-12-08 14:40:38');
INSERT INTO `history_commodity` VALUES ('49', '亳白芍选片6-16号筛  趁鲜加工  芍药苷1.6 %   5年生  无硫', '白芍', '13', '亳州', '过6-16号筛，直径0.6-1.6cm，厚度2-3mm ', '18', '公斤', 'http://static.yaobest.com/commodity/2016/12/0020589c-809d-4b63-81f3-52a35d8443e7Crop.jpg', 'http://static.yaobest.com/temp/2016/12/eced8ca2-626f-4efb-b01d-a44259f8af67Crop.jpg', '2016-12-08 14:47:47');
INSERT INTO `history_commodity` VALUES ('50', '三棱，个，浙江，鳞皮去毛，呈圆锥形，略扁，长3cm-6cm直径3cm-4cm ', '三棱', '1', '浙江', '去毛统个、长2cm-6cm、直径2cm-4cm', '15', '公斤', 'http://static.yaobest.com/commodity/2016/11/71a7db7b-f381-4874-9f7a-95e13f0bd24bCrop.jpg', 'http://static.yaobest.com/temp/2016/11/ab078b3c-fab5-4201-9e63-b44428714cfdCrop.jpg', '2016-12-15 13:03:42');
INSERT INTO `history_commodity` VALUES ('51', '三棱，统个，浙江，长2cm-6cm直径2cm-4cm，火燎或撞去毛，有些许残留的毛须', '三棱', '2', '浙江', '统个、火燎或撞毛、长2cm-6cm、直径2cm-4cm', '11', '公斤', 'http://static.yaobest.com/commodity/2016/11/0d0aac35-156c-4add-a058-eb37dc84c531Crop.jpg', 'http://static.yaobest.com/temp/2016/11/7e12d9da-920b-4853-9d85-62aa963aaa13Crop.jpg', '2016-12-15 13:55:16');
INSERT INTO `history_commodity` VALUES ('52', '三棱，统个，浙江，长2cm-6cm直径2cm-4cm，火燎或撞去毛，有些许残留的毛须', '三棱', '2', '浙江', '统个、火燎或撞毛、长2cm-6cm、直径2cm-4cm', '11', '公斤', 'http://static.yaobest.com/commodity/2016/11/0d0aac35-156c-4add-a058-eb37dc84c531Crop.jpg', 'http://static.yaobest.com/temp/2016/11/7e12d9da-920b-4853-9d85-62aa963aaa13Crop.jpg', '2016-12-15 13:55:32');
INSERT INTO `history_commodity` VALUES ('53', '三棱，统个，浙江，长2cm-6cm直径2cm-4cm，火燎或撞去毛，有些许残留的毛须', '三棱', '2', '浙江', '统个、火燎或撞毛、长2cm-6cm、直径2cm-4cm', '11', '公斤', 'http://static.yaobest.com/commodity/2016/11/0d0aac35-156c-4add-a058-eb37dc84c531Crop.jpg', 'http://static.yaobest.com/temp/2016/11/7e12d9da-920b-4853-9d85-62aa963aaa13Crop.jpg', '2016-12-20 11:26:52');
INSERT INTO `history_commodity` VALUES ('54', '三棱，个，浙江，鳞皮去毛，呈圆锥形，略扁，长3cm-6cm直径3cm-4cm ', '三棱', '1', '浙江', '去毛统个、长2cm-6cm、直径2cm-4cm', '15', '公斤', 'http://static.yaobest.com/commodity/2016/11/71a7db7b-f381-4874-9f7a-95e13f0bd24bCrop.jpg', 'http://static.yaobest.com/temp/2016/11/ab078b3c-fab5-4201-9e63-b44428714cfdCrop.jpg', '2016-12-28 14:17:19');
INSERT INTO `history_commodity` VALUES ('55', '三棱，统个，浙江，长2cm-6cm直径2cm-4cm，火燎或撞去毛，有些许残留的毛须', '三棱', '2', '浙江', '统个、火燎或撞毛、长2cm-6cm、直径2cm-4cm', '11', '公斤', 'http://static.yaobest.com/commodity/2016/11/0d0aac35-156c-4add-a058-eb37dc84c531Crop.jpg', 'http://static.yaobest.com/temp/2016/11/7e12d9da-920b-4853-9d85-62aa963aaa13Crop.jpg', '2016-12-28 14:17:19');
INSERT INTO `history_commodity` VALUES ('56', '三棱，片，浙江，过20号筛，直径2cm以上', '三棱', '4', '浙江', '过20号筛，直径2cm以上', '18', '公斤', 'http://static.yaobest.com/commodity/2016/11/6c39dd87-5d64-4552-96fe-6c0ae973a783Crop.jpg', 'http://static.yaobest.com/temp/2016/11/8482da57-fcfe-4d9c-9f2e-3a6f07c72879Crop.jpg', '2016-12-28 14:17:19');

-- ----------------------------
-- Table structure for history_price
-- ----------------------------
DROP TABLE IF EXISTS `history_price`;
CREATE TABLE `history_price` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `commodity_id` int(11) DEFAULT NULL,
  `price` decimal(10,2) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `create_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `history_price_ibfk` (`commodity_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of history_price
-- ----------------------------
INSERT INTO `history_price` VALUES ('1', '2', '10.60', '2016-12-15 17:40:56', '34');

-- ----------------------------
-- Table structure for member
-- ----------------------------
DROP TABLE IF EXISTS `member`;
CREATE TABLE `member` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) NOT NULL COMMENT '用户名',
  `password` varchar(255) NOT NULL COMMENT '密码',
  `salt` varchar(255) DEFAULT NULL COMMENT '密码盐',
  `name` varchar(255) DEFAULT NULL COMMENT '用户姓名',
  `mobile` varchar(255) DEFAULT NULL COMMENT '手机号',
  `email` varchar(255) DEFAULT NULL COMMENT '邮箱',
  `tel` varchar(255) DEFAULT NULL COMMENT '座机号码',
  `openid` varchar(255) DEFAULT NULL COMMENT '微信openid',
  `is_del` bit(1) NOT NULL COMMENT '是否删除(1是,0否)',
  `create_date` datetime NOT NULL COMMENT '创建时间',
  `update_date` datetime DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8 COMMENT='管理员表';

-- ----------------------------
-- Records of member
-- ----------------------------
INSERT INTO `member` VALUES ('2', 'wangb', '6FDF061AE2B67F95AC71849A96421C5EDD7E9AC5', 'ocj6l5Osf2CmydVa8rF6oX6SgVazu5RN', '王彬', '13655559999', 'burgleaf@163.com', null, null, '\0', '2016-07-08 17:44:03', '2016-11-23 12:16:45');
INSERT INTO `member` VALUES ('34', 'admin', 'E92517093601DA98ED3BD1744ABDDB0D4F8D2892', 'IpFkPsPLZZzaIvx7HrgOJXUKmZpdqbJg', 'admin', '13699998888', '1234@qq.com', null, 'oQnHnv7-CXQOiguW9JG8k9Kptq4k', '\0', '2016-10-25 16:24:59', '2016-11-22 15:29:24');
INSERT INTO `member` VALUES ('35', 'chenb', '221FC2AFE7BE9E93E7FB6A4EFB5FBB60994E9644', 'R6UU3bnTnZIdebhnBCEwpu1SKvXZbqg3', '陈斌', '15215671552', '632348872@qq.com', null, null, '\0', '2016-11-22 14:56:51', '2016-11-22 15:03:03');
INSERT INTO `member` VALUES ('36', 'chenyz', '6EE02D7611B0A1ED4E53044C9D6FD1A9E4350AD8', 'gHwsmiAIYcrz6IAdGOgoyLuZ71Uh060T', '陈永争', '13705686011', '80357966@qq.com', null, null, '\0', '2016-11-22 15:00:43', '2016-11-22 15:02:56');
INSERT INTO `member` VALUES ('37', 'chensl', 'A42FE96223A6059A3AA097CF0017C7E33B04253E', 'TbONNkKa3ZSI8Ys7VBnXusByCtn4xEgx', '陈树理', '18756759690', '1264540027@qq.com', null, null, '\0', '2016-11-22 15:02:44', '2016-12-15 17:20:20');
INSERT INTO `member` VALUES ('38', 'wanggh', '5C1A08DFE5A023E8CBC9B1148B681F242BF670C8', 'hv9vafznsnLQepQUOdweYIdS3xzQlcGD', '王光辉', '13075078816', '958977978@qq.com', null, null, '\0', '2016-11-22 15:05:50', null);
INSERT INTO `member` VALUES ('39', 'hez', '165FD070D083E12CDCCEE47CC45C8E6C1757E255', 'Y20LsEtrqjEZycKlVApMtvNsSMwJ5THs', '何姿', '18029164122', 'hez@yaocai.pro', null, null, '\0', '2016-11-22 15:28:52', null);
INSERT INTO `member` VALUES ('40', 'zhouh', 'DF7058D4C8B6CCA7045FD69CB79C3524E89136D5', 'eHjjKjk0ksKZpEOfrRRwvdTWLKuBvhat', '周行', '15002781007', 'zhouh@yaocai.pro', null, null, '\0', '2016-11-23 12:18:10', '2016-11-23 12:19:43');
INSERT INTO `member` VALUES ('41', 'zjing', '90FA734BB3393E1CF845839E7DFCA387C26424BC', '4xh45L0AaI5Ugj7m2vGmhNl2b6TU6EQX', '张静', '18056796628', null, null, null, '\0', '2016-12-08 14:01:10', null);
INSERT INTO `member` VALUES ('42', 'yanf', 'B8EF02034322EC14AC58DCDE6614D02C777161E4', 'sf2CSC3ZG5vtMg2owzWs3yEhtWhpwar9', '严飞', '13545002090', null, null, null, '\0', '2016-12-21 16:25:48', '2016-12-21 16:31:40');

-- ----------------------------
-- Table structure for message
-- ----------------------------
DROP TABLE IF EXISTS `message`;
CREATE TABLE `message` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `url` varchar(128) DEFAULT NULL,
  `content` varchar(64) DEFAULT NULL,
  `type` int(11) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `event_id` int(11) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of message
-- ----------------------------
INSERT INTO `message` VALUES ('1', '17', null, '王彬提交选货单', '0', '1', '58', '2016-12-15 13:03:42');
INSERT INTO `message` VALUES ('2', '129', null, '周先生寄样申请', '1', '0', '53', '2016-12-15 13:55:16');
INSERT INTO `message` VALUES ('3', '129', null, '周先生提交选货单', '0', '1', '59', '2016-12-15 13:55:32');
INSERT INTO `message` VALUES ('4', '17', null, '王彬提交选货单', '0', '1', '60', '2016-12-20 11:26:52');
INSERT INTO `message` VALUES ('5', '127', null, '测试提交选货单', '0', '0', '61', '2016-12-28 14:17:19');

-- ----------------------------
-- Table structure for pick
-- ----------------------------
DROP TABLE IF EXISTS `pick`;
CREATE TABLE `pick` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `user_id` int(10) DEFAULT NULL COMMENT '用户id',
  `nickname` varchar(255) CHARACTER SET utf8 NOT NULL,
  `phone` varchar(255) CHARACTER SET utf8 NOT NULL,
  `code` varchar(32) CHARACTER SET utf8 NOT NULL,
  `abandon` int(5) NOT NULL DEFAULT '0' COMMENT '0:正常，1废弃',
  `status` int(10) NOT NULL DEFAULT '0' COMMENT '送货单状态',
  `create_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=62 DEFAULT CHARSET=latin1 COMMENT='选货单表';

-- ----------------------------
-- Records of pick
-- ----------------------------
INSERT INTO `pick` VALUES ('51', '17', '王彬', '18801285391', '201611231844000051', '1', '0', '2016-11-23 18:44:15', '2016-11-23 18:44:15');
INSERT INTO `pick` VALUES ('52', '17', '王彬', '18801285391', '201611231846000052', '1', '0', '2016-11-23 18:46:03', '2016-11-23 18:46:03');
INSERT INTO `pick` VALUES ('53', '144', '汪宗喜', '15055065555', '201611250757000053', '0', '1', '2016-11-25 07:57:12', '2016-12-21 15:27:33');
INSERT INTO `pick` VALUES ('54', '44', '<a>hello</a>', '13638654365', '201611251638000054', '1', '0', '2016-11-25 16:38:32', '2016-11-25 16:38:32');
INSERT INTO `pick` VALUES ('55', '44', '<a>hello</a>', '13638654365', '201611251711000055', '1', '0', '2016-11-25 17:11:11', '2016-11-25 17:11:11');
INSERT INTO `pick` VALUES ('56', '145', '陈永争', '13705686011', '201611281537000056', '0', '1', '2016-11-28 15:37:56', '2016-12-07 14:44:56');
INSERT INTO `pick` VALUES ('57', '17', '王彬', '18801285391', '201612071441000057', '0', '3', '2016-12-07 14:41:15', '2016-12-07 14:44:37');
INSERT INTO `pick` VALUES ('58', '17', '王彬', '18801285391', '201612151303000058', '0', '2', '2016-12-15 13:03:42', '2016-12-20 11:28:04');
INSERT INTO `pick` VALUES ('59', '129', '周先生', '15002781007', '201612151355000059', '0', '1', '2016-12-15 13:55:32', '2016-12-20 10:59:30');
INSERT INTO `pick` VALUES ('60', '17', '王彬', '18801285391', '201612201126000060', '0', '4', '2016-12-20 11:26:52', '2016-12-21 15:19:08');
INSERT INTO `pick` VALUES ('61', '127', '测试', '17736426951', '201612281417000061', '0', '0', '2016-12-28 14:17:19', '2016-12-28 14:17:19');

-- ----------------------------
-- Table structure for pick_commodity
-- ----------------------------
DROP TABLE IF EXISTS `pick_commodity`;
CREATE TABLE `pick_commodity` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pick_id` int(11) DEFAULT NULL,
  `price` decimal(10,0) DEFAULT NULL,
  `commodity_id` int(11) DEFAULT NULL,
  `num` int(10) DEFAULT NULL,
  `unit` varchar(20) CHARACTER SET utf8 DEFAULT NULL,
  `total` decimal(20,0) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=81 DEFAULT CHARSET=latin1 COMMENT='选货单商品表';

-- ----------------------------
-- Records of pick_commodity
-- ----------------------------
INSERT INTO `pick_commodity` VALUES ('68', '51', '105', '35', '50', '公斤', '5250', '2016-11-23 18:44:15');
INSERT INTO `pick_commodity` VALUES ('69', '52', '105', '36', '50', '公斤', '5250', '2016-11-23 18:46:03');
INSERT INTO `pick_commodity` VALUES ('70', '53', '37', '37', '400', '公斤', '14800', '2016-11-25 07:57:12');
INSERT INTO `pick_commodity` VALUES ('71', '54', '15', '38', '50', '公斤', '750', '2016-11-25 16:38:32');
INSERT INTO `pick_commodity` VALUES ('72', '55', '15', '39', '50', '公斤', '750', '2016-11-25 17:11:11');
INSERT INTO `pick_commodity` VALUES ('73', '56', '105', '40', '50', '公斤', '5250', '2016-11-28 15:37:56');
INSERT INTO `pick_commodity` VALUES ('74', '57', '11', '46', '50', '公斤', '525', '2016-12-07 14:41:15');
INSERT INTO `pick_commodity` VALUES ('75', '58', '15', '50', '50', '公斤', '750', '2016-12-15 13:03:42');
INSERT INTO `pick_commodity` VALUES ('76', '59', '11', '52', '50', '公斤', '525', '2016-12-15 13:55:32');
INSERT INTO `pick_commodity` VALUES ('77', '60', '11', '53', '50', '公斤', '525', '2016-12-20 11:26:52');
INSERT INTO `pick_commodity` VALUES ('78', '61', '15', '54', '52', '公斤', '780', '2016-12-28 14:17:19');
INSERT INTO `pick_commodity` VALUES ('79', '61', '11', '55', '52', '公斤', '546', '2016-12-28 14:17:19');
INSERT INTO `pick_commodity` VALUES ('80', '61', '18', '56', '51', '公斤', '918', '2016-12-28 14:17:19');

-- ----------------------------
-- Table structure for pick_tracking
-- ----------------------------
DROP TABLE IF EXISTS `pick_tracking`;
CREATE TABLE `pick_tracking` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `op_type` int(5) DEFAULT NULL COMMENT '操作者类别',
  `operator` int(11) DEFAULT NULL COMMENT '操作者id',
  `name` varchar(255) CHARACTER SET utf8 DEFAULT NULL COMMENT '操作者名称',
  `record_type` int(5) DEFAULT NULL COMMENT '记录类型，同意/拒绝/记录/完成',
  `pick_id` int(11) DEFAULT NULL,
  `extra` varchar(255) CHARACTER SET utf8 DEFAULT NULL COMMENT '同意理由，拒绝理由，记录内容等附加内容',
  `create_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=latin1 COMMENT='选货单追踪记录表';

-- ----------------------------
-- Records of pick_tracking
-- ----------------------------
INSERT INTO `pick_tracking` VALUES ('81', '1', '17', '王彬', '0', '51', '', '2016-11-23 18:44:15', '2016-11-23 18:44:15');
INSERT INTO `pick_tracking` VALUES ('82', '1', '17', '王彬', '0', '52', '', '2016-11-23 18:46:03', '2016-11-23 18:46:03');
INSERT INTO `pick_tracking` VALUES ('83', '1', '144', '汪宗喜', '0', '53', '', '2016-11-25 07:57:12', '2016-11-25 07:57:12');
INSERT INTO `pick_tracking` VALUES ('84', '1', '44', '<a>hello</a>', '0', '54', '', '2016-11-25 16:38:32', '2016-11-25 16:38:32');
INSERT INTO `pick_tracking` VALUES ('85', '1', '44', '<a>hello</a>', '0', '55', '', '2016-11-25 17:11:11', '2016-11-25 17:11:11');
INSERT INTO `pick_tracking` VALUES ('86', '1', '145', '陈永争', '0', '56', '', '2016-11-28 15:37:56', '2016-11-28 15:37:56');
INSERT INTO `pick_tracking` VALUES ('87', '1', '17', '王彬', '0', '57', '', '2016-12-07 14:41:15', '2016-12-07 14:41:15');
INSERT INTO `pick_tracking` VALUES ('88', '0', '34', 'admin', '1', '57', '', '2016-12-07 14:42:40', '2016-12-07 14:42:40');
INSERT INTO `pick_tracking` VALUES ('89', '0', '34', 'admin', '3', '57', '客户真实想买。但是需要有账期', '2016-12-07 14:43:29', '2016-12-07 14:43:29');
INSERT INTO `pick_tracking` VALUES ('90', '0', '34', 'admin', '5', '57', '', '2016-12-07 14:44:37', '2016-12-07 14:44:37');
INSERT INTO `pick_tracking` VALUES ('91', '0', '34', 'admin', '1', '56', '', '2016-12-07 14:44:56', '2016-12-07 14:44:56');
INSERT INTO `pick_tracking` VALUES ('92', '1', '17', '王彬', '0', '58', '', '2016-12-15 13:03:42', '2016-12-15 13:03:42');
INSERT INTO `pick_tracking` VALUES ('93', '1', '129', '周先生', '0', '59', '', '2016-12-15 13:55:32', '2016-12-15 13:55:32');
INSERT INTO `pick_tracking` VALUES ('94', '0', '34', 'admin', '1', '59', '', '2016-12-20 10:59:30', '2016-12-20 10:59:30');
INSERT INTO `pick_tracking` VALUES ('95', '1', '17', '王彬', '0', '60', '', '2016-12-20 11:26:52', '2016-12-20 11:26:52');
INSERT INTO `pick_tracking` VALUES ('96', '0', '34', 'admin', '1', '58', '', '2016-12-20 11:27:40', '2016-12-20 11:27:40');
INSERT INTO `pick_tracking` VALUES ('97', '0', '34', 'admin', '4', '58', '原因：1', '2016-12-20 11:28:04', '2016-12-20 11:28:04');
INSERT INTO `pick_tracking` VALUES ('98', '0', '34', 'admin', '2', '60', '不同意理由：非采购人士', '2016-12-21 15:19:08', '2016-12-21 15:19:08');
INSERT INTO `pick_tracking` VALUES ('99', '0', '34', 'admin', '1', '53', '', '2016-12-21 15:27:33', '2016-12-21 15:27:33');
INSERT INTO `pick_tracking` VALUES ('100', '1', '127', '测试', '0', '61', '', '2016-12-28 14:17:19', '2016-12-28 14:17:19');

-- ----------------------------
-- Table structure for quotation
-- ----------------------------
DROP TABLE IF EXISTS `quotation`;
CREATE TABLE `quotation` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) DEFAULT NULL,
  `status` int(5) DEFAULT NULL,
  `content` text,
  `description` text,
  `create_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of quotation
-- ----------------------------

-- ----------------------------
-- Table structure for resources
-- ----------------------------
DROP TABLE IF EXISTS `resources`;
CREATE TABLE `resources` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `type` varchar(255) DEFAULT NULL,
  `path` varchar(255) NOT NULL,
  `pid` int(11) DEFAULT NULL,
  `permission` varchar(255) DEFAULT NULL,
  `create_date` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8 COMMENT='资源表';

-- ----------------------------
-- Records of resources
-- ----------------------------
INSERT INTO `resources` VALUES ('1', '专场广告', 'button', '', '0', 'specialad:index', '2016-07-11 09:58:34');
INSERT INTO `resources` VALUES ('2', '专场列表', 'menu', 'user/index', '1', 'special:list', '2016-07-11 09:58:47');
INSERT INTO `resources` VALUES ('3', '专场编辑', 'button', '', '2', 'special:edit', '2016-07-15 11:37:26');
INSERT INTO `resources` VALUES ('4', '广告列表', 'button', '', '1', 'ad:list', '2016-07-15 11:37:29');
INSERT INTO `resources` VALUES ('5', '广告编辑', 'button', '', '4', 'ad:edit', '2016-11-01 17:39:52');
INSERT INTO `resources` VALUES ('6', 'CMS管理', 'button', '', '0', 'cms:index', '2016-11-01 17:39:52');
INSERT INTO `resources` VALUES ('7', 'CMS列表', 'button', '', '6', 'cms:list', '2016-11-01 17:39:52');
INSERT INTO `resources` VALUES ('8', 'CMS编辑', 'button', '', '7', 'cms:edit', '2016-11-01 17:39:52');
INSERT INTO `resources` VALUES ('9', '用户管理', 'button', '', '0', 'user:index', '2016-11-01 17:39:52');
INSERT INTO `resources` VALUES ('10', '用户列表', 'button', '', '9', 'user:list', '2016-11-01 17:39:52');
INSERT INTO `resources` VALUES ('11', '用户编辑', 'button', '', '10', 'user:edit', '2016-11-01 17:39:52');
INSERT INTO `resources` VALUES ('12', '寄养服务', 'button', '', '0', 'sample:index', '2016-11-01 17:39:52');
INSERT INTO `resources` VALUES ('13', '寄样列表', 'button', '', '12', 'sample:list', '2016-11-01 17:39:52');
INSERT INTO `resources` VALUES ('14', '寄样审核', 'button', '', '13', 'sample:edit', '2016-11-01 17:39:52');
INSERT INTO `resources` VALUES ('15', '选货单管理', 'button', '', '0', 'pick:index', '2016-11-01 17:39:52');
INSERT INTO `resources` VALUES ('16', '选货单列表', 'button', '', '15', 'pick:list', '2016-11-01 17:39:52');
INSERT INTO `resources` VALUES ('17', '选货单审核', 'button', '', '16', 'pick:edit', '2016-11-01 17:39:52');
INSERT INTO `resources` VALUES ('18', '商品管理', 'button', '', '0', 'commodity:index', '2016-11-01 17:39:52');
INSERT INTO `resources` VALUES ('19', '商品列表', 'button', '', '18', 'commodity:list', '2016-11-01 17:39:52');
INSERT INTO `resources` VALUES ('20', '商品编辑', 'button', '', '19', 'commodity:edit', '2016-11-01 17:39:52');
INSERT INTO `resources` VALUES ('21', '品种列表', 'button', '', '18', 'category:list', '2016-11-01 17:39:52');
INSERT INTO `resources` VALUES ('22', '品种编辑', 'button', '', '21', 'category:edit', '2016-11-01 17:39:52');
INSERT INTO `resources` VALUES ('23', '账号权限', 'button', '', '0', 'memberole:index', '2016-11-01 17:39:52');
INSERT INTO `resources` VALUES ('24', '管理员列表', 'button', '', '23', 'member:list', '2016-11-01 17:39:52');
INSERT INTO `resources` VALUES ('25', '管理员编辑', 'button', '', '24', 'member:edit', '2016-11-01 17:39:52');
INSERT INTO `resources` VALUES ('26', '角色列表', 'button', '', '23', 'role:list', '2016-11-01 17:39:52');
INSERT INTO `resources` VALUES ('27', '角色详情', 'button', '', '26', 'role:edit', '2016-11-01 17:39:52');
INSERT INTO `resources` VALUES ('28', '供应商列表', 'button', '', '32', 'supplier:list', '2016-12-09 17:29:07');
INSERT INTO `resources` VALUES ('29', '供应商详情', 'button', '', '32', 'supplier:edit', '2016-12-09 17:29:55');
INSERT INTO `resources` VALUES ('30', '报价单列表', 'button', '', '33', 'quotation:list', '2016-12-09 17:30:45');
INSERT INTO `resources` VALUES ('31', '报价单详情', 'button', '', '33', 'quotation:edit', '2016-12-09 17:31:05');
INSERT INTO `resources` VALUES ('32', '供应商主页', 'button', '', '0', 'supplier:index', '2016-12-09 17:33:06');
INSERT INTO `resources` VALUES ('33', '报价单主页', 'button', '', '0', 'quotation:index', '2016-12-09 17:33:45');

-- ----------------------------
-- Table structure for role
-- ----------------------------
DROP TABLE IF EXISTS `role`;
CREATE TABLE `role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `create_date` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COMMENT='角色表';

-- ----------------------------
-- Records of role
-- ----------------------------
INSERT INTO `role` VALUES ('7', '超级管理员', null, '2016-07-12 14:57:59');
INSERT INTO `role` VALUES ('8', '业务员', null, '2016-08-02 10:36:45');
INSERT INTO `role` VALUES ('10', '网站编辑', null, '2016-08-02 17:52:57');

-- ----------------------------
-- Table structure for role_member
-- ----------------------------
DROP TABLE IF EXISTS `role_member`;
CREATE TABLE `role_member` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `role_id` int(11) NOT NULL,
  `member_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `role_id` (`role_id`,`member_id`),
  KEY `member_id` (`member_id`),
  CONSTRAINT `role_member_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `role` (`id`),
  CONSTRAINT `role_member_ibfk_2` FOREIGN KEY (`member_id`) REFERENCES `member` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=93 DEFAULT CHARSET=utf8 COMMENT='角色管理员关联表';

-- ----------------------------
-- Records of role_member
-- ----------------------------
INSERT INTO `role_member` VALUES ('86', '7', '34');
INSERT INTO `role_member` VALUES ('91', '7', '37');
INSERT INTO `role_member` VALUES ('84', '7', '39');
INSERT INTO `role_member` VALUES ('89', '7', '40');
INSERT INTO `role_member` VALUES ('90', '7', '41');
INSERT INTO `role_member` VALUES ('92', '7', '42');
INSERT INTO `role_member` VALUES ('87', '8', '2');
INSERT INTO `role_member` VALUES ('83', '8', '38');
INSERT INTO `role_member` VALUES ('82', '10', '35');
INSERT INTO `role_member` VALUES ('81', '10', '36');

-- ----------------------------
-- Table structure for role_resources
-- ----------------------------
DROP TABLE IF EXISTS `role_resources`;
CREATE TABLE `role_resources` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `role_id` int(11) DEFAULT NULL,
  `resources_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `role_id` (`role_id`),
  KEY `resources_id` (`resources_id`),
  CONSTRAINT `role_resources_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `role` (`id`),
  CONSTRAINT `role_resources_ibfk_2` FOREIGN KEY (`resources_id`) REFERENCES `resources` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1657 DEFAULT CHARSET=utf8 COMMENT='角色资源关联表';

-- ----------------------------
-- Records of role_resources
-- ----------------------------
INSERT INTO `role_resources` VALUES ('1599', '10', '1');
INSERT INTO `role_resources` VALUES ('1600', '10', '2');
INSERT INTO `role_resources` VALUES ('1601', '10', '3');
INSERT INTO `role_resources` VALUES ('1602', '10', '4');
INSERT INTO `role_resources` VALUES ('1603', '10', '5');
INSERT INTO `role_resources` VALUES ('1604', '10', '6');
INSERT INTO `role_resources` VALUES ('1605', '10', '7');
INSERT INTO `role_resources` VALUES ('1606', '10', '8');
INSERT INTO `role_resources` VALUES ('1607', '10', '18');
INSERT INTO `role_resources` VALUES ('1608', '10', '19');
INSERT INTO `role_resources` VALUES ('1609', '10', '20');
INSERT INTO `role_resources` VALUES ('1610', '10', '21');
INSERT INTO `role_resources` VALUES ('1611', '10', '22');
INSERT INTO `role_resources` VALUES ('1612', '8', '6');
INSERT INTO `role_resources` VALUES ('1613', '8', '7');
INSERT INTO `role_resources` VALUES ('1614', '8', '8');
INSERT INTO `role_resources` VALUES ('1615', '8', '9');
INSERT INTO `role_resources` VALUES ('1616', '8', '10');
INSERT INTO `role_resources` VALUES ('1617', '8', '11');
INSERT INTO `role_resources` VALUES ('1618', '8', '12');
INSERT INTO `role_resources` VALUES ('1619', '8', '13');
INSERT INTO `role_resources` VALUES ('1620', '8', '14');
INSERT INTO `role_resources` VALUES ('1621', '8', '15');
INSERT INTO `role_resources` VALUES ('1622', '8', '16');
INSERT INTO `role_resources` VALUES ('1623', '8', '17');
INSERT INTO `role_resources` VALUES ('1624', '7', '1');
INSERT INTO `role_resources` VALUES ('1625', '7', '2');
INSERT INTO `role_resources` VALUES ('1626', '7', '3');
INSERT INTO `role_resources` VALUES ('1627', '7', '4');
INSERT INTO `role_resources` VALUES ('1628', '7', '5');
INSERT INTO `role_resources` VALUES ('1629', '7', '6');
INSERT INTO `role_resources` VALUES ('1630', '7', '7');
INSERT INTO `role_resources` VALUES ('1631', '7', '8');
INSERT INTO `role_resources` VALUES ('1632', '7', '9');
INSERT INTO `role_resources` VALUES ('1633', '7', '10');
INSERT INTO `role_resources` VALUES ('1634', '7', '11');
INSERT INTO `role_resources` VALUES ('1635', '7', '12');
INSERT INTO `role_resources` VALUES ('1636', '7', '13');
INSERT INTO `role_resources` VALUES ('1637', '7', '14');
INSERT INTO `role_resources` VALUES ('1638', '7', '15');
INSERT INTO `role_resources` VALUES ('1639', '7', '16');
INSERT INTO `role_resources` VALUES ('1640', '7', '17');
INSERT INTO `role_resources` VALUES ('1641', '7', '18');
INSERT INTO `role_resources` VALUES ('1642', '7', '19');
INSERT INTO `role_resources` VALUES ('1643', '7', '20');
INSERT INTO `role_resources` VALUES ('1644', '7', '21');
INSERT INTO `role_resources` VALUES ('1645', '7', '22');
INSERT INTO `role_resources` VALUES ('1646', '7', '23');
INSERT INTO `role_resources` VALUES ('1647', '7', '24');
INSERT INTO `role_resources` VALUES ('1648', '7', '25');
INSERT INTO `role_resources` VALUES ('1649', '7', '26');
INSERT INTO `role_resources` VALUES ('1650', '7', '27');
INSERT INTO `role_resources` VALUES ('1651', '7', '32');
INSERT INTO `role_resources` VALUES ('1652', '7', '28');
INSERT INTO `role_resources` VALUES ('1653', '7', '29');
INSERT INTO `role_resources` VALUES ('1654', '7', '33');
INSERT INTO `role_resources` VALUES ('1655', '7', '30');
INSERT INTO `role_resources` VALUES ('1656', '7', '31');

-- ----------------------------
-- Table structure for sample_address
-- ----------------------------
DROP TABLE IF EXISTS `sample_address`;
CREATE TABLE `sample_address` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `address` varchar(255) NOT NULL COMMENT '收货地址',
  `receiver` varchar(20) NOT NULL COMMENT '收货人',
  `receiver_phone` varchar(11) NOT NULL COMMENT '收货人电话',
  `remark` varchar(512) NOT NULL COMMENT '备注信息',
  `send_id` int(11) NOT NULL COMMENT '寄样单id',
  `create_time` datetime NOT NULL,
  `update_time` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COMMENT='寄样地址表';

-- ----------------------------
-- Records of sample_address
-- ----------------------------
INSERT INTO `sample_address` VALUES ('8', '', '', '', '', '46', '2016-11-23 09:45:45', '2016-11-23 09:45:45');
INSERT INTO `sample_address` VALUES ('9', '武汉光谷', '王彬', '18801285391', '1', '50', '2016-12-07 14:16:08', '2016-12-07 14:16:08');
INSERT INTO `sample_address` VALUES ('10', '安徽省亳州市谯城区光明西路沪谯饮片厂', '陈树理', '18756759690', '白芍 寄样 100克，用途：留样，质检', '52', '2016-12-08 14:47:47', '2016-12-08 14:47:47');

-- ----------------------------
-- Table structure for sample_tracking
-- ----------------------------
DROP TABLE IF EXISTS `sample_tracking`;
CREATE TABLE `sample_tracking` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `operator` int(11) NOT NULL COMMENT '操作人id',
  `name` varchar(255) NOT NULL COMMENT '操作人名称',
  `type` int(3) NOT NULL DEFAULT '0' COMMENT '0：后台人员,1:前台用户',
  `send_id` int(11) NOT NULL COMMENT '寄样单id',
  `record_type` int(11) NOT NULL DEFAULT '0' COMMENT '追踪类型 0：申请寄样，1：同意寄样，2：拒绝寄样，3:客户预约，4：寄送样品，5：客户已收货，6：跟踪记录，7：客户留言，8：寄样单受理完成',
  `extra` varchar(255) NOT NULL COMMENT '寄样追踪附加内容：如同意理由，等等',
  `create_time` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=113 DEFAULT CHARSET=utf8 COMMENT='寄样跟踪表';

-- ----------------------------
-- Records of sample_tracking
-- ----------------------------
INSERT INTO `sample_tracking` VALUES ('84', '134', '陈树理', '1', '46', '0', '', '2016-11-23 09:40:36');
INSERT INTO `sample_tracking` VALUES ('85', '37', '陈树理', '0', '46', '1', '同意理由：同意寄样', '2016-11-23 09:46:27');
INSERT INTO `sample_tracking` VALUES ('86', '37', '陈树理', '0', '46', '3', '快递公司：安能物流 快递单号：1234567890', '2016-11-23 09:46:50');
INSERT INTO `sample_tracking` VALUES ('87', '146', '郑凯迪', '1', '47', '0', '', '2016-11-29 00:15:30');
INSERT INTO `sample_tracking` VALUES ('88', '17', '王彬', '1', '48', '0', '', '2016-11-29 18:41:11');
INSERT INTO `sample_tracking` VALUES ('89', '17', '王彬', '1', '49', '0', '', '2016-12-07 13:52:15');
INSERT INTO `sample_tracking` VALUES ('90', '17', '王彬', '1', '50', '0', '', '2016-12-07 14:10:24');
INSERT INTO `sample_tracking` VALUES ('91', '34', 'admin', '0', '50', '1', '同意理由：客户真实想买', '2016-12-07 14:14:51');
INSERT INTO `sample_tracking` VALUES ('92', '34', 'admin', '0', '50', '3', '快递公司：圆通快递 快递单号：12221321321331', '2016-12-07 14:16:40');
INSERT INTO `sample_tracking` VALUES ('93', '34', 'admin', '0', '50', '6', '客户对样品比较满意，想产生购买。', '2016-12-07 14:17:51');
INSERT INTO `sample_tracking` VALUES ('94', '34', 'admin', '0', '50', '6', '客户购买了货物需要账期。', '2016-12-07 14:19:15');
INSERT INTO `sample_tracking` VALUES ('95', '34', 'admin', '0', '50', '6', '客户已经购买。', '2016-12-07 14:20:03');
INSERT INTO `sample_tracking` VALUES ('96', '34', 'admin', '0', '50', '8', '', '2016-12-07 14:20:06');
INSERT INTO `sample_tracking` VALUES ('97', '34', 'admin', '0', '49', '1', '同意理由：同意', '2016-12-07 14:23:26');
INSERT INTO `sample_tracking` VALUES ('98', '34', 'admin', '0', '49', '5', '预约时间：2016年12月23日 00:00 来访人：王彬 电话：18801285391', '2016-12-07 14:25:12');
INSERT INTO `sample_tracking` VALUES ('99', '34', 'admin', '0', '49', '6', '对我们货物比较满意', '2016-12-07 14:25:59');
INSERT INTO `sample_tracking` VALUES ('100', '34', 'admin', '0', '49', '6', '客户又说不满意了。', '2016-12-07 14:27:49');
INSERT INTO `sample_tracking` VALUES ('101', '34', 'admin', '0', '49', '8', '', '2016-12-07 14:27:54');
INSERT INTO `sample_tracking` VALUES ('102', '34', 'admin', '0', '48', '1', '同意理由：111', '2016-12-07 14:28:49');
INSERT INTO `sample_tracking` VALUES ('103', '34', 'admin', '0', '48', '3', '快递公司：1 快递单号：1', '2016-12-07 14:28:56');
INSERT INTO `sample_tracking` VALUES ('104', '34', 'admin', '0', '48', '6', '寄样品很满意。', '2016-12-07 14:39:49');
INSERT INTO `sample_tracking` VALUES ('105', '34', 'admin', '0', '48', '8', '', '2016-12-07 14:39:53');
INSERT INTO `sample_tracking` VALUES ('106', '17', '王彬', '1', '51', '0', '', '2016-12-08 14:28:02');
INSERT INTO `sample_tracking` VALUES ('107', '41', '张静', '0', '51', '2', '不同意理由：不同意', '2016-12-08 14:38:33');
INSERT INTO `sample_tracking` VALUES ('108', '134', '陈树理', '1', '52', '0', '', '2016-12-08 14:40:38');
INSERT INTO `sample_tracking` VALUES ('109', '41', '张静', '0', '52', '1', '同意理由：业务需要', '2016-12-08 14:49:03');
INSERT INTO `sample_tracking` VALUES ('110', '41', '张静', '0', '52', '3', '快递公司：圆通 快递单号：1234455690', '2016-12-08 16:46:26');
INSERT INTO `sample_tracking` VALUES ('111', '41', '张静', '0', '52', '8', '', '2016-12-08 16:47:00');
INSERT INTO `sample_tracking` VALUES ('112', '129', '周先生', '1', '53', '0', '', '2016-12-15 13:55:16');

-- ----------------------------
-- Table structure for send_sample
-- ----------------------------
DROP TABLE IF EXISTS `send_sample`;
CREATE TABLE `send_sample` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL DEFAULT '0' COMMENT 'user表主键',
  `code` varchar(20) NOT NULL COMMENT '寄样单号',
  `phone` varchar(255) NOT NULL,
  `nickname` varchar(255) NOT NULL,
  `area` varchar(255) NOT NULL,
  `intention` varchar(255) NOT NULL COMMENT '寄样商品',
  `abandon` int(5) NOT NULL DEFAULT '0' COMMENT '0:正常，1废弃',
  `status` int(11) NOT NULL DEFAULT '0' COMMENT '处理状态',
  `update_time` datetime NOT NULL,
  `create_time` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=54 DEFAULT CHARSET=utf8 COMMENT='寄样单表';

-- ----------------------------
-- Records of send_sample
-- ----------------------------
INSERT INTO `send_sample` VALUES ('46', '134', '201611230940000046', '18756759690', '陈树理', '安徽省亳州市', '34', '0', '4', '2016-11-23 09:40:36', '2016-11-23 09:40:36');
INSERT INTO `send_sample` VALUES ('47', '146', '201611290015000047', '18956757255', '郑凯迪', '亳州', '41', '0', '0', '2016-11-29 00:15:30', '2016-11-29 00:15:30');
INSERT INTO `send_sample` VALUES ('48', '17', '201611291841000048', '18801285391', '王彬', '武汉', '42', '0', '5', '2016-11-29 18:41:11', '2016-11-29 18:41:11');
INSERT INTO `send_sample` VALUES ('49', '17', '201612071352000049', '18801285391', '王彬', '湖北武汉', '43', '0', '5', '2016-12-07 13:52:15', '2016-12-07 13:52:15');
INSERT INTO `send_sample` VALUES ('50', '17', '201612071410000050', '18801285391', '王彬', '湖北武汉', '45', '1', '5', '2016-12-07 14:10:24', '2016-12-07 14:10:24');
INSERT INTO `send_sample` VALUES ('51', '17', '201612081428000051', '18801285391', '王彬', '湖北武汉', '47', '0', '2', '2016-12-08 14:28:02', '2016-12-08 14:28:02');
INSERT INTO `send_sample` VALUES ('52', '134', '201612081440000052', '18756759690', '陈树理', '安徽省亳州市谯城区光明西路', '49', '0', '5', '2016-12-08 14:40:38', '2016-12-08 14:40:38');
INSERT INTO `send_sample` VALUES ('53', '129', '201612151355000053', '15002781007', '周先生', '湖北武汉', '51', '0', '0', '2016-12-15 13:55:16', '2016-12-15 13:55:16');

-- ----------------------------
-- Table structure for special
-- ----------------------------
DROP TABLE IF EXISTS `special`;
CREATE TABLE `special` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(64) DEFAULT NULL COMMENT '标题',
  `pictuer_url` varchar(256) DEFAULT NULL,
  `description` varchar(256) DEFAULT NULL,
  `status` int(11) DEFAULT NULL COMMENT '0 禁用 1 启用',
  `update_time` datetime DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `sort` int(11) DEFAULT NULL,
  `update_mem` int(11) DEFAULT NULL COMMENT '修改人id',
  `create_mem` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='专场表';

-- ----------------------------
-- Records of special
-- ----------------------------
INSERT INTO `special` VALUES ('1', '半夏专场', '/opt/resources/yaobest/special/2016/11/7bac39cb-6f57-4e93-b90f-88740db28915Crop.jpg', '', '1', '2016-11-22 10:28:04', '2016-10-28 18:26:11', '23', '34', '34');
INSERT INTO `special` VALUES ('2', '三棱专场', '/opt/resources/yaobest/special/2016/11/87c43308-7e78-4086-a04a-980ae998e0d0Crop.jpg', '', '1', '2016-11-22 10:27:09', '2016-11-07 11:06:43', '0', '34', '34');
INSERT INTO `special` VALUES ('3', '白芍专场', '/opt/resources/yaobest/special/2016/11/80be39d4-383d-4ba3-a7ae-369e5e003ca9Crop.jpg', '', '1', '2016-12-05 09:38:25', '2016-11-22 22:18:58', '20', '34', '34');

-- ----------------------------
-- Table structure for special_commodity
-- ----------------------------
DROP TABLE IF EXISTS `special_commodity`;
CREATE TABLE `special_commodity` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `special_id` int(11) DEFAULT NULL COMMENT '专场id',
  `commodity_id` int(11) DEFAULT NULL COMMENT '商品id',
  PRIMARY KEY (`id`),
  KEY `special_id` (`special_id`),
  KEY `commodity_id` (`commodity_id`),
  CONSTRAINT `special_commodity_ibfk_2` FOREIGN KEY (`commodity_id`) REFERENCES `commodity` (`id`),
  CONSTRAINT `special_commodity_ibfk_1` FOREIGN KEY (`special_id`) REFERENCES `special` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8 COMMENT='专场商品表';

-- ----------------------------
-- Records of special_commodity
-- ----------------------------
INSERT INTO `special_commodity` VALUES ('16', '2', '1');
INSERT INTO `special_commodity` VALUES ('17', '2', '2');
INSERT INTO `special_commodity` VALUES ('18', '2', '3');
INSERT INTO `special_commodity` VALUES ('19', '2', '4');
INSERT INTO `special_commodity` VALUES ('20', '1', '5');
INSERT INTO `special_commodity` VALUES ('21', '1', '6');
INSERT INTO `special_commodity` VALUES ('22', '1', '7');
INSERT INTO `special_commodity` VALUES ('23', '1', '8');
INSERT INTO `special_commodity` VALUES ('29', '3', '10');
INSERT INTO `special_commodity` VALUES ('30', '3', '13');
INSERT INTO `special_commodity` VALUES ('31', '3', '14');

-- ----------------------------
-- Table structure for supplier
-- ----------------------------
DROP TABLE IF EXISTS `supplier`;
CREATE TABLE `supplier` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `phone` varchar(11) DEFAULT NULL,
  `phone2` varchar(20) DEFAULT NULL,
  `email` varchar(128) DEFAULT NULL,
  `telephone` varchar(20) DEFAULT NULL,
  `area` varchar(255) DEFAULT NULL,
  `enter_category` varchar(255) DEFAULT NULL,
  `qq` varchar(255) DEFAULT NULL,
  `mark` varchar(255) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of supplier
-- ----------------------------

-- ----------------------------
-- Table structure for tracking_detail
-- ----------------------------
DROP TABLE IF EXISTS `tracking_detail`;
CREATE TABLE `tracking_detail` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `send_id` int(11) NOT NULL,
  `type` int(11) NOT NULL DEFAULT '1' COMMENT '1：物流信息 ，2：客户来访信息',
  `company` varchar(128) DEFAULT NULL COMMENT '快递公司',
  `tracking_no` varchar(50) DEFAULT NULL COMMENT '快递单号',
  `vistor` varchar(50) DEFAULT NULL COMMENT '来访人',
  `vistor_phone` varchar(11) DEFAULT NULL COMMENT '来访电话',
  `vistor_time` datetime DEFAULT NULL COMMENT '来访时间',
  `create_time` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COMMENT='追踪详情表';

-- ----------------------------
-- Records of tracking_detail
-- ----------------------------
INSERT INTO `tracking_detail` VALUES ('6', '46', '0', '安能物流', '1234567890', null, null, null, '2016-11-23 09:46:50');
INSERT INTO `tracking_detail` VALUES ('7', '50', '0', '圆通快递', '12221321321331', null, null, null, '2016-12-07 14:16:40');
INSERT INTO `tracking_detail` VALUES ('8', '49', '1', null, null, '王彬', '18801285391', '2016-12-23 00:00:00', '2016-12-07 14:25:12');
INSERT INTO `tracking_detail` VALUES ('9', '48', '0', '1', '1', null, null, null, '2016-12-07 14:28:56');
INSERT INTO `tracking_detail` VALUES ('10', '52', '0', '圆通', '1234455690', null, null, null, '2016-12-08 16:46:26');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` int(11) NOT NULL DEFAULT '1' COMMENT '1：注册用户，0：申请寄样生成的用户',
  `phone` varchar(11) NOT NULL COMMENT '手机号',
  `password` varchar(50) DEFAULT NULL COMMENT '用户密码',
  `salt` varchar(40) DEFAULT NULL,
  `openid` varchar(32) DEFAULT NULL COMMENT '用户公众号对应的openid',
  `update_time` datetime DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `phone` (`phone`) USING BTREE,
  UNIQUE KEY `openid` (`openid`)
) ENGINE=InnoDB AUTO_INCREMENT=169 DEFAULT CHARSET=utf8 COMMENT='用户表';

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('3', '-1', '17740679874', '61A1AE967C34D9D1007B6A5F84926026A1C39AAA', 'ejoodRPcGHBo7MF6R7RBv36yf2zjIuOm', null, '2016-11-04 11:15:56', '2016-10-31 13:23:30');
INSERT INTO `user` VALUES ('17', '0', '18801285391', '0238BF51B8065558B0C66DF5AFE7402D338DB73E', 'q6Bq0nxa1zdM25Y2mrsaD2RMnApuTeA9', 'oQnHnv7-CXQOiguW9JG8k9Kptq4k', '2016-11-14 17:52:16', '2016-11-10 19:03:21');
INSERT INTO `user` VALUES ('44', '0', '13638654365', '58A9055045DFFDBFB71F2DF2A8C9B40BCC94D197', '0Ai7YH1VBzvA9zza2mBk9NjfK5njM9Wq', null, '2016-12-28 15:06:00', '2016-11-03 17:53:24');
INSERT INTO `user` VALUES ('119', '1', '13638663566', '', '', null, '2016-11-09 11:02:52', '2016-11-09 11:02:52');
INSERT INTO `user` VALUES ('120', '1', '18801285392', '', '', null, '2016-11-10 18:33:11', '2016-11-10 18:33:11');
INSERT INTO `user` VALUES ('127', '0', '18664865125', '113ABB6F22C9F661099A6824669FABFB4DB079A8', 'qZakYg8BbFIOtdHlmqOOH3DgWmdcawCb', 'oQnHnv3rbXgdGAQayfaJVStFbEws', '2016-11-10 19:09:37', '2016-11-10 19:09:37');
INSERT INTO `user` VALUES ('128', '0', '13349875212', null, null, 'oQnHnvy3Pq9x680k5y7ex53yCC9U', '2016-11-10 21:04:37', '2016-11-10 21:04:37');
INSERT INTO `user` VALUES ('129', '0', '15002781007', 'D152969D9AD52D690DBA8699E3E0BB5F7D3B8BD7', 'fXwBXTqUrENZ4S06nTCOWZo6G9uTj0ff', 'oQnHnv5XqL-5hp9z_Ba-KjjWHA5o', '2016-12-15 13:56:31', '2016-11-11 15:47:09');
INSERT INTO `user` VALUES ('131', '0', '15015367140', null, null, 'oQnHnvyt8RPGn5Zejkx-ER9TRsQc', '2016-11-14 17:39:50', '2016-11-14 17:39:50');
INSERT INTO `user` VALUES ('132', '0', '13545002090', null, null, 'oQnHnv1EftcEPxyOrbj32KjIhyVI', '2016-11-14 18:00:52', '2016-11-14 18:00:52');
INSERT INTO `user` VALUES ('133', '0', '15926332570', null, null, 'oQnHnv2Xfp4S6eAv79HdSdQ5FjtM', '2016-11-14 18:44:05', '2016-11-14 18:44:05');
INSERT INTO `user` VALUES ('134', '0', '18756759690', null, null, 'oQnHnv_ngGpeOmrOm3Fk4RhgRYZc', '2016-11-21 16:02:33', '2016-11-21 16:02:33');
INSERT INTO `user` VALUES ('135', '0', '13760623606', null, null, 'oQnHnv1SNWrw2XAlAsab55cj1Lj4', '2016-11-22 23:18:15', '2016-11-22 23:18:15');
INSERT INTO `user` VALUES ('139', '0', '13888008610', null, null, 'oQnHnv8KLJV9eix29YJRXjBPB0yA', '2016-11-23 08:36:35', '2016-11-23 08:36:35');
INSERT INTO `user` VALUES ('140', '0', '13888119155', null, null, 'oQnHnvxoD4w6XgIhGCnbwT7k_kjA', '2016-11-23 09:47:36', '2016-11-23 09:47:36');
INSERT INTO `user` VALUES ('141', '0', '15925628899', null, null, 'oQnHnvxlSxuFKkgGEGdrvuuTkylk', '2016-11-23 12:17:35', '2016-11-23 12:17:35');
INSERT INTO `user` VALUES ('142', '0', '18048808242', null, null, 'oQnHnv7sbkd2w-drtBccllAKDuNg', '2016-11-23 15:27:22', '2016-11-23 15:27:22');
INSERT INTO `user` VALUES ('143', '0', '13355687515', null, null, 'oQnHnv_fTyrvdu36RCAeoyBOczlI', '2016-11-23 16:31:15', '2016-11-23 16:31:15');
INSERT INTO `user` VALUES ('144', '1', '15055065555', '', '', 'oQnHnv4b5lEmgchbGrA8t2T4ewT0', '2016-11-25 07:57:12', '2016-11-25 07:57:12');
INSERT INTO `user` VALUES ('145', '1', '13705686011', '', '', null, '2016-11-28 15:37:56', '2016-11-28 15:37:56');
INSERT INTO `user` VALUES ('146', '0', '18956757255', null, null, 'oQnHnvxh13uF0QIDZAMYlNzIfewg', '2016-11-28 16:20:09', '2016-11-28 16:20:09');
INSERT INTO `user` VALUES ('147', '0', '18956780080', null, null, 'oQnHnv_ejGAUARJwd7FHW-DJKOCU', '2016-11-28 17:15:05', '2016-11-28 17:15:05');
INSERT INTO `user` VALUES ('148', '0', '18656705001', null, null, 'oQnHnvz-VS5UM5tG1NEwClWtflL4', '2016-11-28 20:37:49', '2016-11-28 20:37:49');
INSERT INTO `user` VALUES ('149', '0', '18055866925', null, null, 'oQnHnvxYawHrqea2cQd1CHZctGBk', '2016-11-28 21:52:47', '2016-11-28 21:52:47');
INSERT INTO `user` VALUES ('150', '0', '13195670999', 'BCE68B701AF72B5662A7802EC859806511339967', 'V7t6qzMZC2NkPbLBHoE7x7US9FaAa8FD', null, '2016-12-08 10:54:35', '2016-12-08 10:54:35');
INSERT INTO `user` VALUES ('151', '0', '13845975701', null, null, 'oQnHnv0OlmOT2HsgfCAYRLSyPc-A', '2016-12-11 11:26:37', '2016-12-11 11:26:37');
INSERT INTO `user` VALUES ('152', '0', '13041162468', null, null, 'oQnHnv2RWVdjQn9QkbtLUquyoKPk', '2016-12-13 17:06:37', '2016-12-13 17:06:37');
INSERT INTO `user` VALUES ('153', '0', '13636286273', null, null, 'oQnHnvyfbGrMDWYfnJfg47vSVqBk', '2016-12-15 08:15:15', '2016-12-15 08:15:15');
INSERT INTO `user` VALUES ('154', '0', '15055070828', null, null, 'oQnHnv4T0EHyVNITcMJhbZ-29vyI', '2016-12-15 17:54:15', '2016-12-15 17:54:15');
INSERT INTO `user` VALUES ('155', '0', '15339695789', null, null, 'oQnHnv6tZS9pKEdJIc5kv5CQgzbE', '2016-12-15 17:59:41', '2016-12-15 17:59:41');
INSERT INTO `user` VALUES ('156', '0', '13156735787', null, null, 'oQnHnv4_v2sa6bdPWoqW-qjMyRTo', '2016-12-20 22:42:18', '2016-12-20 22:42:18');
INSERT INTO `user` VALUES ('157', '0', '13881913820', null, null, 'oQnHnvxmdyWCmXQ2xl4LNmAfyQrI', '2016-12-21 13:57:35', '2016-12-21 13:57:35');
INSERT INTO `user` VALUES ('158', '0', '15035086412', '0BA20DA00FA7C64D7FBFEE25D971872DEBF0C7F5', '224XQ4j9FFIRYU6oyJst41UM36Sr3kkQ', 'oQnHnv0LOgdU34nlSsDjZ1hocBwE', '2016-12-21 21:04:15', '2016-12-21 21:01:15');
INSERT INTO `user` VALUES ('159', '0', '15903810702', null, null, 'oQnHnv1QIKWLeQzYiN0j8IhYLWzg', '2016-12-22 18:07:25', '2016-12-22 18:07:25');
INSERT INTO `user` VALUES ('160', '0', '18763516003', null, null, 'oQnHnv24nQcTB8XGbSAimtaZRoys', '2016-12-22 19:21:20', '2016-12-22 19:21:20');
INSERT INTO `user` VALUES ('161', '0', '18909673808', null, null, 'oQnHnv8Euynx_DaYcFCT83hzf5b8', '2016-12-23 20:07:37', '2016-12-23 20:07:37');
INSERT INTO `user` VALUES ('162', '0', '15855882626', null, null, 'oQnHnv2HlCsn0fC9Q5mG2QPlooew', '2016-12-24 00:37:25', '2016-12-24 00:37:25');
INSERT INTO `user` VALUES ('163', '0', '13893237314', null, null, 'oQnHnv5MmmyzEA34dry33zT7VqbQ', '2016-12-26 18:20:06', '2016-12-26 18:20:06');
INSERT INTO `user` VALUES ('164', '0', '18609719646', null, null, 'oQnHnv1zV2CHJMrNGp35NX1PBfGY', '2016-12-26 22:35:36', '2016-12-26 22:35:36');
INSERT INTO `user` VALUES ('165', '0', '13872574558', null, null, 'oQnHnvxMY6qOptfIdN_1cJAIqYhM', '2016-12-26 22:52:07', '2016-12-26 22:52:07');
INSERT INTO `user` VALUES ('166', '0', '13803634787', null, null, 'oQnHnv_O5TaxC48qDiYjpUG52MFc', '2016-12-26 22:54:28', '2016-12-26 22:54:28');
INSERT INTO `user` VALUES ('167', '1', '17736426951', '', '', null, '2016-12-28 14:17:19', '2016-12-28 14:17:19');
INSERT INTO `user` VALUES ('168', '0', '13384786788', null, null, 'oQnHnvwh5u1cQ-dNvWbXJ59zJ420', '2016-12-29 12:00:45', '2016-12-29 12:00:45');

-- ----------------------------
-- Table structure for user_detail
-- ----------------------------
DROP TABLE IF EXISTS `user_detail`;
CREATE TABLE `user_detail` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` int(5) NOT NULL DEFAULT '0' COMMENT '补全信息类型 ',
  `nickname` varchar(255) NOT NULL COMMENT '联系人姓名',
  `phone` varchar(255) NOT NULL COMMENT '联系电话',
  `head_img_url` text,
  `area` varchar(255) DEFAULT NULL COMMENT '地区',
  `name` varchar(255) DEFAULT NULL COMMENT '姓名/公司',
  `remark` varchar(255) DEFAULT NULL COMMENT '用户备注',
  `user_id` int(11) NOT NULL COMMENT 'user表id',
  `create_time` datetime NOT NULL,
  `update_time` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `phone` (`phone`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `user_detail_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=66 DEFAULT CHARSET=utf8 COMMENT='用户详情表';

-- ----------------------------
-- Records of user_detail
-- ----------------------------
INSERT INTO `user_detail` VALUES ('12', '2', '<a>hello</a>', '13638654365', null, '武汉洪山', '', '', '44', '2016-11-03 12:58:25', '2016-11-25 17:11:11');
INSERT INTO `user_detail` VALUES ('25', '0', 'dfdf', '13638663566', null, '湖北武汉', '', '', '119', '2016-11-09 11:02:52', '2016-11-09 11:04:15');
INSERT INTO `user_detail` VALUES ('26', '0', '王彬2', '18801285392', null, '1', '', '', '120', '2016-11-10 18:33:11', '2016-11-14 19:15:41');
INSERT INTO `user_detail` VALUES ('27', '1', '王彬', '18801285391', 'http://wx.qlogo.cn/mmopen/9XibKWLOyJBSiaWiaXibOnuXTFFGh0rClicaS0OPlFtgMFFfPn81Mcs0pElIn6IGFmypwQFMlF3D5bvfMRTayPe923xDMGJoLHVDD/0', '湖北武汉', '天济饮片厂', null, '17', '2016-11-10 19:03:21', '2016-12-20 11:26:52');
INSERT INTO `user_detail` VALUES ('28', '0', '芃芃', '18664865125', 'http://wx.qlogo.cn/mmopen/ajNVdqHZLLBgfSDKkRqtC5wTACBEk5OVFdJl1YksvOdzGsMFft6MYezvfZfJzZDykAEjE2LZdfI6ofL4wUbOSA/0', null, null, null, '127', '2016-11-10 19:09:37', '2016-11-10 19:09:37');
INSERT INTO `user_detail` VALUES ('29', '0', 'Messi', '13349875212', 'http://wx.qlogo.cn/mmopen/FAqV5coM53g1XiccUAKnxUV0wu9UL02gNTVFMohLkicQCNNPiaQvIJanFXWdicm3Rf3EBSJU9MosXrEgQwKjWOTaP3CzvZYaRiaCa/0', null, null, null, '128', '2016-11-10 21:04:37', '2016-11-10 21:04:37');
INSERT INTO `user_detail` VALUES ('30', '0', '周先生', '15002781007', 'http://wx.qlogo.cn/mmopen/FAqV5coM53jxwCdREecj3ZZBWYQ1IUuIc1J8yecss3bNPtkA1t2dzNacwoiarKiaFYjzvwejej7IBOtxhf2403fPMJibke3iaUAI/0', '湖北武汉', '', '', '129', '2016-11-11 15:47:53', '2016-12-15 13:55:32');
INSERT INTO `user_detail` VALUES ('32', '0', '何姿', '15015367140', 'http://wx.qlogo.cn/mmopen/ibJJngZRP5m8mjue7iapdkUCr59pU2zNGribE7NPfEB31tSjn1BPiamzWdgibo9xF5ab5yqlGgfmYN0u5iawBz0Ast6w/0', '湖北武汉', null, null, '131', '2016-11-14 17:39:50', '2016-11-14 17:47:52');
INSERT INTO `user_detail` VALUES ('33', '0', '严飞', '13545002090', 'http://wx.qlogo.cn/mmopen/SQd7RF5caa2iaicplIibdNo2kJuZBsjOzMSBPXCrrjyWYFNvNpcicrGriaXQOWXyga9ZUyzP2kMfNVaRAdtl1vsvA4A/0', '湖北武汉', null, null, '132', '2016-11-14 18:00:52', '2016-11-14 18:13:29');
INSERT INTO `user_detail` VALUES ('34', '0', '自在', '15926332570', 'http://wx.qlogo.cn/mmopen/Q3auHgzwzM5ox1biafnclLh8AEApy1wV02jZBCOSciaUibMPVWFBgqOhy7mfr9CWicMKN12eRQIVX8N7rHdn9iaIGrtE7ia8emfNmZ03J0I36VFGM/0', null, null, null, '133', '2016-11-14 18:44:05', '2016-11-14 18:44:05');
INSERT INTO `user_detail` VALUES ('35', '1', '陈树理', '18756759690', 'http://wx.qlogo.cn/mmopen/SQd7RF5caa0Vlxlqz3uPjYDyGJ8gqpIWBvBfBicntrTtKObXD3qOa5eqbhjbJ0ic12QSuHQTlfx3sne09fhDZAj0gHBr2BibtdL/0', '安徽省亳州市谯城区光明西路', '陈树理/沪谯饮片厂', null, '134', '2016-11-21 16:02:33', '2016-12-08 14:45:39');
INSERT INTO `user_detail` VALUES ('36', '0', '赵飞', '13760623606', 'http://wx.qlogo.cn/mmopen/9XibKWLOyJBTZuYyJYe41DqqCqckozUXPXxk6X5Siaq258bgibvIozMdicQD4ptd4jFBheKqkG2hzgeJFuDWynB9REOw5vrwE6p1/0', null, null, null, '135', '2016-11-22 23:18:15', '2016-11-22 23:18:15');
INSERT INTO `user_detail` VALUES ('37', '0', '张伟', '13888008610', 'http://wx.qlogo.cn/mmopen/9XibKWLOyJBTxXEgaXFZO37ckB5aGg12MDHwvn5icH1avHFo4UBXial8iaGxiaXLVrydRxZwCqlZ4w7pGdtStkjHDlpkZbDZWaLQI/0', null, null, null, '139', '2016-11-23 08:36:35', '2016-11-23 08:36:35');
INSERT INTO `user_detail` VALUES ('38', '0', '丽', '13888119155', 'http://wx.qlogo.cn/mmopen/FAqV5coM53ia7iaydGQAXP2hU3P4TzuyslDVp9zVSLMic27TKGU3HspY61K6TSpSZbEghHsnC3HNS33ibZibrMMy5kwYnVQbrRUPt/0', null, null, null, '140', '2016-11-23 09:47:36', '2016-11-23 09:47:36');
INSERT INTO `user_detail` VALUES ('39', '0', '陈红飞(燚淋)', '15925628899', 'http://wx.qlogo.cn/mmopen/FAqV5coM53ia7iaydGQAXP2rvRwHA6k6NB10udj9H3KffMkoePJC90N5Mcfe4JGgq1PgZUicja9ATXJ1kIFswlPdLRkJSKFO8k9/0', null, null, null, '141', '2016-11-23 12:17:35', '2016-11-23 12:17:35');
INSERT INTO `user_detail` VALUES ('40', '0', '中庸', '18048808242', '', null, null, null, '142', '2016-11-23 15:27:22', '2016-11-23 15:27:22');
INSERT INTO `user_detail` VALUES ('41', '0', '三实药商主营元胡', '13355687515', 'http://wx.qlogo.cn/mmopen/ibJJngZRP5mibSvG2NtiaQ9yIwWNhzeuqibQPHmqn5YnKMS3G8CibRtZyoYMAxnvd6ofnvKgIbR093Tfn24Xlamk8o4OFrY4G5nnx/0', null, null, null, '143', '2016-11-23 16:31:15', '2016-11-23 16:31:15');
INSERT INTO `user_detail` VALUES ('42', '0', '汪宗喜', '15055065555', 'http://wx.qlogo.cn/mmopen/ibJJngZRP5m8SSO41ibLxwK0GU9SRjaHShnctCp2vYia02ibytzKNYZBSds34OPfgcroCQCLfJkQntt4tQqhjcXMNZ8OSfZWgQib6/0', '', '', '', '144', '2016-11-25 07:57:12', '2016-11-25 07:58:21');
INSERT INTO `user_detail` VALUES ('43', '0', '陈永争', '13705686011', null, '', '', '', '145', '2016-11-28 15:37:56', '2016-11-28 15:37:56');
INSERT INTO `user_detail` VALUES ('44', '0', '郑凯迪', '18956757255', 'http://wx.qlogo.cn/mmopen/SQd7RF5caa2wEaDzUsEnrzE7Y7t2kErDvfp38D5LGvVlmKU6HUhJwL1MINPMZ9RLe9ohvTSxYrCXJsSyKh7reCKx04evohnQ/0', '亳州', null, null, '146', '2016-11-28 16:20:09', '2016-11-29 00:15:30');
INSERT INTO `user_detail` VALUES ('45', '0', 'dt', '18956780080', 'http://wx.qlogo.cn/mmopen/PiajxSqBRaELm8SbVCrKzFn0D4psak72uMmdwCmlTpGIq7bEZk7IPQyakgYHh2ZE34tYauMnNxLGtR6rPswa4gQ/0', null, null, null, '147', '2016-11-28 17:15:05', '2016-11-28 17:15:05');
INSERT INTO `user_detail` VALUES ('46', '0', 'lawyer', '18656705001', 'http://wx.qlogo.cn/mmopen/ajNVdqHZLLB1aZW40LjI6VMp2xpUztJCZCDUPnz7HgThEeFeHcHd6SW5S2Kibl54rb4k1Kog9uIe0vcydvQWWsA/0', null, null, null, '148', '2016-11-28 20:37:49', '2016-11-28 20:37:49');
INSERT INTO `user_detail` VALUES ('47', '0', '刘年轻', '18055866925', 'http://wx.qlogo.cn/mmopen/FAqV5coM53hd8Gl1wbdiafgXSoNAtFaRBxiasyRICZgzb39qNSCsCibpVfAJiafOvI0u5GmjvMSUKBdKrAv3wxsmiaIBZ952mZeKA/0', null, null, null, '149', '2016-11-28 21:52:47', '2016-11-28 21:52:47');
INSERT INTO `user_detail` VALUES ('48', '0', '刘万江13845975701', '13845975701', 'http://wx.qlogo.cn/mmopen/0HqbFdfAEhCG0EDPjcPyPZEVJbvJLYRib8HNwicWLTBWMH9iaMFxDBLEjvKBibMMBpicCiarHVUUpJYnQxA3xl8axk1y53viay8KibPy/0', null, null, null, '151', '2016-12-11 11:26:37', '2016-12-11 11:26:37');
INSERT INTO `user_detail` VALUES ('49', '0', '周亮', '13041162468', 'http://wx.qlogo.cn/mmopen/SQd7RF5caa0OtCyykHaibxfMPyrbvJGwsiaicJdsI8Vpx8XHlnyZwgqnkTiavE2MwSZhibdYAdmMnuYZOPNh1EYAdLA/0', null, null, null, '152', '2016-12-13 17:06:37', '2016-12-13 17:06:37');
INSERT INTO `user_detail` VALUES ('50', '0', '秀才', '13636286273', 'http://wx.qlogo.cn/mmopen/FAqV5coM53hFNnaJ1LYokCRDN8AEkkQpc5RStAcukK55ooXHF0cpSsdTgiaah0OEaXA2aBthBEQdJLWVxIBPbLzFGM3XKczEG/0', null, null, null, '153', '2016-12-15 08:15:15', '2016-12-15 08:15:15');
INSERT INTO `user_detail` VALUES ('51', '0', '程效芬佳欣宝贝，15055070828', '15055070828', 'http://wx.qlogo.cn/mmopen/FAqV5coM53ia7iaydGQAXP2ia42265Tr93iaFpibE5licf7Agb3W5VkNzJGs4nGaf99EVjUOWgOPyiaSibseTuhUlVuTxdcXySdicrwibD/0', null, null, null, '154', '2016-12-15 17:54:15', '2016-12-15 17:54:15');
INSERT INTO `user_detail` VALUES ('52', '0', '众和农业', '15339695789', 'http://wx.qlogo.cn/mmopen/ibJJngZRP5mibSvG2NtiaQ9yKLoFLDdG1bgMmjvEhw6zibxfCTTLJk1RAmVqbOANVicx4Fpqf8D0MEtM0WjUDxKLGNEQXBcWkuZnP/0', null, null, null, '155', '2016-12-15 17:59:41', '2016-12-15 17:59:41');
INSERT INTO `user_detail` VALUES ('53', '0', 'A海涛药材代销代购13156735787', '13156735787', 'http://wx.qlogo.cn/mmopen/9XibKWLOyJBQxHjjv9LibOCp0bXexDmPZPYAC09Dvicm5r0e9xjzBpu9VwqicEicpHHNgDR57ybfmwTjMSaRQoK0jwNQDT9aATBCN/0', null, null, null, '156', '2016-12-20 22:42:18', '2016-12-20 22:42:18');
INSERT INTO `user_detail` VALUES ('54', '0', '小琪琪', '13881913820', 'http://wx.qlogo.cn/mmopen/PDEqbQ0tgua0UQLUsqSIL2dkPTXboob1whqHeiaWhULJqAjwiaB3SwOTknAaSkj00HMpFzlhepwr7DVqO1ZdzDibFASYceh4vV6/0', null, null, null, '157', '2016-12-21 13:57:35', '2016-12-21 13:57:35');
INSERT INTO `user_detail` VALUES ('55', '0', 'A地道山西中药材', '15035086412', 'http://wx.qlogo.cn/mmopen/ibJJngZRP5mib6GuicwibAkZeubSDR5KicKK2Ha6CFLstNboDuAqzBImpKG6ZhqP7ibxIGDbXPLaoQdEQ1YhIX8c4bwSvQXfdH7FOj/0', null, null, null, '158', '2016-12-21 21:01:15', '2016-12-21 21:01:15');
INSERT INTO `user_detail` VALUES ('56', '0', '原态中药材 香辛料 调料贸易', '15903810702', 'http://wx.qlogo.cn/mmopen/ibJJngZRP5micIEsmSavYu4AVKaoytoJicN8uicgLnYxZzFhKiaGCYeTiaNfNGXoZLY56PpXM2XJliaoxPX1622GASg7p7XHJXpgmqo/0', null, null, null, '159', '2016-12-22 18:07:25', '2016-12-22 18:07:25');
INSERT INTO `user_detail` VALUES ('57', '0', '寥寥数笔   勾勒人生', '18763516003', 'http://wx.qlogo.cn/mmopen/9XibKWLOyJBSiaWiaXibOnuXTDMax7U3AfoEwsOE2yrm1E8z9MG5APQr5icA3icF88Yl1ib2Rwg8OngIZUb7zCboJTJHgoQIoY6Iay5/0', null, null, null, '160', '2016-12-22 19:21:20', '2016-12-22 19:21:20');
INSERT INTO `user_detail` VALUES ('58', '0', '湖', '18909673808', 'http://wx.qlogo.cn/mmopen/FAqV5coM53hbHJ0rscX4kcJsqpKORjqJrw8qLKzMCklvJ4pOldricIDicvAZSyGYPe44Rrk0YbVrPASHxpia571ibw/0', null, null, null, '161', '2016-12-23 20:07:37', '2016-12-23 20:07:37');
INSERT INTO `user_detail` VALUES ('59', '0', '羌活通草灯芯草猪苓僵蚕', '15855882626', 'http://wx.qlogo.cn/mmopen/SQd7RF5caa1RYCjhFclT3UMibWpmEgFjyTd3COOhIwg6rE6MMYOv6BSYH52mmGibnzURumfBBK1QBXsLsWVoZcEw/0', null, null, null, '162', '2016-12-24 00:37:25', '2016-12-24 00:37:25');
INSERT INTO `user_detail` VALUES ('60', '0', '安好可以有多好', '13893237314', 'http://wx.qlogo.cn/mmopen/SQd7RF5caa3JicfWg0WWrqfhfwMCM9MVe0pp5CeGOUpgOpy99hodWx9nuQ4L8fV16Qja78KyYKecEJgzNCp7qEa258TENKAMC/0', null, null, null, '163', '2016-12-26 18:20:06', '2016-12-26 18:20:06');
INSERT INTO `user_detail` VALUES ('61', '0', 'AAA马占祥（冬虫夏草）快递批发', '18609719646', 'http://wx.qlogo.cn/mmopen/SQd7RF5caa0Vlxlqz3uPjVBmoqbEfrVQ6DLMbzOVqkaIIyu6vfTwhSrZ2eNSBmicEbNKFUzIDzbDBethGQgkeMADNumZ5tOVE/0', null, null, null, '164', '2016-12-26 22:35:36', '2016-12-26 22:35:36');
INSERT INTO `user_detail` VALUES ('62', '0', '$彩运虹桥*', '13872574558', 'http://wx.qlogo.cn/mmopen/ibJJngZRP5mibfmOmZg796dKY5l3Ukk73g4ticSTsg2EoLEuaS3SAE3MwQNNcASIFsaxhHso7Ku1YVQVoNEPN4q2G0foCibROfC7/0', null, null, null, '165', '2016-12-26 22:52:07', '2016-12-26 22:52:07');
INSERT INTO `user_detail` VALUES ('63', '0', '三宝', '13803634787', 'http://wx.qlogo.cn/mmopen/FAqV5coM53jrx4UgtSTdiaKVWFqKuQgbAoHHBfZiclQVegFlmSTpG2zyia2DGTcd76C9jZ2bOhcV6In7UhL2Dxnaw/0', null, null, null, '166', '2016-12-26 22:54:28', '2016-12-26 22:54:28');
INSERT INTO `user_detail` VALUES ('64', '0', '测试', '17736426951', null, '', '', '', '167', '2016-12-28 14:17:19', '2016-12-28 14:17:19');
INSERT INTO `user_detail` VALUES ('65', '0', 'AAA乔刚诊所13384786788', '13384786788', 'http://wx.qlogo.cn/mmopen/SQd7RF5caa0Vlxlqz3uPjYagaePJ15F8HOSjHqm9Kyb6SKxtqiarWP5yxKpzrqKrtwfUcicQ2uxEg0NJk4RicdibFt13Xfjhz0qA/0', null, null, null, '168', '2016-12-29 12:00:45', '2016-12-29 12:00:45');
