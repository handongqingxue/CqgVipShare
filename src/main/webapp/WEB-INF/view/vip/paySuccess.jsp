<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
<%@include file="../background/js.jsp"%>
<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
</head>
<body>
<div style="text-align: center;font-size: 25px;margin-top: 50px;">支付成功</div>
<div>
	<img alt="" src="${requestScope.qrcodeUrl }">
</div>
<div style="width: 90%;margin: 30px auto 0;">持此码到店消费，到店后请打开：我的-我的分享单-待消费-查看详情路径找到二维码</div>
</body>
</html>