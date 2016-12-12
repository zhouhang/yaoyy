package com.ms.service.observer;

import com.ms.service.MessageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationListener;
import org.springframework.stereotype.Component;

/**
 * Author: koabs
 * 12/5/16.
 * 生产消息监听器
 */
@Component
public class MsgConsumeListener implements ApplicationListener<MsgConsumeEvent> {

    @Autowired
    private MessageService messageService;

    @Override
    public void onApplicationEvent(MsgConsumeEvent event) {
        messageService.consumeMsg(event.getEventId(),event.getType());
    }
}
