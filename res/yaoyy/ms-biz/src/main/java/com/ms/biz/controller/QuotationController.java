package com.ms.biz.controller;

import com.github.pagehelper.PageInfo;
import com.ms.dao.model.Quotation;
import com.ms.dao.model.QuoteFeed;
import com.ms.dao.vo.QuotationVo;
import com.ms.dao.vo.QuoteFeedVo;
import com.ms.service.QuotationService;
import com.ms.service.QuoteFeedService;
import com.ms.tools.annotation.SecurityToken;
import com.ms.tools.entity.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.Date;
import java.util.List;

/**
 * Created by xiao on 2016/12/8.
 * 前台资讯模块
 */
@Controller
@RequestMapping("quotation/")
public class QuotationController {

    @Autowired
    private QuotationService quotationService;

    @Autowired
    private QuoteFeedService quoteFeedService;


    /**
     * 显示最近发布一条报价单
     * @param model
     * @return
     */
    @RequestMapping(value = "index", method = RequestMethod.GET)
    @SecurityToken(generateToken = true)
    public String latestQuotation(ModelMap model){
        QuotationVo quotationVo=quotationService.getRecent();
        List<QuotationVo> quotationVos=quotationService.recentList();
        QuoteFeedVo quoteFeedVo=new QuoteFeedVo();
        if(quotationVo!=null){
            quoteFeedVo.setQid(quotationVo.getId());
        }
        PageInfo<QuoteFeedVo> quoteFeedVos=quoteFeedService.findByParams(quoteFeedVo,1,10);
        model.put("quotationVo",quotationVo);
        model.put("historyVos",quotationVos);
        model.put("quoteFeedVos",quoteFeedVos.getList());
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

    /**
     * 每份报价单明细
     * @param id
     * @param model
     * @return
     */
    @RequestMapping(value = "/detail/{id}", method = RequestMethod.GET)
    @SecurityToken(generateToken = true)
    public String quotationDetail(@PathVariable("id") Integer id, ModelMap model){
        Quotation quotation=quotationService.findById(id);
        List<QuotationVo> quotationVos=quotationService.recentList();
        QuoteFeedVo quoteFeedVo=new QuoteFeedVo();
        if(quotation!=null){
            quoteFeedVo.setQid(quotation.getId());
        }
        PageInfo<QuoteFeedVo> quoteFeedVos=quoteFeedService.findByParams(quoteFeedVo,1,10);
        model.put("quotationVo",quotation);
        model.put("historyVos",quotationVos);
        model.put("quoteFeedVos",quoteFeedVos.getList());
        return "quote";
    }

    /**
     * 发表评论
     * @param quoteFeed
     * @return
     */
    @RequestMapping(value="/feed",method=RequestMethod.POST)
    @ResponseBody
    @SecurityToken(validateToken=true)
    public Result feed(QuoteFeed quoteFeed){
        if(quoteFeed.getNickname().equals("")){
            quoteFeed.setNickname(null);
        }
        quoteFeed.setCreateTime(new Date());
        quoteFeedService.create(quoteFeed);
        return Result.success().data("发表评论成功");
    }

    /**
     * 分页获取评论
     * @param qid
     * @param pageNum
     * @param pageSize
     * @return
     */

    @RequestMapping(value="/getFeed",method=RequestMethod.POST)
    @ResponseBody
    public Result getFeed(Integer qid,Integer pageNum,Integer pageSize){
        QuoteFeedVo quoteFeedVo=new QuoteFeedVo();
        quoteFeedVo.setQid(qid);
        PageInfo<QuoteFeedVo> quoteFeedVos=quoteFeedService.findByParams(quoteFeedVo,pageNum,pageSize);

        return Result.success().data(quoteFeedVos);
    }




}
