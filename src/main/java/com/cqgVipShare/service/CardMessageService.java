package com.cqgVipShare.service;

import java.util.List;
import java.util.Map;

import com.cqgVipShare.entity.*;

public interface CardMessageService {

	List<Map<String,Object>> selectCommentListByOpenId(String openId);

	int addComment(CardMessage message);
}
