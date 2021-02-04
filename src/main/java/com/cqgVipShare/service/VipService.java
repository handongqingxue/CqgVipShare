package com.cqgVipShare.service;

import java.util.List;

import com.cqgVipShare.entity.*;

public interface VipService {

	Vip getByOpenId(String openId);

	int updateWithDrawMoneyByOpenId(Float withDrawMoney, String openId);

	int bindAlipay(Vip vip);

	boolean checkUserExist(String openId);

	Vip getUserInfoById(String userId);

	int addUser(Vip vip);

	int editVipSignTxt(String signTxt, String openId);
}
