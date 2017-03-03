package com.ms.dao;

import com.ms.dao.config.AutoMapper;
import com.ms.dao.model.UserTrackRecord;
import com.ms.dao.vo.UserTrackRecordVo;

import java.util.List;
@AutoMapper
public interface UserTrackRecordDao extends ICommonDao<UserTrackRecord>{

    public List<UserTrackRecordVo> findByParams(UserTrackRecordVo userTrackRecordVo);

}
