package com.cqgVipShare.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.cqgVipShare.entity.*;

public interface MerchantMessageMapper {

	int add(MerchantMessage mm);

	List<MerchantMessage> selectList(@Param("flag")Integer flag, @Param("openId")String openId);

	int readByIds(List<String> idList);

	MerchantMessage getById(@Param("id")String id);

	int deleteByIds(List<String> idList);

	int selectForInt(@Param("title")String title, @Param("isRead")String isRead, @Param("openId")String openId);

	List<MerchantMessage> selectBgList(@Param("title")String title, @Param("isRead")String isRead, @Param("openId")String openId, @Param("start")int start, @Param("rows")int rows, String sort, String order);

}
