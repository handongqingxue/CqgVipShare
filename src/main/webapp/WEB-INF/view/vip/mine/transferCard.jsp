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
<link rel="stylesheet" href="<%=basePath %>resource/css/vip/mine/transferCard.css"/>
<script type="text/javascript" src="<%=basePath %>resource/js/jquery-3.3.1.js"></script>
<script type="text/javascript">
var path='<%=basePath %>';
var openId='${param.openId}';

function goTradeList(){
	location.href=path+"vip/goPage?page=tradeList&action=addTransferCard&openId="+openId;
}

function goDelLeaseList(){
	location.href=path+"vip/goPage?page=mineDll&openId="+openId;
}

function goBack(){
	location.href=path+"vip/goPage?page=mineInfo&openId="+openId;
}
</script>
<title>Insert title here</title>
</head>
<body>
<div class="top_div">
	<span>租赁卡</span>
</div>
<div class="back_div">
	<span class="back_span" onclick="goBack()">&lt;返回</span>
</div>
<div class="but_div addLease_div" onclick="goTradeList()">
	发布租赁卡信息
</div>
<div class="but_div delLease_div" onclick="goDelLeaseList()">
	删除租赁卡信息
</div>
</body>
</html>