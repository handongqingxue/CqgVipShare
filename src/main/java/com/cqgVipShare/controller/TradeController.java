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
@RequestMapping(TradeController.MODULE_NAME)
public class TradeController {

	@Autowired
	private TradeService tradeService;
	public static final String MODULE_NAME="/background/trade";
	
	@RequestMapping(value="/cc/list")
	public String goCCList() {
		
		return MODULE_NAME+"/cc/list";
	}
	
	@RequestMapping(value="/selectCCList")
	@ResponseBody
	public Map<String, Object> selectCCList(int page,int rows,String sort,String order) {
		
		Map<String, Object> jsonMap = new HashMap<String, Object>();
		int count=tradeService.selectCCInt();
		List<Trade> tradeList=tradeService.selectCCList(page, rows, sort, order);
		
		jsonMap.put("total", count);
		jsonMap.put("rows", tradeList);
		
		return jsonMap;
	}
	
	@RequestMapping(value="/updateCCPercentById")
	@ResponseBody
	public Map<String, Object> updateCCPercentById(Float ccPercent,String id) {
		
		Map<String, Object> jsonMap = new HashMap<String, Object>();
		int count=tradeService.updateCCPercentById(ccPercent,id);
		
		if(count==0) {
			jsonMap.put("status", "no");
			jsonMap.put("message", "修改抽成失败！");
		}
		else {
			jsonMap.put("status", "ok");
			jsonMap.put("message", "修改抽成成功！");
		}
		
		return jsonMap;
	}
}
