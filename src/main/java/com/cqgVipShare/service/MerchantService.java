package com.cqgVipShare.service;

import java.util.List;

import com.cqgVipShare.entity.*;

public interface MerchantService {

	int selectShopCheckForInt();

	List<Merchant> selectShopCheckList(int page, int rows, String sort, String order);

	Merchant getMerchant(Merchant merchant);

	Merchant getByOpenId(String openId);

	int addMerchant(Merchant merchant);

	int editMerchant(Merchant merchant);

	int checkShopByOpenId(Integer shopCheck, String resultStr, String content, String openId);
}
