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

    /**
     * 签约供应商列表
     * @param user
     * @param pageNum
     * @param pageSize
     * @param model
     * @return
     */
    @RequestMapping(value = "signlist", method = RequestMethod.GET)
    public String signlist(UserVo user, Integer pageNum, Integer pageSize, ModelMap model){
        // 只查询供应商商的用户
        user.setType(2);
        PageInfo<UserVo> pageInfo = userService.findVoByParams(user, pageNum, pageSize);
        model.put("pageInfo", pageInfo);
        return "suppliersign_list";
    }

    /**
     * 签约供应商详情
     * @param id
     * @param model
     * @return
     */
    @RequestMapping(value = "signdetail/{id}", method = RequestMethod.GET)
    public String supplierSignDetail(@PathVariable("id") Integer id,ModelMap model){
        UserVo userVo = userService.findById(id);
        userVo.setSourceName(UserSourceEnum.get(userVo.getSource()));
        model.put("userVo",userVo);

        List<CommodityVo> commodityVos=commodityService.findBySupplier(id);
        model.put("commodityVos", commodityVos);

        //查出该供应商区域数据
        AreaVo areaVo = areaService.findVoById(userVo.getArea());
        //省份数据
        Integer parentid = 100000;
        List<Area> provinces = areaService.findByParent(parentid);
        //城市数据
        List<Area> cities = areaService.findByParent(areaVo.getProvinceId());
        //地区数据
        List<Area> areaVos = areaService.findByParent(areaVo.getCityId());

        model.put("areaVo", areaVo);
        model.put("provinces", provinces);
        model.put("cities", cities);
        model.put("areaVos", areaVos);

        //获取跟踪记录
        UserTrackRecordVo userTrackRecordVo = new UserTrackRecordVo();
        userTrackRecordVo.setUserId(userVo.getId());
        List<UserTrackRecordVo> userTrackRecordVos = userTrackRecordService.findByParamsNoPage(userTrackRecordVo);
        model.put("userTrackRecordVos", userTrackRecordVos);

        //读取图片信息
        UserAnnexVo userAnnexVo = new UserAnnexVo();
        userAnnexVo.setUserId(id);
        List<UserAnnexVo> userAnnexVos = userAnnexService.findByParamsNoPage(userAnnexVo);
        model.put("userAnnexVos", userAnnexVos);

        return "suppliersign_detail";
    }

    /**
     * 保存签约供应商信息
     * @param userVo
     * @return
     */
    @RequestMapping(value = "signsave", method = RequestMethod.POST)
    @ResponseBody
    public Result saveSupplier(UserVo userVo){
        userService.signSave(userVo);
        return Result.success("保存成功");
    }

    /**
     * 保存供应商信息
     * @param userId
     * @param url
     * @return
     */
    @RequestMapping(value = "annex", method = RequestMethod.GET)
    @ResponseBody
    public Result annex(Integer userId, String url){
        UserAnnexVo userAnnexVo = new UserAnnexVo();
        userAnnexVo.setUserId(userId);
        userAnnexVo.setUrl(url);
        userAnnexVo.setCreateTime(new Date());
        userAnnexService.save(userAnnexVo);
        return Result.success("保存成功");
    }

    /**
     * 保存供应商信息
     * @param annexId
     * @return
     */
    @RequestMapping(value = "annexdel", method = RequestMethod.GET)
    @ResponseBody
    public Result annexdel(Integer annexId){
        userAnnexService.deleteFileById(annexId);
        return Result.success("删除成功");
    }

}
