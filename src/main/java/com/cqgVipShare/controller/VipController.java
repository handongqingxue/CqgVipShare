package com.cqgVipShare.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/vip")
public class VipController {
	
	//https://www.cnblogs.com/lyr1213/p/9186330.html
	@RequestMapping(value="/toIndex")
	public String toIndex() {
		
		return "/vip/index";
	}
	
	@RequestMapping(value="/toGPS")
	public String toGPS() {
		
		return "/vip/gps";
	}

}
