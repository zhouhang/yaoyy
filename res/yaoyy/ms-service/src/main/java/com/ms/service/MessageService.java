package com.ms.service;

import com.github.pagehelper.PageInfo;
import com.ms.dao.model.Message;
import com.ms.dao.vo.MessageVo;
import com.ms.service.enums.MessageEnum;

import java.util.List;

public interface MessageService extends ICommonService<Message>{

    public PageInfo<MessageVo> findByParams(MessageVo messageVo,Integer pageNum,Integer pageSize);

    public List<MessageVo> findUnReadMsg();

    /**
     * 将消息设置为已读
     * @param eventId
     * @param type
     */
    public void consumeMsg(Integer eventId, MessageEnum type);

    /**
     * 将消息设置为已读
     * @param msgId
     */
    public void consumeMsg(Integer msgId);

    /**
     * 获取未读消息数量
     * @param type
     * @return
     */
    public Integer count(MessageEnum type);
}
