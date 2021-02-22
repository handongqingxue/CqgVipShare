package com.cqgVipShare.service;

import java.util.List;

import com.cqgVipShare.entity.MerchantComment;

public interface MerchantCommentService {

	int add(MerchantComment mc);

	List<MerchantComment> selectMerComment(Integer type,Integer shopId);

}
