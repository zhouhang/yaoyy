package com.ms.biz.controller;

import com.ms.dao.model.ShippingAddress;
import com.ms.dao.model.User;
import com.ms.dao.vo.ShippingAddressVo;
import com.ms.service.ShippingAddressService;
import com.ms.service.enums.RedisEnum;
import com.ms.tools.annotation.SecurityToken;
import com.ms.tools.entity.Result;
import com.ms.tools.exception.ControllerException;
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
 * 12/26/16.
 * 收货地址
 */
@Controller
@RequestMapping("/address")
public class AddressController {

    @Autowired
    private ShippingAddressService addressService;

    @Autowired
    HttpSession httpSession;

    /**
     *  获取用户地址列表
     * @param model
     * @return
     */
    @RequestMapping("/list")
    public String list(ModelMap model){
        //获取登陆用户userId
        User user = (User) httpSession.getAttribute(RedisEnum.USER_SESSION_BIZ.getValue());
        model.put("addressList",addressService.findByUserId(user.getId()));
        return "address_list";
    }

    /**
     * 订单选择地址的列表
     * @param model
     * @return
     */
    @RequestMapping("/select")
    public String select(Integer orderId, ModelMap model){
        //获取登陆用户userId
        User user = (User) httpSession.getAttribute(RedisEnum.USER_SESSION_BIZ.getValue());
        model.put("addressList",addressService.findByUserId(user.getId()));
        model.put("orderId",orderId);
        return "address_select";
    }

    /**
     * 获取用户默认地址
     * @return
     */
    @RequestMapping(value = "/default", method = RequestMethod.POST)
    @ResponseBody
    public Result getDefault(){
        //获取登陆用户userId
        User user = (User) httpSession.getAttribute(RedisEnum.USER_SESSION_BIZ.getValue());
        return Result.success().data(addressService.getDefault(user.getId()));
    }

    /**
     * 保存地址
     * @param address
     * @return
     */
    @RequestMapping(value = "/save", method = RequestMethod.POST)
    @ResponseBody
    @SecurityToken(validateToken=true)
    public Result save(ShippingAddress address){
        //获取登陆用户userId
        User user = (User) httpSession.getAttribute(RedisEnum.USER_SESSION_BIZ.getValue());
        address.setUserId(user.getId());
        return Result.success().data(addressService.save(address));
    }

    /**
     * 删除地址
     * @param id
     * @return
     */
    @RequestMapping(value = "/delete/{id}", method = RequestMethod.POST)
    @ResponseBody
    public Result delete(@PathVariable("id") Integer id){
        //获取登陆用户userId
        User user = (User) httpSession.getAttribute(RedisEnum.USER_SESSION_BIZ.getValue());
        addressService.delete(user.getId(),id);
        return Result.success();
    }

    /**
     * 地址详情
     * @param id
     * @param model
     * @return
     */
    @RequestMapping("/detail/{id}")
    @SecurityToken(generateToken = true)
    public String detail(@PathVariable("id") Integer id, ModelMap model){
        //获取登陆用户userId
        User user = (User) httpSession.getAttribute(RedisEnum.USER_SESSION_BIZ.getValue());
        ShippingAddressVo addressVo = addressService.findVoById(id);
        if (!addressVo.getUserId().equals(user.getId())) {
            throw new ControllerException("没有权限访问该地址详情.");
        }
        model.put("vo",addressVo);
        return "address_detail";
    }

    @RequestMapping("/add")
    @SecurityToken(generateToken = true)
    public String addAddress(ModelMap model){
        return "add_address";
    }



}
