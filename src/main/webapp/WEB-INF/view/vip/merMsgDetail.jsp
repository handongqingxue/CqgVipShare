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
<link rel="stylesheet" href="<%=basePath %>resource/css/vip/merMsgDetail.css"/>
<script type="text/javascript" src="<%=basePath %>resource/js/jquery-3.3.1.js"></script>
<script type="text/javascript">
var path='<%=basePath%>';
var openId='${param.openId}';

function goBack(){
	location.href=path+"vip/toMerchantMessage?openId="+openId;
}
</script>
<title>Insert title here</title>
</head>
<body>
<div class="top_div">
	<span>消息详情</span>
</div>
<div class="back_div">
	<span class="back_span" onclick="goBack()">&lt;返回</span>
</div>
<div>${requestScope.merchantMessage.title }</div>
<div>${requestScope.merchantMessage.content }</div>
<div>${requestScope.merchantMessage.createTime }</div>
</body>
</html>