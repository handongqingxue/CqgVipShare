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

	int add(Merchant merchant);

	int edit(Merchant merchant);

	int checkShopById(Integer shopCheck, String resultStr, String content, Integer shopId);

	List<Merchant> selectHotShopList(String tradeId);

	List<Merchant> selectMoreShopList(String tradeId);

	boolean checkUserNameExist(String userName);

	List<Merchant> selectHotShopList(Double myLatitude, Double myLongitude);

	int updateVisitCountById(Integer id);

	boolean checkPassWord(String password, String userName);

	boolean checkPwdByOpenId(String password, String openId);

	int updatePwdById(String password, Integer id);

	int updatePwdByOpenId(String password, String openId);

	int updateWithDrawMoneyById(Float withDrawMoney, Integer id);

	int updateWXQrcodeById(Integer wxFlag, String wxQrcode, Integer id);

	int updateOpenIdById(String openId, Integer id);

	boolean checkOpenIdExist(String openId);
}
