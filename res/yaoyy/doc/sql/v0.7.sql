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
