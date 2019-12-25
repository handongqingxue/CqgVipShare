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
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alipay.api.AlipayApiException;
import com.alipay.api.AlipayClient;
import com.alipay.api.DefaultAlipayClient;
import com.alipay.api.request.AlipayTradeWapPayRequest;
import com.cqgVipShare.entity.Article;
import com.cqgVipShare.entity.InputMessage;
import com.cqgVipShare.entity.LeaseRelation;
import com.cqgVipShare.entity.PicAndTextMsg;
import com.cqgVipShare.entity.ShareHistoryRecord;
import com.cqgVipShare.entity.ShareRecord;
import com.cqgVipShare.entity.ShareVip;
import com.cqgVipShare.entity.Trade;
import com.cqgVipShare.entity.User;
import com.cqgVipShare.service.UtilService;
import com.cqgVipShare.service.VipService;
import com.cqgVipShare.util.AlipayConfig;
import com.cqgVipShare.util.JsonUtil;
import com.cqgVipShare.util.PlanResult;
import com.cqgVipShare.util.TenpayHttpClient;
import com.cqgVipShare.util.WeChatUtil;
import com.cqgVipShare.util.qrcode.Qrcode;
import com.thoughtworks.xstream.XStream;
import com.thoughtworks.xstream.io.xml.DomDriver;

import net.sf.json.JSONObject;

@Controller
@RequestMapping("/vip")
public class VipController {

	String TAG = "VipController";
	public static final String MCARDGX="http://www.mcardgx.com";
	
	@Autowired
	private VipService vipService;
	@Autowired
	private UtilService utilService;
	
	//https://www.cnblogs.com/lyr1213/p/9186330.html

	/**
	 * 跳转至登录页面
	 * @return
	 */
	@RequestMapping(value="/login",method=RequestMethod.GET)
	public String login() {
		return "/admin/login";
	}
	
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
			User user=(User)SecurityUtils.getSubject().getPrincipal();
			session.setAttribute("user", user);
			
