package com.cqgVipShare.service;

import com.cqgVipShare.entity.NotifyUrlParam;

public interface NotifyUrlParamService {

	int add(NotifyUrlParam notifyUrlParam);

	NotifyUrlParam getByUuid(String uuid);

	int deleteByUuid(String uuid);

}
