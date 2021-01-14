package com.cqgVipShare.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.cqgVipShare.entity.*;


public interface VipMapper {
	//保存注册用户信息
	public int saveUser(Vip msg);

	Vip getByOpenId(@Param("openId")String openId);

	int updateSumShareByOpenId(@Param("shareMoney")Float shareMoney, @Param("openId")String openId);
	
	public int updateWithDrawMoneyByOpenId(@Param("withDrawMoney")Float withDrawMoney, @Param("openId")String openId);
	
	public int bindAlipay(Vip user);

	int getUserCountByOpenId(@Param("openId")String openId);
	
	Vip getUserInfoById(@Param("id")String id);

	int addUser(Vip user);
}
