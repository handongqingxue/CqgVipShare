package com.cqgVipShare.service;

import java.util.List;

import com.cqgVipShare.entity.*;

public interface ShareHistoryRecordService {

	List<ShareHistoryRecord> selectKzSHRListByVipId(String vipId, String openId);

	int addShareHistoryRecord(ShareHistoryRecord shr);
}
