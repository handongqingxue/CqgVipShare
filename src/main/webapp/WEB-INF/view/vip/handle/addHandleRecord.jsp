<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%
	String basePath=request.getScheme()+"://"+request.getServerName()+":"
	+request.getServerPort()+request.getContextPath()+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
<link rel="stylesheet" href="<%=basePath %>resource/css/vip/handle/addHandleRecord.css"/>
<script type="text/javascript" src="<%=basePath %>resource/js/jquery-3.3.1.js"></script>
<!--引用微信JS库-->
<script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
<script type="text/javascript">
var path='<%=basePath %>';
var id='${param.id}';
var openId='${param.openId}';
var mcId='${requestScope.pageValue.mcId}';
var money='${requestScope.pageValue.money}';
var tradeId='${requestScope.pageValue.tradeId}';
var tradeName='${requestScope.pageValue.tradeName}';
var shopId='${requestScope.pageValue.shopId}';
var shopName='${requestScope.pageValue.shopName}';
var shopAddress='${requestScope.pageValue.shopAddress}';
var logo='${requestScope.pageValue.logo}';
var prePage='${requestScope.pageValue.prePage}';
var from='${requestScope.pageValue.from}';
var action="handle";
$(function(){
	
});

function pay(){
	var realName = $("#realName").val();
	var phone=$("#phone").val();
	var qq=$("#qq").val();
	var wxNo=$("#wxNo").val();
	$.post("wxPay",
		{openId:openId,realName:realName,phone:phone,qq:qq,wxNo:wxNo,mcId:mcId,money:money,action:action},
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
			     	location.href="goPaySuccess?hrUuid="+payMap.uuid+"&action="+action;
			     }else{  
			     	//pophint("付款失败");
			     	//此处，若用户取消付款（也就是退出公众号或者关闭那个输入密码的窗口），你可以执行一些自己的操作
			     }  
		    }); 
		}
	,"json");
}

function checkInfo(){
	if(checkRealName()){
		if(checkPhone()){
			if(checkQqWxNo()){
				pay();
			}
		}
	}
}

function focusRealName(){
	var realName = $("#realName").val();
	if(realName=="姓名不能为空"){
		$("#realName").val("");
		$("#realName").css("color", "#555555");
	}
}

//验证姓名
function checkRealName(){
	var realName = $("#realName").val();
	if(realName==null||realName==""||realName=="姓名不能为空"){
		$("#realName").css("color","#E15748");
    	$("#realName").val("姓名不能为空");
    	return false;
	}
	else
		return true;
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

//验证qq或微信
function checkQqWxNo(){
	var flag;
	var qq = $("#qq").val();
	var wxNo = $("#wxNo").val();
	if(qq!=null&qq!=""){
    	flag=true;
	}
	else if(wxNo!=null&wxNo!=""){
		flag=true;
	}
	else
		flag=false;
	
	if(!flag){
		alert("请输入qq或微信");
	}
	return flag;
}

function goBack(){
	location.href=path+"vip/goPage?page=handleTreaty&openId="+openId;
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
	<div class="rn_div">
		<div class="tit_div">姓名</div>
		<div class="rn_inp_div">
			<input type="text" class="rn_inp" id="realName" placeholder="请输入姓名" onfocus="focusRealName()" onblur="checkRealName()"/>
		</div>
	</div>
	<div class="phone_div">
		<div class="tit_div">手机号</div>
		<div class="phone_inp_div">
			<input type="text" class="phone_inp" id="phone" placeholder="请输入手机号" onfocus="focusPhone()" onblur="checkPhone()"/>
		</div>
	</div>
	<div class="qq_div">
		<div class="tit_div">qq</div>
		<div class="qq_inp_div">
			<input type="text" class="qq_inp" id="qq" placeholder="请输入qq" onblur="checkQqWxNo()"/>
		</div>
	</div>
	<div class="wxNo_div">
		<div class="tit_div">微信</div>
		<div class="wxNo_inp_div">
			<input type="text" class="wxNo_inp" id="wxNo" placeholder="请输入微信" onblur="checkQqWxNo()"/>
		</div>
	</div>
</div>
<div class="bottom_div" onclick="checkInfo()">
	<span class="moneySign_span">￥</span>
	<span class="money_span">${param.money }</span>
	<div class="payBut_div" onclick="toAddHandleRecord()">普通支付</div>
</div>
<!-- 
<div>
	<img id="qrcodeUrl" alt="" />
</div>
 -->
</body>
</html>