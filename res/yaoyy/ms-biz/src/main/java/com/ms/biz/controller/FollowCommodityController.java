package com.ms.biz.controller;

import com.ms.dao.model.User;
import com.ms.service.FollowCommodityService;
import com.ms.service.enums.RedisEnum;
import com.ms.tools.entity.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;

/**
 * Author: koabs
 * 12/8/16.
 */
@Controller
@RequestMapping("follow/")
public class FollowCommodityController {

    @Autowired
    private FollowCommodityService followCommodityService;

    @Autowired
    private HttpSession httpSession;

    @RequestMapping(value = "list", method = RequestMethod.GET)
    public String list(ModelMap model) {
        User user = (User) httpSession.getAttribute(RedisEnum.USER_SESSION_BIZ.getValue());
        model.put("list",followCommodityService.findCommodity(user.getId()));
        return "user_follow";
    }

    /**
     * 关注商品
     * @param commodityId
     * @return
     */
    @RequestMapping(value = "watch", method = RequestMethod.POST)
    @ResponseBody
    public Result watch(Integer commodityId){
        User user = (User) httpSession.getAttribute(RedisEnum.USER_SESSION_BIZ.getValue());
        followCommodityService.watch(commodityId, user.getId());
        return Result.success("关注成功");
    }

    /**
     * 取消关注商品
     * @param id
     * @return
     */
    @RequestMapping(value = "unwatch", method = RequestMethod.POST)
    @ResponseBody
    public Result unwatch(Integer id, Integer commodityId){
        User user = (User) httpSession.getAttribute(RedisEnum.USER_SESSION_BIZ.getValue());
        followCommodityService.unwatch(id,commodityId,user.getId());
        return Result.success("取消关注成功");
    }
}
