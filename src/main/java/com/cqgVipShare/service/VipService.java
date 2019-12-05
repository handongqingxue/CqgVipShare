package com.cqgVipShare.service;

import java.util.List;
import java.util.Map;

import com.cqgVipShare.entity.ShareVip;
import com.cqgVipShare.entity.Trade;
import com.cqgVipShare.entity.User;

public interface VipService {

	List<Trade> selectTrade(String name);

	int addShareVip(ShareVip shareVip);

	List<ShareVip> selectVipList(String tradeId);

	Map<String,Object> selectShareInfoById(String id);

	boolean merchantCheck(String unionId);

	User getUserInfoByUnionId(String unionId);

}
