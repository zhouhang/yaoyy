package com.ms.boss.controller;

import com.github.pagehelper.PageInfo;
import com.ms.dao.enums.PickTrackingTypeEnum;
import com.ms.dao.enums.TrackingTypeEnum;
import com.ms.dao.model.Member;
import com.ms.dao.vo.*;
import com.ms.service.*;
import com.ms.service.enums.RedisEnum;
import com.ms.tools.entity.Result;
import org.springframework.beans.factory.annotation.Autowired;
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
 * 账单
 * Created by xiao on 2016/12/27.
 */
@Controller
@RequestMapping(value="bill/")
public class AccountBillController {


    @Autowired
    private AccountBillService accountBillService;

    @Autowired
    private UserDetailService userDetailService;

    @Autowired
    private PayRecordService payRecordService;

    @Autowired
    private PickTrackingService pickTrackingService;

    @Autowired
    private HttpSession httpSession;

    /**
     * 账单list
     * @param accountBillVo
     * @param pageNum
     * @param pageSize
     * @param model
     * @return
     */
    @RequestMapping(value = "list", method = RequestMethod.GET)
    public String list(AccountBillVo accountBillVo,Integer pageNum, Integer pageSize, ModelMap model){

        PageInfo<AccountBillVo> billVoPageInfo=accountBillService.findByParams(accountBillVo,pageNum,pageSize);
        model.put("pageInfo",billVoPageInfo);
        return "bill_list";
    }

    /**
     * 账单详情
     * @param id
     * @param model
     * @return
     */
    @RequestMapping(value = "detail/{id}", method = RequestMethod.GET)
    public  String detail(@PathVariable("id") Integer id, ModelMap model){
        AccountBillVo accountBillVo=accountBillService.findVoById(id);
        if(accountBillVo==null){
            return "redirect:error/404";
        }
        UserDetailVo userDetailVo=userDetailService.findByUserId(accountBillVo.getUserId());
        PayRecordVo payRecordVo=payRecordService.findByBillId(id);

        model.put("billVo",accountBillVo);
        model.put("userDetail",userDetailVo);
        model.put("payRecord",payRecordVo);
        return "bill_detail";
    }

    @RequestMapping(value = "configPay", method = RequestMethod.POST)
    @ResponseBody
    @Transactional
    public Result configPay(Integer payRecordId){
        /**
         * 先修改支付记录状态，然后账单状态，写跟踪记录
         */
        Member mem= (Member) httpSession.getAttribute(RedisEnum.MEMBER_SESSION_BOSS.getValue());
        PayRecordVo payRecordVo=payRecordService.findByBillId(payRecordId);
        
        payRecordVo.setStatus(1);
        payRecordVo.setMemberId(mem.getId());
        payRecordVo.setOperateTime(new Date());
        payRecordService.save(payRecordVo);

        Integer billId=payRecordVo.getAccountBillId();
        AccountBillVo accountBillVo=accountBillService.findVoById(billId);
        accountBillVo.setAlreadyPayable(accountBillVo.getAlreadyPayable()+payRecordVo.getActualPayment());
        accountBillVo.setStatus(1);
        accountBillService.update(accountBillVo);



        PickTrackingVo pickTrackingVo=new PickTrackingVo();
        pickTrackingVo.setPickId(accountBillVo.getOrderId());
        pickTrackingVo.setOperator(mem.getId());
        pickTrackingVo.setName(mem.getName());
        pickTrackingVo.setOpType(TrackingTypeEnum.TYPE_ADMIN.getValue());

        pickTrackingVo.setRecordType(PickTrackingTypeEnum.PICK_CONFIG_PAY_BILL.getValue());

        pickTrackingService.save(pickTrackingVo);

        return Result.success().msg("确认成功");
    }



}
