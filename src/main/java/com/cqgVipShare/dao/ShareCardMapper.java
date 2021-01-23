package com.cqgVipShare.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.cqgVipShare.entity.Vip;
import com.cqgVipShare.entity.CapitalFlowRecord;
import com.cqgVipShare.entity.LeaseRecord;
import com.cqgVipShare.entity.LeaseVip;
import com.cqgVipShare.entity.CardMessage;
import com.cqgVipShare.entity.ShareHistoryRecord;
import com.cqgVipShare.entity.ShareRecord;
import com.cqgVipShare.entity.ShareCard;
import com.cqgVipShare.entity.Trade;

public interface ShareCardMapper {

	int addShareCard(ShareCard shareCard);

	List<ShareCard> selectVipList(@Param("orderFlag")Integer orderFlag, @Param("order")String order, @Param("likeFlag")Integer likeFlag, @Param("tradeId")String tradeId, 
			@Param("start")Integer start, @Param("end")Integer end, @Param("myLatitude")Double myLatitude, @Param("myLongitude")Double myLongitude);

	ShareCard selectVipById(@Param("id")String id);

	int updateVipConsumeCountById(@Param("id")Integer vipId);

	Integer getVipConsumeCountById(@Param("id")Integer id);

	int updateVipUsedById(@Param("id")Integer id);

	List<ShareCard> selectWXFShareListByKzOpenId(@Param("openId")String openId);

	List<ShareCard> selectYXFShareListByKzOpenId(@Param("openId")String openId);

	List<CapitalFlowRecord> selectMyCancelSRList(@Param("openId")String openId);

	int selectVipShopIdById(@Param("id")Integer id);

}
