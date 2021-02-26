package com.cqgVipShare.service.serviceImpl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.cqgVipShare.dao.*;
import com.cqgVipShare.entity.*;
import com.cqgVipShare.service.*;

@Service
public class PageValueServiceImpl implements PageValueService {

	@Autowired
	private PageValueMapper pageValueDao;
	
	@Override
	public boolean checkExistByOpenId(String openId) {
		// TODO Auto-generated method stub
		int count=pageValueDao.getCountByOpenId(openId);
		return count>0?true:false;
	}

	@Override
	public int updateByOpenId(PageValue pv) {
		// TODO Auto-generated method stub
		return pageValueDao.updateByOpenId(pv);
	}

	@Override
	public int add(PageValue pv) {
		// TODO Auto-generated method stub
		return pageValueDao.add(pv);
	}

	@Override
	public PageValue selectByOpenId(String openId) {
		// TODO Auto-generated method stub
		return pageValueDao.selectByOpenId(openId);
	}

}
