/**
1. user 表新建 source,status,verify 3个字段
2. 修改type 字段备注 1 采购商 2 供应商
3. 把type 字段值更新到source 字段上
4. 把type 里面值为启用的用户的type值设置为1
5. 认证状态默认未0 未认证
**/

ALTER TABLE `yaoyy`.`user`
CHANGE COLUMN `type` `type` INT(11) NOT NULL DEFAULT '1' COMMENT '1 采购商 2 供应商' ,
ADD COLUMN `source` INT NOT NULL COMMENT '0注册用户，1申请寄样生成的用户(针对采购商) 10: 后台导入 11: 微信注册 （针对采购商）' AFTER `create_time`,
ADD COLUMN `status` INT NULL DEFAULT 0 COMMENT '0禁用 1启用' AFTER `source`,
ADD COLUMN `verify` INT NULL COMMENT '0 未认证 1已认证(主要针对供应商)' AFTER `status`;

update user set source=0  where type = 0 and id >= 3;
update user set source=1  where type = 1 and id >= 3;
update user set status=0  where type = -1 and id >= 3;
update user set status=1  where type != -1 and id >= 3;
update user set type = 1 where id >=3; -- 数据库所有数据都为 采购商

-- 要删除供应商表 待确认是否需要数据迁移.

CREATE TABLE `yaoyy`.`commodity_batch` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `num` INT NOT NULL COMMENT '商品数量',
  `pick_commodity_id` INT NOT NULL COMMENT '订单商品表的ID',
  `no` VARCHAR(64) NOT NULL COMMENT '批次号',
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
COMMENT = '供应商商品批次信息表';

-- 创建默认寄卖下单用户
INSERT INTO `yaoyy`.`user` (`id`, `type`, `update_time`, `create_time`, `source`, `status`) VALUES ('1', '1', '2017-02-09 12:13:46', '2017-02-09 12:13:46', '0', '1');
INSERT INTO `yaoyy`.`user_detail` (`type`, `nickname`, `user_id`, `create_time`, `update_time`) VALUES ('0', '亳州天际药业有限公司', '1', '2017-02-09 12:13:46', '2017-02-09 12:13:46');

ALTER TABLE `yaoyy`.`history_commodity`
CHANGE COLUMN `price` `price` DECIMAL(10,2) NOT NULL ;

--user和user_detail：


--alter table user add COLUMN status INT(8) DEFAULT 1;--1启用 0禁用

--alter table user add COLUMN source INT(8) DEFAULT NULL;--1：注册用户，0：申请寄样生成的用户',

alter table user_detail add COLUMN category_ids VARCHAR(20) DEFAULT NULL;

alter table user_detail MODIFY area VARCHAR(10);

alter table user_detail add COLUMN email VARCHAR(50) DEFAULT NULL;

alter table user_detail add COLUMN qq VARCHAR(20) DEFAULT NULL;

alter table user_detail add COLUMN company VARCHAR(191) DEFAULT NULL;



--commodity：

alter table commodity add COLUMN warehouse float(10) DETAULT 0;

alter table commodity add COLUMN unwarehouse float(10) DEFAULT 0;

alter table commodity drop column mark;

--supplier:

alter table supplier add COLUMN company VARCHAR(191) DEFAULT NULL;

alter table supplier add COLUMN enter_category_str VARCHAR(191) DEFAULT NULL;


--message:

alter table message add COLUMN is_member int(8) DEFAULT 0;

alter table message DROP COLUMN url;


--category:

alter table category add COLUMN spec VARCHAR(191) NOT NULL;

alter table category MODIFY unit VARCHAR(191);

alter table category add COLUMN unit_desc VARCHAR(191) NOT NULL;

alter table category CHANGE variety name  VARCHAR(191);

alter table category add COLUMN alias VARCHAR(191) DEFAULT NULL;


CREATE TABLE `announcement` (

  `id` int(11) NOT NULL AUTO_INCREMENT,

  `title` varchar(191) DEFAULT NULL,

  `user_type` int(11) DEFAULT NULL,

  `content` text DEFAULT NULL,

  `status` int(11) DEFAULT 0,

  `create_time` datetime DEFAULT NULL,

  PRIMARY KEY (`id`)

) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8 COMMENT='新闻公告表';


