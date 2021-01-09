package com.cqgVipShare.controller;

import java.io.IOException;
import java.io.OutputStream;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.cqgVipShare.entity.*;
import com.cqgVipShare.service.*;
import com.cqgVipShare.util.*;

import jxl.Workbook;
import jxl.write.Label;
import jxl.write.WritableSheet;
import jxl.write.WritableWorkbook;
import jxl.write.WriteException;

/*
 * 这个类用于封装后台接口
 */
@Controller
@RequestMapping("/merchant")
public class MerchantController {

	@Autowired
	private MerchantService merchantService;
	@Autowired
	private CapFlowRecService capFlowRecService;
	@Autowired
	private TradeService tradeService;
	@Autowired
	private UtilService utilService;

	/**
	 * 跳转至登录页面
	 * @return
	 */
	@RequestMapping(value="/login",method=RequestMethod.GET)
	public String login() {
		return "/merchant/login";
	}
	
	@RequestMapping(value="/toShopCheckList")
	public String toShopCheckList() {
		
		return "/merchant/shopCheckList";
	}
	
	@RequestMapping(value="/toShopDetail")
	public String toShopDetail() {
		
		return "/merchant/shopDetail";
	}
	
	@RequestMapping(value="/toCapFlowRecList")
	public String toCapFlowRecList() {
		
		return "/merchant/capFlowRecList";
	}
	
	@RequestMapping(value="/toTradeCCList")
	public String toTradeCCList() {
		
		return "/merchant/tradeCCList";
	}

	/**
	 * 为登录页面获取验证码
	 * @param session
	 * @param identity
	 * @param response
	 */
	@RequestMapping(value="/login/captcha")
	public void getKaptchaImageByMerchant(HttpSession session, String identity, HttpServletResponse response) {
		utilService.getKaptchaImageByMerchant(session, identity, response);
	}
	
