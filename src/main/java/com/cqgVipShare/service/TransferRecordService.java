package com.cqgVipShare.service;

import com.cqgVipShare.entity.*;

public interface TransferRecordService {

	TransferRecord getLRDetailById(String id);

	int addTransferRecord(TransferRecord lr);
}
