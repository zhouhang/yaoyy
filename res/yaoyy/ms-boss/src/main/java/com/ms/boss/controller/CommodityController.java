package com.ms.boss.controller;

import com.github.pagehelper.PageInfo;
import com.ms.boss.config.LogTypeConstant;
import com.ms.dao.model.Commodity;
import com.ms.dao.model.HistoryPrice;
import com.ms.dao.model.Member;
import com.ms.dao.vo.CommodityVo;
import com.ms.dao.vo.HistoryPriceVo;
import com.ms.service.CommodityService;
import com.ms.service.enums.RedisEnum;
import com.ms.tools.annotation.SecurityToken;
import com.ms.tools.entity.Result;
import com.sucai.compentent.logs.annotation.BizLog;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.List;

/**
 * Author: koabs
 * 10/12/16.
 */
@Controller
@RequestMapping("commodity/")
public class CommodityController extends BaseController{

    // CRUD

    @Autowired
    CommodityService commodityService;

    @Autowired
    HttpSession httpSession;

    /**
     * 商品列表页面
     * @param commodity
     * @param pageNum
     * @param pageSize
     * @return
     */
    @RequestMapping(value = "list", method = RequestMethod.GET)
    public String list(CommodityVo commodity, Integer pageNum, Integer pageSize, ModelMap model) {
        // 商品信息放入model 在前台可以取出存入的信息
        PageInfo<CommodityVo> pageInfo = commodityService.findByParams(commodity, pageNum, pageSize);
        // 把查询出来的结果放到model 里面前台就可以获取到
        model.put("pageInfo", pageInfo);
        // 参数
        return "commodity_list";
    }

    /**
     * 添加商品页面
     * @return
     */
    @RequestMapping(value = "add", method = RequestMethod.GET)
    @SecurityToken(generateToken = true)
    public String add() {
        // 获取单位信息
        return "commodity_add";
    }

    /**
     * 商品详情
     * @param id
     * @param model
     * @return
     */
    @RequestMapping(value = "detail/{id}", method = RequestMethod.GET)
    @SecurityToken(generateToken = true)
    public String detail(@PathVariable("id") Integer id, ModelMap model) {
        // 获取单位信息
        CommodityVo vo = commodityService.findById(id);
        model.put("commodity", vo);
        return "commodity_editor";
    }


    /**
     * 保存
     * @param commodity
     * @return
     */
    @RequestMapping(value = "save", method = RequestMethod.POST)
    @ResponseBody
    @SecurityToken(validateToken = true)
    @BizLog(type = LogTypeConstant.COMMODITY, desc = "保存商品信息")
    public Result save(@RequestBody CommodityVo commodity) {
        // Spring 自动绑定把前台的JSON 数据绑定到 @RequestBody CommodityVo commodity
        Member mem= (Member) httpSession.getAttribute(RedisEnum.MEMBER_SESSION_BOSS.getValue());
        commodityService.save(commodity,mem.getId());
        return Result.success("保存成功!");
    }


    /**
     * 删除
     * @param id
     * @return
     */
    @RequestMapping(value = "detete/{id}", method = RequestMethod.POST)
    @ResponseBody
    @BizLog(type = LogTypeConstant.COMMODITY, desc = "删除商品")
    public Result delete(@PathVariable("id") Integer id) {
        commodityService.deleteById(id);
        return Result.success("删除成功!");
    }

    /**
     * 按名称模糊查询商品
     * @param commodityVo
     * @return
     */
    @RequestMapping(value = "/search", method = RequestMethod.POST)
    @ResponseBody
    public Result search(CommodityVo commodityVo) {
        List<Commodity> commodityList=commodityService.searchComodity(commodityVo);
        return  Result.success().data(commodityList);
    }

    @RequestMapping(value = "/updown", method = RequestMethod.POST)
    @ResponseBody
    @BizLog(type = LogTypeConstant.COMMODITY, desc = "下线商品信息")
    public Result upDownCommodity(Integer id,Integer status){
        commodityService.updateStatus(status,id);
        return  Result.success();
    }

    /**
     * 通过id获取商品信息
     * @param id
     * @return
     */
    @RequestMapping(value = "/get", method = RequestMethod.POST)
    @ResponseBody
    public Result getCommodity(Integer id){
        CommodityVo commodityVo=commodityService.findById(id);
        return  Result.success().data(commodityVo);
    }

    /**
     * 更改商品价格
     * @param id
     * @param price
     * @return
     */

    @RequestMapping(value = "/updatePrice", method = RequestMethod.POST)
    @ResponseBody
    @BizLog(type = LogTypeConstant.COMMODITY, desc = "更改商品价格")
    public Result updatePrice(Integer id,float price){
        Member mem= (Member) httpSession.getAttribute(RedisEnum.MEMBER_SESSION_BOSS.getValue());
        CommodityVo commodityVo= new CommodityVo();
        commodityVo.setId(id);
        commodityVo.setPrice(price);
        commodityService.updatePrice(mem.getId(),commodityVo);
        return  Result.success();
    }

    /**
     * 通过品种id查找商品
     * @param categoryId
     * @return
     */
    @RequestMapping(value = "/getByCategory", method = RequestMethod.POST)
    @ResponseBody
    public Result getByCategory(Integer categoryId){
        List<CommodityVo>  commodityVos=commodityService.findByCategoryId(categoryId);
        return  Result.success().data(commodityVos);
    }

}
