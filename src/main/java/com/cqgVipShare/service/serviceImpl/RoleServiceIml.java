package com.cqgVipShare.service.serviceImpl;

import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.cqgVipShare.dao.RoleMapper;
import com.cqgVipShare.service.RoleService;
@Service
public class RoleServiceIml implements RoleService{
	@Autowired
	private RoleMapper roleMapper;

	@Override
	public Set<String> getRoleListByUserId(Integer userId) {
		return roleMapper.getRoleList(userId);
	}

	@Override
	public Set<String> getPermissionByUserId(String id) {
		// TODO Auto-generated method stub
		return roleMapper.getPermissions(id);
	}

}
