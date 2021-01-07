package com.cqgVipShare.service.serviceImpl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.cqgVipShare.dao.*;
import com.cqgVipShare.entity.*;
import com.cqgVipShare.service.*;

@Service
public class VipServiceImpl implements VipService {

	@Autowired
	private VipMapper vipDao;

	@Override
	public int checkShopById(String id) {
		// TODO Auto-generated method stub
		return vipDao.checkShopById(id);
	}

	@Override
	public Vip getUserInfoByOpenId(String openId) {
		// TODO Auto-generated method stub
		return vipDao.getUserInfoByOpenId(openId);
	}

	@Override
	public boolean merchantCheck(String openId) {
		// TODO Auto-generated method stub
		
		boolean bool=false;
		Vip user=vipDao.getUserInfoByOpenId(openId);
		if(user.getUserType()==1) {
			bool=false;
		}
		else {
			bool=true;
		}
		return bool;
	}

	@Override
	public int editMerchant(Vip user) {
		// TODO Auto-generated method stub
		String pinYin=vipDao.getShopFPY(user.getShopName());
		user.setShopFPY(pinYin);
		return vipDao.editMerchant(user);
	}

	@Override
	public List<Vip> selectHotShopList(String tradeId) {
		// TODO Auto-generated method stub
		return vipDao.selectHotShopList(tradeId);
	}

	@Override
	public List<Vip> selectMoreShopList(String tradeId) {
		// TODO Auto-generated method stub
		return vipDao.selectMoreShopList(tradeId);
	}

	@Override
	public int updateWithDrawMoneyByOpenId(Float withDrawMoney, String openId) {
		// TODO Auto-generated method stub
		return vipDao.updateWithDrawMoneyByOpenId(withDrawMoney,openId);
	}

	@Override
	public int bindAlipay(Vip user) {
		// TODO Auto-generated method stub
		return vipDao.bindAlipay(user);
	}

	@Override
	public boolean checkUserExist(String openId) {
		// TODO Auto-generated method stub
		
		int count=vipDao.getUserCountByOpenId(openId);
		return count==0?false:true;
	}

	@Override
	public Vip getUserInfoById(String userId) {
		// TODO Auto-generated method stub
		return vipDao.getUserInfoById(userId);
	}

	@Override
	public int addUser(Vip user) {
		// TODO Auto-generated method stub
		return vipDao.addUser(user);
	}
}
