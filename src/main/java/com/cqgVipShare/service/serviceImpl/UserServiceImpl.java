package com.cqgVipShare.service.serviceImpl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.cqgVipShare.dao.*;
import com.cqgVipShare.entity.*;
import com.cqgVipShare.service.*;

@Service
public class UserServiceImpl implements UserService {

	@Autowired
	private UserMapper userDao;
	
	@Override
	public int selectShopCheckForInt() {
		// TODO Auto-generated method stub
		return userDao.selectShopCheckForInt();
	}

	@Override
	public List<User> selectShopCheckList(int page, int rows, String sort, String order) {
		// TODO Auto-generated method stub
		return userDao.selectShopCheckList((page-1)*rows, rows, sort, order);
	}

	@Override
	public int checkShopById(String id) {
		// TODO Auto-generated method stub
		return userDao.checkShopById(id);
	}

	@Override
	public User getUserInfoByOpenId(String openId) {
		// TODO Auto-generated method stub
		return userDao.getUserInfoByOpenId(openId);
	}

	@Override
	public boolean merchantCheck(String openId) {
		// TODO Auto-generated method stub
		
		boolean bool=false;
		User user=userDao.getUserInfoByOpenId(openId);
		if(user.getUserType()==1) {
			bool=false;
		}
		else {
			bool=true;
		}
		return bool;
	}

	@Override
	public int editMerchant(User user) {
		// TODO Auto-generated method stub
		String pinYin=userDao.getShopFPY(user.getShopName());
		user.setShopFPY(pinYin);
		return userDao.editMerchant(user);
	}

	@Override
	public List<User> selectHotShopList(String tradeId) {
		// TODO Auto-generated method stub
		return userDao.selectHotShopList(tradeId);
	}

	@Override
	public List<User> selectMoreShopList(String tradeId) {
		// TODO Auto-generated method stub
		return userDao.selectMoreShopList(tradeId);
	}

	@Override
	public int updateWithDrawMoneyByOpenId(Float withDrawMoney, String openId) {
		// TODO Auto-generated method stub
		return userDao.updateWithDrawMoneyByOpenId(withDrawMoney,openId);
	}

	@Override
	public int bindAlipay(User user) {
		// TODO Auto-generated method stub
		return userDao.bindAlipay(user);
	}

	@Override
	public boolean checkUserExist(String openId) {
		// TODO Auto-generated method stub
		
		int count=userDao.getUserCountByOpenId(openId);
		return count==0?false:true;
	}

	@Override
	public User getUserInfoById(String userId) {
		// TODO Auto-generated method stub
		return userDao.getUserInfoById(userId);
	}

	@Override
	public int addUser(User user) {
		// TODO Auto-generated method stub
		return userDao.addUser(user);
	}
}
