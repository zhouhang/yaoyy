package com.ms.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.ms.dao.*;
import com.ms.dao.enums.*;
import com.ms.dao.model.*;
import com.ms.dao.vo.*;
import com.ms.service.*;
import com.ms.service.enums.MessageEnum;
import com.ms.service.observer.MsgProducerEvent;
import com.ms.tools.exception.ControllerException;
import com.ms.tools.utils.SeqNoUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Calendar;
import java.util.Date;
import java.util.List;

@Service
public class PickServiceImpl  extends AbsCommonService<Pick> implements PickService{

	@Autowired
	private PickDao pickDao;


	@Autowired
	private PickCommodityService pickCommodityService;


	@Autowired
	private UserDao userDao;

	@Autowired
	private UserDetailDao userDetailDao;


	@Autowired
	private PickTrackingDao pickTrackingDao;

	@Autowired
	private CommodityService commodityService;

	private CodeDao codeDao;

	@Autowired
	private  ApplicationContext applicationContext;

	@Autowired
	private MemberService memberService;

	@Autowired
	private PickTrackingService  pickTrackingService;



	@Override
	public PageInfo<PickVo> findByParams(PickVo pickVo,Integer pageNum,Integer pageSize) {
		pageNum = pageNum==null?1:pageNum;
		pageSize = pageSize==null?10:pageSize;
        PageHelper.startPage(pageNum, pageSize);
    	List<PickVo>  list = pickDao.findByParams(pickVo);
		list.forEach(p->{
			List<PickCommodityVo> pickCommodityVos=pickCommodityService.findByPickId(p.getId());
			float total=0;

			for(PickCommodityVo vo :pickCommodityVos){
				total+=vo.getTotal();
			}
			p.setTotal(total);

			p.setPickCommodityVoList(pickCommodityVos);
		});
        PageInfo page = new PageInfo(list);
        return page;
	}

	@Override
	public PickVo findVoById(Integer id) {
		PickVo pickVo=pickDao.findVoById(id);
		List<PickCommodityVo> pickCommodityVos=pickCommodityService.findByPickId(id);
		float total=0;

		for(PickCommodityVo vo :pickCommodityVos){
			total+=vo.getTotal();
		}
		pickVo.setTotal(total);

		pickVo.setPickCommodityVoList(pickCommodityVos);

		return pickVo;
	}

	@Override
	@Transactional
	public void save(PickVo pickVo) {
		UserVo userVo=userDao.findByPhone(pickVo.getPhone());

		Integer nowLogin=pickVo.getUserId();//现在登录的userid
		//如果用户注册
		Date now=new Date();

		int useId;
		if (userVo==null){
			User user=new User();
			user.setPhone(pickVo.getPhone());
			user.setType(UserEnum.auto.getType());
			user.setSalt("");
			user.setPassword("");
			//user.setOpenid("");
			user.setUpdateTime(now);
			user.setCreateTime(now);
			userDao.create(user);

			useId=user.getId();
		}
		else{
			useId=userVo.getId();
		}
		UserDetail userDetail=userDetailDao.findByUserId(useId);
		if (userDetail==null){
			userDetail=new UserDetail();
			userDetail.setPhone(pickVo.getPhone());
			userDetail.setNickname(pickVo.getNickname());
			userDetail.setArea("");
			userDetail.setUserId(useId);
			userDetail.setName("");
			userDetail.setRemark("");
			userDetail.setType(0);
			userDetail.setUpdateTime(now);
			userDetail.setCreateTime(now);
			userDetailDao.create(userDetail);
		}
		else{
			userDetail.setPhone(pickVo.getPhone());
			userDetail.setNickname(pickVo.getNickname());
			userDetail.setUpdateTime(now);
			userDetailDao.update(userDetail);
		}




		Pick pick=new Pick();
		if(nowLogin==null){
			pick.setUserId(useId);
		}
		else{
			pick.setUserId(nowLogin);
		}
		pick.setNickname(pickVo.getNickname());
		pick.setPhone(pickVo.getPhone());
		pick.setStatus(PickEnum.PICK_NOTHANDLE.getValue());
		pick.setUpdateTime(now);
		pick.setCreateTime(now);
		pick.setCode("");
		pick.setAbandon(0);

		/**
		 * 设置code
		 */
		pick.setCode(SeqNoUtil.getOrderCode());
		pickDao.create(pick);

		pickVo.getPickCommodityVoList().forEach(c->{
			c.setPickId(pick.getId());
		});
		pickCommodityService.saveList(pickVo.getPickCommodityVoList());



		PickTracking pickTracking=new PickTracking();
		pickTracking.setName(pickVo.getNickname());
		pickTracking.setOpType(TrackingTypeEnum.TYPE_USER.getValue());
		if(nowLogin==null){
			pickTracking.setOperator(useId);
		}
		else{
			pickTracking.setOperator(nowLogin);
		}
		pickTracking.setExtra("");
		pickTracking.setCreateTime(now);
		pickTracking.setUpdateTime(now);
		pickTracking.setPickId(pick.getId());
		pickTracking.setRecordType(PickTrackingTypeEnum.PICK_APPLY.getValue());
		pickTrackingDao.create(pickTracking);

		/**
		 * 存消息
		 *
		 */
		String content=pick.getNickname()+"提交选货单";
		MsgProducerEvent msgProducerEvent =new MsgProducerEvent(pick.getUserId(),pick.getId(), MessageEnum.PICK,content);
		applicationContext.publishEvent(msgProducerEvent);



	}

