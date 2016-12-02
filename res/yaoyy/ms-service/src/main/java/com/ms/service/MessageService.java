package com.ms.service;

import com.github.pagehelper.PageInfo;
import com.ms.dao.model.Message;
import com.ms.dao.vo.MessageVo;

public interface MessageService extends ICommonService<Message>{

    public PageInfo<MessageVo> findByParams(MessageVo messageVo,Integer pageNum,Integer pageSize);
}
