package com.ms.biz.controller;

import com.ms.biz.properties.BizSystemProperties;
import com.ms.biz.shiro.BizToken;
import com.ms.dao.enums.PayTypeEnum;
import com.ms.dao.enums.SettleTypeEnum;
import com.ms.dao.model.Member;
import com.ms.dao.model.Payment;
import com.ms.dao.model.User;
import com.ms.dao.vo.AccountBillVo;
import com.ms.dao.vo.PaymentVo;
import com.ms.dao.vo.PickVo;
import com.ms.service.*;
import com.ms.service.enums.RedisEnum;
import com.ms.service.properties.WechatProperties;
import com.ms.service.redis.RedisManager;
import com.ms.tools.entity.Result;
import com.ms.tools.utils.SeqNoUtil;
import com.ms.tools.utils.WebUtil;
import me.chanjar.weixin.common.api.WxConsts;
import me.chanjar.weixin.common.bean.WxJsapiSignature;
import me.chanjar.weixin.mp.api.WxMpPayService;
import me.chanjar.weixin.mp.api.WxMpService;
import me.chanjar.weixin.mp.bean.kefu.WxMpKefuMessage;
import me.chanjar.weixin.mp.bean.pay.WxPayJsSDKCallback;
import me.chanjar.weixin.mp.bean.pay.request.WxPayUnifiedOrderRequest;
import me.chanjar.weixin.mp.bean.result.WxMpOAuth2AccessToken;
import me.chanjar.weixin.mp.bean.result.WxMpUser;
import org.apache.commons.io.IOUtils;
import org.apache.commons.lang3.StringUtils;
import org.apache.log4j.Logger;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.PrincipalCollection;
import org.apache.shiro.subject.SimplePrincipalCollection;
import org.apache.shiro.subject.Subject;
import org.apache.shiro.util.ThreadContext;
import org.apache.shiro.web.subject.WebSubject;
import org.elasticsearch.common.collect.HppcMaps;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.Date;
import java.util.Map;

/**
 * Created by wangbin on 2016/10/28.
 */
@Controller
@RequestMapping("wechat")
public class WechatController extends BaseController {

    private static final Logger logger = Logger.getLogger(WechatController.class);

    @Autowired
    private RedisManager redisManager;
    @Autowired
    private WxMpService wxService;
    @Autowired
    private UserService userService;
    @Autowired
    private BizSystemProperties systemProperties;
    @Autowired
    private HttpSession httpSession;

    @Autowired
    private MemberService memberService;

    @Autowired
    private PickService pickService;

    @Autowired
    private AccountBillService accountBillService;

    @Autowired
    private PaymentService paymentService;

    @Autowired
    private WechatProperties wechatProperties;


    /**
     * 接入微信公众号
     *
     * @param response
     * @param signature
     * @param timestamp
     * @param nonce
     * @param echostr
     */
    @RequestMapping(path = "init", method = RequestMethod.GET)
    @ResponseBody
    public void authGet(HttpServletResponse response,
                        @RequestParam(name = "signature", required = false) String signature,
                        @RequestParam(name = "timestamp", required = false) String timestamp,
                        @RequestParam(name = "nonce", required = false) String nonce,
                        @RequestParam(name = "echostr", required = false) String echostr) {
        logger.info("接收微信signature:" + signature + ",timestamp:" + timestamp + ",nonce:" + nonce + "echostr:" + echostr);
        if (StringUtils.isAnyBlank(signature, timestamp, nonce, echostr)) {
            throw new IllegalArgumentException("请求参数非法，请核实~");
        }
        if (this.wxService.checkSignature(timestamp, nonce, signature)) {
            WebUtil.print(response, echostr);
        }
        WebUtil.print(response, "非法请求");

    }


    /**
     * 绑定微信到后台管理员
     *
     * @param code
     * @return
     */
    @RequestMapping("member")
    public String memberBind(String code,
                             Integer memberId,
                             HttpServletResponse response,
                             ModelMap model) {
        String modelName = "wechat_member";
        try {
            if (code == null) {
                String wechatLoginUrl = systemProperties.getBaseUrl() + "/wechat/member?memberId=" + memberId.toString();
                String OAUTH_URL = wxService.oauth2buildAuthorizationUrl(wechatLoginUrl, WxConsts.OAUTH2_SCOPE_USER_INFO, "weixin_state");
                response.sendRedirect(OAUTH_URL);
            }


            WxMpOAuth2AccessToken wxMpOAuth2AccessToken = wxService.oauth2getAccessToken(code);
            WxMpUser wxMpUser = wxService.oauth2getUserInfo(wxMpOAuth2AccessToken, null);
            Member member = memberService.findById(memberId);
            if (member.getOpenid() == null || member.getOpenid().equals("")) {
                model.put("headImgUrl", wxMpUser.getHeadImgUrl());
                model.put("nickname", wxMpUser.getNickname());
                model.put("openId", wxMpUser.getOpenId());
                model.put("memberName", member.getName());
                model.put("memberId", member.getId());
            } else {
                model.put("memberName", member.getName());
                modelName = "bind_success";
            }

        } catch (Exception e) {
            logger.error(e);
        }
        return modelName;
    }

