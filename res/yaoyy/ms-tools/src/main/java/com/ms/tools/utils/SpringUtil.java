package com.ms.tools.utils;

/**
 * Created by xiao on 2016/12/27.
 */
import org.springframework.beans.BeansException;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;
import org.springframework.stereotype.Component;


@Component
public class SpringUtil implements ApplicationContextAware {
    /**
     * 上下文
     */
    private static ApplicationContext applicationContext;

    public static ApplicationContext getApplicationContext() {
        return applicationContext;
    }

    public void setApplicationContext(ApplicationContext applicationContext)
            throws BeansException {
        SpringUtil.applicationContext = applicationContext;
    }

    /**
     * 根据Bean ID获取Bean
     *
     * @param beanId
     * @return
     */
    public static Object getBean(String beanId) {
        return applicationContext.getBean(beanId);
    }

    /**
     * 根据类型获取bean
     * @param clazz
     * @return
     */
    public static Object getBean(Class clazz) {
        return applicationContext.getBean(clazz);
    }
}
