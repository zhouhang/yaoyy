package com.ms.dao;

import com.ms.dao.config.AutoMapper;
import com.ms.dao.model.Announcement;
import com.ms.dao.vo.AnnouncementVo;

import java.util.List;
@AutoMapper
public interface AnnouncementDao extends ICommonDao<Announcement>{

    public List<AnnouncementVo> findByParams(AnnouncementVo announcementVo);

}
