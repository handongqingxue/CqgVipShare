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
	public List<Merchant> selectShopCheckList(int page, int rows, String sort, String order) {
		// TODO Auto-generated method stub
		return merchantDao.selectShopCheckList((page-1)*rows, rows, sort, order);
	}

	@Override
	public Merchant getMerchant(Merchant merchant) {
		// TODO Auto-generated method stub
		return merchantDao.getMerchant(merchant);
	}

	@Override
	public Merchant getByOpenId(String openId) {
		// TODO Auto-generated method stub
		return merchantDao.getByOpenId(openId);
	}

	@Override
	public int addMerchant(Merchant merchant) {
		// TODO Auto-generated method stub
		//https://www.cnblogs.com/kiko2014551511/p/11527423.html
		String pinYin=merchantDao.getShopFPY(merchant.getShopName());
		merchant.setShopFPY(pinYin);
		return merchantDao.addMerchant(merchant);
	}

	@Override
	public int editMerchant(Merchant merchant) {
		// TODO Auto-generated method stub
		String pinYin=merchantDao.getShopFPY(merchant.getShopName());
		merchant.setShopFPY(pinYin);
		return merchantDao.editMerchant(merchant);
	}

	@Override
	public int checkShopById(String id) {
		// TODO Auto-generated method stub
		return merchantDao.checkShopById(id);
	}
}
