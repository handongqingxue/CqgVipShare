package com.cqgVipShare.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.cqgVipShare.entity.AccountMsg;
import com.cqgVipShare.entity.ShareVip;
import com.cqgVipShare.entity.Trade;

public interface VipMapper {

	List<Trade> selectTrade(@Param("name")String name);

	int addShareVip(ShareVip shareVip);

	List<ShareVip> selectVipList(@Param("tradeId")String tradeId);

	ShareVip selectVipById(@Param("id")String id);

	AccountMsg getShopInfoById(@Param("shopId")Integer shopId);

	Integer getReputationByPhone(@Param("phone")String phone);

}
