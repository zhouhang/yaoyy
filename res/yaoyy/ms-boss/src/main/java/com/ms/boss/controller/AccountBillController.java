package com.ms.boss.controller;

import com.github.pagehelper.PageInfo;
import com.ms.dao.vo.AccountBillVo;
import com.ms.dao.vo.PayRecordVo;
import com.ms.dao.vo.UserDetailVo;
import com.ms.service.AccountBillService;
import com.ms.service.PayRecordService;
import com.ms.service.UserDetailService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

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

    @RequestMapping(value = "list", method = RequestMethod.GET)
    public String list(AccountBillVo accountBillVo,Integer pageNum, Integer pageSize, ModelMap model){

        PageInfo<AccountBillVo> billVoPageInfo=accountBillService.findByParams(accountBillVo,pageNum,pageSize);
        model.put("pageInfo",billVoPageInfo);
        return "bill_list";
    }

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



}
