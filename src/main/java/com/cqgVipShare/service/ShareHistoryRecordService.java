package com.cqgVipShare.service;

import java.util.List;

import com.cqgVipShare.entity.*;

public interface ShareHistoryRecordService {

	List<ShareHistoryRecord> selectKzSHRListByScId(String scId, String openId);

	int addShareHistoryRecord(ShareHistoryRecord shr);

	ShareHistoryRecord getDetailByUuid(String uuid);
}
