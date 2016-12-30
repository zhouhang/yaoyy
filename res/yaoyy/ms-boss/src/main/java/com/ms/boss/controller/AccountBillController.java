package com.ms.boss.controller;

import com.github.pagehelper.PageInfo;
import com.ms.dao.vo.AccountBillVo;
import com.ms.service.AccountBillService;
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

    @RequestMapping(value = "list", method = RequestMethod.GET)
    public String list(AccountBillVo accountBillVo,Integer pageNum, Integer pageSize, ModelMap model){

        PageInfo<AccountBillVo> billVoPageInfo=accountBillService.findByParams(accountBillVo,pageNum,pageSize);
        model.put("pageInfo",billVoPageInfo);
        return "";
    }

    @RequestMapping(value = "detail/{id}", method = RequestMethod.GET)
    public  String detail(@PathVariable("id") Integer id, ModelMap model){
        AccountBillVo accountBillVo=accountBillService.findVoById(id);
        model.put("accountBillVo",accountBillVo);
        return "";
    }



}
