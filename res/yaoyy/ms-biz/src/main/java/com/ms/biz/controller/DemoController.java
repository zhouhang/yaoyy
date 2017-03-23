package com.ms.biz.controller;

import com.ms.dao.model.HuqiaoSupplier;
import com.ms.service.HuqiaoSupplierService;
import com.ms.service.utils.ExcelParse;
import com.ms.tools.entity.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.util.List;

/**
 * Created by wangbin on 2017/3/22.
 */
@Controller
@RequestMapping("/demo")
public class DemoController {

    @Autowired
    private HuqiaoSupplierService huqiaoSupplierService;

    @RequestMapping(value = "/ins/suppiler", method = RequestMethod.GET)
    @ResponseBody
    public Result insSuppiler()throws Exception{
        File file = new File("E:\\excel\\供应商信息.xlsx");
        InputStream inputStream = new FileInputStream(file) ;
        List<HuqiaoSupplier> huqiaoSupplierList = ExcelParse.parseEnquiryXLS(inputStream);

        for(HuqiaoSupplier huqiaoSupplier : huqiaoSupplierList){
            if(null==huqiaoSupplier.getMobile()||huqiaoSupplier.getMobile().length()!=11){
                continue;
            }
            huqiaoSupplierService.create(huqiaoSupplier);
        }


        return  Result.success().msg("数据导入成功!");
    }


}
