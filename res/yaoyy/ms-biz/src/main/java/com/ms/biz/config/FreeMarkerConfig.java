package com.ms.biz.config;

import com.ms.biz.properties.BizSystemProperties;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import javax.annotation.PostConstruct;

/**
 * Created by burgl on 2016/10/29.
 */
@Configuration
public class FreeMarkerConfig {

    @Autowired
    protected freemarker.template.Configuration configuration;

    @Autowired
    private BizSystemProperties systemProperties;

    @PostConstruct
    public void freeMarkerConfigurer(){
        try {
            configuration.setSharedVariable("baseUrl",systemProperties.getBaseUrl());
        }catch (Exception e){
            e.printStackTrace();
        }
    }



}
