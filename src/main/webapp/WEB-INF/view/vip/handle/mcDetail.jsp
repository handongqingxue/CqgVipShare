<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String basePath=request.getScheme()+"://"+request.getServerName()+":"
	+request.getServerPort()+request.getContextPath()+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
<link rel="stylesheet" href="<%=basePath %>resource/css/vip/handle/mcDetail.css"/>
<script type="text/javascript" src="<%=basePath %>resource/js/jquery-3.3.1.js"></script>
<script type="text/javascript">
var path='<%=basePath%>';
var id='${param.id}';
var openId='${param.openId}';
var tradeId='${param.tradeId}';
var tradeName='${param.tradeName}';
var shopId='${param.shopId}';
var prePage='${param.prePage}';
var action='${param.action}';
var from='${param.from}';

function toAddHandleRecord(){
	location.href=path+"vip/goPage?page=handleAhr&tradeId="+tradeId+"&tradeName="+tradeName+"&shopId="+shopId+"&prePage="+prePage+"&action="+action+"&from="+from+"&openId="+openId+"&id="+id+"&mcId="+'${requestScope.mcInfo.id }'+"&money="+'${requestScope.mcInfo.money }';
}

function goBack(){
	location.href=path+"vip/goPage?page=handleMcl&tradeId="+tradeId+"&tradeName="+tradeName+"&shopId="+shopId+"&prePage="+prePage+"&action="+action+"&from="+from+"&openId="+openId;
}
</script>
<title>详情</title>
</head>
<body>
<div class="top_div">
	<span>${requestScope.mcInfo.shopName }</span>
</div>
<div class="back_div">
	<span class="back_span" onclick="goBack()">&lt;返回</span>
</div>
<img class="logo_img" alt="" src="${requestScope.mcInfo.logo }">
<div class="shopName_div">${requestScope.mcInfo.shopName }</div>
<div class="line_div"></div>
<div class="shopAddress_div">
	<img class="shopAddress_img" alt="" src="<%=basePath%>resource/image/014.png">
	<span class="shopAddress_span">${requestScope.mcInfo.shopAddress }</span>
</div>
<div class="state_div">
	<img class="state_img" alt="" src="<%=basePath%>resource/image/015.png">
	<span class="state_span">营业</span>
</div>
<div class="line_div"></div>
<div class="hykxx_div">
	会员卡信息
</div>
<div class="mcName_div">
	<img class="mcName_img" alt="" src="<%=basePath%>resource/image/014.png">
	<span class="mcName_span">会员卡名称：${requestScope.mcInfo.mcName }</span>
	<c:if test="${requestScope.mcInfo.mcType eq '1' }">
		<span class="consumeMoney_span">总金额：${requestScope.mcInfo.money }</span>
	</c:if>
	<c:if test="${requestScope.mcInfo.mcType eq '2' }">
		<span class="consumeCount_span">使用次数：${requestScope.mcInfo.consumeCount }</span>
	</c:if>
	<div class="wybk_div" onclick="toAddHandleRecord()">我要办卡</div>
</div>
<div class="vipType_div">
	<img class="vipType_img" alt="" src="<%=basePath%>resource/image/015.png">
	<span class="vipType_span">会员卡类型：
		<c:if test="${requestScope.mcInfo.mcType eq '1' }">
			金额卡
		</c:if>
		<c:if test="${requestScope.mcInfo.mcType eq '2' }">
			次卡
		</c:if>
	</span>
</div>
<div class="vipPrice_div">
	<img class="vipPrice_img" alt="" src="<%=basePath%>resource/image/015.png">
	<span class="vipPrice_span">会员卡价格：${requestScope.mcInfo.money }</span>
</div>
<c:if test="${requestScope.mcInfo.discount ne null }">
<div class="discPrice_div">
	<img class="discPrice_img" alt="" src="<%=basePath%>resource/image/015.png">
	<span class="discPrice_span">会员卡折扣：${requestScope.mcInfo.discount }</span>
</div>
</c:if>
<div class="line_div"></div>
<div class="describe_div">会员服务描述：${requestScope.mcInfo.describe }</div>
</body>
</html>