package com.ms.biz.exception;

import com.ms.service.exception.BaseGlobalExceptionHandler;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.resource.ResourceUrlProvider;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Created by wangbin on 2016/6/30.
 */
@ControllerAdvice
public class GlobalExceptionHandler  extends BaseGlobalExceptionHandler {

    @Autowired
    private ResourceUrlProvider resourceUrlProvider;


    @ModelAttribute("urls")
    ResourceUrlProvider urls() {
        return this.resourceUrlProvider;
    }


    //500的异常会被这个方法捕获
    @ExceptionHandler(Exception.class)
    @ResponseBody
    public ModelAndView handleError(HttpServletRequest req, HttpServletResponse rsp, Exception e) throws Exception  {
        ModelAndView modelAndView = super.handleError(req, rsp, e,"/error/500", HttpStatus.INTERNAL_SERVER_ERROR);
        if(modelAndView!=null){
            modelAndView.addObject("urls",this.resourceUrlProvider);
        }
        return modelAndView;
    }




}
