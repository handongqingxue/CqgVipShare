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
<link rel="stylesheet" href="<%=basePath %>resource/css/vip/alipay.css"/>
<script type="text/javascript" src="<%=basePath %>resource/js/jquery-3.3.1.js"></script>
<script type="text/javascript">
var path='<%=basePath %>';
var openId='${param.openId}';

function goBindAlipay(){
	location.href=path+"vip/toBindAlipay?openId="+openId;
}

function goBack(){
	location.href=path+"vip/goPage?page=mineInfo&openId="+openId;
}
</script>
<title>支付宝</title>
</head>
<body>
<div class="top_div">
	<span>支付宝</span>
</div>
<div class="back_div">
	<span class="back_span" onclick="goBack()">&lt;返回</span>
</div>
<div class="alpn_div">
	<span class="alpnTit_span">
		支付宝账户：
	</span>
	<span class="alpnVal_span">${requestScope.vip.alipayNo }</span>
</div>
<div class="rn_div">
	<span class="rnTit_span">
		真实姓名：
	</span>
	<span class="rnVal_span">${requestScope.vip.realName }</span>
</div>
<div class="bindAlipay_div" onclick="goBindAlipay()">
	绑定支付宝
</div>
</body>
</html>