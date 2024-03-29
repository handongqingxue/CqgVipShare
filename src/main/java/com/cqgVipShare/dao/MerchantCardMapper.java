package com.cqgVipShare.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.cqgVipShare.entity.*;

public interface MerchantCardMapper {

	List<MerchantCard> selectList(@Param("orderFlag")Integer orderFlag, @Param("order")String order, @Param("likeFlag")Integer likeFlag, @Param("shopId")String shopId, @Param("type")Integer type,
			@Param("start")Integer start, @Param("end")Integer end, @Param("myLatitude")Double myLatitude, @Param("myLongitude")Double myLongitude);

	MerchantCard selectById(@Param("id")String id);

	int selectShopIdById(@Param("id")Integer id);

	int selectForInt(@Param("name")String name, @Param("type")Integer type, @Param("shopId")Integer shopId);

	List<MerchantCard> selectBgList(@Param("name")String name, @Param("type")Integer type, @Param("shopId")Integer shopId, @Param("start")int start, @Param("rows")int rows, String sort, String order);

	List<MerchantCard> selectMineMerBgList(@Param("name")String name, @Param("type")Integer type, @Param("shopId")Integer shopId);

	List<MerchantCard> selectMerCardSel(@Param("type")Integer type, @Param("shopId")Integer shopId);

	int add(MerchantCard mc);

	int edit(MerchantCard mc);

	int updateEnableById(@Param("id")Integer id, @Param("enable")Boolean enable);

	int deleteByIds(List<String> idList);

	int getCountByType(@Param("type")String type, @Param("shopId")Integer shopId);

}
