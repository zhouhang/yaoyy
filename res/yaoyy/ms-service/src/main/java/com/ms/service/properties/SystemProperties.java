package com.ms.service.properties;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.PropertySource;
import org.springframework.stereotype.Component;

/**
 * Created by wangbin on 2016/12/5.
 */
@Component
@PropertySource(value="classpath:config.properties")
public class SystemProperties {


    @Value("${sms.apikey}")
    private String apikey;

    @Value("${sms.serviceMobile}")
    private String serviceMobile;

    public String getApikey() {
        return apikey;
    }

    public void setApikey(String apikey) {
        this.apikey = apikey;
    }

    public String getServiceMobile() {
        return serviceMobile;
    }

    public void setServiceMobile(String serviceMobile) {
        this.serviceMobile = serviceMobile;
    }
}
