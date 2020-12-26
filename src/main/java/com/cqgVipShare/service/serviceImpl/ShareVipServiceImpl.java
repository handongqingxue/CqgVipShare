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
public class ShareVipServiceImpl implements ShareVipService {

	@Autowired
	private UserMapper userDao;
	@Autowired
	private ShareVipMapper shareVipDao;
	@Autowired
	private ShareRecordMapper shareRecordDao;
	@Autowired
	private ShareHistoryRecordMapper shareHistoryRecordDao;
	@Autowired
	private CapFlowRecMapper capFlowRecDao;

	@Override
	public int addShareVip(ShareVip shareVip) {
		// TODO Auto-generated method stub
		return shareVipDao.addShareVip(shareVip);
	}

	@Override
	public List<ShareVip> selectVipList(Integer orderFlag, String order, Integer likeFlag, String tradeId, Integer start, Integer end, Double myLatitude, Double myLongitude) {
		// TODO Auto-generated method stub
		return shareVipDao.selectVipList(orderFlag, order, likeFlag, tradeId, start, end, myLatitude, myLongitude);
	}

	@Override
	public Map<String,Object> selectShareInfoById(String id) {
		// TODO Auto-generated method stub
		
		Map<String, Object> map=new HashMap<String, Object>();
		ShareVip sv = shareVipDao.selectVipById(id);
		
		Integer shopId = sv.getShopId();
		User am=userDao.getShopInfoById(shopId);

		map.put("id", sv.getId());
		map.put("logo", am.getLogo());
		map.put("shopName", am.getShopName());
		map.put("shopAddress", am.getShopAddress());
		map.put("openId", sv.getOpenId());
		map.put("vipName", sv.getName());
		map.put("consumeCount", sv.getConsumeCount());
		map.put("shareMoney", sv.getShareMoney());
		map.put("reputation", am.getReputation());
		map.put("describe", sv.getDescribe());
		return map;
	}

	@Override
	public User getUserInfoById(String userId) {
		// TODO Auto-generated method stub
		return shareVipDao.getUserInfoById(userId);
	}

	@Override
	public List<ShareRecord> selectShareListByFxzOpenId(Integer type, String openId) {
		// TODO Auto-generated method stub
		List<ShareRecord> list = null;
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
			list = new ArrayList<ShareRecord>();
			break;
		}
		return list;
	}

	@Override
	public boolean checkUserExist(String openId) {
		// TODO Auto-generated method stub
		
		int count=shareVipDao.getUserCountByOpenId(openId);
		return count==0?false:true;
	}

	@Override
	public int addUser(User user) {
		// TODO Auto-generated method stub
		return shareVipDao.addUser(user);
	}

	@Override
	public List<ShareVip> selectMyAddShareVipList(Integer type, String openId) {
		// TODO Auto-generated method stub
		List<ShareVip> list = null;
		switch (type) {
		case 1:
			list = shareVipDao.selectWXFShareListByKzOpenId(openId);
			break;
		case 2:
			list = shareVipDao.selectYXFShareListByKzOpenId(openId);
			break;
		}
		return list;
	}

	@Override
	public List<CapitalFlowRecord> selectMyCancelSRList(String openId) {
		// TODO Auto-generated method stub
		return shareVipDao.selectMyCancelSRList(openId);
	}

	@Override
	public int confirmConsumeShare(ShareRecord sr) {
		// TODO Auto-generated method stub
		int count=capFlowRecDao.updateCapFlowStateBySrUuid(CapitalFlowRecord.YXF_STATE,sr.getUuid());
		if(count>0)
			count=userDao.updateSumShareByOpenId(sr.getShareMoney(),sr.getKzOpenId());
		return count;
	}

	@Override
	public boolean compareShopIdWithVipShopId(String openId,Integer vipId) {
		// TODO Auto-generated method stub
		int vipShopId = shareVipDao.selectVipShopIdById(vipId);
		int shopId = userDao.getShopIdByOpenId(openId);
		return vipShopId==shopId?true:false;
	}

}
