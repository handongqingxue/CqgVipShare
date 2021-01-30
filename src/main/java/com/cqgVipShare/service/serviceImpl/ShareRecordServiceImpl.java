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
	private ShareCardMapper shareCardDao;
	@Autowired
	private CapFlowRecMapper capFlowRecDao;

	@Override
	public ShareRecord getByUuid(String uuid) {
		// TODO Auto-generated method stub
		return shareRecordDao.getByUuid(uuid);
	}

	@Override
	public ShareRecord getSRDetailByUuid(String uuid) {
		// TODO Auto-generated method stub
		return shareRecordDao.getSRDetailByUuid(uuid);
	}

	@Override
	public List<ShareRecord> selectKzSRListByScId(String scId, String openId) {
		// TODO Auto-generated method stub
		return shareRecordDao.selectKzSRListByScId(scId,openId);
	}

	@Override
	public int deleteByUuid(String uuid) {
		// TODO Auto-generated method stub
		int count=shareRecordDao.deleteByUuid(uuid);
		return count;
	}

	@Override
	public int add(ShareRecord sr) {
		// TODO Auto-generated method stub
		int count=shareRecordDao.add(sr);
		Integer scId = sr.getScId();
		
		if(sr.getScType()==2) {
			if(count>0)
				count=shareCardDao.updateConsumeCountById(scId);//更新会员卡剩余次数
			Integer consumeCount=shareCardDao.getConsumeCountById(scId);//获得会员卡剩余次数
			if(consumeCount==0)
				count=shareCardDao.updateUsedById(scId);//若剩余次数减到0，就不能再用了
		}
		
    	CapitalFlowRecord cfr=new CapitalFlowRecord();
    	cfr.setSrUuid(sr.getUuid());
    	cfr.setScId(sr.getScId());
    	cfr.setKzOpenId(sr.getKzOpenId());
    	cfr.setFxzOpenId(sr.getFxzOpenId());
    	cfr.setShareMoney(sr.getShareMoney());

    	count=capFlowRecDao.addCapitalFlowRecord(cfr);//添加资金流水记录
    	
		return count;
	}

	@Override
	public int confirmConsumeMoney(Float shareMoney, String uuid) {
		// TODO Auto-generated method stub
		int count=shareRecordDao.updateShareMoneyByUuid(shareMoney,uuid);
		if(count>0)
			count=capFlowRecDao.updateShareMoneyBySrUuid(shareMoney,uuid);
		return count;
	}
}
