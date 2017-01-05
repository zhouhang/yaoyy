package com.ms.dao.vo;

import com.ms.dao.enums.IdentityTypeEnum;
import com.ms.dao.model.AccountBill;

import java.math.BigDecimal;
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

    private PickVo pickVo;

    // 待支付金额
    private float unpaid;

    public PickVo getPickVo() {
        return pickVo;
    }

    public void setPickVo(PickVo pickVo) {
        this.pickVo = pickVo;
    }

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

    public Float getUnpaid() {
        BigDecimal b1 = new BigDecimal(Float.toString(getAmountsPayable()));
        BigDecimal b2 = new BigDecimal(Float.toString(getAlreadyPayable()));
        unpaid = Float.valueOf(b1.subtract(b2).setScale(2, BigDecimal.ROUND_HALF_UP).toString());
        return unpaid ;
    }

    public void setUnpaid(float unpaid) {
        this.unpaid = unpaid;
    }
}