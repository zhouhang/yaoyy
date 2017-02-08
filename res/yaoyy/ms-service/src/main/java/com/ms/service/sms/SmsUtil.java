package com.ms.service.sms;

import com.ms.dao.enums.SettleTypeEnum;
import com.ms.dao.model.Pick;
import com.ms.dao.model.Setting;
import com.ms.dao.model.User;
import com.ms.service.enums.RedisEnum;
import com.ms.service.properties.SystemProperties;
import com.ms.service.redis.RedisManager;
import com.ms.tools.httpclient.HttpClientUtil;
import com.ms.tools.httpclient.common.HttpConfig;
import com.ms.tools.utils.SeqNoUtil;
import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

/**
 * 短信服务类
 * Created by wangbin on 2016/6/29.
 */
@Component
public class SmsUtil {

    private static final int SMS_EXPIRE_TIME = 30*60;//秒

    private static final int SMS_INTERVAL_TIME = 60 * 1000;//秒

    private static final Logger logger = Logger.getLogger(SmsUtil.class);


    private boolean enable = false;

    private final String smsUrl = "https://sms.yunpian.com/v2/sms/single_send.json";

    @Autowired
    private RedisManager redisManager;

    @Autowired
    private SystemProperties systemProperties;

    /**
     * 发送登入验证码
     * @param mobile
     * @return
     * @throws Exception
     */
    public String sendLoginCaptcha(String mobile) throws Exception {

        check(mobile);

        //生成并发送验证码
        String code = SeqNoUtil.getRandomNum(4);

        Map<String, Object> param = new HashMap<>();
        param.put("apikey", systemProperties.getApikey());
        param.put("mobile", mobile);
        param.put("text", TextTemplateEnum.SMS_BIZ_CAPTCHA.getText("【药优优】", code));

        HttpClientUtil.post(HttpConfig.custom().url(smsUrl).map(param));
        //记录发送成功的时间
        redisManager.set(RedisEnum.KEY_MOBILE_CAPTCHA_INTERVAL.getValue()+mobile,new Date().getTime()+"");
        //验证码存储在redis缓存里
        redisManager.set(RedisEnum.KEY_MOBILE_CAPTCHA_LOGIN.getValue()+mobile,code,SMS_EXPIRE_TIME);
        return code;
    }

    /**
     * 发送注册验证码
     * @param mobile
     * @return
     * @throws Exception
     */
    public String sendRegistCaptcha(String mobile) throws Exception {
        check(mobile);

        //生成并发送验证码
        String code = SeqNoUtil.getRandomNum(4);

        Map<String, Object> param = new HashMap<>();
        param.put("apikey", systemProperties.getApikey());
        param.put("mobile", mobile);
        param.put("text", TextTemplateEnum.SMS_BIZ_CAPTCHA.getText("【药优优】", code));

        HttpClientUtil.post(HttpConfig.custom().url(smsUrl).map(param));
        //记录发送成功的时间
        redisManager.set(RedisEnum.KEY_MOBILE_CAPTCHA_INTERVAL.getValue()+mobile,new Date().getTime()+"");
        //验证码存储在redis缓存里
        redisManager.set(RedisEnum.KEY_MOBILE_CAPTCHA_REGISTER.getValue()+mobile,code,SMS_EXPIRE_TIME);
        return code;
    }

    /**
     * 重设密码短信
     * @param mobile
     * @return
     * @throws Exception
     */
    public String sendResetPasswordSms(String mobile) throws Exception {

        check(mobile);

        //生成并发送验证码
        String code = SeqNoUtil.getRandomNum(4);

        Map<String, Object> param = new HashMap<>();
        param.put("apikey", systemProperties.getApikey());
        param.put("mobile", mobile);
        param.put("text", TextTemplateEnum.SMS_BIZ_CAPTCHA.getText("【药优优】", code));

        HttpClientUtil.post(HttpConfig.custom().url(smsUrl).map(param));
        //记录发送成功的时间
        redisManager.set(RedisEnum.KEY_MOBILE_CAPTCHA_INTERVAL.getValue()+mobile,new Date().getTime()+"");
        //验证码存储在redis缓存里
        redisManager.set(RedisEnum.KEY_MOBILE_RESET_PASSWORD.getValue()+mobile,code,SMS_EXPIRE_TIME);
        return code;
    }

