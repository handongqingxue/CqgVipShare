package com.cqgVipShare.dao;

import org.apache.ibatis.annotations.Param;

import com.cqgVipShare.entity.*;

public interface LeaseRecordMapper {

	LeaseRecord getLRDetailById(@Param("id")String id);
}