	@Override
	@Transactional
	public void createOrder(PickVo pickVo) {

		PickVo oldPick=pickDao.findVoById(pickVo.getId());
		if(oldPick.getStatus()!=PickEnum.PICK_PAY.getValue()){
			//创建一条生成订单跟踪记录
			PickTracking pickTracking=new PickTracking();
			if(pickVo.getMemberId()!=null){
				Member member=memberService.findById(pickVo.getMemberId());
				pickTracking.setName(member.getName());
				pickTracking.setOpType(TrackingTypeEnum.TYPE_ADMIN.getValue());
			}
			else{
				PickVo pick=pickDao.findVoById(pickVo.getId());
				pickTracking.setName(pick.getNickname());
				pickTracking.setOpType(TrackingTypeEnum.TYPE_USER.getValue());
			}


			pickTracking.setExtra("");
			pickTracking.setCreateTime(new Date());
			pickTracking.setUpdateTime(new Date());
			pickTracking.setPickId(pickVo.getId());
			pickTracking.setRecordType(PickTrackingTypeEnum.PICK_ORDER.getValue());
			pickTrackingDao.create(pickTracking);

		}
		else{
			//创建一条修改结算详情的记录
			for(PickCommodity pickCommodity:pickVo.getPickCommodityVoList()){
				pickCommodityService.update(pickCommodity);
			}
			PickTracking pickTracking=new PickTracking();
			if(pickVo.getMemberId()!=null){
				Member member=memberService.findById(pickVo.getMemberId());
				pickTracking.setName(member.getName());
				pickTracking.setOpType(TrackingTypeEnum.TYPE_ADMIN.getValue());
			}
			else{
				PickVo pick=pickDao.findVoById(pickVo.getId());
				pickTracking.setName(pick.getNickname());
				pickTracking.setOpType(TrackingTypeEnum.TYPE_USER.getValue());
			}


			pickTracking.setExtra("");
			pickTracking.setCreateTime(new Date());
			pickTracking.setUpdateTime(new Date());
			pickTracking.setPickId(pickVo.getId());
			pickTracking.setRecordType(PickTrackingTypeEnum.PICK_UPDATE.getValue());
			pickTrackingDao.create(pickTracking);

		}
		//全款或保证金
		if(pickVo.getSettleType()==SettleTypeEnum.SETTLE_ALL.getType()||pickVo.getSettleType()==SettleTypeEnum.SETTLE_DEPOSIT.getType()){
			pickVo.setStatus(PickEnum.PICK_PAY.getValue());
		}
		else{
			pickVo.setStatus(PickEnum.PICK_CONFIRM.getValue());
		}
		//设置有效期
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(new Date());
		calendar.add(Calendar.DATE, 3);
		pickVo.setExpireDate(calendar.getTime());
		pickDao.update(pickVo);


	}

	@Override
	@Transactional
	public void changeOrderStatus(Integer id, Integer status) {
		Pick pick=new Pick();
		pick.setId(id);
		pick.setStatus(status);
		pick.setUpdateTime(new Date());
		pickDao.update(pick);
	}
    @Override
	@Transactional
	public void updateCommodityNum(List<PickCommodity> pickCommodities) {
		for(PickCommodity pickCommodity:pickCommodities){
			pickCommodityService.update(pickCommodity);
		}
	}

	@Override
	@Transactional
	public void cancel(Integer id, Integer userId) {
		// 判断订单属于当前用户,再取消
		Pick pick = findById(id);
		if (pick!= null && pick.getId().equals(userId)) {
			throw new ControllerException("没有权限取消订单");
			// TODO: 判断当前订单的状态是否 处于可取消状态
		}
		changeOrderStatus(id,PickEnum.PICK_CANCLE.getValue());
	}




	@Override
	@Transactional
	public void receipt(Integer id, Integer userId) {
		// 判断订单属于当前用户,再取消
		Pick pick = findById(id);
		if (pick!= null && pick.getId().equals(userId)) {
			throw new ControllerException("没有权限取消订单");
			// TODO: 判断当前订单的状态是否 处于可确认收货状态
		}
		changeOrderStatus(id,PickEnum.PICK_FINISH.getValue());
	}

	@Override
	@Transactional
	public void saveOrder(PickVo pickVo) {
		//判断提交的订单是否属于当前用户
		// 收货地址保存到历史收货地址表中并把ID 回填到订单表
		// 保存发票信息
		// 保存订单

	}

	@Override
	public ICommonDao<Pick> getDao() {
		return pickDao;
	}



}
