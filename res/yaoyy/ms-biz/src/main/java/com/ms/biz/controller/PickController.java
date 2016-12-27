package com.ms.biz.controller;

import com.github.pagehelper.PageInfo;
import com.ms.dao.model.Commodity;
import com.ms.dao.model.PickCommodity;
import com.ms.dao.model.User;
import com.ms.dao.model.UserDetail;
import com.ms.dao.vo.PickCommodityVo;
import com.ms.dao.vo.PickTrackingVo;
import com.ms.dao.vo.PickVo;
import com.ms.service.CommodityService;
import com.ms.service.PickCommodityService;
import com.ms.service.PickService;
import com.ms.service.PickTrackingService;
import com.ms.service.enums.RedisEnum;
import com.ms.tools.entity.Result;
import com.ms.tools.entity.ResultStatus;
import com.ms.tools.utils.CookieUtils;
import com.ms.tools.utils.GsonUtil;
import me.chanjar.weixin.mp.api.WxMpPayService;
import me.chanjar.weixin.mp.api.WxMpService;
import me.chanjar.weixin.mp.bean.pay.request.WxPayUnifiedOrderRequest;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.*;

/**
 * Created by xiao on 2016/11/1.
 */
@Controller
@RequestMapping("pick/")
public class PickController extends BaseController{


    @Autowired
    private PickService pickService;

    @Autowired
    private HttpSession httpSession;

    @Autowired
    private PickTrackingService pickTrackingService;

    @Autowired
    private WxMpService wxService;


    /**
     * 选货单列表
     * @return
     */
    @RequestMapping(value="list",method= RequestMethod.GET)
    public String list(){
        return "pick_list";
    }

    @RequestMapping(value="list",method= RequestMethod.POST)
    @ResponseBody
    public Result list(Integer pageNum, Integer pageSize){
        User user = (User) httpSession.getAttribute(RedisEnum.USER_SESSION_BIZ.getValue());
        PickVo pickVo=new PickVo();
        pickVo.setUserId(user.getId());
        pickVo.setAbandon(0);
        PageInfo<PickVo> pickVoPageInfo=pickService.findByParams(pickVo,pageNum,pageSize);
        pickVoPageInfo.getList().forEach(p->{
            p.setStatusText(p.getStatusText());
            p.setBizStatusText(p.getBizStatusText());
        });

        return Result.success().data(pickVoPageInfo);


    }

    /**
     * 选货单详情
     * @param id
     * @param model
     * @return
     */
    @RequestMapping(value="detail/{id}",method=RequestMethod.GET)
    public String detail(@PathVariable("id") Integer id, ModelMap model){
        PickVo pickVo=pickService.findVoById(id);
        List<PickTrackingVo> pickTrackingVos=pickTrackingService.findByPickId(id);

        model.put("pickVo",pickVo);
        model.put("pickTrackingVos",pickTrackingVos);

        return "pick_detail";
    }




}
