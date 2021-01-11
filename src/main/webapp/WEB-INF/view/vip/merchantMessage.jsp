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
var path='<%=basePath%>';
var openId='${param.openId}';
$(function(){
	selectList();	
});

function selectList(){
	$.post("selectMerchantMessageList",
		{openId:openId},
		function(result){
			if(result.message=="ok"){
			   alert(result.data.length);
			}
			else{
			   alert(result.message);
			}
		}
	,"json");
}
</script>
<title>消息中心</title>
</head>
<body>

</body>
</html>