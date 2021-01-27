package com.cqgVipShare.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.cqgVipShare.entity.*;

public interface HandleRecordMapper {

	int add(HandleRecord hr);

	HandleRecord getByUuid(@Param("uuid")String uuid);

	int updateReceiveByUuid(@Param("uuid")String uuid);

	int selectForInt(@Param("mcName")String mcName, @Param("mcType")Integer mcType, @Param("shopId")Integer shopId, @Param("createTimeStart")String createTimeStart, @Param("createTimeEnd")String createTimeEnd, @Param("receive")Boolean receive);

	List<HandleRecord> selectList(@Param("mcName")String mcName, @Param("mcType")Integer mcType, @Param("shopId")Integer shopId, 
			@Param("createTimeStart")String createTimeStart, @Param("createTimeEnd")String createTimeEnd, @Param("receive")Boolean receive, 
			@Param("start")int start, @Param("rows")int rows, String sort, String order);

}
