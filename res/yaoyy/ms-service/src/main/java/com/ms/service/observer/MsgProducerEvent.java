package com.ms.service.observer;

import com.ms.service.enums.MessageEnum;
import org.springframework.context.ApplicationEvent;

/**
 * Author: koabs
 * 12/5/16.
 * 消费提示消息
 */
public class MsgProducerEvent extends ApplicationEvent{

    // //对应的id(寄样单，或是选货单)
    private Integer eventId;

    private MessageEnum type;

    private String content;

    private Integer userId;

    //isMember为0表示user_id是前台用户id，值为1表示user_id后台用户id
    private Integer isMember;

    public MsgProducerEvent(Integer eventId, MessageEnum type, String content, Integer isMember) {
        super(eventId);
        this.eventId = eventId;
        this.type = type;
        this.content = content;
        this.isMember = isMember;
    }

    public MsgProducerEvent(Integer userId, Integer eventId, MessageEnum type, String content, Integer isMember) {
        super(eventId);
        this.eventId = eventId;
        this.type = type;
        this.content = content;
        this.userId = userId;
        this.isMember = isMember;
    }

    public Integer getEventId() {
        return eventId;
    }

    public MessageEnum getType() {
        return type;
    }

    public String getContent() {
        return content;
    }

    public Integer getUserId() {
        return userId;
    }

    public Integer getIsMember() { return isMember; }
}
