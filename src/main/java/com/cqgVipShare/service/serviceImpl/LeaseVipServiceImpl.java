package com.cqgVipShare.service.serviceImpl;

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
public class LeaseVipServiceImpl implements LeaseVipService {

	@Autowired
	private VipMapper vipDao;
	@Autowired
	private MerchantMapper merchantDao;
	@Autowired
	private LeaseVipMapper leaseVipDao;

	@Override
	public Map<String, Object> selectLeaseInfoById(String id) {
		// TODO Auto-generated method stub

		Map<String, Object> map=new HashMap<String, Object>();
		LeaseVip lv = leaseVipDao.selectLeaseVipById(id);
		
		Integer shopId = lv.getShopId();
		Merchant mer=merchantDao.getById(shopId);
		Vip kz=vipDao.getByOpenId(lv.getOpenId());

		map.put("id", lv.getId());
		map.put("logo", mer.getLogo());
		map.put("shopName", mer.getShopName());
		map.put("shopAddress", mer.getShopAddress());
		map.put("openId", lv.getOpenId());
		map.put("consumeCount", lv.getConsumeCount());
		map.put("shareMoney", lv.getShareMoney());
		map.put("reputation", kz.getReputation());
		map.put("describe", lv.getDescribe());
		return map;
	}

	@Override
	public List<LeaseVip> selectLeaseVipList(Integer orderFlag, String order, Integer likeFlag, String tradeId, Integer start, Integer end, Double myLatitude, Double myLongitude) {
		// TODO Auto-generated method stub
		return leaseVipDao.selectLeaseVipList(orderFlag,order,likeFlag,tradeId,start,end, myLatitude, myLongitude);
	}

	@Override
	public List<LeaseVip> selectLeaseVipListByOpenId(String openId) {
		// TODO Auto-generated method stub
		return leaseVipDao.selectLeaseVipListByOpenId(openId);
	}

	@Override
	public List<LeaseRecord> selectLeaseListByFxzOpenId(String openId) {
		// TODO Auto-generated method stub
		return leaseVipDao.selectLeaseListByFxzOpenId(openId);
	}

	@Override
	public int deleteLeaseVipByIds(String ids) {
		// TODO Auto-generated method stub
		List<String> idList = Arrays.asList(ids.split(","));
		return leaseVipDao.deleteLeaseVipByIds(idList);
	}

	@Override
	public int addLeaseVip(LeaseVip lv) {
		// TODO Auto-generated method stub
		return leaseVipDao.addLeaseVip(lv);
	}
}
