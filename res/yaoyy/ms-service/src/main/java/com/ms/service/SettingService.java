package com.ms.service;

import com.github.pagehelper.PageInfo;
import com.ms.dao.model.Setting;
import com.ms.dao.vo.SettingVo;

public interface SettingService extends ICommonService<Setting>{

    public PageInfo<SettingVo> findByParams(SettingVo settingVo, Integer pageNum, Integer pageSize);

    public void save(Setting setting);

    public void tel(String tel);

    public void bank(String account, String card, String bank);

    public Setting find();
}
