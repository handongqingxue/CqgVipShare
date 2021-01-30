package com.cqgVipShare.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.cqgVipShare.entity.*;

public interface MerchantMapper {
	//通过用户信息查询用户
	public Merchant getMerchant(Merchant Merchant);

	int selectCheckForInt();

	List<Merchant> selectCheckList(@Param("start")int start, @Param("rows")int rows, String sort, String order);

	public int selectForInt();

	public List<Merchant> selectList(@Param("start")int start, @Param("rows")int rows, String sort, String order);
	
	Merchant getByOpenId(@Param("openId")String openId);

	String getShopFPY(@Param("shopName")String shopName);

	int addMerchant(Merchant merchant);

	int editMerchant(Merchant Merchant);

	int updateShopCheckByOpenId(@Param("shopCheck")Integer shopCheck, @Param("openId")String openId);

	List<Merchant> selectHotShopList(@Param("tradeId")String tradeId);

	List<Merchant> selectMoreShopList(@Param("tradeId")String tradeId);

	Merchant getById(@Param("id")Integer id);
	
	int getShopIdByOpenId(@Param("openId")String openId);

	public int checkUserNameExist(@Param("userName")String userName);

}