    @RequestMapping("memberBind")
    @ResponseBody
    public Result bindPhone(HttpServletResponse response,
                            HttpServletRequest request,
                            String openId,
                            Integer memberId
    ) {

        Member member = new Member();
        member.setId(memberId);
        member.setOpenid(openId);
        memberService.update(member);
        return Result.success("绑定成功").data(memberId);
    }

    @RequestMapping("bindsuccess")
    public String bindsuccess(
            Integer memberId,
            ModelMap model) {
        Member member = memberService.findById(memberId);
        model.put("memberName", member.getName());
        return "bind_success";
    }


    /**
     * 跳转到微信登陆页面（绑定微信和手机号）
     *
     * @param request
     * @param response
     * @param call
     * @param code
     * @param model
     * @return
     */
    @RequestMapping("login")
    public String login(HttpServletRequest request,
                        HttpServletResponse response,
                        String call,
                        String code,
                        ModelMap model) {
        try {
            WxMpOAuth2AccessToken wxMpOAuth2AccessToken = wxService.oauth2getAccessToken(code);
            WxMpUser wxMpUser = wxService.oauth2getUserInfo(wxMpOAuth2AccessToken, null);

            User user = userService.findByOpenId(wxMpUser.getOpenId());
            if (user != null) {
                autoLogin(user);
                if (StringUtils.isNotBlank(call)) {
                    return "redirect:" + call;
                } else {
                    return "redirect:/center/index";
                }
            }
            model.put("headImgUrl", wxMpUser.getHeadImgUrl());
            model.put("nickname", wxMpUser.getNickname());
            model.put("openId", wxMpUser.getOpenId());
            model.put("call", call);
        } catch (Exception e) {
            logger.error(e);
            return "redirect:/user/login";
        }
        return "wechat_login";
    }


    /**
     * 通过页面表单信息注册用户并登陆
     *
     * @param response
     * @param request
     * @param callUrl
     * @param phone
     * @param code
     * @param openId
     * @param nickname
     * @param headImgUrl
     * @return
     * @throws Exception
     */
    @RequestMapping("bind")
    @ResponseBody
    public Result bindPhone(HttpServletResponse response,
                            HttpServletRequest request,
                            String callUrl,
                            String phone,
                            String code,
                            String openId,
                            String nickname,
                            String headImgUrl) throws Exception {
        String rcode = redisManager.get(RedisEnum.KEY_MOBILE_CAPTCHA_REGISTER.getValue() + phone);
        if (!code.equalsIgnoreCase(rcode)) {
            return Result.error().msg("验证码错误!");
        }
        User user = userService.registerWechat(phone, openId, nickname, headImgUrl);
        autoLogin(user);

        return Result.success("绑定成功").data(callUrl);
    }


    /**
     * 实现shiro自动登录(并未绑定到redis)
     *
     * @param user
     */
    public void autoLogin(User user) {
        Subject subject = SecurityUtils.getSubject();
        BizToken token = new BizToken(user.getPhone(), user.getPassword(), false, null, "");
        token.setOpenId(user.getOpenid());
        userService.login(subject, token);
    }


    @RequestMapping("test")
    public String test(HttpServletRequest request,
                       HttpServletResponse response,
                       ModelMap model) throws Exception {
        String url = request.getRequestURL().toString();
        System.out.println("url:" + url);
        WxJsapiSignature signature = wxService.createJsapiSignature(url);
        model.put("signature", signature);
        return "wechat_test";
    }