CREATE TABLE `user_annex` (

  `id` int(11) NOT NULL AUTO_INCREMENT,

  `user_id` int(11) NOT NULL,

  `url` mediumtext DEFAULT NULL,

  `status` int(11) DEFAULT 0,

  `create_time` datetime DEFAULT NULL,

  PRIMARY KEY (`id`),

  CONSTRAINT `user_annex_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)

) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8 COMMENT='新闻公告表';

CREATE TABLE `user_track_record` (

  `id` int(11) NOT NULL AUTO_INCREMENT,

  `user_id` int(11) DEFAULT NULL COMMENT 'user表id',

  `supplier_id` int(11) DEFAULT NULL COMMENT 'supplier表id',

  `member_id` int(11) NOT NULL COMMENT 'member表id',

  `content` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,

  `create_time` datetime NOT NULL,

  PRIMARY KEY (`id`)

) ENGINE=InnoDB AUTO_INCREMENT=70 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='供应商跟踪记录表';

alter table message change content content text;

alter table user_detail add contract int(8) not Null DEFAULT 0;

-- 2017-03-13
DELETE FROM `yaoyy`.`role_resources` WHERE `id`='1754';
DELETE FROM `yaoyy`.`role_resources` WHERE `id`='1755';
DELETE FROM `yaoyy`.`role_resources` WHERE `id`='1753';

UPDATE `yaoyy`.`resources` SET `name`='寄样服务' WHERE `id`='12';
UPDATE `yaoyy`.`resources` SET `name`='订单管理' WHERE `id`='15';
UPDATE `yaoyy`.`resources` SET `name`='订单列表' WHERE `id`='16';
UPDATE `yaoyy`.`resources` SET `name`='订单审核' WHERE `id`='17';
DELETE FROM `yaoyy`.`resources` WHERE `id`='32';
INSERT INTO `yaoyy`.`resources` (`id`, `name`, `type`, `pid`, `permission`, `create_date`) VALUES ('40', '供应商管理', 'button', '0', 'supplier:index', '2017-03-13 13:27:58');
INSERT INTO `yaoyy`.`resources` (`id`, `name`, `type`, `pid`, `permission`, `create_date`) VALUES ('41', '未签约供应商列表', 'button', '40', 'supplier:unsign', '2017-03-13 13:27:58');
INSERT INTO `yaoyy`.`resources` (`id`, `name`, `type`, `pid`, `permission`, `create_date`) VALUES ('42', '未签约供应商详情', 'button', '40', 'supplier:unsignDetail', '2017-03-13 13:27:58');
INSERT INTO `yaoyy`.`resources` (`id`, `name`, `type`, `pid`, `permission`, `create_date`) VALUES ('43', '签约供应商列表', 'button', '40', 'supplier:sign', '2017-03-13 13:27:58');
INSERT INTO `yaoyy`.`resources` (`id`, `name`, `type`, `pid`, `permission`, `create_date`) VALUES ('44', '签约供应商详情', 'button', '40', 'supplier:signDetail', '2017-03-13 13:27:58');
INSERT INTO `yaoyy`.`resources` (`id`) VALUES (NULL);
DELETE FROM `yaoyy`.`resources` WHERE `id`='28';
DELETE FROM `yaoyy`.`resources` WHERE `id`='29';
UPDATE `yaoyy`.`resources` SET `name`='资讯管理' WHERE `id`='33';

-- 品种导入
ALTER TABLE `yaoyy`.`category`
CHANGE COLUMN `title` `title` VARCHAR(255) NULL COMMENT '标题' ,
CHANGE COLUMN `picture_url` `picture_url` VARCHAR(512) NULL ,
ADD COLUMN `pinyin` VARCHAR(64) NULL AFTER `alias`;

-- 根茎类
insert into category(pid,name,sort,create_time,update_time,level,status,pinyin)
select 1,name,20,now(),now(),2,1,pinyin from category_pieces where parent_id = 64;

-- 果实籽仁类
insert into category(pid,name,sort,create_time,update_time,level,status,pinyin)
select 2,name,20,now(),now(),2,1,pinyin from category_pieces where parent_id = 65;

-- 花叶全草类
insert into category(pid,name,sort,create_time,update_time,level,status,pinyin)
select 3,name,20,now(),now(),2,1,pinyin from category_pieces where parent_id = 68;

-- 藤皮类
insert into category(pid,name,sort,create_time,update_time,level,status,pinyin)
select 4,name,20,now(),now(),2,1,pinyin from category_pieces where parent_id = 1077;

-- 树脂菌藻类
insert into category(pid,name,sort,create_time,update_time,level,status,pinyin)
select 5,name,20,now(),now(),2,1,pinyin from category_pieces where parent_id = 1192;

-- 矿石动物类
insert into category(pid,name,sort,create_time,update_time,level,status,pinyin)
select 6,name,20,now(),now(),2,1,pinyin from category_pieces where parent_id = 1238;

-- 其他类
insert into category(pid,name,sort,create_time,update_time,level,status,pinyin)
select 7,name,20,now(),now(),2,1,pinyin from category_pieces where parent_id = 1680;

-- 删除之前系统输入的品种
delete from category where name = '三棱' and id >=41;
delete from category where name = '半夏' and id >=41;
delete from category where name = '白芍' and id >=41;
delete from category where name = '补骨脂' and id >=41;
delete from category where name = '白附子' and id >=41;
delete from category where name = '天麻' and id >=41;
delete from category where name = '茯苓' and id >=41;
delete from category where name = '稻芽' and id >=41;
delete from category where name = '皂角刺' and id >=41;
delete from category where name = '白及' and id >=41;
delete from category where name = '砂仁' and id >=41;
delete from category where name = '厚朴' and id >=41;
delete from category where name = '苍耳子' and id >=41;
delete from category where name = '百合' and id >=41;
delete from category where name = '旋覆花' and id >=41;
delete from category where name = '柴胡' and id >=41;
delete from category where name = '当归' and id >=41;
delete from category where name = '党参' and id >=41;
delete from category where name = '红花' and id >=41;
delete from category where name = '黄芪' and id >=41;
delete from category where name = '乌药' and id >=41;
delete from category where name = '鸡内金' and id >=41;
