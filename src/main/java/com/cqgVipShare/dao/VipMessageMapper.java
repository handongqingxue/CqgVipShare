package com.cqgVipShare.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.cqgVipShare.entity.*;

public interface VipMessageMapper {

	List<VipMessage> selectCommentListByOpenId(@Param("fxzOpenId")String openId);

	int addMessage(VipMessage msg);
}
