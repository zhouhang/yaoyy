package com.ms.biz.controller;

import com.alibaba.druid.support.json.JSONUtils;
import com.alipay.api.AlipayClient;
import com.alipay.api.DefaultAlipayClient;
import com.alipay.api.request.AlipayTradeWapPayRequest;
import com.ms.biz.properties.AliPayProperties;
import org.apache.commons.io.IOUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;

/**
 * Created by wangbin on 2017/1/3.
 */
@Controller
@RequestMapping("alipay/")
public class AliPayController {

    @Autowired
    private AliPayProperties aliPayProperties;

    @RequestMapping(value = "index")
    public String index(){

        return "alipay_test";
    }

    @RequestMapping(value = "pay")
    public void pay(HttpServletRequest request,
                    HttpServletResponse response,
                    String outTradeNo,
                    Double totalAmount,
                    String body,
                    String subject) throws Exception{
        Map<String,Object> params = new HashMap<>();
        params.put("out_trade_no",outTradeNo);
        params.put("total_amount",totalAmount);
        params.put("subject",subject);
        params.put("body",body);
        params.put("product_code","QUICK_WAP_PAY");
        params.put("seller_id",aliPayProperties.getSellerId());
        String content =  JSONUtils.toJSONString(params);
        AlipayClient alipayClient = new DefaultAlipayClient("https://openapi.alipay.com/gateway.do",aliPayProperties.getAppId(),aliPayProperties.getPrivate_key(),"json",aliPayProperties.getCharset(),aliPayProperties.getPublic_key(),"RSA2");
        AlipayTradeWapPayRequest alipayRequest = new AlipayTradeWapPayRequest();//创建API对应的request
        alipayRequest.setReturnUrl("http://test.sankobuy.com:8080"); //回调页面
        alipayRequest.setNotifyUrl("http://test.sankobuy.com:8080/alipay/callback");//在公共参数中设置回跳和通知地址
        alipayRequest.setBizContent(content);//填充业务参数
        String form = alipayClient.pageExecute(alipayRequest).getBody(); //调用SDK生成表单
        response.setContentType("text/html;charset=" + aliPayProperties.getCharset());
        response.getWriter().write(form);//直接将完整的表单html输出到页面
        response.getWriter().flush();
    }

    //https://doc.open.alipay.com/docs/doc.htm?treeId=203&articleId=105285&docType=1
    @RequestMapping(value = "callback")
    public void callBack(HttpServletRequest request,
                         HttpServletResponse response)throws Exception{
        //获取返回所有参数
        StringBuilder params = new StringBuilder();
        for(Map.Entry<String, String[]> entry : request.getParameterMap().entrySet()){
            params.append(entry.getKey()).append(Arrays.asList(entry.getValue()).toString());
        }
        String result =params.toString();
        System.out.println(result);
    }


}
