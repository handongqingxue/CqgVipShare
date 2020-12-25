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
	
	@Override
	public List<Trade> selectTrade(String name) {
		// TODO Auto-generated method stub
		return shareVipDao.selectTrade(name);
	}

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
	public int editMerchant(User user) {
		// TODO Auto-generated method stub
		String pinYin=shareVipDao.getShopFPY(user.getShopName());
		user.setShopFPY(pinYin);
		return shareVipDao.editMerchant(user);
	}

	@Override
	public int addShareRecord(ShareRecord sr) {
		// TODO Auto-generated method stub
		int count=shareVipDao.addShareRecord(sr);
		Integer vipId = sr.getVipId();
		if(count>0)
			count=shareVipDao.updateVipConsumeCountById(vipId);//更新会员卡剩余次数
		Integer consumeCount=shareVipDao.getVipConsumeCountById(vipId);//获得会员卡剩余次数
		if(consumeCount==0)
			count=shareVipDao.updateVipUsedById(vipId);//若剩余次数减到0，就不能再用了
		
    	CapitalFlowRecord cfr=new CapitalFlowRecord();
    	cfr.setSrUuid(sr.getUuid());
    	cfr.setVipId(sr.getVipId());
    	cfr.setKzOpenId(sr.getKzOpenId());
    	cfr.setFxzOpenId(sr.getFxzOpenId());
    	cfr.setShareMoney(sr.getShareMoney());

    	count=shareVipDao.addCapitalFlowRecord(cfr);//添加资金流水记录
    	
		return count;
	}

	@Override
	public User getUserInfoById(String userId) {
		// TODO Auto-generated method stub
		return shareVipDao.getUserInfoById(userId);
	}

	@Override
	public int addShareHistoryRecord(ShareHistoryRecord shr) {
		// TODO Auto-generated method stub
		return shareVipDao.addShareHistoryRecord(shr);
	}

	@Override
	public int deleteShareRecordByUuid(String uuid) {
		// TODO Auto-generated method stub
		int count=shareVipDao.deleteShareRecordByUuid(uuid);
		return count;
	}

	@Override
	public List<ShareRecord> selectShareListByFxzOpenId(Integer type, String openId) {
		// TODO Auto-generated method stub
		List<ShareRecord> list = null;
		switch (type) {
		case CapitalFlowRecord.ALL_TAB:
			list = shareVipDao.selectAllShareListByFxzOpenId(openId);
			break;
		case CapitalFlowRecord.DXF_TAB:
			list = shareVipDao.selectDXFShareListByFxzOpenId(openId);
			break;
		case CapitalFlowRecord.YXF_TAB:
			list = shareVipDao.selectYXFShareListByFxzOpenId(openId);
			break;
		case CapitalFlowRecord.YQX_TAB:
			list = shareVipDao.selectYQXShareListByFxzOpenId(openId);
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
		return shareVipDao.selectCommentListByOpenId(openId);
	}

	@Override
	public List<LeaseRecord> selectLeaseListByFxzOpenId(String openId) {
		// TODO Auto-generated method stub
		return shareVipDao.selectLeaseListByFxzOpenId(openId);
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
	public List<User> selectHotShopList(String tradeId) {
		// TODO Auto-generated method stub
		return shareVipDao.selectHotShopList(tradeId);
	}

	@Override
	public List<User> selectMoreShopList(String tradeId) {
		// TODO Auto-generated method stub
		return shareVipDao.selectMoreShopList(tradeId);
	}

	@Override
	public int addLeaseVip(LeaseVip lv) {
		// TODO Auto-generated method stub
		return shareVipDao.addLeaseVip(lv);
	}

	@Override
	public int addLeaseRecord(LeaseRecord lr) {
		// TODO Auto-generated method stub
		return shareVipDao.addLeaseRecord(lr);
	}

	@Override
	public List<LeaseVip> selectLeaseVipList(Integer orderFlag, String order, Integer likeFlag, String tradeId, Integer start, Integer end, Double myLatitude, Double myLongitude) {
		// TODO Auto-generated method stub
		return shareVipDao.selectLeaseVipList(orderFlag,order,likeFlag,tradeId,start,end, myLatitude, myLongitude);
	}

	@Override
	public List<LeaseVip> selectLeaseVipListByOpenId(String openId) {
		// TODO Auto-generated method stub
		return shareVipDao.selectLeaseVipListByOpenId(openId);
	}

	@Override
	public ShareRecord getSRDetailByUuid(String uuid) {
		// TODO Auto-generated method stub
		return shareVipDao.getSRDetailByUuid(uuid);
	}

	@Override
	public LeaseRecord getLRDetailById(String id) {
		// TODO Auto-generated method stub
		return shareVipDao.getLRDetailById(id);
	}

	@Override
	public int deleteLeaseVipByIds(String ids) {
		// TODO Auto-generated method stub
		List<String> idList = Arrays.asList(ids.split(","));
		return shareVipDao.deleteLeaseVipByIds(idList);
	}

	@Override
	public int updateSumShareByOpenId(Float shareMoney, String openId) {
		// TODO Auto-generated method stub
		return shareVipDao.updateSumShareByOpenId(shareMoney,openId);
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
	public List<ShareRecord> selectKzSRListByVipId(String vipId, String openId) {
		// TODO Auto-generated method stub
		return shareVipDao.selectKzSRListByVipId(vipId,openId);
	}

	@Override
	public List<ShareHistoryRecord> selectKzSHRListByVipId(String vipId, String openId) {
		// TODO Auto-generated method stub
		return shareVipDao.selectKzSHRListByVipId(vipId,openId);
	}

	@Override
	public int canncelShareVip(String srUuid, String content, String fxzOpenId) {
		// TODO Auto-generated method stub
		int count=0;
		count=shareVipDao.updateCapFlowStateBySrUuid(CapitalFlowRecord.DQX_STATE,srUuid);
		if(count>0) {
			Message msg=new Message();
			msg.setSrUuid(srUuid);
			msg.setContent(content);
			msg.setFxzOpenId(fxzOpenId);
			msg.setType(Message.QX_VIP);
			count=shareVipDao.addMessage(msg);
		}
		return count;
	}

	@Override
	public int confirmCanShareVip(String srUuid) {
		// TODO Auto-generated method stub
		return shareVipDao.updateCapFlowStateBySrUuid(CapitalFlowRecord.YQX_STATE,srUuid);
	}

	@Override
	public int addComment(Message msg) {
		// TODO Auto-generated method stub
		int count=0;
		msg.setType(Message.PL_VIP);
		count=shareVipDao.addMessage(msg);
		if(count>0) {
			count=shareVipDao.updateCapFlowStateBySrUuid(CapitalFlowRecord.YPL_STATE,msg.getSrUuid());
		}
		return count;
	}

	@Override
	public int confirmConsumeShare(ShareRecord sr) {
		// TODO Auto-generated method stub
		int count=shareVipDao.updateCapFlowStateBySrUuid(CapitalFlowRecord.YXF_STATE,sr.getUuid());
		if(count>0)
			count=shareVipDao.updateSumShareByOpenId(sr.getShareMoney(),sr.getKzOpenId());
		return count;
	}

	@Override
	public int deleteCFRByUuid(String srUuid) {
		// TODO Auto-generated method stub
		return shareVipDao.updateCapFlowStateBySrUuid(CapitalFlowRecord.YSC_STATE,srUuid);
	}

	@Override
	public boolean compareShopIdWithVipShopId(String openId,Integer vipId) {
		// TODO Auto-generated method stub
		int vipShopId = shareVipDao.selectVipShopIdById(vipId);
		int shopId = userDao.getShopIdByOpenId(openId);
		return vipShopId==shopId?true:false;
	}

}
