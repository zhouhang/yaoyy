package com.ms.biz.controller;

import com.ms.dao.model.Pick;
import com.ms.dao.model.Setting;
import com.ms.dao.model.User;
import com.ms.dao.vo.AccountBillVo;
import com.ms.dao.vo.PayDocumentVo;
import com.ms.dao.vo.PayRecordVo;
import com.ms.service.AccountBillService;
import com.ms.service.PayRecordService;
import com.ms.service.PickService;
import com.ms.service.SettingService;
import com.ms.service.enums.RedisEnum;
import com.ms.tools.entity.Result;
import com.ms.tools.exception.ControllerException;
import com.ms.tools.exception.NotFoundException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;

/**
 * Author: koabs
 * 1/4/17.
 * 账单
 */
@Controller
@RequestMapping("/bill")
public class BillController extends BaseController{
    @Autowired
    private HttpSession httpSession;

    @Autowired
    private AccountBillService accountBillService;

    @Autowired
    private PayRecordService payRecordService;

    @Autowired
    private PickService pickService;

    @Autowired
    SettingService settingService;

    /**
     * 账单列表页面
     * @return
     */
    @RequestMapping(value = "", method = RequestMethod.GET)
    public String list(){
        return "bill_list";
    }

    /**
     * 账单列表数据
     * @param pageNum
     * @param pageSize
     * @return
     */
    @RequestMapping(value = "", method = RequestMethod.POST)
    @ResponseBody
    public Result listData(Integer pageNum, Integer pageSize){
        User user = (User) httpSession.getAttribute(RedisEnum.USER_SESSION_BIZ.getValue());
        return Result.success().data(accountBillService.findByUserId(user.getId(), pageNum, pageSize));
    }


    /**
     *账单详情页面
     * @param id
     * @param model
     * @return
     */
    @RequestMapping(value = "/detail/{id}", method = RequestMethod.GET)
    public  String detail(@PathVariable("id") Integer id, ModelMap model){
        User user = (User) httpSession.getAttribute(RedisEnum.USER_SESSION_BIZ.getValue());
        AccountBillVo accountBillVo=accountBillService.findVoById(id);
        if(accountBillVo==null || !accountBillVo.getUserId().equals(user.getId())){
            throw new NotFoundException("找不到该账单");
        }
        PayRecordVo payRecordVo=payRecordService.findByBillId(id);
        Pick pick = pickService.findById(accountBillVo.getOrderId());
        model.put("bill",accountBillVo);
        model.put("payRecord",payRecordVo);
        model.put("pick",pick);
        return "bill_detail";
    }

    /**
     * 银行转账页面
     * @param billId
     * @return
     */
    @RequestMapping(value = "bankTransfer", method = RequestMethod.GET)
    public String bankTransfer(Integer billId, ModelMap model){
        // 根据订单Id 获取转账金额.同时确认订单属于当前用户
        User user = (User) httpSession.getAttribute(RedisEnum.USER_SESSION_BIZ.getValue());
        AccountBillVo bill=accountBillService.findVoById(billId);
        if (!(bill!= null && bill.getUserId().equals(user.getId()))){
            throw new ControllerException("用户无权限访问此付款页面.");
        }
        model.put("total",bill.getAmountsPayable()-bill.getAlreadyPayable());
        PayRecordVo payRecord = payRecordService.findByBillId(billId);
        if (payRecord != null) {
            model.put("id", payRecord.getId());
            if (payRecord.getPayDocuments()!= null && payRecord.getPayDocuments().size()>0)
                model.put("url",payRecord.getPayDocuments().get(0).getPath());
        }
        // 后台配置的银行信息
        Setting setting = settingService.find();
        model.put("setting", setting);
        model.put("billId", billId);
        return "bill_pay";
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
        AccountBillVo bill=accountBillService.findVoById(record.getAccountBillId());
        if (!(bill!= null && bill.getUserId().equals(user.getId()))){
            throw new ControllerException("用户无权限访问此付款页面.");
        }

        PayDocumentVo document = new PayDocumentVo();
        document.setPath(url);
        List<PayDocumentVo> list = new ArrayList<>();
        list.add(document);
        record.setPayDocuments(list);
        record.setUserId(user.getId());
        record.setCode(bill.getCode());
        record.setCodeType(1);
        record.setStatus(0);
        record.setPayType(0);
        record.setActualPayment(bill.getAmountsPayable()-bill.getAlreadyPayable());
        // 设置默认信息
        // 后台配置的银行信息
        Setting setting = settingService.find();
        record.setPayAccount(setting.getPayAccount());
        record.setPayBankCard(setting.getPayBankCard());
        record.setPayBank(setting.getPayBank());
        // 判断之前没有支付记录TODO:
        payRecordService.save(record);
        return "redirect:/bill/bankTransferSuccess?billId="+ record.getAccountBillId();
    }

    /**
     * 转账成功页面
     * @return
     */
    @RequestMapping(value = "bankTransferSuccess", method = RequestMethod.GET)
    public String bankTransferSuccess(Integer billId, ModelMap model){
        model.put("billId",billId);
        return "bill_pay_success";
    }
}
