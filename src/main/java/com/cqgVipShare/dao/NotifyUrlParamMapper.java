package com.cqgVipShare.dao;

import com.cqgVipShare.entity.NotifyUrlParam;

public interface NotifyUrlParamMapper {

	int add(NotifyUrlParam notifyUrlParam);

	NotifyUrlParam getByOutTradeNo(String outTradeNo);

	int deleteByOutTradeNo(String outTradeNo);

}
