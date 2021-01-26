package com.cqgVipShare.service.serviceImpl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.cqgVipShare.dao.*;
import com.cqgVipShare.entity.*;
import com.cqgVipShare.service.*;

@Service
public class HandleHistoryRecordServiceImpl implements HandleHistoryRecordService {

	@Autowired
	private HandleHistoryRecordMapper handleHistoryRecordDao;
	
	@Override
	public int add(HandleHistoryRecord hhr) {
		// TODO Auto-generated method stub
		return handleHistoryRecordDao.add(hhr);
	}

}
