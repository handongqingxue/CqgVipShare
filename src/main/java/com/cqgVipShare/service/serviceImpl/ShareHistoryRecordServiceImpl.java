package com.cqgVipShare.service.serviceImpl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.cqgVipShare.dao.*;
import com.cqgVipShare.entity.*;
import com.cqgVipShare.service.*;

@Service
public class ShareHistoryRecordServiceImpl implements ShareHistoryRecordService {

	@Autowired
	private ShareHistoryRecordMapper shareHistoryRecordDao;

	@Override
	public List<ShareHistoryRecord> selectKzSHRListByVipId(String vipId, String openId) {
		// TODO Auto-generated method stub
		return shareHistoryRecordDao.selectKzSHRListByVipId(vipId,openId);
	}

	@Override
	public int addShareHistoryRecord(ShareHistoryRecord shr) {
		// TODO Auto-generated method stub
		return shareHistoryRecordDao.addShareHistoryRecord(shr);
	}

	@Override
	public ShareHistoryRecord getDetailByUuid(String uuid) {
		// TODO Auto-generated method stub
		return shareHistoryRecordDao.getDetailByUuid(uuid);
	}
}
