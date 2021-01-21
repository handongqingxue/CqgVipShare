<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
<%@include file="../../background/js.jsp"%>
<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
<link rel="stylesheet" href="<%=basePath %>resource/css/vip/home/addShareRecord.css"/>
<!--引用微信JS库-->
<script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
<script type="text/javascript">
var path='<%=basePath %>';
var id='${param.id}';
var kzOpenId='${param.kzOpenId}';
var fxzOpenId='${param.fxzOpenId}';
var from='${param.from}';
$(function(){
	ygxfDB=$("#ygxfDate").datebox({
		height:30,
		editable:false
	});
	$(".combo.datebox").eq(0).css("margin-top","12px");
});

function pay(){
	var phone=$("#phone").val();
	var ygxfDate=ygxfDB.datebox("getValue");
	var vipId='${param.vipId}';
	var shareMoney='${param.shareMoney}';
	//location.href="alipay?kzOpenId="+kzOpenId+"&fxzOpenId="+fxzOpenId+"&phone="+phone+"&ygxfDate="+ygxfDate+"&vipId="+vipId+"&shareMoney="+shareMoney;
	$.post("wxPay",
		{kzOpenId:kzOpenId,fxzOpenId:fxzOpenId,phone:phone,ygxfDate:ygxfDate,vipId:vipId,shareMoney:shareMoney},
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

function checkInfo(){
	if(checkPhone()){
		if(checkYgxfDate()){
			pay();
		}
	}
}

function focusPhone(){
	var phone = $("#phone").val();
	if(phone=="手机号不能为空"){
		$("#phone").val("");
		$("#phone").css("color", "#555555");
	}
}

//验证手机号
function checkPhone(){
	var phone = $("#phone").val();
	if(phone==null||phone==""||phone=="手机号不能为空"){
		$("#phone").css("color","#E15748");
    	$("#phone").val("手机号不能为空");
    	return false;
	}
	else
		return true;
}

//验证预估消费日期
function checkYgxfDate(){
	var ygxfDate=ygxfDB.datebox("getValue");
	if(ygxfDate==null||ygxfDate==""||ygxfDate=="预估消费日期不能为空"){
    	alert("预估消费日期不能为空");
    	return false;
	}
	else
		return true;
}

function goBack(){
	location.href=path+"vip/goPage?page=homeShare&id="+id+"&openId="+fxzOpenId+"&from="+from;
}
</script>
</head>
<body>
<div class="top_div">
	<span>分享会员</span>
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
	<div class="ygxfDate_div">
		<div class="tit_div">预估消费日期</div>
		<div class="ygxfd_inp_div">
			<input type="text" class="ygxfDate_inp" id="ygxfDate"/>
		</div>
	</div>
</div>
<div class="pay_div" onclick="checkInfo()">
	支付
</div>
<div>
	<img id="qrcodeUrl" alt="" />
</div>
</body>
</html>