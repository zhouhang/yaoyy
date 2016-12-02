package com.ms.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.ms.dao.ICommonDao;
import com.ms.dao.MessageDao;
import com.ms.dao.model.Message;
import com.ms.dao.vo.MessageVo;
import com.ms.service.MessageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
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
	public ICommonDao<Message> getDao() {
		return messageDao;
	}

}
