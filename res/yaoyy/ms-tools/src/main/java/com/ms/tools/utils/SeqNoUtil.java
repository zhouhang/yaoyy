package com.ms.tools.utils;

import java.util.Date;
import java.util.Random;

/**
 * 序列数工具类
 * Created by wangbin on 2016/6/30.
 */
public class SeqNoUtil {
	
	private static String XEGER_PWD = "[a-zA-Z]{1}[a-zA-Z0-9]{5,19}";
	
    private SeqNoUtil(){};
    

    
    /**
     * 生成指定位数的随机数
     * @param length
     * @return
     */
    public static String getRandomNum(int length){
        Random random = new Random();
        StringBuffer sb = new StringBuffer();
        for(int i=0;i<length;i++){
            sb.append( random.nextInt(10));
        }
        return sb.toString();
    }




    public static final String get(String prefix, Integer id, int len){
        String seq=id+"";
        for(int i=seq.length(); i<len;i++){
            seq="0"+seq;
        }
        return prefix+DateUtils.dateToStringWithFormat(new Date(), "yyyyMMddHHmm")+seq;
    }

    // 订单Code
    public static  String getOrderCode() {
        return System.currentTimeMillis()/1000 + getRandomNum(2);
    }

    // 账单Code
    public static String getBillCode() {
        return "Z" + System.currentTimeMillis()/1000 + getRandomNum(2);
    }

    // 寄样单Code
    public static String getSampleCode() {
        return "S" + System.currentTimeMillis()/1000 + getRandomNum(2);
    }

    //paymentCode
    public static String getPaymentCode(){return "P" + System.currentTimeMillis()/1000 + getRandomNum(2);}



}
