package com.cqgVipShare.service;

import java.util.List;
import java.util.Map;

import com.cqgVipShare.entity.CapitalFlowRecord;
import com.cqgVipShare.entity.TransferRecord;
import com.cqgVipShare.entity.TransferCard;
import com.cqgVipShare.entity.CardMessage;
import com.cqgVipShare.entity.ShareHistoryRecord;
import com.cqgVipShare.entity.ShareRecord;
import com.cqgVipShare.entity.ShareCard;
import com.cqgVipShare.entity.Trade;
import com.cqgVipShare.entity.Vip;

public interface ShareCardService {

	int add(ShareCard shareCard);

	List<ShareCard> selectList(Integer orderFlag, String order, Integer likeFlag, String tradeId, Integer start, Integer end, Double myLatitude, Double myLongitude);

	Map<String,Object> selectById(String id);

	List<ShareCard> selectMyAddShareCardList(Integer type, String openId);

	List<CapitalFlowRecord> selectMyCancelSRList(String openId);

	int confirmConsumeShare(ShareRecord sr);

	boolean compareShopIdWithCardShopId(String openId,Integer scId);

	int updateConsumeMoneyById(Float shareMoney, Integer scId);

	int updateConsumeCountById(Integer scId);

}
