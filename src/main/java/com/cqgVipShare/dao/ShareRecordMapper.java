package com.cqgVipShare.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.cqgVipShare.entity.*;

public interface ShareRecordMapper {

	ShareRecord getByUuid(@Param("uuid")String uuid);

	ShareRecord getSRDetailByUuid(@Param("uuid")String uuid);

	List<Map<String,Object>> selectAllShareListByFxzOpenId(@Param("fxzOpenId")String fxzOpenId);

	List<Map<String,Object>> selectDXFShareListByFxzOpenId(@Param("fxzOpenId")String fxzOpenId);

	List<Map<String,Object>> selectYQXShareListByFxzOpenId(@Param("fxzOpenId")String fxzOpenId);

	List<ShareRecord> selectKzSRListByScId(@Param("scId")String scId, @Param("kzOpenId")String kzOpenId);

	int deleteByUuid(@Param("uuid")String uuid);

	int add(ShareRecord sr);
}
