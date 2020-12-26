package com.cqgVipShare.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.cqgVipShare.entity.*;

public interface CapFlowRecMapper {

	int selectCapFlowRecInt();

	List<CapitalFlowRecord> selectCapFlowRecList(@Param("start")int start, @Param("rows")int rows, String sort, String order);

	List<CapitalFlowRecord> exportCapFlowRecList();

	int updateCapFlowStateBySrUuid(@Param("stateFlag")Integer stateFlag,@Param("uuid")String uuid);

	int addCapitalFlowRecord(CapitalFlowRecord cfr);
}
