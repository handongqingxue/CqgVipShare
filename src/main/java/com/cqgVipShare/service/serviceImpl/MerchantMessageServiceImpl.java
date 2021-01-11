package com.cqgVipShare.service.serviceImpl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.cqgVipShare.dao.*;
import com.cqgVipShare.entity.*;
import com.cqgVipShare.service.*;

@Service
public class MerchantMessageServiceImpl implements MerchantMessageService {

	@Autowired
	private MerchantMessageMapper merchantMessageDao;
	
	@Override
	public List<MerchantMessage> selectList(Integer flag, String openId) {
		// TODO Auto-generated method stub
		return merchantMessageDao.selectList(flag, openId);
	}

}
