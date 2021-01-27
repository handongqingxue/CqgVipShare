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
@RequestMapping(MerchantCardController.MODULE_NAME)
public class MerchantCardController {

	@Autowired
	private MerchantCardService merchantCardService;
	@Autowired
	private HandleRecordService handleRecordService;
	public static final String MODULE_NAME="/background/merchantCard";

	@RequestMapping(value="/merCard/list")
	public String goMerCardList() {
		
		return MODULE_NAME+"/merCard/list";
	}

	@RequestMapping(value="/merCard/add")
	public String goMerCardNew() {
		
		return MODULE_NAME+"/merCard/add";
	}

	@RequestMapping(value="/hanRec/list")
	public String goHanRecList() {
		
		return MODULE_NAME+"/hanRec/list";
	}
	
	@RequestMapping(value="/selectMerCardList")
	@ResponseBody
	public Map<String, Object> selectMerCardList(String name,Integer type,Integer shopId,int page,int rows,String sort,String order) {
		
		Map<String, Object> jsonMap = new HashMap<String, Object>();
		int count=merchantCardService.selectForInt(name,type,shopId);
		List<MerchantCard> mcList=merchantCardService.selectList(name, type, shopId, page, rows, sort, order);

		jsonMap.put("total", count);
		jsonMap.put("rows", mcList);
			
		return jsonMap;
	}

	@RequestMapping(value="/addMerCard")
	@ResponseBody
	public Map<String, Object> newMerCard(MerchantCard mc) {

		Map<String, Object> jsonMap = new HashMap<String, Object>();
		int count=merchantCardService.add(mc);
		
		if(count==0) {
			jsonMap.put("message", "no");
			jsonMap.put("info", "添加会员失败！");
		}
		else {
			jsonMap.put("message", "ok");
			jsonMap.put("info", "添加会员成功！");
		}
		return jsonMap;
	}
	
	@RequestMapping(value="/selectHanRecList")
	@ResponseBody
	public Map<String, Object> selectHanRecList(String mcName,Integer mcType,String createTimeStart,String createTimeEnd,Boolean receive,Integer shopId,int page,int rows,String sort,String order) {
		
		Map<String, Object> jsonMap = new HashMap<String, Object>();
		int count=handleRecordService.selectForInt(mcName,mcType,shopId,createTimeStart,createTimeEnd,receive);
		List<HandleRecord> hrList=handleRecordService.selectList(mcName, mcType, shopId, createTimeStart, createTimeEnd, receive, page, rows, sort, order);

		jsonMap.put("total", count);
		jsonMap.put("rows", hrList);
			
		return jsonMap;
	}
}
