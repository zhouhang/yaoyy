package com.ms.biz.controller;

import com.github.pagehelper.PageInfo;
import com.ms.dao.enums.CategoryEnum;
import com.ms.dao.vo.CategoryVo;
import com.ms.dao.vo.CommodityVo;
import com.ms.service.CategoryService;
import com.ms.service.CommodityService;
import com.ms.tools.entity.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

/**
 * Author: koabs
 * 10/25/16.
 */
@Controller
@RequestMapping("category/")
public class CategoryController extends BaseController{

    @Autowired
    private CategoryService categoryService;

    /**
     * 商品列表页面
     * @param name
     * @param model
     * @return
     */
    @RequestMapping(value = "list", method = RequestMethod.GET)
    public String listPage(String name,ModelMap model) {
        model.put("name",name);
        return "category_list";
    }

    /**
     * 商品列表
     * @param categoryVo
     * @param pageNum
     * @param pageSize
     * @return
     */
    @RequestMapping(value = "list", method = RequestMethod.POST)
    @ResponseBody
    public Result list(CategoryVo categoryVo, Integer pageNum, Integer pageSize) {
        //不显示一级父类
        categoryVo.setLevel(CategoryEnum.LEVEL_BREED.getValue());
        categoryVo.setStatus(1);
        PageInfo<CategoryVo> pageInfo = categoryService.findByParamsBiz(categoryVo,pageNum,pageSize);
        // 参数
        return Result.success().data(pageInfo);
    }

    /**
     * 品种查询页面
     * @return
     */
    @RequestMapping(value = "search", method = RequestMethod.GET)
    public String searchPage() {
        return "category_search";
    }

    /**
     * 品种联想
     * @param categoryVo
     * @return
     */
    @RequestMapping(value = "search",method = RequestMethod.POST)
    @ResponseBody
    public Result searchCategory(CategoryVo categoryVo){
        categoryVo.setLevel(CategoryEnum.LEVEL_BREED.getValue());
        categoryVo.setStatus(1);
        List<CategoryVo> categoryVoList=categoryService.searchCategory(categoryVo);
        if(categoryVoList.size()>6){
            return  Result.success().data(categoryVoList.subList(0,6));
        }
        return  Result.success().data(categoryVoList);
    }


}
