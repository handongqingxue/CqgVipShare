package com.cqgVipShare.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.cqgVipShare.entity.*;

public interface ShareHistoryRecordMapper {

	List<Map<String,Object>> selectYXFShareListByFxzOpenId(@Param("fxzOpenId")String fxzOpenId);

	List<ShareHistoryRecord> selectKzSHRListByScId(@Param("scId")String scId, @Param("kzOpenId")String openId);

	int add(ShareHistoryRecord shr);

	ShareHistoryRecord getDetailByUuid(@Param("uuid")String uuid);
}
