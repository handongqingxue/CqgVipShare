<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
	String basePath=request.getScheme()+"://"+request.getServerName()+":"
	+request.getServerPort()+request.getContextPath()+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
<link rel="stylesheet" href="<%=basePath %>resource/css/vip/mine/srDetail.css"/>
<script type="text/javascript" src="<%=basePath %>resource/js/jquery-3.3.1.js"></script>
<script type="text/javascript">
var path='<%=basePath %>';
var openId='${param.openId}';
$(function(){
	
});

function showQrcodeDiv(flag){
	var sqrcBgDiv=$("#sqrc_bg_div");
	var qrcodeImg=$("#sqrc_div #qrcode_img");
	if(flag==1){
		sqrcBgDiv.css("display","block");
		qrcodeImg.attr("src",$("#qrcodeUrl_div #qrcode_img").attr("src"));
	}
	else{
		sqrcBgDiv.css("display","none");
		qrcodeImg.attr("src","");
	}
}

function goBack(){
	location.href=path+"vip/goPage?page=mineShareList&openId="+openId;
}
</script>
<title>分享单详情</title>
</head>
<body>
<div class="sqrc_bg_div" id="sqrc_bg_div">
	<div class="sqrc_div" id="sqrc_div">
		<div class="close_div">
			<span class="close_span" onclick="showQrcodeDiv(0)">X</span>
		</div>
		<img class="qrcode_img" id="qrcode_img" src=""/>
		<!-- 
		<img class="qrcode_img" id="qrcode_img" src="/CqgVipShare/upload/20210104120059.jpg"/>
		 -->
	</div>
</div>

<div class="top_div">
	<span class="back_span" onclick="goBack()">&lt;返回</span>
	<div class="shopName_div">
		<span>${requestScope.srDetail.shopName }</span>
	</div>
</div>
<img class="shopLogo_img" alt="" src="${requestScope.srDetail.shopLogo }">
<div class="space_div"></div>
<div class="attr_div">
	<span class="tit_span">
		卡号：
	</span>
	<span class="val_span">${requestScope.srDetail.scNo }</span>
</div>
<div class="attr_div">
	<span class="tit_span">
		卡名：
	</span>
	<span class="val_span">${requestScope.srDetail.scName }</span>
</div>
<div class="attr_div">
	<span class="tit_span">
		金额：
	</span>
	<span class="val_span">${requestScope.srDetail.shareMoney }</span>
</div>
<div class="attr_div">
	<span class="tit_span">
		预估消费日期：
	</span>
	<span class="val_span">${requestScope.srDetail.ygxfDate }</span>
</div>
<div class="attr_div">
	<span class="tit_span">
		卡主手机号：
	</span>
	<span class="val_span">${fn:substring(requestScope.srDetail.kzPhone,0,3) }****${fn:substring(requestScope.srDetail.kzPhone,7,11) }</span>
</div>
<div class="attr_div">
	<span class="tit_span">
		消费地址：
	</span>
	<span class="val_span">${requestScope.srDetail.shopAddress }</span>
</div>
<div class="qrcodeUrl_div" id="qrcodeUrl_div">
	<span class="tit_span ${param.used eq 1?'qrcUsedTit_span':'qrcUnUsedTit_span' }">
		消费二维码：
	</span>
	<c:if test="${param.used eq 1}">
		<span class="qrcMemo_span">
			此码已使用
		</span>
	</c:if>
	<div class="val_span">
		<img class="qrcode_img" id="qrcode_img" src="${requestScope.srDetail.qrcodeUrl }" onclick="showQrcodeDiv(1)"/>
	</div>
</div>
</body>
</html>