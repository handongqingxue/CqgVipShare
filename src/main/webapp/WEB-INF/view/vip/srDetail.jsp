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
<link rel="stylesheet" href="<%=basePath %>resource/css/vip/srDetail.css"/>
<script type="text/javascript" src="<%=basePath %>resource/js/jquery-3.3.1.js"></script>
<script type="text/javascript">
var path='<%=basePath %>';
var openId='${param.openId}';
</script>
<title>分享单详情</title>
</head>
<body>
<div class="top_div">
	<span class="back_span" onclick="history.go(-1)">&lt;返回</span>
	<div class="shopName_div">
		<span>${requestScope.srDetail.shopName }</span>
	</div>
</div>
<img class="shopLogo_img" alt="" src="${requestScope.srDetail.shopLogo }">
<div class="vipNo_div">
	<span class="vipNoTit_span">
		卡号：
	</span>
	<span class="vipNoVal_span">${requestScope.srDetail.vipNo }</span>
</div>
<div class="vipName_div">
	<span class="vnTit_span">
		卡名：
	</span>
	<span class="vnVal_span">${requestScope.srDetail.vipName }</span>
</div>
<div class="shareMoney_div">
	<span class="smTit_span">
		金额：
	</span>
	<span class="smVal_span">${requestScope.srDetail.shareMoney }</span>
</div>
<div class="ygxfDate_div">
	<span class="ygxfdTit_span">
		预估消费日期：
	</span>
	<span class="ygxfdVal_span">${requestScope.srDetail.ygxfDate }</span>
</div>
<div class="kzPhone_div">
	<span class="kpTit_span">
		卡主手机号：
	</span>
	<span class="kpVal_span">${requestScope.srDetail.kzPhone }</span>
</div>
<div class="shopAddress_div">
	<span class="saTit_span">
		消费地址：
	</span>
	<span class="saVal_span">${requestScope.srDetail.shopAddress }</span>
</div>
<div class="qrcodeUrl_div">
	<span class="qrcTit_span">
		消费二维码：
	</span>
	<div class="qrcVal_span">
		<img class="qrcode_img" src="${requestScope.srDetail.qrcodeUrl }"/>
	</div>
</div>
</body>
</html>