			plan.setStatus(0);
			plan.setMsg("验证通过");
			plan.setUrl("/admin/toShopCheckList");
			return JsonUtil.getJsonFromObject(plan);
		}
		plan.setStatus(1);
		plan.setMsg("验证码错误");
		return JsonUtil.getJsonFromObject(plan);
	}
	
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
	public String toEditMerchant(String openId, HttpServletRequest request) {
		
		User user=vipService.getUserInfoByOpenId(openId);
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
	public String toQrcodeInfo(String openId, String uuid, HttpServletRequest request) {
		
		String url=null;
		ShareRecord sr = vipService.getShareRecordByUuid(uuid);
		if(sr==null) {
			url="/vip/qrcodeUsed";
		}
		else {
			User user = vipService.getUserInfoByOpenId(openId);
			request.setAttribute("user", user);
			url="/vip/qrcodeInfo";
		}
		
		return url;
	}

	@RequestMapping(value="/toShareList")
	public String toShareList() {

		return "/vip/shareList";
	}
	
	@RequestMapping(value="/toShopList")
	public String toShopList() {
		
		return "/vip/shopList";
	}
	
	@RequestMapping(value="/toLeaseList")
	public String toLeaseList() {
		
		return "/vip/leaseList";
	}
	
	@RequestMapping(value="/toAddLease")
	public String toAddLease() {
		
		return "/vip/addLeaseRelation";
	}
	
	@RequestMapping(value="/toSRDetail")
	public String toSRDetail(String uuid, HttpServletRequest request) {
		
		ShareRecord sr=vipService.getSRDetailByUuid(uuid);
		request.setAttribute("shareRecord", sr);
		
		return "/vip/srDetail";
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

	@RequestMapping(value="/selectLeaseList")
	@ResponseBody
	public Map<String, Object> selectLeaseList() {

		Map<String, Object> jsonMap = new HashMap<String, Object>();
		List<LeaseRelation> lrList=vipService.selectLeaseList();

		if(lrList.size()==0) {
			jsonMap.put("status", "no");
		}
		else {
			jsonMap.put("status", "ok");
			jsonMap.put("data", lrList);
		}
		return jsonMap;
	}
	
	@RequestMapping(value="/selectShareListByOpenId")
	@ResponseBody
	public Map<String, Object> selectShareListByOpenId(String openId) {
		
		Map<String, Object> jsonMap = new HashMap<String, Object>();
		List<ShareRecord> shareList=vipService.selectShareListByFxzOpenId(openId);
		
		if(shareList.size()==0) {
			jsonMap.put("message", "no");
			jsonMap.put("info", "暂无共享单");
		}
		else {
			jsonMap.put("message", "ok");
			jsonMap.put("data", shareList);
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
		shr.setUuid(uuid);
		shr.setVipId(sr.getVipId());
		shr.setKzOpenId(sr.getKzOpenId());
		shr.setFxzOpenId(sr.getFxzOpenId());
		shr.setShareMoney(sr.getShareMoney());
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
	public Map<String, Object> merchantCheck(String openId) {

		Map<String, Object> jsonMap = new HashMap<String, Object>();
		
		boolean bool=vipService.merchantCheck(openId);
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
		String url=basePath+"vip/toQrcodeInfo?openId="+sr.getKzOpenId()+"&uuid="+uuid;
		String fileName = new SimpleDateFormat("yyyyMMddHHmmss").format(new Date()) + ".jpg";
		String avaPath="/CqgVipShare/upload/"+fileName;
		//String path = "D:/resource/CqgVipShare";
		String path = "C:/resource/CqgVipShare";
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

	@RequestMapping(value="/addLeaseRelation")
	@ResponseBody
	public Map<String, Object> addLeaseRelation(LeaseRelation lr) {

		Map<String, Object> jsonMap = new HashMap<String, Object>();
		int count=vipService.addLeaseRelation(lr);
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
				Map<String, String> userMap = queryUserFromApi(openId,"wxf600e162d89732da","097ee3404400bdf4b75ac8cfb0cc1c26");
				User user=new User();
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
				a.setUrl(MCARDGX+"/CqgVipShare/vip/toIndex?openId="+openId);// 该地址是点击图片跳转后
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

	@RequestMapping(value="/queryUserFromDB")
	@ResponseBody
	public Map<String, Object> queryUserFromDB(String openId) {

		Map<String, Object> jsonMap = new HashMap<String, Object>();
		User user = vipService.getUserInfoByOpenId(openId);
		
        jsonMap.put("user", user);
        
        return jsonMap;
	}
	
	@RequestMapping(value="/editWeixinMenu")
	@ResponseBody
	public Map<String, Object> editWeixinMenu(String appid, String appsecret) {

		Map<String, Object> jsonMap = new HashMap<String, Object>();
		
		//http://localhost:8088/CqgVipShare/vip/editWeixinMenu?appid=wxf600e162d89732da&appsecret=097ee3404400bdf4b75ac8cfb0cc1c26
		WeChatUtil weChatUtil = new WeChatUtil();
		String jsonMenu = "{\"button\":[{\"type\":\"click\",\"name\":\"分享主页\",\"key\":\"Share_Index\"},";
			jsonMenu+="{\"type\":\"click\",\"name\":\"发布共享\",\"key\":\"Add_Share\"},";
			jsonMenu+="{\"type\":\"click\",\"name\":\"商家验证\",\"key\":\"Merchant_Check\"}";
			jsonMenu+="]}";
		int count = weChatUtil.createMenu(appid, appsecret, jsonMenu);
		if(count==0){
			jsonMap.put("message", "no");
			jsonMap.put("info", "请核实appid值和appsecret值是否正确！");
		}else{
			jsonMap.put("message", "ok");
			jsonMap.put("info", "公众号提交成功！");
		}
		return jsonMap;
	}

	@RequestMapping(value="/selectShopList")
	@ResponseBody
	public Map<String, Object> selectShopList(String tradeId) {

		Map<String, Object> jsonMap = new HashMap<String, Object>();
		List<User> hotList=vipService.selectHotShopList(tradeId);
		List<User> moreList=vipService.selectMoreShopList(tradeId);
		jsonMap.put("hotList", hotList);
		jsonMap.put("moreList", moreList);
		return jsonMap;
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
	
	@RequestMapping(value="/aliPay")
	public void aliPay(HttpServletRequest request, HttpServletResponse response) {
		try {
			AlipayClient alipayClient = new DefaultAlipayClient(AlipayConfig.URL,AlipayConfig.APPID,AlipayConfig.RSA_PRIVATE_KEY, "json", "UTF-8", AlipayConfig.ALIPAY_PUBLIC_KEY, "RSA2");
			AlipayTradeWapPayRequest alipayRequest = new AlipayTradeWapPayRequest();
			JSONObject order = new JSONObject();
			order.put("out_trade_no", "23242345rfg34534fertgedf");
			order.put("subject", "songSir支付");
			order.put("product_code", "QUICK_WAP_WAY");
			order.put("body", "儿童泳装|泳具");
			order.put("total_amount", "0.01");
			order.put("subject", "竞浪男童平角泳裤");
			alipayRequest.setBizContent(order.toString());
			/**
			* 在公共参数中设置回跳和通知地址
			*/
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
	
	public static void main(String[] args) {
		//System.out.println(new org.json.JSONObject("{\"aaa\":\"111\"}").getString("aaa"));
	}

}
