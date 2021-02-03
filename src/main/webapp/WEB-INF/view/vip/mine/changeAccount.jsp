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
<link rel="stylesheet" href="<%=basePath %>resource/css/vip/mine/changeAccount.css"/>
<script type="text/javascript" src="<%=basePath %>resource/js/jquery-3.3.1.js"></script>
<script type="text/javascript">
var path='<%=basePath %>';
var openId='${param.openId}';
var from='${param.from}';

function goPage(flag){
	var goPage;
	switch (flag) {
		case 1:
			goPage="mineInfo";
			break;
		case 2:
			goPage="mineMerchantInfo";
			break;
	}
	location.href=path+"vip/goPage?page="+goPage+"&openId="+openId;
}

function goBack(){
	var goPage;
	if(from=="vip")
		goPage="mineInfo";
	else if(from=="merchant")
		goPage="mineMerchantInfo";
	location.href=path+"vip/goPage?page="+goPage+"&openId="+openId;
}
</script>
<title>切换账号</title>
</head>
<body>
<div class="top_div">
	<span class="qhzh_span">切换账号</span>
</div>
<div class="back_div">
	<span class="back_span" onclick="goBack()">&lt;返回</span>
</div>
<div class="xzdlsf_div">请选择登录身份</div>
<div class="but_div vip_div" onclick="goPage(1);">会员</div>
<div class="but_div merchant_div" onclick="goPage(2);">商家</div>
</body>
</html>