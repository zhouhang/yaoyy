package com.ms.biz.controller;

import com.github.pagehelper.PageInfo;
import com.ms.dao.enums.AnnouncementUserTypeEnum;
import com.ms.dao.model.User;
import com.ms.dao.vo.AnnouncementVo;
import com.ms.dao.vo.CommodityVo;
import com.ms.dao.vo.MessageVo;
import com.ms.dao.vo.PickVo;
import com.ms.service.AnnouncementService;
import com.ms.service.CommodityService;
import com.ms.service.MessageService;
import com.ms.service.PickService;
import com.ms.service.enums.MessageEnum;
import com.ms.service.enums.RedisEnum;
import com.ms.tools.entity.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
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
@RequestMapping("/message")
public class MessageController {

    @Autowired
    private MessageService messageService;

    @Autowired
    private HttpSession httpSession;

    @RequestMapping(value = "/list", method = RequestMethod.GET)
    public String list(ModelMap model) {
        return "supplier/message_list";
    }

    @RequestMapping(value = "/getlist", method = RequestMethod.GET)
    @ResponseBody
    public Result getlist(Integer pagesize) {
        //获取登陆用户userId
        User user = (User) httpSession.getAttribute(RedisEnum.USER_SESSION_BIZ.getValue());
        //"我的消息"
        MessageVo messageVo = new MessageVo();
        messageVo.setUserId(user.getId());
        List<Integer> types = new ArrayList<Integer>();
        types.add(MessageEnum.SUPPLIER_SAMPLES.get());
        types.add(MessageEnum.SUPPLIER_COMMODITY.get());
        types.add(MessageEnum.SUPPLIER_ORDER.get());
        messageVo.setTypes(types);
        PageInfo<MessageVo> messageVos = messageService.findByParams(messageVo, pagesize, 5);
        return Result.success().data(messageVos.getList());
    }

}
