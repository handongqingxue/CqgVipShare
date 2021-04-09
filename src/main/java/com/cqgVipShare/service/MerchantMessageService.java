package com.cqgVipShare.service;

import java.util.List;

import com.cqgVipShare.entity.MerchantMessage;

public interface MerchantMessageService {

	List<MerchantMessage> selectList(Integer flag, String openId);

	int readByIds(String ids);

	MerchantMessage getById(String id);

	int deleteMerchantMessageByIds(String ids);

	int selectForInt(String title,String isRead,String openId);

	List<MerchantMessage> selectList(String title, String isRead, String openId, int page, int rows, String sort, String order);

}
