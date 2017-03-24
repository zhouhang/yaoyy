INSERT INTO `survey` VALUES ('1', '资源控制能力（产地有没有专门的人负责备货）', '优 ,一般 ,差', '1', '2017-03-23 17:14:05');
INSERT INTO `survey` VALUES ('2', '行情把控能力（对行情的预测是否敏感）', '优 ,一般 ,差', '1', '2017-03-23 17:14:25');
INSERT INTO `survey` VALUES ('3', '品种熟悉程度（对品种质量的理解，经营年限）', '优 ,一般 ,差', '1', '2017-03-23 17:14:51');
INSERT INTO `survey` VALUES ('4', '物流配送能力（是否有自己的车，是否有长期合作的物流公司）', '优 ,一般 ,差', '1', '2017-03-23 17:15:23');
INSERT INTO `survey` VALUES ('5', '资金实力（能否承受较长账期）', '优 ,一般 ,差', '1', '2017-03-23 17:15:46');

ALTER TABLE `supplier_choice`
CHANGE COLUMN `desc` `survey_desc`  varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL AFTER `choose`;

-- 把认证的供应商信息导入到供应商表中
insert into supplier(phone,name,area,enter_category,company,enter_category_str)
select u.phone as phone, ud.name as name,ud.area as area,ud.category_ids as enter_category,
ud.company as company,(select group_concat(category.name) from category where  FIND_IN_SET(category.id,ud.category_ids)) as enter_category_str
FROM user u
LEFT JOIN user_detail ud on u.id = ud.user_id
WHERE u.type = 2;
-- select group_concat(c.name) as enter_category_str from category c where c.id in(691,65,669);
-- 沪谯 供应商导入
insert into supplier(name,phone,enter_category_str,enter_category)
select t.name as name,t.mobile as phone,group_concat(t.category) as enter_category_str,group_concat(c.id) as enter_category from
(select hs.name,hs.mobile, category from huqiao_supplier hs group by hs.name, hs.mobile,hs.category)t
left join category c on t.category = c.name
group by t.name,t.mobile;
-- 设置供应商默认值. 当前创建时间啥的
-- update supplier SET create_time = now(), status = 0 where id >100;
-- 查找供应商重复的数据
-- select group_concat(id) as ids ,supplier.* from supplier group by phone having count(*)>1;
-- 供应商和用户绑定
update user,supplier
set user.supplier_id = supplier.id
where user.phone=supplier.phone;
