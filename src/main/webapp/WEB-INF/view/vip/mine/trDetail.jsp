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
<link rel="stylesheet" href="<%=basePath %>resource/css/vip/mine/lrDetail.css"/>
<script type="text/javascript" src="<%=basePath %>resource/js/jquery-3.3.1.js"></script>
<script type="text/javascript">
var path='<%=basePath %>';
var openId='${param.openId}';

function updatePageValue(postParams,urlParams){
	$.post("updatePageValue",
		postParams,
		function(data){
			if(data.status=="ok")
				location.href=path+"vip/goPage?openId="+openId+urlParams;
		}
	,"json");
}

function goBack(){
	var postParams={type:6,openId:openId};
	var urlParams="&page=mineShareList";
	updatePageValue(postParams,urlParams);
}
</script>
<title>转让卡详情</title>
</head>
<body>
<div class="top_div">
	<span>${requestScope.transferRecord.shopName }</span>
</div>
<div class="back_div">
	<span class="back_span" onclick="goBack()">&lt;返回</span>
</div>
<img class="shopLogo_img" alt="" src="${requestScope.transferRecord.shopLogo }">
<div class="space_div"></div>
<div class="attr_div">
	<span class="tit_span">
		卡号：
	</span>
	<span class="val_span">${requestScope.transferRecord.scNo }</span>
</div>
<div class="attr_div">
	<span class="tit_span">
		卡名：
	</span>
	<span class="val_span">${requestScope.transferRecord.scName }</span>
</div>
<div class="attr_div">
	<span class="tit_span">
		金额：
	</span>
	<span class="val_span">${requestScope.transferRecord.shareMoney }</span>
</div>
<div class="attr_div">
	<span class="tit_span">
		消费地址：
	</span>
	<span class="val_span">${requestScope.transferRecord.shopAddress }</span>
</div>
</body>
</html>