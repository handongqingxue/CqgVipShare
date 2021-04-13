<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	String basePath=request.getScheme()+"://"+request.getServerName()+":"
		+request.getServerPort()+request.getContextPath()+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
<link rel="stylesheet" href="<%=basePath %>resource/css/vip/mine/merchant/card/hanRec/detail.css"/>
<script type="text/javascript" src="<%=basePath %>resource/js/jquery-3.3.1.js"></script>
<script type="text/javascript">
var path='<%=basePath %>';
var vipPath='<%=basePath%>'+"vip/";
var openId='${param.openId}';
var shopId='${sessionScope.merchant.id }';
$(function(){
});

function goBack(){
	location.href=path+"vip/goPage?page=mineHanRec&openId="+openId;
}
</script>
<title>办卡记录详情</title>
</head>
<body>
<div class="top_div">
	<span>办卡记录详情</span>
</div>
<div class="back_div">
	<span class="back_span" onclick="goBack()">&lt;返回</span>
</div>
<div class="main_div" id="main_div">
	<div class="attr_div">
		<div class="key_div">办卡人姓名：</div>
		<div class="val_div">${requestScope.handleRecord.realName }</div>
	</div>
	<div class="attr_div">
		<div class="key_div">手机号：</div>
		<div class="val_div">${requestScope.handleRecord.phone }</div>
	</div>
	<div class="attr_div">
		<div class="key_div">qq：</div>
		<div class="val_div">${requestScope.handleRecord.qq }</div>
	</div>
	<div class="attr_div">
		<div class="key_div">微信：</div>
		<div class="val_div">${requestScope.handleRecord.wxNo }</div>
	</div>
	<div class="attr_div">
		<div class="key_div">卡名：</div>
		<div class="val_div">${requestScope.handleRecord.mcName }</div>
	</div>
	<div class="attr_div">
		<div class="key_div">类型：</div>
		<div class="val_div">
			<c:if test="${requestScope.handleRecord.mcType eq 1 }">年</c:if>
			<c:if test="${requestScope.handleRecord.mcType eq 2 }">季</c:if>
			<c:if test="${requestScope.handleRecord.mcType eq 3 }">月</c:if>
			<c:if test="${requestScope.handleRecord.mcType eq 4 }">充值</c:if>
			<c:if test="${requestScope.handleRecord.mcType eq 5 }">次</c:if>
			卡
		</div>
	</div>
	<div class="attr_div">
		<div class="key_div">金额：</div>
		<div class="val_div">${requestScope.handleRecord.money }</div>
	</div>
	<div class="attr_div">
		<div class="key_div">办卡时间：</div>
		<div class="val_div">${requestScope.handleRecord.createTime }</div>
	</div>
	<div class="attr_div">
		<div class="key_div">状态：</div>
		<div class="val_div">${requestScope.handleRecord.receive?'已':'未' }领取</div>
	</div>
</div>
</body>
</html>