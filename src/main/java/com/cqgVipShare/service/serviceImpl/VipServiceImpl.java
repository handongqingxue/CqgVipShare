package com.cqgVipShare.service.serviceImpl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.cqgVipShare.dao.VipMapper;
import com.cqgVipShare.entity.User;
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
		
		map.put("logo", am.getLogo());
		map.put("shopName", am.getShopName());
		map.put("shopAddress", am.getShopAddress());
		map.put("consumeCount", sv.getConsumeCount());
		map.put("reputation", reputation);
		map.put("describe", sv.getDescribe());
		return map;
	}

	@Override
	public boolean merchantCheck(String unionId) {
		// TODO Auto-generated method stub
		
		boolean bool=false;
		User user=vipDao.getUserInfoByUnionId(unionId);
		if(StringUtils.isEmpty(user.getShopName())||StringUtils.isEmpty(user.getShopAddress())) {
			bool=false;
		}
		else {
			bool=true;
		}
		return bool;
	}

	@Override
	public User getUserInfoByUnionId(String unionId) {
		// TODO Auto-generated method stub
		return vipDao.getUserInfoByUnionId(unionId);
	}

	@Override
	public int editMerchant(User user) {
		// TODO Auto-generated method stub
		return vipDao.editMerchant(user);
	}

}
