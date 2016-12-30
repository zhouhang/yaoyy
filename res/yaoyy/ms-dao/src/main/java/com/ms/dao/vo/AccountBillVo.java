package com.ms.dao.vo;

import com.ms.dao.enums.IdentityTypeEnum;
import com.ms.dao.model.AccountBill;

import java.util.Calendar;
import java.util.Date;

public class AccountBillVo extends AccountBill{

    private String orderCode;//订单号

    private String nickname;

    private String name;

    private String operateName;//操作人

    private String timeLeft;//账期剩余时间

    private Integer userType;

    private String userTypeName;

    public Integer getUserType() {
        return userType;
    }

    public void setUserType(Integer userType) {
        this.userType = userType;
    }

    public String getUserTypeName() {
        return IdentityTypeEnum.get(getUserType());
    }

    public void setUserTypeName(String userTypeName) {
        this.userTypeName = userTypeName;
    }

    public String getOperateName() {
        return operateName;
    }

    public void setOperateName(String operateName) {
        this.operateName = operateName;
    }

    public String getOrderCode() {
        return orderCode;
    }

    public void setOrderCode(String orderCode) {
        this.orderCode = orderCode;
    }

    public String getNickname() {
        return nickname;
    }

    public void setNickname(String nickname) {
        this.nickname = nickname;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    /**
     * 获取剩余还款期限
     * @return
     */
    public String getTimeLeft() {

        if(this.getRepayTime()!=null){
            Long day = 24 * 60 * 60 * 1000L;
            Long hour = 60 * 60 * 1000L;
            Long minute = 60 * 1000L;
            Calendar now = Calendar.getInstance();
            now.setTime(this.getRepayTime());
            now.set(Calendar.HOUR_OF_DAY, 23);
            now.set(Calendar.MINUTE,59);
            now.set(Calendar.SECOND,59);
            Long expireDate = now.getTime().getTime();
            Long currentTime = new Date().getTime();

            Long difference = expireDate - currentTime;
            Long dayS = difference / day;
            // Long hourS = (difference % day) / hour;
            //Long minuteS = ((difference % day) % hour) / minute;
            timeLeft=dayS.intValue() + "天";
        }


        return timeLeft ;
    }

    public void setTimeLeft(String timeLeft) {
        this.timeLeft = timeLeft;
    }
}