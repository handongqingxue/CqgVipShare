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
<link rel="stylesheet" href="<%=basePath %>resource/css/vip/bindAlipay.css"/>
<script type="text/javascript" src="<%=basePath %>resource/js/jquery-3.3.1.js"></script>
<script type="text/javascript">
var path='<%=basePath %>';
var openId='${param.openId}';
function bindAlipay(){
	var alipayNo=$("#alipayNo").val();
	var realName=$("#realName").val();
	$.post("bindAlipay",
		{alipayNo:alipayNo,realName:realName,openId:openId},
		function(data){
			location.href=path+"vip/toMine?openId="+openId;
			/*
			if(data.status==1){
				alert(data.msg);
				location.href=path+"vip/toMine?openId="+openId;
			}
			else{
				alert(data.msg);
			}
			*/
		}
	,"json");
}

function goBack(){
	location.href=path+"vip/toAlipay?openId="+openId;
}
</script>
<title>Insert title here</title>
</head>
<body style="margin: 0px;">
<div class="top_div">
	<span>绑定支付宝</span>
</div>
<div class="back_div">
	<span class="back_span" onclick="goBack()">&lt;返回</span>
</div>
<input type="hidden" id="openId" name="openId" value="${param.openId }"/>
<table style="margin-top: 10px;">
	<tr height="30">
		<td style="width:45%;padding-left: 10px;">支付宝账户</td>
		<td>
			<input type="text" id="alipayNo" name="alipayNo" value="${requestScope.vip.alipayNo }" style="width: 188px;"/>
		</td>
	</tr>
	<tr height="30">
		<td style="width:45%;padding-left: 10px;">真实姓名</td>
		<td>
			<input type="text" id="realName" name="realName" value="${requestScope.vip.realName }" style="width: 188px;"/>
		</td>
	</tr>
</table>
<div onclick="bindAlipay()" style="width:95%;height:40px;line-height:40px;margin:0 auto; margin-top: 10px;text-align:center;color:#fff;background-color: #f00;border-radius:5px;">
	提交
</div>
</body>
</html>