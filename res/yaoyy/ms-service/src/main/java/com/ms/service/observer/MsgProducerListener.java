package com.ms.service.observer;

import com.ms.dao.model.Message;
import com.ms.service.MessageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationListener;
import org.springframework.stereotype.Component;

/**
 * Author: koabs
 * 12/5/16.
 * 消费消息监听器
 */
@Component
public class MsgProducerListener implements ApplicationListener<MsgProducerEvent>{

    @Autowired
    private MessageService messageService;

    @Override
    public void onApplicationEvent(MsgProducerEvent event) {
        Message message = new Message();
        message.setType(event.getType().get());
        message.setEventId(event.getEventId());
        message.setContent(event.getContent());
        message.setUserId(event.getUserId());
        messageService.create(message);
    }
}
