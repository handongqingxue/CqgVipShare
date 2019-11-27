package com.cqgVipShare.service;

import java.util.List;

import com.cqgVipShare.entity.Trade;

public interface VipService {

	List<Trade> selectTrade(String name);

}
