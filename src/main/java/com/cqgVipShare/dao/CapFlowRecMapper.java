package com.cqgVipShare.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.cqgVipShare.entity.*;

public interface CapFlowRecMapper {

	int selectFlowRecInt();

	List<CapitalFlowRecord> selectFlowRecList(@Param("start")int start, @Param("rows")int rows, String sort, String order);

	List<CapitalFlowRecord> exportFlowRecList();

	int updateCapFlowStateBySrUuid(@Param("stateFlag")Integer stateFlag,@Param("uuid")String uuid);

	int addCapitalFlowRecord(CapitalFlowRecord cfr);
}
