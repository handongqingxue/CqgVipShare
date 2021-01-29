package com.cqgVipShare.service;

import java.util.List;

import com.cqgVipShare.entity.*;

public interface TradeService {

	int selectTradeInt(String name);

	List<Trade> selectTradeList(String name, int page, int rows, String sort, String order);

	int updateCCPercentById(Float ccPercent, String id);

	List<Trade> selectTrade(String name);

	Float getCcPercentByShrUuid(String uuid);

	int add(Trade trade);

	Trade getById(String id);

	int edit(Trade trade);
}
