package com.ms.boss.controller;

import com.github.pagehelper.PageInfo;
import com.ms.dao.enums.PickEnum;
import com.ms.dao.enums.PickTrackingTypeEnum;
import com.ms.dao.enums.TrackingTypeEnum;
import com.ms.dao.model.Member;
import com.ms.dao.model.PayRecord;
import com.ms.dao.vo.PayRecordVo;
import com.ms.dao.vo.PickTrackingVo;
import com.ms.service.PayRecordService;
import com.ms.service.PickService;
import com.ms.service.PickTrackingService;
import com.ms.service.enums.RedisEnum;
import com.ms.tools.entity.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;


/**
 * 交易流水
 * Created by xiao on 2016/12/26.
 */
@Controller
@RequestMapping(value = "payRecord/")
public class PayRecordController extends BaseController{

    @Autowired
    private PayRecordService payRecordService;

    @Autowired
    private PickService pickService;

    @Autowired
    private PickTrackingService pickTrackingService;

    @Autowired
    HttpSession httpSession;


    /**
     * 交易流水列表
     * @param payRecordVo
     * @param pageNum
     * @param pageSize
     * @param model
     * @return
     */
    @RequestMapping(value = "list", method = RequestMethod.GET)
    public String list(PayRecordVo payRecordVo,Integer pageNum, Integer pageSize, ModelMap model){

        PageInfo<PayRecordVo> payRecordVos=payRecordService.findByParams(payRecordVo,pageNum,pageSize);
        model.put("pageInfo",payRecordVos);

        return "pay_record_list";
    }

    /**
     * 交易流水详情
     * @param id
     * @param model
     * @return
     */
    @RequestMapping(value = "detail/{id}", method = RequestMethod.GET)
    public  String detail(@PathVariable("id") Integer id, ModelMap model){
        PayRecordVo payRecordVo=payRecordService.findVoById(id);
        model.put("payRecordVo",payRecordVo);
        return "pay_record_detail";
    }
    /**
     * 确认收款
     */
    @RequestMapping(value = "config", method = RequestMethod.POST)
    @ResponseBody
    @Transactional
    public Result config(Integer payRecordId, Integer orderId){
        PayRecord payRecord=new PayRecord();
        payRecord.setId(payRecordId);
        payRecord.setStatus(1);
        payRecordService.update(payRecord);

        //确认收款之后记录一条记录用户付全款的跟踪记录
        Member mem= (Member) httpSession.getAttribute(RedisEnum.MEMBER_SESSION_BOSS.getValue());
        PickTrackingVo pickTrackingVo=new PickTrackingVo();
        pickTrackingVo.setPickId(orderId);
        pickTrackingVo.setOperator(mem.getId());
        pickTrackingVo.setOpType(TrackingTypeEnum.TYPE_ADMIN.getValue());
        pickTrackingVo.setName(mem.getName());
        pickTrackingVo.setRecordType(PickTrackingTypeEnum.PICK_PAYALL.getValue());
        pickTrackingService.save(pickTrackingVo);

        return Result.success().data("确认收款");
    }


}
