package com.cqgVipShare.service;
/**
 * 获取用户在系统中的角�?
 * @author Administrator
 *
 */

import java.util.Set;

import org.springframework.stereotype.Service;

/**这个是用来获取用户在系统中扮演的角色
 * @author Administrator
 *
 */
@Service
public interface RoleService {
	//通过商户id查询用户角色
	public Set<String> getRoleListByUserId(String userId);
	//通过商户id查询角色权限
	public Set<String> getPermissionByUserId(String id);
}