	/**
	 * 后台用户登录
	 * @param userName
	 * @param password
	 * @param rememberMe
	 * @param loginVCode
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/login",method=RequestMethod.POST,produces="plain/text; charset=UTF-8")
	@ResponseBody
	public String login(String userName,String password,
			String rememberMe,String loginVCode,HttpServletRequest request) {
		System.out.println("===登录接口===");
		//返回值的json
		PlanResult plan=new PlanResult();
		HttpSession session=request.getSession();
		String verifyCode = (String) session.getAttribute("验证码");
		System.out.println("verifyCode==="+verifyCode);
		System.out.println("loginVCode==="+loginVCode);
		if(verifyCode.equals(loginVCode)) {
			//TODO在这附近添加登录储存信息步骤，将用户的账号以及密码储存到shiro框架的管理配置当中方便后续查询
			try {
				System.out.println("验证码一致");
				UsernamePasswordToken token = new UsernamePasswordToken(userName,password);  
				Subject currentUser = SecurityUtils.getSubject();  
				if (!currentUser.isAuthenticated()){
					//使用shiro来验证  
					token.setRememberMe(true);  
					currentUser.login(token);//验证角色和权限  
				}
			}catch (Exception e) {
				e.printStackTrace();
				plan.setStatus(1);
				plan.setMsg("登陆失败");
				return JsonUtil.getJsonFromObject(plan);
			}
			Merchant merchant=(Merchant)SecurityUtils.getSubject().getPrincipal();
			session.setAttribute("merchant", merchant);
			
			plan.setStatus(0);
			plan.setMsg("验证通过");
			plan.setUrl("/merchant/toShopCheckList");
			return JsonUtil.getJsonFromObject(plan);
		}
		plan.setStatus(1);
		plan.setMsg("验证码错误");
		return JsonUtil.getJsonFromObject(plan);
	}
	
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
	
	@RequestMapping(value="/selectCapFlowRecList")
	@ResponseBody
	public Map<String, Object> selectCapFlowRecList(int page,int rows,String sort,String order) {
		
		Map<String, Object> jsonMap = new HashMap<String, Object>();
		int count=capFlowRecService.selectCapFlowRecInt();
		List<CapitalFlowRecord> cfrList=capFlowRecService.selectCapFlowRecList(page, rows, sort, order);
		
		jsonMap.put("total", count);
		jsonMap.put("rows", cfrList);
		
		return jsonMap;
	}
	
	@RequestMapping(value="/selectTradeCCList")
	@ResponseBody
	public Map<String, Object> selectTradeCCList(int page,int rows,String sort,String order) {
		
		Map<String, Object> jsonMap = new HashMap<String, Object>();
		int count=tradeService.selectTradeCCInt();
		List<Trade> tradeList=tradeService.selectTradeCCList(page, rows, sort, order);
		
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


	@RequestMapping(value="/checkShopById")
	@ResponseBody
	public Map<String, Object> checkShopById(Integer shopCheck,String id) {

		Map<String, Object> jsonMap = new HashMap<String, Object>();
		int count=merchantService.checkShopById(shopCheck,id);
        if(count==0) {
        	jsonMap.put("status", "no");
        	jsonMap.put("message", "审核失败！");
        }
        else {
        	jsonMap.put("status", "ok");
        	jsonMap.put("message", "审核成功！");
        }
		return jsonMap;
	}

	@RequestMapping(value="/exportCapFlowRecList")
	public void exportCapFlowRecList(HttpServletResponse response) {
		try {
			String filename = "资金流水记录.xls";
			OutputStream os = response.getOutputStream();
			response.setHeader( "Content-Disposition", "attachment;filename="  + new String(filename.getBytes(),"ISO-8859-1"));
            response.setContentType("application/msexcel");
            WritableWorkbook  wwb = Workbook.createWorkbook(os);
            WritableSheet ws = wwb.createSheet("资金流水记录", 0);
            String[] titleNameArr= {"卡号","卡主昵称","分享者昵称","金额","分享者手机号","门店名称","门店地址","预估消费日期","创建时间","状态"};
            Label label;
            for(int i=0;i<titleNameArr.length;i++) {
            	label = new Label(i,0,titleNameArr[i]);
                ws.addCell(label);
            }
            
            CapitalFlowRecord cfr = null;
            List<CapitalFlowRecord> cfrList=capFlowRecService.exportCapFlowRecList();
            for(int i=0;i<cfrList.size();i++) {
            	cfr = cfrList.get(i);
            	label = new Label(0,i+1,cfr.getNo());
                ws.addCell(label);
                label = new Label(1,i+1,cfr.getKzNickName());
                ws.addCell(label);
                label = new Label(2,i+1,cfr.getFxzNickName());
                ws.addCell(label);
                label = new Label(3,i+1,cfr.getShareMoney()+"");
                ws.addCell(label);
                label = new Label(4,i+1,cfr.getPhone());
                ws.addCell(label);
                label = new Label(5,i+1,cfr.getShopName());
                ws.addCell(label);
                label = new Label(6,i+1,cfr.getShopAddress());
                ws.addCell(label);
                label = new Label(7,i+1,cfr.getYgxfDate());
                ws.addCell(label);
                label = new Label(8,i+1,cfr.getCreateTime());
                ws.addCell(label);
                String stateStr=null;
                Integer state = cfr.getState();
                switch (state) {
				case 0:
					stateStr="未消费";
					break;
				case 1:
					stateStr="已消费";
					break;
				case 2:
					stateStr="已取消";
					break;
				}
                label = new Label(9,i+1,stateStr);
                ws.addCell(label);
            }
            
            wwb.write();//写入excel对象
            wwb.close();//关闭可写入的Excel对象
            os.close();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (WriteException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	@RequestMapping(value="/exit")
	public String exit(HttpSession session) {
		System.out.println("退出接口");
		 Subject currentUser = SecurityUtils.getSubject();       
	       currentUser.logout();    
		return "/merchant/login";
	}
}
