package com.cqgVipShare.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.cqgVipShare.entity.*;

public interface TradeMapper {

	int selectTradeCCInt();

	List<Trade> selectTradeCCList(@Param("start")int start, @Param("rows")int rows, String sort, String order);

	int updateCCPercentById(@Param("ccPercent")Float ccPercent, @Param("id")String id);

	List<Trade> selectTrade(@Param("name")String name);
}
