package com.ms.dao;

import com.ms.dao.config.AutoMapper;
import com.ms.dao.model.Setting;
import com.ms.dao.vo.SettingVo;

import java.util.List;
@AutoMapper
public interface SettingDao extends ICommonDao<Setting>{

    public List<SettingVo> findByParams(SettingVo settingVo);

}
