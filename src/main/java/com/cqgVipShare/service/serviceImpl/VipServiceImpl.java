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
	public Vip getByOpenId(String openId) {
		// TODO Auto-generated method stub
		return vipDao.getByOpenId(openId);
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

	@Override
	public int editVipSignTxt(String signTxt, String openId) {
		// TODO Auto-generated method stub
		return vipDao.editVipSignTxt(signTxt,openId);
	}
}
