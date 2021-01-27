package com.cqgVipShare.service.serviceImpl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.cqgVipShare.dao.*;
import com.cqgVipShare.entity.*;
import com.cqgVipShare.service.*;

@Service
public class TransferRecordServiceImpl implements TransferRecordService {

	@Autowired
	private TransferRecordMapper transferRecordDao;

	@Override
	public TransferRecord getLRDetailById(String id) {
		// TODO Auto-generated method stub
		return transferRecordDao.getLRDetailById(id);
	}

	@Override
	public int addTransferRecord(TransferRecord lr) {
		// TODO Auto-generated method stub
		return transferRecordDao.addTransferRecord(lr);
	}
}
