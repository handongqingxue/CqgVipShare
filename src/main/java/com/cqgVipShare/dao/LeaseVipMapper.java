package com.cqgVipShare.dao;

import org.apache.ibatis.annotations.Param;

import com.cqgVipShare.entity.*;

public interface LeaseVipMapper {

	LeaseVip selectLeaseVipById(@Param("id")String id);
}
