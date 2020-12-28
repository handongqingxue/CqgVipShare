package com.cqgVipShare.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.ServletInputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.alipay.api.AlipayApiException;
import com.alipay.api.AlipayClient;
import com.alipay.api.DefaultAlipayClient;
import com.alipay.api.request.AlipayTradeWapPayRequest;

import com.cqgVipShare.entity.*;
import com.cqgVipShare.service.*;
import com.cqgVipShare.util.*;
import com.cqgVipShare.util.qrcode.Qrcode;
import com.thoughtworks.xstream.XStream;
import com.thoughtworks.xstream.io.xml.DomDriver;

import net.sf.json.JSONObject;

/*
 * �����Ա����ƽ̨
 * oNFEuwzkbP4OTTjBucFgBTWE5Bqg
 * �������Ҫ��������װ�ֻ��˵Ľӿ�
 */
/* 
<dependency>
	<groupId>mysql</groupId>
	<artifactId>mysql-connector-java</artifactId>
	<version>5.1.42</version>
</dependency>
*/
@Controller
@RequestMapping("/vip")
public class VipController {

	String TAG = "VipController";
	/**
	 * ��Ա������ƽ̨����
	 */
	public static final String MCARDGX="http://www.mcardgx.com";
	public static final String APPID="wxf600e162d89732da";
	public static final String SECRET="097ee3404400bdf4b75ac8cfb0cc1c26";
	
	@Autowired
	private UserService userService;
	@Autowired
	private ShareVipService shareVipService;
	@Autowired
	private LeaseVipService leaseVipService;
	@Autowired
	private ShareRecordService shareRecordService;
	@Autowired
	private ShareHistoryRecordService shareHistoryRecordService;
	@Autowired
	private LeaseRecordService leaseRecordService;
	@Autowired
	private TradeService tradeService;
	@Autowired
	private MessageService messageService;
	@Autowired
	private CapFlowRecService capFlowRecService;
	
	//https://www.cnblogs.com/lyr1213/p/9186330.html
	
	@RequestMapping(value="/toIndex")
	public String toIndex(HttpServletRequest request) {
		
		String goPage="/vip/index";
		return checkMyLocation(request,goPage);
	}
	
	public String checkMyLocation(HttpServletRequest request, String goPage) {
		
		HttpSession session = request.getSession();
		saveMyLocation(session,new MyLocation(35.95795,120.19353));
		
		Object myLocObj = session.getAttribute("myLocation");
		if(myLocObj==null) {
			if(goPage.contains("/index"))
				request.setAttribute("redirectUrl", "vip/toIndex");
			else if(goPage.contains("/leaseVipList"))
				request.setAttribute("redirectUrl", "vip/toLeaseVipList");
			request.setAttribute("appId", APPID);
			request.setAttribute("appSecret", SECRET);
			return "/vip/getLocation";
		}
		else
			return goPage;
	}

	@RequestMapping(value="/saveMyLocation")
	@ResponseBody
	public Map<String, Object> saveMyLocation(HttpSession session, MyLocation myLocation) {
		
		Map<String, Object> jsonMap = new HashMap<String, Object>();
		
		session.setAttribute("myLocation", myLocation);
		
		jsonMap.put("status", "ok");
		
		return jsonMap;
	}
	
	@RequestMapping(value="/toGPS")
	public String toGPS() {
		
		return "/vip/gps";
	}
	
	@RequestMapping(value="/toVipList")
	public String toVipList() {
		
		return "/vip/vipList";
	}
	
	@RequestMapping(value="/toAddShareVip")
	public String toAddShareVip() {
		
		return "/vip/addShareVip";
	}
	
