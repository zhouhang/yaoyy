package com.ms.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.ms.dao.ICommonDao;
import com.ms.dao.SupplierAnnexDao;
import com.ms.dao.model.SupplierAnnex;
import com.ms.dao.vo.SupplierAnnexVo;
import com.ms.service.SupplierAnnexService;
import com.ms.tools.upload.PathConvert;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;
import java.util.List;

@Service
public class SupplierAnnexServiceImpl  extends AbsCommonService<SupplierAnnex> implements SupplierAnnexService{

	@Autowired
	private SupplierAnnexDao supplierAnnexDao;

	@Autowired
	private PathConvert pathConvert;

	/**
	 * 品种图片保存路径
	 */
	private String folderName = "supplierAnnex/";


	@Override
	public PageInfo<SupplierAnnexVo> findByParams(SupplierAnnexVo supplierAnnexVo,Integer pageNum,Integer pageSize) {
    PageHelper.startPage(pageNum, pageSize);
    	List<SupplierAnnexVo>  list = supplierAnnexDao.findByParams(supplierAnnexVo);
        PageInfo page = new PageInfo(list);
        return page;
	}

	@Override
	public List<SupplierAnnexVo> findBySupplierId(Integer supplierId) {
		SupplierAnnexVo supplierAnnexVo=new SupplierAnnexVo();
		supplierAnnexVo.setSupplierId(supplierId);
		List<SupplierAnnexVo>  list = supplierAnnexDao.findByParams(supplierAnnexVo);
		list.forEach(supplierAnnex->{
			supplierAnnex.setUrl(pathConvert.getUrl(supplierAnnex.getUrl()));
		});
		return list;
	}

	@Override
	@Transactional
	public void save(SupplierAnnexVo supplierAnnexVo) {
		supplierAnnexVo.setUrl(pathConvert.saveFileFromTemp(supplierAnnexVo.getUrl(),folderName));
		if(supplierAnnexVo.getId()==null){
			supplierAnnexVo.setStatus("1");
			supplierAnnexVo.setCreateTime(new Date());
			supplierAnnexDao.create(supplierAnnexVo);
		}
		else{
			supplierAnnexDao.update(supplierAnnexVo);
		}

	}

	@Override
	public void deleteBySupplierId(Integer supplierId) {
          supplierAnnexDao.deleteBySupplierId(supplierId);
	}


	@Override
	public ICommonDao<SupplierAnnex> getDao() {
		return supplierAnnexDao;
	}

}
