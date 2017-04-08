package com.ms.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.google.common.base.Strings;
import com.ms.dao.ICommonDao;
import com.ms.dao.UserDao;
import com.ms.dao.enums.IdentityTypeEnum;
import com.ms.dao.enums.UserEnum;
import com.ms.dao.enums.UserSourceEnum;
import com.ms.dao.enums.UserTypeEnum;
import com.ms.dao.model.User;
import com.ms.dao.model.UserDetail;
import com.ms.dao.vo.UserDetailVo;
import com.ms.dao.vo.UserVo;
import com.ms.service.CategoryService;
import com.ms.service.UserDetailService;
import com.ms.service.UserService;
import com.ms.service.dto.Password;
import com.ms.service.enums.ContractEnum;
import com.ms.service.enums.RedisEnum;
import com.ms.service.redis.RedisManager;
import com.ms.service.sms.SmsUtil;
import com.ms.service.utils.EncryptUtil;
import com.ms.tools.exception.ValidationException;
import me.chanjar.weixin.mp.bean.result.WxMpUser;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.servlet.http.HttpSession;
import java.util.Date;
import java.util.List;

@Service
public class UserServiceImpl  extends AbsCommonService<User> implements UserService{

	@Autowired
	private UserDao userDao;
	@Autowired
	private UserDetailService userDetailService;

	@Autowired
	private SmsUtil smsUtil;

	@Autowired
	private RedisManager redisManager;

	@Autowired
	private CategoryService categoryService;

	@Override
	public PageInfo<UserVo> findByParams(UserVo userVo,Integer pageNum,Integer pageSize) {
		if (pageNum == null || pageSize == null) {
			pageNum = 1;
			pageSize = 10;
		}
		PageHelper.startPage(pageNum, pageSize);
		List<UserVo> list = userDao.findByParams(userVo);
		PageInfo page = new PageInfo(list);
		return page;
	}


	@Override
	public UserVo findByPhone(String phone) {
            return userDao.findByPhone(phone);
	}

	public UserVo findByOpenId(String openId){
		return userDao.findByOpenId(openId);
	}

	@Override
	public UserVo findById(Integer id) {
		UserVo vo = new UserVo();
		vo.setId(id);
		UserVo userVo = userDao.findByParams(vo).get(0);
		userVo.setEnterCategoryList(categoryService.findByIds(userVo.getCategoryIds()));
		return userDao.findByParams(vo).get(0);
	}

	@Override
	@Transactional
	public void disable(Integer id) {
		User user =new User();
		user.setId(id);
		user.setStatus(UserEnum.disable.getType());
		userDao.update(user);
	}

	@Override
	@Transactional
	public void enable(Integer id) {
		User user =new User();
		user.setId(id);
		user.setStatus(UserEnum.enable.getType());
		userDao.update(user);
	}

	@Override
	public void login(Subject subject, UsernamePasswordToken token) {
		User user = findByPhone(token.getUsername());

		try{
			subject.login(token);
		}catch(Exception e){
			e.printStackTrace();
			throw new RuntimeException("账号或密码错误.");
		}

		user.setPassword(null);
		user.setSalt(null);
		Session s = subject.getSession();
		s.setAttribute(RedisEnum.USER_SESSION_BIZ.getValue(), user);
	}

	@Override
	public void logout() {
		SecurityUtils.getSubject().logout();
	}

	@Override
	@Transactional
	public User loginSms(String phone, String code) {
		String rcode = redisManager.get(RedisEnum.KEY_MOBILE_CAPTCHA_LOGIN.getValue()+phone);
		if (!code.equalsIgnoreCase(rcode)) {
			throw new RuntimeException("验证码错误");
		}

		User user =  findByPhone(phone);

		if (user == null) {
			user = new User();
			user.setPhone(phone);
			user.setType(UserTypeEnum.purchase.getType());
			user.setSource(UserSourceEnum.auto.getType());
			user.setStatus(UserEnum.enable.getType());
			user.setCreateTime(new Date());
			user.setUpdateTime(new Date());
			create(user);
		}

		return user;
	}

