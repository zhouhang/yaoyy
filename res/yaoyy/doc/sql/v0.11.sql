ALTER TABLE `pick`
ADD COLUMN `supplier_id`  int NULL COMMENT '供应商ID' AFTER `amounts_payable`;

ALTER TABLE `pick` ADD FOREIGN KEY (`supplier_id`) REFERENCES `user` (`id`);