package com.cqgVipShare.dao;

import org.apache.ibatis.annotations.Param;

import com.cqgVipShare.entity.PageValue;

public interface PageValueMapper {

	int getCountByOpenId(@Param("openId")String openId);

	int updateByOpenId(PageValue pv);

	int add(PageValue pv);

	PageValue selectByOpenId(@Param("openId")String openId);

}
