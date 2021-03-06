package com.ms.biz.controller;

import com.ms.biz.shiro.BizToken;
import com.ms.dao.model.User;
import com.ms.service.UserService;
import com.ms.tools.entity.Result;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.subject.Subject;
import org.apache.shiro.web.util.WebUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

/**
 * Author: koabs
 * 10/25/16.
 * 用户登入
 */
@Controller
@RequestMapping("user/")
public class UserController extends BaseController{

    @Autowired
    HttpSession httpSession;

    @Autowired
    UserService userService;

    /**
     * 账号密码登入页面
     * @return
     */
    @RequestMapping(value = "login", method = RequestMethod.GET)
    public String loginPage() {

        return "login";
    }

    /**
     * 短信验证码登入
     * @return
     */
    @RequestMapping(value = "loginSMS", method = RequestMethod.GET)
    public String loginSMSPage() {
        return "login_sms";
    }

    /**
     * 快速注册
     * @return
     */
    @RequestMapping(value = "register", method = RequestMethod.GET)
    public String registerPage() {
        return "register";
    }

    /**
     * 1. 自动创建的账户禁止登入必须先创建
     * 账号密码登入
     * @param phone
     * @param password
     * @return
     */
    @RequestMapping(value = "login", method = RequestMethod.POST)
    public String login(String phone, String password, ModelMap model, HttpServletRequest request) {
        String url = "/";
        try {
            // 登陆验证
            Subject subject = SecurityUtils.getSubject();
            BizToken token = new BizToken(phone, password, false, null, null);
            userService.login(subject, token);
        } catch (Exception e) {
            model.put("error", e.getMessage());
            model.put("phone",phone);
            return "login";
        }

        if (WebUtils.getSavedRequest(request) != null) {
            url =  WebUtils.getSavedRequest(request).getRequestUrl();;
        }

        return "redirect:" +url;
    }

    /**
     * 登出
     * @return
     */
    @RequestMapping(value = "logout", method = RequestMethod.POST)
    public String loginOut() {
        userService.logout();
        return "redirect:/user/login";
    }

    /**
     * 用户注册
     * 1. 用户注册时账户已经存在把账户由自动创建修改为注册
     * @param phone
     * @param code
     * @param password
     * @param name
     * @return
     */
    @RequestMapping(value = "register", method = RequestMethod.POST)
    public String register(String phone, String code, String password, String name, ModelMap model) {
        try {
            userService.register(phone, code, password, name);
            Subject subject = SecurityUtils.getSubject();
            BizToken token = new BizToken(phone, password, false, null, null);
            userService.login(subject, token);
        } catch (Exception e) {
            model.put("error",e.getMessage());
            model.put("phone",phone);
            return "register";
        }
        return "redirect:/";
    }

    /**
     * 短信登入
     * @param phone
     * @param code
     * @return
     */
    @RequestMapping(value = "loginSMS", method = RequestMethod.POST)
    public String loginSMS(String phone, String code, ModelMap model, HttpServletRequest request) {
        String url = "/";
        try {
            User user = userService.loginSms(phone, code);
            Subject subject = SecurityUtils.getSubject();
            BizToken token = new BizToken(phone, user.getPassword(), false, null, "");
            token.setValidationCode(code);
            userService.login(subject, token);
        } catch (Exception e) {
            model.put("phone",phone);
            model.put("error",e.getMessage());
            return "login_sms";
        }

        if (WebUtils.getSavedRequest(request) != null) {
            url =  WebUtils.getSavedRequest(request).getRequestUrl();;
        }

        return "redirect:"+url;
    }


    @RequestMapping(value = "sendRegistSms", method = RequestMethod.POST)
    @ResponseBody
    public Result sendRegistSms(String phone) {
        userService.sendRegistSms(phone);
        return Result.success("验证码发送成功");
    }

    @RequestMapping(value = "sendLoginSms", method = RequestMethod.POST)
    @ResponseBody
    public Result sendLoginSms(String phone) {
        userService.sendLoginSms(phone);
        return Result.success("验证码发送成功");
    }

}
