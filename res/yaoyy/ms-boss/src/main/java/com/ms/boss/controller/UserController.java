package com.ms.boss.controller;

import com.github.pagehelper.PageInfo;
import com.ms.boss.config.LogTypeConstant;
import com.ms.dao.enums.UserSourceEnum;
import com.ms.dao.model.Area;
import com.ms.dao.model.Commodity;
import com.ms.dao.model.UserAnnex;
import com.ms.dao.model.UserTrackRecord;
import com.ms.dao.vo.*;
import com.ms.service.*;
import com.ms.tools.annotation.SecurityToken;
import com.ms.tools.entity.Result;
import com.sucai.compentent.logs.annotation.BizLog;
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
 * Author: koabs
 * 10/13/16.
 * 用户管理列表
 */
@Controller
@RequestMapping("user/")
public class UserController extends BaseController{

    @Autowired
    UserService userService;

    @Autowired
    AreaService areaService;

    @Autowired
    CommodityService commodityService;

    @Autowired
    UserTrackRecordService userTrackRecordService;

    @Autowired
    UserAnnexService userAnnexService;

    @RequestMapping(value = "list", method = RequestMethod.GET)
    public String list(UserVo user, Integer pageNum, Integer pageSize, ModelMap model){
        // 只查询采购商的用户
        user.setType(1);
        PageInfo<UserVo> pageInfo = userService.findByParams(user, pageNum, pageSize);
        model.put("pageInfo", pageInfo);
        return "user_list";
    }

    @RequestMapping(value = "detail/{id}", method = RequestMethod.GET)
    @ResponseBody
    public Result detail(@PathVariable("id")Integer id){
        UserVo userVo=userService.findById(id);
        userVo.setIdentityTypeName(userVo.getIdentityTypeName());
        return Result.success("用户详情").data(userVo);
    }

    /**
     * 禁用用户
     * @param id
     * @return
     */
    @RequestMapping(value = "disable/{id}", method = RequestMethod.GET)
    @ResponseBody
    @BizLog(type = LogTypeConstant.USER, desc = "禁用用户")
    public Result disable(@PathVariable("id")Integer id) {
        userService.disable(id);
        return Result.success("禁用成功!");
    }

    /**
     * 启用账号
     * @param id
     * @return
     */
    @RequestMapping(value = "enable/{id}", method = RequestMethod.GET)
    @ResponseBody
    @BizLog(type = LogTypeConstant.USER, desc = "启用用户")
    public Result enable(@PathVariable("id")Integer id) {
        userService.enable(id);
        return Result.success("启用成功!");
    }

}
