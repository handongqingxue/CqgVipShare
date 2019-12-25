package com.cqgVipShare.service;

import java.util.List;
import java.util.Map;

import com.cqgVipShare.entity.CapitalFlowRecord;
import com.cqgVipShare.entity.LeaseRelation;
import com.cqgVipShare.entity.ShareHistoryRecord;
import com.cqgVipShare.entity.ShareRecord;
import com.cqgVipShare.entity.ShareVip;
import com.cqgVipShare.entity.Trade;
import com.cqgVipShare.entity.User;

public interface VipService {

	List<Trade> selectTrade(String name);

	int addShareVip(ShareVip shareVip);

	List<ShareVip> selectVipList(String tradeId);

	Map<String,Object> selectShareInfoById(String id);

	boolean merchantCheck(String openId);

	User getUserInfoByOpenId(String openId);

	int editMerchant(User user);

	int addShareRecord(ShareRecord sr);

	User getUserInfoById(String userId);

	ShareRecord getShareRecordByUuid(String uuid);

	int addShareHistoryRecord(ShareHistoryRecord shr);

	int deleteShareRecordByUuid(String uuid);

	List<ShareRecord> selectShareListByFxzOpenId(String openId);

	boolean checkUserExist(String openId);

	int addUser(User user);

	List<User> selectHotShopList(String tradeId);

	List<User> selectMoreShopList(String tradeId);

	int addLeaseRelation(LeaseRelation lr);

	List<LeaseRelation> selectLeaseList();

	List<User> selectShopCheckList(int page, int rows, String sort, String order);

	int selectShopCheckForInt();

	int selectCapFlowRecInt();

	List<CapitalFlowRecord> selectCapFlowRecList(int page, int rows, String sort, String order);

	List<CapitalFlowRecord> exportCapFlowRecList();

	int selectTradeCCInt();

	List<Trade> selectTradeCCList(int page, int rows, String sort, String order);

	int updateCCPercentById(Float ccPercent, String id);

	ShareRecord getSRDetailByUuid(String uuid);

}
