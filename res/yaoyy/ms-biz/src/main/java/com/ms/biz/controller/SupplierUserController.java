package com.ms.biz.controller;

import com.google.common.base.Strings;
import com.ms.biz.shiro.BizToken;
import com.ms.dao.model.User;
import com.ms.service.UserService;
import com.ms.tools.entity.Result;
import me.chanjar.weixin.mp.api.WxMpService;
import me.chanjar.weixin.mp.bean.result.WxMpOAuth2AccessToken;
import me.chanjar.weixin.mp.bean.result.WxMpUser;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.subject.Subject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;

/**
 * Author: koabs
 * 3/6/17.
 */
@RequestMapping("user/supplier")
@Controller
public class SupplierUserController {

    Logger logger = LoggerFactory.getLogger(SupplierUserController.class);

    @Autowired
    private WxMpService wxService;

    @Autowired
    UserService userService;

    @Autowired
    HttpSession httpSession;

    /**
     * 登入
     * 1. 判断用户来源微信还是手机网页
     * 2. 微信判断用户是否注册,已经注册过的直接跳转到首页
     * 3. 未注册的 跳转到登入页
     * @return
     */
    @RequestMapping(value = "login", method = RequestMethod.GET)
    public String loginPage(String call, String code, ModelMap model) {
        if (!Strings.isNullOrEmpty(code)) {
            try {
                WxMpOAuth2AccessToken wxMpOAuth2AccessToken = wxService.oauth2getAccessToken(code);
                WxMpUser wxMpUser = wxService.oauth2getUserInfo(wxMpOAuth2AccessToken, null);

                User user = userService.findByOpenId(wxMpUser.getOpenId());
                if (user != null) {
                    // 登入
                    Subject subject = SecurityUtils.getSubject();
                    BizToken token = new BizToken(user.getPhone(), user.getPassword(), false, null, "");
                    token.setOpenId(user.getOpenid());
                    userService.login(subject, token);

                    if (!Strings.isNullOrEmpty(call)) {
                        return "redirect:" + call;
                    } else {
                        return "redirect:/supplier/index";
                    }
                }

                //保存微信信息到Session 里面
                httpSession.setAttribute("wxMpUser",wxMpUser);

            } catch (Exception e) {
                logger.error(e.getMessage());
            }
        }

        return "supplier/login";
    }


    /**
     * 用户登入
     * @param phone
     * @param password
     * @return
     */
    @RequestMapping(value = "login", method = RequestMethod.POST)
    @ResponseBody
    public Result login(String phone, String password) {
        WxMpUser wxMpUser = (WxMpUser)httpSession.getAttribute("wxMpUser");
        // 获取用户登入的微信信息 存在的话就把微信信息保存到用户表中
        // 登陆验证
        Subject subject = SecurityUtils.getSubject();
        BizToken token = new BizToken(phone, password, false, null, null);
        userService.login(subject, token, wxMpUser);
        httpSession.removeAttribute("wxMpUser");
        return Result.success().data("/supplier");
    }

    /**
     * 找回密码
     * @return
     */
    @RequestMapping(value = "findPassword", method = RequestMethod.GET)
    public String findPassword() {
        return "supplier/find_password";
    }

    /**
     * 重置密码
     * @param phone
     * @param password
     * @param code
     * @return
     */
    @RequestMapping(value = "findPassword", method = RequestMethod.POST)
    @ResponseBody
    public Result resetPassword(String phone, String password,String code) {
        //TODO: 安全性待验证
        userService.resetPassword(phone, code, password);
        return Result.success("密码重置成功");
    }

    /**
     * 发送重置密码短信
     * @param phone
     * @return
     */
    @RequestMapping(value = "sendFindPasswordSms", method = RequestMethod.POST)
    @ResponseBody
    public Result sendResetPasswordSms(String phone) {
        userService.sendResetPasswordSms(phone);
        return Result.success("验证码发送成功");
    }



    /**
     * 供应商入驻
     * @return
     */
    @RequestMapping(value = "register", method = RequestMethod.GET)
    public String register() {
        return "supplier/register";
    }


}
