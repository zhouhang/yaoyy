package com.ms.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.ms.dao.ICommonDao;
import com.ms.dao.MessageDao;
import com.ms.dao.model.Message;
import com.ms.dao.vo.MessageVo;
import com.ms.service.MessageService;
import com.ms.service.enums.MessageEnum;
import org.apache.commons.collections.ListUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Arrays;
import java.util.Date;
import java.util.List;

@Service
public class MessageServiceImpl  extends AbsCommonService<Message> implements MessageService{

	@Autowired
	private MessageDao messageDao;


	@Override
	public PageInfo<MessageVo> findByParams(MessageVo messageVo,Integer pageNum,Integer pageSize) {
		if (pageNum == null || pageSize == null) {
			pageNum = 1;
			pageSize = 10;
		}

    	PageHelper.startPage(pageNum, pageSize);
    	List<MessageVo>  list = messageDao.findByParams(messageVo);
		list.forEach(c->{
			c.setTypeName(MessageEnum.getTypeName(c.getType()));
		});
        PageInfo page = new PageInfo(list);
        return page;
	}

	@Override
	@Transactional
	public int create(Message message) {
		message.setCreateTime(new Date());
		message.setStatus(0);
		return super.create(message);
	}

	@Override
	@Transactional
	public void consumeMsg(Integer eventId, MessageEnum type) {
		messageDao.consumeMsg(eventId, type.get());
	}

	@Override
	@Transactional
	public void consumeMsg(Integer msgId) {
		Message message = new Message();
		message.setId(msgId);
		message.setStatus(1);
		update(message);
	}

	@Override
	public Integer count(MessageEnum type) {
		return messageDao.count(type.get());
	}

	@Override
	public List<MessageVo> findUnReadMsg() {
		MessageVo vo = new MessageVo();
		vo.setStatus(0);
		return messageDao.findByParams(vo);
	}

	@Override
	public List<MessageVo> findByParamsNoPage(MessageVo messageVo) {
		List<MessageVo> messageVos = messageDao.findByParams(messageVo);
		messageVos.forEach(c->{
			c.setTypeName(MessageEnum.getTypeName(c.getType()));
		});
		return messageVos;
	}

	@Override
	public PageInfo<MessageVo> findSupplierCommodityTraceMsg(Integer supplierId,Integer pageNum,Integer pageSize) {
		MessageVo vo = new MessageVo();
		vo.setUserId(supplierId);
		Integer[] types = {MessageEnum.SUPPLIER_SAMPLES_CONSIGNMENT.get(),
				MessageEnum.SUPPLIER_COMMODITY_CONSIGNMENT.get(),
				MessageEnum.SUPPLIER_ORDER_CONSIGNMENT.get()};
		vo.setTypes(Arrays.asList(types));
		return findByParams(vo,pageNum,pageSize);
	}

	@Override
	public ICommonDao<Message> getDao() {
		return messageDao;
	}

}
