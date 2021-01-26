package com.cqgVipShare.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.cqgVipShare.entity.*;
import com.cqgVipShare.service.*;

@Controller
@RequestMapping(HandleController.MODULE_NAME)
public class HandleController {

	@Autowired
	private MerchantCardService merchantCardService;
	public static final String MODULE_NAME="/background/handle";

	@RequestMapping(value="/merCard/list")
	public String goMerCardList() {
		
		return MODULE_NAME+"/merCard/list";
	}
	
	@RequestMapping(value="/selectMerCardList")
	@ResponseBody
	public Map<String, Object> selectCheckList(Integer shopId,int page,int rows,String sort,String order) {
		
		Map<String, Object> jsonMap = new HashMap<String, Object>();
		int count=merchantCardService.selectForInt(shopId);
		List<MerchantCard> mcList=merchantCardService.selectList(shopId, page, rows, sort, order);

		jsonMap.put("total", count);
		jsonMap.put("rows", mcList);
			
		return jsonMap;
	}
}
