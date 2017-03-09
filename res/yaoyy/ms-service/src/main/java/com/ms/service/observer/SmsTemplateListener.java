package com.ms.service.observer;


import com.ms.service.sms.SmsUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationListener;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Component;

/**
 * Author: kevin
 * 03/07/17.
 * 短信模板消息监听器
 */
@Component
public class SmsTemplateListener implements ApplicationListener<SmsTemplateEvent>{


    @Autowired
    SmsUtil smsUtil;

    @Override
    @Async
    public void onApplicationEvent(SmsTemplateEvent event) {

        try {
            smsUtil.sendSupplierSign(event.getMobile(), event.getPwd());
        }catch(Exception e){
            e.printStackTrace();
        }
    }
}
