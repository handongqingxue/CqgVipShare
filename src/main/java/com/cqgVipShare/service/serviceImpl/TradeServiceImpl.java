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
	public int selectCCInt() {
		// TODO Auto-generated method stub
		return tradeDao.selectCCInt();
	}

	@Override
	public List<Trade> selectCCList(int page, int rows, String sort, String order) {
		// TODO Auto-generated method stub
		return tradeDao.selectCCList((page-1)*rows, rows, sort, order);
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
	public Float getCcPercentByShrUuid(String uuid) {
		// TODO Auto-generated method stub
		return tradeDao.getCcPercentByShrUuid(uuid);
	}
}
