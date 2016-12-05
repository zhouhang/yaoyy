package com.ms.biz.properties;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

/**
 * Created by wangbin on 2016/12/5.
 */
@Component
public class BizSystemProperties {


    @Value("${doc.base.url}")
    private String baseUrl;

    public String getBaseUrl() {
        return baseUrl;
    }

}
