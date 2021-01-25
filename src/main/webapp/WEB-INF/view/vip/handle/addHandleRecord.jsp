<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<%@include file="../../background/js.jsp"%>
<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
<link rel="stylesheet" href="<%=basePath %>resource/css/vip/handle/addHandleRecord.css"/>
<!--引用微信JS库-->
<script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
<script type="text/javascript">
var path='<%=basePath %>';
var id='${param.id}';
var openId='${param.openId}';
$(function(){
	initYglkDB();
});

function initYglkDB(){
	yglkDB=$("#yglkDate").datebox({
		height:30,
		editable:false
	});
	$(".combo.datebox").eq(0).css("margin-top","12px");
}

function pay(){
	var phone=$("#phone").val();
	var yglkDate=yglkDB.datebox("getValue");
	var mcId='${param.mcId}';
	var shareMoney='${param.shareMoney}';
	//location.href="alipay?kzOpenId="+kzOpenId+"&fxzOpenId="+fxzOpenId+"&phone="+phone+"&ygxfDate="+ygxfDate+"&scId="+scId+"&shareMoney="+shareMoney;
	$.post("wxPay",
		{openId:openId,phone:phone,yglkDate:yglkDate,mcId:mcId,shareMoney:shareMoney,action:"handle"},
		function(payMap){
			//alert(JSON.stringify(payMap));
			WeixinJSBridge.invoke('getBrandWCPayRequest',{  
			    "appId" : payMap.appId,
			  	"timeStamp":payMap.timeStamp,  
			     "nonceStr" : payMap.nonceStr,
			     "package" : payMap["package"],  
			     "signType" : "MD5",
			     "paySign" : payMap.paySign
			},function(res){  
				//alert(JSON.stringify(res));
			     if(res.err_msg == "get_brand_wcpay_request:ok"){ 
			     	//pophint("付款成功！",null,null,"javascript:window.history.back();return false;");
			     	location.href="goPaySuccess?srUuid="+payMap.srUuid;
			     }else{  
			     	//pophint("付款失败");
			     	//此处，若用户取消付款（也就是退出公众号或者关闭那个输入密码的窗口），你可以执行一些自己的操作
			     }  
		    }); 
			/*
			if(data.status=="ok")
				$("#qrcodeUrl").attr("src",data.qrcodeUrl);
			else
				alert(data.message);
			*/
		}
	,"json");
}
</script>
<title>Insert title here</title>
</head>
<body>
<div class="top_div">
	<span>办理会员</span>
</div>
<div class="back_div">
	<span class="back_span" onclick="goBack()">&lt;返回</span>
</div>
<div class="addSR_div">
	<div class="phone_div">
		<div class="tit_div">手机号</div>
		<div class="phone_inp_div">
			<input type="text" class="phone_inp" id="phone" placeholder="请输入手机号" onfocus="focusPhone()" onblur="checkPhone()"/>
		</div>
	</div>
	<div class="yglkDate_div">
		<div class="tit_div">预估领卡日期</div>
		<div class="yglkd_inp_div">
			<input type="text" class="yglkDate_inp" id="yglkDate"/>
		</div>
	</div>
</div>
<!-- 
<div class="pay_div" onclick="checkInfo()">
	支付
</div>
 -->
<div class="pay_div" onclick="pay()">
	支付
</div>
<div>
	<img id="qrcodeUrl" alt="" />
</div>
</body>
</html>