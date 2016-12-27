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



ALTER TABLE `pick`
ADD COLUMN `shipping_costs`  decimal(11,2) NULL DEFAULT NULL COMMENT '运费' AFTER `status`,
ADD COLUMN `bagging`  decimal(11,2) NULL DEFAULT NULL COMMENT '包装费' AFTER `shipping_costs`,
ADD COLUMN `checking`  decimal(11,2) NULL DEFAULT NULL COMMENT '检测费' AFTER `bagging`,
ADD COLUMN `taxation`  decimal(11,2) NULL DEFAULT NULL COMMENT '税费' AFTER `checking`,
ADD COLUMN `settle_type`  int(5) NULL DEFAULT NULL COMMENT '结算方式：0：全款，1：保证金,2:账期' AFTER `taxation`,
ADD COLUMN `deposit`  decimal(11,2) NULL DEFAULT NULL COMMENT '保证金' AFTER `settle_type`,
ADD COLUMN `bill_time`  int(6) NULL DEFAULT NULL COMMENT '账期时间单位天' AFTER `deposit`,
ADD COLUMN `addr_history_id`  int(11) NULL DEFAULT NULL COMMENT '对应下单地址记录里面的id' AFTER `bill_time`,
ADD COLUMN `remark`  varchar(512) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注' AFTER `addr_history_id`,
ADD COLUMN `amounts_payable`  decimal(10,2) NULL DEFAULT NULL COMMENT '实际应付' AFTER `remark`,
ADD COLUMN `member_id`  int(11) NULL DEFAULT NULL COMMENT '操作人id' AFTER `amounts_payable`,
ADD COLUMN `sum`  decimal(10,2) NULL DEFAULT NULL COMMENT '商品合计' AFTER `member_id`,
ADD COLUMN `expire_date`  datetime NULL DEFAULT NULL COMMENT '订单过期时间' AFTER `sum`;


CREATE TABLE `account_bill` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(255) DEFAULT NULL COMMENT '账单编号',
  `order_id` int(11) DEFAULT NULL COMMENT '订单号',
  `user_id` int(11) DEFAULT NULL COMMENT '用户ID',
  `bill_time` int(11) DEFAULT NULL COMMENT '账单时间',
  `amounts_payable` decimal(10,2) DEFAULT NULL COMMENT '应付',
  `already_payable` decimal(10,2) DEFAULT NULL COMMENT '已付',
  `status` tinyint(2) DEFAULT NULL COMMENT '状态(0:未结清,1:已结清)',
  `repay_time` datetime DEFAULT NULL COMMENT '还款时间',
  `member_id` int(11) DEFAULT NULL COMMENT '操作人',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='账单表';

CREATE TABLE `logistical` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `order_id` int(11) DEFAULT NULL,
  `ship_date` datetime DEFAULT NULL COMMENT '发货日期',
  `picture_url` varchar(255) DEFAULT NULL COMMENT '发货单据图片',
  `content` varchar(512) DEFAULT NULL,
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='物流';

CREATE TABLE `pay_account` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `receive_bank` varchar(255) DEFAULT NULL COMMENT '收款银行',
  `receive_account` varchar(255) DEFAULT NULL COMMENT '收款账户',
  `receive_bank_card` varchar(255) DEFAULT NULL COMMENT '收款银行卡号',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='支付账户表';

CREATE TABLE `pay_document` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pay_record_id` int(11) NOT NULL,
  `path` varchar(255) NOT NULL,
  `create_date` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='支付凭证表';

CREATE TABLE `pay_record` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pay_code` varchar(255) DEFAULT NULL COMMENT '支付流水号',
  `order_code` varchar(255) NOT NULL COMMENT '订单编号',
  `order_id` int(11) DEFAULT NULL,
  `code_type` int(5) DEFAULT NULL COMMENT '单号类型：0:订单，1：账单',
  `account_bill_id` int(11) DEFAULT NULL COMMENT '关联账单',
  `payment_id` int(11) DEFAULT NULL COMMENT '三方支付id',
  `actual_payment` decimal(11,2) DEFAULT NULL COMMENT '实付金额',
  `pay_bank` varchar(255) DEFAULT NULL COMMENT '开户行',
  `pay_account` varchar(255) DEFAULT NULL COMMENT '开户人',
  `pay_bank_card` varchar(255) DEFAULT NULL COMMENT '银行卡号',
  `user_id` int(11) NOT NULL COMMENT '用户id',
  `payment_time` datetime NOT NULL COMMENT '支付时间',
  `status` tinyint(2) NOT NULL DEFAULT '0' COMMENT '0付款待确认，1支付成功，2支付失败',
  `pay_type` int(5) DEFAULT NULL COMMENT '支付渠道 ：0,线下转账，1支付宝支付,2.微信支付',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='支付记录表';

CREATE TABLE `payment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL COMMENT '用户id',
  `pay_type` int(5) DEFAULT NULL COMMENT '支付方式',
  `status` int(5) DEFAULT NULL COMMENT '支付状态',
  `money` decimal(10,2) DEFAULT NULL COMMENT '支付金额',
  `trade_no` varchar(64) DEFAULT NULL COMMENT '支付宝/微信交易号',
  `out_trade_no` varchar(255) DEFAULT NULL COMMENT '提供给第三方支付的订单号，必须唯一',
  `remark` varchar(255) DEFAULT NULL,
  `in_param` text COMMENT '返回参数',
  `out_param` text COMMENT '传出参数',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `callback_time` datetime DEFAULT NULL COMMENT '回调时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='线上支付表';

ALTER TABLE `yaoyy`.`order_invoice`
ADD COLUMN `order_id` INT NULL COMMENT '订单ID' AFTER `bank_account`;


