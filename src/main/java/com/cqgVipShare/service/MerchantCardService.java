package com.cqgVipShare.service;

import java.util.List;

import com.cqgVipShare.entity.MerchantCard;

public interface MerchantCardService {

	List<MerchantCard> selectList(String shopId);

}
