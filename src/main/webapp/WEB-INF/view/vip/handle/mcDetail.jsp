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
<link rel="stylesheet" href="<%=basePath %>resource/css/vip/handle/mcDetail.css"/>
<script type="text/javascript" src="<%=basePath %>resource/js/jquery-3.3.1.js"></script>
<script type="text/javascript">
var path='<%=basePath%>';
var id='${param.id}';
var openId='${param.openId}';

function toAddHandleRecord(){
	location.href=path+"vip/goPage?page=homeAhr&id="+id+"&mcId="+'${requestScope.mcInfo.id }'+"&openId="+openId+"&money="+'${requestScope.mcInfo.money }';
}

function goBack(){
	location.href=path+"vip/goPage?page=handleMcl&openId="+openId;
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
	<span class="mcName_span">会员卡名称：${requestScope.mcInfo.mvName }</span>
	<span class="consumeCount_span">使用次数：${requestScope.mcInfo.consumeCount }</span>
	<div class="wybk_div" onclick="toAddHandleRecord()">我要办卡</div>
</div>
<div class="vipType_div">
	<img class="vipType_img" alt="" src="<%=basePath%>resource/image/015.png">
	<span class="vipType_span">会员卡类型：</span>
</div>
<div class="vipPrice_div">
	<img class="vipPrice_img" alt="" src="<%=basePath%>resource/image/015.png">
	<span class="vipPrice_span">会员卡价格：${requestScope.mcInfo.money }</span>
</div>
<div class="line_div"></div>
<div class="describe_div">会员服务描述：${requestScope.mcInfo.describe }</div>
</body>
</html>