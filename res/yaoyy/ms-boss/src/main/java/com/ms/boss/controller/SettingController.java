package com.ms.boss.controller;

import com.ms.service.SettingService;
import com.ms.tools.entity.Result;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * Author: koabs
 * 1/3/17.
 * 配置信息
 */
@RequestMapping("/setting")
@Controller
public class SettingController {

    @Autowired
    private SettingService settingService;

    /**
     * 配置页面
     * @return
     */
    @RequestMapping(value = "")
    @RequiresPermissions(value = "setting:all")
    public String index(ModelMap model) {
        model.put("setting", settingService.find());
        return  "setting";
    }

    /**
     * 保存客服电话
     * @param tel
     * @return
     */
    @RequestMapping(value = "/tel")
    @ResponseBody
    @RequiresPermissions(value = "setting:all")
    public Result tel(String tel) {
        settingService.tel(tel);
        return  Result.success();
    }

    /**
     * 保存银行账号信息
     * @param account
     * @param card
     * @param bank
     * @return
     */
    @RequestMapping(value = "/bank")
    @ResponseBody
    @RequiresPermissions(value = "setting:all")
    public Result bank(String account, String card, String bank) {
        settingService.bank(account, card, bank);
        return  Result.success();
    }


}
