package com.cqgVipShare.service.serviceImpl;

import java.util.Arrays;
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

	@Override
	public int readByIds(String ids) {
		// TODO Auto-generated method stub
		List<String> idList = Arrays.asList(ids);
		return merchantMessageDao.readByIds(idList);
	}

	@Override
	public MerchantMessage getById(String id) {
		// TODO Auto-generated method stub
		return merchantMessageDao.getById(id);
	}

}
