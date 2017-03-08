package com.ms.service;

import com.github.pagehelper.PageInfo;
import com.ms.dao.model.UserAnnex;
import com.ms.dao.vo.UserAnnexVo;

import java.util.List;

public interface UserAnnexService extends ICommonService<UserAnnex>{

    public PageInfo<UserAnnexVo> findByParams(UserAnnexVo userAnnexVo, Integer pageNum, Integer pageSize);

    public void save(UserAnnexVo userAnnexVo);

    public List<UserAnnexVo> findByParamsNoPage(UserAnnexVo userAnnexVo);

    public void deleteFileById(Integer annexId);
}
