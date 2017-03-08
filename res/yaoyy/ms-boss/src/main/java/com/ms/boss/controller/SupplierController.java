package com.ms.boss.controller;

import com.github.pagehelper.PageInfo;
import com.ms.boss.config.LogTypeConstant;
import com.ms.dao.model.Area;
import com.ms.dao.model.UserTrackRecord;
import com.ms.dao.vo.*;
import com.ms.service.*;
import com.ms.service.enums.WxSupplierSignTemplateEnum;
import com.ms.service.observer.SmsTemplateEvent;
import com.ms.service.observer.WxTemplateEvent;
import com.ms.tools.annotation.SecurityToken;
import com.ms.tools.entity.Result;
import com.sucai.compentent.logs.annotation.BizLog;
import me.chanjar.weixin.mp.bean.template.WxMpTemplateData;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import me.chanjar.weixin.mp.bean.template.WxMpTemplateMessage;


import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

/**
 * Created by xiao on 2016/12/2.
 */
@Controller
@RequestMapping("supplier/")
public class SupplierController {


    @Autowired
    private SupplierService supplierService;

    @Autowired
    private AreaService areaService;

    @Autowired
    private CommodityService commodityService;

    @Autowired
    private UserTrackRecordService userTrackRecordService;

    @Autowired
    private UserService userService;

    @Autowired
    private ApplicationContext applicationContext;

    /**
     * 供应商list
     * @param supplierVo
     * @param pageNum
     * @param pageSize
     * @param model
     * @return
     */

    @RequestMapping(value = "list", method = RequestMethod.GET)
    @BizLog(type = LogTypeConstant.SUPPLIER, desc = "供应商列表")
    public String supplierList(SupplierVo supplierVo, Integer pageNum,
                               Integer pageSize, ModelMap model){

        PageInfo<SupplierVo> supplierVoPageInfo = supplierService.findVoByParams(supplierVo,pageNum,pageSize);
        model.put("supplierVoPageInfo",supplierVoPageInfo);


        return "supplier_list";
    }

    /**
     *
     * @return
     */
    @RequestMapping(value = "create", method = RequestMethod.GET)
    @SecurityToken(generateToken = true)
    public String createSupplier(ModelMap model){
        //查询全国所有省份，供一级区域菜单使用，故parentid为100000
        Integer parentid = 100000;
        List<Area> provinces = areaService.findByParent(parentid);
        model.put("provinces", provinces);
        return  "supplier_detail";
    }




    /**
     * 供应商详情
     * @param id
     * @param model
     * @return
     */
    @RequestMapping(value = "detail/{id}", method = RequestMethod.GET)
    @SecurityToken(generateToken = true)
    @BizLog(type = LogTypeConstant.SUPPLIER, desc = "供应商详情")
    public String supplierDetail(@PathVariable("id") Integer id,ModelMap model){

        SupplierVo supplierVo=supplierService.findVoById(id);


        List<CommodityVo> commodityVos=commodityService.findBySupplier(id);

        model.put("supplierVo",supplierVo);
        model.put("commodityVos",commodityVos);

        //查出该供应商区域数据
        AreaVo areaVo = areaService.findVoById(supplierVo.getArea());
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

        //读取跟踪记录数据
        UserTrackRecordVo userTrackRecordVo = new UserTrackRecordVo();
        userTrackRecordVo.setSupplierId(id);
        List<UserTrackRecordVo> userTrackRecordVos = userTrackRecordService.findByParamsNoPage(userTrackRecordVo);
        model.put("userTrackRecordVos", userTrackRecordVos);

        return "supplier_detail";
    }

    /**
     * 保存供应商
     * @param supplierVo
     * @return
     */
    @RequestMapping(value = "save", method = RequestMethod.POST)
    @ResponseBody
    @SecurityToken(validateToken=true)
    @BizLog(type = LogTypeConstant.SUPPLIER, desc = "保存供应商")
    public Result saveSupplier(SupplierVo supplierVo){
        supplierService.save(supplierVo);
        return Result.success("保存成功");
    }

