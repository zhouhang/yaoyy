package com.ms.biz.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 * Author: koabs
 * 3/7/17.
 */
@Controller
@RequestMapping("/supplier")
public class SupplierController {

    @RequestMapping(value = "", method = RequestMethod.GET)
    public String index() {
        return "supplier/index";
    }

    /**
     * 订单列表页面
     * @return
     */
    @RequestMapping(value = "order", method = RequestMethod.GET)
    public String order() {
        return "supplier/order";
    }
}
