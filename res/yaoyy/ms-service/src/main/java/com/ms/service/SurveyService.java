package com.ms.service;

import com.github.pagehelper.PageInfo;
import com.ms.dao.model.Survey;
import com.ms.dao.vo.SurveyVo;

public interface SurveyService extends ICommonService<Survey>{

    public PageInfo<SurveyVo> findByParams(SurveyVo surveyVo,Integer pageNum,Integer pageSize);
}
