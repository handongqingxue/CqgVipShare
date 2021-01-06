package com.cqgVipShare.service.serviceImpl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.cqgVipShare.dao.*;
import com.cqgVipShare.entity.*;
import com.cqgVipShare.service.*;

@Service
public class NotifyUrlParamServiceImpl implements NotifyUrlParamService {

	@Autowired
	private NotifyUrlParamMapper notifyUrlParamDao;
	
	@Override
	public int add(NotifyUrlParam notifyUrlParam) {
		// TODO Auto-generated method stub
		return notifyUrlParamDao.add(notifyUrlParam);
	}

	@Override
	public NotifyUrlParam getByOutTradeNo(String outTradeNo) {
		// TODO Auto-generated method stub
		return notifyUrlParamDao.getByOutTradeNo(outTradeNo);
	}

	@Override
	public int deleteByOutTradeNo(String outTradeNo) {
		// TODO Auto-generated method stub
		return notifyUrlParamDao.deleteByOutTradeNo(outTradeNo);
	}

}
