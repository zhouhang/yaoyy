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