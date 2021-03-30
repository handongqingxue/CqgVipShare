package com.cqgVipShare.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.shiro.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.cqgVipShare.entity.*;
import com.cqgVipShare.service.*;
import com.cqgVipShare.util.*;

@Controller
@RequestMapping(MerchantController.MODULE_NAME)
public class MerchantController {

	@Autowired
	private MerchantService merchantService;
	public static final String MODULE_NAME="/background/merchant";
	
	@RequestMapping(value="/all/list")
	public String goMerchantAllList() {
		
		return MODULE_NAME+"/all/list";
	}

	@RequestMapping(value="/all/detail")
	public String goMerchantAllDetail(HttpServletRequest request) {

		Integer id = Integer.valueOf(request.getParameter("id"));
		Merchant merchant = merchantService.getById(id);
		request.setAttribute("merchant", merchant);
		
		return MODULE_NAME+"/all/detail";
	}
	
	@RequestMapping(value="/check/list")
	public String goMerchantCheckList() {
		
		return MODULE_NAME+"/check/list";
	}
	
	@RequestMapping(value="/info/info")
	public String goMerchantInfoInfo(HttpServletRequest request) {
		
		Merchant mer=(Merchant)SecurityUtils.getSubject().getPrincipal();
		request.setAttribute("merchant", mer);
		
		return MODULE_NAME+"/info/info";
	}
	
	@RequestMapping(value="/check/detail")
	public String goMerchantCheckDetail(HttpServletRequest request) {
		
		String openId = request.getParameter("openId");
		Merchant merchant=merchantService.getByOpenId(openId);
		request.setAttribute("merchant", merchant);
		
		return MODULE_NAME+"/check/detail";
	}
	
	@RequestMapping(value="/selectCheckList")
	@ResponseBody
	public Map<String, Object> selectCheckList(String shopName,Integer tradeId,int page,int rows,String sort,String order) {
		
		Map<String, Object> jsonMap = new HashMap<String, Object>();
		int count=merchantService.selectCheckForInt(shopName,tradeId);
		List<Merchant> shopList=merchantService.selectCheckList(shopName, tradeId, page, rows, sort, order);

		jsonMap.put("total", count);
		jsonMap.put("rows", shopList);
			
		return jsonMap;
	}
	
	@RequestMapping(value="/selectAllList")
	@ResponseBody
	public Map<String, Object> selectAllList(String shopName,Integer tradeId,String shopCheck,int page,int rows,String sort,String order) {
		
		Map<String, Object> jsonMap = new HashMap<String, Object>();
		int count=merchantService.selectForInt(shopName,tradeId,shopCheck);
		List<Merchant> shopList=merchantService.selectList(shopName, tradeId, shopCheck, page, rows, sort, order);

		jsonMap.put("total", count);
		jsonMap.put("rows", shopList);
			
		return jsonMap;
	}

	@RequestMapping(value="/checkShopByOpenId")
	@ResponseBody
	public Map<String, Object> checkShopByOpenId(Integer shopCheck,String content,String openId) {

		Map<String, Object> jsonMap = new HashMap<String, Object>();
    	String resultStr=null;
    	switch (shopCheck) {
			case Merchant.SHEN_HE_TONG_GUO:
				resultStr="商家审核通过";
				content="您的商家信息已审核通过，可以使用商家的功能了。";
				break;
			case Merchant.SHEN_HE_BU_HE_GE:
				resultStr="商家审核未通过";
				break;
		}
		int count=merchantService.checkShopByOpenId(shopCheck,resultStr,content,openId);
        if(count==0) {
        	jsonMap.put("status", "no");
        	jsonMap.put("message", "审核失败！");
        }
        else {
        	jsonMap.put("status", "ok");
        	jsonMap.put("message", resultStr);
        }
		return jsonMap;
	}
	
	@RequestMapping(value="/checkPassword")
	@ResponseBody
	public Map<String, Object> checkPassword(String password, String userName) {
		
		Map<String, Object> jsonMap = new HashMap<String, Object>();
		boolean bool=merchantService.checkPassWord(password,userName);
		
		if(bool) {
			jsonMap.put("status", "ok");
		}
		else {
			jsonMap.put("status", "no");
			jsonMap.put("message", "原密码错误！");
		}
		return jsonMap;
	}
	
	@RequestMapping(value="/updatePwdById")
	@ResponseBody
	public String updatePwdById(String password) {
		Merchant mer=(Merchant)SecurityUtils.getSubject().getPrincipal();
		Integer id = mer.getId();
		int count = merchantService.updatePwdById(password,id);
		
		PlanResult plan=new PlanResult();
		if(count==0) {
			plan.setStatus(0);
		}
		else {
			plan.setStatus(1);
		}
		return JsonUtil.getJsonFromObject(plan);
	}
}
