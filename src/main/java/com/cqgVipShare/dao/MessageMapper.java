package com.cqgVipShare.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.cqgVipShare.entity.*;

public interface MessageMapper {

	List<Message> selectCommentListByOpenId(@Param("fxzOpenId")String openId);
}
