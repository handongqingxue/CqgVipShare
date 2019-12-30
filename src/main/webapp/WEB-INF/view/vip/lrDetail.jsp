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
var openId='${param.openId}';
</script>
<title>Insert title here</title>
</head>
<body style="margin: 0px;">
<div style="width: 100%;height: 40px;line-height: 40px;color:#fff;background-color: #EC4149;">
	<span style="margin-left: 10px;" onclick="history.go(-1)">&lt;返回</span>
	<div style="text-align:center;width: 200px;height: 40px;line-height: 40px;margin: 0 auto;margin-top: -40px;">
		<span>${requestScope.leaseRecord.shopName }</span>
	</div>
</div>
<img alt="" src="${requestScope.leaseRecord.shopLogo }" style="width: 100%;height: 200px;">
<div style="height:40px;line-height:40px;margin-top: 10px;">
	<span style="margin-left: 20px;">
		卡号：
	</span>
	<span style="float: right;margin-right: 20px;">${requestScope.leaseRecord.vipNo }</span>
</div>
<div style="height:40px;line-height:40px;">
	<span style="margin-left: 20px;">
		卡名：
	</span>
	<span style="float: right;margin-right: 20px;">${requestScope.leaseRecord.vipName }</span>
</div>
<div style="height:40px;line-height:40px;">
	<span style="margin-left: 20px;">
		金额：
	</span>
	<span style="float: right;margin-right: 20px;">${requestScope.leaseRecord.shareMoney }</span>
</div>
<div style="height:40px;line-height:40px;">
	<span style="margin-left: 20px;">
		消费地址：
	</span>
	<span style="float: right;margin-right: 20px;">${requestScope.leaseRecord.shopAddress }</span>
</div>
</body>
</html>