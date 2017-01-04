package com.ms.biz.controller;

import com.github.pagehelper.PageInfo;
import com.ms.dao.enums.*;
import com.ms.dao.model.*;
import com.ms.dao.vo.*;
import com.ms.service.*;
import com.ms.service.enums.RedisEnum;
import com.ms.tools.entity.BASE64DecodedMultipartFile;
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
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.commons.CommonsMultipartFile;
import sun.misc.BASE64Decoder;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.ByteArrayInputStream;
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

    @Autowired
    ShippingAddressHistoryService shippingAddressHistoryService;

    @Autowired
    ShippingAddressService shippingAddressService;

    @Autowired
    LogisticalService logisticalService;

    @Autowired
    AccountBillService accountBillService;

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
        User user = (User) httpSession.getAttribute(RedisEnum.USER_SESSION_BIZ.getValue());
        PickVo pickVo=pickService.findVoById(id);
        if (!(pickVo!= null && pickVo.getUserId().equals(user.getId()))){
            throw new ControllerException("用户无权限访问此页面.");
        }
        List<PickTrackingVo> pickTrackingVos=pickTrackingService.findByPickId(id);

        model.put("pickVo",pickVo);
        model.put("pickTrackingVos",pickTrackingVos);

        //  获取默认的收货地址
        if (pickVo.getAddrHistoryId() == null){
            // 获取默认地址信息
            ShippingAddressVo address = shippingAddressService.getDefault(user.getId());
            model.put("address", address);
        } else {
            ShippingAddressHistory shippingAddressHistory=shippingAddressHistoryService.findById(pickVo.getAddrHistoryId());
            // 设置 历史地址id 为-1;
            shippingAddressHistory.setId(-1);
            model.put("address", shippingAddressHistory);
        }

        // 处于已发货状态获取物流信息
        LogisticalVo logisticalVo=logisticalService.findByOrderId(pickVo.getId());
        model.put("logistical",logisticalVo);

        // 发票信息
        OrderInvoiceVo orderInvoiceVo=orderInvoiceService.findByOrderId(pickVo.getId());
        model.put("orderInvoiceVo",orderInvoiceVo);
        if (orderInvoiceVo!= null) {
            // 订单为待支付状态时才设置
            model.put("orderInvoiceSession", GsonUtil.toJson(orderInvoiceVo));
        }
        if (pickVo.getRemark()!= null) {
            model.put("remarkSession", pickVo.getRemark());
        }

        return "pick_detail";
    }

    /**
     * 订单备注页面
     * 订单备注信息 保存于SessionStorage中 订单提交后删除
     * @param id
     * @return
     */
    @RequestMapping(value="note/{id}",method=RequestMethod.GET)
    public String note(@PathVariable("id") Integer id, ModelMap model){
        model.put("id",id);
        return "pick_note";
    }

    /**
     * 保存发票信息
     * @param id
     * @param model
     * @return
     */
    @RequestMapping(value="invoice/{id}",method=RequestMethod.GET)
    public String invoice(@PathVariable("id") Integer id, ModelMap model){
        model.put("id",id);
        return "pick_invoice";
    }

    /**
     * 保存订单信息
     * @param pickVo
     * @param type 支付类型 根据不同的类型返回不同的跳转Url
     * @return
     */
    @RequestMapping(value = "save", method = RequestMethod.POST, consumes = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public Result save(@RequestBody PickVo pickVo,Integer type){
        Result result = null;
        User user = (User) httpSession.getAttribute(RedisEnum.USER_SESSION_BIZ.getValue());
        pickVo.setUserId(user.getId());
        pickService.saveOrder(pickVo);

        if (type == 1) {
            // 根据type 类型返回不同的跳转链接
            result = Result.success().data("/pick/bankTransfer?orderId="+pickVo.getId());
        }
        return result;
    }

    /**
     *取消订单
     * @param id
     * @return
     */
    @RequestMapping(value = "cancel", method = RequestMethod.POST)
    @ResponseBody
    public Result cancel(Integer id){
        User user = (User) httpSession.getAttribute(RedisEnum.USER_SESSION_BIZ.getValue());
        pickService.cancel(id,user.getId());
        return Result.success("订单取消成功!");
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
        if (!(pick!= null && pick.getUserId().equals(user.getId()))){
            throw new ControllerException("用户无权限访问此付款页面.");
        }
        PayRecordVo param=new PayRecordVo();
        param.setCodeType(0);
        param.setOrderId(orderId);
        PayRecordVo vo = payRecordService.findByOrderId(param);
        if(pick.getSettleType()!= SettleTypeEnum.SETTLE_DEPOSIT.getType()){
            model.put("total",pick.getAmountsPayable());
        }
        else{
            model.put("total",pick.getDeposit());
        }

        model.put("orderId",orderId);
        if (vo != null) {
            model.put("id", vo.getId());
            if (vo.getPayDocuments()!= null && vo.getPayDocuments().size()>0)
            model.put("url",vo.getPayDocuments().get(0).getPath());
        }
        return "pick_pay";
    }

    /**
     * 上传转账图片
     * @param img
     * @return
     */
    @RequestMapping(value = "/upload", method = RequestMethod.POST)
    @ResponseBody
    public CropResult updateFile(String img, String fileName) throws Exception{
        img=img.substring(img.indexOf(",")+1);//需要去掉头部信息，这很重要
        BASE64Decoder base64Decoder = new BASE64Decoder();
        byte[] result = base64Decoder.decodeBuffer(img);//解码
        BASE64DecodedMultipartFile multipartFile = new BASE64DecodedMultipartFile(result, fileName);
        return uploadService.uploadImage(multipartFile);
    }

    /**
     * 保存银行转账
     * @param record
     * @return
     */
    @RequestMapping(value = "bankTransfer", method = RequestMethod.POST)
    public String bankTransferSave(PayRecordVo record, String url){
        // 根据订单Id同时确认订单属于当前用户
        User user = (User) httpSession.getAttribute(RedisEnum.USER_SESSION_BIZ.getValue());
        Pick pick = pickService.findById(record.getOrderId());
        if (!(pick!= null && pick.getUserId().equals(user.getId()))){
            throw new ControllerException("用户无权限访问此付款页面.");
        }

        // 不处于待支付z状态的订单也无法访问此页面 跑出404 页面 TODO:

        PayDocumentVo document = new PayDocumentVo();
        document.setPath(url);
        List<PayDocumentVo> list = new ArrayList<>();
        list.add(document);
        record.setPayDocuments(list);
        record.setUserId(user.getId());
        record.setCode(pick.getCode());
        record.setCodeType(0);
        record.setStatus(0);
        record.setPayType(0);
        // 设置默认信息
        record.setPayAccount("亳州市东方康元中药材信息咨询有限公司");
        record.setPayBankCard("1318 0404 0926 6666 630");
        record.setPayBank("中国工商银行亳州谯陵分理处");
        // 判断之前没有支付记录TODO:
        payRecordService.save(record);


        //增加跟踪记录
        PickTrackingVo pickTrackingVo=new PickTrackingVo();
        pickTrackingVo.setPickId(record.getOrderId());
        pickTrackingVo.setOperator(user.getId());
        pickTrackingVo.setOpType(TrackingTypeEnum.TYPE_USER.getValue());
        pickTrackingVo.setName(pick.getNickname());
        pickTrackingVo.setRecordType(PickTrackingTypeEnum.PICK_SUBMIT_PAY.getValue());
        if(pickTrackingVo.getExtra()==null){
            pickTrackingVo.setExtra("");
        }
        pickTrackingVo.setCreateTime(new Date());
        pickTrackingVo.setUpdateTime(new Date());

        pickTrackingService.create(pickTrackingVo);




        return "redirect:/pick/bankTransferSuccess?orderId="+ record.getOrderId();
    }

    /**
     * 转账成功页面
     * @return
     */
    @RequestMapping(value = "bankTransferSuccess", method = RequestMethod.GET)
    public String bankTransferSuccess(Integer orderId, ModelMap model){
        model.put("orderId",orderId);
        return "pick_pay_success";
    }

    /**
     * 支付成功页面
     * @return
     */
    @RequestMapping(value = "paySuccess", method = RequestMethod.GET)
    public String paySuccess(Integer orderId,Integer billId, ModelMap model){
        model.put("orderId",orderId);
        model.put("billId",billId);
        return "pay_success";
    }

    /**
     * 确认成功页面
     * @return
     */
    @RequestMapping(value = "configSuccess", method = RequestMethod.GET)
    public String configSuccess(Integer orderId, ModelMap model){
        model.put("orderId",orderId);
        return "config_success";
    }



    /**
     * 确认账单
     * @param pickVo
     * @return
     */
    @RequestMapping(value="configBill",method = RequestMethod.POST, consumes = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    @Transactional
    public Result  configBill(@RequestBody PickVo pickVo){

        User user = (User) httpSession.getAttribute(RedisEnum.USER_SESSION_BIZ.getValue());
        pickVo.setUserId(user.getId());
        pickService.saveOrder(pickVo);
        //为用户生成账期
        PickVo pick=pickService.findVoById(pickVo.getId());
        AccountBillVo accountBillVo=new AccountBillVo();
        accountBillVo.setMemberId(pick.getMemberId());
        accountBillVo.setOrderId(pick.getId());
        accountBillVo.setUserId(pick.getUserId());
        accountBillVo.setBillTime(pick.getBillTime());
        accountBillVo.setAmountsPayable(pick.getAmountsPayable());
        accountBillVo.setAlreadyPayable(0.0f);
        accountBillService.saveAccountBill(accountBillVo);
        //更新为状态待发货状态
        pickService.changeOrderStatus(pick.getId(), PickEnum.PICK_DELIVERY.getValue());

        //增加跟踪记录
        PickTrackingVo pickTrackingVo=new PickTrackingVo();
        pickTrackingVo.setPickId(pick.getId());
        pickTrackingVo.setOperator(user.getId());
        pickTrackingVo.setOpType(TrackingTypeEnum.TYPE_USER.getValue());
        pickTrackingVo.setName(pick.getNickname());
        pickTrackingVo.setRecordType(PickTrackingTypeEnum.PICK_CONFIRM.getValue());
        if(pickTrackingVo.getExtra()==null){
            pickTrackingVo.setExtra("");
        }
        pickTrackingVo.setCreateTime(new Date());
        pickTrackingVo.setUpdateTime(new Date());

        pickTrackingService.create(pickTrackingVo);

        //跳转确认成功页面
        return  Result.success().data("/pick/configSuccess?orderId="+pickVo.getId());
    }


}
