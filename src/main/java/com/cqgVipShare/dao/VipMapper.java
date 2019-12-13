package com.cqgVipShare.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.cqgVipShare.entity.User;
import com.cqgVipShare.entity.ShareHistoryRecord;
import com.cqgVipShare.entity.ShareRecord;
import com.cqgVipShare.entity.ShareVip;
import com.cqgVipShare.entity.Trade;

public interface VipMapper {

	List<Trade> selectTrade(@Param("name")String name);

	int addShareVip(ShareVip shareVip);

	List<ShareVip> selectVipList(@Param("tradeId")String tradeId);

	ShareVip selectVipById(@Param("id")String id);

	User getShopInfoById(@Param("shopId")Integer shopId);

	Integer getReputationByPhone(@Param("phone")String phone);

	User getUserInfoByOpenId(@Param("openId")String openId);
	
	User getUserInfoById(@Param("id")String id);

	int editMerchant(User user);

	int addShareRecord(ShareRecord sr);

	int updateVipConsumeCountById(@Param("id")Integer vipId);

	ShareRecord getShareRecordByUuid(@Param("uuid")String uuid);

	int addShareHistoryRecord(ShareHistoryRecord shr);

	int deleteShareRecordByUuid(@Param("uuid")String uuid);

	List<ShareRecord> selectShareListByUserId(@Param("userId")String userId);

	int getUserCountByOpenId(@Param("openId")String openId);

	int addUser(User user);

}
