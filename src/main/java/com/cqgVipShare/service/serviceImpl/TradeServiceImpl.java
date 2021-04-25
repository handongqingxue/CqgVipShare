package com.cqgVipShare.service.serviceImpl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.cqgVipShare.dao.*;
import com.cqgVipShare.entity.*;
import com.cqgVipShare.service.*;

@Service
public class TradeServiceImpl implements TradeService {

	@Autowired
	private TradeMapper tradeDao;
	
	@Override
	public int selectTradeInt(String name) {
		// TODO Auto-generated method stub
		return tradeDao.selectTradeInt(name);
	}

	@Override
	public List<Trade> selectTradeList(String name, int page, int rows, String sort, String order) {
		// TODO Auto-generated method stub
		return tradeDao.selectTradeList(name, (page-1)*rows, rows, sort, order);
	}

	@Override
	public int updateCCPercentById(Float ccPercent, String id) {
		// TODO Auto-generated method stub
		return tradeDao.updateCCPercentById(ccPercent,id);
	}
	
	@Override
	public List<Trade> selectTrade(String name) {
		// TODO Auto-generated method stub
		return tradeDao.selectTrade(name);
	}

	@Override
	public Float getCcPercentBySrUuid(String uuid) {
		// TODO Auto-generated method stub
		return tradeDao.getCcPercentBySrUuid(uuid);
	}

	@Override
	public int add(Trade trade) {
		// TODO Auto-generated method stub
		return tradeDao.add(trade);
	}

	@Override
	public Trade getById(String id) {
		// TODO Auto-generated method stub
		return tradeDao.getById(id);
	}

	@Override
	public int edit(Trade trade) {
		// TODO Auto-generated method stub
		return tradeDao.edit(trade);
	}
}
