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

import org.apache.commons.codec.digest.DigestUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
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
import com.cqgVipShare.util.wxpay.sdk.WXPayConfig;
import com.cqgVipShare.util.wxpay.sdk.WXPayUtil;
import com.cqgVipShare.util.wxwithdraw.sdk.HLWXWithDrawConfig;
import com.cqgVipShare.util.wxwithdraw.sdk.HttpRequestHandler;
import com.cqgVipShare.util.wxwithdraw.sdk.WechatpayUtil;
import com.jpay.ext.kit.IpKit;
import com.jpay.ext.kit.PaymentKit;
import com.jpay.ext.kit.StrKit;
import com.jpay.weixin.api.WxPayApi;
import com.jpay.weixin.api.WxPayApiConfig;
import com.jpay.weixin.api.WxPayApiConfigKit;
import com.mysql.cj.protocol.StandardSocketFactory;
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
@RequestMapping(VipController.MODULE_NAME)
public class VipController {

	String TAG = "VipController";
	/**
	 * ��Ա������ƽ̨����
	 */
	public static final String MCARDGX="http://www.mcardgx.com";
	public static final String APPID="wxf600e162d89732da";
	public static final String SECRET="097ee3404400bdf4b75ac8cfb0cc1c26";
	
	@Autowired
	private VipService vipService;
	@Autowired
	private MerchantService merchantService;
	@Autowired
	private ShareCardService shareCardService;
	@Autowired
	private MerchantCardTypeService merchantCardTypeService;
	@Autowired
	private MerchantCardService merchantCardService;
	@Autowired
	private MerchantCommentService merchantCommentService;
	@Autowired
	private TransferCardService transferCardService;
	@Autowired
	private ShareRecordService shareRecordService;
	@Autowired
	private HandleRecordService handleRecordService;
	@Autowired
	private ShareHistoryRecordService shareHistoryRecordService;
	@Autowired
	private TransferRecordService transferRecordService;
	@Autowired
	private TradeService tradeService;
	@Autowired
	private CardMessageService cardMessageService;
	@Autowired
	private MerchantMessageService merchantMessageService;
	@Autowired
	private CapFlowRecService capFlowRecService;
	@Autowired
	private NotifyUrlParamService notifyUrlParamService;
	@Autowired
	private PageValueService pageValueService;
	private SimpleDateFormat cfrIdSDF=new SimpleDateFormat("yyyyMMddHHmmss");
	public static final String MODULE_NAME="/vip";
	public static final String HOME_PATH=MODULE_NAME+"/home";
	public static final String HANDLE_PATH=MODULE_NAME+"/handle";
	public static final String TRANSFER_PATH=MODULE_NAME+"/transfer";
	public static final String MINE_PATH=MODULE_NAME+"/mine";
	public static final String MERCHANT_PATH=MINE_PATH+"/merchant";
	
	//https://www.cnblogs.com/lyr1213/p/9186330.html
	
	@RequestMapping(value="/merchantLogin",method=RequestMethod.POST,produces="plain/text; charset=UTF-8")
	@ResponseBody
	public String merchantLogin(Merchant merchant, HttpServletRequest request) {
		
		PlanResult plan=new PlanResult();
		Merchant mer=merchantService.getMerchant(merchant);
		if(mer==null) {
			plan.setStatus(1);
			plan.setMsg("�û�������������");
		}
		else {
			String openId=request.getParameter("openId");
			if(!openId.equals(mer.getOpenId())) {
				plan.setStatus(1);
				plan.setMsg("�Ǳ�΢�ź�ע����̼�");
			}
			/*
			else if(mer.getShopCheck()==Merchant.DAI_SHEN_HE){
				plan.setStatus(1);
				plan.setMsg("���̼����������");
			}
			else if(mer.getShopCheck()==Merchant.SHEN_HE_BU_HE_GE){
				plan.setStatus(1);
				plan.setMsg("���̼����δͨ��");
			}
			*/
			else {
				HttpSession session=request.getSession();
				session.setAttribute("merchant", mer);
				
				plan.setStatus(0);
				plan.setMsg("��¼�ɹ�");
			}
		}
		return JsonUtil.getJsonFromObject(plan);
	}

	@RequestMapping(value="/merchantExit")
	public String merchantExit(HttpSession session) {
		System.out.println("�̼��˳��ӿ�");
		session.removeAttribute("merchant");
		return MINE_PATH+"/info";
	}
	
	public String checkMyLocation(HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		//saveMyLocation(session,new MyLocation(35.95795,120.19353,"ɽ��ʡ","�ൺ��","�б���","����·","","ɽ��ʡ�ൺ���б�������·"));
		
		String page = request.getParameter("page");
		Object myLocObj = session.getAttribute("myLocation");
		if(myLocObj==null) {
			request.setAttribute("redirectUrl", MODULE_NAME+"/goPage?page="+page+"&openId="+request.getParameter("openId"));
			request.setAttribute("appId", APPID);
			request.setAttribute("appSecret", SECRET);
			return MODULE_NAME+"/getLocation";
		}
		else {
			String goPage=null;
			if(page.contains("homeIndex"))
				goPage=HOME_PATH+"/index";
			else if(page.contains("transferTcl"))
				goPage=TRANSFER_PATH+"/transferCardList";
			return goPage;
		}
	}

	@RequestMapping(value="/saveMyLocation")
	@ResponseBody
	public Map<String, Object> saveMyLocation(HttpSession session, MyLocation myLocation) {
		
		Map<String, Object> jsonMap = new HashMap<String, Object>();
		
		/*
		System.out.println("latitude==="+myLocation.getLatitude());
		System.out.println("longitude==="+myLocation.getLongitude());
		System.out.println("province==="+myLocation.getProvince());
		System.out.println("city==="+myLocation.getCity());
		System.out.println("district==="+myLocation.getDistrict());
		System.out.println("street==="+myLocation.getStreet());
		System.out.println("streetNumber==="+myLocation.getStreetNumber());
		System.out.println("formattedAddress==="+myLocation.getFormattedAddress());
		*/
		session.setAttribute("myLocation", myLocation);
		
		jsonMap.put("status", "ok");
		
		return jsonMap;
	}
	
