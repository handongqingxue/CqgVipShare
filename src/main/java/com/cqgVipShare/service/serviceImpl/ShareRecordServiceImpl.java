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
				count=shareCardDao.updateConsumeCountById(scId);//���»�Ա��ʣ�����
			Integer consumeCount=shareCardDao.getConsumeCountById(scId);//��û�Ա��ʣ�����
			if(consumeCount==0)
				count=shareCardDao.updateUsedById(scId);//��ʣ���������0���Ͳ���������
		}
		
    	CapitalFlowRecord cfr=new CapitalFlowRecord();
    	cfr.setSrUuid(sr.getUuid());
    	cfr.setScId(sr.getScId());
    	cfr.setKzOpenId(sr.getKzOpenId());
    	cfr.setFxzOpenId(sr.getFxzOpenId());
    	cfr.setShareMoney(sr.getShareMoney());

    	count=capFlowRecDao.addCapitalFlowRecord(cfr);//����ʽ���ˮ��¼
    	
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
