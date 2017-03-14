package com.ms.biz.controller;

import com.github.pagehelper.PageInfo;
import com.ms.dao.model.Article;
import com.ms.dao.model.Commodity;
import com.ms.dao.model.User;
import com.ms.dao.vo.CategoryVo;
import com.ms.dao.vo.CommodityVo;
import com.ms.service.*;
import com.ms.service.enums.RedisEnum;
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
import javax.servlet.http.HttpSession;
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
    private HttpSession httpSession;

    @Autowired
    private WxMpService wxService;

    @Autowired
    private FollowCommodityService followCommodityService;

    @Autowired
    private HistoryPriceService historyPriceService;

    @Autowired
    private CategoryService categoryService;

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

        Boolean login = false;
        User user = (User) httpSession.getAttribute(RedisEnum.USER_SESSION_BIZ.getValue());
        if (user != null) {
            List<Integer> ids = followCommodityService.findCommodityIds(user.getId());
            if (ids.contains(id)){
                commodityVo.setWatch(true);
            }
            login = true;
        }
        model.put("login",login);

        List<CommodityVo> commodityVoList=commodityService.findByCategoryId(commodityVo.getCategoryId());
        model.put("commodityVo",commodityVo);
        model.put("commodityVoList",commodityVoList);

        // 质量保证
        Article article = articleService.findById(2);
        if (article!= null) {
            if(article.getContent()!=null){
                model.put("article", article.getContent());
            }
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

    /**
     * 商品的价格历史记录
     * @param id
     * @return
     */
    @RequestMapping(value="/price/{id}",method=RequestMethod.GET)
    public String getDetail(@PathVariable("id") Integer id, ModelMap model){
        CommodityVo commodityVo=commodityService.findById(id);
        if(commodityVo==null){
            throw new NotFoundException("找不到该商品");
        }
        List<CommodityVo> commodityVoList=commodityService.findByCategoryId(commodityVo.getCategoryId());
        // 获取商品的价格历史数据
        model.addAllAttributes(historyPriceService.findByCommodityId(id));
        model.put("commodityVo",commodityVo);
        model.put("commodityVoList",commodityVoList);
        return "commodity_price";
    }

    /**
     * 全局商品列表
     * @params categoryId
     * @return
     */
    @RequestMapping(value="/list",method=RequestMethod.GET)
    public String list(Integer categoryId, ModelMap model){
        CategoryVo categoryVo = new CategoryVo();
        categoryVo.setLevel(2);//查询二级分类
        categoryVo.setStatus(1);//查询上架的品种
        List<CategoryVo> categoryVos = categoryService.findHasCommodity(categoryVo);
        model.put("categoryVos",categoryVos);
        model.put("categoryId", categoryId);

        return "commodity_list";
    }

    /**
     * 某分类下的商品分页列表
     * @param categoryId
     * @param keyword
     * @param pageNum
     * @return
     */
    @RequestMapping(value="/list",method=RequestMethod.POST)
    @ResponseBody
    public Result list(Integer categoryId, String keyword, Integer pageNum){
        CommodityVo commodityVo = new CommodityVo();
        commodityVo.setCategoryId(categoryId);
        commodityVo.setKeyword(keyword);
        commodityVo.setStatus(1);//查询已上架的商品
        PageInfo<CommodityVo> commodityVos = commodityService.findByParams(commodityVo, pageNum, 5);

        return Result.success().data(commodityVos.getList());
    }

}
