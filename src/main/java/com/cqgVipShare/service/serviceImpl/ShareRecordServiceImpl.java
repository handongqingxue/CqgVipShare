package com.cqgVipShare.service.serviceImpl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.cqgVipShare.dao.*;
import com.cqgVipShare.entity.*;
import com.cqgVipShare.service.*;

@Service
public class ShareRecordServiceImpl implements ShareRecordService {

	@Autowired
	private ShareRecordMapper shareRecordDao;
	@Autowired
	private ShareCardMapper shareVipDao;
	@Autowired
	private CapFlowRecMapper capFlowRecDao;

	@Override
	public ShareRecord getShareRecordByUuid(String uuid) {
		// TODO Auto-generated method stub
		return shareRecordDao.getShareRecordByUuid(uuid);
	}

	@Override
	public ShareRecord getSRDetailByUuid(String uuid) {
		// TODO Auto-generated method stub
		return shareRecordDao.getSRDetailByUuid(uuid);
	}

	@Override
	public List<ShareRecord> selectKzSRListByVipId(String vipId, String openId) {
		// TODO Auto-generated method stub
		return shareRecordDao.selectKzSRListByVipId(vipId,openId);
	}

	@Override
	public int deleteShareRecordByUuid(String uuid) {
		// TODO Auto-generated method stub
		int count=shareRecordDao.deleteShareRecordByUuid(uuid);
		return count;
	}

	@Override
	public int addShareRecord(ShareRecord sr) {
		// TODO Auto-generated method stub
		int count=shareRecordDao.addShareRecord(sr);
		Integer vipId = sr.getVipId();
		if(count>0)
			count=shareVipDao.updateVipConsumeCountById(vipId);//更新会员卡剩余次数
		Integer consumeCount=shareVipDao.getVipConsumeCountById(vipId);//获得会员卡剩余次数
		if(consumeCount==0)
			count=shareVipDao.updateVipUsedById(vipId);//若剩余次数减到0，就不能再用了
		
    	CapitalFlowRecord cfr=new CapitalFlowRecord();
    	cfr.setSrUuid(sr.getUuid());
    	cfr.setVipId(sr.getVipId());
    	cfr.setKzOpenId(sr.getKzOpenId());
    	cfr.setFxzOpenId(sr.getFxzOpenId());
    	cfr.setShareMoney(sr.getShareMoney());

    	count=capFlowRecDao.addCapitalFlowRecord(cfr);//添加资金流水记录
    	
		return count;
	}
}
