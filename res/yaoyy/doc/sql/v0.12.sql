ALTER TABLE `yaoyy`.`commodity`
ADD COLUMN `special_offers` INT NULL DEFAULT 0 COMMENT '0表示非特价商品 1表示特价商品' AFTER `unwarehouse`;
