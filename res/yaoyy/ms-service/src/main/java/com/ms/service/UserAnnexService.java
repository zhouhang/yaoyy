package com.ms.service;

import com.github.pagehelper.PageInfo;
import com.ms.dao.model.UserAnnex;
import com.ms.dao.vo.UserAnnexVo;

public interface UserAnnexService extends ICommonService<UserAnnex>{

    public PageInfo<UserAnnexVo> findByParams(UserAnnexVo userAnnexVo, Integer pageNum, Integer pageSize);
}
