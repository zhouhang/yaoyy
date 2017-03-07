package com.ms.service.sms;

import org.apache.commons.lang.ArrayUtils;

/**
 * 验证码模板
 * Created by wangbin on 2016/6/30.
 */
public enum TextTemplateEnum {

    SMS_BIZ_CAPTCHA("{1}您的验证码是{2},该验证码在30分钟内有效."),
    SMS_SAMPLE_APPLY("{1}您提交了一个寄样申请，商品：{2}，我们会在三十分钟内给您回复。"), // 用户提交寄样申请确认短信
    SMS_SAMPLE_CONFIRM("{1} [{2}]您好，您提交的寄样申请已审核通过，我们会马上为您寄送样品。"), // 客服确认寄样申请有效通知客户
    SMS_BOSS_SAMPLE_SEND("{1} [{2}]用户提交了{3}寄样申请,请速联系."),
    SMS_BIZ_BANK_INFO("{1}您的订货订单{2}需要支付{3}，汇款账户：{4}，账号：{5}，开户行：{6} 请在汇款留言栏填写如下内容：{7}"),
    SMS_BOSS_SUPPLIER_SIGN("【药优优】恭喜您，已成为药优优签约供应商。您可以在药优优公众号左侧供应商管理菜单看到您的订单情况，以及对您的商品进行调价。第一次使用请用您的账号：{1}和密码：{2} 进行登录。");

    private String value;

    TextTemplateEnum(String value){
        this.value = value;
    }

    /**
     * 根据所传数组值来替换模板变量
     * @param params
     * @return
     */
    public String getText(String... params ){
        String text = new String(this.value);
        if(!ArrayUtils.isEmpty(params)){
            for(int i=0;i<params.length;i++){
                String temKey = "{"+(i+1)+"}";
                String temVal = params[i];
                text = text.replace(temKey,temVal);
            }
        }
        return text;
    }
}
