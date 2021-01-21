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
<link rel="stylesheet" href="<%=basePath %>resource/css/vip/addComment.css"/>
<script type="text/javascript" src="<%=basePath %>resource/js/jquery-3.3.1.js"></script>
<script type="text/javascript">
var path='<%=basePath %>';
var srUuid='${param.srUuid}';
var type='${param.type}';
var openId='${param.openId}';

function addComment(){
	var content=$("#content_ta").val();
	$.post("addComment",
		{srUuid:srUuid,content:content,fxzOpenId:openId},
		function(data){
			if(data.status=="ok"){
				location.href=path+"vip/goPage?page=mineShareList&type=4&openId="+openId;
			}
		}
	,"json");
}

function goBack(){
	location.href=path+"vip/goPage?page=mineShareList&type="+type+"&openId="+openId;
}
</script>
<title>发表评价</title>
</head>
<body>
<div class="top_div">
	<span class="back_span" onclick="goBack()">&lt;返回</span>
	<span class="fbpl_span">发表评价</span>
	<span class="fb_span" onclick="addComment()">发布</span>
</div>
<div class="vipInfo_div">
	<img class="shopLogo_img" alt="" src="${param.shopLogo}">
	<span class="shopName_span">${param.shopName}</span>
	<span class="vipName_span">${param.vipName}</span>
</div>
<div class="space_div"></div>
<div class="content_div">
	<textarea class="content_ta" id="content_ta" rows="8" cols="10"></textarea>
</div>
</body>
</html>