package com.cqgVipShare.service;

import com.cqgVipShare.entity.NotifyUrlParam;

public interface NotifyUrlParamService {

	int add(NotifyUrlParam notifyUrlParam);

	NotifyUrlParam getByOutTradeNo(String outTradeNo);

	int deleteByOutTradeNo(String outTradeNo);

}
