package com.ms.biz.properties;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

/**
 * Created by wangbin on 2017/1/3.
 */
@Component
public class AliPayProperties {

    @Value("${alipay.appId}")
    private String appId ;

    @Value("${alipay.privateKey}")
    private String privateKey ;

    private String charset = "UTF-8";

    @Value("${alipay.publicKey}")
    private String publicKey ;

    @Value("${alipay.sellerId}")
    private String sellerId ;

    public String getAppId() {
        return appId;
    }

    public String getPrivateKey() {
        return privateKey;
    }

    public String getCharset() {
        return charset;
    }

    public String getPublicKey() {
        return publicKey;
    }

    public String getSellerId() {
        return sellerId;
    }


}
