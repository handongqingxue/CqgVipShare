package com.cqgVipShare.service;

import java.util.List;

import com.cqgVipShare.entity.*;

public interface CapFlowRecService {

	int selectFlowRecInt();

	List<CapitalFlowRecord> selectFlowRecList(int page, int rows, String sort, String order);

	List<CapitalFlowRecord> exportFlowRecList();

	int deleteCFRByUuid(String srUuid);

	int canncelShareVip(String srUuid, String content, String fxzOpenId);

	int confirmCanShareVip(CapitalFlowRecord cfr);
}
