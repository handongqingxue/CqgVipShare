package com.cqgVipShare.service;

import java.util.List;
import java.util.Map;

import com.cqgVipShare.entity.MerchantCard;

public interface MerchantCardService {

	List<MerchantCard> selectList(Integer orderFlag, String order, Integer likeFlag, String shopId, Integer type, Integer start, Integer end, Double myLatitude, Double myLongitude);

	Map<String, Object> selectMapById(String id);

	MerchantCard selectById(String id);

	boolean compareShopIdWithCardShopId(String shopOpenId, Integer mcId);

	int selectForInt(String name, Integer type, Integer shopId);

	List<MerchantCard> selectList(String name, Integer type, Integer shopId, int page, int rows, String sort, String order);

	int add(MerchantCard mc);

	int edit(MerchantCard mc);

	boolean checkTypeExist(Integer type, Integer shopId);

	int updateEnableById(Integer id, Boolean enable);

	int deleteByIds(String ids);

	String checkExistMerCardByType(String types, Integer shopId);

	List<MerchantCard> selectList(String name, Integer type, Integer shopId);

	List<MerchantCard> selectList(Integer type, Integer shopId);

}
