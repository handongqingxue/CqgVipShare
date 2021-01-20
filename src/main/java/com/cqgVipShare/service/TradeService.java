package com.cqgVipShare.service;

import java.util.List;

import com.cqgVipShare.entity.*;

public interface TradeService {

	int selectCCInt();

	List<Trade> selectCCList(int page, int rows, String sort, String order);

	int updateCCPercentById(Float ccPercent, String id);

	List<Trade> selectTrade(String name);

	Float getCcPercentByShrUuid(String uuid);
}
