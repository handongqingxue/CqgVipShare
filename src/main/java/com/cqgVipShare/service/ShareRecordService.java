package com.cqgVipShare.service;

import com.cqgVipShare.entity.*;

public interface ShareRecordService {

	ShareRecord getShareRecordByUuid(String uuid);

	ShareRecord getSRDetailByUuid(String uuid);
}
