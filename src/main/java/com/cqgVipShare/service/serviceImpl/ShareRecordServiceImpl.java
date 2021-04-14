package com.cqgVipShare.service.serviceImpl;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

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
	private ShareHistoryRecordMapper shareHistoryRecordDao;
	@Autowired
	private ShareCardMapper shareCardDao;
	@Autowired
	private MerchantMapper merchantDao;
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
	public List<Map<String,Object>> selectShareListByFxzOpenId(Integer type, String openId) {
		// TODO Auto-generated method stub
		List<Map<String,Object>> list = null;
		switch (type) {
		case CapitalFlowRecord.ALL_TAB:
			list = shareRecordDao.selectAllShareListByFxzOpenId(openId);
			break;
		case CapitalFlowRecord.DXF_TAB:
			list = shareRecordDao.selectDXFShareListByFxzOpenId(openId);
			break;
		case CapitalFlowRecord.YXF_TAB:
			list = shareHistoryRecordDao.selectYXFShareListByFxzOpenId(openId);
			break;
		case CapitalFlowRecord.YQX_TAB:
			list = shareRecordDao.selectYQXShareListByFxzOpenId(openId);
			break;
		default:
			list = new ArrayList<Map<String,Object>>();
			break;
		}
		return list;
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
		
		if(sr.getScType()==5) {
			if(count>0)
				count=shareCardDao.updateConsumeCountById(false,scId);//更新会员卡剩余次数
			Integer consumeCount=shareCardDao.getConsumeCountById(scId);//获得会员卡剩余次数
			if(consumeCount==0)
				count=shareCardDao.updateEnableById(false,scId);//若剩余次数减到0，就暂时设置为不可用（若分享者取消分享，再变回可用）
		}
		else {
			count=shareCardDao.updateEnableById(false,scId);//金额卡之类的卡只要有人下载分享了，就暂时设置为不可用（若分享者取消分享或者到店消费完里面还有余额，再变回可用）
		}
		
		merchantDao.updateShareCountById(true,sr.getShopId());
		
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
