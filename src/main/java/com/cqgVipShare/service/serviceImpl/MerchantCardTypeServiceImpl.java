package com.cqgVipShare.service.serviceImpl;

import java.util.Arrays;
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

	@Override
	public List<MerchantCardType> selectList(Integer shopId, String selectAction) {
		// TODO Auto-generated method stub
		return merchantCardTypeDao.selectList(shopId, selectAction);
	}

	@Override
	public List<MerchantCardType> selectList(Integer shopId) {
		// TODO Auto-generated method stub
		return merchantCardTypeDao.selectList(shopId);
	}

	@Override
	public int add(MerchantCardType mct) {
		// TODO Auto-generated method stub
		int count=0;
		String[] typeArr = mct.getTypes().split(",");
		for (String type : typeArr) {
			mct.setType(Integer.valueOf(type));
			count+=merchantCardTypeDao.add(mct);
		}
		return count;
	}

	@Override
	public int deleteByTypes(String types, Integer shopId) {
		// TODO Auto-generated method stub
		int count=0;
		List<String> typeList = Arrays.asList(types.split(","));
		count=merchantCardTypeDao.deleteByTypes(typeList);
		return count;
	}
}
