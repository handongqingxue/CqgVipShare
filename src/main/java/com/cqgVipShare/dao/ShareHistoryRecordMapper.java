package com.cqgVipShare.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.cqgVipShare.entity.*;

public interface ShareHistoryRecordMapper {

	List<Map<String,Object>> selectYXFShareListByFxzOpenId(@Param("fxzOpenId")String fxzOpenId);

	List<ShareHistoryRecord> selectKzSHRListByVipId(@Param("vipId")String vipId, @Param("kzOpenId")String openId);

	int addShareHistoryRecord(ShareHistoryRecord shr);

	ShareHistoryRecord getDetailByUuid(@Param("uuid")String uuid);
}
