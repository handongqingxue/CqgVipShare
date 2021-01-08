package com.cqgVipShare.service;

import java.util.List;

import com.cqgVipShare.entity.*;

public interface VipService {

	int checkShopById(String id);

	Vip getUserInfoByOpenId(String openId);

	boolean merchantCheck(String openId);

	List<Vip> selectHotShopList(String tradeId);

	List<Vip> selectMoreShopList(String tradeId);

	int updateWithDrawMoneyByOpenId(Float withDrawMoney, String openId);

	int bindAlipay(Vip vip);

	boolean checkUserExist(String openId);

	Vip getUserInfoById(String userId);

	int addUser(Vip vip);
}
