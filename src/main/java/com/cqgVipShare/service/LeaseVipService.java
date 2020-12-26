package com.cqgVipShare.service;

import java.util.List;
import java.util.Map;

import com.cqgVipShare.entity.*;

public interface LeaseVipService {

	Map<String, Object> selectLeaseInfoById(String id);

	List<LeaseVip> selectLeaseVipList(Integer orderFlag, String order, Integer likeFlag, String tradeId, Integer start, Integer end, Double myLatitude, Double myLongitude);

	List<LeaseVip> selectLeaseVipListByOpenId(String openId);

	List<LeaseRecord> selectLeaseListByFxzOpenId(String openId);

	int deleteLeaseVipByIds(String ids);
}
