ALTER TABLE `pick`
ADD COLUMN `supplier_id`  int NULL COMMENT '供应商ID' AFTER `amounts_payable`;

ALTER TABLE `pick` ADD FOREIGN KEY (`supplier_id`) REFERENCES `user` (`id`);


ALTER TABLE `pick`
ADD COLUMN `complete_time`  datetime NULL COMMENT '订单完成时间' AFTER `update_time`

ALTER TABLE `yaoyy`.`history_commodity`
ADD COLUMN `category_id` INT NULL COMMENT '品种ID' AFTER `create_time`;
ALTER TABLE `yaoyy`.`history_commodity`
CHANGE COLUMN `picture_url` `picture_url` VARCHAR(255) CHARACTER SET 'utf8' NULL ,
CHANGE COLUMN `thumbnail_url` `thumbnail_url` VARCHAR(255) CHARACTER SET 'utf8' NULL ;
