package com.ms.boss.controller;

import com.github.pagehelper.PageInfo;
import com.ms.dao.model.CommodityBatch;
import com.ms.dao.model.Member;
import com.ms.dao.vo.PickVo;
import com.ms.dao.vo.SupplierOrderVo;
import com.ms.service.PickService;
import com.ms.service.enums.RedisEnum;
import com.ms.tools.entity.Result;
import com.ms.tools.exception.ValidationException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.List;

/**
 * Author: koabs
 * 3/6/17.
 * 寄卖订单管理
 */
@RequestMapping("supplier")
@Controller
public class SupplierOrderController {

    @Autowired
    PickService pickService;

    @Autowired
    HttpSession httpSession;

    /**
     * 订单列表
     * @return
     */
    @RequestMapping(value = "order", method = RequestMethod.GET)
    public String order(SupplierOrderVo vo, Integer pageNum, Integer pageSize, ModelMap model) {
        PageInfo<SupplierOrderVo> pageInfo =pickService.queryForSupplier(vo, pageNum,pageSize);
        model.put("pageInfo", pageInfo);
        return "/supplier/order_list";
    }

    /**
     * 订单详情
     * @param pickId
     * @return
     */
    @RequestMapping(value = "order/detail", method = RequestMethod.POST)
    @ResponseBody
    public Result orderDetail(Integer pickId) {
        SupplierOrderVo info =pickService.queryByIdForSupplier(pickId);
        info.getStatusText();
        return Result.success().data(info);
    }


    /**
     * 下单
     * 寄卖下单只有商品总价字段
     * 其它 运费,包装费, 都为0
     * 付款方式为现款
     * 下单成功后默认状态为已发货
     * 退货和结算订单 直接改状态,添加跟踪记录.
     * 寄卖下单时默认购买用户为 id 为1 的用户
     * @return
     */
    @RequestMapping(value = "order/create", method = RequestMethod.POST)
    @ResponseBody
    public Result create(@RequestBody List<CommodityBatch> list, Integer commodityId) {
        // 寄卖下单时默认购买用户未 id 为1 的用户
        Member mem= (Member) httpSession.getAttribute(RedisEnum.MEMBER_SESSION_BOSS.getValue());
        try {
            pickService.supplierCreateOrder(list, commodityId,mem.getId());
        } catch (ValidationException e) {
            return Result.error().msg("库存不足!");
        }
        return Result.success();
    }

    /**
     *订单结算
     * @return
     */
    @RequestMapping(value = "order/finish", method = RequestMethod.POST)
    @ResponseBody
    public Result finish(Integer pickId) {
        // 结算直接该状态,用不用添加订单跟踪记录
        pickService.supplierFinish(pickId);
        return Result.success();
    }

    /**
     *退货
     * @return
     */
    @RequestMapping(value = "order/refunds", method = RequestMethod.POST)
    @ResponseBody
    public Result refunds(Integer pickId) {
        pickService.supplierRefunds(pickId);
        return Result.success();
    }

}
