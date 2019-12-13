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
var openId='${param.openId}';
$(function(){
	$.post("queryUserFromDB",
		{openId:openId},
		function(data){
			var user=data.user;
			$("#nickName_div").text(user.nickName);
			$("#headImgUrl_img").attr("src",user.headImgUrl);
		}
	,"json");
});

function getUrlParam(name){
	var reg = new RegExp("(^|&)"+ name +"=([^&]*)(&|$)"); //构造一个含有目标参数的正则表达式对象
	var r = window.location.search.substr(1).match(reg);  //匹配目标参数
	if (r!=null) return unescape(r[2]); return null; //返回参数值
} 
</script>
<title>我的</title>
</head>
<body style="margin: 0px;">
<a href="<%=basePath %>vip/toEditMerchant?openId=${param.openId}">我要成为商家</a>
<div id="nickName_div"></div>
<div>
	<img id="headImgUrl_img" alt="" src="" style="width:100px;height:100px;">
</div>
<jsp:include page="foot.jsp"></jsp:include>
</body>
</html>