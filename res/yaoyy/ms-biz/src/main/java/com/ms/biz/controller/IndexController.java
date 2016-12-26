package com.ms.biz.controller;

import com.ms.dao.model.Article;
import com.ms.dao.model.Commodity;
import com.ms.dao.model.User;
import com.ms.dao.vo.AdVo;
import com.ms.dao.vo.SendSampleVo;
import com.ms.dao.vo.UserVo;
import com.ms.service.*;
import com.ms.service.enums.RedisEnum;
import com.ms.tools.entity.Result;
import com.ms.tools.exception.ControllerException;
import com.ms.tools.exception.NotFoundException;
import com.ms.tools.utils.HttpUtil;
import me.chanjar.weixin.common.bean.WxJsapiSignature;
import me.chanjar.weixin.mp.api.WxMpService;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.List;

/**
 * Author: koabs
 * 10/12/16.
 */
@Controller
@RequestMapping
public class IndexController extends BaseController{

    private static final Logger logger = Logger.getLogger(WechatController.class);


    @Autowired
    private AdService adService;

    @Autowired
    private CommodityService commodityService;

    @Autowired
    private SendSampleService sendSampleService;

    @Autowired
    private UserService userService;

    @Autowired
    private HttpSession httpSession;

    @Autowired
    private ArticleService articleService;

    @Autowired
    private WxMpService wxService;


    /**
     * 首页广告
     * @param model
     * @return
     */
    @RequestMapping(value = "/", method = RequestMethod.GET)
    public String index(ModelMap model,HttpServletRequest request) {
        // 首页banner 广告
        // 专场广告
        List<AdVo> banners = adService.findByType(1);
        List<AdVo> specials = adService.findByType(2);
        model.put("banners", banners);
        model.put("specials",specials);
        try {
            String url = HttpUtil.getFullUrl(request);
            WxJsapiSignature signature = wxService.createJsapiSignature(url);
            model.put("signature",signature);
        }catch (Exception e){
            logger.error(e);
        }

        return "index";
    }

    /**
     * 寄样页面
     * @param commdityId
     * @param model
     * @return
     */
    @RequestMapping(value = "apply/sample/{id}", method = RequestMethod.GET)
    public String apply(@PathVariable("id")Integer commdityId,ModelMap model) {

        Commodity commodity=commodityService.findById(commdityId);
        if (commodity==null){
            throw new NotFoundException("找不到该商品");
        }
        User user = (User) httpSession.getAttribute(RedisEnum.USER_SESSION_BIZ.getValue());
        if(user!=null){
            model.put("phone", user.getPhone());
        }
        model.put("commodity", commodity);
        return "apply_sample";
    }

    /**
     * 申请寄样post请求
     * @param sendSampleVo
     * @return
     */
    @RequestMapping(value = "apply/sample", method = RequestMethod.POST)
    @ResponseBody
    public Result applySample(SendSampleVo sendSampleVo) {

        if(sendSampleVo.getIntention()==null){
            return Result.error();
        }
        User user = (User) httpSession.getAttribute(RedisEnum.USER_SESSION_BIZ.getValue());
        if(user!=null){
            sendSampleVo.setUserId(user.getId());
        }
        sendSampleService.save(sendSampleVo);
        UserVo userInfo=userService.findByPhone(sendSampleVo.getPhone());

        return Result.success().data(userInfo);
    }

    @RequestMapping(value = "/article/{id}", method = RequestMethod.GET)
    public String article(@PathVariable("id") Integer id, ModelMap modelMap) {
        Article article = articleService.findById(id);
        if(article.getContent()!=null){
            article.setContent(article.getContent());
        }
        modelMap.put("article", article);
        return "article";
    }



    @RequestMapping(value = "/html/{name}", method = RequestMethod.GET)
    public String html(@PathVariable("name") String name,
                       HttpServletRequest request,
                       ModelMap model) throws Exception{
        String url = HttpUtil.getFullUrl(request);
        WxJsapiSignature signature = wxService.createJsapiSignature(url);
        model.put("signature",signature);
        return "html/"+name;
    }





}
