package com.cqgVipShare.service;

import java.util.List;

import com.cqgVipShare.entity.*;

public interface ShareRecordService {

	ShareRecord getShareRecordByUuid(String uuid);

	ShareRecord getSRDetailByUuid(String uuid);

	List<ShareRecord> selectKzSRListByVipId(String vipId, String openId);

	int deleteShareRecordByUuid(String uuid);

	int addShareRecord(ShareRecord sr);
}
