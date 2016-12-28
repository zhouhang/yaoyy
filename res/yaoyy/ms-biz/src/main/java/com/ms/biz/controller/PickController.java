package com.ms.biz.controller;

import com.github.pagehelper.PageInfo;
import com.ms.dao.model.*;
import com.ms.dao.vo.PayRecordVo;
import com.ms.dao.vo.PickCommodityVo;
import com.ms.dao.vo.PickTrackingVo;
import com.ms.dao.vo.PickVo;
import com.ms.service.*;
import com.ms.service.enums.RedisEnum;
import com.ms.tools.entity.Result;
import com.ms.tools.entity.ResultStatus;
import com.ms.tools.exception.ControllerException;
import com.ms.tools.ueditor.CropResult;
import com.ms.tools.upload.UploadService;
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
import org.springframework.web.multipart.MultipartFile;

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

    @Autowired
    private OrderInvoiceService orderInvoiceService;

    @Autowired
    UploadService uploadService;

    @Autowired
    PayRecordService payRecordService;

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


    /**
     * 保存订单信息
     * @param pickVo
     * @param type 支付类型 根据不同的类型返回不同的跳转Url
     * @return
     */
    @RequestMapping(value = "save", method = RequestMethod.POST)
    @ResponseBody
    public Result save(PickVo pickVo,Integer type){
        User user = (User) httpSession.getAttribute(RedisEnum.USER_SESSION_BIZ.getValue());
        pickVo.setUserId(user.getId());
        pickService.saveOrder(pickVo);
        return null;
    }

    /**
     *取消订单
     * @param id
     * @return
     */
    @RequestMapping(value = "cancel", method = RequestMethod.POST)
    public String cancel(Integer id){
        User user = (User) httpSession.getAttribute(RedisEnum.USER_SESSION_BIZ.getValue());
        pickService.cancel(id,user.getId());
        return "redirect:/pick/cancelSuccess";
    }

    /**
     * 取消成功页面
     * @return
     */
    @RequestMapping(value = "cancelSuccess", method = RequestMethod.GET)
    public String cancelSuccess(){
        return "";
    }

    /**
     * 确认收货
     * @param id
     * @return
     */
    @RequestMapping(value = "receipt", method = RequestMethod.POST)
    @ResponseBody
    public Result receipt(Integer id){
        User user = (User) httpSession.getAttribute(RedisEnum.USER_SESSION_BIZ.getValue());
        pickService.receipt(id,user.getId());
        return Result.success("订单完成");
    }

    /**
     * 银行转账页面
     * @param orderId
     * @return
     */
    @RequestMapping(value = "bankTransfer", method = RequestMethod.GET)
    public String bankTransfer(Integer orderId, ModelMap model){
        // 根据订单Id 获取转账金额.同时确认订单属于当前用户
        User user = (User) httpSession.getAttribute(RedisEnum.USER_SESSION_BIZ.getValue());
        Pick pick = pickService.findById(orderId);
        if (!(pick!= null && pick.getUserId() == user.getId())){
            throw new ControllerException("用户无权限访问此付款页面.");
        }
        model.put("total",pick.getAmountsPayable());
        return "";
    }

    /**
     * 上传转账图片
     * @param img
     * @return
     */
    @RequestMapping(value = "/upload", method = RequestMethod.POST)
    @ResponseBody
    public CropResult updateFile(@RequestParam(required = false) MultipartFile img) throws Exception{
        return uploadService.uploadImage(img);
    }

    /**
     * 保存银行转账
     * @param record
     * @return
     */
    @RequestMapping(value = "bankTransfer", method = RequestMethod.POST)
    public String bankTransferSave(PayRecordVo record){
        // 根据订单Id同时确认订单属于当前用户
        User user = (User) httpSession.getAttribute(RedisEnum.USER_SESSION_BIZ.getValue());
        Pick pick = pickService.findById(record.getOrderId());
        if (!(pick!= null && pick.getUserId() == user.getId())){
            throw new ControllerException("用户无权限访问此付款页面.");
        }
        record.setUserId(user.getId());
        record.setCode(pick.getCode());
        payRecordService.save(record);
        return "redirect:/pick/bankTransferSuccess";
    }

    /**
     * 转账成功页面
     * @return
     */
    @RequestMapping(value = "bankTransferSuccess", method = RequestMethod.GET)
    public String bankTransferSuccess(){
        return "";
    }

    /**
     * 支付成功页面
     * @return
     */
    @RequestMapping(value = "paySuccess", method = RequestMethod.GET)
    public String paySuccess(){
        return "";
    }

}
