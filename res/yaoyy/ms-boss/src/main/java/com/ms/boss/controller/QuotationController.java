package com.ms.boss.controller;

import com.github.pagehelper.PageInfo;
import com.ms.dao.model.Quotation;
import com.ms.dao.vo.QuotationVo;
import com.ms.service.QuotationService;
import com.ms.tools.entity.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * Created by xiao on 2016/12/5.
 * 后台资讯模块报价单
 */
@Controller
@RequestMapping("quotation/")
public class QuotationController {

    @Autowired
    private QuotationService quotationService;

    /**
     * 报价单list
     * @param quotationVo
     * @param pageNum
     * @param pageSize
     * @param model
     * @return
     */
    @RequestMapping(value = "list", method = RequestMethod.GET)
    public String quotationList(QuotationVo quotationVo, Integer pageNum,
                                 Integer pageSize, ModelMap model){
        PageInfo<QuotationVo> quotationVoPageInfo=quotationService.findByParams(quotationVo,pageNum,pageSize);
        model.put("pageInfo",quotationVoPageInfo);
        return "quotation_list";
    }

    /**
     * 报价单详情
     * @param id
     * @param model
     * @return
     */
    @RequestMapping(value = "detail/{id}", method = RequestMethod.GET)
    public String quotationDetail(@PathVariable("id") Integer id, ModelMap model){
        Quotation quotation=quotationService.findById(id);
        model.put("quotation",quotation);
        return "quotation_detail";

    }


    @RequestMapping(value = "save", method = RequestMethod.POST)
    @ResponseBody
    public Result saveQuotation(QuotationVo quotationVo){
        quotationService.save(quotationVo);
        return Result.success("修改成功");
    }








}
