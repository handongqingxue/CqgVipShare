package com.cqgVipShare.service.serviceImpl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.cqgVipShare.dao.*;
import com.cqgVipShare.entity.*;
import com.cqgVipShare.service.*;

@Service
public class MerchantCommentServiceImpl implements MerchantCommentService {

	@Autowired
	private MerchantCommentMapper merchantCommentDao;
	
	@Override
	public int add(MerchantComment mc) {
		// TODO Auto-generated method stub
		return merchantCommentDao.add(mc);
	}

}
