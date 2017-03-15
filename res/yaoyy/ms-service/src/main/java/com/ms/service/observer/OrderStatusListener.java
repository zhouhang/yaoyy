package com.ms.service.observer;

import com.ms.dao.observer.OrderStatusEvent;
import com.ms.service.PickService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationListener;
import org.springframework.scheduling.annotation.Async;
import org.springframework.scheduling.annotation.EnableAsync;
import org.springframework.stereotype.Component;

/**
 * Created by xiao on 2016/12/26.
 */
@Component
@EnableAsync
public class OrderStatusListener implements ApplicationListener<OrderStatusEvent> {

    @Autowired
    PickService pickService;

    @Override
    @Async
    public void onApplicationEvent(OrderStatusEvent event) {
        pickService.changeOrderStatus(event.getOrderId(),event.getStatus());
    }

}
