package com.cqgVipShare.dao;

import org.apache.ibatis.annotations.Param;

import com.cqgVipShare.entity.*;

public interface HandleRecordMapper {

	int add(HandleRecord hr);

	HandleRecord getByUuid(@Param("uuid")String uuid);

	int deleteByUuid(String uuid);

}
