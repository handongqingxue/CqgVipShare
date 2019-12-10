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
<script type="text/javascript" src="<%=basePath %>resource/js/jquery-3.3.1.js"></script>
<script type="text/javascript">
function pay(){
	$.post("addShareRecord",
		{},
		function(){
		
		}
	,"json");
}
</script>
<title>Insert title here</title>
</head>
<body>
<div>
	<input type="text" id="phone"/>
</div>
<div>
	<input type="text" id="ygxfDate"/>
</div>
<div>
	<input type="button" value="支付" onclick="pay()"/>
</div>
</body>
</html>