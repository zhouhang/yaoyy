package com.ms.boss.controller;

import com.github.pagehelper.PageInfo;
import com.ms.dao.model.Supplier;
import com.ms.dao.vo.CommodityVo;
import com.ms.dao.vo.SupplierVo;
import com.ms.service.CategoryService;
import com.ms.service.CommodityService;
import com.ms.service.SupplierService;
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
    private CategoryService categoryService;

    @Autowired
    private CommodityService commodityService;

    @RequestMapping(value = "list", method = RequestMethod.GET)
    public String supplierList(SupplierVo supplierVo, Integer pageNum,
                               Integer pageSize, ModelMap model){

        PageInfo<SupplierVo> supplierVoPageInfo = supplierService.findByParams(supplierVo,pageNum,pageSize);
        model.put("supplierVoPageInfo",supplierVoPageInfo);


        return "supplier_list";
    }

    @RequestMapping(value = "detail/{id}", method = RequestMethod.GET)
    public String supplierDetail(@PathVariable("id") Integer id,ModelMap model){

        SupplierVo supplierVo=supplierService.findVoById(id);
        supplierVo.setEnterCategoryList(categoryService.findByIds(supplierVo.getEnterCategory()));

        List<CommodityVo> commodityVos=commodityService.findBySupplier(id);

        model.put("supplierVo",supplierVo);
        model.put("commodityVos",commodityVos);


        return "supplier_detail";
    }
    @RequestMapping(value = "save", method = RequestMethod.POST)
    @ResponseBody
    public Result saveSupplier(SupplierVo supplierVo){
        supplierService.save(supplierVo);
        return Result.success("保存成功");
    }




}
