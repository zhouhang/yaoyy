DROP TABLE IF EXISTS `area`;
CREATE TABLE `area` (
  `id` int(10) NOT NULL COMMENT 'ID',
  `areaname` varchar(50) NOT NULL COMMENT '栏目名',
  `parentid` int(10) NOT NULL COMMENT '父栏目',
  `shortname` varchar(50) DEFAULT NULL,
  `areacode` int(6) DEFAULT NULL,
  `zipcode` int(10) DEFAULT NULL,
  `pinyin` varchar(100) DEFAULT NULL,
  `lng` varchar(20) DEFAULT NULL,
  `lat` varchar(20) DEFAULT NULL,
  `level` tinyint(1) NOT NULL,
  `position` varchar(255) NOT NULL,
  `sort` tinyint(3) unsigned DEFAULT '50' COMMENT '排序',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='区域code表';

CREATE TABLE `order_invoice` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) DEFAULT NULL COMMENT '单位名称',
  `type` int(11) DEFAULT NULL COMMENT '1.个人发票 2.增值税发票',
  `content` varchar(256) DEFAULT NULL COMMENT '发票内容',
  `identifier` varchar(64) DEFAULT NULL COMMENT '纳税人识别码',
  `registered_address` varchar(64) DEFAULT NULL COMMENT '注册地址',
  `registered_tel` varchar(15) DEFAULT NULL COMMENT '注册电话',
  `bank_name` varchar(32) DEFAULT NULL COMMENT '开户银行',
  `bank_account` varchar(32) DEFAULT NULL COMMENT '银行账户',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8 COMMENT='发票';

CREATE TABLE `shipping_address` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `is_default` bit(1) DEFAULT NULL COMMENT '是否默认地址\n            1 默认',
  `consignee` varchar(32) DEFAULT NULL COMMENT '收货人',
  `postcode` varchar(20) DEFAULT NULL COMMENT '邮编',
  `tel` varchar(12) DEFAULT NULL COMMENT '手机号码',
  `area_id` int(11) DEFAULT NULL COMMENT '所在区域',
  `detail` varchar(64) DEFAULT NULL COMMENT '详细地址',
  `create_time` datetime DEFAULT NULL,
  `aliases` varchar(12) DEFAULT NULL COMMENT '别名',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=85 DEFAULT CHARSET=utf8 COMMENT='收货地址';

CREATE TABLE `shipping_address_history` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `consignee` varchar(32) DEFAULT NULL COMMENT '收货人',
  `postcode` varchar(20) DEFAULT NULL,
  `tel` varchar(12) DEFAULT NULL COMMENT '手机号码',
  `area_id` int(11) DEFAULT NULL,
  `area` varchar(32) DEFAULT NULL COMMENT '所在区域',
  `detail` varchar(64) DEFAULT NULL COMMENT '详细地址',
  `create_time` datetime DEFAULT NULL,
  `aliases` varchar(12) DEFAULT NULL COMMENT '别名',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=185 DEFAULT CHARSET=utf8 COMMENT='历史收货地址';
