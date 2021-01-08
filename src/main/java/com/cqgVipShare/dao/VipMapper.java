package com.cqgVipShare.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.cqgVipShare.entity.*;


public interface VipMapper {
	//保存注册用户信息
	public int saveUser(Vip msg);

	int checkShopById(@Param("id")String id);

	Vip getUserInfoByOpenId(@Param("openId")String openId);

	Vip getShopInfoById(@Param("shopId")Integer shopId);
	
	int getShopIdByOpenId(@Param("openId")String openId);

	int updateSumShareByOpenId(@Param("shareMoney")Float shareMoney, @Param("openId")String openId);

	List<Vip> selectHotShopList(@Param("tradeId")String tradeId);

	List<Vip> selectMoreShopList(@Param("tradeId")String tradeId);
	
	public int updateWithDrawMoneyByOpenId(@Param("withDrawMoney")Float withDrawMoney, @Param("openId")String openId);
	
	public int bindAlipay(Vip user);

	int getUserCountByOpenId(@Param("openId")String openId);
	
	Vip getUserInfoById(@Param("id")String id);

	int addUser(Vip user);
}
