package com.ms.biz.controller;

import com.ms.dao.model.Special;
import com.ms.dao.vo.CommodityVo;
import com.ms.service.SpecialService;
import com.ms.tools.utils.HttpUtil;
import me.chanjar.weixin.common.bean.WxJsapiSignature;
import me.chanjar.weixin.mp.api.WxMpService;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * Author: koabs
 * 10/26/16.
 * 专场
 */
@Controller
@RequestMapping("special")
public class SpecialController extends BaseController{

    private static final Logger logger = Logger.getLogger(WechatController.class);

    @Autowired
    private SpecialService specialService;

    @Autowired
    private WxMpService wxService;

    /**
     * 专场详情页
     * @param id
     * @param model
     * @return
     */
    @RequestMapping(value = "/{id}", method = RequestMethod.GET)
    public String detail(@PathVariable("id")Integer id, ModelMap model,HttpServletRequest request) {
        Special vo = specialService.findById(id);
        List<CommodityVo> commodities = specialService.findCommoditiesBySpecial(id);
        model.put("special", vo);
        model.put("commodities", commodities);
        try {
            String url = HttpUtil.getFullUrl(request);
            WxJsapiSignature signature = wxService.createJsapiSignature(url);
            model.put("signature",signature);
        }catch (Exception e){
            logger.error(e);
        }
        // 根据id查询专场信息
        return "special";
    }
}
