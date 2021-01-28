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
public class TransferCardServiceImpl implements TransferCardService {

	@Autowired
	private VipMapper vipDao;
	@Autowired
	private MerchantMapper merchantDao;
	@Autowired
	private TransferCardMapper transferCardDao;

	@Override
	public Map<String, Object> selectInfoById(String id) {
		// TODO Auto-generated method stub

		Map<String, Object> map=new HashMap<String, Object>();
		TransferCard lv = transferCardDao.selectById(id);
		
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
	public List<TransferCard> selectTransferCardList(Integer orderFlag, String order, Integer likeFlag, String tradeId, Integer start, Integer end, Double myLatitude, Double myLongitude) {
		// TODO Auto-generated method stub
		return transferCardDao.selectTransferCardList(orderFlag,order,likeFlag,tradeId,start,end, myLatitude, myLongitude);
	}

	@Override
	public List<TransferCard> selectTransferCardListByOpenId(String openId) {
		// TODO Auto-generated method stub
		return transferCardDao.selectTransferCardListByOpenId(openId);
	}

	@Override
	public List<TransferRecord> selectTransferListByZrzOpenId(String openId) {
		// TODO Auto-generated method stub
		return transferCardDao.selectTransferListByZrzOpenId(openId);
	}

	@Override
	public int deleteTransferCardByIds(String ids) {
		// TODO Auto-generated method stub
		List<String> idList = Arrays.asList(ids.split(","));
		return transferCardDao.deleteTransferCardByIds(idList);
	}

	@Override
	public int addTransferCard(TransferCard tc) {
		// TODO Auto-generated method stub
		return transferCardDao.addTransferCard(tc);
	}
}
