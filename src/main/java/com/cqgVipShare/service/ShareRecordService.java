package com.cqgVipShare.service;

import java.util.List;

import com.cqgVipShare.entity.*;

public interface ShareRecordService {

	ShareRecord getByUuid(String uuid);

	ShareRecord getSRDetailByUuid(String uuid);

	List<ShareRecord> selectKzSRListByScId(String scId, String openId);

	int deleteByUuid(String uuid);

	int add(ShareRecord sr);

	int confirmConsumeMoney(Float shareMoney, String uuid);
}
