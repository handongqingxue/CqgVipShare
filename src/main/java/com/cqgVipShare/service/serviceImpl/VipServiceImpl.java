package com.cqgVipShare.service.serviceImpl;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.cqgVipShare.dao.VipMapper;
import com.cqgVipShare.entity.User;
import com.cqgVipShare.entity.CapitalFlowRecord;
import com.cqgVipShare.entity.LeaseRecord;
import com.cqgVipShare.entity.LeaseVip;
import com.cqgVipShare.entity.Message;
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
	public List<ShareVip> selectVipList(Integer orderFlag, String order, Integer likeFlag, String tradeId, Integer start, Integer end, Double myLatitude, Double myLongitude) {
		// TODO Auto-generated method stub
		return vipDao.selectVipList(orderFlag, order, likeFlag, tradeId, start, end, myLatitude, myLongitude);
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
		map.put("vipName", sv.getName());
		map.put("consumeCount", sv.getConsumeCount());
		map.put("shareMoney", sv.getShareMoney());
		map.put("reputation", am.getReputation());
		map.put("describe", sv.getDescribe());
		return map;
	}

	@Override
	public Map<String, Object> selectLeaseInfoById(String id) {
		// TODO Auto-generated method stub

		Map<String, Object> map=new HashMap<String, Object>();
		LeaseVip lv = vipDao.selectLeaseVipById(id);
		
		Integer shopId = lv.getShopId();
		User am=vipDao.getShopInfoById(shopId);

		map.put("id", lv.getId());
		map.put("logo", am.getLogo());
		map.put("shopName", am.getShopName());
		map.put("shopAddress", am.getShopAddress());
		map.put("openId", lv.getOpenId());
		map.put("consumeCount", lv.getConsumeCount());
		map.put("shareMoney", lv.getShareMoney());
		map.put("reputation", am.getReputation());
		map.put("describe", lv.getDescribe());
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
			count=vipDao.updateVipConsumeCountById(vipId);//更新会员卡剩余次数
		Integer consumeCount=vipDao.getVipConsumeCountById(vipId);//获得会员卡剩余次数
		if(consumeCount==0)
			count=vipDao.updateVipUsedById(vipId);//若剩余次数减到0，就不能再用了
		
    	CapitalFlowRecord cfr=new CapitalFlowRecord();
    	cfr.setSrUuid(sr.getUuid());
    	cfr.setVipId(sr.getVipId());
    	cfr.setKzOpenId(sr.getKzOpenId());
    	cfr.setFxzOpenId(sr.getFxzOpenId());
    	cfr.setShareMoney(sr.getShareMoney());

    	count=vipDao.addCapitalFlowRecord(cfr);//添加资金流水记录
    	
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
		return count;
	}

	@Override
	public List<ShareRecord> selectShareListByFxzOpenId(Integer type, String openId) {
		// TODO Auto-generated method stub
		List<ShareRecord> list = null;
		switch (type) {
		case CapitalFlowRecord.ALL_TAB:
			list = vipDao.selectAllShareListByFxzOpenId(openId);
			break;
		case CapitalFlowRecord.DXF_TAB:
			list = vipDao.selectDXFShareListByFxzOpenId(openId);
			break;
		case CapitalFlowRecord.YXF_TAB:
			list = vipDao.selectYXFShareListByFxzOpenId(openId);
			break;
		case CapitalFlowRecord.YQX_TAB:
			list = vipDao.selectYQXShareListByFxzOpenId(openId);
			break;
		default:
			list = new ArrayList<ShareRecord>();
			break;
		}
		return list;
	}

	@Override
	public List<Message> selectCommentListByOpenId(String openId) {
		// TODO Auto-generated method stub
		return vipDao.selectCommentListByOpenId(openId);
	}

	@Override
	public List<LeaseRecord> selectLeaseListByFxzOpenId(String openId) {
		// TODO Auto-generated method stub
		return vipDao.selectLeaseListByFxzOpenId(openId);
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
	public List<User> selectHotShopList(String tradeId) {
		// TODO Auto-generated method stub
		return vipDao.selectHotShopList(tradeId);
	}

	@Override
	public List<User> selectMoreShopList(String tradeId) {
		// TODO Auto-generated method stub
		return vipDao.selectMoreShopList(tradeId);
	}

	@Override
	public int addLeaseVip(LeaseVip lv) {
		// TODO Auto-generated method stub
		return vipDao.addLeaseVip(lv);
	}

	@Override
	public int addLeaseRecord(LeaseRecord lr) {
		// TODO Auto-generated method stub
		return vipDao.addLeaseRecord(lr);
	}

	@Override
	public List<LeaseVip> selectLeaseVipList(Integer orderFlag, String order, Integer likeFlag, String tradeId, Integer start, Integer end, Double myLatitude, Double myLongitude) {
		// TODO Auto-generated method stub
		return vipDao.selectLeaseVipList(orderFlag,order,likeFlag,tradeId,start,end, myLatitude, myLongitude);
	}

	@Override
	public List<LeaseVip> selectLeaseVipListByOpenId(String openId) {
		// TODO Auto-generated method stub
		return vipDao.selectLeaseVipListByOpenId(openId);
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

	@Override
	public LeaseRecord getLRDetailById(String id) {
		// TODO Auto-generated method stub
		return vipDao.getLRDetailById(id);
	}

	@Override
	public int checkShopById(String id) {
		// TODO Auto-generated method stub
		return vipDao.checkShopById(id);
	}

	@Override
	public int deleteLeaseVipByIds(String ids) {
		// TODO Auto-generated method stub
		List<String> idList = Arrays.asList(ids.split(","));
		return vipDao.deleteLeaseVipByIds(idList);
	}

	@Override
	public int updateSumShareByOpenId(Float shareMoney, String openId) {
		// TODO Auto-generated method stub
		return vipDao.updateSumShareByOpenId(shareMoney,openId);
	}

	@Override
	public List<ShareVip> selectMyAddShareVipList(Integer type, String openId) {
		// TODO Auto-generated method stub
		List<ShareVip> list = null;
		switch (type) {
		case 1:
			list = vipDao.selectWXFShareListByKzOpenId(openId);
			break;
		case 2:
			list = vipDao.selectYXFShareListByKzOpenId(openId);
			break;
		}
		return list;
	}

	@Override
	public List<CapitalFlowRecord> selectMyCancelSRList(String openId) {
		// TODO Auto-generated method stub
		return vipDao.selectMyCancelSRList(openId);
	}

	@Override
	public List<ShareRecord> selectKzSRListByVipId(String vipId, String openId) {
		// TODO Auto-generated method stub
		return vipDao.selectKzSRListByVipId(vipId,openId);
	}

	@Override
	public List<ShareHistoryRecord> selectKzSHRListByVipId(String vipId, String openId) {
		// TODO Auto-generated method stub
		return vipDao.selectKzSHRListByVipId(vipId,openId);
	}

	@Override
	public int canncelShareVip(String srUuid, String content, String fxzOpenId) {
		// TODO Auto-generated method stub
		int count=0;
		count=vipDao.updateCapFlowStateBySrUuid(CapitalFlowRecord.DQX_STATE,srUuid);
		if(count>0) {
			Message msg=new Message();
			msg.setSrUuid(srUuid);
			msg.setContent(content);
			msg.setFxzOpenId(fxzOpenId);
			msg.setType(Message.QX_VIP);
			count=vipDao.addMessage(msg);
		}
		return count;
	}

	@Override
	public int confirmCanShareVip(String srUuid) {
		// TODO Auto-generated method stub
		return vipDao.updateCapFlowStateBySrUuid(CapitalFlowRecord.YQX_STATE,srUuid);
	}

	@Override
	public int addComment(Message msg) {
		// TODO Auto-generated method stub
		int count=0;
		msg.setType(Message.PL_VIP);
		count=vipDao.addMessage(msg);
		if(count>0) {
			count=vipDao.updateCapFlowStateBySrUuid(CapitalFlowRecord.YPL_STATE,msg.getSrUuid());
		}
		return count;
	}

	@Override
	public int confirmConsumeShare(ShareRecord sr) {
		// TODO Auto-generated method stub
		int count=vipDao.updateCapFlowStateBySrUuid(CapitalFlowRecord.YXF_STATE,sr.getUuid());
		if(count>0)
			count=vipDao.updateSumShareByOpenId(sr.getShareMoney(),sr.getKzOpenId());
		return count;
	}

	@Override
	public int deleteCFRByUuid(String srUuid) {
		// TODO Auto-generated method stub
		return vipDao.updateCapFlowStateBySrUuid(CapitalFlowRecord.YSC_STATE,srUuid);
	}

}
