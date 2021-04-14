package com.cqgVipShare.service.serviceImpl;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.cqgVipShare.dao.*;
import com.cqgVipShare.entity.*;
import com.cqgVipShare.service.*;

@Service
public class ShareCardServiceImpl implements ShareCardService {

	@Autowired
	private VipMapper vipDao;
	@Autowired
	private MerchantMapper merchantDao;
	@Autowired
	private ShareCardMapper shareCardDao;
	@Autowired
	private CapFlowRecMapper capFlowRecDao;

	@Override
	public int add(ShareCard shareCard) {
		// TODO Auto-generated method stub
		return shareCardDao.add(shareCard);
	}

	@Override
	public List<ShareCard> selectList(Integer orderFlag, String order, Integer likeFlag, String tradeId, Integer start, Integer end, Double myLatitude, Double myLongitude) {
		// TODO Auto-generated method stub
		/*
		if(myLatitude==null||myLongitude==null) {
			myLatitude=35.95795;
			myLongitude=120.19353;
		}
		*/
		return shareCardDao.selectList(orderFlag, order, likeFlag, tradeId, start, end, myLatitude, myLongitude);
	}

	@Override
	public Map<String,Object> selectById(String id) {
		// TODO Auto-generated method stub
		
		Map<String, Object> map=new HashMap<String, Object>();
		ShareCard sc = shareCardDao.selectById(id);
		
		Integer shopId = sc.getShopId();
		Merchant mer=merchantDao.getById(shopId);
		Vip kz=vipDao.getByOpenId(sc.getOpenId());

		map.put("id", sc.getId());
		map.put("logo", mer.getLogo());
		map.put("shopName", mer.getShopName());
		map.put("shopAddress", mer.getShopAddress());
		map.put("weekday", mer.getWeekday());
		map.put("shopStartTime", mer.getStartTime());
		map.put("shopEndTime", mer.getEndTime());
		map.put("openId", sc.getOpenId());
		map.put("scNo", sc.getNo());
		map.put("scName", sc.getName());
		map.put("scType", sc.getType());
		map.put("consumeCount", sc.getConsumeCount());
		map.put("shareMoney", sc.getShareMoney());
		map.put("discount", sc.getDiscount());
		map.put("minDeposit", sc.getMinDeposit());
		map.put("reputation", kz.getReputation());
		map.put("describe", sc.getDescribe());
		return map;
	}

	@Override
	public List<ShareCard> selectMyAddShareCardList(Integer type, String openId) {
		// TODO Auto-generated method stub
		List<ShareCard> list = null;
		switch (type) {
		case 1:
			list = shareCardDao.selectWXFShareListByKzOpenId(openId);
			break;
		case 2:
			list = shareCardDao.selectYXFShareListByKzOpenId(openId);
			break;
		}
		return list;
	}

	@Override
	public List<CapitalFlowRecord> selectMyCancelSRList(String openId) {
		// TODO Auto-generated method stub
		return shareCardDao.selectMyCancelSRList(openId);
	}

	@Override
	public int confirmConsumeShare(ShareRecord sr) {
		// TODO Auto-generated method stub
		int count=capFlowRecDao.updateCapFlowStateBySrUuid(CapitalFlowRecord.YXF_STATE,sr.getUuid());
		if(count>0)
			count=vipDao.updateSumShareByOpenId(sr.getShareMoney(),sr.getKzOpenId());
		return count;
	}

	@Override
	public boolean compareShopIdWithCardShopId(String openId,Integer scId) {
		// TODO Auto-generated method stub
		int cardShopId = shareCardDao.selectShopIdById(scId);
		int shopId = merchantDao.getShopIdByOpenId(openId);
		return cardShopId==shopId?true:false;
	}

	@Override
	public int updateConsumeMoneyById(Float shareMoney, Integer scId) {
		// TODO Auto-generated method stub
		int count=shareCardDao.updateConsumeMoneyById(shareMoney,scId);//���»�Ա��ʣ�����Ϊ�ǽ����ʹο���ͬ�����Ѻ���ܳ�����������۳����
		Float consumeMoney=shareCardDao.getConsumeMoneyById(scId);//��û�Ա��ʣ����
		if(consumeMoney<=0)
			count=shareCardDao.updateUsedById(scId);//��ʣ�������0���Ͳ���������
		else
			count=shareCardDao.updateEnableById(true, scId);//����������ָ�����״̬Ϊ���á����ǽ����ο����������ѣ����Ƿ�����ȡ���˷������ָܻ�״̬Ϊ����
		return count;
	}

	@Override
	public int updateConsumeCountById(Integer scId) {
		// TODO Auto-generated method stub
		int count=0;
		Integer consumeCount=shareCardDao.getConsumeCountById(scId);//��û�Ա��ʣ�����
		if(consumeCount==0)
			count=shareCardDao.updateUsedById(scId);//��ʣ���������0���Ͳ���������
		return count;
	}

}
