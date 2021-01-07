package com.cqgVipShare.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.cqgVipShare.entity.*;

public interface MerchantMapper {
	//通过用户信息查询用户
	public Merchant getMerchant(Merchant Merchant);

	int selectShopCheckForInt();

	List<Vip> selectShopCheckList(@Param("start")int start, @Param("rows")int rows, String sort, String order);

}
