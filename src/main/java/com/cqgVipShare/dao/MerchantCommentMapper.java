package com.cqgVipShare.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.cqgVipShare.entity.*;

public interface MerchantCommentMapper {

	int add(MerchantComment mc);

	List<MerchantComment> selectMerComment(@Param("shopId")Integer shopId);

}
