package com.cqgVipShare.service.serviceImpl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.cqgVipShare.dao.*;
import com.cqgVipShare.entity.MerchantCardType;
import com.cqgVipShare.service.*;

@Service
public class MerchantCardTypeServiceImpl implements MerchantCardTypeService {

	@Autowired
	private MerchantCardTypeMapper merchantCardTypeDao;

	@Override
	public int selectForInt(Integer shopId) {
		// TODO Auto-generated method stub
		return merchantCardTypeDao.selectForInt(shopId);
	}

	@Override
	public List<MerchantCardType> selectList(Integer shopId, int page, int rows, String sort, String order) {
		// TODO Auto-generated method stub
		return merchantCardTypeDao.selectList(shopId, (page-1)*rows, rows, sort, order);
	}
}
