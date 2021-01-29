package com.cqgVipShare.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.cqgVipShare.entity.*;
import com.cqgVipShare.service.*;
import com.cqgVipShare.util.FileUploadUtils;
import com.cqgVipShare.util.JsonUtil;
import com.cqgVipShare.util.PlanResult;

import net.sf.json.JSONObject;

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
	
	@RequestMapping(value="/trade/add")
	public String goTradeAdd() {
		
		return MODULE_NAME+"/trade/add";
	}
	
	@RequestMapping(value="/trade/edit")
	public String goTradeEdit(HttpServletRequest request) {
		
		String id = request.getParameter("id");
		Trade trade=tradeService.getById(id);
		request.setAttribute("trade", trade);
		
		return MODULE_NAME+"/trade/edit";
	}
	
	@RequestMapping(value="/trade/list")
	public String goTradeList() {
		
		return MODULE_NAME+"/trade/list";
	}
	
	@RequestMapping(value="/trade/detail")
	public String goTradeDetail(HttpServletRequest request) {
		
		String id = request.getParameter("id");
		Trade trade=tradeService.getById(id);
		request.setAttribute("trade", trade);
		
		return MODULE_NAME+"/trade/detail";
	}
	
	@RequestMapping(value="/selectTradeList")
	@ResponseBody
	public Map<String, Object> selectTradeList(String name,int page,int rows,String sort,String order) {
		
		Map<String, Object> jsonMap = new HashMap<String, Object>();
		int count=tradeService.selectTradeInt(name);
		List<Trade> tradeList=tradeService.selectTradeList(name, page, rows, sort, order);
		
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

	@RequestMapping(value="/addTrade",produces="plain/text; charset=UTF-8")
	@ResponseBody
	public String addTrade(Trade trade,
			@RequestParam(value="imgUrl_file",required=false) MultipartFile imgUrl_file,
			HttpServletRequest request) {

		String json=null;;
		try {
			PlanResult plan=new PlanResult();
			MultipartFile[] fileArr=new MultipartFile[1];
			fileArr[0]=imgUrl_file;
			for (int i = 0; i < fileArr.length; i++) {
				String jsonStr = null;
				if(fileArr[i].getSize()>0) {
					String folder=null;
					switch (i) {
					case 0:
						folder="TradeImg";
						break;
					}
					jsonStr = FileUploadUtils.appUploadContentImg(request,fileArr[i],folder);
					JSONObject fileJson = JSONObject.fromObject(jsonStr);
					if("成功".equals(fileJson.get("msg"))) {
						JSONObject dataJO = (JSONObject)fileJson.get("data");
						switch (i) {
						case 0:
							trade.setImgUrl(dataJO.get("src").toString());
							break;
						}
					}
				}
			}
			int count=tradeService.add(trade);
			if(count==0) {
				plan.setStatus(0);
				plan.setMsg("添加行业失败！");
				json=JsonUtil.getJsonFromObject(plan);
			}
			else {
				plan.setStatus(1);
				plan.setMsg("添加行业成功！");
				json=JsonUtil.getJsonFromObject(plan);
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return json;
	}

	@RequestMapping(value="/editTrade",produces="plain/text; charset=UTF-8")
	@ResponseBody
	public String editTrade(Trade trade,
			@RequestParam(value="imgUrl_file",required=false) MultipartFile imgUrl_file,
			HttpServletRequest request) {

		String json=null;;
		try {
			PlanResult plan=new PlanResult();
			MultipartFile[] fileArr=new MultipartFile[1];
			fileArr[0]=imgUrl_file;
			for (int i = 0; i < fileArr.length; i++) {
				String jsonStr = null;
				if(fileArr[i].getSize()>0) {
					String folder=null;
					switch (i) {
					case 0:
						folder="TradeImg";
						break;
					}
					jsonStr = FileUploadUtils.appUploadContentImg(request,fileArr[i],folder);
					JSONObject fileJson = JSONObject.fromObject(jsonStr);
					if("成功".equals(fileJson.get("msg"))) {
						JSONObject dataJO = (JSONObject)fileJson.get("data");
						switch (i) {
						case 0:
							trade.setImgUrl(dataJO.get("src").toString());
							break;
						}
					}
				}
			}
			int count=tradeService.edit(trade);
			if(count==0) {
				plan.setStatus(0);
				plan.setMsg("编辑行业失败！");
				json=JsonUtil.getJsonFromObject(plan);
			}
			else {
				plan.setStatus(1);
				plan.setMsg("编辑行业成功！");
				json=JsonUtil.getJsonFromObject(plan);
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return json;
	}
}
