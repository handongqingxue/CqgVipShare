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
<link rel="stylesheet" href="<%=basePath %>resource/css/vip/handle/addMerComment.css"/>
<script type="text/javascript" src="<%=basePath %>resource/js/jquery-3.3.1.js"></script>
<script type="text/javascript">
var path='<%=basePath %>';
var openId='${param.openId}';
var tradeId='${requestScope.pageValue.tradeId}';
var tradeName='${requestScope.pageValue.tradeName}';
var shopId='${requestScope.pageValue.shopId}';
var shopName='${requestScope.pageValue.shopName}';
var shopAddress='${requestScope.pageValue.shopAddress}';
var logo='${requestScope.pageValue.logo}';
var prePage='${requestScope.pageValue.prePage}';
var from='${requestScope.pageValue.from}';
var action='${requestScope.pageValue.action}';

function addComment(){
	var content=$("#content_ta").val();
	$.post("addMerComment",
		{content:content,openId:openId,type:1,shopId:shopId},
		function(data){
			if(data.status=="ok"){
				location.href=path+"vip/goPage?page=handleMcl&openId="+openId;
			}
		}
	,"json");
}

function goBack(){
	location.href=path+"vip/goPage?page=handleMcl&openId="+openId;
}
</script>
<title>发表评价</title>
</head>
<body>
<div class="top_div">
	<span>发表评价</span>
</div>
<div class="back_div">
	<span class="back_span" onclick="goBack()">&lt;返回</span>
	<span class="fb_span" onclick="addComment()">发布</span>
</div>
<div class="shopLogo_div">
	<img class="shopLogo_img" alt="" src="${requestScope.pageValue.logo}">
</div>
<div class="shopName_div">${requestScope.pageValue.shopName}</div>
<div class="space_div"></div>
<div class="content_div">
	<textarea class="content_ta" id="content_ta" rows="8" cols="10"></textarea>
</div>
</body>
</html>