package com.cqgVipShare.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.cqgVipShare.entity.User;
import com.cqgVipShare.entity.CapitalFlowRecord;
import com.cqgVipShare.entity.LeaseRecord;
import com.cqgVipShare.entity.LeaseVip;
import com.cqgVipShare.entity.Message;
import com.cqgVipShare.entity.ShareHistoryRecord;
import com.cqgVipShare.entity.ShareRecord;
import com.cqgVipShare.entity.ShareVip;
import com.cqgVipShare.entity.Trade;

public interface ShareVipMapper {

	List<Trade> selectTrade(@Param("name")String name);

	int addShareVip(ShareVip shareVip);

	List<ShareVip> selectVipList(@Param("orderFlag")Integer orderFlag, @Param("order")String order, @Param("likeFlag")Integer likeFlag, @Param("tradeId")String tradeId, 
			@Param("start")Integer start, @Param("end")Integer end, @Param("myLatitude")Double myLatitude, @Param("myLongitude")Double myLongitude);

	ShareVip selectVipById(@Param("id")String id);
	
	User getUserInfoById(@Param("id")String id);

	int editMerchant(User user);

	int addShareRecord(ShareRecord sr);

	int updateVipConsumeCountById(@Param("id")Integer vipId);

	int addShareHistoryRecord(ShareHistoryRecord shr);

	int addMessage(Message msg);

	int deleteShareRecordByUuid(@Param("uuid")String uuid);

	List<ShareRecord> selectAllShareListByFxzOpenId(@Param("fxzOpenId")String fxzOpenId);

	List<ShareRecord> selectDXFShareListByFxzOpenId(@Param("fxzOpenId")String fxzOpenId);

	List<ShareRecord> selectYXFShareListByFxzOpenId(@Param("fxzOpenId")String fxzOpenId);

	List<ShareRecord> selectYQXShareListByFxzOpenId(@Param("fxzOpenId")String fxzOpenId);

	List<Message> selectCommentListByOpenId(@Param("fxzOpenId")String openId);

	List<LeaseRecord> selectLeaseListByFxzOpenId(@Param("zlzOpenId")String zlzOpenId);

	int getUserCountByOpenId(@Param("openId")String openId);

	int addUser(User user);

	String getShopFPY(@Param("shopName")String shopName);

	List<User> selectHotShopList(@Param("tradeId")String tradeId);

	List<User> selectMoreShopList(@Param("tradeId")String tradeId);

	int addLeaseVip(LeaseVip lv);

	int addLeaseRecord(LeaseRecord lr);

	List<LeaseVip> selectLeaseVipList(@Param("orderFlag")Integer orderFlag, @Param("order")String order, @Param("likeFlag")Integer likeFlag, @Param("tradeId")String tradeId, 
			@Param("start")Integer start, @Param("end")Integer end, @Param("myLatitude")Double myLatitude, @Param("myLongitude")Double myLongitude);

	List<LeaseVip> selectLeaseVipListByOpenId(@Param("openId")String openId);

	Integer getVipConsumeCountById(@Param("id")Integer id);

	int updateVipUsedById(@Param("id")Integer id);

	int addCapitalFlowRecord(CapitalFlowRecord cfr);

	int updateCapFlowStateBySrUuid(@Param("stateFlag")Integer stateFlag,@Param("uuid")String uuid);

	ShareRecord getSRDetailByUuid(@Param("uuid")String uuid);

	LeaseRecord getLRDetailById(@Param("id")String id);

	int deleteLeaseVipByIds(List<String> idList);

	int updateSumShareByOpenId(@Param("shareMoney")Float shareMoney, @Param("openId")String openId);

	List<ShareVip> selectWXFShareListByKzOpenId(@Param("openId")String openId);

	List<ShareVip> selectYXFShareListByKzOpenId(@Param("openId")String openId);

	List<CapitalFlowRecord> selectMyCancelSRList(@Param("openId")String openId);

	List<ShareRecord> selectKzSRListByVipId(@Param("vipId")String vipId, @Param("kzOpenId")String kzOpenId);

	List<ShareHistoryRecord> selectKzSHRListByVipId(@Param("vipId")String vipId, @Param("kzOpenId")String openId);

	int selectVipShopIdById(@Param("id")Integer id);

}