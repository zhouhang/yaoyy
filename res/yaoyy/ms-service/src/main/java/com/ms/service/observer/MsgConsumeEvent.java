package com.ms.service.observer;

import com.ms.service.enums.MessageEnum;
import org.springframework.context.ApplicationEvent;

/**
 * Author: koabs
 * 12/5/16.
 * 提示消息生产
 */
public class MsgConsumeEvent extends ApplicationEvent{
    // //对应的id(寄样单，或是选货单)
    private Integer eventId;

    private MessageEnum type;

    public MsgConsumeEvent(Integer eventId, MessageEnum type) {
        super(eventId);
        this.eventId = eventId;
        this.type = type;
    }

    public Integer getEventId() {
        return eventId;
    }

    public MessageEnum getType() {
        return type;
    }
}
