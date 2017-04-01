package com.ms.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.ms.dao.ICommonDao;
import com.ms.dao.SurveyDao;
import com.ms.dao.model.Survey;
import com.ms.dao.vo.SurveyVo;
import com.ms.service.SurveyService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class SurveyServiceImpl  extends AbsCommonService<Survey> implements SurveyService{

	@Autowired
	private SurveyDao surveyDao;


	@Override
	public PageInfo<SurveyVo> findByParams(SurveyVo surveyVo,Integer pageNum,Integer pageSize) {
    PageHelper.startPage(pageNum, pageSize);
    	List<SurveyVo>  list = surveyDao.findByParams(surveyVo);
        PageInfo page = new PageInfo(list);
        return page;
	}

	@Override
	public List<SurveyVo> allQuestions() {
		SurveyVo surveyVo=new SurveyVo();
		List<SurveyVo>  list = surveyDao.findByParams(surveyVo);
		return list;
	}


	@Override
	public ICommonDao<Survey> getDao() {
		return surveyDao;
	}

}
