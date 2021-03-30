package com.cqgVipShare.service;

import java.util.List;

import com.cqgVipShare.entity.*;

public interface MerchantService {

	int selectCheckForInt(String shopName, Integer tradeId);

	List<Merchant> selectCheckList(String shopName, Integer tradeId, int page, int rows, String sort, String order);

	int selectForInt(String shopName, Integer tradeId, String shopCheck);

	List<Merchant> selectList(String shopName, Integer tradeId, String shopCheck, int page, int rows, String sort, String order);

	Merchant getMerchant(Merchant merchant);

	Merchant getByOpenId(String openId);

	Merchant getById(Integer id);

	int addMerchant(Merchant merchant);

	int editMerchant(Merchant merchant);

	int checkShopByOpenId(Integer shopCheck, String resultStr, String content, String openId);

	List<Merchant> selectHotShopList(String tradeId);

	List<Merchant> selectMoreShopList(String tradeId);

	boolean checkUserNameExist(String userName);

	List<Merchant> selectHotShopList();

	int updateVisitCountById(Integer id);

	boolean checkPassWord(String password, String userName);

	int updatePwdById(String password, Integer id);
}
