package com.cqgVipShare.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.cqgVipShare.entity.*;

public interface MerchantCardMapper {

	List<MerchantCard> selectList(@Param("shopId")String shopId);

}
