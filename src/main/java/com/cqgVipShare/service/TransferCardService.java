package com.cqgVipShare.service;

import java.util.List;
import java.util.Map;

import com.cqgVipShare.entity.*;

public interface TransferCardService {

	Map<String, Object> selectInfoById(String id);

	List<TransferCard> selectTransferCardList(Integer orderFlag, String order, Integer likeFlag, String tradeId, Integer start, Integer end, Double myLatitude, Double myLongitude);

	List<TransferCard> selectTransferCardListByOpenId(String openId);

	List<TransferRecord> selectTransferListByZrzOpenId(String openId);

	int deleteTransferCardByIds(String ids);

	int addTransferCard(TransferCard lv);
}
