package com.ms.boss.controller;

import com.github.pagehelper.PageInfo;
import com.ms.dao.model.Supplier;
import com.ms.dao.vo.SupplierVo;
import com.ms.service.SupplierService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 * Created by xiao on 2016/12/2.
 */
@Controller
@RequestMapping("supplier")
public class SupplierController {


    @Autowired
    private SupplierService supplierService;

    @RequestMapping(value = "list", method = RequestMethod.GET)
    public String supplierList(SupplierVo supplierVo, Integer pageNum,
                               Integer pageSize, ModelMap model){

        PageInfo<SupplierVo> supplierVoPageInfo = supplierService.findByParams(supplierVo,pageNum,pageSize);
        model.put("supplierVoPageInfo",supplierVoPageInfo);


        return "supplier_list";
    }



}
