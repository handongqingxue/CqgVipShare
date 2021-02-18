package com.cqgVipShare.service;

import java.util.List;

import com.cqgVipShare.entity.MerchantCardType;

public interface MerchantCardTypeService {

	int selectForInt(Integer shopId);

	List<MerchantCardType> selectList(Integer shopId, int page, int rows, String sort, String order);

}
