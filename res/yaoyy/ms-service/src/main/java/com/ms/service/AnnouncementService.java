package com.ms.service;

import com.github.pagehelper.PageInfo;
import com.ms.dao.model.Announcement;
import com.ms.dao.vo.AnnouncementVo;

public interface AnnouncementService extends ICommonService<Announcement>{

    public PageInfo<AnnouncementVo> findByParams(AnnouncementVo announcementVo, Integer pageNum, Integer pageSize);
}
