package com.cqgVipShare.controller;

import java.io.IOException;
import java.io.OutputStream;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.cqgVipShare.entity.CapitalFlowRecord;
import com.cqgVipShare.entity.Trade;
import com.cqgVipShare.entity.User;
import com.cqgVipShare.service.VipService;

import jxl.Workbook;
import jxl.write.Label;
import jxl.write.WritableSheet;
import jxl.write.WritableWorkbook;
import jxl.write.WriteException;

@Controller
@RequestMapping("/admin")
public class AdminController {

	@Autowired
	private VipService vipService;
	
	@RequestMapping(value="/toShopCheckList")
	public String toShopCheckList() {
		
		return "/admin/shopCheckList";
	}
	
	@RequestMapping(value="/toCapFlowRecList")
	public String toCapFlowRecList() {
		
		return "/admin/capFlowRecList";
	}
	
	@RequestMapping(value="/toTradeCCList")
	public String toTradeCCList() {
		
		return "/admin/tradeCCList";
	}
	
	@RequestMapping(value="/selectShopCheckList")
	@ResponseBody
	public Map<String, Object> selectShopCheckList(int page,int rows,String sort,String order) {
		
		Map<String, Object> jsonMap = new HashMap<String, Object>();
		int count=vipService.selectShopCheckForInt();
		List<User> shopList=vipService.selectShopCheckList(page, rows, sort, order);

		jsonMap.put("total", count);
		jsonMap.put("rows", shopList);
			
		return jsonMap;
	}
	
	@RequestMapping(value="/selectCapFlowRecList")
	@ResponseBody
	public Map<String, Object> selectCapFlowRecList(int page,int rows,String sort,String order) {
		
		Map<String, Object> jsonMap = new HashMap<String, Object>();
		int count=vipService.selectCapFlowRecInt();
		List<CapitalFlowRecord> cfrList=vipService.selectCapFlowRecList(page, rows, sort, order);
		
		jsonMap.put("total", count);
		jsonMap.put("rows", cfrList);
		
		return jsonMap;
	}
	
	@RequestMapping(value="/selectTradeCCList")
	@ResponseBody
	public Map<String, Object> selectTradeCCList(int page,int rows,String sort,String order) {
		
		Map<String, Object> jsonMap = new HashMap<String, Object>();
		int count=vipService.selectTradeCCInt();
		List<Trade> tradeList=vipService.selectTradeCCList(page, rows, sort, order);
		
		jsonMap.put("total", count);
		jsonMap.put("rows", tradeList);
		
		return jsonMap;
	}
	
	@RequestMapping(value="/updateCCPercentById")
	@ResponseBody
	public Map<String, Object> updateCCPercentById(Float ccPercent,String id) {
		
		Map<String, Object> jsonMap = new HashMap<String, Object>();
		int count=vipService.updateCCPercentById(ccPercent,id);
		
		if(count==0) {
			jsonMap.put("status", "no");
			jsonMap.put("message", "�޸ĳ��ʧ�ܣ�");
		}
		else {
			jsonMap.put("status", "ok");
			jsonMap.put("message", "�޸ĳ�ɳɹ���");
		}
		
		return jsonMap;
	}

	@RequestMapping(value="/exportCapFlowRecList")
	public void exportCapFlowRecList(HttpServletResponse response) {
		try {
			String filename = "�ʽ���ˮ��¼.xls";
			OutputStream os = response.getOutputStream();
			response.setHeader( "Content-Disposition", "attachment;filename="  + new String(filename.getBytes(),"ISO-8859-1"));
            response.setContentType("application/msexcel");
            WritableWorkbook  wwb = Workbook.createWorkbook(os);
            WritableSheet ws = wwb.createSheet("�ʽ���ˮ��¼", 0);
            String[] titleNameArr= {"����","�����ǳ�","�������ǳ�","���","�������ֻ���","�ŵ�����","�ŵ��ַ","Ԥ����������","����ʱ��","״̬"};
            Label label;
            for(int i=0;i<titleNameArr.length;i++) {
            	label = new Label(i,0,titleNameArr[i]);
                ws.addCell(label);
            }
            
            CapitalFlowRecord cfr = null;
            List<CapitalFlowRecord> cfrList=vipService.exportCapFlowRecList();
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
                label = new Label(9,i+1,(cfr.getState()?"��":"δ")+"����");
                ws.addCell(label);
            }
            
            wwb.write();//д��excel����
            wwb.close();//�رտ�д���Excel����
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
		System.out.println("�˳��ӿ�");
		 Subject currentUser = SecurityUtils.getSubject();       
	       currentUser.logout();    
		return "/admin/login";
	}
}
