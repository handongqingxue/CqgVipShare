package com.cqgVipShare.dao;

import java.util.List;
import com.cqgVipShare.entity.AccountMsg;


public interface UserMapper {
	//保存注册用户信息
	public int saveUser(AccountMsg msg);
	//通过用户信息查询用户
	public AccountMsg getUser(AccountMsg msg);
}
