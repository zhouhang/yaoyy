package com.ms.biz.controller;

import com.google.common.base.Strings;
import com.ms.biz.shiro.BizToken;
import com.ms.dao.enums.UserTypeEnum;
import com.ms.dao.model.User;
import com.ms.dao.vo.SupplierVo;
import com.ms.service.SupplierService;
import com.ms.service.UserService;
import com.ms.service.enums.RedisEnum;
import com.ms.service.redis.RedisManager;
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

    @Autowired
    SupplierService supplierService;

    @Autowired
    private RedisManager redisManager;

    /**
     * 登入
     * 1. 判断用户来源微信还是手机网页
     * 2. 微信判断用户是否注册,已经注册过的直接跳转到首页
     * 3. 未注册的 跳转到登入页
     * @return
     */
    @RequestMapping(value = "login", method = RequestMethod.GET)
    public String loginPage(String call, String code) {
        if (!Strings.isNullOrEmpty(code)) {
            try {
                WxMpOAuth2AccessToken wxMpOAuth2AccessToken = wxService.oauth2getAccessToken(code);
                WxMpUser wxMpUser = wxService.oauth2getUserInfo(wxMpOAuth2AccessToken, null);

                User user = userService.findByOpenId(wxMpUser.getOpenId());
                if (user != null && user.getType() == UserTypeEnum.supplier.getType()) {
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
    public Result login(String phone, String password,String openId, String nikeName, String headImgUrl ) {
        // 获取用户登入的微信信息 存在的话就把微信信息保存到用户表中
        // 登陆验证
        WxMpUser wxMpUser = (WxMpUser)httpSession.getAttribute("wxMpUser");
        Subject subject = SecurityUtils.getSubject();
        BizToken token = new BizToken(phone, password, false, null, null);
        userService.login(subject, token, wxMpUser);
        httpSession.removeAttribute("wxMpUser");
        return Result.success().data("/supplier/index");
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
        return Result.success("密码重置成功").data("user/supplier/login");
    }

    /**
     * 发送重置密码短信
     * @param phone
     * @return
     */
    @RequestMapping(value = "sendFindPasswordSms", method = RequestMethod.POST)
    @ResponseBody
    public Result sendResetPasswordSms(String phone) {
        // 发送短信前 得先确认手机号在数据库中存在且用户type 为供应商

        User user = userService.findByPhone(phone);
        if (user == null || user.getType() != UserTypeEnum.supplier.getType()) {
            return Result.error().msg("用户不存在");
        }
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

    /**
     * 1.供应商表已经存在提示审核中
     * 2.不存在直接保存
     * @param supplier
     * @return
     */
    @RequestMapping(value = "register", method = RequestMethod.POST)
    @ResponseBody
    public Result saveRegister(SupplierVo supplier) {
        Result result = Result.success().data("/user/supplier/registerSuccess");
        // 1. 先去User里面查询手机号如果存在叫用户去登入
        // 2. 查询Supplier 表.存在告诉用户正在审核中请稍后
        // 3. 把数据插入到Supplier 表中,入驻完成跳转到二维码页面
        if (!supplierService.register(supplier)){
            result = result.error().msg("您的信息已登记，正在审核中，无需重复登记.");
        }
        return result;
    }


    @RequestMapping(value = "registerSuccess", method = RequestMethod.GET)
    public String registerSuccess() {
        return "supplier/register_success";
    }

    /**
     * 供应商注册

     * @return
     */
    @RequestMapping(value = "join", method = RequestMethod.GET)
    public String join() {
        return "supplier/join";
    }

    @RequestMapping(value = "join", method = RequestMethod.POST)
    @ResponseBody
    public Result saveJoin(SupplierVo supplier,String code) {


        String rcode = redisManager.get(RedisEnum.KEY_MOBILE_CAPTCHA_REGISTER.getValue()+supplier.getPhone());

        Result result = Result.success().data("/user/supplier/registerSuccess");

        if (!code.equalsIgnoreCase(rcode)) {
            result = result.error().msg("验证码错误");
        }
        else{
            // 1. 先去user里面插入
            // 2. 再去supplier表插入
            // 3. 入驻完成跳转到二维码页面
            if (!supplierService.register(supplier)){
                result = result.error().msg("您的信息已登记，正在审核中，无需重复登记.");
            }
        }

        return result;

    }


}
