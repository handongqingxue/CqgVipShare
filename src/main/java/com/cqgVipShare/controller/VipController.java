package com.cqgVipShare.controller;

import java.io.BufferedOutputStream;
import java.io.BufferedWriter;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.security.PublicKey;
import java.security.cert.CertificateException;
import java.security.cert.CertificateFactory;
import java.security.cert.X509Certificate;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.SortedMap;
import java.util.TreeMap;
import java.util.UUID;

import javax.servlet.ServletException;
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
import com.alipay.api.request.AlipayFundTransToaccountTransferRequest;
import com.alipay.api.request.AlipayFundTransUniTransferRequest;
import com.alipay.api.request.AlipayTradePagePayRequest;
import com.alipay.api.request.AlipayTradeWapPayRequest;
import com.alipay.api.response.AlipayFundTransUniTransferResponse;
import com.cqgVipShare.entity.*;
import com.cqgVipShare.service.*;
import com.cqgVipShare.util.*;
import com.cqgVipShare.util.qrcode.Qrcode;
import com.cqgVipShare.util.wxpay.sdk.HLWXPayConfig;
import com.cqgVipShare.util.wxpay.sdk.HttpRequest;
import com.cqgVipShare.util.wxpay.sdk.WXPay;
import com.cqgVipShare.util.wxpay.sdk.WXPayUtil;
import com.jpay.ext.kit.IpKit;
import com.jpay.ext.kit.PaymentKit;
import com.jpay.ext.kit.StrKit;
import com.jpay.weixin.api.WxPayApi;
import com.jpay.weixin.api.WxPayApiConfig;
import com.jpay.weixin.api.WxPayApiConfigKit;
import com.jpay.weixin.api.WxPayApi.TradeType;
import com.jpay.weixin.api.WxPayApiConfig.PayModel;
import com.thoughtworks.xstream.XStream;
import com.thoughtworks.xstream.io.xml.DomDriver;

