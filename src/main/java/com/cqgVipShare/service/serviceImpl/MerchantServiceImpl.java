package com.cqgVipShare.service.serviceImpl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.cqgVipShare.dao.*;
import com.cqgVipShare.entity.*;
import com.cqgVipShare.service.*;

@Service
public class MerchantServiceImpl implements MerchantService {

	@Autowired
	private MerchantMapper merchantDao;
	
	@Override
	public int selectShopCheckForInt() {
		// TODO Auto-generated method stub
		return merchantDao.selectShopCheckForInt();
	}

	@Override
	public List<Vip> selectShopCheckList(int page, int rows, String sort, String order) {
		// TODO Auto-generated method stub
		return merchantDao.selectShopCheckList((page-1)*rows, rows, sort, order);
	}

}
