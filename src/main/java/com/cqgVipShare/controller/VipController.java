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
import com.alipay.api.CertAlipayRequest;
import com.alipay.api.DefaultAlipayClient;
import com.alipay.api.internal.util.AlipaySignature;
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
 * 华凌会员共享平台
 * oNFEuwzkbP4OTTjBucFgBTWE5Bqg
 * 这个类主要是用来封装手机端的接口
 */
/* 
<dependency>
	<groupId>mysql</groupId>
	<artifactId>mysql-connector-java</artifactId>
	<version>5.1.42</version>
</dependency>
http://download.eclipse.org/recommenders/models/oxygen/
微信sdk接口列表：https://developers.weixin.qq.com/doc/offiaccount/OA_Web_Apps/JS-SDK.html
微信提现接口：https://www.bilibili.com/video/av97054866/
*/
@Controller
@RequestMapping(VipController.MODULE_NAME)
public class VipController {

	String TAG = "VipController";
	/**
	 * 会员卡共享平台域名
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
	public static final String MERCHANT_LOGIN_PATH=MERCHANT_PATH+"/login";
	
	//https://www.cnblogs.com/lyr1213/p/9186330.html
	
	/**
	 * 商户登录
	 * @param merchant
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/merchantLogin",method=RequestMethod.POST,produces="plain/text; charset=UTF-8")
	@ResponseBody
	public String merchantLogin(Merchant merchant, HttpServletRequest request) {
		
		PlanResult plan=new PlanResult();
		Merchant mer=merchantService.getMerchant(merchant);
		if(mer==null) {
			plan.setStatus(1);
			plan.setMsg("用户名或密码有误");
		}
		else {
			HttpSession session=request.getSession();
			session.setAttribute("merchant", mer);
			
			plan.setStatus(0);
			plan.setMsg("登录成功");
		}
		return JsonUtil.getJsonFromObject(plan);
	}

	/**
	 * 商家注销
	 * @param session
	 * @return
	 */
	@RequestMapping(value="/merchantExit")
	public String merchantExit(HttpSession session) {
		System.out.println("商家退出接口");
		session.removeAttribute("merchant");
		return MINE_PATH+"/center";
	}
	
