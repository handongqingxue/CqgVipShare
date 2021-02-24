package com.cqgVipShare.service;

import java.util.List;
import java.util.Map;

import com.cqgVipShare.entity.*;

public interface HandleRecordService {

	int add(HandleRecord hr);

	HandleRecord getByUuid(String uuid);

	int updateReceiveByUuid(String uuid);

	int selectForInt(String mcName, Integer mcType, Integer shopId, String createTimeStart, String createTimeEnd, Boolean receive);

	List<HandleRecord> selectList(String mcName, Integer mcType, Integer shopId, String createTimeStart, String createTimeEnd, Boolean receive, int page, int rows, String sort,
			String order);

	List<Map<String,Object>> selectHandleListByFxzOpenId(Integer type, String openId);

	HandleRecord getDetailByUuid(String uuid);
}
