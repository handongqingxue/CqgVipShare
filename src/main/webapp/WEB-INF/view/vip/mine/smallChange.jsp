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
<link rel="stylesheet" href="<%=basePath %>resource/css/vip/mine/smallChange.css"/>
<script type="text/javascript" src="<%=basePath %>resource/js/jquery-3.3.1.js"></script>
<script type="text/javascript">
var path='<%=basePath %>';
var openId='${param.openId}';

$(function(){
	getWithDrawMoney();
});

function getWithDrawMoney(){
	$.post("getWithDrawMoneyByOpenId",
		{openId:openId},
		function(data){
			$("#wdmVal_span").text(data.withDrawMoney);
		}
	,"json");
}

function userWithDraw(){
	//var alipayNo=$("#alpnVal_span").text();
	//var realName=$("#rnVal_span").text();
	var withDrawMoney=$("#wdmVal_span").text();
	var desc="企业付款到零钱";
	//copyStr(path+"vip/userAlipayWithDraw?alipayNo="+alipayNo+"&realName="+realName+"&withDrawMoney="+withDrawMoney+"&openId="+openId);
	$.post(path+"vip/userWxWithDraw",
		{amount:withDrawMoney,desc:desc,openId:openId},
		function(data){
			if(data.status=="ok"){
				alert(data.message);
				location.href=location.href;
			}
			else{
				alert(data.message);
			}
		}
	,"json");
}

function copyStr(val) { //val 是要复制的字符串
    var input = document.createElement("input");
    input.value = val;
    input.readOnly = true
    document.body.appendChild(input);
    input.select();
    input.setSelectionRange(0, input.value.length)
    document.execCommand('Copy');
    document.body.removeChild(input);
    //window.scrollTo(0, 0);;
    alert("支付链接复制成功，请粘贴到浏览器里");
}

function goBack(){
	location.href=path+"vip/goPage?page=mineCenter&openId="+openId;
}
</script>
<title>我的零钱</title>
</head>
<body>
<div class="top_div">
	<span>我的零钱</span>
</div>
<div class="back_div">
	<span class="back_span" onclick="goBack()">&lt;返回</span>
</div>
<div class="main_div">
	<div>
		<img class="yuan_img" alt="" src="<%=basePath %>resource/image/021.png"/>
	</div>
	<div class="wdlq_div">
		<span class="wdlq_span">我的零钱</span>
	</div>
	<div class="wdm_div">
		<span class="yuan_span">￥</span>
		<span class="wdmVal_span" id="wdmVal_span"></span>
	</div>
	<div class="wdBut_div" onclick="userWithDraw()">提现</div>
</div>
</body>
</html>