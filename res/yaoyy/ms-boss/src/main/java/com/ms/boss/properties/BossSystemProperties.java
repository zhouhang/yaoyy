package com.ms.boss.properties;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

/**
 * Created by wangbin on 2016/12/5.
 */
@Component
public class BossSystemProperties {


    @Value("${doc.base.url}")
    private String baseUrl;

    @Value("${biz.base.url}")
    private String bizBaseUrl;

    public String getBaseUrl() {
        return baseUrl;
    }

    public String getBizBaseUrl() {
        return bizBaseUrl;
    }

}