    @RequestMapping("send")
    public void send() {
        try {
            WxMpKefuMessage message = WxMpKefuMessage
                    .TEXT()
                    .toUser("oQmRps5sNt0QHgYpqGggc2xqRQB0")
                    .content("sfsfdsdf")
                    .build();
            wxService.getKefuService().sendKefuMessage(message);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    //调用微信支付,如果是订单支付传orderId,账单支付传billId
    @RequestMapping("pay")
    @ResponseBody
    public Result pay(HttpServletRequest request, Integer orderId, Integer billId) throws Exception {
        User user = (User) httpSession.getAttribute(RedisEnum.USER_SESSION_BIZ.getValue());
        WxPayUnifiedOrderRequest orderRequest = new WxPayUnifiedOrderRequest();
        Payment payment = new Payment();
        payment.setUserId(user.getId());
        payment.setPayType(PayTypeEnum.WXPAY.getType());

        if (orderId != null) {
            PickVo pick = pickService.findVoById(orderId);
            orderRequest.setBody("药优优订单支付");
            orderRequest.setNotifyURL(systemProperties.getBaseUrl() + "/wechat/pay/callback");
            payment.setType(0);
            payment.setOrderId(orderId);
            if (pick.getSettleType() == SettleTypeEnum.SETTLE_ALL.getType()) {
                orderRequest.setTotalFee((int) (pick.getAmountsPayable() * 100));//元转成分
                payment.setMoney(pick.getAmountsPayable());
            } else if (pick.getSettleType() == SettleTypeEnum.SETTLE_DEPOSIT.getType()) {
                orderRequest.setTotalFee((int) (pick.getDeposit() * 100));
                payment.setMoney(pick.getDeposit());
            }


        } else if (billId != null) {
            AccountBillVo accountBillVo = accountBillService.findVoById(billId);
            orderRequest.setBody("药优优账单支付");
            orderRequest.setNotifyURL(systemProperties.getBaseUrl() + "/wechat/pay/callback");
            payment.setType(1);
            payment.setBillId(billId);
            Float total = accountBillVo.getAmountsPayable() - accountBillVo.getAlreadyPayable();
            orderRequest.setTotalFee((int) (total * 100));//元转成分
            payment.setMoney(total);
        }
        //orderRequest.setTotalFee(1);//测试订单
        String outTradeNo=SeqNoUtil.getPaymentCode();
        orderRequest.setOutTradeNo(outTradeNo);
        payment.setOutTradeNo(outTradeNo);
        orderRequest.setTradeType("JSAPI");
        orderRequest.setOpenid(user.getOpenid());
        orderRequest.setSpbillCreateIp(request.getRemoteAddr());
        WxMpPayService wxMpPayService = wxService.getPayService();
        payment.setOutParam(orderRequest.toString());
        logger.info("微信支付"+orderRequest.toString());
        //返回结果
        Map<String, String> result = wxMpPayService.getPayInfo(orderRequest);
        //创建对应的payment记录
        payment.setStatus(0);
        payment.setCreateTime(new Date());
        paymentService.create(payment);


        return Result.success().data(result);
    }

    //支付成功通知
    @RequestMapping("pay/callback")
    public void payCallBack(HttpServletRequest request,
                            HttpServletResponse response) {
        WxMpPayService wxMpPayService = wxService.getPayService();
        try {
            String xmlResult = IOUtils.toString(request.getInputStream(), request.getCharacterEncoding());
            WxPayJsSDKCallback result = wxMpPayService.getJSSDKCallbackData(xmlResult);
            logger.info("微信支付通知"+result.toString());
            PaymentVo payment=paymentService.getByOutTradeNo(result.getOut_trade_no());
            if(payment!=null&&payment.getCallbackTime()==null){
                payment.setInParam(result.toString());
                payment.setPayAppId(wechatProperties.getAppId());
                if ("SUCCESS".equals(result.getReturn_code())) {
                    //支付成功
                    payment.setStatus(1);
                    pickService.handlePay(payment);
                } else {
                    //支付失败
                    payment.setStatus(2);
                    pickService.handlePay(payment);
                }
            }

            String Result = "<xml>" +
                    "<return_code><![CDATA[SUCCESS]]></return_code>" +
                    "<return_msg><![CDATA[OK]]></return_msg>" +
                    "</xml>";
            WebUtil.print(response, Result);
        } catch (Exception e) {
            logger.error("微信回调结果异常,异常原因{}", e);
        }
    }

}



    //  参考地址  https://pay.weixin.qq.com/wiki/doc/api/jsapi.php?chapter=9_1
    //调用统一下单接口
    /*
    @RequestMapping("pay")
    @ResponseBody
    public Result pay(HttpServletRequest request,
                      HttpServletResponse response,
                      ModelMap model)throws Exception{
        WxPayUnifiedOrderRequest orderRequest = new WxPayUnifiedOrderRequest();
        orderRequest.setBody("支付内容");
        orderRequest.setTradeType("JSAPI");
        orderRequest.setNotifyURL("http://burgleaf.tunnel.2bdata.com/wechat/pay/callback");
        orderRequest.setOutTradeNo(System.currentTimeMillis()+"");
        orderRequest.setTotalFee(1);//元转成分
        orderRequest.setOpenid("oQnHnv7-CXQOiguW9JG8k9Kptq4k");
        orderRequest.setSpbillCreateIp(request.getRemoteAddr());
        WxMpPayService wxMpPayService = wxService.getPayService();
        //返回结果
        Map<String, String> result = wxMpPayService.getPayInfo(orderRequest);
        return Result.success().data(result);
    }

    //支付页面
    @RequestMapping("pay/page")
    public String payPage(HttpServletRequest request,
                          HttpServletResponse response){
        return "pay_test_page";
    }*/

