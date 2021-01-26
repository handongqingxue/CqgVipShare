package com.cqgVipShare.service.serviceImpl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.cqgVipShare.dao.*;
import com.cqgVipShare.entity.*;
import com.cqgVipShare.service.*;

@Service
public class MerchantCardServiceImpl implements MerchantCardService {

	@Autowired
	private MerchantMapper merchantDao;
	@Autowired
	private MerchantCardMapper merchantCardDao;
	
	@Override
	public List<MerchantCard> selectList(Integer orderFlag, String order, Integer likeFlag, String shopId, Integer start, Integer end, Double myLatitude, Double myLongitude) {
		// TODO Auto-generated method stub
		return merchantCardDao.selectList(orderFlag, order, likeFlag, shopId, start, end, myLatitude, myLongitude);
	}

	@Override
	public Map<String, Object> selectById(String id) {
		// TODO Auto-generated method stub

		Map<String, Object> map=new HashMap<String, Object>();
		MerchantCard mv = merchantCardDao.selectById(id);
		
		Integer shopId = mv.getShopId();
		Merchant mer=merchantDao.getById(shopId);

		map.put("id", mv.getId());
		map.put("logo", mer.getLogo());
		map.put("shopName", mer.getShopName());
		map.put("shopAddress", mer.getShopAddress());
		map.put("mvName", mv.getName());
		map.put("consumeCount", mv.getConsumeCount());
		map.put("money", mv.getMoney());
		map.put("describe", mv.getDescribe());
		return map;
	}

	@Override
	public boolean compareShopIdWithCardShopId(String shopOpenId, Integer mcId) {
		// TODO Auto-generated method stub
		int cardShopId = merchantCardDao.selectShopIdById(mcId);
		int shopId = merchantDao.getShopIdByOpenId(shopOpenId);
		return cardShopId==shopId?true:false;
	}

}
