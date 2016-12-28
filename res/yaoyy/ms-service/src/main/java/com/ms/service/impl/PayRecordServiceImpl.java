package com.ms.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.ms.dao.ICommonDao;
import com.ms.dao.PayDocumentDao;
import com.ms.dao.PayRecordDao;
import com.ms.dao.model.PayDocument;
import com.ms.dao.model.PayRecord;
import com.ms.dao.vo.PayDocumentVo;
import com.ms.dao.vo.PayRecordVo;
import com.ms.service.PayRecordService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class PayRecordServiceImpl  extends AbsCommonService<PayRecord> implements PayRecordService{

	@Autowired
	private PayRecordDao payRecordDao;

	@Autowired
	private PayDocumentDao payDocumentDao;


	@Override
	public PageInfo<PayRecordVo> findByParams(PayRecordVo payRecordVo,Integer pageNum,Integer pageSize) {

		pageNum = pageNum==null?1:pageNum;
		pageSize = pageSize==null?10:pageSize;
        PageHelper.startPage(pageNum, pageSize);
    	List<PayRecordVo>  list = payRecordDao.findByParams(payRecordVo);
        PageInfo page = new PageInfo(list);
        return page;
	}

	@Override
	public PayRecordVo findVoById(Integer id) {
		PayRecordVo payRecordVo=payRecordDao.findVoById(id);
		PayDocumentVo payDocument =new PayDocumentVo();
		payDocument.setPayRecordId(id);
		payRecordVo.setPayDocuments(payDocumentDao.findByParams(payDocument));
		return payRecordVo;
	}

	@Override
	public PayRecordVo findByOrderId(PayRecordVo payRecordVo) {
		List<PayRecordVo>  list = payRecordDao.findByParams(payRecordVo);
		if(list.size()!=0){
			PayRecordVo payRecord=list.get(0);
			PayDocumentVo payDocument =new PayDocumentVo();
			payDocument.setPayRecordId(payRecord.getId());
            payRecord.setPayDocuments(payDocumentDao.findByParams(payDocument));
			return payRecord;
		}
		return null;
	}


	@Override
	public ICommonDao<PayRecord> getDao() {
		return payRecordDao;
	}

}
