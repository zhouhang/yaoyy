package com.ms.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.ms.dao.ICommonDao;
import com.ms.dao.SampleTrackingDao;
import com.ms.dao.SendSampleDao;
import com.ms.dao.TrackingDetailDao;
import com.ms.dao.enums.MsgIsMemberEnum;
import com.ms.dao.enums.SampleEnum;
import com.ms.dao.enums.TrackingDetailEnum;
import com.ms.dao.enums.TrackingEnum;
import com.ms.dao.model.Message;
import com.ms.dao.model.SampleTracking;
import com.ms.dao.model.SendSample;
import com.ms.dao.model.TrackingDetail;
import com.ms.dao.vo.SampleTrackingVo;
import com.ms.dao.vo.SendSampleVo;
import com.ms.service.SampleTrackingService;
import com.ms.service.SendSampleService;
import com.ms.service.enums.MessageEnum;
import com.ms.service.enums.MessageTemplateEnum;
import com.ms.service.observer.MsgConsumeEvent;
import com.ms.service.observer.MsgProducerEvent;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.servlet.annotation.HttpConstraint;
import javax.servlet.http.HttpSession;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Service
public class SampleTrackingServiceImpl  extends AbsCommonService<SampleTracking> implements SampleTrackingService{

	@Autowired
	private SampleTrackingDao sampleTrackingDao;

	@Autowired
	private SendSampleDao sendSampleDao;

	@Autowired
	private TrackingDetailDao tackingDetailDao;

	@Autowired
	private ApplicationContext applicationContext;

	@Autowired
	private SendSampleService sendSampleService;

	@Override
	public PageInfo<SampleTrackingVo> findByParams(SampleTrackingVo sampleTrackingVo,Integer pageNum,Integer pageSize) {
    PageHelper.startPage(pageNum, pageSize);
    	List<SampleTrackingVo>  list = sampleTrackingDao.findByParams(sampleTrackingVo);
        PageInfo page = new PageInfo(list);
        return page;
	}

	@Override
	public List<SampleTrackingVo> findAllByParams(SampleTrackingVo sampleTrackingVo) {
		return sampleTrackingDao.findByParams(sampleTrackingVo);
	}

	@Override
	@Transactional
	public void save(SampleTracking sampleTracking, TrackingDetail trackingDetail) {
		//需要更新寄样单状态的记录类型
		List<Integer> requie=new ArrayList<Integer>();
		requie.add(TrackingEnum.TRACKING_AGREE.getValue());
		requie.add(TrackingEnum.TRACKING_REFUSE.getValue());
		requie.add(TrackingEnum.TRACKING_SEND.getValue());
		requie.add(TrackingEnum.TRACKING_ORDER.getValue());
		requie.add(TrackingEnum.TRACKING_FINISH.getValue());

		Date now=new Date();

		Integer recordType=sampleTracking.getRecordType();
		if(requie.indexOf(sampleTracking.getRecordType())!=-1){
			SendSample sendSample=new SendSample();
			sendSample.setId(sampleTracking.getSendId());
			if(recordType.intValue()==TrackingEnum.TRACKING_AGREE.getValue()){
				sendSample.setStatus(SampleEnum.SAMPLE_AGREE.getValue());
				/**
				 * 消费掉消息
				 */
				MsgConsumeEvent msgConsumeEvent=new MsgConsumeEvent(sendSample.getId(),MessageEnum.SAMPLE);
				applicationContext.publishEvent(msgConsumeEvent);
				//同意寄样通知客户
				MsgProducerEvent msgSample =new MsgProducerEvent(sendSample.getUserId(),sendSample.getId(), MessageEnum.SAMPLE_CONFIRM,null, MsgIsMemberEnum.IS_MEMBER.getKey());
				applicationContext.publishEvent(msgSample);
			}
			else if(recordType.intValue()==TrackingEnum.TRACKING_REFUSE.getValue()){
				sendSample.setStatus(SampleEnum.SAMPLE_REFUSE.getValue());
				MsgConsumeEvent msgConsumeEvent=new MsgConsumeEvent(sendSample.getId(),MessageEnum.SAMPLE);
				applicationContext.publishEvent(msgConsumeEvent);
			}
			else if(recordType.intValue()==TrackingEnum.TRACKING_SEND.getValue()){
				trackingDetail.setType(TrackingDetailEnum.TYPE_SEND.getValue());
				trackingDetail.setCreateTime(now);
				trackingDetail.setSendId(sampleTracking.getSendId());
				tackingDetailDao.create(trackingDetail);
				sendSample.setStatus(SampleEnum.SAMPLE_SEND.getValue());
				sampleTracking.setExtra("快递公司："+trackingDetail.getCompany()+" "+"快递单号："+trackingDetail.getTrackingNo());

				// 寄送样品时发送通知给供应商告诉寄送了样品
				SendSampleVo sendSampleVo = sendSampleService.findDetailById(sampleTracking.getSendId());
				Message message = new Message();
				message.setContent(MessageTemplateEnum.SUPPLIER_COMMODITY_STOCK_TEMPLATE.get().replace("{name}",sampleTracking.getName())
						.replace("{commodity}", sendSampleVo.getIntentionText()));
				message.setCreateTime(new Date());
				message.setType(MessageEnum.SUPPLIER_SAMPLES.get());
//				message.setUserId();
				message.setIsMember(0);
				message.setEventId(sampleTracking.getSendId());
//				messageService.create(message);
			}
			else if(recordType.intValue()==TrackingEnum.TRACKING_ORDER.getValue()){
				trackingDetail.setType(TrackingDetailEnum.TYPE_ORDER.getValue());
				trackingDetail.setCreateTime(now);
				trackingDetail.setSendId(sampleTracking.getSendId());
				tackingDetailDao.create(trackingDetail);
				sendSample.setStatus(SampleEnum.SAMPLE_VISTE.getValue());
				SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy年MM月dd日 HH:mm");
				sampleTracking.setExtra("预约时间："+dateFormat.format(trackingDetail.getVistorTime())+" "+"来访人："+trackingDetail.getVistor()+" "+"电话："+trackingDetail.getVistorPhone());
			}else{
				sendSample.setStatus(SampleEnum.SAMPLE_FINISH.getValue());
			}
			sendSampleDao.update(sendSample);
		}

		if(sampleTracking.getExtra()==null){
			sampleTracking.setExtra("");
		}
		sampleTracking.setCreateTime(now);

		sampleTrackingDao.create(sampleTracking);


	}


	@Override
	public ICommonDao<SampleTracking> getDao() {
		return sampleTrackingDao;
	}

}
