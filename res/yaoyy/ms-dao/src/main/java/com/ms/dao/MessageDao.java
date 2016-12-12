package com.ms.dao;

import com.ms.dao.config.AutoMapper;
import com.ms.dao.model.Message;
import com.ms.dao.vo.MessageVo;
import org.apache.ibatis.annotations.Param;

import java.util.List;
@AutoMapper
public interface MessageDao extends ICommonDao<Message>{

    public List<MessageVo> findByParams(MessageVo messageVo);

    public Integer count(Integer type);

    Integer consumeMsg(@Param("eventId")Integer eventId,@Param("type")Integer type);

}
