package com.cqgVipShare.service;

import java.util.List;

import com.cqgVipShare.entity.*;

public interface UserService {

	int selectShopCheckForInt();

	List<User> selectShopCheckList(int page, int rows, String sort, String order);

	int checkShopById(String id);

	User getUserInfoByOpenId(String openId);

	boolean merchantCheck(String openId);
}
