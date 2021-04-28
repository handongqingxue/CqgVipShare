<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
<%@include file="../../../background/js.jsp"%>
<title>Insert title here</title>
<style type="text/css">
.status_div{
	font-size: 16px;text-align: center;margin: 100px auto 0;
}
.message_div{
	font-size: 16px;text-align: center;margin: 30px auto 0;
}
.finishBut_div{
	width: 200px;height:30px;line-height:30px;margin: 50px auto 0;color:#fff;text-align:center;background-color: #00A3FF;border-radius:4px;
}
</style>
</head>
<body>
<div class="status_div">
<c:choose>
<c:when test="${requestScope.status eq 'ok' }">绑定成功</c:when>
<c:otherwise>绑定失败</c:otherwise>
</c:choose>
</div>
<div class="message_div">${requestScope.message }</div>
<div class="finishBut_div" onclick="WeixinJSBridge.call('closeWindow')">完成</div>
</body>
</html>