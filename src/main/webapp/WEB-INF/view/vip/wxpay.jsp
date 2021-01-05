<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
<title>Insert title here</title>
<%@include file="../admin/js.jsp"%>
<!--引用微信JS库-->
<script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
<!--引用jQuery库-->
<script type="text/javascript" src="http://code.jquery.com/jquery-1.4.2.min.js"></script>
<script type="text/javascript">
/*
function pays() {
	$.ajax({
		type:"POST",
		url:"toH5Pay.do",
		data:{
			amount:"",
			userId:"",
			orderId:""
		},error:function(requst){
			pophint("系统错误，请稍后重试")
		},success:function(result){
 
			//请求成功了，开始解析数据
			eval("var r ="+result);
			
			if(r.success){
				var obj=r.obj;
				WeixinJSBridge.invoke('getBrandWCPayRequest',{  
	               "appId" : obj.app_id,
	             	"timeStamp":obj.timeStamp,  
	                "nonceStr" : obj.nonce_str,
	                "package" : obj.prepay_id,  
	                "signType" : obj.signType,
	                "paySign" : obj.paySign
	           },function(res){  
	                if(res.err_msg == "get_brand_wcpay_request:ok"){ 
	                	pophint("付款成功！",null,null,"javascript:window.history.back();return false;");	
	                }else{  
	                	pophint("付款失败");
	                	//此处，若用户取消付款（也就是退出公众号或者关闭那个输入密码的窗口），你可以执行一些自己的操作
	                }  
	       	   }); 
			}else{
				pophint(r.msg)
			}
		}
	});
}
*/

var appId='${requestScope.appId}';
var appSecret = "097ee3404400bdf4b75ac8cfb0cc1c26";
var timeStamp='${requestScope.timeStamp}';
var nonceStr='${requestScope.nonceStr}';
var package1='${requestScope.package1}';
var paySign='${requestScope.paySign}';
function wxPay(){
	WeixinJSBridge.invoke('getBrandWCPayRequest',{  
	    "appId" : appId,
	  	"timeStamp":timeStamp,  
	     "nonceStr" : nonceStr,
	     "package" : package1,  
	     "signType" : "MD5",
	     "paySign" : paySign
	},function(res){  
		alert(JSON.stringify(res));
	     if(res.err_msg == "get_brand_wcpay_request:ok"){ 
	     	pophint("付款成功！",null,null,"javascript:window.history.back();return false;");
	     }else{  
	     	pophint("付款失败");
	     	//此处，若用户取消付款（也就是退出公众号或者关闭那个输入密码的窗口），你可以执行一些自己的操作
	     }  
	   }); 
}

/*
//1.获取微信JSSDK签名
$.post("../JSSDK/getSignture.action",{
	appid: appId,
	appSecret: appSecret,
	url:location.href.split('#')[0]
	//url:"http://www.mcardgx.com/CqgVipShare/vip/toScan?openId="+openId+"&from=singlemessage"
},function(data){
	//alert(data.timestamp);
	//alert(data.nonceStr);
	//alert(data.signature);
	console.log(data);

	timeStamp=data.timestamp;
	nonceStr=data.nonceStr;
	paySign=data.signature;
	wx.config({
		debug: false, // 开启调试模式,调用的所有api的返回值会在客户端alert出来，若要查看传入的参数，可以在pc端打开，参数信息会通过log打出，仅在pc端时才会打印。
		appId: appId, // 必填，公众号的唯一标识
		timestamp: timeStamp, // 必填，生成签名的时间戳
		nonceStr: nonceStr, // 必填，生成签名的随机串
		signature: paySign,// 必填，签名，见附录1
		jsApiList: ['JSAPI'] // 必填，需要使用的JS接口列表，所有JS接口列表见附录2
	});
},"json");

wx.ready(function(){
	alert(111);
});
*/
</script>
</head>
<body>
<input type="button" value="aaa" onclick="wxPay()"/>
</body>
</html>