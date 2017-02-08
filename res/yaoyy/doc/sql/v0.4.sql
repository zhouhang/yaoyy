
CREATE TABLE `quote_feed` (
  `id` int(11) NOT NULL,
  `qid` int(11) NOT NULL COMMENT '报价单id',
  `nickname` varchar(256) DEFAULT NULL COMMENT '昵称',
  `content` text COMMENT '评论内容',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='报价单评论';
