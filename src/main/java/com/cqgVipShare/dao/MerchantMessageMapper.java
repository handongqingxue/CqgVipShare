package com.cqgVipShare.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.cqgVipShare.entity.*;

public interface MerchantMessageMapper {

	int add(MerchantMessage mm);

	List<MerchantMessage> selectList(@Param("flag")Integer flag, @Param("openId")String openId);

}