    /**
     * 发送寄样通知短信
     * @param commodityInfo
     * @param mobile
     * @throws Exception
     */
    public void sendSample(String commodityInfo,String mobile) throws Exception {
        Map<String, Object> param = new HashMap<>();
        param.put("apikey", systemProperties.getApikey());
        param.put("mobile", mobile);
        param.put("text", TextTemplateEnum.SMS_SAMPLE_APPLY.getText("【药优优】",commodityInfo));
        HttpClientUtil.post(HttpConfig.custom().url(smsUrl).map(param));
    }

    /**
     * 寄样申请通过通知客户
     * @param text
     * @param mobile
     * @throws Exception
     */
    public void sendSampleConfirm(String text,String mobile) throws Exception {
        Map<String, Object> param = new HashMap<>();
        param.put("apikey", systemProperties.getApikey());
        param.put("mobile", mobile);
        param.put("text", TextTemplateEnum.SMS_SAMPLE_CONFIRM.getText("【药优优】",text));
        HttpClientUtil.post(HttpConfig.custom().url(smsUrl).map(param));
    }

    /**
     * 发送客服确认订单短信
     * @param mobile
     * @throws Exception
     */
    public void sendPickConfirm(String text,String mobile) throws Exception {
        Map<String, Object> param = new HashMap<>();
        param.put("apikey", systemProperties.getApikey());
        param.put("mobile", mobile);
        param.put("text", text);
        HttpClientUtil.post(HttpConfig.custom().url(smsUrl).map(param));
    }

    /**
     * 给客服发送转账信息
     * @param setting
     * @param code
     * @param total
     * @param mobile
     * @throws Exception
     */
    public void sendBankInfo(Setting setting, String code, String total, String mobile) throws Exception {
        // 【药优优】 您的订货订单{2014414147}需要支付{500元}，汇款账户：亳州东方康元中药材信息有限公司，账号：1109 0795 0110 201 ，开户行：中国银行魏武大道支行   请在汇款留言栏填写如下内容：{“客户：张三，订单号：20144141474 汇款”}
        // 您的订货订单#code#需要支付#total#，汇款账户：#payAccount#，账号：#payBankCard#，开户行：#payBank# 请在汇款留言栏填写如下内容：#remark#
        String remark = "“订单号："+code +"汇款”";
        Map<String, Object> param = new HashMap<>();
        param.put("apikey", systemProperties.getApikey());
        param.put("mobile", mobile);
        param.put("text", TextTemplateEnum.SMS_BIZ_BANK_INFO.getText("【药优优】",code,total,setting.getPayAccount(),
                setting.getPayBankCard(),setting.getPayBank(),remark));
        HttpClientUtil.post(HttpConfig.custom().url(smsUrl).map(param));
    }

    /**
     * 一个手机号一分钟之内只能发送1条短信；
     * 一个手机号三十分钟只能发送三次验证码；
     * @param mobile
     */
    public void check(String mobile){
        String timerStr = redisManager.get(RedisEnum.KEY_MOBILE_TIMER.getValue()+mobile);
        String intervalTimeStr = redisManager.get(RedisEnum.KEY_MOBILE_CAPTCHA_INTERVAL.getValue()+mobile);
        if(StringUtils.isNotBlank(timerStr)){
            if(StringUtils.isNotBlank(intervalTimeStr)){
                Long intervalTime =  Long.valueOf(intervalTimeStr) + SMS_INTERVAL_TIME;
                if(new Date().getTime()<intervalTime){
                    throw new RuntimeException("'"+mobile+"',该手机号请求短信间隔太快!");
                }
            }
            Integer timer =  Integer.valueOf(timerStr);
            if(timer>=3){
                throw new RuntimeException("'"+mobile+"',该手机号短信发送次数超标!");
            }else{
                redisManager.set(RedisEnum.KEY_MOBILE_TIMER.getValue()+mobile,(timer+1)+"",SMS_EXPIRE_TIME);
            }
        }else{
            redisManager.set(RedisEnum.KEY_MOBILE_TIMER.getValue()+mobile,"1",SMS_EXPIRE_TIME);
        }
    }


}
