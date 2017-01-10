package com.ms.boss.controller;

import com.github.pagehelper.PageInfo;
import com.ms.dao.vo.CommodityVo;
import com.ms.dao.vo.SupplierVo;
import com.ms.service.CommodityService;
import com.ms.service.SupplierService;
import com.ms.tools.annotation.SecurityToken;
import com.ms.tools.entity.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

/**
 * Created by xiao on 2016/12/2.
 */
@Controller
@RequestMapping("supplier/")
public class SupplierController {


    @Autowired
    private SupplierService supplierService;



    @Autowired
    private CommodityService commodityService;

    /**
     * 供应商list
     * @param supplierVo
     * @param pageNum
     * @param pageSize
     * @param model
     * @return
     */

    @RequestMapping(value = "list", method = RequestMethod.GET)
    public String supplierList(SupplierVo supplierVo, Integer pageNum,
                               Integer pageSize, ModelMap model){

        PageInfo<SupplierVo> supplierVoPageInfo = supplierService.findByParams(supplierVo,pageNum,pageSize);
        model.put("supplierVoPageInfo",supplierVoPageInfo);


        return "supplier_list";
    }

    /**
     *
     * @return
     */
    @RequestMapping(value = "create", method = RequestMethod.GET)
    @SecurityToken(generateToken = true)
    public String createSupplier(){
        return  "supplier_detail";
    }




    /**
     * 供应商详情
     * @param id
     * @param model
     * @return
     */
    @RequestMapping(value = "detail/{id}", method = RequestMethod.GET)
    @SecurityToken(generateToken = true)
    public String supplierDetail(@PathVariable("id") Integer id,ModelMap model){

        SupplierVo supplierVo=supplierService.findVoById(id);


        List<CommodityVo> commodityVos=commodityService.findBySupplier(id);

        model.put("supplierVo",supplierVo);
        model.put("commodityVos",commodityVos);


        return "supplier_detail";
    }

    /**
     * 保存供应商
     * @param supplierVo
     * @return
     */
    @RequestMapping(value = "save", method = RequestMethod.POST)
    @ResponseBody
    @SecurityToken(validateToken=true)
    public Result saveSupplier(SupplierVo supplierVo){
        supplierService.save(supplierVo);
        return Result.success("保存成功");
    }

    /**
     * 根据姓名查询供应商
     * @param name
     * @return
     */
    @RequestMapping(value = "search", method = RequestMethod.POST)
    @ResponseBody
    public Result search(String name){
        return Result.success("供应商列表").data(supplierService.search(name));
    }


}
