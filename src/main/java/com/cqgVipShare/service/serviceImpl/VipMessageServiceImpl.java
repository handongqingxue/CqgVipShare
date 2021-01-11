package com.cqgVipShare.service.serviceImpl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.cqgVipShare.dao.*;
import com.cqgVipShare.entity.*;
import com.cqgVipShare.service.*;

@Service
public class VipMessageServiceImpl implements VipMessageService {

	@Autowired
	private VipMessageMapper vipMessageDao;
	@Autowired
	private CapFlowRecMapper capFlowRecDao;

	@Override
	public List<VipMessage> selectCommentListByOpenId(String openId) {
		// TODO Auto-generated method stub
		return vipMessageDao.selectCommentListByOpenId(openId);
	}

	@Override
	public int addComment(VipMessage msg) {
		// TODO Auto-generated method stub
		int count=0;
		msg.setType(VipMessage.PL_VIP);
		count=vipMessageDao.addMessage(msg);
		if(count>0) {
			count=capFlowRecDao.updateCapFlowStateBySrUuid(CapitalFlowRecord.YPL_STATE,msg.getSrUuid());
		}
		return count;
	}
}
