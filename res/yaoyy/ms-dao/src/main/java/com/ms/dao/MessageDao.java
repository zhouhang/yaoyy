package com.ms.dao;

import com.ms.dao.config.AutoMapper;
import com.ms.dao.model.Message;
import com.ms.dao.vo.MessageVo;

import java.util.List;
@AutoMapper
public interface MessageDao extends ICommonDao<Message>{

    public List<MessageVo> findByParams(MessageVo messageVo);

}
