package com.ms.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.ms.dao.*;
import com.ms.dao.enums.SampleEnum;
import com.ms.dao.enums.TrackingEnum;
import com.ms.dao.enums.TrackingTypeEnum;
import com.ms.dao.enums.UserEnum;
import com.ms.dao.model.*;
import com.ms.dao.vo.CommodityVo;
import com.ms.dao.vo.HistoryCommodityVo;
import com.ms.dao.vo.SendSampleVo;
import com.ms.dao.vo.UserVo;
import com.ms.service.CommodityService;
import com.ms.service.HistoryCommodityService;
import com.ms.service.SendSampleService;
import com.ms.service.enums.MessageEnum;
import com.ms.service.observer.MsgProducerEvent;
import com.ms.service.properties.SystemProperties;
import com.ms.service.sms.SmsUtil;
import com.ms.tools.utils.SeqNoUtil;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.ApplicationContext;
import org.springframework.ejb.access.EjbAccessException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Service
public class SendSampleServiceImpl  extends AbsCommonService<SendSample> implements SendSampleService{


	@Autowired
	private SystemProperties systemProperties;

	@Autowired
	private SendSampleDao sendSampleDao;

	@Autowired
	private CommodityService commodityService;

	@Autowired
	private HistoryCommodityService historyCommodityService;

	@Autowired
	private UserDao userDao;

	@Autowired
	private UserDetailDao userDetailDao;

	@Autowired
	private SampleTrackingDao sampleTrackingDao;

	@Autowired
	private SmsUtil smsUtil;

	@Autowired
	private  ApplicationContext applicationContext;




	@Override
	public PageInfo<SendSampleVo> findByParams(SendSampleVo sendSampleVo,Integer pageNum,Integer pageSize) {
		pageNum = pageNum==null?1:pageNum;
		pageSize = pageSize==null?10:pageSize;
        PageHelper.startPage(pageNum, pageSize);
    	List<SendSampleVo>  list = sendSampleDao.findByParams(sendSampleVo);
		//意向商品转化为显示字符串
		list.forEach(s->{
			List<HistoryCommodityVo> commodityList = historyCommodityService.findByIds(s.getIntention());
			s.setCommodityList(commodityList);
		});
        PageInfo page = new PageInfo(list);
        return page;
	}

	@Override
	public SendSampleVo findDetailById(Integer id) {
		SendSampleVo sendSampleVo=sendSampleDao.findDetailById(id);
		if(sendSampleVo==null){
			return null;
		}
		List<HistoryCommodityVo> commodityList = historyCommodityService.findByIds(sendSampleVo.getIntention());
		sendSampleVo.setCommodityList(commodityList);
		return sendSampleVo ;
	}

	@Override
	public List<SendSampleVo> findByCommodityId(int userId,List<Integer> ids) {
		String idstr=StringUtils.join(ids, "|");
		List<SendSampleVo> sendSampleVos= sendSampleDao.findByCommodityId(userId,idstr);
		for(SendSampleVo s:sendSampleVos)
		{
			List<HistoryCommodityVo> commodityList = historyCommodityService.findByIds(s.getIntention());
			s.setCommodityList(commodityList);

		}
		return sendSampleVos;
	}

	@Override
	public List<SendSampleVo> findByUserId(Integer userId) {
		SendSampleVo sendSampleVo=new SendSampleVo();
		sendSampleVo.setUserId(userId);
		List<SendSampleVo>  list = sendSampleDao.findByParams(sendSampleVo);
		for(SendSampleVo s:list)
		{
			List<HistoryCommodityVo> commodityList = historyCommodityService.findByIds(s.getIntention());
			s.setCommodityList(commodityList);

		}
		return list;
	}

	@Override
	@Transactional
	public void save(SendSampleVo sendSampleVo) {

		UserVo userVo=userDao.findByPhone(sendSampleVo.getPhone());
		Integer nowLogin = sendSampleVo.getUserId();//现在登录的userid
		//在用户未登入时所给的手机号未注册的话则给用户注册默认账号.
		Date now=new Date();
		if (userVo==null && nowLogin ==null){
			User user=new User();
			user.setPhone(sendSampleVo.getPhone());
			user.setType(UserEnum.auto.getType());
			user.setSalt("");
			user.setPassword("");
			//user.setOpenid("");
			user.setUpdateTime(now);
			user.setCreateTime(now);
			userDao.create(user);
			nowLogin=user.getId();
		}

		if (nowLogin == null) {
			nowLogin = userVo.getId();
		}

		UserDetail userDetail = userDetailDao.findByUserId(nowLogin);
		if (userDetail == null) {
			userDetail = new UserDetail();
			userDetail.setPhone(sendSampleVo.getPhone());
			userDetail.setNickname(sendSampleVo.getNickname());
			userDetail.setArea(sendSampleVo.getArea());
			userDetail.setUserId(nowLogin);
			userDetail.setName("");
			userDetail.setRemark("");
			userDetail.setType(0);
			userDetail.setUpdateTime(now);
			userDetail.setCreateTime(now);
			userDetailDao.create(userDetail);
		}

		SendSample sendSample = new SendSample();
		sendSample.setUserId(nowLogin);
		sendSample.setNickname(sendSampleVo.getNickname());
		sendSample.setPhone(sendSampleVo.getPhone());
		sendSample.setArea(sendSampleVo.getArea());
		sendSample.setStatus(SampleEnum.SAMPLE_NOTHANDLE.getValue());

		//寄样的商品存历史表
		List<CommodityVo> commodityList =commodityService.findByIds(sendSampleVo.getIntention());
		List<Integer> ids=new ArrayList<>();
		commodityList.forEach(c->{
			HistoryCommodity historyCommodity=historyCommodityService.saveCommodity(c);
			ids.add(historyCommodity.getId());
		});

		sendSample.setIntention(StringUtils.join(ids,","));

		sendSample.setUpdateTime(now);
		sendSample.setCreateTime(now);
		sendSample.setCode(SeqNoUtil.getSampleCode());
		sendSampleDao.create(sendSample);

		SampleTracking sampleTracking=new SampleTracking();
		sampleTracking.setName(sendSampleVo.getNickname());
		sampleTracking.setType(TrackingTypeEnum.TYPE_USER.getValue());
		sampleTracking.setOperator(nowLogin);

		sampleTracking.setExtra("");
		sampleTracking.setCreateTime(now);
		sampleTracking.setSendId(sendSample.getId());
		sampleTracking.setRecordType(TrackingEnum.TRACKING_APPLY.getValue());
		sampleTrackingDao.create(sampleTracking);

		/**
		 * 存消息
		 *
		 */
		String content=sendSample.getNickname()+"寄样申请";
		MsgProducerEvent msgProducerEvent =new MsgProducerEvent(sendSample.getUserId(),sendSample.getId(), MessageEnum.SAMPLE,content);
		applicationContext.publishEvent(msgProducerEvent);

		// 通知客户寄样申请成功.
		// 获取寄样的商品
		String text = commodityList.get(0).getName() +" " + commodityList.get(0).getOrigin()+" " + commodityList.get(0).getSpec();
		MsgProducerEvent msgSample =new MsgProducerEvent(sendSample.getUserId(),sendSample.getId(), MessageEnum.SAMPLE_C,text);
		applicationContext.publishEvent(msgSample);


	}

	@Override
	public ICommonDao<SendSample> getDao() {
		return sendSampleDao;
	}

}
