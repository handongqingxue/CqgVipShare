package com.cqgVipShare.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.cqgVipShare.entity.*;

public interface ShareRecordMapper {

	ShareRecord getShareRecordByUuid(@Param("uuid")String uuid);

	ShareRecord getSRDetailByUuid(@Param("uuid")String uuid);

	List<ShareRecord> selectAllShareListByFxzOpenId(@Param("fxzOpenId")String fxzOpenId);

	List<ShareRecord> selectDXFShareListByFxzOpenId(@Param("fxzOpenId")String fxzOpenId);

	List<ShareRecord> selectYQXShareListByFxzOpenId(@Param("fxzOpenId")String fxzOpenId);

	List<ShareRecord> selectKzSRListByVipId(@Param("vipId")String vipId, @Param("kzOpenId")String kzOpenId);

	int deleteShareRecordByUuid(@Param("uuid")String uuid);

	int addShareRecord(ShareRecord sr);
}
