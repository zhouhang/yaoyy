package com.ms.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.ms.dao.ICommonDao;
import com.ms.dao.PayRecordDao;
import com.ms.dao.model.PayRecord;
import com.ms.dao.vo.PayDocumentVo;
import com.ms.dao.vo.PayRecordVo;
import com.ms.service.PayDocumentService;
import com.ms.service.PayRecordService;
import com.ms.tools.upload.PathConvert;
import com.ms.tools.utils.SeqNoUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;
import java.util.List;

@Service
public class PayRecordServiceImpl  extends AbsCommonService<PayRecord> implements PayRecordService{

	@Autowired
	private PayRecordDao payRecordDao;

	@Autowired
	private PayDocumentService payDocumentService;

	@Autowired
	private PathConvert pathConvert;

	/**
	 * 商品图片保存路径
	 */
	private String folderName = "pay/";

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
		payRecordVo.setPayDocuments(payDocumentService.findByParams(payDocument));
		return payRecordVo;
	}

	@Override
	public PayRecordVo findByOrderId(PayRecordVo payRecordVo) {
		List<PayRecordVo>  list = payRecordDao.findByParams(payRecordVo);
		if(list.size()!=0){
			PayRecordVo payRecord=list.get(0);
			PayDocumentVo payDocument =new PayDocumentVo();
			payDocument.setPayRecordId(payRecord.getId());
            payRecord.setPayDocuments(payDocumentService.findByParams(payDocument));
			return payRecord;
		}
		return null;
	}


	@Override
	@Transactional
	public PayRecordVo save(PayRecordVo payRecord) {
		if (payRecord.getId()!= null) {
			update(payRecord);
		} else {
			payRecord.setPaymentTime(new Date());
			payRecord.setCreateTime(new Date());
			create(payRecord);
			payRecord.setPayCode(SeqNoUtil.get("",payRecord.getId(),6));
			update(payRecord);
		}
		// 删除原图片再保存图片
		payDocumentService.deleteByRecordId(payRecord.getId());
		if (payRecord.getPayDocuments()!= null && payRecord.getPayDocuments().size() >0 ){
			payRecord.getPayDocuments().forEach(doc ->{
				doc.setCreateDate(new Date());
				doc.setPayRecordId(payRecord.getId());
				doc.setPath(pathConvert.saveFileFromTemp(doc.getPath(),folderName));
				payDocumentService.create(doc);
			});
		}
		return payRecord;
	}

	@Override
	public ICommonDao<PayRecord> getDao() {
		return payRecordDao;
	}

}
