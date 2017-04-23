package com.ms.biz.controller;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.ms.dao.model.PickCommodity;
import com.ms.dao.model.ShippingAddressHistory;
import com.ms.dao.model.User;
import com.ms.dao.vo.*;
import com.ms.service.CommodityService;
import com.ms.service.PickService;
import com.ms.service.ShippingAddressService;
import com.ms.service.UserService;
import com.ms.service.enums.RedisEnum;
import com.ms.service.utils.EncryptUtil;
import com.ms.tools.annotation.SecurityToken;
import com.ms.tools.editor.CustomStringEditor;
import com.ms.tools.entity.Result;
import com.ms.tools.utils.GsonUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.lang.reflect.Type;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by xiao on 2016/11/3.
 */
@Controller
@RequestMapping("pickCommodity/")
public class PickCommodityController extends BaseController{

    @Autowired
    private PickService pickService;
    @Autowired
    private HttpSession httpSession;
    @Autowired
    private UserService userService;
    @Autowired
    private CommodityService commodityService;

    @Autowired
    private ShippingAddressService shippingAddressService;

    /**
     * 未提交选货单之前的商品列表
     * @return
     */
    @RequestMapping(value="list",method= RequestMethod.GET)
    @SecurityToken(generateToken = true)
    public String commodityList(ModelMap model) throws Exception {
        User user = (User) httpSession.getAttribute(RedisEnum.USER_SESSION_BIZ.getValue());
        if(user!=null){
            model.put("phone", user.getPhone());
        }
        return "pick_commodity";
    }


    /**
     * 提交选货单
     * @return
     */
    @RequestMapping(value="save",method=RequestMethod.POST)
    @ResponseBody
    @SecurityToken(validateToken=true)
    public Result saveCommodity(String commoditys){
        //没注册和申请寄样一样处理
//        User user = (User) httpSession.getAttribute(RedisEnum.USER_SESSION_BIZ.getValue());
//        if(user!=null){
//            pickVo.setUserId(user.getId());
//        }
//        pickService.save(pickVo);
//
//        UserVo userInfo=userService.findByPhone(pickVo.getPhone());
        // 保存商品信息到session 里面 同时生成MD5值
        String md5 = EncryptUtil.getSHA1(commoditys,"UTF-8");
        httpSession.setAttribute(md5,commoditys);
        return Result.success().data(md5);
    }



    /**
     * 批量获取商品详情（购物车显示用）
     * @param list
     * @return
     */
    @RequestMapping(value="/getDetail",method=RequestMethod.POST,consumes = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public Result getDetail(@RequestBody List<Integer> list){
        StringBuilder ids = new StringBuilder();
        if (list != null && list.size() >0){
            list.forEach(sc ->{
                ids.append(sc).append(",");
            });
        }
        List<CommodityVo> commodities = commodityService.findByIds(ids.substring(0,ids.length()-1));
        //按照供应商区分商品
        Map<Integer,CartVo> cartVoMap = new HashMap<>();
        commodities.forEach(commodity->{
            if(cartVoMap.containsKey(commodity.getSupplierId())){
                cartVoMap.get(commodity.getSupplierId()).getCommodities().add(commodity);
            }else{
                CartVo cartVo = new CartVo();
                cartVo.setSupplierId(commodity.getSupplierId());
                cartVo.setSupplierName(commodity.getSupplierName());
                cartVo.setSupplierCompany(commodity.getSupplierCompany());
                cartVo.getCommodities().add(commodity);
                cartVoMap.put(commodity.getSupplierId(),cartVo);
            }
        });

        List<CartVo> cartVoList = new ArrayList<>();
        cartVoMap.forEach((id,cartVo)->{
            cartVoList.add(cartVo);
        });
        return Result.success().data(cartVoList);
    }


    /**
     * 申请寄样
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value="apply",method= RequestMethod.GET)
    @SecurityToken(generateToken = true)
    public String apply(ModelMap model,String md5) throws Exception {
        User user = (User) httpSession.getAttribute(RedisEnum.USER_SESSION_BIZ.getValue());
        String commoditiesV = (String) httpSession.getAttribute(md5);
        Type type = new TypeToken<ArrayList<PickCommodity>>() {
        }.getType();
        Gson gson = new Gson();
        List<PickCommodity> list = gson.fromJson(commoditiesV,type);
        StringBuilder ids = new StringBuilder();
        Map<Integer, Float> map = new HashMap<>();
        list.forEach(c->{
            ids.append(c.getCommodityId()).append(",");
            map.put(c.getCommodityId(),c.getNum());
        });
        List<CommodityVo> commodities = commodityService.findByIds(ids.substring(0,ids.length()-1));
        commodities.forEach(commodity->{
            commodity.setWarehouse(map.get(commodity.getId()));
        });
        model.put("commodities", commodities);
        ShippingAddressVo address = shippingAddressService.getDefault(user.getId());
        model.put("address", address);
        model.put("md5",md5);

        return "pick_apply";
    }

    // 保存订单
    @RequestMapping(value="apply",method= RequestMethod.POST)
    @SecurityToken(generateToken = true)
    public Result applySave(PickVo vo,String md5) throws Exception {
        User user = (User) httpSession.getAttribute(RedisEnum.USER_SESSION_BIZ.getValue());
        String commoditiesV = (String) httpSession.getAttribute(md5);
        Type type = new TypeToken<ArrayList<PickCommodityVo>>() {
        }.getType();
        Gson gson = new Gson();
        List<PickCommodityVo> list = gson.fromJson(commoditiesV,type);
        vo.setPickCommodityVoList(list);
        pickService.save(vo,user);
        return Result.success();
    }
}
