package com.ms.biz.controller;

import com.github.pagehelper.PageInfo;
import com.ms.dao.model.Article;
import com.ms.dao.model.Commodity;
import com.ms.dao.vo.CommodityVo;
import com.ms.service.ArticleService;
import com.ms.service.CommodityService;
import com.ms.tools.entity.Result;
import com.ms.tools.exception.NotFoundException;
import com.ms.tools.utils.HttpUtil;
import me.chanjar.weixin.common.bean.WxJsapiSignature;
import me.chanjar.weixin.mp.api.WxMpService;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * Author: koabs
 * 10/25/16.
 */
@Controller
@RequestMapping("commodity")
public class CommodityController extends BaseController{


    private static final Logger logger = Logger.getLogger(WechatController.class);


    @Autowired
    private CommodityService commodityService;

    @Autowired
    private ArticleService articleService;

    @Autowired
    private WxMpService wxService;

    /**
     * 商品详情页面
     * @param request
     * @param id
     * @param model
     * @return
     */
    @RequestMapping(value = "/detail/{id}", method = RequestMethod.GET)
    public String commodityDetail(HttpServletRequest request,
                                  @PathVariable("id") Integer id,
                                  ModelMap model){


        CommodityVo commodityVo=commodityService.findById(id);
        if(commodityVo==null){
            throw new NotFoundException("找不到该商品");
        }
        if(commodityVo.getMark()==1){
            commodityVo.setPrice(commodityVo.getGradient().get(0).getPrice());
        }

        List<CommodityVo> commodityVoList=commodityService.findByCategoryId(commodityVo.getCategoryId());
        model.put("commodityVo",commodityVo);
        model.put("commodityVoList",commodityVoList);

        // 质量保证
        Article article = articleService.findById(2);
        if (article!= null) {
            model.put("article", article.getContent());
        }

        try {
            String url = HttpUtil.getFullUrl(request);
            WxJsapiSignature signature = wxService.createJsapiSignature(url);
            model.put("signature",signature);
        }catch (Exception e){
            logger.error(e);
        }


        return "commodity_detail";
    }


    /**
     * 批量获取商品详情（购物车显示用）
     * @param list
     * @return
     */
    @RequestMapping(value="/getDetail",method=RequestMethod.POST,consumes = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public Result getDetail(@RequestBody List<Integer> list){
        StringBuilder ids = new StringBuilder();
        if (list != null && list.size() >0){
            list.forEach(sc ->{
                ids.append(sc).append(",");
            });
        }
        List<CommodityVo> commodities = commodityService.findByIds(ids.substring(0,ids.length()-1));

        return Result.success().data(commodities);
    }





}
