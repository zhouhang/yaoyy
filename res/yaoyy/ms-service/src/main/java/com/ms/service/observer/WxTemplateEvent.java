package com.ms.service.observer;

import com.ms.service.enums.MessageEnum;
import me.chanjar.weixin.mp.bean.template.WxMpTemplateMessage;
import org.springframework.context.ApplicationEvent;

/**
 * Author: kevin
 * 03/07/17.
 * 微信模板消息
 */
public class WxTemplateEvent extends ApplicationEvent{

    public WxMpTemplateMessage getTemplateMessage() {
        return templateMessage;
    }

    public void setTemplateMessage(WxMpTemplateMessage templateMessage) {
        this.templateMessage = templateMessage;
    }

    // 微信模板消息对象
    private WxMpTemplateMessage templateMessage;

    public WxTemplateEvent(WxMpTemplateMessage templateMessage) {
        super(templateMessage);
        this.templateMessage = templateMessage;
    }
}
