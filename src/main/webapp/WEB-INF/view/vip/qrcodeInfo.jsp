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
function confirmConsume(){
	var uuid='${param.uuid}'
	$.post("confirmConsumeShare",
		{uuid:uuid},
		function(data){
			if(data.status=="ok"){
				alert(data.message);
			}
			else{
				alert(data.message);
			}
		}
	,"json");
}
</script>
<title>Insert title here</title>
</head>
<body>
<div>
${requestScope.user.phone }
</div>
<div>
${requestScope.user.passWord }
</div>
<div>
${requestScope.user.nickName }
</div>
<div>
	<input type="button" value="确认消费" onclick="confirmConsume()"/>
</div>
</body>
</html>