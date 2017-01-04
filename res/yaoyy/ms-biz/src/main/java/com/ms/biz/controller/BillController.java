package com.ms.biz.controller;

import com.github.pagehelper.PageInfo;
import com.ms.dao.model.Pick;
import com.ms.dao.model.User;
import com.ms.dao.vo.AccountBillVo;
import com.ms.dao.vo.PayRecordVo;
import com.ms.dao.vo.PickVo;
import com.ms.dao.vo.UserDetailVo;
import com.ms.service.AccountBillService;
import com.ms.service.PayRecordService;
import com.ms.service.PickService;
import com.ms.service.UserDetailService;
import com.ms.service.enums.RedisEnum;
import com.ms.tools.entity.Result;
import com.ms.tools.exception.NotFoundException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;

/**
 * Author: koabs
 * 1/4/17.
 * 账单
 */
@Controller
@RequestMapping("/bill")
public class BillController {
    @Autowired
    private HttpSession httpSession;

    @Autowired
    private AccountBillService accountBillService;

    @Autowired
    private PayRecordService payRecordService;

    @Autowired
    private PickService pickService;

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
    @RequestMapping(value = "/{id}", method = RequestMethod.GET)
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
}
