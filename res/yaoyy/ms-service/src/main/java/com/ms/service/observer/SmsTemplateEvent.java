package com.ms.service.observer;

import me.chanjar.weixin.mp.bean.template.WxMpTemplateMessage;
import org.springframework.context.ApplicationEvent;

/**
 * Author: kevin
 * 03/07/17.
 * 短信模板消息
 */
public class SmsTemplateEvent extends ApplicationEvent{

    public String getMobile() {
        return mobile;
    }

    public void setMobile(String mobile) {
        this.mobile = mobile;
    }

    private String mobile;

    public String getPwd() {
        return pwd;
    }

    public void setPwd(String pwd) {
        this.pwd = pwd;
    }

    private String pwd;

    public SmsTemplateEvent(String mobile, String pwd) {
        super(mobile);
        this.mobile = mobile;
        this.pwd = pwd;

    }
}