	/**
	 * 验证手机端是否已定位
	 * @param request
	 * @return
	 */
	public String checkMyLocation(HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		//saveMyLocation(session,new MyLocation(36.096830,120.385100,"山东省","青岛市","市北区","江都路","","山东省青岛市市北区江都路"));
		
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
	
	/**
	 * 验证手机端商家是否已登录
	 * @param request
	 * @return
	 */
	public boolean checkIfMerchantLogin(HttpServletRequest request) {

		HttpSession session = request.getSession();
		Object merObj = session.getAttribute("merchant");
		if(merObj==null)
			return false;
		else
			return true;
	}

	/**
	 * 保存当前位置
	 * @param session
	 * @param myLocation
	 * @return
	 */
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
	
	/**
	 * 跳转到对应的页面
	 * @param request
	 * @return
	 */
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
		case "mineCenter":
			url=MINE_PATH+"/center";
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
		case "mineMerCardMgr":
			url=MODULE_NAME+"/childMenu";
			break;
		case "mineMerchantMgr":
			if(checkIfMerchantLogin(request))
				url=MODULE_NAME+"/childMenu";
			else
				url=MERCHANT_LOGIN_PATH;
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
		case "mineMerAdd":
			request.setAttribute("appId", APPID);
			request.setAttribute("appSecret", SECRET);
			url=MERCHANT_PATH+"/add";
			break;
		case "mineMerchantCenter":
			HttpSession session = request.getSession();
			Object merchantObj = session.getAttribute("merchant");
			if(merchantObj==null) {
				url=MERCHANT_PATH+"/login";
			}
			else {
				url=MERCHANT_PATH+"/center";
			}
			break;
		case "mineMerCardAdd":
			url=MERCHANT_PATH+"/card/merCard/add";
			break;
		case "mineMerCardEdit":
			MerchantCard mmceMc = merchantCardService.selectById(pageValue.getId());
			request.setAttribute("merchantCard", mmceMc);
			url=MERCHANT_PATH+"/card/merCard/edit";
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
					request.setAttribute("warnMsg", "此码已使用");
					url=MODULE_NAME+"/qrcodeWarn";
				}
				else {
					HttpSession qiSession = request.getSession();
					//String shopOpenId = "oNFEuw61CEPtxI-ysHrZ4YrMoiyM";
					//String shopOpenId = "oNFEuwzkbP4OTTjBucFgBTWE5Bqg";
					String shopOpenId = qiSession.getAttribute("openId").toString();//商户的openId
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
						request.setAttribute("warnMsg", "非本店会员");
						url=MODULE_NAME+"/qrcodeWarn";
					}
				}
			}
			else if("handle".equals(qrcType)) {
				HandleRecord hr = handleRecordService.getByUuid(qiUuid);
				if(hr==null) {
					request.setAttribute("warnMsg", "此码已使用");
					url=MODULE_NAME+"/qrcodeWarn";
				}
				else {
					HttpSession qiSession = request.getSession();
					String shopOpenId = "oNFEuw61CEPtxI-ysHrZ4YrMoiyM";
					//String shopOpenId = qiSession.getAttribute("openId").toString();//商户的openId
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
						request.setAttribute("warnMsg", "非本店会员");
						url=MODULE_NAME+"/qrcodeWarn";
					}
				}
			}
			break;
		case "mineMerchantEdit":
			if(checkIfMerchantLogin(request)) {
				Merchant merchant=merchantService.getById(Integer.valueOf(pageValue.getId()));
				request.setAttribute("merchant", merchant);
				request.setAttribute("appId", APPID);
				request.setAttribute("appSecret", SECRET);
				url=MERCHANT_PATH+"/mgr/edit";
			}
			else
				url=MERCHANT_LOGIN_PATH;
			break;
		case "mineMerMsg":
			if(checkIfMerchantLogin(request))
				url=MERCHANT_PATH+"/mgr/message";
			else
				url=MERCHANT_LOGIN_PATH;
			break;
		case "merMsgDetail":
			if(checkIfMerchantLogin(request)) {
				String mmdId = pageValue.getId();
				boolean isRead = Boolean.valueOf(pageValue.getIsRead());
				if(!isRead) {
					merchantMessageService.readByIds(mmdId);
				}
				MerchantMessage mm = merchantMessageService.getById(mmdId);
				request.setAttribute("merchantMessage", mm);
				
				url=MERCHANT_PATH+"/mgr/msgDetail";
			}
			else
				url=MERCHANT_LOGIN_PATH;
			break;
		case "mineMerInfo":
			if(checkIfMerchantLogin(request)) {
				Merchant mmiMerchant=merchantService.getById(Integer.valueOf(pageValue.getId()));
				request.setAttribute("merchant", mmiMerchant);
				request.setAttribute("appId", APPID);
				request.setAttribute("appSecret", SECRET);
				url=MERCHANT_PATH+"/mgr/info";
			}
			else
				url=MERCHANT_LOGIN_PATH;
			break;
		case "mineUpdMerPwd":
			if(checkIfMerchantLogin(request))
				url=MERCHANT_PATH+"/mgr/updatePwd";
			else
				url=MERCHANT_LOGIN_PATH;
			break;
		case "mineMerCfr":
			if(checkIfMerchantLogin(request))
				url=MERCHANT_PATH+"/capFlowRec/list";
			else
				url=MERCHANT_LOGIN_PATH;
			break;
		case "mineMerCardType":
			if(checkIfMerchantLogin(request))
				url=MERCHANT_PATH+"/card/cardType/list";
			else
				url=MERCHANT_LOGIN_PATH;
			break;
		case "mineMerCard":
			if(checkIfMerchantLogin(request))
				url=MERCHANT_PATH+"/card/merCard/list";
			else
				url=MERCHANT_LOGIN_PATH;
			break;
		case "mineHanRec":
			if(checkIfMerchantLogin(request))
				url=MERCHANT_PATH+"/card/hanRec/list";
			else
				url=MERCHANT_LOGIN_PATH;
			break;
		case "mineHanRecDetail":
			HandleRecord mhrdHr = handleRecordService.getByUuid(pageValue.getUuid());
			request.setAttribute("handleRecord", mhrdHr);
			url=MERCHANT_PATH+"/card/hanRec/detail";
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
	
	/**
	 * 查询行业
	 * @param name
	 * @return
	 */
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

	/**
	 * 查询转让卡
	 * @param orderFlag
	 * @param order
	 * @param likeFlag
	 * @param tradeId
	 * @param start
	 * @param end
	 * @param myLatitude
	 * @param myLongitude
	 * @return
	 */
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
	
	/**
	 * 根据openId查询转让卡
	 * @param openId
	 * @return
	 */
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
	
	/**
	 * 根据openId查询分享单
	 * @param type
	 * @param openId
	 * @return
	 */
	@RequestMapping(value="/selectShareListByOpenId")
	@ResponseBody
	public Map<String, Object> selectShareListByOpenId(Integer type, String openId) {
		
		Map<String, Object> jsonMap = new HashMap<String, Object>();
		List<Map<String,Object>> shareList=shareRecordService.selectShareListByFxzOpenId(type,openId);
		
		if(shareList.size()==0) {
			jsonMap.put("message", "no");
			jsonMap.put("info", "暂无分享单");
		}
		else {
			jsonMap.put("message", "ok");
			jsonMap.put("data", shareList);
		}
		return jsonMap;
	}
	
	/**
	 * 根据openId查询发布卡
	 * @param type
	 * @param openId
	 * @return
	 */
	@RequestMapping(value="/selectHandleListByOpenId")
	@ResponseBody
	public Map<String, Object> selectHandleListByOpenId(Integer type, String openId) {
		
		Map<String, Object> jsonMap = new HashMap<String, Object>();
		List<Map<String,Object>> hrList=handleRecordService.selectHandleListByFxzOpenId(type,openId);
		
		if(hrList.size()==0) {
			jsonMap.put("message", "no");
			jsonMap.put("info", "暂无新卡");
		}
		else {
			jsonMap.put("message", "ok");
			jsonMap.put("data", hrList);
		}
		return jsonMap;
	}
	
	/**
	 * 根据openId查询评论
	 * @param openId
	 * @return
	 */
	@RequestMapping(value="/selectCommentListByOpenId")
	@ResponseBody
	public Map<String, Object> selectCommentListByOpenId(String openId) {
		
		Map<String, Object> jsonMap = new HashMap<String, Object>();
		List<Map<String,Object>> messageList=cardMessageService.selectCommentListByOpenId(openId);
		
		if(messageList.size()==0) {
			jsonMap.put("message", "no");
			jsonMap.put("info", "暂无评价");
		}
		else {
			jsonMap.put("message", "ok");
			jsonMap.put("data", messageList);
		}
		return jsonMap;
	}
	
	/**
	 * 根据openId查询转让单
	 * @param openId
	 * @return
	 */
	@RequestMapping(value="/selectTransferListByOpenId")
	@ResponseBody
	public Map<String, Object> selectTransferListByOpenId(String openId) {
		
		Map<String, Object> jsonMap = new HashMap<String, Object>();
		List<TransferRecord> trList=transferCardService.selectTransferListByZrzOpenId(openId);
		
		if(trList.size()==0) {
			jsonMap.put("message", "no");
			jsonMap.put("info", "暂无转让单");
		}
		else {
			jsonMap.put("message", "ok");
			jsonMap.put("data", trList);
		}
		return jsonMap;
	}
	
	/**
	 * 查询共享卡
	 * @param orderFlag
	 * @param order
	 * @param likeFlag
	 * @param tradeId
	 * @param start
	 * @param end
	 * @param myLatitude
	 * @param myLongitude
	 * @return
	 */
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
	
	/**
	 * 根据门店id查询会员卡类型
	 * @param shopId
	 * @return
	 */
	@RequestMapping(value="/selectMerCardTypeList")
	@ResponseBody
	public Map<String, Object> selectMerCardTypeList(Integer shopId) {
		
		Map<String, Object> jsonMap = new HashMap<String, Object>();
		List<MerchantCardType> mctList=merchantCardTypeService.selectList(shopId);

		if(mctList.size()==0) {
			jsonMap.put("message", "no");
			jsonMap.put("info", "暂无数据");
		}
		else {
			jsonMap.put("message", "ok");
			jsonMap.put("data", mctList);
		}
		return jsonMap;
	}
	
	/**
	 * 查询门店下的会员卡
	 * @param orderFlag
	 * @param order
	 * @param likeFlag
	 * @param shopId
	 * @param type
	 * @param start
	 * @param end
	 * @param myLatitude
	 * @param myLongitude
	 * @return
	 */
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

	/**
	 * 查询我发布的分享卡
	 * @param type
	 * @param openId
	 * @return
	 */
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

	/**
	 * 我发布的待取消的会员卡
	 * @param openId
	 * @return
	 */
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

	/**
	 * 根据会员卡id、卡主openId查询分享记录
	 * @param scId
	 * @param openId
	 * @return
	 */
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
	
	/**
	 * 根据会员卡id、卡主openId查询分享历史记录
	 * @param scId
	 * @param openId
	 * @return
	 */
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

	/**
	 * 根据openId查询商家消息
	 * @param flag
	 * @param openId
	 * @return
	 */
	@RequestMapping(value="/selectMerchantMessageList")
	@ResponseBody
	public Map<String, Object> selectMerchantMessageList(Integer flag, String shopId) {

		Map<String, Object> jsonMap = new HashMap<String, Object>();
		List<MerchantMessage> mmList=merchantMessageService.selectList(flag,shopId);

		if(mmList.size()==0) {
			jsonMap.put("message", "no");
		}
		else {
			jsonMap.put("message", "ok");
			jsonMap.put("data", mmList);
		}
		return jsonMap;
	}

	/**
	 * 确认消费金额（针对金额卡，用户到店消费后计算出消费金额，店家扫码后输入消费金额执行这个方法）
	 * @param shareMoney
	 * @param uuid
	 * @return
	 */
	@RequestMapping(value="/confirmConsumeMoney")
	@ResponseBody
	public Map<String, Object> confirmConsumeMoney(Float shareMoney, String uuid) {

		Map<String, Object> jsonMap = new HashMap<String, Object>();
		
		int count=shareRecordService.confirmConsumeMoney(shareMoney, uuid);
		
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

	/**
	 * 确认消费（包括金额卡、次卡，金额卡在确定消费金额后才执行这个方法）
	 * @param scType
	 * @param uuid
	 * @return
	 */
	@RequestMapping(value="/confirmConsumeShare")
	@ResponseBody
	public Map<String, Object> confirmConsumeShare(Integer scType, Integer shopId, String uuid) {

		Map<String, Object> jsonMap = new HashMap<String, Object>();
		ShareRecord sr=shareRecordService.getByUuid(uuid);
		
		int count=0;
		Integer scId = sr.getScId();
		String kzOpenId = sr.getKzOpenId();
		String fxzOpenId = sr.getFxzOpenId();
		Float yj = sr.getYj();
		Float hyj = sr.getHyj();
		Float shareMoney = sr.getShareMoney();
		Integer sfbfb = sr.getSfbfb();
		Float zdfxje = sr.getZdfxje();//最低分享金额，在卡主分享的金额不上浮情况下就等于分享金额，上浮的话，多出来的金额归卡主
		Integer shopFC = sr.getShopFC();//商家分成
		Integer discount = sr.getDiscount();
		Float deposit = sr.getDeposit();
		String phone = sr.getPhone();
		String createTime = sr.getCreateTime();
		String ygxfDate = sr.getYgxfDate();
		String qrcodeUrl = sr.getQrcodeUrl();

		Float ccPercent=tradeService.getCcPercentBySrUuid(uuid);
		count=shareCardService.confirmConsumeShare(sr);
		//金额卡和次卡的执行逻辑不同，需要用下面的代码区分
		if(count>0) {
			if(scType==MerchantCardType.CHONG_ZHI_KA) {//充值卡消费
				count=shareCardService.updateConsumeMoneyById(shareMoney,scId);//从卡主的会员卡里扣除相应金额，这个金额是扣除行业比率之前的金额
				Float fxzShareMoney = sr.getDeposit()-shareMoney;
				System.out.println("fxzShareMoney==="+fxzShareMoney);
				if(fxzShareMoney>0)
					vipService.updateWithDrawMoneyByOpenId(fxzShareMoney,fxzOpenId);//若从押金里扣除折扣后的金额后还有剩余的押金，就把剩余的押金转到分享者的账户里
				Float ccpMoney = shareMoney*ccPercent/100;
				Float kzje = shareMoney-ccpMoney;
				System.out.println("shareMoney==="+shareMoney);
				System.out.println("ccpMoney==="+ccpMoney);
				System.out.println("kzje==="+kzje);
				vipService.updateWithDrawMoneyByOpenId(kzje,kzOpenId);//分享金额-行业抽成=转给卡主的金额
			}
			else if(scType==MerchantCardType.CI_KA) {//次卡消费
				Float kzsfje = shareMoney-zdfxje;//分享金额-最低分享金额=多出来的分给卡主的金额
				Float sfje = zdfxje-hyj;//这部分是上浮金额，减去行业比率后按分成分给商家和卡主
				System.out.println("sfje==="+sfje);
				System.out.println("ccPercent==="+ccPercent);
				Float ccpMoney = sfje*ccPercent/100;
				Float sjkzje=sfje-ccpMoney;//分享消费金额-行业比率，剩余的金额就是转给商家、卡主的金额
				Float shopFCMoney = sjkzje*shopFC/100;//商家分成金额
				Float kzFCje = sjkzje-shopFCMoney;//卡主分成金额
				Float kzje = kzFCje+kzsfje;
				System.out.println("减去行业抽成前的上浮金额="+sfje);
				System.out.println("ccpMoney==="+ccpMoney);
				System.out.println("商家和卡主分成金额="+sjkzje);
				System.out.println("商家分成金额="+shopFCMoney);
				System.out.println("卡主分成金额="+kzFCje);
				System.out.println("卡主上浮金额="+kzsfje);
				System.out.println("转账给卡主的金额="+kzje);
				
				count=vipService.updateWithDrawMoneyByOpenId(kzje,kzOpenId);//这一部分金额属于卡主的，转账给卡主
				count=merchantService.updateWithDrawMoneyById(shopFCMoney,shopId);//
				
				count=shareCardService.updateConsumeCountById(scId);
			}
			
			ShareHistoryRecord shr=new ShareHistoryRecord();
			shr.setUuid(uuid);
			shr.setScId(scId);
			shr.setKzOpenId(kzOpenId);
			shr.setFxzOpenId(fxzOpenId);
			shr.setYj(yj);
			shr.setHyj(hyj);
			shr.setShareMoney(shareMoney);//这个金额是折扣后上浮后的金额
			shr.setSfbfb(sfbfb);
			shr.setZdfxje(zdfxje);
			shr.setShopFC(shopFC);
			shr.setDiscount(discount);
			shr.setDeposit(deposit);
			shr.setPhone(phone);
			shr.setCreateTime(createTime);
			shr.setYgxfDate(ygxfDate);
			shr.setQrcodeUrl(qrcodeUrl);
			count=shareHistoryRecordService.add(shr);
			count=shareRecordService.deleteByUuid(uuid);
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
	
	/**
	 * 确认办卡，用户到店领取实体卡时执行这个方法，改变办卡状态为已领取
	 * @param uuid
	 * @return
	 */
	@RequestMapping(value="/confirmHandleCard")
	@ResponseBody
	public Map<String, Object> confirmHandleCard(String uuid) {

		Map<String, Object> jsonMap = new HashMap<String, Object>();
		int count=handleRecordService.updateReceiveByUuid(uuid);

		if(count==0) {
			jsonMap.put("status", "no");
			jsonMap.put("message", "确认办卡失败！");
		}
		else {
			jsonMap.put("status", "ok");
			jsonMap.put("message", "已确认办卡！");
		}
		return jsonMap;
	}

	/**
	 * 删除资金流水记录（仅仅是将流水记录的状态变为已删除）
	 * @param srUuid
	 * @return
	 */
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

	/**
	 * 添加共享会员
	 * @param shareCard
	 * @return
	 */
	@RequestMapping(value="/addShareCard",produces="plain/text; charset=UTF-8")
	@ResponseBody
	public String addShareCard(ShareCard shareCard) {
		
		PlanResult plan=new PlanResult();
		String json=null;
		try {
			int count=shareCardService.add(shareCard);
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
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			plan.setStatus(0);
			plan.setMsg("添加共享会员失败！");
			json=JsonUtil.getJsonFromObject(plan);
		}
		return json;
	}

	/**
	 * 删除转让卡
	 * @param ids
	 * @return
	 */
	@RequestMapping(value="/deleteTransferCardByIds",produces="plain/text; charset=UTF-8")
	@ResponseBody
	public String deleteTransferCardByIds(String ids) {

		PlanResult plan=new PlanResult();
		String json;
		int count=transferCardService.deleteTransferCardByIds(ids);
		if(count==0) {
			plan.setStatus(0);
			plan.setMsg("删除转让信息失败！");
			json=JsonUtil.getJsonFromObject(plan);
		}
		else {
			plan.setStatus(1);
			plan.setMsg("删除转让信息成功！");
			json=JsonUtil.getJsonFromObject(plan);
		}
		return json;
	}

	/**
	 * 删除商家消息
	 * @param ids
	 * @return
	 */
	@RequestMapping(value="/deleteMerchantMessageByIds",produces="plain/text; charset=UTF-8")
	@ResponseBody
	public String deleteMerchantMessageByIds(String ids) {

		PlanResult plan=new PlanResult();
		String json;
		int count=merchantMessageService.deleteByIds(ids);
		if(count==0) {
			plan.setStatus(0);
			plan.setMsg("删除商家消息失败！");
			json=JsonUtil.getJsonFromObject(plan);
		}
		else {
			plan.setStatus(1);
			plan.setMsg("删除商家消息成功！");
			json=JsonUtil.getJsonFromObject(plan);
		}
		return json;
	}

	/**
	 * 根据openId验证商家审核状态
	 * @param openId
	 * @return
	 */
	@RequestMapping(value="/merchantCheck")
	@ResponseBody
	public Map<String, Object> merchantCheck(Integer id) {

		Map<String, Object> jsonMap = new HashMap<String, Object>();
		
		Merchant merchant=merchantService.getById(id);
		int shopCheck = merchant.getShopCheck();
		if(shopCheck==Merchant.SHEN_HE_TONG_GUO) {
			jsonMap.put("status", "ok");
		}
		else if(shopCheck==Merchant.SHEN_HE_BU_HE_GE) {
			jsonMap.put("status", "no");
			jsonMap.put("message", "商家审核未通过");
		}
		else if(shopCheck==Merchant.DAI_SHEN_HE) {
			jsonMap.put("status", "no");
			jsonMap.put("message", "商家审核中");
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
        System.out.println("微信支付----付款成功----");
        outSteam.close();
        inStream.close();
        String result = new String(outSteam.toByteArray(), "utf-8");// 获取微信调用我们notify_url的返回信息
        System.out.println("微信支付----result----=" + result);
        Map<String, String> map = WXPayUtil.xmlToMap(result);
        
        if (map.get("result_code").toString().equalsIgnoreCase("SUCCESS")) {
        	System.out.println("微信支付----返回成功");
            //if (verifyWeixinNotify(map)) {
                // 订单处理 操作 orderconroller 的回写操作?
                //logger.error("微信支付----验证签名成功");
                // backxml.put("return_code", "<![CDATA[SUCCESS]]>");
                // backxml.put("return_msg", "<![CDATA[OK]]>");
                // // 告诉微信服务器，我收到信息了，不要在调用回调action了
                // strbackxml = pay.ArrayToXml(backxml);
                // response.getWriter().write(strbackxml);
                // logger.error("微信支付 ~~~~~~~~~~~~~~~~执行完毕？backxml=" +
                // strbackxml);
 
 
	            // ====================================================================
		        // 通知微信.异步确认成功.必写.不然会一直通知后台.八次之后就认为交易失败了.
		        resXml = "<xml>" + "<return_code><![CDATA[SUCCESS]]></return_code>"
		                + "<return_msg><![CDATA[OK]]></return_msg>" + "</xml> ";
		        
		        outTradeNo=map.get("out_trade_no");
        		System.out.println("微信支付回调：订单号=" + outTradeNo);
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
	        		sr.setYj(nup.getYj());
	        		sr.setHyj(nup.getHyj());
	        		if(scType==5)
	        			sr.setShareMoney(nup.getShareMoney());
	        		else
	        			sr.setDeposit(nup.getDeposit());
	        		sr.setSfbfb(nup.getSfbfb());
	        		sr.setZdfxje(nup.getZdfxje());
	        		sr.setShopFC(nup.getShopFC());
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
        	System.out.println("支付失败,错误信息：" + map.get("err_code"));
	        resXml = "<xml>" + "<return_code><![CDATA[FAIL]]></return_code>"
	        	 + "<return_msg><![CDATA[报文为空]]></return_msg>" + "</xml> ";
        }
        // ------------------------------
        // 处理业务完毕
        // ------------------------------
        BufferedOutputStream out = new BufferedOutputStream(response.getOutputStream());
        out.write(resXml.getBytes());
        out.flush();
        out.close();
            

        
        
		//Map<String, Object> jsonMap = new HashMap<String, Object>();
		
		
        
        /*
        if(count==0) {
        	jsonMap.put("status", "no");
        	jsonMap.put("message", "分享失败！");
        }
        else {
        	jsonMap.put("status", "ok");
        	jsonMap.put("qrcodeUrl", avaPath);
        }
		return jsonMap;
		*/
	}

	/**
	 * 添加转让卡
	 * @param tc
	 * @return
	 */
	@RequestMapping(value="/addTransferCard")
	@ResponseBody
	public Map<String, Object> addTransferCard(TransferCard tc) {

		Map<String, Object> jsonMap = new HashMap<String, Object>();
		int count=transferCardService.add(tc);
        if(count==0) {
        	jsonMap.put("status", "no");
        	jsonMap.put("message", "添加失败！");
        }
        else {
        	jsonMap.put("status", "ok");
        	jsonMap.put("message", "添加成功！");
        }
		return jsonMap;
	}
	
	/**
	 * 添加转让记录
	 * @param lr
	 * @return
	 */
	@RequestMapping(value="/addTransferRecord")
	@ResponseBody
	public Map<String, Object> addTransferRecord(TransferRecord lr) {
		
		Map<String, Object> jsonMap = new HashMap<String, Object>();
		int count=transferRecordService.addTransferRecord(lr);
		if(count==0) {
			jsonMap.put("status", "no");
			jsonMap.put("message", "添加失败！");
		}
		else {
			jsonMap.put("status", "ok");
			jsonMap.put("message", "添加成功！");
		}
		return jsonMap;
	}

	/**
	 * 添加共享卡评论
	 * @param message
	 * @return
	 */
	@RequestMapping(value="/addComment")
	@ResponseBody
	public Map<String, Object> addComment(CardMessage message) {

		Map<String, Object> jsonMap = new HashMap<String, Object>();
		int count=cardMessageService.addComment(message);
		if(count==0) {
			jsonMap.put("status", "no");
			jsonMap.put("message", "评价失败！");
		}
		else {
			jsonMap.put("status", "ok");
			jsonMap.put("message", "评价成功！");
		}
		return jsonMap;
	}

	/**
	 * 添加门店评论
	 * @param mc
	 * @return
	 */
	@RequestMapping(value="/addMerComment")
	@ResponseBody
	public Map<String, Object> addMerComment(MerchantComment mc) {

		Map<String, Object> jsonMap = new HashMap<String, Object>();
		int count=merchantCommentService.add(mc);
		if(count==0) {
			jsonMap.put("status", "no");
			jsonMap.put("message", "评价失败！");
		}
		else {
			jsonMap.put("status", "ok");
			jsonMap.put("message", "评价成功！");
		}
		return jsonMap;
	}

	/**
	 * 根据门店id查询门店评论
	 * @param type
	 * @param shopId
	 * @return
	 */
	@RequestMapping(value="/selectMerComment")
	@ResponseBody
	public Map<String, Object> selectMerComment(Integer type, Integer shopId) {

		Map<String, Object> jsonMap = new HashMap<String, Object>();
		List<MerchantComment> mcList = merchantCommentService.selectMerComment(type,shopId);
		if(mcList.size()==0) {
			jsonMap.put("message", "no");
			jsonMap.put("data", "暂无评价！");
		}
		else {
			jsonMap.put("message", "ok");
			jsonMap.put("list", mcList);
		}
		return jsonMap;
	}

	/**
	 * 绑定支付宝（现在改为微信支付了，这个接口暂时用不到）
	 * @param user
	 * @return
	 */
	@RequestMapping(value="/bindAlipay",produces="plain/text; charset=UTF-8")
	@ResponseBody
	public String bindAlipay(Vip user) {

		String json=null;;
		try {
			PlanResult plan=new PlanResult();
			int count=vipService.bindAlipay(user);
			if(count==0) {
				plan.setStatus(0);
				plan.setMsg("绑定支付宝失败！");
				json=JsonUtil.getJsonFromObject(plan);
			}
			else {
				plan.setStatus(1);
				plan.setMsg("绑定支付宝成功！");
				json=JsonUtil.getJsonFromObject(plan);
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return json;
	}

	/**
	 * 商家注册
	 * @param merchant
	 * @param logo_inp
	 * @param yyzz_inp
	 * @param request
	 * @return
	 */
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
					if("成功".equals(fileJson.get("msg"))) {
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
				plan.setMsg("注册商家信息失败！");
				json=JsonUtil.getJsonFromObject(plan);
			}
			else {
				plan.setStatus(1);
				plan.setMsg("注册商家信息成功，等待审核！");
				json=JsonUtil.getJsonFromObject(plan);
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return json;
	}

	/**
	 * 商家编辑
	 * @param merchant
	 * @param logo_inp
	 * @param yyzz_inp
	 * @param request
	 * @return
	 */
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
					if("成功".equals(fileJson.get("msg"))) {
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
				plan.setMsg("编辑商家信息失败！");
				json=JsonUtil.getJsonFromObject(plan);
			}
			else {
				plan.setStatus(1);
				plan.setMsg("商家信息已编辑，等待审核！");
				json=JsonUtil.getJsonFromObject(plan);
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return json;
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
	 * 商家会员上下架操作
	 * @param id
	 * @param enable
	 * @return
	 */
	@RequestMapping(value="/updateMerCardEnableById")
	@ResponseBody
	public Map<String, Object> updateMerCardEnableById(Integer id, Boolean enable) {

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
	
	@RequestMapping(value="/enterMenu")
	public void enterMenu(HttpServletRequest request,HttpServletResponse response) throws IOException {

		System.out.println("in.....");
		ServletInputStream in = null;
		try {
			in = request.getInputStream();
		} catch (IOException e) {
			e.printStackTrace();
		}
		// 将POST流转换为XStream对象
		XStream xs = new XStream(new DomDriver());
		// 将指定节点下的xml节点数据映射为对象
		xs.alias("xml", InputMessage.class);
		// 将流转换为字符串
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
			// 设置编码
			request.setCharacterEncoding("utf-8");
			response.setContentType("html/text;charset=utf-8");
			response.setCharacterEncoding("utf-8");
			// 获取输出流
			PrintWriter printWriter = response.getWriter();

			// 设置一个全局的token,开发者自己设置。api这样解释：Token可由开发者可以任意填写，
			// 用作生成签名（该Token会和接口URL中包含的Token进行比对，从而验证安全性）
			String token = "cqgvs";
			// 根据api说明，获取上述四个参数
			String signature = request.getParameter("signature");
			String timestamp = request.getParameter("timestamp");
			String nonce = request.getParameter("nonce");
			String echostr = request.getParameter("echostr");
			
			System.out.println("signature======="+signature);
			System.out.println("timestamp======="+timestamp);
			System.out.println("nonce======="+nonce);
			System.out.println("echostr======="+echostr);
			
			// // temp:临时打印，观看返回参数情况
			// System.out.println(TAG + ":signature:" + signature +
			// ",timestamp:"
			// + timestamp + ",nonce:" + nonce + ",echostr:" + echostr);
			// 根据api所说的“加密/校验流程”进行接入。共计三步

			// 第一步:将token、timestamp、nonce三个参数进行字典序排序
			String[] parms = new String[] { token, timestamp, nonce };// 将需要字典序排列的字符串放到数组中
			Arrays.sort(parms);// 按照api要求进行字典序排序
			// 第二步:将三个参数字符串拼接成一个字符串进行sha1加密
			// 拼接字符串
			String parmsString = "";// 注意，此处不能=null。
			for (int i = 0; i < parms.length; i++) {
				parmsString += parms[i];
			}
			// sha1加密
			String mParms = null;// 加密后的结果
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
			// 字节数组转换为 十六进制 数
			for (int i = 0; i < messageDigest.length; i++) {
				String shaHex = Integer.toHexString(messageDigest[i] & 0xFF);
				if (shaHex.length() < 2) {
					hexString.append(0);
				}
				hexString.append(shaHex);
			}
			mParms = hexString.toString();// 加密结果

			/*
			 * api要求： 若确认此次GET请求来自微信服务器，请原样返回echostr参数内容， 则接入生效， 成为开发者成功，否则接入失败。
			 */
			// 第三步： 开发者获得加密后的字符串可与signature对比，标识该请求来源于微信接入成功。
			System.out.println(TAG + ":" + mParms + "---->" + signature);
			if (mParms.equals(signature)) {
				// System.out.println(TAG + ":" + mParms + "---->" + signature);
				printWriter.write(echostr);
			} else {
				// 接入失败,不用回写
				System.out.println(TAG + "接入失败");
			}
		}
		else{
		
			System.out.println("1111111111111");
			// 将xml内容转换为InputMessage对象
			InputMessage inputMsg = (InputMessage) xs.fromXML(xmlMsg.toString());
			// 取得消息类型
			// String msgType = inputMsg.getMsgType();
			// 根据消息类型获取对应的消息内容
			// 文本消息
			System.out.println("开发者微信号：" + inputMsg.getToUserName());
			System.out.println("发送方帐号：" + inputMsg.getFromUserName());
			System.out.println("消息创建时间：" + inputMsg.getCreateTime());
			System.out.println("消息内容：" + inputMsg.getContent());
			System.out.println("消息Id：" + inputMsg.getMsgId());
			System.out.println("key：" + inputMsg.getEventKey());
			
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
				a.setTitle("首页");
				a.setUrl(MCARDGX+"/CqgVipShare/vip/goPage?page=homeIndex&openId="+openId);// 该地址是点击图片跳转后
				a.setPicUrl(MCARDGX+"/CqgVipShare/resource/image/001.png");// 该地址是一个有效的图片地址
				a.setDescription("点击进入>>");
				articles.add(a);
				PicAndTextMsg picAndTextMsg = new PicAndTextMsg();
				picAndTextMsg.setToUserName(inputMsg.getFromUserName());// 发送和接收信息“User”刚好相反
				picAndTextMsg.setFromUserName(inputMsg.getToUserName());
				picAndTextMsg.setCreateTime(new Date().getTime());// 消息创建时间 （整型）
				picAndTextMsg.setMsgType("news");// 图文类型消息
				picAndTextMsg.setArticleCount(1);
				picAndTextMsg.setArticles(articles);
				// 第二步，将构造的信息转化为微信识别的xml格式
				XStream xStream = new XStream();
				xStream.alias("xml", picAndTextMsg.getClass());
				xStream.alias("item", a.getClass());
				String picAndTextMsg2Xml = xStream.toXML(picAndTextMsg);
				System.out.println(picAndTextMsg2Xml);
				// 第三步，发送xml的格式信息给微信服务器，服务器转发给用户
				PrintWriter printWriter = response.getWriter();
				printWriter.print(picAndTextMsg2Xml);
			}
			else if("Add_Share".equals(eventKey)) {
				List<Article> articles = new ArrayList<Article>();
				Article a = new Article();
				a.setTitle("发布共享");
				a.setUrl(MCARDGX+"/CqgVipShare/vip/toAddVip?openId="+openId);// 该地址是点击图片跳转后
				a.setPicUrl(MCARDGX+"/CqgVipShare/resource/image/001.png");// 该地址是一个有效的图片地址
				a.setDescription("点击进入>>");
				articles.add(a);
				PicAndTextMsg picAndTextMsg = new PicAndTextMsg();
				picAndTextMsg.setToUserName(inputMsg.getFromUserName());// 发送和接收信息“User”刚好相反
				picAndTextMsg.setFromUserName(inputMsg.getToUserName());
				picAndTextMsg.setCreateTime(new Date().getTime());// 消息创建时间 （整型）
				picAndTextMsg.setMsgType("news");// 图文类型消息
				picAndTextMsg.setArticleCount(1);
				picAndTextMsg.setArticles(articles);
				// 第二步，将构造的信息转化为微信识别的xml格式
				XStream xStream = new XStream();
				xStream.alias("xml", picAndTextMsg.getClass());
				xStream.alias("item", a.getClass());
				String picAndTextMsg2Xml = xStream.toXML(picAndTextMsg);
				System.out.println(picAndTextMsg2Xml);
				// 第三步，发送xml的格式信息给微信服务器，服务器转发给用户
				PrintWriter printWriter = response.getWriter();
				printWriter.print(picAndTextMsg2Xml);
			}
			else if("Merchant_Check".equals(eventKey)) {
				List<Article> articles = new ArrayList<Article>();
				Article a = new Article();
				a.setTitle("商家验证");
				a.setUrl(MCARDGX+"/CqgVipShare/vip/toScan?openId="+openId);// 该地址是点击图片跳转后
				a.setPicUrl(MCARDGX+"/CqgVipShare/resource/image/001.png");// 该地址是一个有效的图片地址
				a.setDescription("点击进入>>");
				articles.add(a);
				PicAndTextMsg picAndTextMsg = new PicAndTextMsg();
				picAndTextMsg.setToUserName(inputMsg.getFromUserName());// 发送和接收信息“User”刚好相反
				picAndTextMsg.setFromUserName(inputMsg.getToUserName());
				picAndTextMsg.setCreateTime(new Date().getTime());// 消息创建时间 （整型）
				picAndTextMsg.setMsgType("news");// 图文类型消息
				picAndTextMsg.setArticleCount(1);
				picAndTextMsg.setArticles(articles);
				// 第二步，将构造的信息转化为微信识别的xml格式
				XStream xStream = new XStream();
				xStream.alias("xml", picAndTextMsg.getClass());
				xStream.alias("item", a.getClass());
				String picAndTextMsg2Xml = xStream.toXML(picAndTextMsg);
				System.out.println(picAndTextMsg2Xml);
				// 第三步，发送xml的格式信息给微信服务器，服务器转发给用户
				PrintWriter printWriter = response.getWriter();
				printWriter.print(picAndTextMsg2Xml);
			}
		}
	}
	
	/**
	 * 获取微信用户信息
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
		 * 获取access_token值
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
		    System.out.println("获取token成功");
			String resContent = httpClientToken.getResContent();
			System.out.println("resContent：" + resContent);
			//access_token = JsonUtil.getJsonValue(resContent, "access_token");
			access_token = new org.json.JSONObject(resContent).getString("access_token");
			System.out.println("token：" + access_token);
		}
		System.out.println("获取的token值为:" + access_token);
		
		
		/**
		 * 获取用户信息
		 */
		String nickname = "";
		String headimgurl = "";
		String userInfoUrl = "https://api.weixin.qq.com/cgi-bin/user/info?access_token=" + access_token + "&openid=" + openid + "&lang=zh_CN";
		TenpayHttpClient httpClientUser = new TenpayHttpClient();																
		httpClientUser.setMethod("GET");
		httpClientUser.setReqContent(userInfoUrl);
        if (httpClientUser.call()) {
            System.out.println("获取用户信息成功");
            String resContent = httpClientUser.getResContent();
            System.out.println("resContent：" + resContent);
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

	/**
	 * 根据openId查询用户信息
	 * @param openId
	 * @return
	 */
	@RequestMapping(value="/queryVipFromDB")
	@ResponseBody
	public Map<String, Object> queryVipFromDB(String openId) {

		Map<String, Object> jsonMap = new HashMap<String, Object>();
		Vip vip = vipService.getByOpenId(openId);
		
        jsonMap.put("vip", vip);
        
        return jsonMap;
	}
	
	/**
	 * 编辑微信公众号菜单（这个接口可以通过浏览器用get方式直接调用）
	 * @param appid
	 * @param appsecret
	 * @return
	 */
	@RequestMapping(value="/editWeixinMenu")
	@ResponseBody
	public Map<String, Object> editWeixinMenu(String appid, String appsecret) {

		Map<String, Object> jsonMap = new HashMap<String, Object>();
		
		//http://localhost:8080/CqgVipShare/vip/editWeixinMenu?appid=APPID&appsecret=SECRET
		//http://www.qrcodesy.com:8080/CqgVipShare/vip/editWeixinMenu?appid=wxf600e162d89732da&appsecret=097ee3404400bdf4b75ac8cfb0cc1c26
		//String viewUrl1="https://open.weixin.qq.com/connect/oauth2/authorize?appid=APPID&redirect_uri=http://www.mcardgx.com:8080/CqgVipShare/vip/goPageFromWXMenu?goPage=";
		//String viewUrl2="&response_type=code&scope=snsapi_base&state=1&connect_redirect=1#wechat_redirect";
		String viewUrl="http://www.mcardgx.com:8080/CqgVipShare/vip/goPageFromWXMenu?goPage=";
		WeChatUtil weChatUtil = new WeChatUtil();
		//String jsonMenu = "{\"button\":[{\"type\":\"view\",\"name\":\"分享主页1\",\"url\":\""+viewUrl1+"homeIndex"+viewUrl2+"\"},";
		String jsonMenu = "{\"button\":[{\"type\":\"view\",\"name\":\"分享主页\",\"url\":\""+viewUrl+"homeIndex\"},";
			jsonMenu+="{\"type\":\"view\",\"name\":\"发布共享\",\"url\":\""+viewUrl+"tradeList\"},";
			jsonMenu+="{\"type\":\"view\",\"name\":\"商家验证\",\"url\":\""+viewUrl+"mineMerchantCenter\"}";
			jsonMenu+="]}";
		int count = weChatUtil.createMenu(appid, appsecret, jsonMenu);
		System.out.println("count==="+count);
		if(count==0){
			jsonMap.put("message", "no");
			jsonMap.put("info", "请核实appid值和appsecret值是否正确！");
		}else{
			jsonMap.put("message", "ok");
			jsonMap.put("info", "公众号提交成功！");
		}
		return jsonMap;
	}

	/**
	 * 根据行业id查询门店列表（包括热门门店、更多门店）
	 * @param tradeId
	 * @return
	 */
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

	/**
	 * 查询所有行业下的热门门店
	 * @return
	 */
	@RequestMapping(value="/selectHotShopList")
	@ResponseBody
	public Map<String, Object> selectHotShopList(Double myLatitude,Double myLongitude) {

		Map<String, Object> jsonMap = new HashMap<String, Object>();
		List<Merchant> hotList=merchantService.selectHotShopList(myLatitude,myLongitude);

		if(hotList.size()==0) {
			jsonMap.put("message", "no");
		}
		else {
			jsonMap.put("message", "ok");
			jsonMap.put("data", hotList);
		}
		return jsonMap;
	}

	/**
	 * 根据分享者openId取消分享单，状态变为待取消
	 * @param srUuid
	 * @param content
	 * @param fxzOpenId
	 * @return
	 */
	@RequestMapping(value="/canncelShareVip")
	@ResponseBody
	public Map<String, Object> canncelShareVip(String srUuid, String content, String fxzOpenId) {

		Map<String, Object> jsonMap = new HashMap<String, Object>();
		int count=capFlowRecService.canncelShareVip(srUuid,content,fxzOpenId);
		if(count==0) {
			jsonMap.put("status", "no");
			jsonMap.put("message", "取消失败！");
		}
		else {
			jsonMap.put("status", "ok");
			jsonMap.put("message", "取消成功，待卡主确认！");
		}
		return jsonMap;
	}

	/**
	 * 确认取消分享单
	 * @param cfr
	 * @return
	 */
	@RequestMapping(value="/confirmCanShareVip")
	@ResponseBody
	public Map<String, Object> confirmCanShareVip(CapitalFlowRecord cfr) {

		Map<String, Object> jsonMap = new HashMap<String, Object>();
		int count=capFlowRecService.confirmCanShareVip(cfr);
		if(count==0) {
			jsonMap.put("status", "no");
			jsonMap.put("message", "确认取消失败！");
		}
		else {
			jsonMap.put("status", "ok");
			jsonMap.put("message", "确认取消成功！");
		}
		return jsonMap;
	}

	/**
	 * 验证商家用户名是否存在
	 * @param userName
	 * @return
	 */
	@RequestMapping(value="/checkUserNameExist")
	@ResponseBody
	public Map<String, Object> checkUserNameExist(String userName) {

		Map<String, Object> jsonMap = new HashMap<String, Object>();
		boolean bool=merchantService.checkUserNameExist(userName);
		if(bool) {
			jsonMap.put("status", "no");
			jsonMap.put("message", "用户名已注册");
		}
		else {
			jsonMap.put("status", "ok");
		}
		return jsonMap;
	}

	/**
	 * 编辑用户签名
	 * @param signTxt
	 * @param openId
	 * @return
	 */
	@RequestMapping(value="/editVipSignTxt")
	@ResponseBody
	public Map<String, Object> editVipSignTxt(String signTxt, String openId) {

		Map<String, Object> jsonMap = new HashMap<String, Object>();
		int count=vipService.editVipSignTxt(signTxt, openId);
		if(count>0) {
			jsonMap.put("status", "ok");
			jsonMap.put("message", "编辑签名成功！");
		}
		else {
			jsonMap.put("status", "no");
			jsonMap.put("message", "编辑签名失败！");
		}
		return jsonMap;
	}

	/**
	 * 根据门店id查询门店下的会员类型
	 * @param shopId
	 * @return
	 */
	@RequestMapping(value="/selectMerCardType")
	@ResponseBody
	public Map<String, Object> selectMerCardType(Integer shopId, String selectAction) {

		Map<String, Object> jsonMap = new HashMap<String, Object>();
		List<MerchantCardType> mctList = merchantCardTypeService.selectList(shopId,selectAction);

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
	 * 根据门店id、会员类型查询门店下的会员卡
	 * @param shopId
	 * @return
	 */
	@RequestMapping(value="/selectMerCardSel")
	@ResponseBody
	public Map<String, Object> selectMerCardSel(Integer shopId, Integer type) {

		Map<String, Object> jsonMap = new HashMap<String, Object>();
		List<MerchantCard> mcList = merchantCardService.selectList(type, shopId);

		if(mcList.size()==0) {
			jsonMap.put("message", "no");
		}
		else {
			jsonMap.put("message", "ok");
			jsonMap.put("data", mcList);
		}
		return jsonMap;
	}
	
	/**
	 * 查询门店流水记录
	 * @param shopId
	 * @param startTime
	 * @param endTime
	 * @return
	 */
	@RequestMapping(value="/selectFlowRecList")
	@ResponseBody
	public Map<String, Object> selectFlowRecList(Integer shopId,String startTime,String endTime) {
		
		Map<String, Object> jsonMap = new HashMap<String, Object>();
		List<CapitalFlowRecord> cfrList=capFlowRecService.selectFlowRecList(shopId, startTime, endTime);
		
		if(cfrList.size()>0) {
			jsonMap.put("message", "ok");
			jsonMap.put("data", cfrList);
		}
		else {
			jsonMap.put("message", "no");
			jsonMap.put("info", "暂无数据");
		}
		
		return jsonMap;
	}
	
	/**
	 * 查询办卡记录
	 * @param mcName
	 * @param mcType
	 * @param createTimeStart
	 * @param createTimeEnd
	 * @param receive
	 * @param shopId
	 * @return
	 */
	@RequestMapping(value="/selectHanRecList")
	@ResponseBody
	public Map<String, Object> selectHanRecList(String mcName,Integer mcType,String createTimeStart,String createTimeEnd,Boolean receive,Integer shopId) {
		
		Map<String, Object> jsonMap = new HashMap<String, Object>();
		List<HandleRecord> hrList=handleRecordService.selectList(mcName, mcType, shopId, createTimeStart, createTimeEnd, receive);

		if(hrList.size()>0) {
			jsonMap.put("message", "ok");
			jsonMap.put("data", hrList);
		}
		else {
			jsonMap.put("message", "no");
			jsonMap.put("info", "暂无数据");
		}
			
		return jsonMap;
	}
	
	/**
	 * 根据卡类型验证门店下是否存在该会员卡
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
	
	@RequestMapping(value="/selectMerCardList")
	@ResponseBody
	public Map<String, Object> selectMerCardList(String name,Integer type,Integer shopId) {
		
		Map<String, Object> jsonMap = new HashMap<String, Object>();
		List<MerchantCard> mcList=merchantCardService.selectList(name, type, shopId);

		if(mcList.size()>0) {
			jsonMap.put("message", "ok");
			jsonMap.put("data", mcList);
		}
		else {
			jsonMap.put("message", "no");
			jsonMap.put("info", "暂无数据");
		}
			
		return jsonMap;
	}
	
	/**
	 * 支付宝支付
	 * 参考链接：https://blog.csdn.net/quyan2017/article/details/85720680
	 * 支付宝支付相关代码:https://blog.csdn.net/weixin_41357729/article/details/80419742
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
			
			//商户订单号，商户网站订单系统中唯一订单号，必填
			String out_trade_no = cfrIdSDF.format(new Date());
			//付款金额，必填
			String total_amount = "0.01";
			//订单名称，必填
			String subject = "aaa";
			//商品描述，可空
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
			order.put("subject", "竞浪男童平角泳裤");
			order.put("product_code", "QUICK_WAP_WAY");
			order.put("body", "儿童泳装|泳具");
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
				//在公共参数中设置回跳和通知地址
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
			paraMap.put("out_trade_no", outTradeNo);//订单号
			 
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
				notifyUrlParam.setYj(sr.getYj());
				notifyUrlParam.setHyj(sr.getHyj());
				if(scType==5)
					notifyUrlParam.setShareMoney(sr.getShareMoney());
				else
					notifyUrlParam.setDeposit(sr.getDeposit());
				notifyUrlParam.setSfbfb(sr.getSfbfb());
				notifyUrlParam.setZdfxje(sr.getZdfxje());
				notifyUrlParam.setShopFC(sr.getShopFC());
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
				//在公共参数中设置回跳和通知地址
				paraMap.put("notify_url",WXPayConfig.notifyUrl);// 此路径是微信服务器调用支付结果通知路径随意写
				//addRecord
			}
			 
			String sign = WXPayUtil.generateSignature(paraMap, wxpc.getKey());
			 
			paraMap.put("sign", sign);
			 
			String xml = WXPayUtil.mapToXml(paraMap);//将所有参数(map)转xml格式
			 
			 
			 
			// 统一下单 https://api.mch.weixin.qq.com/pay/unifiedorder
			 
			String unifiedorder_url = "https://api.mch.weixin.qq.com/pay/unifiedorder";
			 
			 
			 
			String xmlStr = HttpRequest.sendPost(unifiedorder_url, xml);//发送post请求"统一下单接口"返回预支付id:prepay_id
			 
			 
			 
			//以下内容是返回前端页面的json数据
			 
			String prepay_id = "";//预支付id
			 
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

	@RequestMapping(value="/goMerBindWX")
	public String goMerBindWX() {
		
		return "vip/mine/merchant/bindWX";
	}

	@RequestMapping(value="/goMerRemoveBind")
	public String goMerRemoveBind(HttpServletRequest request) {

		Integer merchantId = Integer.valueOf(request.getParameter("merchantId"));
		Merchant mer = merchantService.getById(merchantId);
		request.setAttribute("merchant", mer);
		
		return "vip/mine/merchant/removeBind";
	}
	
	@RequestMapping(value="/unBindMerWX")
	@ResponseBody
	public Map<String, Object> unBindMerWX(Integer id) {

		Map<String, Object> jsonMap = new HashMap<String, Object>();
		
		int count=merchantService.updateOpenIdById(null,id);
		if(count>0) {
			jsonMap.put("message", "ok");
			jsonMap.put("info", "解除绑定成功！");
		}
		else {
			jsonMap.put("message", "no");
			jsonMap.put("info", "解除绑定失败！");
		}
		return jsonMap;
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
			jsonMap.put("message", "存值成功！");
		}
		else {
			jsonMap.put("status", "no");
			jsonMap.put("message", "存值失败！");
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
	
	@RequestMapping(value="/checkMerPassword")
	@ResponseBody
	public Map<String, Object> checkMerPassword(String password, Integer merchantId) {
		
		Map<String, Object> jsonMap = new HashMap<String, Object>();
		boolean bool=merchantService.checkPwdById(password,merchantId);
		
		if(bool) {
			jsonMap.put("status", "ok");
		}
		else {
			jsonMap.put("status", "no");
			jsonMap.put("message", "原密码错误！");
		}
		return jsonMap;
	}
	
	@RequestMapping(value="/updateMerPwdById",method=RequestMethod.POST,produces="plain/text; charset=UTF-8")
	@ResponseBody
	public String updateMerPwdById(String password, Integer merchantId) {
		int count = merchantService.updatePwdById(password,merchantId);
		
		PlanResult plan=new PlanResult();
		if(count==0) {
			plan.setStatus(0);
			plan.setMsg("修改密码失败");
		}
		else {
			plan.setStatus(1);
			plan.setMsg("修改密码成功，重新登录生效！是否重新登录？");
		}
		return JsonUtil.getJsonFromObject(plan);
	}
	
	/**
	 * 微信用户申请提现
	 * 参考链接1：https://www.jianshu.com/p/4b9bc75f2343
	 * 参考链接2：https://blog.csdn.net/qq_41187907/article/details/79978739
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
            // 1.计算参数签名
		 	//wxwdc.setOpenId("oNFEuwzkbP4OTTjBucFgBTWE5Bqg");
		 	//wxwdc.setAmount(100);
		 	//wxwdc.setDesc("企业付款到零钱");
			String openId = request.getParameter("openId");
		 	wxwdc.setOpenId(openId);
		 	wxwdc.setAmount((int)(Float.valueOf(request.getParameter("amount"))*100));
		 	wxwdc.setDesc(request.getParameter("desc"));
		 	
		 	//微信官方API文档 https://pay.weixin.qq.com/wiki/doc/api/tools/mch_pay.php?chapter=14_2
            String paramStr = WechatpayUtil.createLinkString(wxwdc);
            String mysign = paramStr + "&key=" + wxwdc.getAppkey();
            String sign = DigestUtils.md5Hex(mysign).toUpperCase();
	
            // 2.封装请求参数
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
            // 3.加载证书请求接口
            String result = HttpRequestHandler.httpsRequest(wxwdc.getTransfersUrl(), reqXmlStr.toString(),
            		wxwdc, wxwdc.getCertPath());
            System.out.println("response xml = " + result);
            if(result.contains("CDATA[FAIL]")){
	            resultMap.put("status", "no");
	            resultMap.put("message", "调用微信接口失败, 具体信息请查看访问日志");
            }
            else {
            	vipService.updateWithDrawMoneyByOpenId(-Float.valueOf(wxwdc.getAmount()),openId);
                resultMap.put("status", "ok");
                resultMap.put("message", "执行成功！");
            }
        }
        catch (Exception e){
            e.printStackTrace();
            resultMap.put("status", "no");
            resultMap.put("message", "执行失败！");
        }
		finally {
			return resultMap;
		}
	}
	
	/**
	 * 支付宝用户申请提现
	 * 参考链接：https://www.cnblogs.com/wqy415/p/7940633.html
	 * @param request
	 * @param response
	 */
	@RequestMapping(value="/userAlipayWithDraw")
	public void userAlipayWithDraw(HttpServletRequest request, HttpServletResponse response) {
		String openId = request.getParameter("openId");
		try {
			AlipayClient alipayClient = new DefaultAlipayClient(AlipayConfig.URL,AlipayConfig.APPID,AlipayConfig.RSA_PRIVATE_KEY, AlipayConfig.FORMAT, AlipayConfig.CHARSET, AlipayConfig.ALIPAY_PUBLIC_KEY, AlipayConfig.SIGNTYPE);
			AlipayFundTransToaccountTransferRequest alipayRequest = new AlipayFundTransToaccountTransferRequest();
			
			//商户订单号，商户网站订单系统中唯一订单号，必填
			String out_biz_no = cfrIdSDF.format(new Date());
			//支付宝账户，必填
			String payee_account = request.getParameter("alipayNo");
			//真实姓名，必填
			String payee_real_name = request.getParameter("realName");
			//提现金额，必填
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
			
			order.put("payer_show_name", "用户红包提现");
			order.put("payee_real_name", payee_real_name);
			//order.put("payee_real_name", "逄坤");
			order.put("remark", "红包提现到支付宝");
			
			alipayRequest.setBizContent(order.toString());
			
			vipService.updateWithDrawMoneyByOpenId(-Float.valueOf(amount), openId);
			//https://blog.csdn.net/u010533511/article/details/47904217
			//在公共参数中设置回跳和通知地址
			//alipayRequest.setNotifyUrl(MCARDGX+":8080/CqgVipShare/vip/updateWithDrawMoneyByOpenId?withDrawMoney="+amount+"&openId="+openId);
			//alipayRequest.setReturnUrl(MCARDGX+":8080/CqgVipShare/vip/goPage?page=mineCenter&openId="+openId);
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
	 * 支付宝转账
	 * 参考链接1：https://opendocs.alipay.com/apis/api_28/alipay.fund.trans.uni.transfer/
	 * 参考链接2：https://blog.csdn.net/zhengchanmin/article/details/107962287
	 * https://blog.csdn.net/yangxiaovip/article/details/104897230
	 * https://mvnrepository.com/artifact/com.alipay.sdk/alipay-sdk-java/4.11.0.ALL
	 * 这个接口需要加载公钥证书签名，否则会报isv.missing-app-cert-sn(缺少应用公钥证书序列号)错误，调用起来比较麻烦，暂时改用提现接口
	 * RSA2和公钥证书签名验签的区别参考以下链接：
	 * https://opensupport.alipay.com/support/helpcenter/192/201602493592?ant_source=antsupport#
	 */
	@RequestMapping(value="/transfer")
	public void transfer() {
		try {
			CertAlipayRequest certAlipayRequest = new CertAlipayRequest();
	        certAlipayRequest.setServerUrl(AlipayConfig.URL);
	        certAlipayRequest.setAppId(AlipayConfig.APPID);
	        certAlipayRequest.setPrivateKey(AlipayConfig.RSA_PRIVATE_KEY);
	        certAlipayRequest.setFormat(AlipayConfig.FORMAT);
	        certAlipayRequest.setCharset(AlipayConfig.CHARSET);
	        certAlipayRequest.setSignType(AlipayConfig.SIGNTYPE);
	        certAlipayRequest.setCertPath(AlipayConfig.CERT_PATH);//应用公钥证书绝对路径
	        certAlipayRequest.setAlipayPublicCertPath(AlipayConfig.ALIPAY_PUBLIC_CERT_PATH);//支付宝公钥证书绝对路径
	        certAlipayRequest.setRootCertPath(AlipayConfig.ROOT_CERT_PATH);//支付宝根证书绝对路径
	        DefaultAlipayClient alipayClient = new DefaultAlipayClient(certAlipayRequest);
			//AlipayClient alipayClient = new DefaultAlipayClient(AlipayConfig.URL,AlipayConfig.APPID,AlipayConfig.RSA_PRIVATE_KEY,AlipayConfig.FORMAT,AlipayConfig.CHARSET,AlipayConfig.ALIPAY_PUBLIC_KEY,AlipayConfig.SIGNTYPE);
			AlipayFundTransUniTransferRequest request = new AlipayFundTransUniTransferRequest();
			//商户订单号，商户网站订单系统中唯一订单号，必填
			String out_trade_no = cfrIdSDF.format(new Date());
			request.setBizContent("{" +
			"\"out_biz_no\":\""+out_trade_no+"\"," +
			"\"trans_amount\":0.01," +
			"\"product_code\":\"TRANS_ACCOUNT_NO_PWD\"," +
			"\"biz_scene\":\"DIRECT_TRANSFER\"," +
			"\"order_title\":\"转账标题\"," +
			//"\"original_order_id\":\""+out_trade_no+"\"," +
			"\"payee_info\":{" +
			"\"identity\":\"18765943028\"," +
			"\"identity_type\":\"ALIPAY_LOGON_ID\"," +
			"\"name\":\"逄坤\"" +
			"    }," +
			"\"remark\":\"单笔转账\"," +
			"\"business_params\":\"{\\\"sub_biz_scene\\\":\\\"REDPACKET\\\"}\"" +
			"  }");
			AlipayFundTransUniTransferResponse response = alipayClient.certificateExecute(request);
			//{"alipay_fund_trans_uni_transfer_response":{"code":"10000","msg":"Success","order_id":"20210419110070000006810045951694","out_biz_no":"20210419103847","pay_fund_order_id":"20210419110070001506810061218762","status":"SUCCESS","trans_date":"2021-04-19 10:39:01"},"alipay_cert_sn":"9e7fbb1857d99dc507953866161303c5","sign":"dfR4O/s1Z4SoQAEzzR0uLvb2Wd/PLMhZH1mGAyd4GwHQnDp55M/nFvR6vFytWI5ed8vitnIry+R+5JkzBwqyiTp5rifMDfGvYYhWDmZST6qNQUAvpDgdIn20yHsSywnivg4GbjchWoIncDKW3UEPNr7DlKVeG5rjlZL1xur/rT7JZSqkVeM74gdJ+M519PVSc6bx5cjsM8/d83hPd4Ytkj/nRvXWc4y/nQZ2AobcORjyJcbj7jTnGZBNIWkql5X68rCIAahhc2tpHv7BlQj/oZu5ciY57wdHqlieKurqwo2uCt9RyZUE1C/yrYJa8VQkGaicXedx1M/rx3IDdTtwUA=="}
			if(response.isSuccess()){
				System.out.println("调用成功");
			} else {
				System.out.println("调用失败");
			}
		} catch (AlipayApiException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	@RequestMapping(value="/bindMerWX")
	public String bindMerWX(HttpServletRequest request) {

		String url=null;
		String code = request.getParameter("code");
		Integer merchantId = Integer.valueOf(request.getParameter("merchantId"));
		if(StringUtils.isEmpty(code)) {
			url="redirect:https://open.weixin.qq.com/connect/oauth2/authorize?appid="+APPID+"&redirect_uri=http://www.mcardgx.com/getCode.asp?params=bindMerWX,"+merchantId+"&response_type=code&scope=snsapi_base&state=1&connect_redirect=1#wechat_redirect";
		}
		else {
			JSONObject obj = JSONObject.fromObject(MethodUtil.httpRequest("https://api.weixin.qq.com/sns/oauth2/access_token?appid="+APPID+"&secret="+SECRET+"&code="+code+"&grant_type=authorization_code"));
			String openId = obj.getString("openid");
			System.out.println("openId======"+openId);
			boolean exist=merchantService.checkOpenIdExist(openId);
			if(exist) {
				request.setAttribute("status", "no");
				request.setAttribute("message", "你的微信号已绑定其他商家账号");
			}
			else {
				merchantService.updateOpenIdById(openId,merchantId);
				
				request.setAttribute("status", "ok");
				request.setAttribute("message", "你已成功绑定商家账号");
			}
			url=MERCHANT_PATH+"/bindStatus";
		}
		return url;
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
			url="redirect:https://open.weixin.qq.com/connect/oauth2/authorize?appid="+APPID+"&redirect_uri=http://www.mcardgx.com/getCode.asp?params=goPage,"+goPage+"&response_type=code&scope=snsapi_base&state=1&connect_redirect=1#wechat_redirect";
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
	 * 获得应用公钥
	 * 参考链接：https://blog.csdn.net/c5113620/article/details/80384668
	 */
	public void getAppPublicKey() {
		try {
			//
			CertificateFactory cf = CertificateFactory.getInstance("X.509");
			X509Certificate cert = (X509Certificate)cf.generateCertificate(new FileInputStream("E:\\我的文件\\会员卡共享平台\\证书文件\\应用公钥证书\\appCertPublicKey_2016080600178660.crt"));
			PublicKey publicKey = cert.getPublicKey();
			//System.out.println("publicKey==="+publicKey);
			BASE64Encoder base64Encoder=new BASE64Encoder();
			String publicKeyString = base64Encoder.encode(publicKey.getEncoded());
			System.out.println("-----------------公钥--------------------");
			System.out.println(publicKeyString);
			System.out.println("-----------------公钥--------------------");
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
	*/
	
	public static void main(String[] args) {
		try {
			/*
			String s="https://openapi.alipay.com/gateway.do?charset=UTF-8&method=alipay.fund.trans.toaccount.transfer&sign=AHfexcML%2F1nzjB8dfL0oaH%2BZPJOIgARCnJRmizTrFF1ImgQ1h5oR39buLqdYFVcYllgQ8aY2o4uGJNgBetKWYJSspQ5iLwV9JZ0JOuYk9aW66Fgt8kj%2BAaW55mc22wY750LyYulzgN3y5hjG7cizW1r2%2FCVsjzVE2MEYGU9sLCF1%2BRgYC7NRj26gtw6xexYALegjbLFAvtCUvC7l3alGt5TmM1qs41Y8AEmOIJO10RCJ%2Fc%2FpI6NCKBQ4Vv%2Fyt6wzRShR0Nju637L8AdKQPtFWwpIFwPo50obUs2Qu4un9YrZHWtOdFfnTJfmCcNgYaukCeZt7FqDT53THAgHFzOPJQ%3D%3D&version=1.0&app_id=2019122160177031&sign_type=RSA2&timestamp=2020-12-30+17%3A04%3A16&alipay_sdk=alipay-easysdk-java&format=json";
			System.out.println(URLDecoder.decode(s,"gbk"));
			
			File file = new File("d:/111.txt");
			FileOutputStream fos = new FileOutputStream(file);
			byte[] sArr = s.getBytes();
			fos.write(sArr);;
			fos.flush();
			fos.close();
			 */
			String app_cert_sn=AlipaySignature.getCertSN(AlipayConfig.ROOT_CERT_PATH);
			System.out.println("app_cert_sn:"+ app_cert_sn);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
