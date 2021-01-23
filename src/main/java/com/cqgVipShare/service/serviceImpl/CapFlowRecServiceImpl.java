package com.cqgVipShare.service.serviceImpl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.cqgVipShare.dao.*;
import com.cqgVipShare.entity.*;
import com.cqgVipShare.service.*;

@Service
public class CapFlowRecServiceImpl implements CapFlowRecService {

	@Autowired
	private CapFlowRecMapper capFlowRecDao;
	@Autowired
	private CardMessageMapper messageDao;
	
	@Override
	public int selectFlowRecInt() {
		// TODO Auto-generated method stub
		return capFlowRecDao.selectFlowRecInt();
	}

	@Override
	public List<CapitalFlowRecord> selectFlowRecList(int page, int rows, String sort, String order) {
		// TODO Auto-generated method stub
		return capFlowRecDao.selectFlowRecList((page-1)*rows, rows, sort, order);
	}

	@Override
	public List<CapitalFlowRecord> exportFlowRecList() {
		// TODO Auto-generated method stub
		return capFlowRecDao.exportFlowRecList();
	}

	@Override
	public int deleteCFRByUuid(String srUuid) {
		// TODO Auto-generated method stub
		return capFlowRecDao.updateCapFlowStateBySrUuid(CapitalFlowRecord.YSC_STATE,srUuid);
	}

	@Override
	public int canncelShareVip(String srUuid, String content, String fxzOpenId) {
		// TODO Auto-generated method stub
		int count=0;
		count=capFlowRecDao.updateCapFlowStateBySrUuid(CapitalFlowRecord.DQX_STATE,srUuid);
		if(count>0) {
			CardMessage msg=new CardMessage();
			msg.setSrUuid(srUuid);
			msg.setContent(content);
			msg.setFxzOpenId(fxzOpenId);
			msg.setType(CardMessage.QX_CARD);
			count=messageDao.addMessage(msg);
		}
		return count;
	}

	@Override
	public int confirmCanShareVip(String srUuid) {
		// TODO Auto-generated method stub
		return capFlowRecDao.updateCapFlowStateBySrUuid(CapitalFlowRecord.YQX_STATE,srUuid);
	}
}
