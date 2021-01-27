package com.cqgVipShare.service.serviceImpl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.cqgVipShare.dao.*;
import com.cqgVipShare.entity.*;
import com.cqgVipShare.service.*;

@Service
public class HandleRecordServiceImpl implements HandleRecordService {

	@Autowired
	private HandleRecordMapper handleRecordDao;
	
	@Override
	public int add(HandleRecord hr) {
		// TODO Auto-generated method stub
		return handleRecordDao.add(hr);
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

}
