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
	private VipMessageMapper messageDao;
	
	@Override
	public int selectCapFlowRecInt() {
		// TODO Auto-generated method stub
		return capFlowRecDao.selectCapFlowRecInt();
	}

	@Override
	public List<CapitalFlowRecord> selectCapFlowRecList(int page, int rows, String sort, String order) {
		// TODO Auto-generated method stub
		return capFlowRecDao.selectCapFlowRecList((page-1)*rows, rows, sort, order);
	}

	@Override
	public List<CapitalFlowRecord> exportCapFlowRecList() {
		// TODO Auto-generated method stub
		return capFlowRecDao.exportCapFlowRecList();
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
			VipMessage msg=new VipMessage();
			msg.setSrUuid(srUuid);
			msg.setContent(content);
			msg.setFxzOpenId(fxzOpenId);
			msg.setType(VipMessage.QX_VIP);
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
