package com.ms.biz.controller;

import com.github.pagehelper.PageInfo;
import com.ms.dao.enums.AnnouncementUserTypeEnum;
import com.ms.dao.model.Announcement;
import com.ms.dao.model.User;
import com.ms.dao.vo.AnnouncementVo;
import com.ms.dao.vo.MessageVo;
import com.ms.service.AnnouncementService;
import com.ms.service.MessageService;
import com.ms.service.enums.MessageEnum;
import com.ms.service.enums.RedisEnum;
import com.ms.tools.entity.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;

/**
 * Author: kevin
 * 3/9/17.
 */
@Controller
@RequestMapping("/announcement")
public class AnnouncementController {

    @Autowired
    private AnnouncementService announcementService;

    @Autowired
    private HttpSession httpSession;

    @RequestMapping(value = "/list", method = RequestMethod.GET)
    public String list(ModelMap model) {
        return "supplier/announcement_list";
    }

    @RequestMapping(value = "/getlist", method = RequestMethod.GET)
    @ResponseBody
    public Result getlist(Integer pagesize) {
        //获取登陆用户userId
        User user = (User) httpSession.getAttribute(RedisEnum.USER_SESSION_BIZ.getValue());
        //网站公告
        AnnouncementVo announcementVo = new AnnouncementVo();
        List<Integer> userTypes = new ArrayList<Integer>();
        userTypes.add(AnnouncementUserTypeEnum.ALL.getKey());
        userTypes.add(AnnouncementUserTypeEnum.SUPPLIER.getKey());
        announcementVo.setUserTypes(userTypes);//0全体,1供应商
        PageInfo<AnnouncementVo> announcementVos = announcementService.findByParams(announcementVo, 0, 3);

        return Result.success().data(announcementVos.getList());
    }

    @RequestMapping(value = "/detail/{id}", method = RequestMethod.GET)
    public String detail(@PathVariable("id") Integer id, ModelMap model) {
        //网站公告
        AnnouncementVo announcementVo = new AnnouncementVo();
        announcementVo.setId(id);
        Announcement announcement = announcementService.findById(id);
        model.put("announcement", announcement);
        return "supplier/announcement_info";
    }

}
