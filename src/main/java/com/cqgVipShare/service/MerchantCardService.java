package com.cqgVipShare.service;

import java.util.List;
import java.util.Map;

import com.cqgVipShare.entity.MerchantCard;

public interface MerchantCardService {

	List<MerchantCard> selectList(Integer orderFlag, String order, Integer likeFlag, String shopId, Integer start, Integer end, Double myLatitude, Double myLongitude);

	Map<String, Object> selectById(String id);

}
