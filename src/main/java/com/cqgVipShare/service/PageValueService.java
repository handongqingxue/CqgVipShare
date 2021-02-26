package com.cqgVipShare.service;

import com.cqgVipShare.entity.PageValue;

public interface PageValueService {

	boolean checkExistByOpenId(String openId);

	int updateByOpenId(PageValue pv);

	int add(PageValue pv);

	PageValue selectByOpenId(String openId);

}
