package com.cqgVipShare.service.serviceImpl;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.cqgVipShare.dao.*;
import com.cqgVipShare.entity.*;
import com.cqgVipShare.service.*;

@Service
public class HandleRecordServiceImpl implements HandleRecordService {

	@Autowired
	private HandleRecordMapper handleRecordDao;
	@Autowired
	private MerchantMapper merchantDao;
	
	@Override
	public int add(HandleRecord hr) {
		// TODO Auto-generated method stub
		int count=handleRecordDao.add(hr);
		if(count>0)
			count=merchantDao.updateHandleCountById(true,hr.getShopId());
		return count;
	}

	@Override
	public HandleRecord getByUuid(String uuid) {
		// TODO Auto-generated method stub
		return handleRecordDao.getByUuid(uuid);
	}

	@Override
	public int updateReceiveByUuid(String uuid) {
		// TODO Auto-generated method stub
		int count=handleRecordDao.updateReceiveByUuid(uuid);
		return count;
	}

	@Override
	public int selectForInt(String mcName, Integer mcType, Integer shopId, String createTimeStart, String createTimeEnd, Boolean receive) {
		// TODO Auto-generated method stub
		return handleRecordDao.selectForInt(mcName, mcType, shopId, createTimeStart, createTimeEnd, receive);
	}

	@Override
	public List<HandleRecord> selectList(String mcName, Integer mcType, Integer shopId, String createTimeStart, String createTimeEnd, 
			Boolean receive, int page, int rows, String sort, String order) {
		// TODO Auto-generated method stub
		return handleRecordDao.selectList(mcName, mcType, shopId, createTimeStart, createTimeEnd, receive, (page-1)*rows, rows, sort, order);
	}

	@Override
	public List<Map<String,Object>> selectHandleListByFxzOpenId(Integer type, String openId) {
		// TODO Auto-generated method stub
		return handleRecordDao.selectHandleListByFxzOpenId(type, openId);
	}

	@Override
	public HandleRecord getDetailByUuid(String uuid) {
		// TODO Auto-generated method stub
		return handleRecordDao.getDetailByUuid(uuid);
	}

}
