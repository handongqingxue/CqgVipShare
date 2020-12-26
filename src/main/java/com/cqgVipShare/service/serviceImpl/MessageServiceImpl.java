package com.cqgVipShare.service.serviceImpl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.cqgVipShare.dao.*;
import com.cqgVipShare.entity.*;
import com.cqgVipShare.service.*;

@Service
public class MessageServiceImpl implements MessageService {

	@Autowired
	private MessageMapper messageVipDao;

	@Override
	public List<Message> selectCommentListByOpenId(String openId) {
		// TODO Auto-generated method stub
		return messageVipDao.selectCommentListByOpenId(openId);
	}
}
