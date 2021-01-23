package com.cqgVipShare.service.serviceImpl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.cqgVipShare.dao.*;
import com.cqgVipShare.entity.*;
import com.cqgVipShare.service.*;

@Service
public class MerchantCardServiceImpl implements MerchantCardService {

	@Autowired
	private MerchantCardMapper merchantCardDao;
	
	@Override
	public List<MerchantCard> selectList(String shopId) {
		// TODO Auto-generated method stub
		return merchantCardDao.selectList(shopId);
	}

}
