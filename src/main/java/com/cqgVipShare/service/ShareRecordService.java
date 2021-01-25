package com.cqgVipShare.service;

import java.util.List;

import com.cqgVipShare.entity.*;

public interface ShareRecordService {

	ShareRecord getByUuid(String uuid);

	ShareRecord getSRDetailByUuid(String uuid);

	List<ShareRecord> selectKzSRListByScId(String scId, String openId);

	int deleteShareRecordByUuid(String uuid);

	int addShareRecord(ShareRecord sr);
}
