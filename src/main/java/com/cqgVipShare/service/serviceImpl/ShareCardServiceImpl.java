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
	private ShareRecordMapper shareRecordDao;
	@Autowired
	private ShareHistoryRecordMapper shareHistoryRecordDao;
	@Autowired
	private CapFlowRecMapper capFlowRecDao;

	@Override
	public int addShareCard(ShareCard shareCard) {
		// TODO Auto-generated method stub
		return shareCardDao.addShareCard(shareCard);
	}

	@Override
	public List<ShareCard> selectVipList(Integer orderFlag, String order, Integer likeFlag, String tradeId, Integer start, Integer end, Double myLatitude, Double myLongitude) {
		// TODO Auto-generated method stub
		return shareCardDao.selectVipList(orderFlag, order, likeFlag, tradeId, start, end, myLatitude, myLongitude);
	}

	@Override
	public Map<String,Object> selectById(String id) {
		// TODO Auto-generated method stub
		
		Map<String, Object> map=new HashMap<String, Object>();
		ShareCard sv = shareCardDao.selectVipById(id);
		
		Integer shopId = sv.getShopId();
		Merchant mer=merchantDao.getById(shopId);
		Vip kz=vipDao.getByOpenId(sv.getOpenId());

		map.put("id", sv.getId());
		map.put("logo", mer.getLogo());
		map.put("shopName", mer.getShopName());
		map.put("shopAddress", mer.getShopAddress());
		map.put("openId", sv.getOpenId());
		map.put("svNo", sv.getNo());
		map.put("svName", sv.getName());
		map.put("consumeCount", sv.getConsumeCount());
		map.put("shareMoney", sv.getShareMoney());
		map.put("reputation", kz.getReputation());
		map.put("describe", sv.getDescribe());
		return map;
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
	public boolean compareShopIdWithVipShopId(String openId,Integer vipId) {
		// TODO Auto-generated method stub
		int vipShopId = shareCardDao.selectVipShopIdById(vipId);
		int shopId = merchantDao.getShopIdByOpenId(openId);
		return vipShopId==shopId?true:false;
	}

}
