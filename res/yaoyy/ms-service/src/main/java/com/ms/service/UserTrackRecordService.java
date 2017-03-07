package com.ms.service;

import com.github.pagehelper.PageInfo;
import com.ms.dao.model.UserTrackRecord;
import com.ms.dao.vo.UserTrackRecordVo;

import java.util.List;

public interface UserTrackRecordService extends ICommonService<UserTrackRecord>{

    public PageInfo<UserTrackRecordVo> findByParams(UserTrackRecordVo userTrackRecordVo, Integer pageNum, Integer pageSize);

    public List<UserTrackRecordVo> findByParamsNoPage(UserTrackRecordVo userTrackRecordVo);
}
