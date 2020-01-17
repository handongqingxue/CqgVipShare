package com.cqgVipShare.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.cqgVipShare.entity.User;
import com.cqgVipShare.entity.CapitalFlowRecord;
import com.cqgVipShare.entity.LeaseRecord;
import com.cqgVipShare.entity.LeaseVip;
import com.cqgVipShare.entity.ShareHistoryRecord;
import com.cqgVipShare.entity.ShareRecord;
import com.cqgVipShare.entity.ShareVip;
import com.cqgVipShare.entity.Trade;

public interface VipMapper {

	List<Trade> selectTrade(@Param("name")String name);

	int addShareVip(ShareVip shareVip);

	List<ShareVip> selectVipList(@Param("orderFlag")Integer orderFlag, @Param("order")String order, @Param("likeFlag")Integer likeFlag, 
			@Param("tradeId")String tradeId, @Param("start")Integer start, @Param("end")Integer end);

	ShareVip selectVipById(@Param("id")String id);

	LeaseVip selectLeaseVipById(@Param("id")String id);

	User getShopInfoById(@Param("shopId")Integer shopId);

	User getUserInfoByOpenId(@Param("openId")String openId);
	
	User getUserInfoById(@Param("id")String id);

	int editMerchant(User user);

	int addShareRecord(ShareRecord sr);

	int updateVipConsumeCountById(@Param("id")Integer vipId);

	ShareRecord getShareRecordByUuid(@Param("uuid")String uuid);

	int addShareHistoryRecord(ShareHistoryRecord shr);

	int deleteShareRecordByUuid(@Param("uuid")String uuid);

	List<ShareRecord> selectAllShareListByFxzOpenId(@Param("fxzOpenId")String fxzOpenId);

	List<ShareRecord> selectDXFShareListByFxzOpenId(@Param("fxzOpenId")String fxzOpenId);

	List<ShareRecord> selectYXFShareListByFxzOpenId(@Param("fxzOpenId")String fxzOpenId);

	List<ShareRecord> selectYQXShareListByFxzOpenId(@Param("fxzOpenId")String fxzOpenId);

	List<LeaseRecord> selectLeaseListByFxzOpenId(@Param("zlzOpenId")String zlzOpenId);

	int getUserCountByOpenId(@Param("openId")String openId);

	int addUser(User user);

	String getShopFPY(@Param("shopName")String shopName);

	List<User> selectHotShopList(@Param("tradeId")String tradeId);

	List<User> selectMoreShopList(@Param("tradeId")String tradeId);

	int addLeaseVip(LeaseVip lv);

	int addLeaseRecord(LeaseRecord lr);

	List<LeaseVip> selectLeaseVipList(@Param("orderFlag")Integer orderFlag, @Param("order")String order, @Param("likeFlag")Integer likeFlag, 
			@Param("tradeId")String tradeId, @Param("start")Integer start, @Param("end")Integer end);

	List<LeaseVip> selectLeaseVipListByOpenId(@Param("openId")String openId);

	Integer getVipConsumeCountById(@Param("id")Integer id);

	int updateVipUsedById(@Param("id")Integer id);

	int addCapitalFlowRecord(CapitalFlowRecord cfr);

	int selectShopCheckForInt();

	List<User> selectShopCheckList(@Param("start")int start, @Param("rows")int rows, String sort, String order);

	int updateCapFlowStateBySrUuid(@Param("stateFlag")Integer stateFlag,@Param("uuid")String uuid);

	int selectCapFlowRecInt();

	List<CapitalFlowRecord> selectCapFlowRecList(@Param("start")int start, @Param("rows")int rows, String sort, String order);

	List<CapitalFlowRecord> exportCapFlowRecList();

	int selectTradeCCInt();

	List<Trade> selectTradeCCList(@Param("start")int start, @Param("rows")int rows, String sort, String order);

	int updateCCPercentById(@Param("ccPercent")Float ccPercent, @Param("id")String id);

	ShareRecord getSRDetailByUuid(@Param("uuid")String uuid);

	LeaseRecord getLRDetailById(@Param("id")String id);

	int checkShopById(@Param("id")String id);

	int deleteLeaseVipByIds(List<String> idList);

	int updateSumShareByOpenId(@Param("shareMoney")Float shareMoney, @Param("openId")String openId);

	List<ShareVip> selectWXFShareListByKzOpenId(@Param("openId")String openId);

	List<ShareVip> selectYXFShareListByKzOpenId(@Param("openId")String openId);

	List<CapitalFlowRecord> selectMyCancelSRList(@Param("openId")String openId);

	List<ShareRecord> selectKzSRListByVipId(@Param("vipId")String vipId, @Param("kzOpenId")String kzOpenId);

	List<ShareHistoryRecord> selectKzSHRListByVipId(@Param("vipId")String vipId, @Param("kzOpenId")String openId);

}
