package com.ms.biz.controller;

import com.ms.dao.vo.QuotationVo;
import com.ms.service.QuotationService;
import com.ms.tools.entity.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * Created by xiao on 2016/12/8.
 * 前台资讯模块
 */
@Controller
@RequestMapping("quotation/")
public class QuotationController {

    @Autowired
    private QuotationService quotationService;


    /**
     * 显示最近发布一条报价单
     * @param model
     * @return
     */
    @RequestMapping(value = "index", method = RequestMethod.GET)
    public String latestQuotation(ModelMap model){
        QuotationVo quotationVo=quotationService.getRecent();
        model.put("quotationVo",quotationVo);
        return "quote";
    }

    /**
     * 获取最新报价单，主要是显示红点
     * @return
     */
    @RequestMapping(value = "getRecent", method = RequestMethod.POST)
    @ResponseBody
    public Result getRecent(){
        QuotationVo quotationVo=quotationService.getRecent();
        return Result.success().data(quotationVo);

    }



}
