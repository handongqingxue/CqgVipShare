<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%
	String basePath=request.getScheme()+"://"+request.getServerName()+":"
		+request.getServerPort()+request.getContextPath()+"/";
	String appId=request.getAttribute("appId").toString();
	String appSecret=request.getAttribute("appSecret").toString();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
<title>Insert title here</title>
<!--引用微信JS库-->
<script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
<!--引用jQuery库-->
<script type="text/javascript" src="http://code.jquery.com/jquery-1.4.2.min.js"></script>
</head>
<body>
<input type="button" value="扫一扫" id="scanQRCode" onclick="scanQRCode()" style="display: none;"/>
<script type="text/javascript">
var path='<%=basePath%>';
//var appid = "wxf600e162d89732da";
//var appSecret = "097ee3404400bdf4b75ac8cfb0cc1c26";
var appid = '<%=appId%>';
var appSecret = '<%=appSecret%>';
var openId='${param.openId}';
$(function(){
	$.post("merchantCheck",
		{openId:openId},
		function(data){
			if(data.status=="ok"){
			   getSignture();
			}
			else{
			   alert(data.message);
			   location.href=path+"vip/toMine?openId="+openId;
			}
		}
	,"json");
	
});

function getSignture(){
	//1.获取微信JSSDK签名
	$.post("../JSSDK/getSignture.action",{
		appid: appid,
		appSecret: appSecret,
		url:location.href.split('#')[0]
		//url:"http://www.mcardgx.com/CqgVipShare/vip/toScan?openId="+openId+"&from=singlemessage"
	},function(data){
		//alert(data.timestamp);
		//alert(data.nonceStr);
		//alert(data.signature);
		console.log(data);
		$("#timestamp").val(data.timestamp);
		$("#nonceStr").val(data.nonceStr);
		$("#signature").val(data.signature);
		config();
		$("#scanQRCode").css("display","block");
	},"json");

	/*
	//jsapi_ticket=kgt8ON7yVITDhtdwci0qeen6kZojAUOjVNkgXblzBjgKaU-LZunPgbFCh8gM-cjvtkVSA-HSiEuKkFOpqh_-Tg
	$("#timestamp").val("1577428856");
	$("#nonceStr").val("e3314941-0e45-4e55-ba5f-68e43d0963b0");
	$("#signature").val("413c88995d9a049e195f5d52c4c6758f0d51c738");
	config();
	$("#scanQRCode").css("display","block");
	*/
}

function config(){
	var timestamp = $("#timestamp").val();//时间戳
	var nonceStr = $("#nonceStr").val();//随机串
	var signature = $("#signature").val();//签名
	
	wx.config({
		debug: false, // 开启调试模式,调用的所有api的返回值会在客户端alert出来，若要查看传入的参数，可以在pc端打开，参数信息会通过log打出，仅在pc端时才会打印。
		appId: appid, // 必填，公众号的唯一标识
		timestamp: timestamp, // 必填，生成签名的时间戳
		nonceStr: nonceStr, // 必填，生成签名的随机串
		signature: signature,// 必填，签名，见附录1
		jsApiList: ['scanQRCode'] // 必填，需要使用的JS接口列表，所有JS接口列表见附录2
	});
}

function scanQRCode(){
    wx.scanQRCode({
        needResult: 1, // 默认为0，扫描结果由微信处理，1则直接返回扫描结果，
        scanType: ["qrCode"], // 可以指定扫二维码还是一维码，默认二者都有
        success: function (res) {
            var result = res.resultStr; // 当needResult 为 1 时，扫码返回的结果
            //alert("扫描结果："+result);
            window.location.href = result;//因为我这边是扫描后有个链接，然后跳转到该页面
        }
    });
}

	/*
    //这里【url参数一定是去参的本网址】
    $.get("获取微信认证参数的网址?url=当前网页的网址", function(data){
        var jsondata=$.parseJSON(data);
        wx.config({
            // 开启调试模式,调用的所有api的返回值会在客户端alert出来，若要查看传入的参数，可以在pc端打开，参数信息会通过log打出，仅在pc端时才会打印。
            debug: false,
            // 必填，公众号的唯一标识
            appId: jsondata.model.appId,
            // 必填，生成签名的时间戳
            timestamp: "" + jsondata.model.timestamp,
            // 必填，生成签名的随机串
            nonceStr: jsondata.model.nonceStr,
            // 必填，签名
            signature: jsondata.model.signature,
            // 必填，需要使用的JS接口列表
            jsApiList: ['checkJsApi', 'scanQRCode']
        });
    });
    wx.error(function (res) {
        alert("出错了：" + res.errMsg);//这个地方的好处就是wx.config配置错误，会弹出窗口哪里错误，然后根据微信文档查询即可。
    });
    */
 
    wx.ready(function () {
        wx.checkJsApi({
            jsApiList: ['scanQRCode'],
            success: function (res) {
 
            }
        });
    });
</script>
	<input type="hidden" id="timestamp" />
	<input type="hidden" id="nonceStr" />
	<input type="hidden" id="signature" />
</body>
</html>