package com.ms.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.ms.dao.ICommonDao;
import com.ms.dao.SupplierDao;
import com.ms.dao.enums.*;
import com.ms.dao.model.Supplier;
import com.ms.dao.model.User;
import com.ms.dao.vo.*;
import com.ms.service.*;
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

	@Autowired
	private SupplierCommodityService supplierCommodityService;


	@Autowired
	private SupplierChoiceService supplierChoiceService;

	@Autowired
	private SupplierContactService supplierContactService;

	@Autowired
	private SupplierAnnexService supplierAnnexService;

	@Autowired
	private UserTrackRecordService userTrackRecordService;


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
			s.setBinding(userService.findByPhone(s.getPhone())==null?"未绑定":"已绑定");
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
	@Transactional
	public void certify(SupplierCertifyVo supplierCertifyVo) {
		SupplierVo old=supplierDao.findVoById(supplierCertifyVo.getSupplier().getId());
		SupplierVo  supplier=supplierCertifyVo.getSupplier();
		if(old!=null){
			//如果已经审核过，不改变状态
			if(!old.getStatus().equals(SupplierStatusEnum.UNVERIFY.getType())){
				supplier.setStatus(old.getStatus());
			}
			save(supplier);
			if(supplierCertifyVo.getSupplierCommodityVos()!=null) {
				for (SupplierCommodityVo commodityVo : supplierCertifyVo.getSupplierCommodityVos()) {
					commodityVo.setSupplierId(supplierCertifyVo.getSupplier().getId());
					supplierCommodityService.save(commodityVo);
				}
			}
			//只有首次审核记跟踪记录
			if(old.getStatus().equals(SupplierStatusEnum.UNVERIFY.getType())){
				UserTrackRecordVo userTrackRecordVo=new UserTrackRecordVo();
				userTrackRecordVo.setSupplierId(supplierCertifyVo.getSupplier().getId());
				userTrackRecordVo.setMemberId(supplierCertifyVo.getMemberId());
				if(supplier.getStatus().equals(SupplierStatusEnum.VERIFY.getType())){
					userTrackRecordVo.setContent("信息审核正确");
				}
				else if(supplier.getStatus().equals(SupplierStatusEnum.VERIFY_NOT_PASS.getType())){
					userTrackRecordVo.setContent("信息审核不正确");
				}

				userTrackRecordVo.setCreateTime(new Date());
				userTrackRecordService.create(userTrackRecordVo);
			}
		}
		else{
			save(supplier);
			if(supplierCertifyVo.getSupplierCommodityVos()!=null){
				for(SupplierCommodityVo commodityVo:supplierCertifyVo.getSupplierCommodityVos()){
					commodityVo.setSupplierId(supplierCertifyVo.getSupplier().getId());
					supplierCommodityService.save(commodityVo);
				}
			}

		}

	}

	@Override
	@Transactional
	public void judge(SupplierJudgeVo supplierJudgeVo) {
		SupplierVo old=supplierDao.findVoById(supplierJudgeVo.getSupplierVo().getId());
		SupplierVo  supplier=supplierJudgeVo.getSupplierVo();
		//必须是已经审核才修改状态
		if(!old.getStatus().equals(SupplierStatusEnum.VERIFY.getType())){
			supplier.setStatus(old.getStatus());
		}
		save(supplierJudgeVo.getSupplierVo());

		supplierJudgeVo.getContacts().forEach(supplierContactVo -> {
			supplierContactService.save(supplierContactVo);
		});
		supplierAnnexService.deleteBySupplierId(supplier.getId());
		supplierJudgeVo.getAnnexVos().forEach(supplierAnnexVo -> {
			supplierAnnexService.save(supplierAnnexVo);
		});
		supplierChoiceService.deleteBySupplierId(supplierJudgeVo.getSupplierVo().getId());
		supplierJudgeVo.getChoiceVos().forEach(supplierChoiceVo -> {
			supplierChoiceService.save(supplierChoiceVo);
		});

		if(old.getStatus().equals(SupplierStatusEnum.VERIFY.getType())){
			UserTrackRecordVo userTrackRecordVo=new UserTrackRecordVo();
			userTrackRecordVo.setSupplierId(supplier.getId());
			userTrackRecordVo.setMemberId(supplierJudgeVo.getMemberId());
			userTrackRecordVo.setContent("实地考察认证");
			userTrackRecordVo.setCreateTime(new Date());
			userTrackRecordService.create(userTrackRecordVo);
		}



	}

	@Override
	public ICommonDao<Supplier> getDao() {
		return supplierDao;
	}






}
