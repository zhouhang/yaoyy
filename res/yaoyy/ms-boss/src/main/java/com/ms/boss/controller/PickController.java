package com.ms.boss.controller;

import com.github.pagehelper.PageInfo;
import com.ms.dao.enums.PickEnum;
import com.ms.dao.enums.PickTrackingTypeEnum;
import com.ms.dao.enums.TrackingTypeEnum;
import com.ms.dao.model.*;
import com.ms.dao.vo.*;
import com.ms.service.*;
import com.ms.service.enums.MessageEnum;
import com.ms.service.enums.RedisEnum;
import com.ms.service.observer.MsgConsumeEvent;
import com.ms.tools.entity.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.List;

/**
 * Created by xiao on 2016/10/28.
 */
@Controller
@RequestMapping(value="pick/")
public class PickController extends BaseController{

    @Autowired
    private PickService pickService ;

    @Autowired
    private PickCommodityService pickCommodityService;

    @Autowired
    private PickTrackingService pickTrackingService;

    @Autowired
    private UserDetailService userDetailService;


    @Autowired
    HttpSession httpSession;

    @Autowired
    private ApplicationContext applicationContext;

    @Autowired
    private ShippingAddressHistoryService shippingAddressHistoryService;

    @Autowired
    private OrderInvoiceService orderInvoiceService;

    @Autowired
    private PayRecordService payRecordService;

    /**
     * 选货单列表
     * @param pickVo
     * @param pageNum
     * @param pageSize
     * @param model
     * @return
     */
    @RequestMapping(value = "list", method = RequestMethod.GET)
    private String list(PickVo pickVo,Integer pageNum, Integer pageSize, ModelMap model){
        if(pickVo.getAbandon()==null){
            pickVo.setAbandon(0);
        }
        PageInfo<PickVo> pickVoPageInfo = pickService.findByParams(pickVo, pageNum, pageSize);
        model.put("pickVoPageInfo", pickVoPageInfo);
        return "pick_list";
    }

    /**
     * 选货单详情
     * @param id
     * @param model
     * @return
     */
    @RequestMapping(value = "detail/{id}", method = RequestMethod.GET)
    private String detail(@PathVariable("id") Integer id, String edit, ModelMap model){
        PickVo pickVo=pickService.findVoById(id);
        UserDetail userDetail=userDetailService.findByUserId(pickVo.getUserId());
        if(userDetail==null){
            userDetail=new UserDetail();
        }

        List<PickTrackingVo> pickTrackingVos=pickTrackingService.findByPickId(id);
        model.put("pickVo",pickVo);
        model.put("userDetail",userDetail);
        model.put("pickTrackingVos",pickTrackingVos);
        if(edit!=null){
            return "pick_info3";
        }
       if(pickVo.getStatus()== PickEnum.PICK_NOTHANDLE.getValue()
                ||pickVo.getStatus()==PickEnum.PICK_REFUSE.getValue()
                ||pickVo.getStatus()==PickEnum.PICK_HANDING.getValue()
                ||pickVo.getStatus()==PickEnum.PICK_NOTFINISH.getValue()
                ){
            return "pick_info1";
        }
        else{
           //获取支付信息,收货信息和发票信息
            PayRecordVo param=new PayRecordVo();
            param.setCodeType(0);
            param.setOrderId(pickVo.getId());
            if(pickVo.getStatus()==PickEnum.PICK_PAY.getValue()){
                param.setStatus(0);
            }
            else{
                param.setStatus(1);
            }
            PayRecordVo payRecord=payRecordService.findByOrderId(param);
            OrderInvoiceVo orderInvoiceVo=orderInvoiceService.findByOrderId(pickVo.getId());
            ShippingAddressHistory shippingAddressHistory=null;
            if(pickVo.getAddrHistoryId()!=null){
                 shippingAddressHistory=shippingAddressHistoryService.findById(pickVo.getAddrHistoryId());
            }
            model.put("payRecord",payRecord);
            model.put("shippingAddressHistory",shippingAddressHistory);
            model.put("orderInvoiceVo",orderInvoiceVo);
            return "pick_info2";
        }

    }

    /**
     * 删除和恢复
     * @param pick
     * @return
     */
    @RequestMapping(value="delete",method = RequestMethod.POST)
    @ResponseBody
    private Result delete(Pick pick){
        pickService.update(pick);
        if(pick.getAbandon()==1){
            MsgConsumeEvent msgConsumeEvent=new MsgConsumeEvent(pick.getId(), MessageEnum.PICK);
            applicationContext.publishEvent(msgConsumeEvent);
        }
        return Result.success().msg("操作成功");
    }

    /**
     * 选货单跟踪记录
     * @param pickTrackingVo
     * @return
     */
    @RequestMapping(value="trackingSave",method=RequestMethod.POST)
    @ResponseBody
    private Result save(PickTrackingVo pickTrackingVo){

        Member mem= (Member) httpSession.getAttribute(RedisEnum.MEMBER_SESSION_BOSS.getValue());
        pickTrackingVo.setOperator(mem.getId());
        pickTrackingVo.setOpType(TrackingTypeEnum.TYPE_ADMIN.getValue());
        pickTrackingVo.setName(mem.getName());
        pickTrackingService.save(pickTrackingVo);

        return Result.success().msg("保存成功");
    }

    /**
     * 生成订单
     * @param pickVo
     * @return
     */
    @RequestMapping(value="createOrder",method=RequestMethod.POST)
    @ResponseBody
    private Result createOrder(PickVo pickVo){
        Member mem= (Member) httpSession.getAttribute(RedisEnum.MEMBER_SESSION_BOSS.getValue());
        pickVo.setMemberId(mem.getId());
        pickService.createOrder(pickVo);
        return Result.success().msg("生成订单成功");
    }

    @RequestMapping(value="updateOrder",method=RequestMethod.POST)
    @ResponseBody
    private Result updateOrder(@RequestBody PickVo pickVo){
        Member mem= (Member) httpSession.getAttribute(RedisEnum.MEMBER_SESSION_BOSS.getValue());
        pickVo.setMemberId(mem.getId());
        pickService.createOrder(pickVo);
        return Result.success().msg("修改订单成功");
    }


    @RequestMapping(value="updateNum",method=RequestMethod.POST)
    @ResponseBody
    private Result updateNum(@RequestBody List<PickCommodity> pickCommodities){
        //修改数量
        Integer pickId=null;
        PickTrackingVo pickTrackingVo=null;
        if(pickCommodities.size()>0){
            pickId=pickCommodities.get(0).getPickId();
        }

        if(pickId!=null){
            //保存一条修改记录
            Member mem= (Member) httpSession.getAttribute(RedisEnum.MEMBER_SESSION_BOSS.getValue());
            pickTrackingVo=new PickTrackingVo();
            pickTrackingVo.setPickId(pickId);
            pickTrackingVo.setOperator(mem.getId());
            pickTrackingVo.setOpType(TrackingTypeEnum.TYPE_ADMIN.getValue());
            pickTrackingVo.setName(mem.getName());
        }

        pickService.updateCommodityNum(pickCommodities,pickTrackingVo);


        return Result.success().msg("修改成功");
    }












}
