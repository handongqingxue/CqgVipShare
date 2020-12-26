package com.cqgVipShare.service;

import java.util.List;

import com.cqgVipShare.entity.*;

public interface TradeService {

	int selectTradeCCInt();

	List<Trade> selectTradeCCList(int page, int rows, String sort, String order);

	int updateCCPercentById(Float ccPercent, String id);

	List<Trade> selectTrade(String name);
}
