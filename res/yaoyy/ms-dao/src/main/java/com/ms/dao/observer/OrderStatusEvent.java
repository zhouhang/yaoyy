package com.ms.dao.observer;

import org.springframework.context.ApplicationEvent;

/**
 * Created by xiao on 2016/12/26.
 */
public class OrderStatusEvent extends ApplicationEvent {

    private Integer orderId;
    private Integer status;

    public OrderStatusEvent(Object source) {
        super(source);
    }


    public OrderStatusEvent(Integer orderId, Integer status) {
        super(orderId);
        this.orderId = orderId;
        this.status = status;
    }

    public Integer getOrderId() {
        return orderId;
    }

    public Integer getStatus() {
        return status;
    }
}
