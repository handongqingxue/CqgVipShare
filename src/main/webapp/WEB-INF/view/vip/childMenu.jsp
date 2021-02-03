<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	String basePath=request.getScheme()+"://"+request.getServerName()+":"
		+request.getServerPort()+request.getContextPath()+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
<link rel="stylesheet" href="<%=basePath %>resource/css/vip/childMenu.css"/>
<script type="text/javascript" src="<%=basePath %>resource/js/jquery-3.3.1.js"></script>
<script type="text/javascript">
var path='<%=basePath %>';
var openId='${param.openId}';

function goPage(page){
	var params="";
	switch (page) {
	case "tradeList":
		if('${param.page}'=="mySubmitMenu")
			params="&from=mySubmitMenu&action=addShareCard";
		else if('${param.page}'=="mineTransferCard")
			params="&from=mineTransferCard&action=addTransferCard";
		break;
	}
	location.href=path+"vip/goPage?openId="+openId+"&page="+page+params;
}
</script>
<title>Insert title here</title>
</head>
<body>
<div class="top_div">
	<c:if test="${param.page eq 'mineTransferCard' }">
	<span>转让卡</span>
	</c:if>
	<c:if test="${param.page eq 'mySubmitMenu' }">
	<span>我的发布</span>
	</c:if>
</div>
<div class="back_div">
	<c:if test="${param.page eq 'mineTransferCard'||param.page eq 'mySubmitMenu' }">
	<span class="back_span" onclick="goPage('mineInfo')">&lt;返回</span>
	</c:if>
</div>
<c:if test="${param.page eq 'mineTransferCard' }">
	<div class="but_div addTransfer_div" onclick="goPage('tradeList')">
		<img class="txt_img" alt="" src="<%=basePath %>resource/image/015.png">
		<span class="txt_span">发布新卡</span>
		<img class="goPage_img" alt="" src="<%=basePath %>resource/image/016.png">
	</div>
	<div class="but_div fbTransfer_div" onclick="goPage('mineTcl')">
		<img class="txt_img" alt="" src="<%=basePath %>resource/image/015.png">
		<span class="txt_span">发布的信息</span>
		<img class="goPage_img" alt="" src="<%=basePath %>resource/image/016.png">
	</div>
</c:if>
<c:if test="${param.page eq 'mySubmitMenu' }">
	<div class="but_div mineMscl_div" onclick="goPage('mineMscl')">
		<img class="txt_img" alt="" src="<%=basePath %>resource/image/015.png">
		<span class="txt_span">会员</span>
		<img class="goPage_img" alt="" src="<%=basePath %>resource/image/016.png">
	</div>
	<div class="but_div asc_div" onclick="goPage('tradeList')">
		<img class="txt_img" alt="" src="<%=basePath %>resource/image/015.png">
		<span class="txt_span">发布新卡</span>
		<img class="goPage_img" alt="" src="<%=basePath %>resource/image/016.png">
	</div>
</c:if>
</body>
</html>