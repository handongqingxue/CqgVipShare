package com.cqgVipShare.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.cqgVipShare.entity.MerchantCardType;

public interface MerchantCardTypeMapper {

	int selectForInt(@Param("shopId")Integer shopId);

	List<MerchantCardType> selectList(@Param("shopId")Integer shopId, @Param("start")int start, @Param("rows")int rows, String sort, String order);

	List<MerchantCardType> selectList(@Param("shopId")Integer shopId);

	int add(MerchantCardType mct);

	int deleteByTypes(List<String> typeList);

}
