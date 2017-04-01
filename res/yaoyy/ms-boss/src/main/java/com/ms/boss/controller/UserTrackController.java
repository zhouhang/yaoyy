package com.ms.boss.controller;

import com.github.pagehelper.PageInfo;
import com.ms.boss.config.LogTypeConstant;
import com.ms.dao.enums.UserTrackTypeEnum;
import com.ms.dao.model.UserTrackRecord;
import com.ms.dao.vo.UserTrackRecordVo;
import com.ms.dao.vo.UserVo;
import com.ms.service.UserService;
import com.ms.service.UserTrackRecordService;
import com.ms.tools.entity.Result;
import com.sucai.compentent.logs.annotation.BizLog;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.Date;

/**
 * Author: kevin
 * 03/07/17.
 * 用户跟踪记录
 */
@Controller
@RequestMapping("usertrack/")
public class UserTrackController extends BaseController{

    @Autowired
    UserTrackRecordService userTrackRecordService;

    /**
     * 启用账号
     * @param
     * @return
     */
    @RequestMapping(value = "save", method = RequestMethod.POST)
    @ResponseBody
    public Result save(UserTrackRecordVo userTrackRecordVo) {
        userTrackRecordVo.setCreateTime(new Date());
        userTrackRecordVo.setType(UserTrackTypeEnum.GENERAL.getType());
        userTrackRecordService.create(userTrackRecordVo);
        return Result.success("添加成功!");
    }

}
