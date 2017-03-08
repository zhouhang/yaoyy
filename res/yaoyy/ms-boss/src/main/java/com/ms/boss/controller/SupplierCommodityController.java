package com.ms.boss.controller;

import com.github.pagehelper.PageInfo;
import com.ms.dao.vo.CommodityVo;
import com.ms.service.CommodityService;
import com.ms.tools.entity.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * Author: koabs
 * 3/6/17.
 * 寄卖商品管理
 */
@Controller
@RequestMapping("/supplier")
public class SupplierCommodityController {

    @Autowired
    CommodityService commodityService;

    /**
     * 供应商库存商品列表
     * @return
     */
    @RequestMapping(value = "stock", method = RequestMethod.GET)
    public String stock(CommodityVo commodity, Integer pageNum, Integer pageSize, ModelMap model) {
        PageInfo<CommodityVo> pageInfo = commodityService.findByParams(commodity, pageNum, pageSize);
        model.put("pageInfo", pageInfo);
        return "supplier/stock_list";
    }

    /**
     * 添加寄卖库存
     * @return
     */
    @RequestMapping(value = "stock", method = RequestMethod.POST)
    @ResponseBody
    public Result addStock(Integer id, Integer num) {
        commodityService.addStock(id, num);
        return Result.success();
    }

    /**
     * 寄卖商品列表
     * @return
     */
    @RequestMapping(value = "commodity", method = RequestMethod.GET)
    public String commodity(CommodityVo commodity, Integer pageNum, Integer pageSize, ModelMap model) {
        commodity.setWarehouse(0F);
        PageInfo<CommodityVo> pageInfo = commodityService.findByParams(commodity, pageNum, pageSize);
        model.put("pageInfo", pageInfo);
        return "supplier/commodity_list";
    }
}
