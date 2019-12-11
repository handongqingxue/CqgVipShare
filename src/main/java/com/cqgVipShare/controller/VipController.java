package com.cqgVipShare.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.cqgVipShare.entity.ShareHistoryRecord;
import com.cqgVipShare.entity.ShareRecord;
import com.cqgVipShare.entity.ShareVip;
import com.cqgVipShare.entity.Trade;
import com.cqgVipShare.entity.User;
import com.cqgVipShare.service.VipService;
import com.cqgVipShare.util.JsonUtil;
import com.cqgVipShare.util.PlanResult;
import com.cqgVipShare.util.qrcode.Qrcode;

@Controller
@RequestMapping("/vip")
public class VipController {
	
	@Autowired
	private VipService vipService;
	
	//https://www.cnblogs.com/lyr1213/p/9186330.html
	@RequestMapping(value="/toIndex")
	public String toIndex() {
		
		return "/vip/index";
	}
	
	@RequestMapping(value="/toGPS")
	public String toGPS() {
		
		return "/vip/gps";
	}
	
	@RequestMapping(value="/toVipList")
	public String toVipList() {
		
		return "/vip/vipList";
	}
	
	@RequestMapping(value="/toAddVip")
	public String toAddVip() {
		
		return "/vip/addVip";
	}
	
	@RequestMapping(value="/toScan")
	public String toScan() {
		
		return "/vip/scan";
	}
	
	@RequestMapping(value="/toMine")
	public String toMine() {
		
		return "/vip/mine";
	}
	
	@RequestMapping(value="/toAddShareRecord")
	public String toAddShareRecord() {
		
		return "/vip/addShareRecord";
	}
	
	@RequestMapping(value="/toEditMerchant")
	public String toEditMerchant(String unionId, HttpServletRequest request) {
		
		User user=vipService.getUserInfoByUnionId(unionId);
		request.setAttribute("user", user);
		
		return "/vip/editMerchant";
	}
	
	@RequestMapping(value="/toShare")
	public String toShare(String id, HttpServletRequest request) {
		
		Map<String,Object> siMap=vipService.selectShareInfoById(id);
		request.setAttribute("shareInfo", siMap);
		
		return "/vip/share";
	}

	@RequestMapping(value="/toQrcodeInfo")
	public String toQrcodeInfo(String userId, HttpServletRequest request) {
		
		User user = vipService.getUserInfoById(userId);
		request.setAttribute("user", user);
		
		return "/vip/qrcodeInfo";
	}
	
	@RequestMapping(value="/selectTrade")
	@ResponseBody
	public Map<String, Object> selectTrade(String name) {
		
		Map<String, Object> jsonMap = new HashMap<String, Object>();
		List<Trade> tradeList=vipService.selectTrade(name);

		if(tradeList.size()==0) {
			jsonMap.put("message", "no");
		}
		else {
			jsonMap.put("message", "ok");
			jsonMap.put("data", tradeList);
		}
		return jsonMap;
	}
	
	@RequestMapping(value="/selectVipList")
	@ResponseBody
	public Map<String, Object> selectVipList(String tradeId) {
		
		Map<String, Object> jsonMap = new HashMap<String, Object>();
		List<ShareVip> svList=vipService.selectVipList(tradeId);
		
		if(svList.size()==0) {
			jsonMap.put("message", "no");
		}
		else {
			jsonMap.put("message", "ok");
			jsonMap.put("data", svList);
		}
		return jsonMap;
	}

	@RequestMapping(value="/confirmConsumeShare")
	@ResponseBody
	public Map<String, Object> confirmConsumeShare(String uuid) {

		Map<String, Object> jsonMap = new HashMap<String, Object>();
		ShareRecord sr=vipService.getShareRecordByUuid(uuid);
		
		ShareHistoryRecord shr=new ShareHistoryRecord();
		shr.setVipId(sr.getVipId());
		shr.setUserId(sr.getUserId());
		shr.setPhone(sr.getPhone());
		shr.setYgxfDate(sr.getYgxfDate());
		
		int count=vipService.addShareHistoryRecord(shr);
		if(count>0) {
			count=vipService.deleteShareRecordByUuid(uuid);
		}
		
		if(count==0) {
			jsonMap.put("status", "no");
			jsonMap.put("message", "确认消费失败！");
		}
		else {
			jsonMap.put("status", "ok");
			jsonMap.put("message", "已确认消费！");
		}
		return jsonMap;
	}

	@RequestMapping(value="/addShareVip",produces="plain/text; charset=UTF-8")
	@ResponseBody
	public String addShareVip(ShareVip shareVip) {
		
		PlanResult plan=new PlanResult();
		String json;
		int count=vipService.addShareVip(shareVip);
		if(count==0) {
			plan.setStatus(0);
			plan.setMsg("添加共享会员失败！");
			json=JsonUtil.getJsonFromObject(plan);
		}
		else {
			plan.setStatus(1);
			plan.setMsg("添加共享会员成功！");
			json=JsonUtil.getJsonFromObject(plan);
		}
		return json;
	}

	@RequestMapping(value="/merchantCheck")
	@ResponseBody
	public Map<String, Object> merchantCheck(String unionId) {

		Map<String, Object> jsonMap = new HashMap<String, Object>();
		
		boolean bool=vipService.merchantCheck(unionId);
		if(bool) {
			jsonMap.put("status", "ok");
		}
		else {
			jsonMap.put("status", "no");
			jsonMap.put("message", "请完善商家信息");
		}
		return jsonMap;
	}
	
	@RequestMapping(value="/addShareRecord")
	@ResponseBody
	public Map<String, Object> addShareRecord(ShareRecord sr,HttpServletRequest request){
		String uuid = UUID.randomUUID().toString().replaceAll("-", "");

		Map<String, Object> jsonMap = new HashMap<String, Object>();
		
		String basePath=request.getScheme()+"://"+request.getServerName()+":"
				+request.getServerPort()+request.getContextPath()+"/";
		String url=basePath+"vip/toQrcodeInfo?userId=1&uuid="+uuid;
		String fileName = new SimpleDateFormat("yyyyMMddHHmmss").format(new Date()) + ".jpg";
		String avaPath="/CqgVipShare/upload/"+fileName;
		String path = "D:/resource/CqgVipShare";
        Qrcode.createQrCode(url, path, fileName);

        sr.setUuid(uuid);
		sr.setQrcodeUrl(avaPath);
        int count=vipService.addShareRecord(sr);
        if(count==0) {
        	jsonMap.put("status", "no");
        	jsonMap.put("message", "分享失败！");
        }
        else {
        	jsonMap.put("status", "ok");
        	jsonMap.put("qrcodeUrl", avaPath);
        }
		return jsonMap;
	}

	@RequestMapping(value="/editMerchant",produces="plain/text; charset=UTF-8")
	@ResponseBody
	public String editMerchant(User user) {

		PlanResult plan=new PlanResult();
		String json;
		int count=vipService.editMerchant(user);
		if(count==0) {
			plan.setStatus(0);
			plan.setMsg("商家信息完善失败！");
			json=JsonUtil.getJsonFromObject(plan);
		}
		else {
			plan.setStatus(1);
			plan.setMsg("商家信息已完善，等待审核！");
			json=JsonUtil.getJsonFromObject(plan);
		}
		return json;
	}

}
