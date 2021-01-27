package com.cqgVipShare.service;

import com.cqgVipShare.entity.*;

public interface HandleRecordService {

	int add(HandleRecord hr);

	HandleRecord getByUuid(String uuid);

	int updateReceiveByUuid(String uuid);
}
