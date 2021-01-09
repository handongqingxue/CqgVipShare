package com.cqgVipShare.JSSDKGeteway;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.portlet.ModelAndView;

import com.cqgVipShare.JSSDKDemo.WeixinUtil;

@Controller
@RequestMapping(value="/JSSDK")
public class JSSDKGateway {

	Logger log = Logger.getLogger(JSSDKGateway.class);

	/**
	 * 1.获取微信JSSDK签名，返回对应数据
	 */
	@RequestMapping(value = "/getSignture.action")
	@ResponseBody
	public Map<String, String> getSignture (String appid, String appSecret, String url, HttpSession session){
		
		log.info("JSSDKGateway.getSignture.appid = " + appid);
		log.info("JSSDKGateway.getSignture.appSecret = " + appSecret);
		log.info("JSSDKGateway.getSignture.url = " + url);
		
		Map<String, String> jsonMap = new HashMap<String, String>();
		try {
			jsonMap = new WeixinUtil().getSignture(appid,appSecret,url,new ModelAndView(),session);
			System.out.println("timestamp="+jsonMap.get("timestamp"));
			System.out.println("nonceStr="+jsonMap.get("nonceStr"));
			System.out.println("signature="+jsonMap.get("signature"));
			
		} catch (Exception e) {
		//	System.out.println("e="+e);
			e.printStackTrace();
			return jsonMap;
		}
		return jsonMap;
	}
}