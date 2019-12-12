package com.cqgVipShare.util;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.ConnectException;
import java.net.URL;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.net.ssl.HttpsURLConnection;
import javax.net.ssl.SSLContext;
import javax.net.ssl.SSLSocketFactory;
import javax.servlet.http.HttpServletRequest;

import com.cqgVipShare.entity.Article;
import com.cqgVipShare.entity.PicAndTextMsg;
import com.thoughtworks.xstream.XStream;

import net.sf.json.JSONException;
import net.sf.json.JSONObject;

public class WeChatUtil {

	public static JSONObject httpRequest(String requestUrl, String requestMethod, String outputStr) {
		JSONObject jsonObject = null;
		StringBuffer buffer = new StringBuffer();
		try {
			// 创建SSLContext对象，并使用我们指定的信任管理器初始�?
			TrustManager[] tm = { new TrustManager() };
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
			// 设置请求方式（GET/POST�?
			httpUrlConn.setRequestMethod(requestMethod);

			if ("GET".equalsIgnoreCase(requestMethod))
				httpUrlConn.connect();

			// 当有数据�?要提交时
			if (null != outputStr) {
				OutputStream outputStream = httpUrlConn.getOutputStream();
				// 注意编码格式，防止中文乱�?
				outputStream.write(outputStr.getBytes("UTF-8"));
				outputStream.close();
			}

			// 将返回的输入流转换成字符�?
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
			System.out.println("微信服务器连接超时！");
		} catch (Exception e) {
			System.out.println("HTTPS请求错误，错误信息：\n" + e.getMessage());
		}
		return jsonObject;
	}

	// 获取access_token的接口地�?（GET�? �?200（次/天）
	public final static String access_token_url = "https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid=APPID&secret=APPSECRET";

	/**
	 * 获取access_token
	 * 
	 * @param appid
	 *            凭证
	 * @param appsecret
	 *            密钥
	 * @return
	 */
	public static AccessToken getAccessToken(String appid, String appsecret) {
		AccessToken accessToken = null;

		String requestUrl = access_token_url.replace("APPID", appid).replace("APPSECRET", appsecret);
		JSONObject jsonObject = httpRequest(requestUrl, "POST", null);
		// 如果请求成功
		if (null != jsonObject) {
			try {
				accessToken = new AccessToken();
				accessToken.setToken(jsonObject.getString("access_token"));
				accessToken.setExpiresIn(jsonObject.getInt("expires_in"));
			} catch (JSONException e) {
				accessToken = null;
				// 获取token失败
				System.out.println("获取TOKEN失败(" + jsonObject.getInt("errcode") + ")�?"
						+ WeChatErrorCode.ERRORCODE.get(jsonObject.getInt("errcode")));
			}
		}
		return accessToken;
	}

	// 菜单创建（POST�? �?100（次/天）

	public static String menu_create_url = "https://api.weixin.qq.com/cgi-bin/menu/create?access_token=ACCESS_TOKEN";

