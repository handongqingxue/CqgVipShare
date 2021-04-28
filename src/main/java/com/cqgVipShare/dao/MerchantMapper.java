package com.cqgVipShare.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.cqgVipShare.entity.*;

public interface MerchantMapper {
	//通过用户信息查询用户
	public Merchant getMerchant(Merchant Merchant);

	int selectCheckForInt(@Param("shopName")String shopName, @Param("tradeId")Integer tradeId);

	List<Merchant> selectCheckList(@Param("shopName")String shopName, @Param("tradeId")Integer tradeId, @Param("start")int start, @Param("rows")int rows, String sort, String order);

	public int selectForInt(@Param("shopName")String shopName, @Param("tradeId")Integer tradeId, @Param("shopCheck")String shopCheck);

	public List<Merchant> selectList(@Param("shopName")String shopName, @Param("tradeId")Integer tradeId, @Param("shopCheck")String shopCheck, @Param("start")int start, @Param("rows")int rows, String sort, String order);
	
	String getShopFPY(@Param("shopName")String shopName);

	int add(Merchant merchant);

	int edit(Merchant Merchant);

	int updateShopCheckById(@Param("shopCheck")Integer shopCheck, @Param("id")Integer id);

	List<Merchant> selectHotShopList(@Param("tradeId")String tradeId);

	List<Merchant> selectLocHotShopList(@Param("myLatitude")Double myLatitude, @Param("myLongitude")Double myLongitude);

	public List<Merchant> selectHotShopList();

	List<Merchant> selectMoreShopList(@Param("tradeId")String tradeId);

	Merchant getById(@Param("id")Integer id);
	
	int getShopIdByOpenId(@Param("openId")String openId);

	public int checkUserNameExist(@Param("userName")String userName);

	public int updateVisitCountById(@Param("id")Integer id);

	public int updateShareCountById(@Param("enable")Boolean enable, @Param("id")Integer id);

	public int updateHandleCountById(@Param("enable")Boolean enable, @Param("id")Integer id);

	public String getPwdByUserName(@Param("userName")String userName);

	public String getPwdById(@Param("id")Integer id);

	public int updatePwdById(@Param("password")String password, @Param("id")Integer id);

	public int updateWithDrawMoneyById(@Param("withDrawMoney")Float withDrawMoney, @Param("id")Integer id);

	public int updateWXQrcodeById(@Param("wxFlag")Integer wxFlag, @Param("wxQrcode")String wxQrcode, @Param("id")Integer id);

	public int updateOpenIdById(@Param("openId")String openId, @Param("id")Integer id);

	public int getCountByOpenId(@Param("openId")String openId);

}
