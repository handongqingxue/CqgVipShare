package com.cqgVipShare.service;

import java.util.List;

import com.cqgVipShare.entity.MerchantMessage;

public interface MerchantMessageService {

	List<MerchantMessage> selectList(Integer flag, String openId);

}
