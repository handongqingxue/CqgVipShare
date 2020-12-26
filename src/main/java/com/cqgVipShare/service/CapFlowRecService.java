package com.cqgVipShare.service;

import java.util.List;

import com.cqgVipShare.entity.*;

public interface CapFlowRecService {

	int selectCapFlowRecInt();

	List<CapitalFlowRecord> selectCapFlowRecList(int page, int rows, String sort, String order);

	List<CapitalFlowRecord> exportCapFlowRecList();

	int deleteCFRByUuid(String srUuid);

	int canncelShareVip(String srUuid, String content, String fxzOpenId);

	int confirmCanShareVip(String srUuid);
}
