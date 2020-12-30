package com.cqgVipShare.service;

import java.util.List;

import com.cqgVipShare.entity.*;

public interface UserService {

	int selectShopCheckForInt();

	List<User> selectShopCheckList(int page, int rows, String sort, String order);

	int checkShopById(String id);

	User getUserInfoByOpenId(String openId);

	boolean merchantCheck(String openId);

	int editMerchant(User user);

	List<User> selectHotShopList(String tradeId);

	List<User> selectMoreShopList(String tradeId);

	int updateWithDrawMoneyByOpenId(Float withDrawMoney, String openId);

	int bindAlipay(User user);
}
