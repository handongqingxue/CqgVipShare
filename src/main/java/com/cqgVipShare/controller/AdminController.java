package com.cqgVipShare.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("/admin")
public class AdminController {

	@RequestMapping(value="/toShopCheckList")
	public String toShopCheckList() {
		
		return "/admin/shopCheckList";
	}
}
