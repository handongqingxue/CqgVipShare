package com.cqgVipShare.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.cqgVipShare.entity.*;

public interface ShareRecordMapper {

	ShareRecord getShareRecordByUuid(@Param("uuid")String uuid);

	ShareRecord getSRDetailByUuid(@Param("uuid")String uuid);

	List<Map<String,Object>> selectAllShareListByFxzOpenId(@Param("fxzOpenId")String fxzOpenId);

	List<Map<String,Object>> selectDXFShareListByFxzOpenId(@Param("fxzOpenId")String fxzOpenId);

	List<Map<String,Object>> selectYQXShareListByFxzOpenId(@Param("fxzOpenId")String fxzOpenId);

	List<ShareRecord> selectKzSRListByVipId(@Param("vipId")String vipId, @Param("kzOpenId")String kzOpenId);

	int deleteShareRecordByUuid(@Param("uuid")String uuid);

	int addShareRecord(ShareRecord sr);
}
