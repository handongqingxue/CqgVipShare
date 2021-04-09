package com.cqgVipShare.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.cqgVipShare.entity.*;

public interface CapFlowRecMapper {

	int selectFlowRecInt(@Param("shopId")Integer shopId);

	List<CapitalFlowRecord> selectFlowRecList(@Param("shopId")Integer shopId, @Param("start")int start, @Param("rows")int rows, String sort, String order);

	List<CapitalFlowRecord> exportFlowRecList(@Param("shopId")Integer shopId);

	int updateCapFlowStateBySrUuid(@Param("stateFlag")Integer stateFlag,@Param("uuid")String uuid);

	int addCapitalFlowRecord(CapitalFlowRecord cfr);

	int updateShareMoneyBySrUuid(@Param("shareMoney")Float shareMoney, @Param("srUuid")String srUuid);
}
