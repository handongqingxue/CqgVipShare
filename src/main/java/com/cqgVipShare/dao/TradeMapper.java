package com.cqgVipShare.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.cqgVipShare.entity.*;

public interface TradeMapper {

	int selectTradeInt(@Param("name")String name);

	List<Trade> selectTradeList(@Param("name")String name, @Param("start")int start, @Param("rows")int rows, String sort, String order);

	int updateCCPercentById(@Param("ccPercent")Float ccPercent, @Param("id")String id);

	List<Trade> selectTrade(@Param("name")String name);

	Float getCcPercentByShrUuid(@Param("uuid")String uuid);

	int add(Trade trade);

	Trade getById(@Param("id")String id);

	int edit(Trade trade);
}
