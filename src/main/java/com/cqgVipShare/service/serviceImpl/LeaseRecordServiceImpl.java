package com.cqgVipShare.service.serviceImpl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.cqgVipShare.dao.*;
import com.cqgVipShare.entity.*;
import com.cqgVipShare.service.*;

@Service
public class LeaseRecordServiceImpl implements LeaseRecordService {

	@Autowired
	private LeaseRecordMapper leaseRecordDao;

	@Override
	public LeaseRecord getLRDetailById(String id) {
		// TODO Auto-generated method stub
		return leaseRecordDao.getLRDetailById(id);
	}

	@Override
	public int addLeaseRecord(LeaseRecord lr) {
		// TODO Auto-generated method stub
		return leaseRecordDao.addLeaseRecord(lr);
	}
}
