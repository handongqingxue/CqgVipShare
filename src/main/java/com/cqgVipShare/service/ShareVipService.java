package com.cqgVipShare.service;

import java.util.List;
import java.util.Map;

import com.cqgVipShare.entity.CapitalFlowRecord;
import com.cqgVipShare.entity.LeaseRecord;
import com.cqgVipShare.entity.LeaseVip;
import com.cqgVipShare.entity.VipMessage;
import com.cqgVipShare.entity.ShareHistoryRecord;
import com.cqgVipShare.entity.ShareRecord;
import com.cqgVipShare.entity.ShareVip;
import com.cqgVipShare.entity.Trade;
import com.cqgVipShare.entity.Vip;

public interface ShareVipService {

	int addShareVip(ShareVip shareVip);

	List<ShareVip> selectVipList(Integer orderFlag, String order, Integer likeFlag, String tradeId, Integer start, Integer end, Double myLatitude, Double myLongitude);

	Map<String,Object> selectShareInfoById(String id);

	List<Map<String,Object>> selectShareListByFxzOpenId(Integer type, String openId);

	List<ShareVip> selectMyAddShareVipList(Integer type, String openId);

	List<CapitalFlowRecord> selectMyCancelSRList(String openId);

	int confirmConsumeShare(ShareRecord sr);

	boolean compareShopIdWithVipShopId(String openId,Integer vipId);

}
