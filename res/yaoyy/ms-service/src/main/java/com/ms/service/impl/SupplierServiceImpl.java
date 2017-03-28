package com.ms.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.ms.dao.ICommonDao;
import com.ms.dao.SupplierDao;
import com.ms.dao.enums.*;
import com.ms.dao.model.Supplier;
import com.ms.dao.model.User;
import com.ms.dao.model.UserDetail;
import com.ms.dao.vo.SupplierCertifyVo;
import com.ms.dao.vo.SupplierCommodityVo;
import com.ms.dao.vo.SupplierVo;
import com.ms.dao.vo.UserVo;
import com.ms.service.*;
import com.ms.dao.vo.*;
import com.ms.service.*;
import com.ms.service.dto.Password;
import com.ms.service.utils.EncryptUtil;
import com.ms.tools.httpclient.common.util.StringUtil;
import me.chanjar.weixin.mp.bean.result.WxMpUser;
import org.apache.commons.lang.StringUtils;
import me.chanjar.weixin.mp.bean.result.WxMpUser;
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
	private UserDetailService userDetailService;

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
			supplierVo.setSource(SupplierSourceEnum.WECHART.getType());
			save(supplierVo);
			return true;
		}
		return false;
	}


	@Override
	@Transactional
	public Boolean join(SupplierVo supplierVo,WxMpUser wxMpUser) {

		SupplierVo param = new SupplierVo();
		param.setPhone(supplierVo.getPhone());
		List<SupplierVo> list = supplierDao.findByParams(param);
		if (list.size() == 0) {
			supplierVo.setStatus(SupplierStatusEnum.UNVERIFY.getType());
			supplierVo.setSource(SupplierSourceEnum.WECHART.getType());
			supplierVo.setCreateTime(new Date());
			supplierVo.setUpdateTime(new Date());
			create(supplierVo);
			//首先user里面插入一条数据，然后supplier插入数据
			supplierForUser(supplierVo,wxMpUser);
			return true;
		}
		SupplierVo existSupplier = list.get(0);
		if(userService.isBinding(existSupplier.getId())){
			return false;
		}
		supplierForUser(existSupplier,wxMpUser);
		return true;
	}


	private User supplierForUser (SupplierVo supplierVo,WxMpUser wxMpUser){
		User user = userService.findByPhone(supplierVo.getPhone());
		if(user==null){
			user = new User();
			user.setPhone(supplierVo.getPhone());
			user.setType(UserTypeEnum.supplier.getType());
			user.setSource(UserSourceEnum.register.getType());
			user.setStatus(1);
			user.setSupplierId(supplierVo.getId());
			if(null!=wxMpUser){
				user.setOpenid(wxMpUser.getOpenId());
			}
			userService.create(user);
			UserDetail userDetail = new UserDetail();
			userDetail.setUserId(user.getId());
			userDetail.setType(0);
			if(null!=wxMpUser){
				userDetail.setNickname(wxMpUser.getNickname());
				userDetail.setHeadImgUrl(wxMpUser.getHeadImgUrl());
			}
			userDetail.setPhone(supplierVo.getPhone());
			userDetail.setName(supplierVo.getName());
			userDetail.setContract(0);
			userDetailService.save(userDetail);
		}else{
			if(StringUtils.isBlank(user.getOpenid())&&null!=wxMpUser){
				user.setOpenid(wxMpUser.getOpenId());
				UserDetail userDetail = userDetailService.findByUserId(user.getId());
				userDetail.setNickname(wxMpUser.getNickname());
				userDetail.setHeadImgUrl(wxMpUser.getHeadImgUrl());
				userDetailService.save(userDetail);
			}
			user.setSupplierId(supplierVo.getId());
			userService.update(user);
		}
		return user;
	}




	@Override
	@Transactional
	public void certify(SupplierCertifyVo supplierCertifyVo) {
		SupplierVo old=supplierDao.findVoById(supplierCertifyVo.getSupplier().getId());
		SupplierVo  supplier=supplierCertifyVo.getSupplier();

		supplier.setEnterCategoryList(categoryService.findByIds(supplier.getEnterCategory()));
		supplier.setEnterCategoryStr(supplier.getEnterCategoryText());


		if(supplier.getId()!=null){
			//如果已经进入实地考察和签约，不改变状态
			boolean isRecord=false;

			Integer oldStatus=old.getStatus();


			if(oldStatus!=null&&(oldStatus.equals(SupplierStatusEnum.INVEST.getType())||oldStatus.equals(SupplierStatusEnum.SIGN.getType()))){
				//如果是通过状态就不需要更改状态
				if(!supplier.getStatus().equals(SupplierStatusEnum.VERIFY_NOT_PASS.getType())){
					supplier.setStatus(old.getStatus());
				}

			}
			save(supplier);
			if(supplierCertifyVo.getSupplierCommodityVos()!=null) {
				for (SupplierCommodityVo commodityVo : supplierCertifyVo.getSupplierCommodityVos()) {
					commodityVo.setSupplierId(supplierCertifyVo.getSupplier().getId());
					supplierCommodityService.save(commodityVo);
				}
			}
			if(oldStatus==null){
				isRecord=true;
			}
			else{
				//只要没进入实地考察和签约，都记录跟踪状态
				if(!oldStatus.equals(SupplierStatusEnum.INVEST.getType())&&!oldStatus.equals(SupplierStatusEnum.SIGN.getType())){
					if(!oldStatus.equals(supplier.getStatus())){
                       isRecord=true;
				}
			}
			if(isRecord){
				UserTrackRecordVo userTrackRecordVo=new UserTrackRecordVo();
				userTrackRecordVo.setSupplierId(supplierCertifyVo.getSupplier().getId());
				userTrackRecordVo.setMemberId(supplierCertifyVo.getMemberId());
				userTrackRecordVo.setType(UserTrackTypeEnum.CERTIFY.getType());
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



		}
		else{
			save(supplier);
			if(supplierCertifyVo.getSupplierCommodityVos()!=null){
				for(SupplierCommodityVo commodityVo:supplierCertifyVo.getSupplierCommodityVos()){
					commodityVo.setSupplierId(supplierCertifyVo.getSupplier().getId());
					supplierCommodityService.save(commodityVo);
				}
			}
			UserTrackRecordVo userTrackRecordVo=new UserTrackRecordVo();
			userTrackRecordVo.setSupplierId(supplierCertifyVo.getSupplier().getId());
			userTrackRecordVo.setMemberId(supplierCertifyVo.getMemberId());
			userTrackRecordVo.setType(UserTrackTypeEnum.CERTIFY.getType());
			userTrackRecordVo.setContent("信息审核正确");
			userTrackRecordVo.setCreateTime(new Date());
			userTrackRecordService.create(userTrackRecordVo);

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
			userTrackRecordVo.setType(UserTrackTypeEnum.JUDGE.getType());
			userTrackRecordVo.setCreateTime(new Date());
			userTrackRecordService.create(userTrackRecordVo);
		}



	}

	@Override
	public Boolean existSupplier(String phone) {
		SupplierVo param = new SupplierVo();
		param.setPhone(phone);
		List<SupplierVo> list = supplierDao.findByParams(param);
		if (list.size() == 0) {
			return false;
		}
		return true;
	}

	@Override
	public ICommonDao<Supplier> getDao() {
		return supplierDao;
	}






}
