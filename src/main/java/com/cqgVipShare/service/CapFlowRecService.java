package com.cqgVipShare.service;

import java.util.List;

import com.cqgVipShare.entity.*;

public interface CapFlowRecService {

	int selectFlowRecInt(Integer shopId);

	List<CapitalFlowRecord> selectFlowRecList(Integer shopId, int page, int rows, String sort, String order);

	List<CapitalFlowRecord> selectFlowRecList(Integer shopId, String startTime, String endTime);

	List<CapitalFlowRecord> exportFlowRecList(Integer shopId);

	int deleteCFRByUuid(String srUuid);

	int canncelShareVip(String srUuid, String content, String fxzOpenId);

	int confirmCanShareVip(CapitalFlowRecord cfr);
}
