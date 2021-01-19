package com.cqgVipShare.service;

import java.util.List;

import com.cqgVipShare.entity.*;

public interface MerchantService {

	int selectCheckForInt();

	List<Merchant> selectCheckList(int page, int rows, String sort, String order);

	Merchant getMerchant(Merchant merchant);

	Merchant getByOpenId(String openId);

	int addMerchant(Merchant merchant);

	int editMerchant(Merchant merchant);

	int checkShopByOpenId(Integer shopCheck, String resultStr, String content, String openId);

	List<Merchant> selectHotShopList(String tradeId);

	List<Merchant> selectMoreShopList(String tradeId);

	boolean checkUserNameExist(String userName);
}
