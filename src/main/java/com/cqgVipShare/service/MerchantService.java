package com.cqgVipShare.service;

import java.util.List;

import com.cqgVipShare.entity.*;

public interface MerchantService {

	int selectShopCheckForInt();

	List<Vip> selectShopCheckList(int page, int rows, String sort, String order);

	Merchant getMerchant(Merchant merchant);

	Merchant getByOpenId(String openId);

}