	@RequestMapping(value="/goPage")
	public String goPage(HttpServletRequest request) {

		PageValue pageValue=pageValueService.selectByOpenId(request.getParameter("openId"));
		request.setAttribute("pageValue", pageValue);
		
		String url=null;
		String page=request.getParameter("page");
		switch (page) {
		case "gps":
			url=MODULE_NAME+"/gps";
			break;
		case "homeAsc":
			url=HOME_PATH+"/addShareCard";
			break;
		case "homeScl":
			url=HOME_PATH+"/shareCardList";
			break;
		case "shopList":
			url=MODULE_NAME+"/shopList";
			break;
		case "shareTreaty":
			url=HOME_PATH+"/shareTreaty";
			break;
		case "homeAsr":
			url=HOME_PATH+"/addShareRecord";
			break;
		case "shareAMC":
			url=HOME_PATH+"/addMerComment";
			break;
		case "tradeList":
			url=MODULE_NAME+"/tradeList";
			break;
		case "mineInfo":
			url=MINE_PATH+"/info";
			break;
		case "mineHandleList":
			url=MINE_PATH+"/handleList";
			break;
		case "mineShareList":
			url=MINE_PATH+"/shareList";
			break;
		case "mineChangeAccount":
			url=MINE_PATH+"/changeAccount";
			break;
		case "mineSmallChange":
			url=MINE_PATH+"/smallChange";
			break;
		case "mineTransferCard":
		case "mySubmitMenu":
			url=MODULE_NAME+"/childMenu";
			break;
		case "transferAtc":
			url=TRANSFER_PATH+"/addTransferCard";
			break;
		case "transferAtr":
			url=TRANSFER_PATH+"/addTransferRecord";
			break;
		case "transferAMC":
			url=TRANSFER_PATH+"/addMerComment";
			break;
		case "handleMcl":
			merchantService.updateVisitCountById(Integer.valueOf(pageValue.getShopId()));
			url=HANDLE_PATH+"/merCardList";
			break;
		case "handleTreaty":
			Map<String, Object> htMcMap = merchantCardService.selectMapById(pageValue.getMcId());
			MerchantCard htMc=new MerchantCard();
			htMc.setMoney(Float.valueOf(htMcMap.get("money").toString()));
			Object desObj = htMcMap.get("describe");
			if(desObj!=null)
				htMc.setDescribe(desObj.toString());
			htMc.setGmxz(htMcMap.get("gmxz").toString());
			request.setAttribute("merchantCard", htMc);
			url=HANDLE_PATH+"/treaty";
			break;
		case "handleAhr":
			url=HANDLE_PATH+"/addHandleRecord";
			break;
		case "handleAMC":
			url=HANDLE_PATH+"/addMerComment";
			break;
		case "tcDetail":
			merchantService.updateVisitCountById(Integer.valueOf(pageValue.getShopId()));
			Map<String,Object> tiMap=transferCardService.selectInfoById(pageValue.getId());
			request.setAttribute("transferInfo", tiMap);
			url=TRANSFER_PATH+"/tcDetail";
			break;
		case "srDetail":
			String uuid=pageValue.getUuid();
			boolean used="1".equals(pageValue.getUsed())?true:false;
			if(used) {
				ShareHistoryRecord shr=shareHistoryRecordService.getDetailByUuid(uuid);
				request.setAttribute("srDetail", shr);
			}
			else {
				ShareRecord sr=shareRecordService.getSRDetailByUuid(uuid);
				request.setAttribute("srDetail", sr);
			}
			url=MINE_PATH+"/srDetail";
			break;
		case "mineHrDetail":
			HandleRecord hrDetail=handleRecordService.getDetailByUuid(pageValue.getUuid());
			request.setAttribute("hrDetail", hrDetail);
			url=MINE_PATH+"/hrDetail";
			break;
		case "homeShare":
			merchantService.updateVisitCountById(Integer.valueOf(pageValue.getShopId()));
			Map<String,Object> siMap=shareCardService.selectById(pageValue.getId());
			request.setAttribute("shareInfo", siMap);
			url=HOME_PATH+"/share";
			break;
		case "mineMerchantInfo":
			HttpSession session = request.getSession();
			Object merchantObj = session.getAttribute("merchant");
			if(merchantObj==null) {
				String openId = request.getParameter("openId");
				Merchant merchant=merchantService.getByOpenId(openId);
				if(merchant==null) {
					request.setAttribute("appId", APPID);
					request.setAttribute("appSecret", SECRET);
					url=MERCHANT_PATH+"/add";
				}
				else {
					url=MERCHANT_PATH+"/login";
				}
			}
			else {
				request.setAttribute("appId", APPID);
				request.setAttribute("appSecret", SECRET);
				url=MERCHANT_PATH+"/info";
			}
			break;
		case "mineAlipay":
			Vip vip=vipService.getByOpenId(request.getParameter("openId"));
			request.setAttribute("vip", vip);
			url=MINE_PATH+"/alipay";
			break;
		case "qrcodeInfo":
			String qiUuid=request.getParameter("uuid");
			String qrcType=request.getParameter("qrcType");
			if("share".equals(qrcType)) {
				ShareRecord sr = shareRecordService.getByUuid(qiUuid);
				if(sr==null) {
					request.setAttribute("warnMsg", "������ʹ��");
					url=MODULE_NAME+"/qrcodeWarn";
				}
				else {
					HttpSession qiSession = request.getSession();
					//String shopOpenId = "oNFEuw61CEPtxI-ysHrZ4YrMoiyM";
					//String shopOpenId = "oNFEuwzkbP4OTTjBucFgBTWE5Bqg";
					String shopOpenId = qiSession.getAttribute("openId").toString();//�̻���openId
					boolean bool=shareCardService.compareShopIdWithCardShopId(shopOpenId,sr.getScId());
					if(bool) {
						Vip qiVip = vipService.getByOpenId(request.getParameter("openId"));
						Map<String, Object> scMap = shareCardService.selectById(String.valueOf(sr.getScId()));
						request.setAttribute("phone", sr.getPhone());
						request.setAttribute("ygxfDate", sr.getYgxfDate());
						request.setAttribute("nickName", qiVip.getNickName());
						request.setAttribute("scMap", scMap);
						url=MODULE_NAME+"/qrcodeInfo";
					}
					else {
						request.setAttribute("warnMsg", "�Ǳ����Ա");
						url=MODULE_NAME+"/qrcodeWarn";
					}
				}
			}
			else if("handle".equals(qrcType)) {
				HandleRecord hr = handleRecordService.getByUuid(qiUuid);
				if(hr==null) {
					request.setAttribute("warnMsg", "������ʹ��");
					url=MODULE_NAME+"/qrcodeWarn";
				}
				else {
					HttpSession qiSession = request.getSession();
					String shopOpenId = "oNFEuw61CEPtxI-ysHrZ4YrMoiyM";
					//String shopOpenId = qiSession.getAttribute("openId").toString();//�̻���openId
					boolean bool=merchantCardService.compareShopIdWithCardShopId(shopOpenId,hr.getMcId());
					if(bool) {
						Vip qiVip = vipService.getByOpenId(request.getParameter("openId"));
						Map<String, Object> qiMcMap = merchantCardService.selectMapById(String.valueOf(hr.getMcId()));
						request.setAttribute("phone", hr.getPhone());
						request.setAttribute("realName", hr.getRealName());
						request.setAttribute("nickName", qiVip.getNickName());
						request.setAttribute("mcMap", qiMcMap);
						url=MODULE_NAME+"/qrcodeInfo";
					}
					else {
						request.setAttribute("warnMsg", "�Ǳ����Ա");
						url=MODULE_NAME+"/qrcodeWarn";
					}
				}
			}
			break;
		case "mineMerchantEdit":
			Merchant merchant=merchantService.getByOpenId(request.getParameter("openId"));
			request.setAttribute("merchant", merchant);
			request.setAttribute("appId", APPID);
			request.setAttribute("appSecret", SECRET);
			url=MERCHANT_PATH+"/edit";
			break;
		case "mineMerMsg":
			url=MERCHANT_PATH+"/message";
			break;
		case "merMsgDetail":
			String mmdId = pageValue.getId();
			boolean isRead = Boolean.valueOf(pageValue.getIsRead());
			if(!isRead) {
				merchantMessageService.readByIds(mmdId);
			}
			MerchantMessage mm = merchantMessageService.getById(mmdId);
			request.setAttribute("merchantMessage", mm);
			
			url=MERCHANT_PATH+"/msgDetail";
			break;
		case "mineBindAlipay":
			Vip mbaVip=vipService.getByOpenId(request.getParameter("openId"));
			request.setAttribute("vip", mbaVip);
			url=MINE_PATH+"/bindAlipay";
			break;
		case "mineAddComment":
			url=MINE_PATH+"/addComment";
			break;
		case "mineMscl":
			url=MINE_PATH+"/myShareCardList";
			break;
		case "mineKzSRList":
			url=MINE_PATH+"/kzSRList";
			break;
		case "mineKzSHRList":
			url=MINE_PATH+"/kzSHRList";
			break;
		case "mineTcl":
			url=MINE_PATH+"/tranCardList";
			break;
		case "mineTRDetail":
			TransferRecord tr=transferRecordService.getLRDetailById(pageValue.getId());
			request.setAttribute("transferRecord", tr);
			url=MINE_PATH+"/trDetail";
			break;
		case "homeIndex":
		case "transferTcl":
			url=checkMyLocation(request);
			break;
		}
		return url;
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

	@RequestMapping(value="/selectTransferCardList")
	@ResponseBody
	public Map<String, Object> selectTransferCardList(Integer orderFlag,String order,Integer likeFlag,String tradeId,Integer start,Integer end,Double myLatitude,Double myLongitude) {

		Map<String, Object> jsonMap = new HashMap<String, Object>();
		List<TransferCard> tfList=transferCardService.selectTransferCardList(orderFlag,order,likeFlag,tradeId,start,end,myLatitude,myLongitude);

		if(tfList.size()==0) {
			jsonMap.put("status", "no");
		}
		else {
			jsonMap.put("status", "ok");
			jsonMap.put("data", tfList);
		}
		return jsonMap;
	}
	
	@RequestMapping(value="/selectTransferCardListByOpenId")
	@ResponseBody
	public Map<String, Object> selectTransferCardListByOpenId(String openId) {
		
		Map<String, Object> jsonMap = new HashMap<String, Object>();
		List<TransferCard> lvList=transferCardService.selectTransferCardListByOpenId(openId);
		
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
		List<Map<String,Object>> shareList=shareCardService.selectShareListByFxzOpenId(type,openId);
		
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
	
	@RequestMapping(value="/selectHandleListByOpenId")
	@ResponseBody
	public Map<String, Object> selectHandleListByOpenId(Integer type, String openId) {
		
		Map<String, Object> jsonMap = new HashMap<String, Object>();
		List<Map<String,Object>> hrList=handleRecordService.selectHandleListByFxzOpenId(type,openId);
		
		if(hrList.size()==0) {
			jsonMap.put("message", "no");
			jsonMap.put("info", "�����¿�");
		}
		else {
			jsonMap.put("message", "ok");
			jsonMap.put("data", hrList);
		}
		return jsonMap;
	}
	
	@RequestMapping(value="/selectCommentListByOpenId")
	@ResponseBody
	public Map<String, Object> selectCommentListByOpenId(String openId) {
		
		Map<String, Object> jsonMap = new HashMap<String, Object>();
		List<Map<String,Object>> messageList=cardMessageService.selectCommentListByOpenId(openId);
		
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
	
	@RequestMapping(value="/selectTransferListByOpenId")
	@ResponseBody
	public Map<String, Object> selectTransferListByOpenId(String openId) {
		
		Map<String, Object> jsonMap = new HashMap<String, Object>();
		List<TransferRecord> trList=transferCardService.selectTransferListByZrzOpenId(openId);
		
		if(trList.size()==0) {
			jsonMap.put("message", "no");
			jsonMap.put("info", "����ת�õ�");
		}
		else {
			jsonMap.put("message", "ok");
			jsonMap.put("data", trList);
		}
		return jsonMap;
	}
	
	@RequestMapping(value="/selectShareCardList")
	@ResponseBody
	public Map<String, Object> selectShareCardList(Integer orderFlag,String order,Integer likeFlag,String tradeId,Integer start,Integer end,Double myLatitude,Double myLongitude) {
		
		//https://www.cnblogs.com/wenBlog/p/11131182.html
		Map<String, Object> jsonMap = new HashMap<String, Object>();
		List<ShareCard> scList=shareCardService.selectList(orderFlag,order,likeFlag,tradeId,start,end,myLatitude,myLongitude);
		
		if(scList.size()==0) {
			jsonMap.put("message", "no");
		}
		else {
			jsonMap.put("message", "ok");
			jsonMap.put("data", scList);
		}
		return jsonMap;
	}
	
	@RequestMapping(value="/selectMerCardTypeList")
	@ResponseBody
	public Map<String, Object> selectMerCardTypeList(Integer shopId) {
		
		Map<String, Object> jsonMap = new HashMap<String, Object>();
		List<MerchantCardType> mctList=merchantCardTypeService.selectList(shopId);

		if(mctList.size()==0) {
			jsonMap.put("message", "no");
		}
		else {
			jsonMap.put("message", "ok");
			jsonMap.put("data", mctList);
		}
		return jsonMap;
	}
	
	@RequestMapping(value="/selectMerchantCardList")
	@ResponseBody
	public Map<String, Object> selectMerchantCardList(Integer orderFlag,String order,Integer likeFlag,String shopId,Integer type,Integer start,Integer end,Double myLatitude,Double myLongitude) {
		
		Map<String, Object> jsonMap = new HashMap<String, Object>();
		List<MerchantCard> mcList=merchantCardService.selectList(orderFlag, order, likeFlag, shopId, type, start, end, myLatitude, myLongitude);
		
		if(mcList.size()==0) {
			jsonMap.put("message", "no");
		}
		else {
			jsonMap.put("message", "ok");
			jsonMap.put("data", mcList);
		}
		return jsonMap;
	}

	@RequestMapping(value="/selectMyAddShareCardList")
	@ResponseBody
	public Map<String, Object> selectMyAddShareCardList(Integer type, String openId) {

		Map<String, Object> jsonMap = new HashMap<String, Object>();
		List<ShareCard> svList=shareCardService.selectMyAddShareCardList(type,openId);
		
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
		List<CapitalFlowRecord> cfrList=shareCardService.selectMyCancelSRList(openId);
		
		if(cfrList.size()==0) {
			jsonMap.put("message", "no");
		}
		else {
			jsonMap.put("message", "ok");
			jsonMap.put("data", cfrList);
		}
		return jsonMap;
	}

	@RequestMapping(value="/selectKzSRListByScId")
	@ResponseBody
	public Map<String, Object> selectKzSRListByScId(String scId, String openId) {

		Map<String, Object> jsonMap = new HashMap<String, Object>();
		List<ShareRecord> kzSRList=shareRecordService.selectKzSRListByScId(scId,openId);
		
		if(kzSRList.size()==0) {
			jsonMap.put("message", "no");
		}
		else {
			jsonMap.put("message", "ok");
			jsonMap.put("data", kzSRList);
		}
		return jsonMap;
	}
	
	@RequestMapping(value="/selectKzSHRListByScId")
	@ResponseBody
	public Map<String, Object> selectKzSHRListByScId(String scId, String openId) {
		
		Map<String, Object> jsonMap = new HashMap<String, Object>();
		List<ShareHistoryRecord> kzSHRList=shareHistoryRecordService.selectKzSHRListByScId(scId,openId);
		
		if(kzSHRList.size()==0) {
			jsonMap.put("message", "no");
		}
		else {
			jsonMap.put("message", "ok");
			jsonMap.put("data", kzSHRList);
		}
		return jsonMap;
	}

	@RequestMapping(value="/selectMerchantMessageList")
	@ResponseBody
	public Map<String, Object> selectMerchantMessageList(Integer flag, String openId) {

		Map<String, Object> jsonMap = new HashMap<String, Object>();
		List<MerchantMessage> mmList=merchantMessageService.selectList(flag,openId);

		if(mmList.size()==0) {
			jsonMap.put("message", "no");
		}
		else {
			jsonMap.put("message", "ok");
			jsonMap.put("data", mmList);
		}
		return jsonMap;
	}

	@RequestMapping(value="/confirmConsumeMoney")
	@ResponseBody
	public Map<String, Object> confirmConsumeMoney(Float shareMoney, String uuid) {

		Map<String, Object> jsonMap = new HashMap<String, Object>();
		
		int count=shareRecordService.confirmConsumeMoney(shareMoney, uuid);
		
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

	@RequestMapping(value="/confirmConsumeShare")
	@ResponseBody
	public Map<String, Object> confirmConsumeShare(Integer scType, String uuid) {

		Map<String, Object> jsonMap = new HashMap<String, Object>();
		ShareRecord sr=shareRecordService.getByUuid(uuid);
		
		ShareHistoryRecord shr=new ShareHistoryRecord();
		shr.setUuid(uuid);
		shr.setScId(sr.getScId());
		String kzOpenId = sr.getKzOpenId();
		shr.setKzOpenId(kzOpenId);
		String fxzOpenId = sr.getFxzOpenId();
		shr.setFxzOpenId(fxzOpenId);
		Float shareMoney = sr.getShareMoney();
		shr.setShareMoney(shareMoney);//���������ۿ�֮ǰ�Ľ��
		shr.setPhone(sr.getPhone());
		shr.setCreateTime(sr.getCreateTime());
		shr.setYgxfDate(sr.getYgxfDate());
		shr.setQrcodeUrl(sr.getQrcodeUrl());
		int count=shareHistoryRecordService.add(shr);
		count=shareRecordService.deleteByUuid(uuid);
		
		Float ccPercent=tradeService.getCcPercentByShrUuid(uuid);
		Float disShareMoney = (float)0.00;
		Integer discount = sr.getDiscount();
		System.out.println("discount==="+discount);
		if(discount==null)
			disShareMoney=shareMoney;
		else
			disShareMoney=shareMoney*discount/100;//�ۿۺ�Ľ��
		Float ccpMoney = disShareMoney*ccPercent/100;
		System.out.println("ccpMoney==="+ccpMoney);
		Float kzShareMoney=disShareMoney-ccpMoney;//�������ѽ��-��ҵ���ʣ�ʣ��Ľ�����ת�������Ľ����ڷ������濨��������
		
		count=shareCardService.confirmConsumeShare(sr);
		//���ʹο���ִ���߼���ͬ����Ҫ������Ĵ�������
		if(count>0) {
			if(scType!=5) {//������
				count=shareCardService.updateConsumeMoneyById(disShareMoney,shr.getScId());//�ӿ����Ļ�Ա����۳���Ӧ���������ǿ۳���ҵ����֮ǰ�Ľ��
				Float fxzShareMoney = sr.getDeposit()-disShareMoney;
				System.out.println("fxzShareMoney==="+fxzShareMoney);
				if(fxzShareMoney>0)
					vipService.updateWithDrawMoneyByOpenId(fxzShareMoney,fxzOpenId);//����Ѻ����۳��ۿۺ�Ľ�����ʣ���Ѻ�𣬾Ͱ�ʣ���Ѻ��ת�������ߵ��˻���
			}
			else {//�ο�����
				Float yhMoney = shareMoney-disShareMoney;
				System.out.println("yhMoney==="+yhMoney);
				
				count=shareCardService.updateConsumeCountById(shr.getScId());
				
				if(yhMoney>0)//�����Żݳ����Ľ��ͷ�����������
					vipService.updateWithDrawMoneyByOpenId(yhMoney,fxzOpenId);
			}
			count=vipService.updateWithDrawMoneyByOpenId(kzShareMoney,kzOpenId);//��һ���ֽ�����ڿ����ģ�ת�˸�����
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
	
	@RequestMapping(value="/confirmHandleCard")
	@ResponseBody
	public Map<String, Object> confirmHandleCard(String uuid) {

		Map<String, Object> jsonMap = new HashMap<String, Object>();
		int count=handleRecordService.updateReceiveByUuid(uuid);

		if(count==0) {
			jsonMap.put("status", "no");
			jsonMap.put("message", "ȷ�ϰ쿨ʧ�ܣ�");
		}
		else {
			jsonMap.put("status", "ok");
			jsonMap.put("message", "��ȷ�ϰ쿨��");
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

	@RequestMapping(value="/addShareCard",produces="plain/text; charset=UTF-8")
	@ResponseBody
	public String addShareCard(ShareCard shareCard) {
		
		PlanResult plan=new PlanResult();
		String json=null;
		try {
			int count=shareCardService.add(shareCard);
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
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			plan.setStatus(0);
			plan.setMsg("��ӹ����Աʧ�ܣ�");
			json=JsonUtil.getJsonFromObject(plan);
		}
		return json;
	}

	@RequestMapping(value="/deleteTransferCardByIds",produces="plain/text; charset=UTF-8")
	@ResponseBody
	public String deleteTransferCardByIds(String ids) {

		PlanResult plan=new PlanResult();
		String json;
		int count=transferCardService.deleteTransferCardByIds(ids);
		if(count==0) {
			plan.setStatus(0);
			plan.setMsg("ɾ��ת����Ϣʧ�ܣ�");
			json=JsonUtil.getJsonFromObject(plan);
		}
		else {
			plan.setStatus(1);
			plan.setMsg("ɾ��ת����Ϣ�ɹ���");
			json=JsonUtil.getJsonFromObject(plan);
		}
		return json;
	}

	@RequestMapping(value="/deleteMerchantMessageByIds",produces="plain/text; charset=UTF-8")
	@ResponseBody
	public String deleteMerchantMessageByIds(String ids) {

		PlanResult plan=new PlanResult();
		String json;
		int count=merchantMessageService.deleteMerchantMessageByIds(ids);
		if(count==0) {
			plan.setStatus(0);
			plan.setMsg("ɾ���̼���Ϣʧ�ܣ�");
			json=JsonUtil.getJsonFromObject(plan);
		}
		else {
			plan.setStatus(1);
			plan.setMsg("ɾ���̼���Ϣ�ɹ���");
			json=JsonUtil.getJsonFromObject(plan);
		}
		return json;
	}

	@RequestMapping(value="/merchantCheck")
	@ResponseBody
	public Map<String, Object> merchantCheck(String openId) {

		Map<String, Object> jsonMap = new HashMap<String, Object>();
		
		Merchant merchant=merchantService.getByOpenId(openId);
		int shopCheck = merchant.getShopCheck();
		if(shopCheck==Merchant.SHEN_HE_TONG_GUO) {
			jsonMap.put("status", "ok");
		}
		else if(shopCheck==Merchant.SHEN_HE_BU_HE_GE) {
			jsonMap.put("status", "no");
			jsonMap.put("message", "�̼����δͨ��");
		}
		else if(shopCheck==Merchant.DAI_SHEN_HE) {
			jsonMap.put("status", "no");
			jsonMap.put("message", "�̼������");
		}
		jsonMap.put("merchant", merchant);
		return jsonMap;
	}
	
	//https://blog.csdn.net/qq_26101151/article/details/53433380
	@RequestMapping(value="/addRecord")
	public void addRecord(HttpServletRequest request, HttpServletResponse response) throws Exception{

		System.out.println("addRecord........");
        String resXml = "";
        Map<String, String> backxml = new HashMap<String, String>();
 
        String outTradeNo=null;
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
 
 
	            // ====================================================================
		        // ֪ͨ΢��.�첽ȷ�ϳɹ�.��д.��Ȼ��һֱ֪ͨ��̨.�˴�֮�����Ϊ����ʧ����.
		        resXml = "<xml>" + "<return_code><![CDATA[SUCCESS]]></return_code>"
		                + "<return_msg><![CDATA[OK]]></return_msg>" + "</xml> ";
		        
		        outTradeNo=map.get("out_trade_no");
        		System.out.println("΢��֧���ص���������=" + outTradeNo);
        		//String basePath=request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/";
        		String basePath=request.getScheme()+"://"+request.getServerName()+":8080"+request.getContextPath()+"/";
        		
        		NotifyUrlParam nup=notifyUrlParamService.getByOutTradeNo(outTradeNo);
        		String action = nup.getAction();
        		if("share".equals(action)) {
	        		ShareRecord sr = new ShareRecord();
	        		sr.setUuid(nup.getSrUuid());
	        		sr.setScId(nup.getScId());
	        		Integer scType = nup.getScType();
	        		sr.setScType(scType);
	        		sr.setShopId(nup.getShopId());
	        		sr.setKzOpenId(nup.getKzOpenId());
	        		sr.setFxzOpenId(nup.getFxzOpenId());
	        		if(scType==5)
	        			sr.setShareMoney(nup.getShareMoney());
	        		else
	        			sr.setDeposit(nup.getDeposit());
	        		sr.setDiscount(nup.getDiscount());
	        		sr.setPhone(nup.getPhone());
	        		sr.setYgxfDate(nup.getYgxfDate());
	        		
	        		System.out.println("basePath==="+basePath);
	        		String url=basePath+"vip/goPage?page=qrcodeInfo&openId="+sr.getKzOpenId()+"&uuid="+sr.getUuid()+"&qrcType=share";
	        		String fileName = new SimpleDateFormat("yyyyMMddHHmmss").format(new Date()) + ".jpg";
	        		String avaPath="/CqgVipShare/upload/qrcode/share/"+fileName;
	        		String path = "D:/resource/CqgVipShare/qrcode/share";
	                Qrcode.createQrCode(url, path, fileName);
	
	        		sr.setQrcodeUrl(avaPath);
	                int count=shareRecordService.add(sr);
	                if(count>0) {
	                	count=notifyUrlParamService.deleteByOutTradeNo(outTradeNo);
	                }
        		}
        		else if("handle".equals(action)) {
        			HandleRecord hr=new HandleRecord();
        			hr.setUuid(nup.getHrUuid());
        			hr.setMcId(nup.getMcId());
	        		hr.setShopId(nup.getShopId());
        			hr.setOpenId(nup.getOpenId());
        			hr.setMoney(nup.getMoney());
        			hr.setRealName(nup.getRealName());
        			hr.setPhone(nup.getPhone());
        			hr.setQq(nup.getQq());
        			hr.setWxNo(nup.getWxNo());
        			
	        		System.out.println("basePath==="+basePath);
	        		String url=basePath+"vip/goPage?page=qrcodeInfo&openId="+hr.getOpenId()+"&uuid="+hr.getUuid()+"&qrcType=handle";
	        		String fileName = new SimpleDateFormat("yyyyMMddHHmmss").format(new Date()) + ".jpg";
	        		String avaPath="/CqgVipShare/upload/qrcode/handle/"+fileName;
	        		//String path = "D:/resource/CqgVipShare";
	        		String path = "D:/resource/CqgVipShare/qrcode/handle";
	                Qrcode.createQrCode(url, path, fileName);
	
	        		hr.setQrcodeUrl(avaPath);
	                int count=handleRecordService.add(hr);
	                if(count>0) {
	                	count=notifyUrlParamService.deleteByOutTradeNo(outTradeNo);
	                }
        		}
	        //}
        }
        else {
        	System.out.println("֧��ʧ��,������Ϣ��" + map.get("err_code"));
	        resXml = "<xml>" + "<return_code><![CDATA[FAIL]]></return_code>"
	        	 + "<return_msg><![CDATA[����Ϊ��]]></return_msg>" + "</xml> ";
        }
        // ------------------------------
        // ����ҵ�����
        // ------------------------------
        BufferedOutputStream out = new BufferedOutputStream(response.getOutputStream());
        out.write(resXml.getBytes());
        out.flush();
        out.close();
            

        
        
		//Map<String, Object> jsonMap = new HashMap<String, Object>();
		
		
        
        /*
        if(count==0) {
        	jsonMap.put("status", "no");
        	jsonMap.put("message", "����ʧ�ܣ�");
        }
        else {
        	jsonMap.put("status", "ok");
        	jsonMap.put("qrcodeUrl", avaPath);
        }
		return jsonMap;
		*/
	}

	@RequestMapping(value="/addTransferCard")
	@ResponseBody
	public Map<String, Object> addTransferCard(TransferCard tc) {

		Map<String, Object> jsonMap = new HashMap<String, Object>();
		int count=transferCardService.add(tc);
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
	
	@RequestMapping(value="/addTransferRecord")
	@ResponseBody
	public Map<String, Object> addTransferRecord(TransferRecord lr) {
		
		Map<String, Object> jsonMap = new HashMap<String, Object>();
		int count=transferRecordService.addTransferRecord(lr);
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
	public Map<String, Object> addComment(CardMessage message) {

		Map<String, Object> jsonMap = new HashMap<String, Object>();
		int count=cardMessageService.addComment(message);
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

	@RequestMapping(value="/addMerComment")
	@ResponseBody
	public Map<String, Object> addMerComment(MerchantComment mc) {

		Map<String, Object> jsonMap = new HashMap<String, Object>();
		int count=merchantCommentService.add(mc);
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

	@RequestMapping(value="/selectMerComment")
	@ResponseBody
	public Map<String, Object> selectMerComment(Integer type, Integer shopId) {

		Map<String, Object> jsonMap = new HashMap<String, Object>();
		List<MerchantComment> mcList = merchantCommentService.selectMerComment(type,shopId);
		if(mcList.size()==0) {
			jsonMap.put("message", "no");
			jsonMap.put("data", "�������ۣ�");
		}
		else {
			jsonMap.put("message", "ok");
			jsonMap.put("list", mcList);
		}
		return jsonMap;
	}

	@RequestMapping(value="/bindAlipay",produces="plain/text; charset=UTF-8")
	@ResponseBody
	public String bindAlipay(Vip user) {

		String json=null;;
		try {
			PlanResult plan=new PlanResult();
			int count=vipService.bindAlipay(user);
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

	@RequestMapping(value="/addMerchant",produces="plain/text; charset=UTF-8")
	@ResponseBody
	public String addMerchant(Merchant merchant,
			@RequestParam(value="logo_inp",required=false) MultipartFile logo_inp,
			@RequestParam(value="yyzz_inp",required=false) MultipartFile yyzz_inp,
			HttpServletRequest request) {

		String json=null;;
		try {
			PlanResult plan=new PlanResult();
			MultipartFile[] fileArr=new MultipartFile[2];
			fileArr[0]=logo_inp;
			fileArr[1]=yyzz_inp;
			for (int i = 0; i < fileArr.length; i++) {
				String jsonStr = null;
				if(fileArr[i].getSize()>0) {
					String folder=null;
					switch (i) {
					case 0:
						folder="ShopLogo";
						break;
					case 1:
						folder="ShopYYZZ";
						break;
					}
					jsonStr = FileUploadUtils.appUploadContentImg(request,fileArr[i],folder);
					JSONObject fileJson = JSONObject.fromObject(jsonStr);
					if("�ɹ�".equals(fileJson.get("msg"))) {
						JSONObject dataJO = (JSONObject)fileJson.get("data");
						switch (i) {
						case 0:
							merchant.setLogo(dataJO.get("src").toString());
							break;
						case 1:
							merchant.setYyzzImgUrl(dataJO.get("src").toString());
							break;
						}
					}
				}
			}
			int count=merchantService.add(merchant);
			if(count==0) {
				plan.setStatus(0);
				plan.setMsg("ע���̼���Ϣʧ�ܣ�");
				json=JsonUtil.getJsonFromObject(plan);
			}
			else {
				plan.setStatus(1);
				plan.setMsg("ע���̼���Ϣ�ɹ����ȴ���ˣ�");
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
	public String editMerchant(Merchant merchant,
			@RequestParam(value="logo_inp",required=false) MultipartFile logo_inp,
			@RequestParam(value="yyzz_inp",required=false) MultipartFile yyzz_inp,
			HttpServletRequest request) {

		String json=null;;
		try {
			PlanResult plan=new PlanResult();
			MultipartFile[] fileArr=new MultipartFile[2];
			fileArr[0]=logo_inp;
			fileArr[1]=yyzz_inp;
			for (int i = 0; i < fileArr.length; i++) {
				String jsonStr = null;
				if(fileArr[i].getSize()>0) {
					String folder=null;
					switch (i) {
					case 0:
						folder="ShopLogo";
						break;
					case 1:
						folder="ShopYYZZ";
						break;
					}
					jsonStr = FileUploadUtils.appUploadContentImg(request,fileArr[i],folder);
					JSONObject fileJson = JSONObject.fromObject(jsonStr);
					if("�ɹ�".equals(fileJson.get("msg"))) {
						JSONObject dataJO = (JSONObject)fileJson.get("data");
						switch (i) {
						case 0:
							merchant.setLogo(dataJO.get("src").toString());
							break;
						case 1:
							merchant.setYyzzImgUrl(dataJO.get("src").toString());
							break;
						}
					}
				}
			
			}
			int count=merchantService.edit(merchant);
			if(count==0) {
				plan.setStatus(0);
				plan.setMsg("�༭�̼���Ϣʧ�ܣ�");
				json=JsonUtil.getJsonFromObject(plan);
			}
			else {
				plan.setStatus(1);
				plan.setMsg("�̼���Ϣ�ѱ༭���ȴ���ˣ�");
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
			boolean bool=vipService.checkUserExist(openId);
			if(!bool) {
				Map<String, String> userMap = queryUserFromApi(openId,APPID,SECRET);
				Vip user=new Vip();
				user.setOpenId(openId);
				user.setNickName(userMap.get("nickname"));
				user.setHeadImgUrl(userMap.get("headimgurl"));
				vipService.addUser(user);
			}
			String eventKey = inputMsg.getEventKey();
			if("Share_Index".equals(eventKey)) {
				List<Article> articles = new ArrayList<Article>();
				Article a = new Article();
				a.setTitle("��ҳ");
				a.setUrl(MCARDGX+"/CqgVipShare/vip/goPage?page=homeIndex&openId="+openId);// �õ�ַ�ǵ��ͼƬ��ת��
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

	@RequestMapping(value="/queryVipFromDB")
	@ResponseBody
	public Map<String, Object> queryVipFromDB(String openId) {

		Map<String, Object> jsonMap = new HashMap<String, Object>();
		Vip vip = vipService.getByOpenId(openId);
		
        jsonMap.put("vip", vip);
        
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
		//String jsonMenu = "{\"button\":[{\"type\":\"view\",\"name\":\"������ҳ1\",\"url\":\""+viewUrl1+"homeIndex"+viewUrl2+"\"},";
		String jsonMenu = "{\"button\":[{\"type\":\"view\",\"name\":\"������ҳ\",\"url\":\""+viewUrl+"homeIndex\"},";
			jsonMenu+="{\"type\":\"view\",\"name\":\"��������\",\"url\":\""+viewUrl+"tradeList\"},";
			jsonMenu+="{\"type\":\"view\",\"name\":\"�̼���֤\",\"url\":\""+viewUrl+"mineMerchantInfo\"}";
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
		List<Merchant> hotList=merchantService.selectHotShopList(tradeId);
		List<Merchant> moreList=merchantService.selectMoreShopList(tradeId);
		jsonMap.put("hotList", hotList);
		jsonMap.put("moreList", moreList);
		return jsonMap;
	}

	@RequestMapping(value="/selectHotShopList")
	@ResponseBody
	public Map<String, Object> selectHotShopList() {

		Map<String, Object> jsonMap = new HashMap<String, Object>();
		List<Merchant> hotList=merchantService.selectHotShopList();

		if(hotList.size()==0) {
			jsonMap.put("message", "no");
		}
		else {
			jsonMap.put("message", "ok");
			jsonMap.put("data", hotList);
		}
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
	public Map<String, Object> confirmCanShareVip(CapitalFlowRecord cfr) {

		Map<String, Object> jsonMap = new HashMap<String, Object>();
		int count=capFlowRecService.confirmCanShareVip(cfr);
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

	@RequestMapping(value="/checkUserNameExist")
	@ResponseBody
	public Map<String, Object> checkUserNameExist(String userName) {

		Map<String, Object> jsonMap = new HashMap<String, Object>();
		boolean bool=merchantService.checkUserNameExist(userName);
		if(bool) {
			jsonMap.put("status", "no");
			jsonMap.put("message", "�û�����ע��");
		}
		else {
			jsonMap.put("status", "ok");
		}
		return jsonMap;
	}

	@RequestMapping(value="/editVipSignTxt")
	@ResponseBody
	public Map<String, Object> editVipSignTxt(String signTxt, String openId) {

		Map<String, Object> jsonMap = new HashMap<String, Object>();
		int count=vipService.editVipSignTxt(signTxt, openId);
		if(count>0) {
			jsonMap.put("status", "ok");
			jsonMap.put("message", "�༭ǩ���ɹ���");
		}
		else {
			jsonMap.put("status", "no");
			jsonMap.put("message", "�༭ǩ��ʧ�ܣ�");
		}
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
			//String uuid = UUID.randomUUID().toString().replaceAll("-", "");
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
			notifyUrlParam.setOutTradeNo(out_trade_no);
			notifyUrlParam.setScId(sr.getScId());
			notifyUrlParam.setKzOpenId(sr.getKzOpenId());
			notifyUrlParam.setFxzOpenId(sr.getFxzOpenId());
			notifyUrlParam.setShareMoney(sr.getShareMoney());
			notifyUrlParam.setPhone(sr.getPhone());
			notifyUrlParam.setYgxfDate(sr.getYgxfDate());
			int addCount=notifyUrlParamService.add(notifyUrlParam);
			if(addCount>0) {
				//�ڹ������������û�����֪ͨ��ַ
				alipayRequest.setNotifyUrl(AlipayConfig.NOTIFY_URL+"?outTradeNo="+out_trade_no);
				//alipayRequest.setNotifyUrl(AlipayConfig.NOTIFY_URL+"?KzOpenId="+sr.getKzOpenId()+"&fxzOpenId="+sr.getFxzOpenId()+"&phone="+sr.getPhone()+"&ygxfDate="+sr.getYgxfDate()+"&scId="+sr.getScId()+"&shareMoney="+sr.getShareMoney()+"&uuid="+uuid);
			}
			alipayRequest.setReturnUrl(AlipayConfig.RETURN_URL+"?outTradeNo="+out_trade_no);
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
	public Map<String, String> wxPay(ShareRecord sr, HandleRecord hr, HttpServletRequest request, HttpServletResponse response) {

		Map<String, String> payMap = new HashMap<String, String>();
		try {
			Map<String, String> paraMap = new HashMap<String, String>();
			
			HLWXPayConfig wxpc = new HLWXPayConfig();
			paraMap.put("appid", wxpc.getAppID());
			 
			paraMap.put("body", "aaa");
			 
			paraMap.put("mch_id", wxpc.getMchID());
			 
			paraMap.put("nonce_str", WXPayUtil.generateNonceStr());
			 
			//paraMap.put("openid", "oNFEuwzkbP4OTTjBucFgBTWE5Bqg");
			HttpSession session = request.getSession();
			paraMap.put("openid", session.getAttribute("openId").toString());
			 
			String outTradeNo = cfrIdSDF.format(new Date());
			System.out.println("outTradeNo==="+outTradeNo);
			paraMap.put("out_trade_no", outTradeNo);//������
			 
			//paraMap.put("spbill_create_ip", "124.70.38.226");
			String scIp = request.getRemoteHost();
			System.out.println("scIp==="+scIp);
			paraMap.put("spbill_create_ip", scIp);
			 
			paraMap.put("total_fee","1");
			 
			paraMap.put("trade_type", "JSAPI");

			String action = request.getParameter("action");
			NotifyUrlParam notifyUrlParam=new NotifyUrlParam();
			notifyUrlParam.setOutTradeNo(outTradeNo);
			notifyUrlParam.setPayType(NotifyUrlParam.WXPAY);
			notifyUrlParam.setShopId(sr.getShopId());
			String uuid = UUID.randomUUID().toString().replaceAll("-", "");
			if("share".equals(action)) {
				notifyUrlParam.setSrUuid(uuid);
				notifyUrlParam.setScId(sr.getScId());
				Integer scType = Integer.valueOf(request.getParameter("scType"));
				notifyUrlParam.setScType(scType);
				notifyUrlParam.setKzOpenId(sr.getKzOpenId());
				notifyUrlParam.setFxzOpenId(sr.getFxzOpenId());
				if(scType==5)
					notifyUrlParam.setShareMoney(sr.getShareMoney());
				else
					notifyUrlParam.setDeposit(sr.getDeposit());
				notifyUrlParam.setDiscount(sr.getDiscount());
				notifyUrlParam.setYgxfDate(sr.getYgxfDate());
			}
			else if("handle".equals(action)) {
				notifyUrlParam.setHrUuid(uuid);
				notifyUrlParam.setMcId(hr.getMcId());
				notifyUrlParam.setOpenId(hr.getOpenId());
				notifyUrlParam.setMoney(hr.getMoney());
				notifyUrlParam.setRealName(hr.getRealName());
				notifyUrlParam.setQq(hr.getQq());
				notifyUrlParam.setWxNo(hr.getWxNo());
			}
			notifyUrlParam.setAction(action);
			notifyUrlParam.setPhone(sr.getPhone());
			int addCount=notifyUrlParamService.add(notifyUrlParam);
			if(addCount>0) {
				//�ڹ������������û�����֪ͨ��ַ
				paraMap.put("notify_url",WXPayConfig.notifyUrl);// ��·����΢�ŷ���������֧�����֪ͨ·������д
				//addRecord
			}
			 
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
			
			payMap.put("uuid", uuid);
			
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

		System.out.println("goPaySuccess....");
		String action=request.getParameter("action");
		if("share".equals(action)) {
			String srUuid=request.getParameter("srUuid");
			System.out.println("srUuid==="+srUuid);
			ShareRecord sr=shareRecordService.getByUuid(srUuid);
			request.setAttribute("qrcodeUrl", sr.getQrcodeUrl());
		}
		else if("handle".equals(action)) {
			String hrUuid=request.getParameter("hrUuid");
			System.out.println("hrUuid==="+hrUuid);
			HandleRecord hr=handleRecordService.getByUuid(hrUuid);
			request.setAttribute("qrcodeUrl", hr.getQrcodeUrl());
		}
		
		return "/vip/paySuccess";
	}
	
	@RequestMapping(value="/updatePageValue")
	@ResponseBody
	public Map<String, String> updatePageValue(PageValue pv) {

		Map<String, String> jsonMap = new HashMap<String, String>();
		
		int count=0;
		boolean bool = pageValueService.checkExistByOpenId(pv.getOpenId());
		if(bool) {
			count=pageValueService.updateByOpenId(pv);
		}
		else {
			count=pageValueService.add(pv);
		}
		
		if(count>0) {
			jsonMap.put("status", "ok");
			jsonMap.put("message", "��ֵ�ɹ���");
		}
		else {
			jsonMap.put("status", "no");
			jsonMap.put("message", "��ֵʧ�ܣ�");
		}
		return jsonMap;
	}

	@RequestMapping(value="/getWithDrawMoneyByOpenId")
	@ResponseBody
	public Map<String, Object> getWithDrawMoneyByOpenId(HttpServletRequest request) {

		Map<String, Object> jsonMap = new HashMap<String, Object>();
		
		String openId = request.getParameter("openId");
		Float withDrawMoney = vipService.getWithDrawMoneyByOpenId(openId);
		jsonMap.put("withDrawMoney", withDrawMoney);
		
		return jsonMap;
	}
	
	/**
	 * ΢���û���������
	 * �ο�����1��https://www.jianshu.com/p/4b9bc75f2343
	 * �ο�����2��https://blog.csdn.net/qq_41187907/article/details/79978739
	 * https://blog.csdn.net/fanguoddd/article/details/86588783
	 * @param request
	 * @param response
	 */
	@RequestMapping(value="/userWxWithDraw")
	@ResponseBody
	public Map<String,Object> userWxWithDraw(HttpServletRequest request, HttpServletResponse response) {

		Map<String,Object> resultMap = new HashMap<>();
		HLWXWithDrawConfig wxwdc = new HLWXWithDrawConfig();
		 try{
            // 1.�������ǩ��
		 	//wxwdc.setOpenId("oNFEuwzkbP4OTTjBucFgBTWE5Bqg");
		 	//wxwdc.setAmount(100);
		 	//wxwdc.setDesc("��ҵ�����Ǯ");
			String openId = request.getParameter("openId");
		 	wxwdc.setOpenId(openId);
		 	wxwdc.setAmount((int)(Float.valueOf(request.getParameter("amount"))*100));
		 	wxwdc.setDesc(request.getParameter("desc"));
		 	
		 	//΢�Źٷ�API�ĵ� https://pay.weixin.qq.com/wiki/doc/api/tools/mch_pay.php?chapter=14_2
            String paramStr = WechatpayUtil.createLinkString(wxwdc);
            String mysign = paramStr + "&key=" + wxwdc.getAppkey();
            String sign = DigestUtils.md5Hex(mysign).toUpperCase();
	
            // 2.��װ�������
            StringBuilder reqXmlStr = new StringBuilder();
            reqXmlStr.append("<xml>");
            reqXmlStr.append("<mchid>" + wxwdc.getMchID() + "</mchid>");
            reqXmlStr.append("<mch_appid>" + wxwdc.getMchAppID() + "</mch_appid>");
            reqXmlStr.append("<nonce_str>" + wxwdc.getNonceStr() + "</nonce_str>");
            reqXmlStr.append("<check_name>" + wxwdc.getCheckName() + "</check_name>");
            reqXmlStr.append("<openid>" + wxwdc.getOpenId() + "</openid>");
            reqXmlStr.append("<amount>" + wxwdc.getAmount() + "</amount>");
            reqXmlStr.append("<desc>" + wxwdc.getDesc() + "</desc>");
            reqXmlStr.append("<sign>" + sign + "</sign>");
            reqXmlStr.append("<partner_trade_no>" + wxwdc.getPartnerTradeNo() + "</partner_trade_no>");
            reqXmlStr.append("<spbill_create_ip>" + wxwdc.getSpbillCreateIp() + "</spbill_create_ip>");
            reqXmlStr.append("</xml>");
	
            System.out.println("request xml = " + reqXmlStr);
            // 3.����֤������ӿ�
            String result = HttpRequestHandler.httpsRequest(wxwdc.getTransfersUrl(), reqXmlStr.toString(),
            		wxwdc, wxwdc.getCertPath());
            System.out.println("response xml = " + result);
            if(result.contains("CDATA[FAIL]")){
	            resultMap.put("status", "no");
	            resultMap.put("message", "����΢�Žӿ�ʧ��, ������Ϣ��鿴������־");
            }
            else {
            	vipService.updateWithDrawMoneyByOpenId(-Float.valueOf(wxwdc.getAmount()),openId);
                resultMap.put("status", "ok");
                resultMap.put("message", "ִ�гɹ���");
            }
        }
        catch (Exception e){
            e.printStackTrace();
            resultMap.put("status", "no");
            resultMap.put("message", "ִ��ʧ�ܣ�");
        }
		finally {
			return resultMap;
		}
	}
	
	/**
	 * ֧�����û���������
	 * �ο����ӣ�https://www.cnblogs.com/wqy415/p/7940633.html
	 * @param request
	 * @param response
	 */
	@RequestMapping(value="/userAlipayWithDraw")
	public void userAlipayWithDraw(HttpServletRequest request, HttpServletResponse response) {
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
			
			vipService.updateWithDrawMoneyByOpenId(-Float.valueOf(amount), openId);
			//https://blog.csdn.net/u010533511/article/details/47904217
			//�ڹ������������û�����֪ͨ��ַ
			//alipayRequest.setNotifyUrl(MCARDGX+":8080/CqgVipShare/vip/updateWithDrawMoneyByOpenId?withDrawMoney="+amount+"&openId="+openId);
			//alipayRequest.setReturnUrl(MCARDGX+":8080/CqgVipShare/vip/goPage?page=mineInfo&openId="+openId);
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
		boolean bool=vipService.checkUserExist(openId);
		if(!bool) {
			Map<String, String> userMap = queryUserFromApi(openId,APPID,SECRET);
			Vip user=new Vip();
			user.setOpenId(openId);
			user.setNickName(userMap.get("nickname"));
			user.setHeadImgUrl(userMap.get("headimgurl"));
			vipService.addUser(user);
		}
		
		String params="&openId="+openId;
		if("tradeList".equals(goPage)) {
			params+="&action=addShareCard&from=wxMenu";
		}
		return "redirect:http://www.mcardgx.com:8080/CqgVipShare/vip/goPage?page="+goPage+params;
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
