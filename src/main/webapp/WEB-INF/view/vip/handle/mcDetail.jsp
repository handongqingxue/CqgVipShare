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
var logo='${param.logo}';
var shopId='${param.shopId}';
var shopName='${param.shopName}';
var shopAddress='${param.shopAddress}';
var prePage='${param.prePage}';
var action='${param.action}';
var from='${param.from}';

function toAddHandleRecord(){
	location.href=path+"vip/goPage?page=handleAhr&tradeId="+tradeId+"&tradeName="+tradeName+"&shopId="+shopId+"&prePage="+prePage+"&action="+action+"&from="+from+"&openId="+openId+"&id="+id+"&mcId="+'${requestScope.mcInfo.id }'+"&money="+'${requestScope.mcInfo.money }';
}

function goBack(){
	location.href=path+"vip/goPage?page=handleMcl&tradeId="+tradeId+"&tradeName="+tradeName+"&logo="+logo+"&shopId="+shopId+"&shopName="+shopName+"&shopAddress="+shopAddress+"&prePage="+prePage+"&action="+action+"&from="+from+"&openId="+openId;
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
<div class="logo_div">
	<img class="logo_img" alt="" src="${requestScope.mcInfo.logo }">
</div>
<div class="row_div shopName_div">${requestScope.mcInfo.shopName }</div>
<div class="repuImg_div">
	<img class="repu1_img" id="repu1_img" alt="" src="<%=basePath%>resource/image/star_yellow.png">
	<img class="repu2_img" id="repu2_img" alt="" src="<%=basePath%>resource/image/star_yellow.png">
	<img class="repu3_img" id="repu3_img" alt="" src="<%=basePath%>resource/image/star_yellow.png">
	<img class="repu4_img" id="repu4_img" alt="" src="<%=basePath%>resource/image/star_yellow.png">
	<img class="repu5_img" id="repu5_img" alt="" src="<%=basePath%>resource/image/star_yellow.png">
	<span class="score_span">5</span>
</div>
<div class="row_div state_div">
	<span>营业中</span><span class="openTime_span">周二至周日 09:00-21:00</span>
</div>
<div class="line_div"></div>
<div class="row_div shopAddress_div">
	${requestScope.mcInfo.shopAddress }
</div>
<div class="space_div"></div>
<div class="row_div hykxx_div">
	会员卡信息
</div>
<div class="row_div mcName_div">
	<span class="mcName_span">${requestScope.mcInfo.mcName }</span>
</div>
<div class="row_div scType_div">
	<span>
		<c:if test="${requestScope.mcInfo.mcType eq '1' }">
			金额卡
		</c:if>
		<c:if test="${requestScope.mcInfo.mcType eq '2' }">
			次卡
		</c:if>
	</span>
	<c:if test="${requestScope.mcInfo.discount ne null }">
		<span class="discPrice_span">${requestScope.mcInfo.discount }折</span>
	</c:if>
</div>
<div class="row_div scType_div" style="color: #FD6104;font-weight: bold;">
	<c:if test="${requestScope.mcInfo.mcType eq '1' }">
		<span class="consumeMoney_span">金额：${requestScope.mcInfo.money }</span>
	</c:if>
	<c:if test="${requestScope.mcInfo.mcType eq '2' }">
		<span>￥${requestScope.mcInfo.money }/次</span>
		<span class="consumeCount_span">次数：${requestScope.mcInfo.consumeCount }</span>
	</c:if>
	<div class="wybk_div" onclick="toAddHandleRecord()">我要办卡</div>
</div>
<div class="line_div"></div>
<div class="describe_div">简介：${requestScope.mcInfo.describe }</div>
<div class="space_div"></div>
<div class="yhpj_div">
	<div class="tit_div">用户评价(0)</div>
</div>
</body>
</html>