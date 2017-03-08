package com.ms.dao;

import com.ms.dao.config.AutoMapper;
import com.ms.dao.model.UserAnnex;
import com.ms.dao.vo.UserAnnexVo;

import java.util.List;
@AutoMapper
public interface UserAnnexDao extends ICommonDao<UserAnnex>{

    public List<UserAnnexVo> findByParams(UserAnnexVo userAnnexVo);

}
