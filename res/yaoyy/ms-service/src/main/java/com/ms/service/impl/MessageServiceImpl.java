package com.ms.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.ms.dao.ICommonDao;
import com.ms.dao.MessageDao;
import com.ms.dao.model.Message;
import com.ms.dao.vo.MessageVo;
import com.ms.service.MessageService;
import com.ms.service.enums.MessageEnum;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.util.Date;
import java.util.List;

@Service
public class MessageServiceImpl  extends AbsCommonService<Message> implements MessageService{

	@Autowired
	private MessageDao messageDao;


	@Override
	public PageInfo<MessageVo> findByParams(MessageVo messageVo,Integer pageNum,Integer pageSize) {
    	PageHelper.startPage(pageNum, pageSize);
    	List<MessageVo>  list = messageDao.findByParams(messageVo);
        PageInfo page = new PageInfo(list);
        return page;
	}

	@Override
	@Transactional
	public int create(Message message) {
		message.setCreateTime(new Date());
		message.setStatus(0);
		message.setUserId(null);
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
	public ICommonDao<Message> getDao() {
		return messageDao;
	}

}
