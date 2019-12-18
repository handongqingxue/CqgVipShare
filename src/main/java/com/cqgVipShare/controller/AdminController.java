package com.cqgVipShare.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.cqgVipShare.entity.Trade;
import com.cqgVipShare.entity.User;
import com.cqgVipShare.service.VipService;

@Controller
@RequestMapping("/admin")
public class AdminController {

	@Autowired
	private VipService vipService;
	
	@RequestMapping(value="/toShopCheckList")
	public String toShopCheckList() {
		
		return "/admin/shopCheckList";
	}
	
	@RequestMapping(value="/selectShopCheckList")
	@ResponseBody
	public Map<String, Object> selectShopCheckList(int page,int rows,String sort,String order) {
		
		Map<String, Object> jsonMap = new HashMap<String, Object>();
		int count=vipService.selectShopCheckForInt();
		List<User> shopList=vipService.selectShopCheckList(page, rows, sort, order);

		jsonMap.put("total", count);
		jsonMap.put("rows", shopList);
			
		return jsonMap;
	}

	@RequestMapping(value="/exit")
	public String exit(HttpSession session) {
		System.out.println("ÍË³ö½Ó¿Ú");
		 Subject currentUser = SecurityUtils.getSubject();       
	       currentUser.logout();    
		return "/admin/login";
	}
}
