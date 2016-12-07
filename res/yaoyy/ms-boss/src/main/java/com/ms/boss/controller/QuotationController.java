package com.ms.boss.controller;

import com.github.pagehelper.PageInfo;
import com.ms.dao.model.Quotation;
import com.ms.dao.vo.QuotationVo;
import com.ms.service.QuotationService;
import com.ms.tools.entity.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;

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

    @RequestMapping(value = "create", method = RequestMethod.GET)
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
    public Result updateStatus(QuotationVo quotationVo){
        quotationService.update(quotationVo);
        return Result.success("状态更新成功");
    }









}