import cn.hutool.core.io.FileUtil;
import cn.hutool.extra.qrcode.QrCodeUtil;
import net.sf.json.JSONObject;
import sun.misc.BASE64Encoder;

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
http://download.eclipse.org/recommenders/models/oxygen/
΢��sdk�ӿ��б�https://developers.weixin.qq.com/doc/offiaccount/OA_Web_Apps/JS-SDK.html
΢�����ֽӿڣ�https://www.bilibili.com/video/av97054866/
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
	@Autowired
	private NotifyUrlParamService notifyUrlParamService;
	private SimpleDateFormat cfrIdSDF=new SimpleDateFormat("yyyyMMddHHmmss");
	
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

	@RequestMapping(value="/toBindAlipay")
	public String toBindAlipay(String openId, HttpServletRequest request) {

		User user=userService.getUserInfoByOpenId(openId);
		request.setAttribute("user", user);
		
		return "/vip/bindAlipay";
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
		
		Float ccPercent=tradeService.getCcPercentByShrUuid(uuid);
		Float ccpMoney = shareMoney*ccPercent/100;
		System.out.println("ccpMoney==="+ccpMoney);
		Float kzShareMoney=shareMoney-ccpMoney;
		
		count=shareVipService.confirmConsumeShare(sr);
		if(count>0) {
			count=userService.updateWithDrawMoneyByOpenId(kzShareMoney,kzOpenId);
		}
		
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
	
	//https://blog.csdn.net/qq_26101151/article/details/53433380
	@RequestMapping(value="/addShareRecord")
	@ResponseBody
	public Map<String, Object> addShareRecord(ShareRecord sr, HttpServletRequest request) throws Exception{
		
        String resXml = "";
        Map<String, String> backxml = new HashMap<String, String>();
 
 
        InputStream inStream;
            inStream = request.getInputStream();
 
 
            ByteArrayOutputStream outSteam = new ByteArrayOutputStream();
            byte[] buffer = new byte[1024];
            int len = 0;
            while ((len = inStream.read(buffer)) != -1) {
                outSteam.write(buffer, 0, len);
            }
            System.out.println("΢��֧��----����ɹ�----");
            outSteam.close();
            inStream.close();
            String result = new String(outSteam.toByteArray(), "utf-8");// ��ȡ΢�ŵ�������notify_url�ķ�����Ϣ
            System.out.println("΢��֧��----result----=" + result);
            Map<String, String> map = WXPayUtil.xmlToMap(result);
            
            if (map.get("result_code").toString().equalsIgnoreCase("SUCCESS")) {
            	System.out.println("΢��֧��----���سɹ�");
                //if (verifyWeixinNotify(map)) {
                    // �������� ���� orderconroller �Ļ�д����?
                    //logger.error("΢��֧��----��֤ǩ���ɹ�");
                    // backxml.put("return_code", "<![CDATA[SUCCESS]]>");
                    // backxml.put("return_msg", "<![CDATA[OK]]>");
                    // // ����΢�ŷ����������յ���Ϣ�ˣ���Ҫ�ڵ��ûص�action��
                    // strbackxml = pay.ArrayToXml(backxml);
                    // response.getWriter().write(strbackxml);
                    // logger.error("΢��֧�� ~~~~~~~~~~~~~~~~ִ����ϣ�backxml=" +
                    // strbackxml);
            	System.out.println("΢��֧���ص����޸ĵĶ���=" + map.get("out_trade_no"));
 
 
                    // ====================================================================
                    // ֪ͨ΢��.�첽ȷ�ϳɹ�.��д.��Ȼ��һֱ֪ͨ��̨.�˴�֮�����Ϊ����ʧ����.
                    resXml = "<xml>" + "<return_code><![CDATA[SUCCESS]]></return_code>"
                            + "<return_msg><![CDATA[OK]]></return_msg>" + "</xml> ";
 
            }
            

		String uuid=request.getParameter("uuid");
		System.out.println("addShareRecord........");
		Map<String, Object> jsonMap = new HashMap<String, Object>();
		
		String basePath=request.getScheme()+"://"+request.getServerName()+":"
				+request.getServerPort()+request.getContextPath()+"/";
		
		/*
		NotifyUrlParam nup=notifyUrlParamService.getByUuid(uuid);
		ShareRecord sr = new ShareRecord();
		sr.setUuid(uuid);
		sr.setVipId(nup.getVipId());
		sr.setKzOpenId(nup.getKzOpenId());
		sr.setFxzOpenId(nup.getFxzOpenId());
		sr.setShareMoney(nup.getShareMoney());
		sr.setPhone(nup.getPhone());
		sr.setYgxfDate(nup.getYgxfDate());
		
		String url=basePath+"vip/toQrcodeInfo?openId="+sr.getKzOpenId()+"&uuid="+sr.getUuid();
		String fileName = new SimpleDateFormat("yyyyMMddHHmmss").format(new Date()) + ".jpg";
		String avaPath="/CqgVipShare/upload/"+fileName;
		//String path = "D:/resource/CqgVipShare";
		String path = "C:/resource/CqgVipShare";
        Qrcode.createQrCode(url, path, fileName);

		sr.setQrcodeUrl(avaPath);
        int count=shareRecordService.addShareRecord(sr);
        if(count>0) {
        	count=notifyUrlParamService.deleteByUuid(uuid);
        }
        
        if(count==0) {
        	jsonMap.put("status", "no");
        	jsonMap.put("message", "����ʧ�ܣ�");
        }
        else {
        	jsonMap.put("status", "ok");
        	jsonMap.put("qrcodeUrl", avaPath);
        }
        */
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

	@RequestMapping(value="/bindAlipay",produces="plain/text; charset=UTF-8")
	@ResponseBody
	public String bindAlipay(User user) {

		String json=null;;
		try {
			PlanResult plan=new PlanResult();
			int count=userService.bindAlipay(user);
			if(count==0) {
				plan.setStatus(0);
				plan.setMsg("��֧����ʧ�ܣ�");
				json=JsonUtil.getJsonFromObject(plan);
			}
			else {
				plan.setStatus(1);
				plan.setMsg("��֧�����ɹ���");
				json=JsonUtil.getJsonFromObject(plan);
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return json;
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
	
	/**
	 * ֧����֧��
	 * �ο����ӣ�https://blog.csdn.net/quyan2017/article/details/85720680
	 * ֧����֧����ش���:https://blog.csdn.net/weixin_41357729/article/details/80419742
	 * @param request
	 * @param response
	 */
	@RequestMapping(value="/alipay")
	public void alipay(ShareRecord sr, HttpServletRequest request, HttpServletResponse response) {
		try {
			System.out.println("alipay....");
			System.out.println("APPID==="+AlipayConfig.APPID);
			String uuid = UUID.randomUUID().toString().replaceAll("-", "");
			AlipayClient alipayClient = new DefaultAlipayClient(AlipayConfig.URL,AlipayConfig.APPID,AlipayConfig.RSA_PRIVATE_KEY, AlipayConfig.FORMAT, AlipayConfig.CHARSET, AlipayConfig.ALIPAY_PUBLIC_KEY, AlipayConfig.SIGNTYPE);
			AlipayTradeWapPayRequest alipayRequest = new AlipayTradeWapPayRequest();
			
			//�̻������ţ��̻���վ����ϵͳ��Ψһ�����ţ�����
			String out_trade_no = cfrIdSDF.format(new Date());
			//���������
			String total_amount = "0.01";
			//�������ƣ�����
			String subject = "aaa";
			//��Ʒ�������ɿ�
			String body = "";

			JSONObject order = new JSONObject();
			order.put("out_trade_no", out_trade_no);
			order.put("subject", subject);
			order.put("product_code", "QUICK_WAP_WAY");
			//order.put("product_code", "FAST_INSTANT_TRADE_PAY");
			order.put("body", body);
			order.put("total_amount", total_amount);
			
			/*
			order.put("out_trade_no", "23242345rfg34534fertgedf");
			order.put("subject", "������ͯƽ��Ӿ��");
			order.put("product_code", "QUICK_WAP_WAY");
			order.put("body", "��ͯӾװ|Ӿ��");
			order.put("total_amount", "0.01");
			*/
			alipayRequest.setBizContent(order.toString());
			
			NotifyUrlParam notifyUrlParam=new NotifyUrlParam();
			notifyUrlParam.setUuid(uuid);
			notifyUrlParam.setVipId(sr.getVipId());
			notifyUrlParam.setKzOpenId(sr.getKzOpenId());
			notifyUrlParam.setFxzOpenId(sr.getFxzOpenId());
			notifyUrlParam.setShareMoney(sr.getShareMoney());
			notifyUrlParam.setPhone(sr.getPhone());
			notifyUrlParam.setYgxfDate(sr.getYgxfDate());
			int addCount=notifyUrlParamService.add(notifyUrlParam);
			if(addCount>0) {
				//�ڹ������������û�����֪ͨ��ַ
				alipayRequest.setNotifyUrl(AlipayConfig.NOTIFY_URL+"?uuid="+uuid);
				//alipayRequest.setNotifyUrl(AlipayConfig.NOTIFY_URL+"?KzOpenId="+sr.getKzOpenId()+"&fxzOpenId="+sr.getFxzOpenId()+"&phone="+sr.getPhone()+"&ygxfDate="+sr.getYgxfDate()+"&vipId="+sr.getVipId()+"&shareMoney="+sr.getShareMoney()+"&uuid="+uuid);
			}
			alipayRequest.setReturnUrl(AlipayConfig.RETURN_URL+"?uuid="+uuid);
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

	//https://www.cnblogs.com/gopark/p/9394951.html
	@RequestMapping(value="/wxPay")
	@ResponseBody
	public Map<String, String> wxPay(ShareRecord sr, HttpServletRequest request, HttpServletResponse response) {

		Map<String, String> payMap = new HashMap<String, String>();
		try {
			String uuid = UUID.randomUUID().toString().replaceAll("-", "");
			Map<String, String> paraMap = new HashMap<String, String>();
			
			HLWXPayConfig wxpc = new HLWXPayConfig();
			paraMap.put("appid", wxpc.getAppID());
			 
			paraMap.put("body", "aaa");
			 
			paraMap.put("mch_id", wxpc.getMchID());
			 
			paraMap.put("nonce_str", WXPayUtil.generateNonceStr());
			 
			paraMap.put("openid", "oNFEuwzkbP4OTTjBucFgBTWE5Bqg");
			HttpSession session = request.getSession();
			//paraMap.put("openid", session.getAttribute("openId").toString());
			 
			paraMap.put("out_trade_no", cfrIdSDF.format(new Date()));//������
			 
			//paraMap.put("spbill_create_ip", "124.70.38.226");
			String scIp = request.getRemoteHost();
			System.out.println("scIp==="+scIp);
			paraMap.put("spbill_create_ip", scIp);
			 
			paraMap.put("total_fee","1");
			 
			paraMap.put("trade_type", "JSAPI");


			/*
			NotifyUrlParam notifyUrlParam=new NotifyUrlParam();
			notifyUrlParam.setUuid(uuid);
			notifyUrlParam.setVipId(sr.getVipId());
			notifyUrlParam.setKzOpenId(sr.getKzOpenId());
			notifyUrlParam.setFxzOpenId(sr.getFxzOpenId());
			notifyUrlParam.setShareMoney(sr.getShareMoney());
			notifyUrlParam.setPhone(sr.getPhone());
			notifyUrlParam.setYgxfDate(sr.getYgxfDate());
			int addCount=notifyUrlParamService.add(notifyUrlParam);
			*/
			//if(addCount>0) {
				//�ڹ������������û�����֪ͨ��ַ
				paraMap.put("notify_url",("http://www.mcardgx.com:8080/CqgVipShare/vip/addShareRecord?uuid="+uuid));// ��·����΢�ŷ���������֧�����֪ͨ·������д
			//}
			 
			String sign = WXPayUtil.generateSignature(paraMap, wxpc.getKey());
			 
			paraMap.put("sign", sign);
			 
			String xml = WXPayUtil.mapToXml(paraMap);//�����в���(map)תxml��ʽ
			 
			 
			 
			// ͳһ�µ� https://api.mch.weixin.qq.com/pay/unifiedorder
			 
			String unifiedorder_url = "https://api.mch.weixin.qq.com/pay/unifiedorder";
			 
			 
			 
			String xmlStr = HttpRequest.sendPost(unifiedorder_url, xml);//����post����"ͳһ�µ��ӿ�"����Ԥ֧��id:prepay_id
			 
			 
			 
			//���������Ƿ���ǰ��ҳ���json����
			 
			String prepay_id = "";//Ԥ֧��id
			 
			if (xmlStr.indexOf("SUCCESS") != -1) {
			 
			Map<String, String> map = WXPayUtil.xmlToMap(xmlStr);
			 
			prepay_id = (String) map.get("prepay_id");
			 
			}
			 
			payMap.put("appId", wxpc.getAppID());
			 
			payMap.put("timeStamp", WXPayUtil.getCurrentTimestamp()+"");
			 
			payMap.put("nonceStr", WXPayUtil.generateNonceStr());
			 
			payMap.put("signType", "MD5");
			 
			payMap.put("package", "prepay_id=" + prepay_id);
			 
			String paySign = WXPayUtil.generateSignature(payMap, wxpc.getKey());
			 
			payMap.put("paySign", paySign);
			
			/*
			request.setAttribute("appId", payMap.get("appId").toString());
			request.setAttribute("timeStamp", payMap.get("timeStamp").toString());
			request.setAttribute("nonceStr", payMap.get("nonceStr").toString());
			request.setAttribute("paySign", paySign);
			request.setAttribute("package1", payMap.get("package").toString());
			*/
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		finally {
			return payMap;
		}
	}
	
	@RequestMapping(value="/goPaySuccess")
	public String goPaySuccess(HttpServletRequest request) {
		
		String uuid=request.getParameter("uuid");
		System.out.println("goPaySuccess...."+uuid);
		ShareRecord sr=shareRecordService.getShareRecordByUuid(uuid);
		request.setAttribute("qrcodeUrl", sr.getQrcodeUrl());
		
		return "/vip/paySuccess";
	}
	
	/**
	 * �û���������
	 * �ο����ӣ�https://www.cnblogs.com/wqy415/p/7940633.html
	 * @param request
	 * @param response
	 */
	@RequestMapping(value="/userWithDraw")
	public void userWithDraw(HttpServletRequest request, HttpServletResponse response) {
		String openId = request.getParameter("openId");
		try {
			AlipayClient alipayClient = new DefaultAlipayClient(AlipayConfig.URL,AlipayConfig.APPID,AlipayConfig.RSA_PRIVATE_KEY, AlipayConfig.FORMAT, AlipayConfig.CHARSET, AlipayConfig.ALIPAY_PUBLIC_KEY, AlipayConfig.SIGNTYPE);
			AlipayFundTransToaccountTransferRequest alipayRequest = new AlipayFundTransToaccountTransferRequest();
			
			//�̻������ţ��̻���վ����ϵͳ��Ψһ�����ţ�����
			String out_biz_no = cfrIdSDF.format(new Date());
			//֧�����˻�������
			String payee_account = request.getParameter("alipayNo");
			//��ʵ����������
			String payee_real_name = request.getParameter("realName");
			//���ֽ�����
			String amount = request.getParameter("withDrawMoney");
			System.out.println("payee_account==="+payee_account);
			System.out.println("payee_real_name==="+payee_real_name);
			System.out.println("amount==="+amount);

			JSONObject order = new JSONObject();
			order.put("out_biz_no", out_biz_no);
			order.put("payee_type", "ALIPAY_LOGONID");
			order.put("payee_account", payee_account);
			order.put("amount", amount);
			//order.put("payee_account", "18765943028");
			//order.put("amount", "0.1");
			
			order.put("payer_show_name", "�û��������");
			order.put("payee_real_name", payee_real_name);
			//order.put("payee_real_name", "����");
			order.put("remark", "������ֵ�֧����");
			
			alipayRequest.setBizContent(order.toString());
			
			userService.updateWithDrawMoneyByOpenId(-Float.valueOf(amount), openId);
			//https://blog.csdn.net/u010533511/article/details/47904217
			//�ڹ������������û�����֪ͨ��ַ
			//alipayRequest.setNotifyUrl(MCARDGX+":8080/CqgVipShare/vip/updateWithDrawMoneyByOpenId?withDrawMoney="+amount+"&openId="+openId);
			//alipayRequest.setReturnUrl(MCARDGX+":8080/CqgVipShare/vip/toMine?openId="+openId);
			String form = alipayClient.pageExecute(alipayRequest).getBody(); 
			System.out.println("form==="+form);
			
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
	
	/*
	@RequestMapping(value="/updateWithDrawMoneyByOpenId")
	@ResponseBody
	public Map<String, Object> updateWithDrawMoneyByOpenId(HttpServletRequest request){
		
		System.out.println("updateWithDrawMoneyByOpenId...");
		Map<String, Object> jsonMap = new HashMap<String, Object>();
		String withDrawMoney = request.getParameter("withDrawMoney");
		String openId = request.getParameter("openId");
		int count=userService.updateWithDrawMoneyByOpenId(-Float.valueOf(withDrawMoney),openId);
		if(count==0) {
        	jsonMap.put("status", "no");
        	jsonMap.put("message", "����ʧ�ܣ�");
        }
        else {
        	jsonMap.put("status", "ok");
        	jsonMap.put("message", "���ֳɹ���");
        }
		return jsonMap;
	}
	*/
	
	/**
	 * ֧����ת��
	 * https://blog.csdn.net/yangxiaovip/article/details/104897230
	 * https://mvnrepository.com/artifact/com.alipay.sdk/alipay-sdk-java/4.11.0.ALL
	 * ����ӿ���Ҫ���ع�Կ֤��ǩ��������ᱨisv.missing-app-cert-sn(ȱ��Ӧ�ù�Կ֤�����к�)���󣬵��������Ƚ��鷳����ʱ�������ֽӿ�
	 * RSA2�͹�Կ֤��ǩ����ǩ������ο��������ӣ�
	 * https://opensupport.alipay.com/support/helpcenter/192/201602493592?ant_source=antsupport#
	 */
	@RequestMapping(value="/transfer")
	public void transfer() {
		try {
			AlipayClient alipayClient = new DefaultAlipayClient(AlipayConfig.URL,AlipayConfig.APPID,AlipayConfig.RSA_PRIVATE_KEY,AlipayConfig.FORMAT,AlipayConfig.CHARSET,AlipayConfig.ALIPAY_PUBLIC_KEY,AlipayConfig.SIGNTYPE);
			AlipayFundTransUniTransferRequest request = new AlipayFundTransUniTransferRequest();
			//�̻������ţ��̻���վ����ϵͳ��Ψһ�����ţ�����
			String out_trade_no = cfrIdSDF.format(new Date());
			request.setBizContent("{" +
			"\"out_biz_no\":\""+out_trade_no+"\"," +
			"\"trans_amount\":0.01," +
			"\"product_code\":\"TRANS_ACCOUNT_NO_PWD\"," +
			"\"biz_scene\":\"DIRECT_TRANSFER\"," +
			"\"order_title\":\"ת�˱���\"," +
			"\"original_order_id\":\""+out_trade_no+"\"," +
			"\"payee_info\":{" +
			"\"identity\":\"2019122160177031\"," +
			"\"identity_type\":\"ALIPAY_LOGON_ID\"," +
			"\"name\":\"�����������޹�˾\"" +
			"    }," +
			"\"remark\":\"����ת��\"," +
			"\"business_params\":\"{\\\"sub_biz_scene\\\":\\\"REDPACKET\\\"}\"" +
			"  }");
			AlipayFundTransUniTransferResponse response = alipayClient.certificateExecute(request);
			if(response.isSuccess()){
				System.out.println("���óɹ�");
			} else {
				System.out.println("����ʧ��");
			}
		} catch (AlipayApiException e) {
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
	
	/**
	 * ���Ӧ�ù�Կ
	 * �ο����ӣ�https://blog.csdn.net/c5113620/article/details/80384668
	 */
	public void getAppPublicKey() {
		try {
			//
			CertificateFactory cf = CertificateFactory.getInstance("X.509");
			X509Certificate cert = (X509Certificate)cf.generateCertificate(new FileInputStream("E:\\�ҵ��ļ�\\��Ա������ƽ̨\\֤���ļ�\\Ӧ�ù�Կ֤��\\appCertPublicKey_2016080600178660.crt"));
			PublicKey publicKey = cert.getPublicKey();
			//System.out.println("publicKey==="+publicKey);
			BASE64Encoder base64Encoder=new BASE64Encoder();
			String publicKeyString = base64Encoder.encode(publicKey.getEncoded());
			System.out.println("-----------------��Կ--------------------");
			System.out.println(publicKeyString);
			System.out.println("-----------------��Կ--------------------");
		} catch (CertificateException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	/*
	public void writeToFile(String s) {
		try {
			File file = new File("d:/111.txt");
			FileOutputStream fos = new FileOutputStream(file);
			byte[] sArr = s.getBytes();
			fos.write(sArr);;
			fos.flush();
			fos.close();
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public static void main(String[] args) {
		try {
			String s="https://openapi.alipay.com/gateway.do?charset=UTF-8&method=alipay.fund.trans.toaccount.transfer&sign=AHfexcML%2F1nzjB8dfL0oaH%2BZPJOIgARCnJRmizTrFF1ImgQ1h5oR39buLqdYFVcYllgQ8aY2o4uGJNgBetKWYJSspQ5iLwV9JZ0JOuYk9aW66Fgt8kj%2BAaW55mc22wY750LyYulzgN3y5hjG7cizW1r2%2FCVsjzVE2MEYGU9sLCF1%2BRgYC7NRj26gtw6xexYALegjbLFAvtCUvC7l3alGt5TmM1qs41Y8AEmOIJO10RCJ%2Fc%2FpI6NCKBQ4Vv%2Fyt6wzRShR0Nju637L8AdKQPtFWwpIFwPo50obUs2Qu4un9YrZHWtOdFfnTJfmCcNgYaukCeZt7FqDT53THAgHFzOPJQ%3D%3D&version=1.0&app_id=2019122160177031&sign_type=RSA2&timestamp=2020-12-30+17%3A04%3A16&alipay_sdk=alipay-easysdk-java&format=json";
			System.out.println(URLDecoder.decode(s,"gbk"));
			
			File file = new File("d:/111.txt");
			FileOutputStream fos = new FileOutputStream(file);
			byte[] sArr = s.getBytes();
			fos.write(sArr);;
			fos.flush();
			fos.close();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	*/

}
