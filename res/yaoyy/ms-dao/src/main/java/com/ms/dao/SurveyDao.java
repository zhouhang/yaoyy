package com.ms.dao;

import com.ms.dao.config.AutoMapper;
import com.ms.dao.model.Survey;
import com.ms.dao.vo.SurveyVo;

import java.util.List;
@AutoMapper
public interface SurveyDao extends ICommonDao<Survey>{

    public List<SurveyVo> findByParams(SurveyVo surveyVo);

}
