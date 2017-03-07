package com.ms.service.observer;


import me.chanjar.weixin.common.exception.WxErrorException;
import me.chanjar.weixin.mp.api.WxMpService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationListener;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Component;

import java.util.Arrays;
import java.util.List;

/**
 * Author: kevin
 * 03/07/17.
 * 微信模板消息监听器
 */
@Component
public class WxTemplateListener implements ApplicationListener<WxTemplateEvent>{

    @Autowired
    private WxMpService wxMpService;

    @Override
    @Async
    public void onApplicationEvent(WxTemplateEvent event) {
        try {
            wxMpService.getTemplateMsgService().sendTemplateMsg(event.getTemplateMessage());
        } catch(WxErrorException e){
            e.printStackTrace();
        }
    }
}