	@Override
	@Transactional
	public void register(String phone, String code, String password, String name) {

		String rcode = redisManager.get(RedisEnum.KEY_MOBILE_CAPTCHA_REGISTER.getValue()+phone);

		if (!code.equalsIgnoreCase(rcode)) {
			throw new RuntimeException("验证码错误");
		}

		User existUser = findByPhone(phone);
		if ( existUser!= null) {
			// 判断用户是否通过微信
			if (Strings.isNullOrEmpty(existUser.getPassword())){
				// 微信openId 存在 密码不存在修改注册信息
				Password pass = EncryptUtil.PiecesEncode(password);
				existUser.setPassword(pass.getPassword());
				existUser.setSalt(pass.getSalt());
				update(existUser);
			} else {
				throw new RuntimeException("电话号码已经存在");
			}
		} else {
			User user = new User();
			user.setPhone(phone);
			user.setType(UserTypeEnum.purchase.getType());
			user.setSource(UserSourceEnum.register.getType());
			user.setStatus(UserEnum.enable.getType());
			user.setCreateTime(new Date());
			user.setUpdateTime(new Date());
			Password pass = EncryptUtil.PiecesEncode(password);
			user.setPassword(pass.getPassword());
			user.setSalt(pass.getSalt());
			create(user);

			//新需求中注册新增"姓名"字段，add by kevin 20170405
			UserDetail userDetail = new UserDetail();
			userDetail.setUserId(user.getId());
			userDetail.setType(IdentityTypeEnum.t0.getId());
			userDetail.setName(name);
			userDetail.setPhone(phone);
			userDetail.setContract(0);//因为是采购商注册，默认未签合同，所以填0
			userDetail.setCreateTime(new Date());
			userDetail.setUpdateTime(new Date());
			userDetailService.create(userDetail);
		}
	}

	@Override
	@Transactional
	public User registerWechat(String phone, String openId, String nickname, String headImgUrl, String name) {
		User user = findByPhone(phone);
		if(user!=null){
			user.setType(UserEnum.enable.getType());
			user.setOpenid(openId);
			update(user);
		}else{
			user = new User();
			user.setPhone(phone);
			user.setOpenid(openId);
			user.setType(UserTypeEnum.purchase.getType());
			user.setSource(UserSourceEnum.register.getType());
			user.setStatus(UserEnum.enable.getType());
			user.setCreateTime(new Date());
			user.setUpdateTime(new Date());
			create(user);
		}

		UserDetail userDetail  = userDetailService.findByUserId(user.getId());
		if(userDetail==null){
			userDetail = new UserDetail();
			userDetail.setType(0);
			userDetail.setUserId(user.getId());
			userDetail.setPhone(phone);
			userDetail.setNickname(nickname);
			userDetail.setHeadImgUrl(headImgUrl);
			userDetail.setName(name);
		}else {
			userDetail.setHeadImgUrl(headImgUrl);
			userDetail.setName(name);
		}
		userDetailService.save(userDetail);
		return user;
	}



