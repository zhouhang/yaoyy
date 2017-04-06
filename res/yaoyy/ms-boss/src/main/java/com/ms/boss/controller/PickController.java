package com.ms.boss.controller;

import com.github.pagehelper.PageInfo;
import com.ms.boss.config.LogTypeConstant;
import com.ms.dao.enums.PickEnum;
import com.ms.dao.enums.SettleTypeEnum;
import com.ms.dao.enums.TrackingTypeEnum;
import com.ms.dao.model.*;
import com.ms.dao.vo.*;
import com.ms.service.*;
import com.ms.service.enums.MessageEnum;
import com.ms.service.enums.RedisEnum;
import com.ms.service.observer.MsgConsumeEvent;
import com.ms.tools.annotation.SecurityToken;
import com.ms.tools.entity.Result;
import com.sucai.compentent.logs.annotation.BizLog;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.List;

/**
 * Created by xiao on 2016/10/28.
 */
@Controller
@RequestMapping(value = "pick/")
public class PickController extends BaseController {

    @Autowired
    PickService pickService;

    @Autowired
    PickTrackingService pickTrackingService;

    @Autowired
    UserDetailService userDetailService;

    @Autowired
    HttpSession httpSession;

    @Autowired
    ApplicationContext applicationContext;

    @Autowired
    ShippingAddressHistoryService shippingAddressHistoryService;

    @Autowired
    OrderInvoiceService orderInvoiceService;

    @Autowired
    PayRecordService payRecordService;

    @Autowired
    LogisticalService logisticalService;

    @Autowired
    AccountBillService accountBillService;

    /**
     * 订单列表
     *
     * @param pickVo
     * @param pageNum
     * @param pageSize
     * @param model
     * @return
     */
    @RequestMapping(value = "list", method = RequestMethod.GET)
    @BizLog(type = LogTypeConstant.ORDER, desc = "订单列表")
    String list(PickVo pickVo, Integer pageNum, Integer pageSize, ModelMap model) {
        if (pickVo.getAbandon() == null) {
            pickVo.setAbandon(0);
        }
        PageInfo<PickVo> pickVoPageInfo = pickService.findByParams(pickVo, pageNum, pageSize);
        //寻找是否有待支付并且有提交转账记录的订单

        pickVoPageInfo.getList().forEach(p -> {
            if (p.getStatus() == PickEnum.PICK_PAY.getValue()) {
                PayRecordVo param = new PayRecordVo();
                param.setCodeType(0);
                param.setOrderId(p.getId());
                param.setStatus(0);
                PayRecordVo payRecord = payRecordService.findByOrderId(param);
                if (payRecord != null) {
                    p.setStatusText("(付款待确认)");
                }
            }
        });
        model.put("pickVoPageInfo", pickVoPageInfo);
        return "pick_list";
    }

    /**
     * 选货单详情
     *
     * @param id
     * @param model
     * @return
     */
    @RequestMapping(value = "detail/{id}", method = RequestMethod.GET)
    @SecurityToken(generateToken = true)
    @BizLog(type = LogTypeConstant.ORDER, desc = "订单详情")
    String detail(@PathVariable("id") Integer id, String edit, ModelMap model) {

        //订单信息
        PickVo pickVo = pickService.findVoById(id);
        model.put("pickVo", pickVo);

        //获取下单用户信息
        UserDetail userDetail = userDetailService.findByUserId(pickVo.getUserId());
        if (userDetail == null) {
            userDetail = new UserDetail();
        }
        model.put("userDetail", userDetail);

        //获取订单供应商信息
        UserDetail supplierDetail=new UserDetail();
        if(null!=pickVo.getSupplierId()){
            supplierDetail = userDetailService.findByUserId(pickVo.getSupplierId());
        }
        model.put("supplierDetail", supplierDetail);

        //获取订单跟踪信息
        List<PickTrackingVo> pickTrackingVos = pickTrackingService.findByPickId(id);
        model.put("pickTrackingVos", pickTrackingVos);


        //收货地址
        ShippingAddressHistory shippingAddressHistory = null;
        if (pickVo.getAddrHistoryId() != null) {
            shippingAddressHistory = shippingAddressHistoryService.findById(pickVo.getAddrHistoryId());
        }
        model.put("shippingAddressHistory", shippingAddressHistory);

        if (edit != null) {
            return "pick_info3";
        }
        if (pickVo.getStatus() == PickEnum.PICK_NOTHANDLE.getValue()
                || pickVo.getStatus() == PickEnum.PICK_REFUSE.getValue()
                || pickVo.getStatus() == PickEnum.PICK_HANDING.getValue()
                || pickVo.getStatus() == PickEnum.PICK_NOTFINISH.getValue()
                ) {
            return "pick_info1";
        } else {
            //获取支付信息,收货信息和发票信息
            PayRecordVo param = new PayRecordVo();
            param.setCodeType(0);
            param.setOrderId(pickVo.getId());
            if (PickEnum.PICK_PAY.getValue().equals(pickVo.getStatus())) {
                param.setStatus(0);
            } else {
                param.setStatus(1);
            }
            if (!SettleTypeEnum.SETTLE_ALL.getType().equals(pickVo.getSettleType())) {
                AccountBillVo accountBillVo = accountBillService.findVoByOrderId(pickVo.getId());
                model.put("accountBillVo", accountBillVo);
            }
            PayRecordVo payRecord = payRecordService.findByOrderId(param);
            OrderInvoiceVo orderInvoiceVo = orderInvoiceService.findByOrderId(pickVo.getId());


            LogisticalVo logisticalVo = logisticalService.findByOrderId(pickVo.getId());
            model.put("logisticalVo", logisticalVo);
            model.put("payRecord", payRecord);
            model.put("orderInvoiceVo", orderInvoiceVo);
            return "pick_info2";
        }

    }

