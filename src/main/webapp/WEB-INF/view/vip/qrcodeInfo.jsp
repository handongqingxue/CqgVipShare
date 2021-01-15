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
				WeixinJSBridge.call('closeWindow');
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
<body style="margin: 0px;background-color: #F6F6F6;">
<div style="margin-top: 10px;font-size: 20px;background-color: #fff;">
	<div style="height:40px;line-height:40px;">
		卡主手机号：${requestScope.phone }
	</div>
	<div style="height:40px;line-height:40px;">
		预估消费日期：${requestScope.ygxfDate }
	</div>
	<div style="height:40px;line-height:40px;">
		卡主昵称：${requestScope.nickName }
	</div>
</div>
<div onclick="confirmConsume()" style="width:95%;height:50px;line-height:50px;margin:0 auto; margin-top: 10px;text-align:center;color:#fff; font-size: 20px;background-color: #f00;border-radius:5px;">
	确认消费
</div>
</body>
</html>