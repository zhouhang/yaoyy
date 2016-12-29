package com.ms.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.ms.dao.ICommonDao;
import com.ms.dao.PayDocumentDao;
import com.ms.dao.model.PayDocument;
import com.ms.dao.vo.PayDocumentVo;
import com.ms.service.PayDocumentService;
import com.ms.tools.upload.PathConvert;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class PayDocumentServiceImpl  extends AbsCommonService<PayDocument> implements PayDocumentService{

	@Autowired
	private PayDocumentDao payDocumentDao;

	@Autowired
	private PathConvert pathConvert;

	@Override
	public PageInfo<PayDocumentVo> findByParams(PayDocumentVo payDocumentVo,Integer pageNum,Integer pageSize) {
    PageHelper.startPage(pageNum, pageSize);
    	List<PayDocumentVo>  list = payDocumentDao.findByParams(payDocumentVo);
        PageInfo page = new PageInfo(list);
        return page;
	}

	@Override
	public List<PayDocumentVo> findByParams(PayDocumentVo payDocumentVo) {
		List<PayDocumentVo>  list = payDocumentDao.findByParams(payDocumentVo);
		list.forEach(doc ->{
			doc.setPath(pathConvert.getUrl(doc.getPath()));
		});
		return list;
	}

	@Override
	public void deleteByRecordId(Integer recordId) {
		payDocumentDao.deleteByRecordId(recordId);
	}

	@Override
	public ICommonDao<PayDocument> getDao() {
		return payDocumentDao;
	}

}
