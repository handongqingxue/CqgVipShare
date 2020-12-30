package com.cqgVipShare.dao;

import com.cqgVipShare.entity.NotifyUrlParam;

public interface NotifyUrlParamMapper {

	int add(NotifyUrlParam notifyUrlParam);

	NotifyUrlParam getByUuid(String uuid);

	int deleteByUuid(String uuid);

}
