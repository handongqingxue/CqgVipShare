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
	@Autowired
	private MerchantMessageMapper merchantMessageDao;
	
	@Override
	public int selectCheckForInt(String shopName, Integer tradeId) {
		// TODO Auto-generated method stub
		return merchantDao.selectCheckForInt(shopName, tradeId);
	}

	@Override
	public List<Merchant> selectCheckList(String shopName, Integer tradeId, int page, int rows, String sort, String order) {
		// TODO Auto-generated method stub
		return merchantDao.selectCheckList(shopName, tradeId, (page-1)*rows, rows, sort, order);
	}

	@Override
	public int selectForInt(String shopName, Integer tradeId, String shopCheck) {
		// TODO Auto-generated method stub
		return merchantDao.selectForInt(shopName, tradeId, shopCheck);
	}

	@Override
	public List<Merchant> selectList(String shopName, Integer tradeId, String shopCheck, int page, int rows, String sort, String order) {
		// TODO Auto-generated method stub
		return merchantDao.selectList(shopName, tradeId, shopCheck, (page-1)*rows, rows, sort, order);
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
	public Merchant getById(Integer id) {
		// TODO Auto-generated method stub
		return merchantDao.getById(id);
	}

	@Override
	public int add(Merchant merchant) {
		// TODO Auto-generated method stub
		//https://www.cnblogs.com/kiko2014551511/p/11527423.html
		String pinYin=merchantDao.getShopFPY(merchant.getShopName());
		merchant.setShopFPY(pinYin);
		return merchantDao.add(merchant);
	}

	@Override
	public int edit(Merchant merchant) {
		// TODO Auto-generated method stub
		String pinYin=merchantDao.getShopFPY(merchant.getShopName());
		merchant.setShopFPY(pinYin);
		return merchantDao.edit(merchant);
	}

	@Override
	public int checkShopById(Integer shopCheck, String resultStr, String content, Integer shopId) {
		// TODO Auto-generated method stub
		int count=merchantDao.updateShopCheckById(shopCheck,shopId);
		if(count>0) {
			MerchantMessage mm=new MerchantMessage();
			mm.setTitle(resultStr);
			mm.setContent(content);
			mm.setShopId(shopId);
			count=merchantMessageDao.add(mm);
		}
		return count;
	}

	@Override
	public List<Merchant> selectHotShopList(String tradeId) {
		// TODO Auto-generated method stub
		return merchantDao.selectHotShopList(tradeId);
	}

	@Override
	public List<Merchant> selectMoreShopList(String tradeId) {
		// TODO Auto-generated method stub
		return merchantDao.selectMoreShopList(tradeId);
	}

	@Override
	public boolean checkUserNameExist(String userName) {
		// TODO Auto-generated method stub
		int count=merchantDao.checkUserNameExist(userName);
		return count>0?true:false;
	}

	@Override
	public List<Merchant> selectHotShopList() {
		// TODO Auto-generated method stub
		return merchantDao.selectHotShopList();
	}

	@Override
	public int updateVisitCountById(Integer id) {
		// TODO Auto-generated method stub
		return merchantDao.updateVisitCountById(id);
	}

	@Override
	public boolean checkPassWord(String password, String userName) {
		// TODO Auto-generated method stub
		String pwd = merchantDao.getPwdByUserName(userName);
		if(pwd.equals(password)) {
			return true;
		}
		else
			return false;
	}

	@Override
	public boolean checkPwdByOpenId(String password, String openId) {
		// TODO Auto-generated method stub
		String pwd = merchantDao.getPwdByOpenId(openId);
		if(pwd.equals(password)) {
			return true;
		}
		else
			return false;
	}

	@Override
	public int updatePwdById(String password, Integer id) {
		// TODO Auto-generated method stub
		return merchantDao.updatePwdById(password,id);
	}

	@Override
	public int updatePwdByOpenId(String password, String openId) {
		// TODO Auto-generated method stub
		return merchantDao.updatePwdByOpenId(password,openId);
	}
}
