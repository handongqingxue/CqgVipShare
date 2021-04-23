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
import com.cqgVipShare.util.JsonUtil;
import com.cqgVipShare.util.PlanResult;

@Controller
@RequestMapping(MerchantCardController.MODULE_NAME)
public class MerchantCardController {

	@Autowired
	private MerchantCardService merchantCardService;
	@Autowired
	private MerchantCardTypeService merchantCardTypeService;
	@Autowired
	private HandleRecordService handleRecordService;
	public static final String MODULE_NAME="/background/merchantCard";

	@RequestMapping(value="/merCardType/list")
	public String goMerCardTypeList() {
		
		return MODULE_NAME+"/merCardType/list";
	}

	@RequestMapping(value="/merCard/add")
	public String goMerCardNew() {
		
		return MODULE_NAME+"/merCard/add";
	}

	@RequestMapping(value="/merCard/edit")
	public String goMerCardEdit(HttpServletRequest request) {
		
		MerchantCard mc = merchantCardService.selectById(request.getParameter("id"));
		request.setAttribute("merchantCard", mc);
		
		return MODULE_NAME+"/merCard/edit";
	}

	@RequestMapping(value="/merCard/list")
	public String goMerCardList() {
		
		return MODULE_NAME+"/merCard/list";
	}

	@RequestMapping(value="/hanRec/list")
	public String goHanRecList() {
		
		return MODULE_NAME+"/hanRec/list";
	}

	@RequestMapping(value="/hanRec/detail")
	public String goHanRecDetail(HttpServletRequest request) {
		
		String uuid = request.getParameter("uuid");
		HandleRecord handleRecord = handleRecordService.getByUuid(uuid);
		request.setAttribute("handleRecord", handleRecord);
		
		return MODULE_NAME+"/hanRec/detail";
	}
	
	/**
	 * 查询商家会员类型
	 * @param shopId
	 * @param page
	 * @param rows
	 * @param sort
	 * @param order
	 * @return
	 */
	@RequestMapping(value="/selectMerCardTypeList")
	@ResponseBody
	public Map<String, Object> selectMerCardTypeList(Integer shopId,int page,int rows,String sort,String order) {
		
		Map<String, Object> jsonMap = new HashMap<String, Object>();
		int count=merchantCardTypeService.selectForInt(shopId);
		List<MerchantCardType> mctList=merchantCardTypeService.selectList(shopId, page, rows, sort, order);

		jsonMap.put("total", count);
		jsonMap.put("rows", mctList);
			
		return jsonMap;
	}
	
	/**
	 * 查询商家会员
	 * @param name
	 * @param type
	 * @param shopId
	 * @param page
	 * @param rows
	 * @param sort
	 * @param order
	 * @return
	 */
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

	/**
	 * 添加会员
	 * @param mc
	 * @return
	 */
	@RequestMapping(value="/addMerCard")
	@ResponseBody
	public Map<String, Object> addMerCard(MerchantCard mc) {

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

	/**
	 * 编辑会员
	 * @param mc
	 * @return
	 */
	@RequestMapping(value="/editMerCard")
	@ResponseBody
	public Map<String, Object> editMerCard(MerchantCard mc) {

		Map<String, Object> jsonMap = new HashMap<String, Object>();
		int count=merchantCardService.edit(mc);
		
		if(count==0) {
			jsonMap.put("message", "no");
			jsonMap.put("info", "编辑会员失败！");
		}
		else {
			jsonMap.put("message", "ok");
			jsonMap.put("info", "编辑会员成功！");
		}
		return jsonMap;
	}

	/**
	 * 添加会员卡类型
	 * @param mct
	 * @return
	 */
	@RequestMapping(value="/addMerCardType")
	@ResponseBody
	public Map<String, Object> addMerCardType(MerchantCardType mct) {

		Map<String, Object> jsonMap = new HashMap<String, Object>();
		int count=merchantCardTypeService.add(mct);
		
		if(count==0) {
			jsonMap.put("message", "no");
			jsonMap.put("info", "添加会员卡类型失败！");
		}
		else {
			jsonMap.put("message", "ok");
			jsonMap.put("info", "添加会员卡类型成功！");
		}
		return jsonMap;
	}
	
	/**
	 * 根据id删除商家会员卡
	 * @param ids
	 * @return
	 */
	@RequestMapping(value="/deleteMerCardByIds",produces="plain/text; charset=UTF-8")
	@ResponseBody
	public String deleteMerCardByIds(String ids) {
		
		int count=merchantCardService.deleteByIds(ids);
		PlanResult plan=new PlanResult();
		String json;
		if(count==0) {
			plan.setStatus(0);
			plan.setMsg("删除商家会员卡失败");
			json=JsonUtil.getJsonFromObject(plan);
		}
		else {
			plan.setStatus(1);
			plan.setMsg("删除商家会员卡成功");
			json=JsonUtil.getJsonFromObject(plan);
		}
		return json;
	}
	
	/**
	 * 根据type删除会员卡类型
	 * @param types
	 * @param shopId
	 * @return
	 */
	@RequestMapping(value="/deleteMerCardTypeByTypes",produces="plain/text; charset=UTF-8")
	@ResponseBody
	public String deleteMerCardTypeByTypes(String types, Integer shopId) {

		int count=merchantCardTypeService.deleteByTypes(types,shopId);
		PlanResult plan=new PlanResult();
		String json;
		if(count==0) {
			plan.setStatus(0);
			plan.setMsg("删除会员卡类型失败");
			json=JsonUtil.getJsonFromObject(plan);
		}
		else {
			plan.setStatus(1);
			plan.setMsg("删除会员卡类型成功");
			json=JsonUtil.getJsonFromObject(plan);
		}
		return json;
	}
	
	/**
	 * @param types
	 * @param shopId
	 * @return
	 */
	@RequestMapping(value="/checkExistMerCardByType",produces="plain/text; charset=UTF-8")
	@ResponseBody
	public String checkExistMerCardByType(String types, Integer shopId) {
		
		String json=merchantCardService.checkExistMerCardByType(types, shopId);
		return json;
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

	@RequestMapping(value="/selectMerCardType")
	@ResponseBody
	public Map<String, Object> selectMerCardType(Integer shopId) {

		Map<String, Object> jsonMap = new HashMap<String, Object>();
		List<MerchantCardType> mctList = merchantCardTypeService.selectList(shopId);

		if(mctList.size()==0) {
			jsonMap.put("message", "no");
		}
		else {
			jsonMap.put("message", "ok");
			jsonMap.put("data", mctList);
		}
		return jsonMap;
	}

	@RequestMapping(value="/updateEnableById")
	@ResponseBody
	public Map<String, Object> updateEnableById(Integer id, Boolean enable) {

		Map<String, Object> jsonMap = new HashMap<String, Object>();
		int count=merchantCardService.updateEnableById(id,enable);

		if(count==0) {
			jsonMap.put("state", "no");
			jsonMap.put("message", (enable?"上":"下")+"架失败！");
		}
		else {
			jsonMap.put("state", "ok");
			jsonMap.put("message", (enable?"上":"下")+"架成功！");
		}
		return jsonMap;
	}
}