	/**
	 * 创建菜单
	 * 
	 * @param jsonMenu
	 *            菜单实例
	 * @param accessToken
	 *            有效的access_token
	 * @return 0表示成功，其他�?�表示失�?
	 */
	public static int createMenu(String appid, String appsecret, String jsonMenu) {
		//String[] menuStr = menu.split(",");
		AccessToken at = getAccessToken(appid, appsecret);
		System.out.println("token=========="+at.getToken());
		
		/**
		String jsonMenu = "";
		jsonMenu = "{\"button\":[" + "{\"name\":\"会员中心\"," + "\"sub_button\":[" + "{\"type\":\"click\", \"name\":\"会员注册\",";
		if (menuStr[0].equals("1")) {
			jsonMenu += "\"key\":\"Vip_Reg"+appid+"\"";
		} else {
			jsonMenu += "\"key\":\"Not_Available\"";
		}
		jsonMenu += "},{" + "\"type\":\"click\"," + "\"name\":\"会员签到\","; 
		if (menuStr[1].equals("1")) {
			jsonMenu += "\"key\":\"Vip_Sign"+appid+"\"";
		} else {
			jsonMenu += "\"key\":\"Not_Available\"";
		}
		jsonMenu += " },{" + "\"type\":\"click\"," + "\"name\":\"购物抽奖\",";
		if (menuStr[2].equals("1")) {
			jsonMenu += "\"key\":\"Shopping_Draw"+appid+"\"";
		} else {
			jsonMenu += "\"key\":\"Not_Available\"";
		}
		jsonMenu += " },{" + "\"type\":\"click\"," + "\"name\":\"分享积分\",";
		if (menuStr[3].equals("1")) {
			jsonMenu += "\"key\":\"Sharing_Points"+appid+"\"";
		} else {
			jsonMenu += "\"key\":\"Not_Available\"";
		}
		jsonMenu += " },{" + "\"type\":\"click\"," + "\"name\":\"会员中心\",";
		if (menuStr[4].equals("1")) {
			jsonMenu += "\"key\":\"Member_Center"+appid+"\"";
		} else {
			jsonMenu += "\"key\":\"Not_Available\"";
		}
		//jsonMenu += "}]}]}";
		jsonMenu += " }]" + "},";
		if (menuStr[5].equals("1")) {
			jsonMenu += "{\"name\":\"在线游戏\"," + "\"sub_button\":[" + "{\"type\":\"view\"," + "\"name\":\"愚公移山\","
					+ "\"url\":\"http://sygys.egret-labs.org/static/staticOne/nestindex.html?v=1.0.1&resVer=3fgd27t&codeVer=55597993&token=a6f43f250784e3cd22ab452656b48052&egretId=f2d67f5512c88369c23747882c948b8e&appId=22&channelId=18557&egret.runtime.spid=18557&isNewApi=1&egretRv=429&egretSdkDomain=http://api.egret-labs.org/v2&egretServerDomain=http://api.egret-labs.org/v2\""
					+ "}," + "{\"type\":\"view\"," + "\"name\":\"口袋怪兽联盟\","
					+ "\"url\":\"http://api.49you.com/api/gameshf/checkLogin/platformid/9/ptgid/227/pf/bailu?token=f08472d1dec93095391f13a1e05ea469&egretId=f2d67f5512c88369c23747882c948b8e&appId=90336&channelId=18557&egret.runtime.spid=18557&isNewApi=1&egretRv=786&egretSdkDomain=http://api.egret-labs.org/v2&egretServerDomain=http://api.egret-labs.org/v2\""
					+ "}," + "{\"type\":\"view\"," + "\"name\":\"我要当首富\","
					+ "\"url\":\"http://richest.dreamo100.com/?token=1d82dfae384b582344772523f8c3dc34&egretId=f2d67f5512c88369c23747882c948b8e&appId=89739&channelId=18557&egret.runtime.spid=18557&isNewApi=1&egretRv=467&egretSdkDomain=http://api.egret-labs.org/v2&egretServerDomain=http://api.egret-labs.org/v2\""
					+ "}," + "{\"type\":\"view\"," + "\"name\":\"少女H计划2-上天玩笑\","
					+ "\"url\":\"http://h5.topsgame.com/girlplan2/html5/sn5/index.html?token=3ddfae6e24d316e2f0276d955a0db2b3&egretId=f2d67f5512c88369c23747882c948b8e&appId=316&channelId=18557&egret.runtime.spid=18557&isNewApi=1&egretRv=719&egretSdkDomain=http://api.egret-labs.org/v2&egretServerDomain=http://api.egret-labs.org/v2\""
					+ "}," + "{\"type\":\"view\"," + "\"name\":\"小小地下城\","
					+ "\"url\":\"http://g2game.fenha.net/index.html?raeqd=egr&token=03c443a0d0fc13af087e740b3bafe8a5&egretId=f2d67f5512c88369c23747882c948b8e&appId=90643&channelId=18557&egret_runtime_spid=18557&isNewApi=1&egretRv=266&egretSdkDomain=http://api.egret-labs.org/v2&egretServerDomain=http://api.egret-labs.org/v2\""
					+ "}]" + "},";
		} 
		/*
		else {
			jsonMenu += "{\"name\":\"在线游戏\"},";
		}
		*/
		/**
		jsonMenu += "{\"name\":\"联系我们\"," + "\"sub_button\":[" + ""
				+ "{\"type\":\"view\"," + "\"name\":\"客户服务\",\"url\":\"http://www.easy898.net/ZZWeixin/phone/customer.html?appid="+appid+"\"},"
				+ "{\"type\":\"view\"," + "\"name\":\"联系我们\",\"url\":\"http://www.easy898.net/ZZWeixin/phone/contactUs.html\"}]}]}";
		**/
		int result = 0;

		if (at != null && at.getToken() != null) {
			// 拼装创建菜单的url
			String url = menu_create_url.replace("ACCESS_TOKEN", at.getToken());
			//https://api.weixin.qq.com/cgi-bin/menu/delete?access_token=
			System.out.println("url========="+url);
			System.out.println("jsonMenu==========="+jsonMenu);
			// 调用接口创建菜单
			JSONObject jsonObject = httpRequest(url, "POST", jsonMenu);

			if (null != jsonObject) {
				if (0 != jsonObject.getInt("errcode")) {
					result = jsonObject.getInt("errcode");
					System.out.println("创建菜单失败(" + result + ")�?" + WeChatErrorCode.ERRORCODE.get(result));
				} else {
					result = 1;
				}
			}
		} else {
			System.out.println("菜单创建失败");
		}
		return result;
	}

	public static void articles(String fromUserName, String toUserName, String title, String url, String picUrl,
			String description) {
		List<Article> articles = new ArrayList<Article>();
		Article a = new Article();
		a.setTitle("会员注册");
		a.setUrl("");// 该地�?是点击图片跳转后
		a.setPicUrl("");// 该地�?是一个有效的图片地址
		a.setDescription("");
		articles.add(a);
		PicAndTextMsg picAndTextMsg = new PicAndTextMsg();
		picAndTextMsg.setToUserName(fromUserName);// 发�?�和接收信息“User”刚好相�?
		picAndTextMsg.setFromUserName(toUserName);
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
		// 第三步，发�?�xml的格式信息给微信服务器，服务器转发给用户
		// PrintWriter printWriter = resp.getWriter();
		// printWriter.print(picAndTextMsg2Xml);
	}
	
	/**
	 * 获得粉丝的关注时�?
	 * @param openid
	 * @param accessToken
	 * @return
	 */
	public static String getSubscribeTime(String openid, String accessToken) {
		JSONObject obj = JSONObject.fromObject(MethodUtil.httpRequest("https://api.weixin.qq.com/cgi-bin/user/info?access_token="+accessToken+"&openid="+openid+"&lang=zh_CN"));
		if(obj.get("subscribe_time")!=null)
			return MethodUtil.timeStamp2Date(obj.getString("subscribe_time"),null);
		else
			return null;
	}
}
