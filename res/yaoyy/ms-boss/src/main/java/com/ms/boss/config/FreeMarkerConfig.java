package com.ms.boss.config;

import com.ms.boss.properties.BossSystemProperties;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
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
    private BossSystemProperties bossSystemProperties;


    @PostConstruct
    public void freeMarkerConfigurer(){
        try {
            configuration.setSharedVariable("baseUrl",bossSystemProperties.getBaseUrl());
            configuration.setSharedVariable("bizBaseUrl",bossSystemProperties.getBizBaseUrl());
            configuration.setDefaultEncoding("UTF-8");
        }catch (Exception e){
            e.printStackTrace();
        }
    }



}
