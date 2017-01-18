package com.ms.service.properties;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

/**
 * Created by wangbin on 2017/1/3.
 */
@Component
@ConfigurationProperties(locations="classpath:config.yml",prefix = "alipay")
public class AliPayProperties {


    private String appId;

    private String privateKey ;

    private String charset = "UTF-8";

    private String publicKey ;

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

    public void setAppId(String appId) {
        this.appId = appId;
    }

    public void setPrivateKey(String privateKey) {
        this.privateKey = privateKey;
    }

    public void setCharset(String charset) {
        this.charset = charset;
    }

    public void setPublicKey(String publicKey) {
        this.publicKey = publicKey;
    }

    public void setSellerId(String sellerId) {
        this.sellerId = sellerId;
    }
}
