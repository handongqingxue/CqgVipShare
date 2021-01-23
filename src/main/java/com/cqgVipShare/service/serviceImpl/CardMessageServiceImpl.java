package com.cqgVipShare.service.serviceImpl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.cqgVipShare.dao.*;
import com.cqgVipShare.entity.*;
import com.cqgVipShare.service.*;

@Service
public class CardMessageServiceImpl implements CardMessageService {

	@Autowired
	private CardMessageMapper cardMessageDao;
	@Autowired
	private CapFlowRecMapper capFlowRecDao;

	@Override
	public List<Map<String,Object>> selectCommentListByOpenId(String openId) {
		// TODO Auto-generated method stub
		return cardMessageDao.selectCommentListByOpenId(openId);
	}

	@Override
	public int addComment(CardMessage msg) {
		// TODO Auto-generated method stub
		int count=0;
		msg.setType(CardMessage.PL_CARD);
		count=cardMessageDao.addMessage(msg);
		if(count>0) {
			count=capFlowRecDao.updateCapFlowStateBySrUuid(CapitalFlowRecord.YPL_STATE,msg.getSrUuid());
		}
		return count;
	}
}
