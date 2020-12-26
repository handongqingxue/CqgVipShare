package com.cqgVipShare.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.cqgVipShare.entity.*;

public interface ShareHistoryRecordMapper {

	List<ShareRecord> selectYXFShareListByFxzOpenId(@Param("fxzOpenId")String fxzOpenId);

	List<ShareHistoryRecord> selectKzSHRListByVipId(@Param("vipId")String vipId, @Param("kzOpenId")String openId);

	int addShareHistoryRecord(ShareHistoryRecord shr);
}