    /**
     * 删除和恢复
     *
     * @param pick
     * @return
     */
    @RequestMapping(value = "delete", method = RequestMethod.POST)
    @ResponseBody
    @BizLog(type = LogTypeConstant.ORDER, desc = "订单状态更新")
    Result delete(Pick pick) {
        pickService.update(pick);
        if (pick.getAbandon() == 1) {
            MsgConsumeEvent msgConsumeEvent = new MsgConsumeEvent(pick.getId(), MessageEnum.PICK);
            applicationContext.publishEvent(msgConsumeEvent);
        }
        return Result.success().msg("操作成功");
    }

    /**
     * 选货单跟踪记录
     *
     * @param pickTrackingVo
     * @return
     */
    @RequestMapping(value = "trackingSave", method = RequestMethod.POST)
    @ResponseBody
    @SecurityToken(validateToken = true)
    @BizLog(type = LogTypeConstant.ORDER, desc = "选货单跟踪记录")
    Result save(PickTrackingVo pickTrackingVo) {

        Member mem = (Member) httpSession.getAttribute(RedisEnum.MEMBER_SESSION_BOSS.getValue());
        pickTrackingVo.setOperator(mem.getId());
        pickTrackingVo.setOpType(TrackingTypeEnum.TYPE_ADMIN.getValue());
        pickTrackingVo.setName(mem.getName());
        pickTrackingService.save(pickTrackingVo);

        return Result.success().msg("保存成功");
    }



    @RequestMapping(value = "orderComplete", method = RequestMethod.POST)
    @ResponseBody
    @SecurityToken(validateToken = true)
    @BizLog(type = LogTypeConstant.ORDER, desc = "订单完成")
    public Result orderComplete(Integer orderId,String action){
        Boolean result = pickService.complete(orderId,action);
        String msg = "";
        if(result){
            msg = "订单已完成!";
        }else{
            msg = "订单退货成功!";
        }
        return Result.success().msg(msg);
    }



    /**
     * 生成订单
     * @param pickVo
     * @return
     */
    @RequestMapping(value = "addOrderAccount", method = RequestMethod.POST)
    @ResponseBody
    @SecurityToken(validateToken = true)
    @BizLog(type = LogTypeConstant.ORDER, desc = "生成订单")
    Result addOrderAccount(PickVo pickVo) {
        Member mem = (Member) httpSession.getAttribute(RedisEnum.MEMBER_SESSION_BOSS.getValue());
        pickVo.setMemberId(mem.getId());
        //过滤不必要的参数
        if (pickVo.getSettleType().equals(SettleTypeEnum.SETTLE_ALL.getType())) {
            pickVo.setBillTime(0);
            pickVo.setDeposit(0F);
        } else if (pickVo.getSettleType().equals(SettleTypeEnum.SETTLE_BILL.getType())) {
            pickVo.setDeposit(0F);
        }
        pickService.addOrderAccount(pickVo);
        return Result.success().msg("生成订单成功");
    }


    /**
     * 生成订单
     * @param pickVo
     * @return
     */
    @RequestMapping(value = "createOrder", method = RequestMethod.POST)
    @ResponseBody
    @SecurityToken(validateToken = true)
    @BizLog(type = LogTypeConstant.ORDER, desc = "生成订单")
    Result createOrder(PickVo pickVo) {
        Member mem = (Member) httpSession.getAttribute(RedisEnum.MEMBER_SESSION_BOSS.getValue());
        pickVo.setMemberId(mem.getId());
        //过滤不必要的参数
        if (pickVo.getSettleType().equals(SettleTypeEnum.SETTLE_ALL.getType())) {
            pickVo.setBillTime(0);
            pickVo.setDeposit(0F);
        } else if (pickVo.getSettleType().equals(SettleTypeEnum.SETTLE_BILL.getType())) {
            pickVo.setDeposit(0F);
        }
        pickService.createOrder(pickVo);
        return Result.success().msg("生成订单成功");
    }

    @RequestMapping(value = "updateOrder", method = RequestMethod.POST)
    @ResponseBody
    @BizLog(type = LogTypeConstant.ORDER, desc = "修改订单")
    Result updateOrder(@RequestBody PickVo pickVo) {
        Member mem = (Member) httpSession.getAttribute(RedisEnum.MEMBER_SESSION_BOSS.getValue());
        pickVo.setMemberId(mem.getId());
        pickService.createOrder(pickVo);
        return Result.success().msg("修改订单成功");
    }


    @RequestMapping(value = "updateNum", method = RequestMethod.POST)
    @ResponseBody
    @BizLog(type = LogTypeConstant.ORDER, desc = "修改数量")
    Result updateNum(@RequestBody List<PickCommodity> pickCommodities) {
        //修改数量
        pickService.updateCommodityNum(pickCommodities);

        return Result.success().msg("修改成功");
    }

    /**
     * 确认发货
     *
     * @param logisticalVo
     * @return
     */
    @RequestMapping(value = "delivery", method = RequestMethod.POST)
    @ResponseBody
    @SecurityToken(validateToken = true)
    @BizLog(type = LogTypeConstant.ORDER, desc = "确认发货")
    Result delivery(LogisticalVo logisticalVo) {
        Member mem = (Member) httpSession.getAttribute(RedisEnum.MEMBER_SESSION_BOSS.getValue());
        pickService.delivery(logisticalVo, mem);
        return Result.success().msg("发货成功");
    }

}