    /**
     * 根据姓名查询供应商
     * @param name
     * @return
     */
    @RequestMapping(value = "search", method = RequestMethod.POST)
    @ResponseBody
    @BizLog(type = LogTypeConstant.SUPPLIER, desc = "根据姓名查询供应商")
    public Result search(String name){
        return Result.success("供应商列表").data(supplierService.search(name));
    }

    /**
     * 供应商签约入驻
     * @param supplierVo
     * @return
     */
    @RequestMapping(value = "sign", method = RequestMethod.POST)
    @ResponseBody
    @BizLog(type = LogTypeConstant.SUPPLIER, desc = "签约供应商")
    public Result sign(SupplierVo supplierVo, String pwd){
        //supplier数据转存到user
        UserVo userVo = new UserVo();
        userVo.setPhone(supplierVo.getPhone());
        userVo.setPassword(pwd);

        UserDetailVo userDetailVo = new UserDetailVo();
        userDetailVo.setName(supplierVo.getName());
        userDetailVo.setPhone(supplierVo.getPhone());
        userDetailVo.setCategoryIds(supplierVo.getEnterCategory());
        userDetailVo.setCompany(supplierVo.getCompany());
        userDetailVo.setArea(supplierVo.getArea());
        userDetailVo.setEmail(supplierVo.getEmail());
        userDetailVo.setQq(supplierVo.getQq());
        userDetailVo.setRemark(supplierVo.getMark());
        userVo = userService.sign(userVo, userDetailVo);



        //supplier的user_track_record添加user_id字段值
        UserTrackRecord userTrackRecord = new UserTrackRecord();
        userTrackRecord.setUserId(userVo.getId());
        userTrackRecord.setSupplierId(supplierVo.getId());
        userTrackRecordService.update(userTrackRecord);

        //删除supplier的值
        supplierService.deleteById(supplierVo.getId());

        //发短信（短信需要手机号，模板id及params）和微信（微信模板消息需要，模板id，openid及params map）
        if(userVo.getOpenid() != null) {
            WxMpTemplateMessage templateMessage = new WxMpTemplateMessage();
            templateMessage.setToUser(userVo.getOpenid());
            templateMessage.setTemplateId(WxSupplierSignTemplateEnum.TEMPLATEID.get());
            templateMessage.setUrl(WxSupplierSignTemplateEnum.URL.get());
            templateMessage.getData().add(new WxMpTemplateData(WxSupplierSignTemplateEnum.PARAM1_NAME.get(),
                    WxSupplierSignTemplateEnum.PARAM1_VALUE.get(), WxSupplierSignTemplateEnum.PARAM1_COLOR.get()));
            templateMessage.getData().add(new WxMpTemplateData(WxSupplierSignTemplateEnum.PARAM2_NAME.get(),
                    WxSupplierSignTemplateEnum.PARAM2_VALUE.get(), WxSupplierSignTemplateEnum.PARAM2_COLOR.get()));
            templateMessage.getData().add(new WxMpTemplateData(WxSupplierSignTemplateEnum.PARAM3_NAME.get(),
                    WxSupplierSignTemplateEnum.PARAM3_VALUE.get(), WxSupplierSignTemplateEnum.PARAM3_COLOR.get()));
            templateMessage.getData().add(new WxMpTemplateData(WxSupplierSignTemplateEnum.PARAM4_NAME.get(),
                    WxSupplierSignTemplateEnum.PARAM4_VALUE.get(), WxSupplierSignTemplateEnum.PARAM4_COLOR.get()));
            templateMessage.getData().add(new WxMpTemplateData(WxSupplierSignTemplateEnum.PARAM5_NAME.get(),
                    WxSupplierSignTemplateEnum.PARAM5_VALUE.get().replace("{1}", supplierVo.getPhone()).replace("{2}", pwd),
                    WxSupplierSignTemplateEnum.PARAM5_COLOR.get()));

            WxTemplateEvent wt = new WxTemplateEvent(templateMessage);
            applicationContext.publishEvent(wt);
        }

        SmsTemplateEvent sms = new SmsTemplateEvent(supplierVo.getPhone(), pwd);
        applicationContext.publishEvent(sms);

        return Result.success("保存成功");
    }


}