	@RequestMapping(value="/toScan")
	public String toScan(HttpServletRequest request) {

		request.setAttribute("appId", APPID);
		request.setAttribute("appSecret", SECRET);
		
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
	
	@RequestMapping(value="/toAddLeaseRecord")
	public String toAddLeaseRecord() {
		
		return "/vip/addLeaseRecord";
	}
	
	@RequestMapping(value="/toEditMerchant")
	public String toEditMerchant(String openId, HttpServletRequest request) {
		
		User user=userService.getUserInfoByOpenId(openId);
		request.setAttribute("user", user);
		request.setAttribute("appId", APPID);
		request.setAttribute("appSecret", SECRET);
		
		return "/vip/editMerchant";
	}
	
	@RequestMapping(value="/toShare")
	public String toShare(String id, HttpServletRequest request) {
		
		Map<String,Object> siMap=shareVipService.selectShareInfoById(id);
		request.setAttribute("shareInfo", siMap);
		
		return "/vip/share";
	}
	
	@RequestMapping(value="/toLease")
	public String toLease(String id, HttpServletRequest request) {
		
		Map<String,Object> liMap=leaseVipService.selectLeaseInfoById(id);
		request.setAttribute("leaseInfo", liMap);
		
		return "/vip/lease";
	}

	@RequestMapping(value="/toQrcodeInfo")
	public String toQrcodeInfo(String openId, String uuid, HttpServletRequest request) {
		
		String url=null;
		ShareRecord sr = shareRecordService.getShareRecordByUuid(uuid);
		if(sr==null) {
			request.setAttribute("warnMsg", "������ʹ��");
			url="/vip/qrcodeWarn";
		}
		else {
			boolean bool=shareVipService.compareShopIdWithVipShopId(openId,sr.getVipId());
			if(bool) {
				User user = userService.getUserInfoByOpenId(openId);
				request.setAttribute("user", user);
				url="/vip/qrcodeInfo";
			}
			else {
				request.setAttribute("warnMsg", "�Ǳ����Ա");
				url="/vip/qrcodeWarn";
			}
		}
		
		return url;
	}

	@RequestMapping(value="/toShareList")
	public String toShareList() {

		return "/vip/shareList";
	}
	
	@RequestMapping(value="/toAddComment")
	public String toAddComment() {
		
		return "/vip/addComment";
	}
	
	@RequestMapping(value="/toMyShareVipList")
	public String toMyShareVipList() {
		
		return "/vip/myShareVipList";
	}
	
	@RequestMapping(value="/toTradeList")
	public String toTradeList() {
		
		return "/vip/tradeList";
	}
	
	@RequestMapping(value="/toShopList")
	public String toShopList() {
		
		return "/vip/shopList";
	}
	
	@RequestMapping(value="/toLeaseVipList")
	public String toLeaseVipList(HttpServletRequest request) {
		
		String goPage="/vip/leaseVipList";
		return checkMyLocation(request,goPage);
	}
	
	@RequestMapping(value="/toDelLeaseList")
	public String toDelLeaseList() {
		
		return "/vip/delLeaseList";
	}
	
	@RequestMapping(value="/toAddLeaseVip")
	public String toAddLeaseVip() {
		
		return "/vip/addLeaseVip";
	}
	
	@RequestMapping(value="/toKzSRList")
	public String toKzSRList() {
		
		return "/vip/kzSRList";
	}
	
	@RequestMapping(value="/toKzSHRList")
	public String toKzSHRList() {
		
		return "/vip/kzSHRList";
	}
	
	@RequestMapping(value="/toSRDetail")
	public String toSRDetail(String uuid, HttpServletRequest request) {
		
		ShareRecord sr=shareRecordService.getSRDetailByUuid(uuid);
		request.setAttribute("shareRecord", sr);
		
		return "/vip/srDetail";
	}
	
	@RequestMapping(value="/toLRDetail")
	public String toLRDetail(String id, HttpServletRequest request) {
		
		LeaseRecord lr=leaseRecordService.getLRDetailById(id);
		request.setAttribute("leaseRecord", lr);
		
		return "/vip/lrDetail";
	}
	
	@RequestMapping(value="/selectTrade")
	@ResponseBody
	public Map<String, Object> selectTrade(String name) {
		
		Map<String, Object> jsonMap = new HashMap<String, Object>();
		List<Trade> tradeList=tradeService.selectTrade(name);

		if(tradeList.size()==0) {
			jsonMap.put("message", "no");
		}
		else {
			jsonMap.put("message", "ok");
			jsonMap.put("data", tradeList);
		}
		return jsonMap;
	}

	@RequestMapping(value="/selectLeaseVipList")
	@ResponseBody
	public Map<String, Object> selectLeaseVipList(Integer orderFlag,String order,Integer likeFlag,String tradeId,Integer start,Integer end,Double myLatitude,Double myLongitude) {

		Map<String, Object> jsonMap = new HashMap<String, Object>();
		List<LeaseVip> lvList=leaseVipService.selectLeaseVipList(orderFlag,order,likeFlag,tradeId,start,end,myLatitude,myLongitude);

		if(lvList.size()==0) {
			jsonMap.put("status", "no");
		}
		else {
			jsonMap.put("status", "ok");
			jsonMap.put("data", lvList);
		}
		return jsonMap;
	}
	
	@RequestMapping(value="/selectLeaseVipListByOpenId")
	@ResponseBody
	public Map<String, Object> selectLeaseVipListByOpenId(String openId) {
		
		Map<String, Object> jsonMap = new HashMap<String, Object>();
		List<LeaseVip> lvList=leaseVipService.selectLeaseVipListByOpenId(openId);
		
		if(lvList.size()==0) {
			jsonMap.put("status", "no");
		}
		else {
			jsonMap.put("status", "ok");
			jsonMap.put("data", lvList);
		}
		return jsonMap;
	}
	
	@RequestMapping(value="/selectShareListByOpenId")
	@ResponseBody
	public Map<String, Object> selectShareListByOpenId(Integer type, String openId) {
		
		Map<String, Object> jsonMap = new HashMap<String, Object>();
		List<ShareRecord> shareList=shareVipService.selectShareListByFxzOpenId(type,openId);
		
		if(shareList.size()==0) {
			jsonMap.put("message", "no");
			jsonMap.put("info", "���޹���");
		}
		else {
			jsonMap.put("message", "ok");
			jsonMap.put("data", shareList);
		}
		return jsonMap;
	}
	
	@RequestMapping(value="/selectCommentListByOpenId")
	@ResponseBody
	public Map<String, Object> selectCommentListByOpenId(String openId) {
		
		Map<String, Object> jsonMap = new HashMap<String, Object>();
		List<Message> messageList=messageService.selectCommentListByOpenId(openId);
		
		if(messageList.size()==0) {
			jsonMap.put("message", "no");
			jsonMap.put("info", "��������");
		}
		else {
			jsonMap.put("message", "ok");
			jsonMap.put("data", messageList);
		}
		return jsonMap;
	}
	
	@RequestMapping(value="/selectLeaseListByOpenId")
	@ResponseBody
	public Map<String, Object> selectLeaseListByOpenId(String openId) {
		
		Map<String, Object> jsonMap = new HashMap<String, Object>();
		List<LeaseRecord> lrList=leaseVipService.selectLeaseListByFxzOpenId(openId);
		
		if(lrList.size()==0) {
			jsonMap.put("message", "no");
			jsonMap.put("info", "�������޵�");
		}
		else {
			jsonMap.put("message", "ok");
			jsonMap.put("data", lrList);
		}
		return jsonMap;
	}
	
	@RequestMapping(value="/selectVipList")
	@ResponseBody
	public Map<String, Object> selectVipList(Integer orderFlag,String order,Integer likeFlag,String tradeId,Integer start,Integer end,Double myLatitude,Double myLongitude) {
		
		//https://www.cnblogs.com/wenBlog/p/11131182.html
		Map<String, Object> jsonMap = new HashMap<String, Object>();
		List<ShareVip> svList=shareVipService.selectVipList(orderFlag,order,likeFlag,tradeId,start,end,myLatitude,myLongitude);
		
		if(svList.size()==0) {
			jsonMap.put("message", "no");
		}
		else {
			jsonMap.put("message", "ok");
			jsonMap.put("data", svList);
		}
		return jsonMap;
	}

	@RequestMapping(value="/selectMyAddShareVipList")
	@ResponseBody
	public Map<String, Object> selectMyAddShareVipList(Integer type, String openId) {

		Map<String, Object> jsonMap = new HashMap<String, Object>();
		List<ShareVip> svList=shareVipService.selectMyAddShareVipList(type,openId);
		
		if(svList.size()==0) {
			jsonMap.put("message", "no");
		}
		else {
			jsonMap.put("message", "ok");
			jsonMap.put("data", svList);
		}
		return jsonMap;
	}

	@RequestMapping(value="/selectMyCancelSRList")
	@ResponseBody
	public Map<String, Object> selectMyCancelSRList(String openId) {

		Map<String, Object> jsonMap = new HashMap<String, Object>();
		List<CapitalFlowRecord> cfrList=shareVipService.selectMyCancelSRList(openId);
		
		if(cfrList.size()==0) {
			jsonMap.put("message", "no");
		}
		else {
			jsonMap.put("message", "ok");
			jsonMap.put("data", cfrList);
		}
		return jsonMap;
	}

	@RequestMapping(value="/selectKzSRListByVipId")
	@ResponseBody
	public Map<String, Object> selectKzSRListByVipId(String vipId, String openId) {

		Map<String, Object> jsonMap = new HashMap<String, Object>();
		List<ShareRecord> kzSRList=shareRecordService.selectKzSRListByVipId(vipId,openId);
		
		if(kzSRList.size()==0) {
			jsonMap.put("message", "no");
		}
		else {
			jsonMap.put("message", "ok");
			jsonMap.put("data", kzSRList);
		}
		return jsonMap;
	}
	
	@RequestMapping(value="/selectKzSHRListByVipId")
	@ResponseBody
	public Map<String, Object> selectKzSHRListByVipId(String vipId, String openId) {
		
		Map<String, Object> jsonMap = new HashMap<String, Object>();
		List<ShareHistoryRecord> kzSHRList=shareHistoryRecordService.selectKzSHRListByVipId(vipId,openId);
		
		if(kzSHRList.size()==0) {
			jsonMap.put("message", "no");
		}
		else {
			jsonMap.put("message", "ok");
			jsonMap.put("data", kzSHRList);
		}
		return jsonMap;
	}

	@RequestMapping(value="/confirmConsumeShare")
	@ResponseBody
	public Map<String, Object> confirmConsumeShare(String uuid) {

		Map<String, Object> jsonMap = new HashMap<String, Object>();
		ShareRecord sr=shareRecordService.getShareRecordByUuid(uuid);
		
		ShareHistoryRecord shr=new ShareHistoryRecord();
		shr.setUuid(uuid);
		shr.setVipId(sr.getVipId());
		String kzOpenId = sr.getKzOpenId();
		shr.setKzOpenId(kzOpenId);
		shr.setFxzOpenId(sr.getFxzOpenId());
		Float shareMoney = sr.getShareMoney();
		shr.setShareMoney(shareMoney);
		shr.setPhone(sr.getPhone());
		shr.setYgxfDate(sr.getYgxfDate());
		int count=shareHistoryRecordService.addShareHistoryRecord(shr);
		count=shareRecordService.deleteShareRecordByUuid(uuid);
		
		count=shareVipService.confirmConsumeShare(sr);
		if(count==0) {
			jsonMap.put("status", "no");
			jsonMap.put("message", "ȷ������ʧ�ܣ�");
		}
		else {
			jsonMap.put("status", "ok");
			jsonMap.put("message", "��ȷ�����ѣ�");
		}
		return jsonMap;
	}

	@RequestMapping(value="/deleteCFRByUuid")
	@ResponseBody
	public Map<String, Object> deleteCFRByUuid(String srUuid) {

		Map<String, Object> jsonMap = new HashMap<String, Object>();
		int count=capFlowRecService.deleteCFRByUuid(srUuid);
		if(count==0) {
			jsonMap.put("status", "no");
		}
		else {
			jsonMap.put("status", "ok");
		}
		return jsonMap;
	}

	@RequestMapping(value="/addShareVip",produces="plain/text; charset=UTF-8")
	@ResponseBody
	public String addShareVip(ShareVip shareVip) {
		
		PlanResult plan=new PlanResult();
		String json;
		int count=shareVipService.addShareVip(shareVip);
		if(count==0) {
			plan.setStatus(0);
			plan.setMsg("��ӹ����Աʧ�ܣ�");
			json=JsonUtil.getJsonFromObject(plan);
		}
		else {
			plan.setStatus(1);
			plan.setMsg("��ӹ����Ա�ɹ���");
			json=JsonUtil.getJsonFromObject(plan);
		}
		return json;
	}

	@RequestMapping(value="/deleteLeaseVipByIds",produces="plain/text; charset=UTF-8")
	@ResponseBody
	public String deleteLeaseVipByIds(String ids) {

		PlanResult plan=new PlanResult();
		String json;
		int count=leaseVipService.deleteLeaseVipByIds(ids);
		if(count==0) {
			plan.setStatus(0);
			plan.setMsg("ɾ��������Ϣʧ�ܣ�");
			json=JsonUtil.getJsonFromObject(plan);
		}
		else {
			plan.setStatus(1);
			plan.setMsg("ɾ��������Ϣ�ɹ���");
			json=JsonUtil.getJsonFromObject(plan);
		}
		return json;
	}

	@RequestMapping(value="/merchantCheck")
	@ResponseBody
	public Map<String, Object> merchantCheck(String openId) {

		Map<String, Object> jsonMap = new HashMap<String, Object>();
		
		boolean bool=userService.merchantCheck(openId);
		if(bool) {
			jsonMap.put("status", "ok");
		}
		else {
			jsonMap.put("status", "no");
			jsonMap.put("message", "�������̼���Ϣ");
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
		String url=basePath+"vip/toQrcodeInfo?openId="+sr.getKzOpenId()+"&uuid="+uuid;
		String fileName = new SimpleDateFormat("yyyyMMddHHmmss").format(new Date()) + ".jpg";
		String avaPath="/CqgVipShare/upload/"+fileName;
		//String path = "D:/resource/CqgVipShare";
		String path = "C:/resource/CqgVipShare";
        Qrcode.createQrCode(url, path, fileName);

        sr.setUuid(uuid);
		sr.setQrcodeUrl(avaPath);
        int count=shareRecordService.addShareRecord(sr);
        if(count==0) {
        	jsonMap.put("status", "no");
        	jsonMap.put("message", "����ʧ�ܣ�");
        }
        else {
        	jsonMap.put("status", "ok");
        	jsonMap.put("qrcodeUrl", avaPath);
        }
		return jsonMap;
	}

	@RequestMapping(value="/addLeaseVip")
	@ResponseBody
	public Map<String, Object> addLeaseVip(LeaseVip lv) {

		Map<String, Object> jsonMap = new HashMap<String, Object>();
		int count=leaseVipService.addLeaseVip(lv);
        if(count==0) {
        	jsonMap.put("status", "no");
        	jsonMap.put("message", "���ʧ�ܣ�");
        }
        else {
        	jsonMap.put("status", "ok");
        	jsonMap.put("message", "��ӳɹ���");
        }
		return jsonMap;
	}
	
	@RequestMapping(value="/addLeaseRecord")
	@ResponseBody
	public Map<String, Object> addLeaseRecord(LeaseRecord lr) {
		
		Map<String, Object> jsonMap = new HashMap<String, Object>();
		int count=leaseRecordService.addLeaseRecord(lr);
		if(count==0) {
			jsonMap.put("status", "no");
			jsonMap.put("message", "���ʧ�ܣ�");
		}
		else {
			jsonMap.put("status", "ok");
			jsonMap.put("message", "��ӳɹ���");
		}
		return jsonMap;
	}

	@RequestMapping(value="/addComment")
	@ResponseBody
	public Map<String, Object> addComment(Message message) {

		Map<String, Object> jsonMap = new HashMap<String, Object>();
		int count=messageService.addComment(message);
		if(count==0) {
			jsonMap.put("status", "no");
			jsonMap.put("message", "����ʧ�ܣ�");
		}
		else {
			jsonMap.put("status", "ok");
			jsonMap.put("message", "���۳ɹ���");
		}
		return jsonMap;
	}

	@RequestMapping(value="/editMerchant",produces="plain/text; charset=UTF-8")
	@ResponseBody
	public String editMerchant(User user,@RequestParam(value="uploadImg_inp",required=false) MultipartFile uploadImg_inp,HttpServletRequest request) {

		String json=null;;
		try {
			PlanResult plan=new PlanResult();
			if(uploadImg_inp.getSize()>0) {
				String jsonStr = FileUploadUtils.appUploadContentImg(request,uploadImg_inp,"");
				JSONObject fileJson = JSONObject.fromObject(jsonStr);
				if("�ɹ�".equals(fileJson.get("msg"))) {
					JSONObject dataJO = (JSONObject)fileJson.get("data");
					user.setLogo(dataJO.get("src").toString());
				}
			}
			int count=userService.editMerchant(user);
			if(count==0) {
				plan.setStatus(0);
				plan.setMsg("�̼���Ϣ����ʧ�ܣ�");
				json=JsonUtil.getJsonFromObject(plan);
			}
			else {
				plan.setStatus(1);
				plan.setMsg("�̼���Ϣ�����ƣ��ȴ���ˣ�");
				json=JsonUtil.getJsonFromObject(plan);
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return json;
	}
	
	@RequestMapping(value="/enterMenu")
	public void enterMenu(HttpServletRequest request,HttpServletResponse response) throws IOException {

		System.out.println("in.....");
		ServletInputStream in = null;
		try {
			in = request.getInputStream();
		} catch (IOException e) {
			e.printStackTrace();
		}
		// ��POST��ת��ΪXStream����
		XStream xs = new XStream(new DomDriver());
		// ��ָ���ڵ��µ�xml�ڵ�����ӳ��Ϊ����
		xs.alias("xml", InputMessage.class);
		// ����ת��Ϊ�ַ���
		StringBuilder xmlMsg = new StringBuilder();
		byte[] b = new byte[4096];
		try {
			for (int n; (n = in.read(b)) != -1;) {
				xmlMsg.append(new String(b, 0, n, "UTF-8"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		System.out.println("xmlMsg=" + xmlMsg.toString());
		
		if (StringUtils.isEmpty(xmlMsg.toString())) {
			// ���ñ���
			request.setCharacterEncoding("utf-8");
			response.setContentType("html/text;charset=utf-8");
			response.setCharacterEncoding("utf-8");
			// ��ȡ�����
			PrintWriter printWriter = response.getWriter();

			// ����һ��ȫ�ֵ�token,�������Լ����á�api�������ͣ�Token���ɿ����߿���������д��
			// ��������ǩ������Token��ͽӿ�URL�а�����Token���бȶԣ��Ӷ���֤��ȫ�ԣ�
			String token = "cqgvs";
			// ����api˵������ȡ�����ĸ�����
			String signature = request.getParameter("signature");
			String timestamp = request.getParameter("timestamp");
			String nonce = request.getParameter("nonce");
			String echostr = request.getParameter("echostr");
			
			System.out.println("signature======="+signature);
			System.out.println("timestamp======="+timestamp);
			System.out.println("nonce======="+nonce);
			System.out.println("echostr======="+echostr);
			
			// // temp:��ʱ��ӡ���ۿ����ز������
			// System.out.println(TAG + ":signature:" + signature +
			// ",timestamp:"
			// + timestamp + ",nonce:" + nonce + ",echostr:" + echostr);
			// ����api��˵�ġ�����/У�����̡����н��롣��������

			// ��һ��:��token��timestamp��nonce�������������ֵ�������
			String[] parms = new String[] { token, timestamp, nonce };// ����Ҫ�ֵ������е��ַ����ŵ�������
			Arrays.sort(parms);// ����apiҪ������ֵ�������
			// �ڶ���:�����������ַ���ƴ�ӳ�һ���ַ�������sha1����
			// ƴ���ַ���
			String parmsString = "";// ע�⣬�˴�����=null��
			for (int i = 0; i < parms.length; i++) {
				parmsString += parms[i];
			}
			// sha1����
			String mParms = null;// ���ܺ�Ľ��
			MessageDigest digest = null;
			try {
				digest = java.security.MessageDigest.getInstance("SHA");
			} catch (NoSuchAlgorithmException e) {
				e.printStackTrace();
			}
			digest.update(parmsString.getBytes());
			byte messageDigest[] = digest.digest();
			// Create Hex String
			StringBuffer hexString = new StringBuffer();
			// �ֽ�����ת��Ϊ ʮ������ ��
			for (int i = 0; i < messageDigest.length; i++) {
				String shaHex = Integer.toHexString(messageDigest[i] & 0xFF);
				if (shaHex.length() < 2) {
					hexString.append(0);
				}
				hexString.append(shaHex);
			}
			mParms = hexString.toString();// ���ܽ��

			/*
			 * apiҪ�� ��ȷ�ϴ˴�GET��������΢�ŷ���������ԭ������echostr�������ݣ� �������Ч�� ��Ϊ�����߳ɹ����������ʧ�ܡ�
			 */
			// �������� �����߻�ü��ܺ���ַ�������signature�Աȣ���ʶ��������Դ��΢�Ž���ɹ���
			System.out.println(TAG + ":" + mParms + "---->" + signature);
			if (mParms.equals(signature)) {
				// System.out.println(TAG + ":" + mParms + "---->" + signature);
				printWriter.write(echostr);
			} else {
				// ����ʧ��,���û�д
				System.out.println(TAG + "����ʧ��");
			}
		}
		else{
		
			System.out.println("1111111111111");
			// ��xml����ת��ΪInputMessage����
			InputMessage inputMsg = (InputMessage) xs.fromXML(xmlMsg.toString());
			// ȡ����Ϣ����
			// String msgType = inputMsg.getMsgType();
			// ������Ϣ���ͻ�ȡ��Ӧ����Ϣ����
			// �ı���Ϣ
			System.out.println("������΢�źţ�" + inputMsg.getToUserName());
			System.out.println("���ͷ��ʺţ�" + inputMsg.getFromUserName());
			System.out.println("��Ϣ����ʱ�䣺" + inputMsg.getCreateTime());
			System.out.println("��Ϣ���ݣ�" + inputMsg.getContent());
			System.out.println("��ϢId��" + inputMsg.getMsgId());
			System.out.println("key��" + inputMsg.getEventKey());
			
			String openId = inputMsg.getFromUserName();
			boolean bool=shareVipService.checkUserExist(openId);
			if(!bool) {
				Map<String, String> userMap = queryUserFromApi(openId,APPID,SECRET);
				User user=new User();
				user.setOpenId(openId);
				user.setNickName(userMap.get("nickname"));
				user.setHeadImgUrl(userMap.get("headimgurl"));
				shareVipService.addUser(user);
			}
			String eventKey = inputMsg.getEventKey();
			if("Share_Index".equals(eventKey)) {
				List<Article> articles = new ArrayList<Article>();
				Article a = new Article();
				a.setTitle("��ҳ");
				a.setUrl(MCARDGX+"/CqgVipShare/vip/toIndex?openId="+openId);// �õ�ַ�ǵ��ͼƬ��ת��
				a.setPicUrl(MCARDGX+"/CqgVipShare/resource/image/001.png");// �õ�ַ��һ����Ч��ͼƬ��ַ
				a.setDescription("�������>>");
				articles.add(a);
				PicAndTextMsg picAndTextMsg = new PicAndTextMsg();
				picAndTextMsg.setToUserName(inputMsg.getFromUserName());// ���ͺͽ�����Ϣ��User���պ��෴
				picAndTextMsg.setFromUserName(inputMsg.getToUserName());
				picAndTextMsg.setCreateTime(new Date().getTime());// ��Ϣ����ʱ�� �����ͣ�
				picAndTextMsg.setMsgType("news");// ͼ��������Ϣ
				picAndTextMsg.setArticleCount(1);
				picAndTextMsg.setArticles(articles);
				// �ڶ��������������Ϣת��Ϊ΢��ʶ���xml��ʽ
				XStream xStream = new XStream();
				xStream.alias("xml", picAndTextMsg.getClass());
				xStream.alias("item", a.getClass());
				String picAndTextMsg2Xml = xStream.toXML(picAndTextMsg);
				System.out.println(picAndTextMsg2Xml);
				// ������������xml�ĸ�ʽ��Ϣ��΢�ŷ�������������ת�����û�
				PrintWriter printWriter = response.getWriter();
				printWriter.print(picAndTextMsg2Xml);
			}
			else if("Add_Share".equals(eventKey)) {
				List<Article> articles = new ArrayList<Article>();
				Article a = new Article();
				a.setTitle("��������");
				a.setUrl(MCARDGX+"/CqgVipShare/vip/toAddVip?openId="+openId);// �õ�ַ�ǵ��ͼƬ��ת��
				a.setPicUrl(MCARDGX+"/CqgVipShare/resource/image/001.png");// �õ�ַ��һ����Ч��ͼƬ��ַ
				a.setDescription("�������>>");
				articles.add(a);
				PicAndTextMsg picAndTextMsg = new PicAndTextMsg();
				picAndTextMsg.setToUserName(inputMsg.getFromUserName());// ���ͺͽ�����Ϣ��User���պ��෴
				picAndTextMsg.setFromUserName(inputMsg.getToUserName());
				picAndTextMsg.setCreateTime(new Date().getTime());// ��Ϣ����ʱ�� �����ͣ�
				picAndTextMsg.setMsgType("news");// ͼ��������Ϣ
				picAndTextMsg.setArticleCount(1);
				picAndTextMsg.setArticles(articles);
				// �ڶ��������������Ϣת��Ϊ΢��ʶ���xml��ʽ
				XStream xStream = new XStream();
				xStream.alias("xml", picAndTextMsg.getClass());
				xStream.alias("item", a.getClass());
				String picAndTextMsg2Xml = xStream.toXML(picAndTextMsg);
				System.out.println(picAndTextMsg2Xml);
				// ������������xml�ĸ�ʽ��Ϣ��΢�ŷ�������������ת�����û�
				PrintWriter printWriter = response.getWriter();
				printWriter.print(picAndTextMsg2Xml);
			}
			else if("Merchant_Check".equals(eventKey)) {
				List<Article> articles = new ArrayList<Article>();
				Article a = new Article();
				a.setTitle("�̼���֤");
				a.setUrl(MCARDGX+"/CqgVipShare/vip/toScan?openId="+openId);// �õ�ַ�ǵ��ͼƬ��ת��
				a.setPicUrl(MCARDGX+"/CqgVipShare/resource/image/001.png");// �õ�ַ��һ����Ч��ͼƬ��ַ
				a.setDescription("�������>>");
				articles.add(a);
				PicAndTextMsg picAndTextMsg = new PicAndTextMsg();
				picAndTextMsg.setToUserName(inputMsg.getFromUserName());// ���ͺͽ�����Ϣ��User���պ��෴
				picAndTextMsg.setFromUserName(inputMsg.getToUserName());
				picAndTextMsg.setCreateTime(new Date().getTime());// ��Ϣ����ʱ�� �����ͣ�
				picAndTextMsg.setMsgType("news");// ͼ��������Ϣ
				picAndTextMsg.setArticleCount(1);
				picAndTextMsg.setArticles(articles);
				// �ڶ��������������Ϣת��Ϊ΢��ʶ���xml��ʽ
				XStream xStream = new XStream();
				xStream.alias("xml", picAndTextMsg.getClass());
				xStream.alias("item", a.getClass());
				String picAndTextMsg2Xml = xStream.toXML(picAndTextMsg);
				System.out.println(picAndTextMsg2Xml);
				// ������������xml�ĸ�ʽ��Ϣ��΢�ŷ�������������ת�����û�
				PrintWriter printWriter = response.getWriter();
				printWriter.print(picAndTextMsg2Xml);
			}
		}
	}
	
	/**
	 * ��ȡ΢���û���Ϣ
	 * @param appID 
	 * @param appSecret 
	 * @return 
	 */
	public static Map<String, String> queryUserFromApi(String openid, String appID, String appSecret){
		
		/*
		ApplicationContext ac = new ClassPathXmlApplicationContext("spring-mvc.xml");
		MPWeixinDaoImp mpWeixinDao = (MPWeixinDaoImp) ac.getBean("MPWeixinDao");
		*/
		
		/**
		 * ��ȡaccess_tokenֵ
		 */
		String access_token = "";
		System.out.println("openID==========="+openid);
		System.out.println("appID==========="+appID);
		System.out.println("appSecret==========="+appSecret);
		String tokenUrl = "https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid=" + appID + "&secret=" + appSecret;
		TenpayHttpClient httpClientToken = new TenpayHttpClient();																
		httpClientToken.setMethod("GET");
		httpClientToken.setReqContent(tokenUrl);
		if (httpClientToken.call()) {
		    System.out.println("��ȡtoken�ɹ�");
			String resContent = httpClientToken.getResContent();
			System.out.println("resContent��" + resContent);
			//access_token = JsonUtil.getJsonValue(resContent, "access_token");
			access_token = new org.json.JSONObject(resContent).getString("access_token");
			System.out.println("token��" + access_token);
		}
		System.out.println("��ȡ��tokenֵΪ:" + access_token);
		
		
		/**
		 * ��ȡ�û���Ϣ
		 */
		String nickname = "";
		String headimgurl = "";
		String userInfoUrl = "https://api.weixin.qq.com/cgi-bin/user/info?access_token=" + access_token + "&openid=" + openid + "&lang=zh_CN";
		TenpayHttpClient httpClientUser = new TenpayHttpClient();																
		httpClientUser.setMethod("GET");
		httpClientUser.setReqContent(userInfoUrl);
        if (httpClientUser.call()) {
            System.out.println("��ȡ�û���Ϣ�ɹ�");
            String resContent = httpClientUser.getResContent();
            System.out.println("resContent��" + resContent);
            /*
            nickname = JsonUtil.getJsonValue(resContent, "nickname");
            headimgurl = JsonUtil.getJsonValue(resContent, "headimgurl");
            */
            org.json.JSONObject rsJO = new org.json.JSONObject(resContent);
            nickname = rsJO.getString("nickname");
            headimgurl = rsJO.getString("headimgurl");
        }
        Map<String, String> jsonMap = new HashMap<String, String>();
        jsonMap.put("openid", openid);
        jsonMap.put("nickname", nickname);
        jsonMap.put("headimgurl", headimgurl);
        return jsonMap;
	}

	@RequestMapping(value="/queryUserFromDB")
	@ResponseBody
	public Map<String, Object> queryUserFromDB(String openId) {

		Map<String, Object> jsonMap = new HashMap<String, Object>();
		User user = userService.getUserInfoByOpenId(openId);
		
        jsonMap.put("user", user);
        
        return jsonMap;
	}
	
	@RequestMapping(value="/editWeixinMenu")
	@ResponseBody
	public Map<String, Object> editWeixinMenu(String appid, String appsecret) {

		Map<String, Object> jsonMap = new HashMap<String, Object>();
		
		//http://localhost:8080/CqgVipShare/vip/editWeixinMenu?appid=APPID&appsecret=SECRET
		//String viewUrl1="https://open.weixin.qq.com/connect/oauth2/authorize?appid=APPID&redirect_uri=http://www.mcardgx.com:8080/CqgVipShare/vip/goPageFromWXMenu?goPage=";
		//String viewUrl2="&response_type=code&scope=snsapi_base&state=1&connect_redirect=1#wechat_redirect";
		String viewUrl="http://www.mcardgx.com:8080/CqgVipShare/vip/goPageFromWXMenu?goPage=";
		WeChatUtil weChatUtil = new WeChatUtil();
		//String jsonMenu = "{\"button\":[{\"type\":\"view\",\"name\":\"������ҳ1\",\"url\":\""+viewUrl1+"toIndex"+viewUrl2+"\"},";
		String jsonMenu = "{\"button\":[{\"type\":\"view\",\"name\":\"������ҳ\",\"url\":\""+viewUrl+"toIndex\"},";
			jsonMenu+="{\"type\":\"view\",\"name\":\"��������\",\"url\":\""+viewUrl+"toTradeList\"},";
			jsonMenu+="{\"type\":\"view\",\"name\":\"�̼���֤\",\"url\":\""+viewUrl+"toScan\"}";
			jsonMenu+="]}";
		int count = weChatUtil.createMenu(appid, appsecret, jsonMenu);
		System.out.println("count==="+count);
		if(count==0){
			jsonMap.put("message", "no");
			jsonMap.put("info", "���ʵappidֵ��appsecretֵ�Ƿ���ȷ��");
		}else{
			jsonMap.put("message", "ok");
			jsonMap.put("info", "���ں��ύ�ɹ���");
		}
		return jsonMap;
	}

	@RequestMapping(value="/selectShopList")
	@ResponseBody
	public Map<String, Object> selectShopList(String tradeId) {

		Map<String, Object> jsonMap = new HashMap<String, Object>();
		List<User> hotList=userService.selectHotShopList(tradeId);
		List<User> moreList=userService.selectMoreShopList(tradeId);
		jsonMap.put("hotList", hotList);
		jsonMap.put("moreList", moreList);
		return jsonMap;
	}

	@RequestMapping(value="/canncelShareVip")
	@ResponseBody
	public Map<String, Object> canncelShareVip(String srUuid, String content, String fxzOpenId) {

		Map<String, Object> jsonMap = new HashMap<String, Object>();
		int count=capFlowRecService.canncelShareVip(srUuid,content,fxzOpenId);
		if(count==0) {
			jsonMap.put("status", "no");
			jsonMap.put("message", "ȡ��ʧ�ܣ�");
		}
		else {
			jsonMap.put("status", "ok");
			jsonMap.put("message", "ȡ���ɹ���������ȷ�ϣ�");
		}
		return jsonMap;
	}

	@RequestMapping(value="/confirmCanShareVip")
	@ResponseBody
	public Map<String, Object> confirmCanShareVip(String srUuid) {

		Map<String, Object> jsonMap = new HashMap<String, Object>();
		int count=capFlowRecService.confirmCanShareVip(srUuid);
		if(count==0) {
			jsonMap.put("status", "no");
			jsonMap.put("message", "ȷ��ȡ��ʧ�ܣ�");
		}
		else {
			jsonMap.put("status", "ok");
			jsonMap.put("message", "ȷ��ȡ���ɹ���");
		}
		return jsonMap;
	}
	
	//https://blog.csdn.net/quyan2017/article/details/85720680
	@RequestMapping(value="/aliPay")
	public void aliPay(HttpServletRequest request, HttpServletResponse response) {
		try {
			AlipayClient alipayClient = new DefaultAlipayClient(AlipayConfig.URL,AlipayConfig.APPID,AlipayConfig.RSA_PRIVATE_KEY, "json", "UTF-8", AlipayConfig.ALIPAY_PUBLIC_KEY, "RSA2");
			AlipayTradeWapPayRequest alipayRequest = new AlipayTradeWapPayRequest();
			JSONObject order = new JSONObject();
			order.put("out_trade_no", "23242345rfg34534fertgedf");
			order.put("subject", "songSir֧��");
			order.put("product_code", "QUICK_WAP_WAY");
			order.put("body", "��ͯӾװ|Ӿ��");
			order.put("total_amount", "0.01");
			order.put("subject", "������ͯƽ��Ӿ��");
			alipayRequest.setBizContent(order.toString());
			//�ڹ������������û�����֪ͨ��ַ
			alipayRequest.setNotifyUrl(AlipayConfig.NOTIFY_URL);
			alipayRequest.setReturnUrl(AlipayConfig.RETURN_URL);
			String form = alipayClient.pageExecute(alipayRequest).getBody();
			response.setContentType("text/html;charset=utf-8");
			response.getWriter().write(form);
			response.getWriter().flush();
			response.getWriter().close();
		} catch (AlipayApiException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	@RequestMapping(value="/goPageFromWXMenu")
	public String goPageFromWXMenu(HttpServletRequest request) {
		
		System.out.println("goPageFromWXMenu...");
		String url=null;
		String goPage = request.getParameter("goPage");
		String code = request.getParameter("code");
		System.out.println("code==="+code);
		HttpSession session = request.getSession();
		Object openIdObj = session.getAttribute("openId");
		String openId = null;
		if(openIdObj==null&&StringUtils.isEmpty(code)) {
			url="redirect:https://open.weixin.qq.com/connect/oauth2/authorize?appid="+APPID+"&redirect_uri=http://www.mcardgx.com/getCode.asp?params="+goPage+"&response_type=code&scope=snsapi_base&state=1&connect_redirect=1#wechat_redirect";
		}
		else if(openIdObj!=null&&StringUtils.isEmpty(code)) {
			openId = openIdObj.toString();
			System.out.println("openId======"+openId);
			url=getWXMenuRedirectUrl(goPage,openId);
		}
		else{//openIdObj==null&&code!=null
			JSONObject obj = JSONObject.fromObject(MethodUtil.httpRequest("https://api.weixin.qq.com/sns/oauth2/access_token?appid="+APPID+"&secret="+SECRET+"&code="+code+"&grant_type=authorization_code"));
			System.out.println("obj==="+obj.toString());
			openId = obj.getString("openid");
			session.setAttribute("openId", openId);
			System.out.println("openId======"+openId);
			url=getWXMenuRedirectUrl(goPage,openId);
		}
		return url;
	}
	
	public String getWXMenuRedirectUrl(String goPage, String openId) {
		String params="openId="+openId;
		if("toTradeList".equals(goPage)) {
			params+="&action=addShareVip";
		}
		return "redirect:http://www.mcardgx.com:8080/CqgVipShare/vip/"+goPage+"?"+params;
	}
	
	public static void main(String[] args) {
		
	}

}
