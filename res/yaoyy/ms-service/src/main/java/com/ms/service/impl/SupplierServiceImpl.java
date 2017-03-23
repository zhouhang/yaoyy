package com.ms.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.ms.dao.ICommonDao;
import com.ms.dao.SupplierDao;
import com.ms.dao.enums.*;
import com.ms.dao.model.Supplier;
import com.ms.dao.model.User;
import com.ms.dao.vo.SupplierVo;
import com.ms.dao.vo.UserVo;
import com.ms.service.CategoryService;
import com.ms.service.SupplierService;
import com.ms.service.UserService;
import com.ms.service.dto.Password;
import com.ms.service.utils.EncryptUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;
import java.util.List;

@Service
public class SupplierServiceImpl  extends AbsCommonService<Supplier> implements SupplierService{

	@Autowired
	private SupplierDao supplierDao;

	@Autowired
	private CategoryService categoryService;

	@Autowired
	private UserService userService;

	@Override
	public PageInfo<SupplierVo> findByParams(SupplierVo supplierVo,Integer pageNum,Integer pageSize) {

		pageNum = pageNum==null?1:pageNum;
		pageSize = pageSize==null?10:pageSize;

        PageHelper.startPage(pageNum, pageSize);
    	List<SupplierVo>  list = supplierDao.findByParams(supplierVo);
		list.forEach(s->{
			s.setEnterCategoryList(categoryService.findByIds(s.getEnterCategory()));
		});
        PageInfo page = new PageInfo(list);
        return page;
	}

	@Override
	public SupplierVo findVoById(Integer id) {
		SupplierVo supplierVo=supplierDao.findVoById(id);
		supplierVo.setEnterCategoryList(categoryService.findByIds(supplierVo.getEnterCategory()));
		return supplierVo;
	}

	@Override
	@Transactional
	public void save(SupplierVo supplierVo) {
		Date now=new Date();
		if(supplierVo.getId()==null){
			supplierVo.setCreateTime(now);
			supplierVo.setUpdateTime(now);
			supplierDao.create(supplierVo);
		}
		else{
			supplierVo.setUpdateTime(now);
			supplierDao.update(supplierVo);
		}
	}

	@Override
	public List<SupplierVo> search(String name) {
		SupplierVo vo = new SupplierVo();
		vo.setName(name);
		return supplierDao.findByParams(vo);
	}

	@Override
	public PageInfo<SupplierVo> findVoByParams(SupplierVo supplierVo,Integer pageNum,Integer pageSize){
		pageNum = pageNum==null?1:pageNum;
		pageSize = pageSize==null?10:pageSize;

		PageHelper.startPage(pageNum, pageSize);
		List<SupplierVo>  list = supplierDao.findVoByParams(supplierVo);
		list.forEach(s->{
			s.setEnterCategoryList(categoryService.findByIds(s.getEnterCategory()));
			s.setStatusText(SupplierStatusEnum.get(s.getStatus()));
			UserVo uv = new UserVo();
			uv.setSupplierId(s.getId());
			List<UserVo> userVos = userService.findByParamsNoPage(uv);
			s.setBinding(userVos.size()==0?"未绑定":"已绑定");
			s.setSourceText(SupplierSourceEnum.get(s.getSource()));
		});
		PageInfo page = new PageInfo(list);
		return page;
	}

	@Override
	@Transactional
	public Boolean register(SupplierVo supplierVo) {
		SupplierVo param = new SupplierVo();
		param.setPhone(supplierVo.getPhone());
		List<SupplierVo> list = supplierDao.findByParams(param);
		if (list.size() == 0) {
			save(supplierVo);
			return true;
		}
		return false;
	}

	@Override
	@Transactional
	public Boolean join(SupplierVo supplierVo) {

		SupplierVo param = new SupplierVo();
		param.setPhone(supplierVo.getPhone());
		List<SupplierVo> list = supplierDao.findByParams(param);
		if (list.size() == 0) {
			//首先user里面插入一条数据，然后supplier插入数据
			if(userService.findByPhone(supplierVo.getPhone())==null){
				User user = new User();
				user.setPhone(supplierVo.getPhone());
				user.setType(UserTypeEnum.supplier.getType());
				user.setSource(UserSourceEnum.auto.getType());
				user.setStatus(UserEnum.enable.getType());
				user.setCreateTime(new Date());
				user.setUpdateTime(new Date());
				userService.create(user);
			}

			return true;
		}

		return false;
	}

	@Override
	public ICommonDao<Supplier> getDao() {
		return supplierDao;
	}






}
