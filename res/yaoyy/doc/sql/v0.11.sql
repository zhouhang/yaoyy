ALTER TABLE `pick`
ADD COLUMN `supplier_id`  int NULL COMMENT '供应商ID' AFTER `amounts_payable`;

ALTER TABLE `pick` ADD FOREIGN KEY (`supplier_id`) REFERENCES `user` (`id`);


ALTER TABLE `pick`
ADD COLUMN `complete_time`  datetime NULL COMMENT '订单完成时间' AFTER `update_time`;

ALTER TABLE `yaoyy`.`history_commodity`
ADD COLUMN `category_id` INT NULL COMMENT '品种ID' AFTER `create_time`;
ALTER TABLE `yaoyy`.`history_commodity`
CHANGE COLUMN `picture_url` `picture_url` VARCHAR(255) CHARACTER SET 'utf8' NULL ,
CHANGE COLUMN `thumbnail_url` `thumbnail_url` VARCHAR(255) CHARACTER SET 'utf8' NULL ;


ALTER TABLE `user_detail`
  MODIFY COLUMN `contract`  int(8) NULL DEFAULT 0 AFTER `company`;

-- 2017-04-11
  ALTER TABLE `yaoyy`.`pick_commodity`
CHANGE COLUMN `num` `num` DECIMAL(20,2) NULL DEFAULT NULL ;



-- 2017-04-20
CREATE TABLE `yaoyy`.`article_tag` (
  `id` INT NOT NULL,
  `sort` INT NULL DEFAULT 0,
  `name` VARCHAR(45) NOT NULL,
  `create_time` DATETIME NULL,
  `status` INT NOT NULL COMMENT '0 禁用 1启用',
  PRIMARY KEY (`id`));


CREATE TABLE `yaoyy`.`article_tag_bind` (
  `id` INT NOT NULL,
  `article_id` INT NOT NULL,
  `tag_id` INT NOT NULL,
  UNIQUE INDEX `index2` (`tag_id` ASC, `article_id` ASC),
  PRIMARY KEY (`id`));

ALTER TABLE `yaoyy`.`article`
CHANGE COLUMN `status` `status` INT(5) NOT NULL DEFAULT '1' COMMENT '状态 1启用(发布)，0禁用(草稿)' ,
ADD COLUMN `descript` VARCHAR(64) NULL AFTER `update_time`,
ADD COLUMN `hits` INT NULL DEFAULT 0 COMMENT '点击率' AFTER `descript`,
ADD COLUMN `type` INT NULL DEFAULT 1 COMMENT '文章类别  1:平台CMS文章 2：药商头条' AFTER `hits`;

ALTER TABLE `yaoyy`.`article`
CHANGE COLUMN `descript` `descript` VARCHAR(64) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NULL DEFAULT NULL ;
ALTER TABLE `yaoyy`.`article_tag_bind`
CHANGE COLUMN `id` `id` INT(11) NOT NULL AUTO_INCREMENT ;
ALTER TABLE `yaoyy`.`article_tag`
CHANGE COLUMN `id` `id` INT(11) NOT NULL AUTO_INCREMENT ;




