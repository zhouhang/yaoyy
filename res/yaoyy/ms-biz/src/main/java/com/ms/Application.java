package com.ms;

import com.ms.tools.initializer.YamlFileApplicationContextInitializer;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.context.embedded.ConfigurableEmbeddedServletContainer;
import org.springframework.boot.context.embedded.EmbeddedServletContainerCustomizer;
import org.springframework.boot.web.servlet.ErrorPage;
import org.springframework.boot.web.support.ErrorPageFilter;
import org.springframework.boot.web.support.SpringBootServletInitializer;
import org.springframework.context.annotation.Bean;
import org.springframework.http.HttpStatus;

/**
 * Created by burgl on 2016/8/13.
 */

@SpringBootApplication
//@ComponentScan(
//        basePackages = "com.ms",
//        useDefaultFilters = true,
//        excludeFilters = {@ComponentScan.Filter(classes = {Controller.class})}
//)
public class Application extends SpringBootServletInitializer implements EmbeddedServletContainerCustomizer {


    public static void main(String[] args) {
        new SpringApplicationBuilder(Application.class).initializers(new YamlFileApplicationContextInitializer()).run(args);
    }

    @Override
    public void customize(ConfigurableEmbeddedServletContainer container) {
        container.setPort(8188);
    }


    public Application() {
        super();
//        setRegisterErrorPageFilter(true); // <- this one
    }

    @Bean
    public  ErrorPageFilter initErrorPageFilter() {
        ErrorPageFilter filter = new ErrorPageFilter();
        filter.addErrorPages(new ErrorPage(HttpStatus.NOT_FOUND,"/error/404"));
        return filter;
    }

    @Override
    protected SpringApplicationBuilder configure(SpringApplicationBuilder application) {
        return application.sources(Application.class).initializers(new YamlFileApplicationContextInitializer());
    }
}
