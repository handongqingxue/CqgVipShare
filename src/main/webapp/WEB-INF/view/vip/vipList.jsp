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
function goAddVip(){
	location.href=path+"vip/toAddVip";
}
</script>
<title>行业内页</title>
</head>
<body style="margin: 0px;">
<div style="width: 100%;height: 40px;line-height: 40px;color:#fff;background-color: #EC4149;">
	<span style="margin-left: 10px;" onclick="history.go(-1)">&lt;返回</span>
	<span style="margin-left: 50px;">${param.tradeName }会员共享</span>
	<span style="margin-right: 15px;float: right;" onclick="goAddVip()">发布</span>
</div>
<div>
	<div style="width:100%;height:120px;background-color:yellow;">
		<img src="https://gss3.bdstatic.com/-Po3dSag_xI4khGkpoWK1HF6hhy/baike/w%3D268%3Bg%3D0/sign=98681d43845494ee8722081f15ce87c3/29381f30e924b899c2b7e5c466061d950b7bf647.jpg" style="width:80px;height:80px;margin-top:10px;margin-left:10px;"/>
		<span style="font-size:18px;margin-top:10px;margin-left:10px;position: absolute;">岳家庄</span>
		<span style="font-size:15px;margin-top:40px;margin-left:10px;position: absolute;">80次年卡/剩余次数56</span>
		<span style="font-size:12px;margin-top:70px;margin-left:10px;position: absolute;">价格￥10元/次</span>
		<span style="font-size:12px;margin-top:90px;margin-left:10px;color:#DE792B;background-color:#FEF4EB;position: absolute;">aaaaaaaaaaa</span>
	</div>
</div>
</body>
</html>