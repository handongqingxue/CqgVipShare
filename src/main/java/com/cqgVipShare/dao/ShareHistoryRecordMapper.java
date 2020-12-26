package com.cqgVipShare.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.cqgVipShare.entity.*;

public interface ShareHistoryRecordMapper {

	List<ShareRecord> selectYXFShareListByFxzOpenId(@Param("fxzOpenId")String fxzOpenId);
}
