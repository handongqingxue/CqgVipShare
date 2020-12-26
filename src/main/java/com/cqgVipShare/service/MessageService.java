package com.cqgVipShare.service;

import java.util.List;

import com.cqgVipShare.entity.*;

public interface MessageService {

	List<Message> selectCommentListByOpenId(String openId);

	int addComment(Message message);
}
