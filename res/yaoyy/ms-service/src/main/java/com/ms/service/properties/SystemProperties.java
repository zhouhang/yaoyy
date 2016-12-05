package com.ms.service.properties;

import org.springframework.boot.context.properties.ConfigurationProperties;

import org.springframework.stereotype.Component;

/**
 * Created by wangbin on 2016/12/5.
 */
@ConfigurationProperties(locations="classpath:config.yml",prefix = "sms")
@Component
public class SystemProperties {


    private String apikey;

    private String serviceMobile;

    public String getApikey() {
        return apikey;
    }

    public void setApikey(String apikey) {
        this.apikey = apikey;
    }

    public void setServiceMobile(String serviceMobile) {
        this.serviceMobile = serviceMobile;
    }

    public String getServiceMobile() {
        return serviceMobile;
    }

}
