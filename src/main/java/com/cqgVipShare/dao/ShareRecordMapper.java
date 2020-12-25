package com.cqgVipShare.dao;

import org.apache.ibatis.annotations.Param;

import com.cqgVipShare.entity.*;

public interface ShareRecordMapper {

	ShareRecord getShareRecordByUuid(@Param("uuid")String uuid);
}
