package com.ms.boss.controller;

import com.github.pagehelper.PageInfo;
import com.ms.boss.properties.BossSystemProperties;
import com.ms.dao.vo.MessageVo;
import com.ms.service.MessageService;
import com.ms.service.enums.MessageEnum;
import com.ms.tools.entity.Result;
import com.ms.tools.httpclient.common.util.StringUtil;
import com.mysql.jdbc.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Author: koabs
 * 12/6/16.
 */
@Controller
@RequestMapping("/msg")
public class MessageController extends BaseController{

    @Autowired
    private MessageService messageService;

    @Autowired
    private BossSystemProperties bossSystemProperties;

    /**
     * 用户未处理消息
     * @return
     */
    @RequestMapping(value = "/list")
    @ResponseBody
    public Result message() {

        List<MessageVo> list = messageService.findUnReadMsg();
        list.forEach(message -> {
            String url = MessageEnum.getUrl(message.getType());
            if(!StringUtils.isNullOrEmpty(url)) {
                message.setUrl(bossSystemProperties.getBaseUrl() + url + message.getEventId());
            }else{
                message.setUrl("javascript:");
            }
        });
        Map<String,Object> map = new HashMap<>();
        map.put("count", list.size());
        map.put("list",list);
        return Result.success().data(map);
    }

    /**
     * 选货单寄样单消息数量
     * @return
     */
    @RequestMapping(value = "/count")
    @ResponseBody
    public Result pick() {
        Map<String,Integer> map = new HashMap<>();
        map.put("pick", messageService.count(MessageEnum.PICK));
        map.put("sample",messageService.count(MessageEnum.SAMPLE));
        return Result.success().data(map);
    }

}
