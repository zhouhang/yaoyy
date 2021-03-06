package com.ms.boss.controller;

import com.github.pagehelper.PageInfo;
import com.ms.boss.config.LogTypeConstant;
import com.ms.dao.enums.*;
import com.ms.dao.model.AccountBill;
import com.ms.dao.model.Member;
import com.ms.dao.model.PayRecord;
import com.ms.dao.vo.AccountBillVo;
import com.ms.dao.vo.PayRecordVo;
import com.ms.dao.vo.PickTrackingVo;
import com.ms.dao.vo.PickVo;
import com.ms.service.AccountBillService;
import com.ms.service.PayRecordService;
import com.ms.service.PickService;
import com.ms.service.PickTrackingService;
import com.ms.service.enums.MessageEnum;
import com.ms.service.enums.RedisEnum;
import com.ms.service.observer.MsgConsumeEvent;
import com.ms.service.observer.MsgProducerEvent;
import com.ms.tools.annotation.SecurityToken;
import com.ms.tools.entity.Result;
import com.sucai.compentent.logs.annotation.BizLog;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.context.ApplicationContext;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.Date;


/**
 * 交易流水
 * Created by xiao on 2016/12/26.
 */
@Controller
@RequestMapping(value = "payRecord/")
public class PayRecordController extends BaseController{

    @Autowired
    private PayRecordService payRecordService;

    @Autowired
    private PickService pickService;

    @Autowired
    private PickTrackingService pickTrackingService;

    @Autowired
    private HttpSession httpSession;

    @Autowired
    private AccountBillService accountBillService;

    @Autowired
    private ApplicationContext applicationContext;

    /**
     * 交易流水列表
     * @param payRecordVo
     * @param pageNum
     * @param pageSize
     * @param model
     * @return
     */
    @RequestMapping(value = "list", method = RequestMethod.GET)
    @BizLog(type = LogTypeConstant.PAYRECORD, desc = "交易流水列表")
    public String list(PayRecordVo payRecordVo,Integer pageNum, Integer pageSize, ModelMap model){

        PageInfo<PayRecordVo> payRecordVos=payRecordService.findByParams(payRecordVo,pageNum,pageSize);
        model.put("pageInfo",payRecordVos);

        return "pay_record_list";
    }

    /**
     * 交易流水详情
     * @param id
     * @param model
     * @return
     */
    @RequestMapping(value = "detail/{id}", method = RequestMethod.GET)
    @SecurityToken(generateToken = true)
    @BizLog(type = LogTypeConstant.PAYRECORD, desc = "交易流水详情")
    public  String detail(@PathVariable("id") Integer id, ModelMap model){
        PayRecordVo payRecordVo=payRecordService.findVoById(id);
        model.put("payRecordVo",payRecordVo);
        return "pay_record_detail";
    }
    /**
     * 确认收款
     */
    @RequestMapping(value = "config", method = RequestMethod.POST)
    @ResponseBody
    @Transactional
    @SecurityToken(validateToken=true)
    @BizLog(type = LogTypeConstant.PAYRECORD, desc = "确认收款")
    public Result config(Integer payRecordId, Integer orderId){
        Member mem= (Member) httpSession.getAttribute(RedisEnum.MEMBER_SESSION_BOSS.getValue());
        PayRecord payRecord=new PayRecord();
        payRecord.setId(payRecordId);
        payRecord.setStatus(1);
        payRecord.setMemberId(mem.getId());
        payRecord.setOperateTime(new Date());
        payRecordService.update(payRecord);
        //如果存在账期就为这个用户生成账单
        PickVo pick=pickService.findVoById(orderId);
        if(SettleTypeEnum.SETTLE_DEPOSIT.getType().equals(pick.getSettleType())){
            AccountBillVo accountBillVo=new AccountBillVo();
            accountBillVo.setMemberId(mem.getId());
            accountBillVo.setOrderId(pick.getId());
            accountBillVo.setUserId(pick.getUserId());
            accountBillVo.setBillTime(pick.getBillTime());
            accountBillVo.setAlreadyPayable(pick.getDeposit());
            accountBillVo.setAmountsPayable(pick.getAmountsPayable());
            accountBillService.saveAccountBill(accountBillVo);
        }


        //确认收款之后记录一条记录用户付全款的跟踪记录

        PickTrackingVo pickTrackingVo=new PickTrackingVo();
        pickTrackingVo.setPickId(orderId);
        pickTrackingVo.setOperator(mem.getId());
        pickTrackingVo.setOpType(TrackingTypeEnum.TYPE_ADMIN.getValue());
        pickTrackingVo.setName(mem.getName());
        if(pick.getSettleType()== SettleTypeEnum.SETTLE_DEPOSIT.getType()){
            pickTrackingVo.setRecordType(PickTrackingTypeEnum.PICK_PAYPOSIT.getValue());
        }
        else{
            pickTrackingVo.setRecordType(PickTrackingTypeEnum.PICK_PAYALL.getValue());
        }
        pickTrackingService.save(pickTrackingVo);

        MsgProducerEvent msgProducerEvent=new MsgProducerEvent(pick.getUserId(),orderId, MessageEnum.PAY_SUCCESS, null, MsgIsMemberEnum.IS_MEMBER.getKey());
        applicationContext.publishEvent(msgProducerEvent);

        return Result.success().data("确认收款");
    }


}
