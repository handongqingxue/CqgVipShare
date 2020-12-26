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
	private MessageMapper messageDao;
	@Autowired
	private CapFlowRecMapper capFlowRecDao;

	@Override
	public List<Message> selectCommentListByOpenId(String openId) {
		// TODO Auto-generated method stub
		return messageDao.selectCommentListByOpenId(openId);
	}

	@Override
	public int addComment(Message msg) {
		// TODO Auto-generated method stub
		int count=0;
		msg.setType(Message.PL_VIP);
		count=messageDao.addMessage(msg);
		if(count>0) {
			count=capFlowRecDao.updateCapFlowStateBySrUuid(CapitalFlowRecord.YPL_STATE,msg.getSrUuid());
		}
		return count;
	}
}
