package com.cqgVipShare.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.cqgVipShare.entity.*;


public interface UserMapper {
	//保存注册用户信息
	public int saveUser(User msg);
	//通过用户信息查询用户
	public User getUser(User msg);

	int selectShopCheckForInt();

	List<User> selectShopCheckList(@Param("start")int start, @Param("rows")int rows, String sort, String order);

	int checkShopById(@Param("id")String id);

	User getUserInfoByOpenId(@Param("openId")String openId);

	User getShopInfoById(@Param("shopId")Integer shopId);
	
	int getShopIdByOpenId(@Param("openId")String openId);

	int updateSumShareByOpenId(@Param("shareMoney")Float shareMoney, @Param("openId")String openId);

	String getShopFPY(@Param("shopName")String shopName);

	int editMerchant(User user);

	List<User> selectHotShopList(@Param("tradeId")String tradeId);

	List<User> selectMoreShopList(@Param("tradeId")String tradeId);
	
	public int updateWithDrawMoneyByOpenId(@Param("withDrawMoney")Float withDrawMoney, @Param("openId")String openId);
	
	public int bindAlipay(User user);
}
