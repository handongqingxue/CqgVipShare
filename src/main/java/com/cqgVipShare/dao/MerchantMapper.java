package com.cqgVipShare.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.cqgVipShare.entity.*;

public interface MerchantMapper {
	//通过用户信息查询用户
	public Merchant getMerchant(Merchant Merchant);

	int selectShopCheckForInt();

	List<Merchant> selectShopCheckList(@Param("start")int start, @Param("rows")int rows, String sort, String order);
	
	Merchant getByOpenId(@Param("openId")String openId);

	String getShopFPY(@Param("shopName")String shopName);

	int addMerchant(Merchant merchant);

	int editMerchant(Merchant Merchant);

	int updateShopCheckById(@Param("shopCheck")Integer shopCheck, @Param("id")String id);

}
