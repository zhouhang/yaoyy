package com.ms.biz.config;

import com.ms.dao.model.Setting;
import com.ms.service.SettingService;
import com.ms.tools.utils.SpringUtil;

import javax.servlet.http.HttpServletRequest;
import javax.swing.*;
import java.util.Map;

/**
 * Author: koabs
 * 1/4/17.
 */
public class FreeMarkerView extends org.springframework.web.servlet.view.freemarker.FreeMarkerView {

    @Override
    protected void exposeHelpers(Map<String, Object> model,
                                 HttpServletRequest request) throws Exception {
        SettingService settingService = (SettingService)SpringUtil.getBean(SettingService.class);
        Setting setting = settingService.find();
        model.put("consumerHotline", setting.getConsumerHotline());
        super.exposeHelpers(model, request);
    }
}
