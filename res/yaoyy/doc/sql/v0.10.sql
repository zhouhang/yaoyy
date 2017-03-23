INSERT INTO `survey` VALUES ('1', '资源控制能力（产地有没有专门的人负责备货）', '优 ,一般 ,差', '1', '2017-03-23 17:14:05');
INSERT INTO `survey` VALUES ('2', '行情把控能力（对行情的预测是否敏感）', '优 ,一般 ,差', '1', '2017-03-23 17:14:25');
INSERT INTO `survey` VALUES ('3', '品种熟悉程度（对品种质量的理解，经营年限）', '优 ,一般 ,差', '1', '2017-03-23 17:14:51');
INSERT INTO `survey` VALUES ('4', '物流配送能力（是否有自己的车，是否有长期合作的物流公司）', '优 ,一般 ,差', '1', '2017-03-23 17:15:23');
INSERT INTO `survey` VALUES ('5', '资金实力（能否承受较长账期）', '优 ,一般 ,差', '1', '2017-03-23 17:15:46');

ALTER TABLE `supplier_choice`
CHANGE COLUMN `desc` `survey_desc`  varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL AFTER `choose`;
