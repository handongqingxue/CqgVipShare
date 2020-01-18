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
				location.href=path+"vip/toShareList?type=4&openId="+openId;
			}
		}
	,"json");
}

function goBack(){
	location.href=path+"vip/toShareList?type="+type+"&openId="+openId;
}
</script>
<title>发表评价</title>
</head>
<body style="margin: 0px;">
<div style="width: 100%;height: 40px;line-height: 40px;color:#fff;background-color: #EC4149;">
	<span style="margin-left: 10px;" onclick="goBack()">&lt;返回</span>
	<span style="margin-left: 50px;">发表评价</span>
	<span style="margin-right: 15px;float: right;" onclick="addComment()">发布</span>
</div>
<div style="width: 100%;height: 120px;">
	<img alt="" src="${param.shopLogo}" style="width:100px;height:100px;margin-top:10px;margin-left:20px;">
	<span style="font-size:20px;margin-top:10px;margin-left:10px;position: absolute;">${param.shopName}</span>
	<span style="font-size:18px;margin-top:45px;margin-left:10px;position: absolute;">${param.vipName}</span>
</div>
<div class="space_div" style="width: 100%;height:20px;"></div>
<div class="content_div" style="width:370px;margin: 0 auto;">
	<textarea class="content_ta" id="content_ta" rows="8" cols="10" style="width:100%;height:250px;font-size: 22px;"></textarea>
</div>
</body>
</html>