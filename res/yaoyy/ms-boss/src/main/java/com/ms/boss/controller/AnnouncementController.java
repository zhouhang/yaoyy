package com.ms.boss.controller;

import com.github.pagehelper.PageInfo;
import com.ms.dao.vo.AnnouncementVo;
import com.ms.service.AnnouncementService;
import com.ms.tools.entity.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import java.util.ArrayList;
import java.util.List;

/**
 * Author: kevin
 * 03/06/17.
 * 网站新闻公告管理列表
 */
@Controller
@RequestMapping("announcement/")
public class AnnouncementController extends BaseController{

    @Autowired
    AnnouncementService announcementService;

    @RequestMapping(value = "list", method = RequestMethod.GET)
    public String list(AnnouncementVo announcement, Integer pageNum, Integer pageSize, ModelMap model){
        PageInfo<AnnouncementVo> announcementVoPageInfo = announcementService.findByParams(announcement, pageNum, pageSize);
        model.put("announcementVoPageInfo", announcementVoPageInfo);
        return "news_list";
    }

    @RequestMapping(value = "detail/{id}", method = RequestMethod.GET)
    public String detail(@PathVariable("id")Integer id, ModelMap model){
        AnnouncementVo announcementVo = announcementService.findDetailById(id);
        model.put("announcementVo", announcementVo);
        return "news_info";
    }

    @RequestMapping(value = "add", method = RequestMethod.GET)
    public String create(){
        return "news_info";
    }

    @RequestMapping(value = "save", method = RequestMethod.POST)
    public Result save(@RequestBody AnnouncementVo announcement){
        announcementService.save(announcement);
        return Result.success("保存成功!");
    }

    @RequestMapping(value = "delete/{id}", method = RequestMethod.GET)
    public Result delete(@PathVariable("id")Integer id){
        announcementService.deleteById(id);
        return Result.success("删除成功!");
    }

}
