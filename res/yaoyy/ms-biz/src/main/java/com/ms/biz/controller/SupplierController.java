package com.ms.biz.controller;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageInfo;
import com.ms.dao.model.User;
import com.ms.dao.vo.CommodityVo;
import com.ms.dao.vo.PickVo;
import com.ms.service.CommodityService;
import com.ms.service.PickService;
import com.ms.service.enums.RedisEnum;
import com.ms.tools.entity.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.List;

/**
 * Author: koabs
 * 3/7/17.
 */
@Controller
@RequestMapping("/supplier")
public class SupplierController {

    @Autowired
    HttpSession httpSession;

    @Autowired
    PickService pickService;

    @Autowired
    CommodityService commodityService;

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
        return "supplier/order_list";
    }

    /**
     * 供应商订单数据
     * @param pageNum
     * @param pageSize
     * @return
     */
    @RequestMapping(value = "order", method = RequestMethod.POST)
    @ResponseBody
    public Result orderData(Integer pageNum, Integer pageSize) {

        // 账期付款 账期信息获取: TODO:
        User user = (User) httpSession.getAttribute(RedisEnum.USER_SESSION_BIZ.getValue());
        PickVo vo = new PickVo();
        vo.setSupplierId(user.getId());
        PageInfo<PickVo> pageInfo = pickService.findByParams(vo, pageNum, pageSize);
        return Result.success().data(pageInfo);
    }


    /**
     * 寄卖商品列表和 寄卖商品跟踪消息
     * @return
     */
    @RequestMapping(value = "commodityTrace", method = RequestMethod.GET)
    public String commodityTrace(ModelMap model) {
        User user = (User) httpSession.getAttribute(RedisEnum.USER_SESSION_BIZ.getValue());
        List<CommodityVo> list = commodityService.findBySupplier(user.getId());
        model.put("list",list);
        return "/supplier/commodity_trace";
    }

    /**
     * 获取货物跟踪
     * @param model
     * @return
     */
    @RequestMapping(value = "commodityTrace", method = RequestMethod.POST)
    public String commodityTraceData(ModelMap model) {
        User user = (User) httpSession.getAttribute(RedisEnum.USER_SESSION_BIZ.getValue());
        List<CommodityVo> list = commodityService.findBySupplier(user.getId());
        model.put("list",list);
        return "/supplier/commodity_trace";
    }


}
