package com.ms.boss.controller;

import com.github.pagehelper.PageInfo;
import com.ms.boss.config.LogTypeConstant;
import com.ms.dao.enums.SampleEnum;
import com.ms.dao.enums.TrackingEnum;
import com.ms.dao.model.*;
import com.ms.dao.vo.*;
import com.ms.service.*;
import com.ms.service.enums.MessageEnum;
import com.ms.service.observer.MsgConsumeEvent;
import com.ms.tools.annotation.SecurityToken;
import com.ms.tools.entity.Result;
import com.ms.tools.utils.Reflection;
import com.sucai.compentent.logs.annotation.BizLog;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.stream.Stream;

/**
 * Created by xiao on 2016/10/18.
 */
@Controller
@RequestMapping("sample/")
public class SendSampleController extends BaseController{

    @Autowired
    SendSampleService sendSampleService;

    @Autowired
    CommodityService commodityService;


    @Autowired
    SampleTrackingService sampleTrackingService;

    @Autowired
    TrackingDetailService trackingDetailService;

    @Autowired
    SampleAddressService sampleAddressServie;

    @Autowired
    UserDetailService userDetailServer;

    @Autowired
    HistoryCommodityService historyCommodityService;

    @Autowired
    AreaService areaService;

    @Autowired
    private ApplicationContext applicationContext;


    /**
     * 根据查询条件获取寄样列表
     * @param sendSampleVo
     * @param pageNum
     * @param pageSize
     * @param model
     * @return
     */
    @RequestMapping(value = "list", method = RequestMethod.GET)
    @BizLog(type = LogTypeConstant.SENDSAMPLE, desc = "寄样列表")
    public String listSample(SendSampleVo sendSampleVo, Integer pageNum,
                               Integer pageSize, ModelMap model
    ) {
        if(sendSampleVo.getAbandon()==null){
            sendSampleVo.setAbandon(0);
        }
        PageInfo<SendSampleVo> sendSampleVoPageInfo = sendSampleService.findByParams(sendSampleVo,pageNum,pageSize);
        sendSampleVoPageInfo.getList().forEach(s->{
            Area area = areaService.findById(s.getArea());
            s.setPosition(area.getPosition());
        });

        model.put("sendSampleVoPageInfo",sendSampleVoPageInfo);
        model.put("sendSampleVo",sendSampleVo);

        return "sample_list";
    }

    /**
     * 寄样单详情
     * @param id
     * @return
     */
    @RequestMapping(value = "detail/{id}", method = RequestMethod.GET)
    @SecurityToken(generateToken = true)
    @BizLog(type = LogTypeConstant.SENDSAMPLE, desc = "寄样详情")
    public String detail(@PathVariable("id") Integer id, ModelMap model)
    {
        //寄样单信息
        SendSampleVo sendSampleVo=sendSampleService.findDetailById(id);
        Area area = areaService.findById(sendSampleVo.getArea());
        sendSampleVo.setPosition(area.getPosition());


        //历史寄样单信息(需指定最多多少条，显示问题)
        SendSampleVo historyParam=new SendSampleVo();
        historyParam.setPhone(sendSampleVo.getPhone());
        PageInfo<SendSampleVo> historySend = sendSampleService.findByParams(historyParam,1,10);

        //用户详情
        UserDetailVo userDetail=userDetailServer.findByUserId(sendSampleVo.getUserId());
        if(userDetail==null){
            userDetail=new UserDetailVo();
        }

        //地址信息
        SampleAddressVo sampleAdderss= sampleAddressServie.findBySendId(sendSampleVo.getId());
        if(sampleAdderss==null){
            sampleAdderss=new SampleAddressVo();
        }

        //寄样单跟踪状态
        SampleTrackingVo sampleTrackingVo=new SampleTrackingVo();
        sampleTrackingVo.setSendId(sendSampleVo.getId());
        List<SampleTrackingVo> trackingList=sampleTrackingService.findAllByParams(sampleTrackingVo);

        model.put("sendSampleVo",sendSampleVo);
        model.put("historySend",historySend);
        model.put("userDetail",userDetail);
        model.put("sampleAdderss",sampleAdderss);
        model.put("trackingList",trackingList);


        return "sample_detail";
    }

    /**
     * 废弃或恢复
     * @return
     */
    @RequestMapping(value = "delete", method = RequestMethod.POST)
    @ResponseBody
    @BizLog(type = LogTypeConstant.SENDSAMPLE, desc = "废弃或恢复寄样单")
    public Result delete(SendSample sendSample) {
        sendSampleService.update(sendSample);
        if(sendSample.getAbandon()==1){
            MsgConsumeEvent msgConsumeEvent=new MsgConsumeEvent(sendSample.getId(), MessageEnum.SAMPLE);
            applicationContext.publishEvent(msgConsumeEvent);
        }
        return Result.success().msg("修改成功");
    }

    /**
     * 用户信息保存
     * @param userDetail
     * @return
     */
    @RequestMapping(value = "userComplete",method = RequestMethod.POST)
    @ResponseBody
    @BizLog(type = LogTypeConstant.SENDSAMPLE, desc = "用户信息保存")
    public Result userComplete(UserDetail userDetail){
        userDetailServer.save(userDetail);
        return Result.success().msg("保存成功");
    }

    /**
     * 地址信息保存，还有商品意向变化
     * @param address
     * @param intention
     * @return
     */
    @RequestMapping(value = "addressSave",method=RequestMethod.POST)
    @ResponseBody
    @BizLog(type = LogTypeConstant.SENDSAMPLE, desc = "地址信息保存和商品意向变化")
    public Result addressSave(SampleAddress address,String intention){
        sampleAddressServie.save(address);
        SendSample sendSample=new SendSample();
        sendSample.setId(address.getSendId());

        List<CommodityVo> commodityList =commodityService.findByIds(intention);

        List<Integer> ids=new ArrayList<>();

        commodityList.forEach(c->{
            HistoryCommodity historyCommodity=historyCommodityService.saveCommodity(c);
            ids.add(historyCommodity.getId());
        });

        sendSample.setIntention(StringUtils.join(ids,","));
        sendSampleService.update(sendSample);
        return Result.success().msg("保存成功");
    }







}
