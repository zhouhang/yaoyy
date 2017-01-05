package com.ms.biz.controller.advice;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.servlet.resource.ResourceUrlProvider;

/**
 * Author: koabs
 * 1/5/17.
 */
@ControllerAdvice
public class ResourceUrlProvideAdvice {

    @Autowired
    private ResourceUrlProvider resourceUrlProvider;

    @ModelAttribute("urls")
    ResourceUrlProvider urls() {
        return this.resourceUrlProvider;
    }
}
