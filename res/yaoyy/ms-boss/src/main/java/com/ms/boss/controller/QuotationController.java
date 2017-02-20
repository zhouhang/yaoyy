package com.ms.boss.controller;

import com.github.pagehelper.PageInfo;
import com.ms.boss.config.LogTypeConstant;
import com.ms.dao.model.Quotation;
import com.ms.dao.vo.QuotationVo;
import com.ms.service.QuotationService;
import com.ms.tools.annotation.SecurityToken;
import com.ms.tools.entity.Result;
import com.sucai.compentent.logs.annotation.BizLog;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;

import java.util.Date;

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
    @BizLog(type = LogTypeConstant.QUOTATION, desc = "报价单列表")
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
    @SecurityToken(generateToken = true)
    @BizLog(type = LogTypeConstant.QUOTATION, desc = "报价单详情")
    public String quotationDetail(@PathVariable("id") Integer id, ModelMap model){
        Quotation quotation=quotationService.findById(id);
        model.put("quotation",quotation);
        return "quotation_detail";

    }

    @RequestMapping(value = "create", method = RequestMethod.GET)
    @SecurityToken(generateToken = true)
    public String createQuotation(){
        return "quotation_detail";
    }


    /**
     * 保存报价单
     * @param quotationVo
     * @return
     */
    @RequestMapping(value = "save", method = RequestMethod.POST)
    @ResponseBody
    @SecurityToken(validateToken=true)
    @BizLog(type = LogTypeConstant.QUOTATION, desc = "报价单保存")
    public Result saveQuotation(@RequestBody QuotationVo quotationVo){
        quotationService.save(quotationVo);
        return Result.success("修改成功");
    }

    /**
     * 删除报价单
     * @param id
     * @return
     */
    @RequestMapping(value = "delete/{id}", method = RequestMethod.GET)
    @ResponseBody
    @BizLog(type = LogTypeConstant.QUOTATION, desc = "报价单删除")
    public Result delete(@PathVariable("id") Integer id){
        quotationService.deleteById(id);
        return Result.success("删除成功");
    }


    /**
     * 更新报价单状态
     * @param quotationVo
     * @return
     */
    @RequestMapping(value = "updateStatus", method = RequestMethod.POST)
    @ResponseBody
    @BizLog(type = LogTypeConstant.QUOTATION, desc = "报价单更新状态")
    public Result updateStatus(QuotationVo quotationVo){
        quotationVo.setUpdateTime(new Date());
        quotationService.update(quotationVo);
        return Result.success("状态更新成功");
    }









}
