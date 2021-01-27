package com.cqgVipShare.dao;

import org.apache.ibatis.annotations.Param;

import com.cqgVipShare.entity.*;

public interface TransferRecordMapper {

	TransferRecord getLRDetailById(@Param("id")String id);

	int addTransferRecord(TransferRecord lr);
}
