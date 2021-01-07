package com.cqgVipShare.util.shiro.realm;

import java.util.HashSet;
import java.util.Set;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationInfo;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.SimpleAuthenticationInfo;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;
import org.springframework.beans.factory.annotation.Autowired;

import com.cqgVipShare.dao.*;
import com.cqgVipShare.entity.*;
import com.cqgVipShare.service.*;

public class MyRealm extends AuthorizingRealm{
	@Autowired
	private MerchantMapper merchantMapper;
	@Autowired
	private RoleService roleService;
	/**
	 * 为账号进行授权并进行验证
	 */
	@Override
	protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection arg0) {
		Merchant msg=(Merchant)SecurityUtils.getSubject().getPrincipal();
		SimpleAuthorizationInfo info = new SimpleAuthorizationInfo(); 
		if(msg.getId()==null) {
			return info;
		}
		try {
			Set<String> roleNames =null;//roleService.getRoleListByUserId(msg.getId());  
			Set<String> permissions =null;//roleService.getPermissionByUserId(msg.getPermissionId());
			//TODO添加对应的方�?
			info.setRoles(roleNames);
			info.setStringPermissions(permissions);  
			return info; 
		}catch (Exception e) {
			e.printStackTrace();
			return info;
		}
	}

	/**
	 * 对账号登录进行验�?
	 */
	@Override
	protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken authcToken) throws AuthenticationException {
		UsernamePasswordToken token = (UsernamePasswordToken) authcToken;
		Merchant msg=new Merchant(token.getUsername(),String.valueOf(token.getPassword()));
		Merchant resultMsg=merchantMapper.getMerchant(msg);
		if(token.getUsername().equals(resultMsg.getUserName())
				&&
				String.valueOf(token.getPassword()).equals(resultMsg.getPassword())){
			return new SimpleAuthenticationInfo(resultMsg,resultMsg.getPassword(),resultMsg.getUserName());
		}else{
			throw new AuthenticationException();  
		}
	}

}