	@Override
	public void sendRegistSms(String phone) {
		try {
			smsUtil.sendRegistCaptcha(phone);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	public void sendLoginSms(String phone) {
		try {
			smsUtil.sendLoginCaptcha(phone);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	public void sendResetPasswordSms(String phone) {
		try {
			smsUtil.sendResetPasswordSms(phone);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	@Transactional
	public void resetPassword(String phone, String code, String password) {
		String rcode = redisManager.get(RedisEnum.KEY_MOBILE_RESET_PASSWORD.getValue()+phone);

		if (!code.equalsIgnoreCase(rcode)) {
			throw new RuntimeException("验证码错误");
		}

		User user = findByPhone(phone);
		Password pass = EncryptUtil.PiecesEncode(password);
		user.setPassword(pass.getPassword());
		user.setSalt(pass.getSalt());
		user.setUpdateTime(new Date());
		userDao.update(user);
	}

	@Override
	@Transactional
	public UserVo sign(UserVo userVo, UserDetailVo userDetailVo) {

		User existUser = findByPhone(userVo.getPhone());
		if ( existUser!= null) {
			// 判断用户是否通过微信
			if (Strings.isNullOrEmpty(existUser.getPassword())){
				// 微信openId 存在 密码不存在修改注册信息
				Password pass = EncryptUtil.PiecesEncode(userVo.getPassword());
				existUser.setPassword(pass.getPassword());
				existUser.setSalt(pass.getSalt());
				update(existUser);
			}
			User user = new User();
			user.setId(existUser.getId());
			user.setType(UserTypeEnum.supplier.getType());
			user.setSupplierId(userVo.getSupplierId());
			update(user);
		} else {
			User user = new User();
			user.setPhone(userVo.getPhone());
			user.setType(UserTypeEnum.supplier.getType());
			user.setSource(UserSourceEnum.system.getType());
			user.setStatus(UserEnum.enable.getType());
			user.setCreateTime(new Date());
			user.setUpdateTime(new Date());
			Password pass = EncryptUtil.PiecesEncode(userVo.getPassword());
			user.setPassword(pass.getPassword());
			user.setSalt(pass.getSalt());
			user.setSupplierId(userVo.getSupplierId());

			create(user);

			userVo.setId(user.getId());
			UserDetail userDetail = new UserDetail();
			userDetail.setUserId(user.getId());
			userDetail.setType(IdentityTypeEnum.t4.getId());
			userDetail.setName(userDetailVo.getName());
			userDetail.setPhone(userDetailVo.getPhone());
			userDetail.setCategoryIds(userDetailVo.getCategoryIds());
			userDetail.setCompany(userDetailVo.getCompany());
			userDetail.setArea(userDetailVo.getArea());
			userDetail.setEmail(userDetailVo.getEmail());
			userDetail.setQq(userDetailVo.getQq());
			userDetail.setRemark(userDetailVo.getRemark());
			userDetail.setContract(userDetailVo.getContract());
			userDetail.setCreateTime(new Date());
			userDetail.setUpdateTime(new Date());
			userDetailService.create(userDetail);
		}
		return userVo;
	}


	@Override
	@Transactional
	public void login(Subject subject, UsernamePasswordToken token, WxMpUser wxMpUser) {
		User user = findByPhone(token.getUsername());
		if (user == null || user.getSupplierId() == null) {
			// 用户不存在或者用户类型为采购商时提醒用户账号未激活或者签约
			throw new ValidationException("您的账号在药优优供应商系统未激活，请联系工作人员激活或修改。");
		}

		try {
			login(subject, token);
		} catch (Exception e) {
			throw new ValidationException("密码错误。");
		}

		if (wxMpUser!= null) {
//			User user = findByPhone(token.getUsername());
			user.setOpenid(wxMpUser.getOpenId());
			update(user);
			UserDetail userDetail = userDetailService.findByUserId(user.getId());
			if (userDetail == null) {
				userDetail = new UserDetail();
				userDetail.setType(0);
				userDetail.setUserId(user.getId());
				userDetail.setPhone(user.getPhone());
				userDetail.setNickname(wxMpUser.getNickname());
				userDetail.setHeadImgUrl(wxMpUser.getHeadImgUrl());
			} else {
				userDetail.setHeadImgUrl(wxMpUser.getHeadImgUrl());
			}
			userDetailService.save(userDetail);
		}
	}

	@Override
	public PageInfo<UserVo> findVoByParams(UserVo userVo,Integer pageNum,Integer pageSize) {
		if (pageNum == null || pageSize == null) {
			pageNum = 1;
			pageSize = 10;
		}
		PageHelper.startPage(pageNum, pageSize);
		List<UserVo> list = userDao.findByParams(userVo);
		list.forEach(u->{
			u.setEnterCategoryList(categoryService.findByIds(u.getCategoryIds()));
			u.setIsContract(ContractEnum.get(u.getContract()));
		});
		PageInfo page = new PageInfo(list);
		return page;
	}

	@Override
	public List<UserVo> findByParamsNoPage(UserVo userVo) {
		return userDao.findByParams(userVo);
	}

	@Override
	public List<UserVo> findSupplierSignUser(String name) {
		UserVo userVo = new UserVo();
		userVo.setName(name);
		return userDao.findSupplierSignUser(userVo);
	}


	@Override
	public boolean isBinding(Integer supplierId) {
		UserVo param = new UserVo();
		param.setSupplierId(supplierId);
		List<UserVo> list = userDao.findByParams(param);
		if (list.size() == 0) {
			return false;
		}
		return true;
	}

	@Override
	@Transactional
	public void signSave(UserVo userVo) {
//		User user = new User();
//		user.setId(userVo.getId());
//		user.setPhone(userVo.getPhone());
//		update(user);


		UserDetail userDetail = new UserDetail();
		userDetail.setUserId(userVo.getId());
		userDetail.setType(IdentityTypeEnum.t4.getId());
		userDetail.setName(userVo.getName());
		userDetail.setPhone(userVo.getPhone());
		userDetail.setCategoryIds(userVo.getEnterCategory());
		userDetail.setCompany(userVo.getCompany());
		userDetail.setArea(userVo.getArea());
		userDetail.setEmail(userVo.getEmail());
		userDetail.setQq(userVo.getQq());
		userDetail.setContract(userVo.getContract());
		userDetail.setRemark(userVo.getMark());
		if(userDetailService.findByUserId(userVo.getId())!=null) {
			userDetail.setUpdateTime(new Date());
			userDetailService.update(userDetail);
		}else{
			userDetail.setCreateTime(new Date());
			userDetail.setUpdateTime(new Date());
			userDetailService.create(userDetail);
		}
	}

	@Override
	public ICommonDao<User> getDao() {
		return userDao;
	}
}
