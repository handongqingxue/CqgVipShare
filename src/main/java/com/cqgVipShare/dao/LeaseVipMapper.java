package com.cqgVipShare.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.cqgVipShare.entity.*;

public interface LeaseVipMapper {

	LeaseVip selectLeaseVipById(@Param("id")String id);

	List<LeaseVip> selectLeaseVipList(@Param("orderFlag")Integer orderFlag, @Param("order")String order, @Param("likeFlag")Integer likeFlag, @Param("tradeId")String tradeId, 
			@Param("start")Integer start, @Param("end")Integer end, @Param("myLatitude")Double myLatitude, @Param("myLongitude")Double myLongitude);

	List<LeaseVip> selectLeaseVipListByOpenId(@Param("openId")String openId);

	List<LeaseRecord> selectLeaseListByFxzOpenId(@Param("zlzOpenId")String zlzOpenId);

	int deleteLeaseVipByIds(List<String> idList);
}
