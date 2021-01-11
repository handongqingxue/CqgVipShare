package com.cqgVipShare.service;

import java.util.List;

import com.cqgVipShare.entity.*;

public interface VipMessageService {

	List<VipMessage> selectCommentListByOpenId(String openId);

	int addComment(VipMessage message);
}
