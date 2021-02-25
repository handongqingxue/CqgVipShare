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
	public int add(ShareCard shareCard) {
		// TODO Auto-generated method stub
		return shareCardDao.add(shareCard);
	}

	@Override
	public List<ShareCard> selectList(Integer orderFlag, String order, Integer likeFlag, String tradeId, Integer start, Integer end, Double myLatitude, Double myLongitude) {
		// TODO Auto-generated method stub
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
		map.put("openId", sc.getOpenId());
		map.put("scNo", sc.getNo());
		map.put("scName", sc.getName());
		map.put("scType", sc.getType());
		map.put("consumeCount", sc.getConsumeCount());
		map.put("shareMoney", sc.getShareMoney());
		map.put("discount", sc.getDiscount());
		map.put("reputation", kz.getReputation());
		map.put("describe", sc.getDescribe());
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
	public boolean compareShopIdWithCardShopId(String openId,Integer scId) {
		// TODO Auto-generated method stub
		int cardShopId = shareCardDao.selectShopIdById(scId);
		int shopId = merchantDao.getShopIdByOpenId(openId);
		return cardShopId==shopId?true:false;
	}

	@Override
	public int updateConsumeMoneyById(Float shareMoney, Integer scId) {
		// TODO Auto-generated method stub
		int count=shareCardDao.updateConsumeMoneyById(shareMoney,scId);//更新会员卡剩余金额，因为是金额卡，和次卡不同，消费后才能出金额，才在这里扣除金额
		Float consumeMoney=shareCardDao.getConsumeMoneyById(scId);//获得会员卡剩余金额
		if(consumeMoney<=0)
			count=shareCardDao.updateUsedById(scId);//若剩余金额减到0，就不能再用了
		else
			count=shareCardDao.updateEnableById(true, scId);//若还有余额，则恢复卡的状态为可用。这是金额卡，次卡按次数消费，除非分享者取消了分享，才能恢复状态为可用
		return count;
	}

	@Override
	public int updateConsumeCountById(Integer scId) {
		// TODO Auto-generated method stub
		int count=0;
		Integer consumeCount=shareCardDao.getConsumeCountById(scId);//获得会员卡剩余次数
		if(consumeCount==0)
			count=shareCardDao.updateUsedById(scId);//若剩余次数减到0，就不能再用了
		return count;
	}

}
