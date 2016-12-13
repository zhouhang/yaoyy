
DROP TABLE IF EXISTS `follow_commodity`;
CREATE TABLE `follow_commodity` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `commodity_id` int(11) DEFAULT NULL,
  `price` decimal(10,2) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `follow_commodity_ibfk` (`commodity_id`),
  CONSTRAINT `follow_commodity_ibfk` FOREIGN KEY (`commodity_id`) REFERENCES `commodity` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;



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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;


ALTER TABLE `yaoyy`.`commodity`
ADD COLUMN `price_update_time` DATETIME NULL COMMENT '价格更新时间' AFTER `supplier_id`;


ALTER TABLE `commodity`
ADD COLUMN `supplier_id`  int(11) COMMENT '供应商id' AFTER `thumbnail_url`;

INSERT INTO `yaoyy`.`resources` (`id`, `name`, `type`, `path`, `pid`, `permission`, `create_date`) VALUES ('28', '供应商列表', 'button', '', '32', 'supplier:list', '2016-12-09 17:29:07');
INSERT INTO `yaoyy`.`resources` (`id`, `name`, `type`, `path`, `pid`, `permission`, `create_date`) VALUES ('29', '供应商详情', 'button', '', '32', 'supplier:edit', '2016-12-09 17:29:55');
INSERT INTO `yaoyy`.`resources` (`id`, `name`, `type`, `path`, `pid`, `permission`, `create_date`) VALUES ('30', '报价单列表', 'button', '', '33', 'quotation:list', '2016-12-09 17:30:45');
INSERT INTO `yaoyy`.`resources` (`id`, `name`, `type`, `path`, `pid`, `permission`, `create_date`) VALUES ('31', '报价单详情', 'button', '', '33', 'quotation:edit', '2016-12-09 17:31:05');
INSERT INTO `yaoyy`.`resources` (`id`, `name`, `type`, `path`, `pid`, `permission`, `create_date`) VALUES ('32', '供应商主页', 'button', '', '0', 'supplier:index', '2016-12-09 17:33:06');
INSERT INTO `yaoyy`.`resources` (`id`, `name`, `type`, `path`, `pid`, `permission`, `create_date`) VALUES ('33', '报价单主页', 'button', '', '0', 'quotation:index', '2016-12-09 17:33:45');


ALTER TABLE `member`
ADD COLUMN `tel`  varchar(255) NULL COMMENT '座机号码' AFTER `email`,
ADD COLUMN `openid`  varchar(255) NULL COMMENT '微信openid' AFTER `tel`;

