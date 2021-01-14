package com.cqgVipShare.JSSDKDemo;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.ConnectException;
import java.net.URL;
import java.util.Map;

import javax.net.ssl.HttpsURLConnection;
import javax.net.ssl.SSLContext;
import javax.net.ssl.SSLSocketFactory;
import javax.net.ssl.TrustManager;
import javax.servlet.http.HttpSession;

import org.springframework.web.portlet.ModelAndView;

import com.cqgVipShare.JSSDKDemo.MyX509TrustManager;
import com.cqgVipShare.JSSDKDemo.WxJSsign;

import net.sf.json.JSONException;
import net.sf.json.JSONObject;

public class WeixinUtil {

	// 微信JSSDK的ticket请求URL地址
	public final static String weixin_jssdk_ticket_url = "https://api.weixin.qq.com/cgi-bin/ticket/getticket?access_token=ACCESS_TOKEN&type=jsapi";
	
	/**
	 * 获取微信JSSDK的access_token
	 * @author Benson
	 */
	public static String getJSSDKAccessToken(String appid, String appSecret) {
		String returnString = "";
		
		// 微信JSSDK的AccessToken请求URL地址
		String requestUrl = "https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid="+appid+"&secret="+appSecret;
		JSONObject jsonObject = httpRequest(requestUrl, "GET", null);  //Http GET请求
		System.out.println("jsonObject==="+jsonObject.toString());

		//如果请求成功
		if (null != jsonObject) {
			try {
				returnString=jsonObject.getString("access_token");
			} catch (JSONException e) {
				returnString = null;
			}
		}
		return returnString;
    }
	 
	/**
	 * 获取微信JSSDK的ticket
	 * @author Benson
	 */
	public static String getJSSDKTicket(String access_token) {
		System.out.println("access_token==="+access_token);
		String returnString = "";
		String requestUrl = weixin_jssdk_ticket_url.replace("ACCESS_TOKEN", access_token);
		JSONObject jsonObject = httpRequest(requestUrl, "GET", null);

		//如果请求成功
		if (null != jsonObject) {
			try {
				returnString=jsonObject.getString("ticket");
			} catch (JSONException e) {
				returnString = null;
			}
		}
	//	System.out.println("returnString="+returnString);
		return returnString;
    } 
	
	//获取微信JSSDK签名，返回对应数据
	public Map<String, String> getSignture(String appid, String appSecret, String url, ModelAndView mav, HttpSession session) {
		
		//获取签名要用到的jsapi_ticket
		String jsapi_ticket = null;
		Object ticketObj = session.getAttribute("ticket");
		if(ticketObj!=null) {
			jsapi_ticket = ticketObj.toString();
		}
		else {
			String js_accessToken = null;
			Object accessTokenObj = session.getAttribute("accessToken");
			if(accessTokenObj!=null) {
				js_accessToken = accessTokenObj.toString();
			}
			else {
				js_accessToken = WeixinUtil.getJSSDKAccessToken(appid, appSecret);  //获取微信jssdk---access_token
				session.setAttribute("accessToken",js_accessToken);
			}
			jsapi_ticket = WeixinUtil.getJSSDKTicket(js_accessToken); //获取微信jssdk---ticket
			session.setAttribute("ticket",jsapi_ticket);
			System.out.println("jsapi_ticket="+jsapi_ticket);
		}
		
		//获取完整的URL地址
		String fullPath = url;
	//	System.out.println("fullPath="+fullPath);
		
		Map<String, String> data = WxJSsign.sign(jsapi_ticket, fullPath);
		mav.addObject("timestamp", data.get("timestamp"));
		mav.addObject("nonceStr", data.get("nonceStr"));
		mav.addObject("signature", data.get("signature"));
		return data;
	}
	
	/**
	 * 发起https请求并获取结果
	 * @param requestUrl 请求地址
	 * @param requestMethod 请求方式（GET、POST）
	 * @param outputStr 提交的数据
	 * @return JSONObject(通过JSONObject.get(key)的方式获取json对象的属性值)
	 */
	public static JSONObject httpRequest(String requestUrl, String requestMethod, String outputStr) {
		JSONObject jsonObject = null;
		StringBuffer buffer = new StringBuffer();
		try {
			// 创建SSLContext对象，并使用我们指定的信任管理器初始化
			TrustManager[] tm = { new MyX509TrustManager() };
			SSLContext sslContext = SSLContext.getInstance("SSL", "SunJSSE");
			sslContext.init(null, tm, new java.security.SecureRandom());
			// 从上述SSLContext对象中得到SSLSocketFactory对象
			SSLSocketFactory ssf = sslContext.getSocketFactory();
			
			URL url = new URL(requestUrl);
			HttpsURLConnection httpUrlConn = (HttpsURLConnection) url.openConnection();
			
			httpUrlConn.setSSLSocketFactory(ssf);
			httpUrlConn.setDoOutput(true);
			httpUrlConn.setDoInput(true);
			httpUrlConn.setUseCaches(false);
			// 设置请求方式（GET/POST）
			httpUrlConn.setRequestMethod(requestMethod);
			if ("GET".equalsIgnoreCase(requestMethod))
				httpUrlConn.connect();
			
			// 当有数据需要提交时
			if (null != outputStr) {
				OutputStream outputStream = httpUrlConn.getOutputStream();
				// 注意编码格式，防止中文乱码
				outputStream.write(outputStr.getBytes("UTF-8"));
				outputStream.close();
			}
			
			// 将返回的输入流转换成字符串
			InputStream inputStream = httpUrlConn.getInputStream();
			InputStreamReader inputStreamReader = new InputStreamReader(inputStream, "utf-8");
			BufferedReader bufferedReader = new BufferedReader(inputStreamReader);
			
			String str = null;
			while ((str = bufferedReader.readLine()) != null) {
				buffer.append(str);
			}
			bufferedReader.close();
			inputStreamReader.close();
			// 释放资源
			inputStream.close();
			inputStream = null;
			httpUrlConn.disconnect();
			jsonObject = JSONObject.fromObject(buffer.toString());
		} catch (ConnectException ce) {
			ce.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return jsonObject;
	}
}