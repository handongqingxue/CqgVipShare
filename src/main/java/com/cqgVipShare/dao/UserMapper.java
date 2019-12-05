package com.cqgVipShare.dao;

import java.util.List;
import com.cqgVipShare.entity.User;


public interface UserMapper {
	//保存注册用户信息
	public int saveUser(User msg);
	//通过用户信息查询用户
	public User getUser(User msg);
}
