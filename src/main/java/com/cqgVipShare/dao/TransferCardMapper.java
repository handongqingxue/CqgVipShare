package com.cqgVipShare.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.cqgVipShare.entity.*;

public interface TransferCardMapper {

	TransferCard selectTransferCardById(@Param("id")String id);

	List<TransferCard> selectTransferCardList(@Param("orderFlag")Integer orderFlag, @Param("order")String order, @Param("likeFlag")Integer likeFlag, @Param("tradeId")String tradeId, 
			@Param("start")Integer start, @Param("end")Integer end, @Param("myLatitude")Double myLatitude, @Param("myLongitude")Double myLongitude);

	List<TransferCard> selectTransferCardListByOpenId(@Param("openId")String openId);

	List<LeaseRecord> selectLeaseListByFxzOpenId(@Param("zrzOpenId")String zrzOpenId);

	int deleteTransferCardByIds(List<String> idList);

	int addTransferCard(TransferCard lv);
}
