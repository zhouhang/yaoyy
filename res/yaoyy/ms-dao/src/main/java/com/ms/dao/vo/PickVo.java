package com.ms.dao.vo;

import com.ms.dao.enums.BizPickEnum;
import com.ms.dao.enums.PickEnum;
import com.ms.dao.model.Commodity;
import com.ms.dao.model.OrderInvoice;
import com.ms.dao.model.Pick;
import com.ms.dao.observer.OrderStatusEvent;
import com.ms.tools.utils.SpringUtil;

import java.util.Calendar;
import java.util.Date;
import java.util.List;


public class PickVo extends Pick{



    private String statusText;

    private String bizStatusText;

    public String getBizStatusText() {
        return BizPickEnum.findByValue(getStatus());
    }

    public void setBizStatusText(String bizStatusText) {
        this.bizStatusText = bizStatusText;
    }

    private List<PickCommodityVo> pickCommodityVoList;

    private float total;

    // 发票信息
    private OrderInvoice invoice;

    public float getTotal() {
        return total;
    }

    public void setTotal(float total) {
        this.total = total;
    }

    public List<PickCommodityVo> getPickCommodityVoList() {
        return pickCommodityVoList;
    }

    public void setPickCommodityVoList(List<PickCommodityVo> pickCommodityVoList) {
        this.pickCommodityVoList = pickCommodityVoList;
    }


    public String getStatusText() {
        return PickEnum.findByValue(getStatus());
    }

    public void setStatusText(String statusText) {
        this.statusText = statusText;
    }

    public OrderInvoice getInvoice() {
        return invoice;
    }

    public void setInvoice(OrderInvoice invoice) {
        this.invoice = invoice;
    }

    /**
     * 每次显示是
     * 发货后15天自动收货完成订单
     */
    private void aotoComplete() {
        if (getDeliveryDate()!= null && getStatus().equals(PickEnum.PICK_DELIVERIED.getValue())){
            Long intervals = Long.valueOf(10 * 24 * 60 * 60 * 1000L);
            Long currentTime = new Date().getTime();
            Long createTime = this.getDeliveryDate().getTime() + intervals;
            if (createTime <= currentTime) {
                // 如果发货后 15天 订单设置为自动收货
                SpringUtil.getApplicationContext().publishEvent(new OrderStatusEvent(getId(), PickEnum.PICK_FINISH.getValue()));
            }
        }
    }

    /**
     * 订单支付有效期
     * @return
     */
    public void setPickStatus () {
            if (this.getStatus().equals(PickEnum.PICK_PAY.getValue())) {

                Long day = 24 * 60 * 60 * 1000L;
                Long hour = 60 * 60 * 1000L;
                Long minute = 60 * 1000L;
                Calendar now = Calendar.getInstance();
                now.setTime(this.getExpireDate());
                now.set(Calendar.HOUR_OF_DAY, 23);
                now.set(Calendar.MINUTE,59);
                now.set(Calendar.SECOND,59);
                Long expireDate = now.getTime().getTime();
                Long currentTime = new Date().getTime();
                if (expireDate <= currentTime) {
                    // 付款期限已过 设置付款状态为取消
                    this.setStatus(PickEnum.PICK_CANCLE.getValue());
                    SpringUtil.getApplicationContext().publishEvent(new OrderStatusEvent(getId(), PickEnum.PICK_CANCLE.getValue()));
                }
        }
    }



}