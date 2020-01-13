package com.cqgVipShare.service;

import java.util.List;
import java.util.Map;

import com.cqgVipShare.entity.CapitalFlowRecord;
import com.cqgVipShare.entity.LeaseRecord;
import com.cqgVipShare.entity.LeaseVip;
import com.cqgVipShare.entity.ShareHistoryRecord;
import com.cqgVipShare.entity.ShareRecord;
import com.cqgVipShare.entity.ShareVip;
import com.cqgVipShare.entity.Trade;
import com.cqgVipShare.entity.User;

public interface VipService {

	List<Trade> selectTrade(String name);

	int addShareVip(ShareVip shareVip);

	List<ShareVip> selectVipList(Integer orderFlag, String order, Integer likeFlag, String tradeId, Integer start, Integer end);

	Map<String,Object> selectShareInfoById(String id);

	Map<String, Object> selectLeaseInfoById(String id);

	boolean merchantCheck(String openId);

	User getUserInfoByOpenId(String openId);

	int editMerchant(User user);

	int addShareRecord(ShareRecord sr);

	User getUserInfoById(String userId);

	ShareRecord getShareRecordByUuid(String uuid);

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

	List<LeaseVip> selectLeaseVipList();

	List<LeaseVip> selectLeaseVipListByOpenId(String openId);

	List<User> selectShopCheckList(int page, int rows, String sort, String order);

	int selectShopCheckForInt();

	int selectCapFlowRecInt();

	List<CapitalFlowRecord> selectCapFlowRecList(int page, int rows, String sort, String order);

	List<CapitalFlowRecord> exportCapFlowRecList();

	int selectTradeCCInt();

	List<Trade> selectTradeCCList(int page, int rows, String sort, String order);

	int updateCCPercentById(Float ccPercent, String id);

	ShareRecord getSRDetailByUuid(String uuid);

	LeaseRecord getLRDetailById(String id);

	int checkShopById(String id);

	int deleteLeaseVipByIds(String ids);

	int updateSumShareByOpenId(Float shareMoney, String openId);

	List<ShareVip> selectMyAddShareVipList(Integer type, String openId);

	List<CapitalFlowRecord> selectMyCancelSRList(String openId);

	List<ShareRecord> selectKzSRListByVipId(String vipId, String openId);

	List<ShareHistoryRecord> selectKzSHRListByVipId(String vipId, String openId);

}
