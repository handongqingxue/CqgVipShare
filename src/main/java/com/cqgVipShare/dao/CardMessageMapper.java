package com.cqgVipShare.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.cqgVipShare.entity.*;

public interface CardMessageMapper {

	List<Map<String,Object>> selectCommentListByOpenId(@Param("fxzOpenId")String openId);

	int addMessage(CardMessage msg);
}
