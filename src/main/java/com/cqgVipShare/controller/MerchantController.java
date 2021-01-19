package com.cqgVipShare.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.cqgVipShare.entity.*;
import com.cqgVipShare.service.*;

@Controller
@RequestMapping(MerchantController.MODULE_NAME)
public class MerchantController {

	@Autowired
	private MerchantService merchantService;
	public static final String MODULE_NAME="/background/merchant";
	
	@RequestMapping(value="/selectShopCheckList")
	@ResponseBody
	public Map<String, Object> selectShopCheckList(int page,int rows,String sort,String order) {
		
		Map<String, Object> jsonMap = new HashMap<String, Object>();
		int count=merchantService.selectShopCheckForInt();
		List<Merchant> shopList=merchantService.selectShopCheckList(page, rows, sort, order);

		jsonMap.put("total", count);
		jsonMap.put("rows", shopList);
			
		return jsonMap;
	}
}
