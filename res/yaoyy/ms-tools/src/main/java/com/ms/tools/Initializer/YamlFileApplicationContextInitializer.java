package com.ms.tools.Initializer;

import org.springframework.boot.env.YamlPropertySourceLoader;
import org.springframework.context.ApplicationContextInitializer;
import org.springframework.context.ConfigurableApplicationContext;
import org.springframework.core.env.PropertySource;
import org.springframework.core.io.Resource;

import java.io.IOException;

/**
 * Author: koabs
 * 12/21/16.
 * 加载yaml 文件的属性到Spring中
 */

public class YamlFileApplicationContextInitializer implements ApplicationContextInitializer<ConfigurableApplicationContext> {

    @Override
    public void initialize(ConfigurableApplicationContext context) {
        try {
            Resource resource = context.getResource("classpath:config.yml");
            YamlPropertySourceLoader sourceLoader = new YamlPropertySourceLoader();
            PropertySource<?> yaml = sourceLoader.load("config", resource, null);
            context.getEnvironment().getPropertySources().addFirst(yaml);
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }

}
