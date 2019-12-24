package com.cqgVipShare.service.serviceImpl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.cqgVipShare.dao.VipMapper;
import com.cqgVipShare.entity.User;
import com.cqgVipShare.entity.CapitalFlowRecord;
import com.cqgVipShare.entity.LeaseRelation;
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

		map.put("id", sv.getId());
		map.put("logo", am.getLogo());
		map.put("shopName", am.getShopName());
		map.put("shopAddress", am.getShopAddress());
		map.put("openId", sv.getOpenId());
		map.put("consumeCount", sv.getConsumeCount());
		map.put("shareMoney", sv.getShareMoney());
		map.put("reputation", am.getReputation());
		map.put("describe", sv.getDescribe());
		return map;
	}

	@Override
	public boolean merchantCheck(String openId) {
		// TODO Auto-generated method stub
		
		boolean bool=false;
		User user=vipDao.getUserInfoByOpenId(openId);
		if(user.getUserType()==1) {
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
		String pinYin=vipDao.getShopFPY(user.getShopName());
		user.setShopFPY(pinYin);
		return vipDao.editMerchant(user);
	}

	@Override
	public int addShareRecord(ShareRecord sr) {
		// TODO Auto-generated method stub
		int count=vipDao.addShareRecord(sr);
		Integer vipId = sr.getVipId();
		if(count>0)
			count=vipDao.updateVipConsumeCountById(vipId);
		Integer consumeCount=vipDao.getVipConsumeCountById(vipId);
		if(consumeCount==0)
			count=vipDao.updateVipUsedById(vipId);
		
    	CapitalFlowRecord cfr=new CapitalFlowRecord();
    	cfr.setSrUuid(sr.getUuid());
    	cfr.setVipId(sr.getVipId());
    	cfr.setKzOpenId(sr.getKzOpenId());
    	cfr.setFxzOpenId(sr.getFxzOpenId());
    	cfr.setShareMoney(sr.getShareMoney());

    	count=vipDao.addCapitalFlowRecord(cfr);
    	
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
		int count=vipDao.deleteShareRecordByUuid(uuid);
		count=vipDao.updateCapFlowStateBySrUuid(uuid);
		return count;
	}

	@Override
	public List<ShareRecord> selectShareListByFxzOpenId(String openId) {
		// TODO Auto-generated method stub
		return vipDao.selectShareListByFxzOpenId(openId);
	}

	@Override
	public boolean checkUserExist(String openId) {
		// TODO Auto-generated method stub
		
		int count=vipDao.getUserCountByOpenId(openId);
		return count==0?false:true;
	}

	@Override
	public int addUser(User user) {
		// TODO Auto-generated method stub
		return vipDao.addUser(user);
	}

	@Override
	public List<User> selectHotShopList() {
		// TODO Auto-generated method stub
		return vipDao.selectHotShopList();
	}

	@Override
	public List<User> selectMoreShopList() {
		// TODO Auto-generated method stub
		return vipDao.selectMoreShopList();
	}

	@Override
	public int addLeaseRelation(LeaseRelation lr) {
		// TODO Auto-generated method stub
		return vipDao.addLeaseRelation(lr);
	}

	@Override
	public List<LeaseRelation> selectLeaseList() {
		// TODO Auto-generated method stub
		return vipDao.selectLeaseList();
	}

	@Override
	public List<User> selectShopCheckList(int page, int rows, String sort, String order) {
		// TODO Auto-generated method stub
		return vipDao.selectShopCheckList((page-1)*rows, rows, sort, order);
	}

	@Override
	public int selectShopCheckForInt() {
		// TODO Auto-generated method stub
		return vipDao.selectShopCheckForInt();
	}

	@Override
	public int selectCapFlowRecInt() {
		// TODO Auto-generated method stub
		return vipDao.selectCapFlowRecInt();
	}

	@Override
	public List<CapitalFlowRecord> selectCapFlowRecList(int page, int rows, String sort, String order) {
		// TODO Auto-generated method stub
		return vipDao.selectCapFlowRecList((page-1)*rows, rows, sort, order);
	}

	@Override
	public List<CapitalFlowRecord> exportCapFlowRecList() {
		// TODO Auto-generated method stub
		return vipDao.exportCapFlowRecList();
	}

	@Override
	public int selectTradeCCInt() {
		// TODO Auto-generated method stub
		return vipDao.selectTradeCCInt();
	}

	@Override
	public List<Trade> selectTradeCCList(int page, int rows, String sort, String order) {
		// TODO Auto-generated method stub
		return vipDao.selectTradeCCList((page-1)*rows, rows, sort, order);
	}

	@Override
	public int updateCCPercentById(Float ccPercent, String id) {
		// TODO Auto-generated method stub
		return vipDao.updateCCPercentById(ccPercent,id);
	}

	@Override
	public ShareRecord getSRDetailByUuid(String uuid) {
		// TODO Auto-generated method stub
		return vipDao.getSRDetailByUuid(uuid);
	}

}
