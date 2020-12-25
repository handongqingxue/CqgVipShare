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
}
