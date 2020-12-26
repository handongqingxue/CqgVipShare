package com.cqgVipShare.service;

import java.util.List;
import java.util.Map;

import com.cqgVipShare.entity.CapitalFlowRecord;
import com.cqgVipShare.entity.LeaseRecord;
import com.cqgVipShare.entity.LeaseVip;
import com.cqgVipShare.entity.Message;
import com.cqgVipShare.entity.ShareHistoryRecord;
import com.cqgVipShare.entity.ShareRecord;
import com.cqgVipShare.entity.ShareVip;
import com.cqgVipShare.entity.Trade;
import com.cqgVipShare.entity.User;

public interface ShareVipService {

	int addShareVip(ShareVip shareVip);

	List<ShareVip> selectVipList(Integer orderFlag, String order, Integer likeFlag, String tradeId, Integer start, Integer end, Double myLatitude, Double myLongitude);

	Map<String,Object> selectShareInfoById(String id);

	int editMerchant(User user);

	int addShareRecord(ShareRecord sr);

	User getUserInfoById(String userId);

	int addShareHistoryRecord(ShareHistoryRecord shr);

	int deleteShareRecordByUuid(String uuid);

	List<ShareRecord> selectShareListByFxzOpenId(Integer type, String openId);

	List<LeaseRecord> selectLeaseListByFxzOpenId(String openId);

	boolean checkUserExist(String openId);

	int addUser(User user);

	List<User> selectHotShopList(String tradeId);

	List<User> selectMoreShopList(String tradeId);

	int addLeaseVip(LeaseVip lv);

	int addLeaseRecord(LeaseRecord lr);

	int deleteLeaseVipByIds(String ids);

	int updateSumShareByOpenId(Float shareMoney, String openId);

	List<ShareVip> selectMyAddShareVipList(Integer type, String openId);

	List<CapitalFlowRecord> selectMyCancelSRList(String openId);

	List<ShareRecord> selectKzSRListByVipId(String vipId, String openId);

	List<ShareHistoryRecord> selectKzSHRListByVipId(String vipId, String openId);

	int canncelShareVip(String srUuid, String content, String fxzOpenId);

	int confirmCanShareVip(String srUuid);

	int addComment(Message message);

	int confirmConsumeShare(ShareRecord sr);

	int deleteCFRByUuid(String srUuid);

	boolean compareShopIdWithVipShopId(String openId,Integer vipId);

}
