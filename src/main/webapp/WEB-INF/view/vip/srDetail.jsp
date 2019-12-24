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
<title>分享单详情</title>
</head>
<body style="margin: 0px;">
<div style="width: 100%;height: 40px;line-height: 40px;color:#fff;background-color: #EC4149;">
	<span style="margin-left: 10px;" onclick="history.go(-1)">&lt;返回</span>
	<div style="text-align:center;width: 200px;height: 40px;line-height: 40px;margin: 0 auto;margin-top: -40px;">
		<span>${requestScope.shareRecord.shopName }</span>
	</div>
</div>
<img alt="" src="${requestScope.shareRecord.shopLogo }" style="width: 100%;height: 200px;">
<div style="height:40px;line-height:40px;margin-top: 10px;">
	<span style="margin-left: 20px;">
		卡号：
	</span>
	<span style="float: right;margin-right: 20px;">${requestScope.shareRecord.vipNo }</span>
</div>
<div style="height:40px;line-height:40px;">
	<span style="margin-left: 20px;">
		卡名：
	</span>
	<span style="float: right;margin-right: 20px;">${requestScope.shareRecord.vipName }</span>
</div>
<div style="height:40px;line-height:40px;">
	<span style="margin-left: 20px;">
		金额：
	</span>
	<span style="float: right;margin-right: 20px;">${requestScope.shareRecord.shareMoney }</span>
</div>
<div style="height:40px;line-height:40px;">
	<span style="margin-left: 20px;">
		预估消费日期：
	</span>
	<span style="float: right;margin-right: 20px;">${requestScope.shareRecord.ygxfDate }</span>
</div>
<div style="height:40px;line-height:40px;">
	<span style="margin-left: 20px;">
		卡主手机号：
	</span>
	<span style="float: right;margin-right: 20px;">${requestScope.shareRecord.kzPhone }</span>
</div>
<div style="height:40px;line-height:40px;">
	<span style="margin-left: 20px;">
		消费地址：
	</span>
	<span style="float: right;margin-right: 20px;">${requestScope.shareRecord.shopAddress }</span>
</div>
<div style="height:150px;line-height:150px;">
	<span style="margin-left: 20px;">
		消费二维码：
	</span>
	<div style="float: right;margin-right: 20px;">
	<img src="${requestScope.shareRecord.qrcodeUrl }" style="width: 150px;height: 150px;"/>
	</div>
</div>
</body>
</html>