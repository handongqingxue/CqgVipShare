package com.cqgVipShare.service.serviceImpl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.cqgVipShare.dao.VipMapper;
import com.cqgVipShare.entity.User;
import com.cqgVipShare.entity.ShareHistoryRecord;
import com.cqgVipShare.entity.ShareRecord;
import com.cqgVipShare.entity.ShareVip;
import com.cqgVipShare.entity.Trade;
import com.cqgVipShare.service.VipService;

@Service
public class VipServiceImpl implements VipService {

	@Autowired
	private VipMapper vipDao;
	
	@Override
	public List<Trade> selectTrade(String name) {
		// TODO Auto-generated method stub
		return vipDao.selectTrade(name);
	}

	@Override
	public int addShareVip(ShareVip shareVip) {
		// TODO Auto-generated method stub
		return vipDao.addShareVip(shareVip);
	}

	@Override
	public List<ShareVip> selectVipList(String tradeId) {
		// TODO Auto-generated method stub
		return vipDao.selectVipList(tradeId);
	}

	@Override
	public Map<String,Object> selectShareInfoById(String id) {
		// TODO Auto-generated method stub
		
		Map<String, Object> map=new HashMap<String, Object>();
		ShareVip sv = vipDao.selectVipById(id);
		
		Integer shopId = sv.getShopId();
		User am=vipDao.getShopInfoById(shopId);
		Integer reputation=vipDao.getReputationByPhone(sv.getPhone());

		map.put("id", sv.getId());
		map.put("logo", am.getLogo());
		map.put("shopName", am.getShopName());
		map.put("shopAddress", am.getShopAddress());
		map.put("consumeCount", sv.getConsumeCount());
		map.put("reputation", reputation);
		map.put("describe", sv.getDescribe());
		return map;
	}

	@Override
	public boolean merchantCheck(String openId) {
		// TODO Auto-generated method stub
		
		boolean bool=false;
		User user=vipDao.getUserInfoByOpenId(openId);
		if(StringUtils.isEmpty(user.getShopName())||StringUtils.isEmpty(user.getShopAddress())) {
			bool=false;
		}
		else {
			bool=true;
		}
		return bool;
	}

	@Override
	public User getUserInfoByOpenId(String openId) {
		// TODO Auto-generated method stub
		return vipDao.getUserInfoByOpenId(openId);
	}

	@Override
	public int editMerchant(User user) {
		// TODO Auto-generated method stub
		return vipDao.editMerchant(user);
	}

	@Override
	public int addShareRecord(ShareRecord sr) {
		// TODO Auto-generated method stub
		int count=vipDao.addShareRecord(sr);
		if(count>0)
			count=vipDao.updateVipConsumeCountById(sr.getVipId());
		return count;
	}

	@Override
	public User getUserInfoById(String userId) {
		// TODO Auto-generated method stub
		return vipDao.getUserInfoById(userId);
	}

	@Override
	public ShareRecord getShareRecordByUuid(String uuid) {
		// TODO Auto-generated method stub
		return vipDao.getShareRecordByUuid(uuid);
	}

	@Override
	public int addShareHistoryRecord(ShareHistoryRecord shr) {
		// TODO Auto-generated method stub
		return vipDao.addShareHistoryRecord(shr);
	}

	@Override
	public int deleteShareRecordByUuid(String uuid) {
		// TODO Auto-generated method stub
		return vipDao.deleteShareRecordByUuid(uuid);
	}

	@Override
	public List<ShareRecord> selectShareListByUserId(String userId) {
		// TODO Auto-generated method stub
		return vipDao.selectShareListByUserId(userId);
	}

}
