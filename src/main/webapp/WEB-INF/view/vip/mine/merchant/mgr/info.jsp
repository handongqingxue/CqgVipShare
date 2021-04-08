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
<link rel="stylesheet" href="<%=basePath %>resource/css/vip/mine/merchant/mgr/info.css"/>
<script type="text/javascript" src="<%=basePath %>resource/js/jquery-3.3.1.js"></script>
<!--引用微信JS库-->
<script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
<script type="text/javascript">
var path='<%=basePath%>';
//var appid = "wxf600e162d89732da";
//var appSecret = "097ee3404400bdf4b75ac8cfb0cc1c26";
var appid = '<%=appId%>';
var appSecret = '<%=appSecret%>';
var openId='${param.openId}';

$(function(){
	initYYRDiv();
    getSignture();
});

function initYYRDiv(){
	var yyrListDiv=$("#yyr_div #list_div");
	var marginTop=0;
	var marginLeft=0;
	var weekday='${requestScope.merchant.weekday}';
	var weekdayArr=weekday.split(",");
	for(var i=1;i<=7;i++){
		var itemTxt="星期";
		switch (i) {
		case 1:
			itemTxt+="一";
			
			marginTop=10;
			break;
		case 2:
			itemTxt+="二";
			
			marginTop=-25;
			marginLeft+=63;
			break;
		case 3:
			itemTxt+="三";
			
			marginTop=-25;
			marginLeft+=63;
			break;
		case 4:
			itemTxt+="四";
			
			marginTop=-25;
			marginLeft+=63;
			break;
		case 5:
			itemTxt+="五";
			
			marginTop=10;
			marginLeft=0;
			break;
		case 6:
			itemTxt+="六";
			
			marginTop=-25;
			marginLeft+=63;
			break;
		case 7:
			itemTxt+="日";
			
			marginTop=-25;
			marginLeft+=63;
			break;
		}
		yyrListDiv.append("<div class=\"item_div "+(weekdayArr[i-1]==0?"xiuxi":"yingye")+"_div\" style=\"margin-top:"+marginTop+"px;margin-left:"+marginLeft+"px;\">"+itemTxt+"</div>");
	}
}

function getSignture(){
	//1.获取微信JSSDK签名
	$.post("../JSSDK/getSignture.action",{
		appid: appid,
		appSecret: appSecret,
		url:location.href.split('#')[0]
		//url:"http://www.mcardgx.com/CqgVipShare/vip/toScan?openId="+openId+"&from=singlemessage"//这个请求已经不用了，已删除
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

function goEditMerchant(){
	location.href=path+"vip/goPage?page=mineMerchantEdit&openId="+openId;
}

function goBack(){
	location.href=path+"vip/goPage?page=mineMerchantMgr&openId="+openId;
}
</script>
<title>商家信息</title>
</head>
<body>
<div class="top_div">
	<span>商家信息</span>
</div>
<div class="back_div">
	<span class="back_span" onclick="goBack()">&lt;返回</span>
</div>
<div class="main_div">
	<div class="attr_div">
		<div class="key_div">商家名称：</div>
		<div class="val_div">${requestScope.merchant.shopName }</div>
	</div>
	<div class="attr_div">
		<div class="key_div">商家地址：</div>
		<div class="val_div">${requestScope.merchant.shopAddress }</div>
	</div>
	<div class="attr_div">
		<div class="key_div">联系电话：</div>
		<div class="val_div">${requestScope.merchant.contactTel }</div>
	</div>
	<div class="logo_div">
		<div class="key_div">商家logo：</div>
		<img class="logo_img" alt="" src="${requestScope.merchant.logo }">
	</div>
	<div class="yyzz_div">
		<div class="key_div">营业执照：</div>
		<img class="yyzz_img" alt="" src="${requestScope.merchant.yyzzImgUrl }">
	</div>
	<div class="yyr_div" id="yyr_div">
		<div class="key_div">营业日：</div>
		<div class="list_div" id="list_div"></div>
	</div>
	<div class="attr_div">
		<div class="key_div">营业时间：</div>
		<div class="val_div">${requestScope.merchant.startTime }时-${requestScope.merchant.endTime }时</div>
	</div>
	<input type="hidden" id="timestamp" />
	<input type="hidden" id="nonceStr" />
	<input type="hidden" id="signature" />
	<div class="scanQRCode" id="scanQRCode" onclick="scanQRCode()">扫一扫</div>
	<div class="editMerchant_div" id="editMerchant_div" onclick="goEditMerchant()">编辑商家</div>
</div>
</body>
</html>