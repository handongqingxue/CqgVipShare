package com.cqgVipShare.service;

import java.util.List;

import com.cqgVipShare.entity.MerchantMessage;

public interface MerchantMessageService {

	List<MerchantMessage> selectList(Integer flag, String shopId);

	int readByIds(String ids);

	MerchantMessage getById(String id);

	int deleteByIds(String ids);

	int selectForInt(String title,String isRead,String shopId);

	List<MerchantMessage> selectList(String title, String isRead, String shopId, int page, int rows, String sort, String order);

}
