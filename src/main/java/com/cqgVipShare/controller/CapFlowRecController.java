package com.cqgVipShare.controller;

import java.io.IOException;
import java.io.OutputStream;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.cqgVipShare.entity.*;
import com.cqgVipShare.service.*;

import jxl.Workbook;
import jxl.write.Label;
import jxl.write.WritableSheet;
import jxl.write.WritableWorkbook;
import jxl.write.WriteException;

@Controller
@RequestMapping(CapFlowRecController.MODULE_NAME)
public class CapFlowRecController {

	@Autowired
	private CapFlowRecService capFlowRecService;
	public static final String MODULE_NAME="/background/capital";
	
	@RequestMapping(value="/flowRec/list")
	public String goCapitalFlowRecList() {
		
		return MODULE_NAME+"/flowRec/list";
	}
	
	@RequestMapping(value="/selectFlowRecList")
	@ResponseBody
	public Map<String, Object> selectFlowRecList(Integer shopId,int page,int rows,String sort,String order) {
		
		Map<String, Object> jsonMap = new HashMap<String, Object>();
		int count=capFlowRecService.selectFlowRecInt(shopId);
		List<CapitalFlowRecord> cfrList=capFlowRecService.selectFlowRecList(shopId, page, rows, sort, order);
		
		jsonMap.put("total", count);
		jsonMap.put("rows", cfrList);
		
		return jsonMap;
	}
	
	@RequestMapping(value="/exportFlowRecList")
	public void exportFlowRecList(HttpServletRequest request, HttpServletResponse response) {
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
            Integer shopId=Integer.valueOf(request.getParameter("shopId"));
            List<CapitalFlowRecord> cfrList=capFlowRecService.exportFlowRecList(shopId);
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
}
