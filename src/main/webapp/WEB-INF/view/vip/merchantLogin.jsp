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
<link rel="stylesheet" href="<%=basePath %>resource/css/vip/merchantLogin.css"/>
<script type="text/javascript" src="<%=basePath %>resource/js/jquery-3.3.1.js"></script>
<script type="text/javascript">
var path='<%=basePath %>';
var openId='${param.openId}';

function merchantLogin(){
	var userName=$("#userName").val();
	var password=$("#password").val();
	
	$.post("merchantLogin",
		{openId:openId,userName:userName,password:password},
		function(data){
			if(data.status==1){
				alert(data.msg);
				location.href=path+"vip/toMerchantInfo?openId="+openId;
			}
			else{
				alert(data.msg);
			}
		}
	,"json");
}

function checkInfo(){
	if(checkUserName()){
		if(checkPassword()){
			merchantLogin();
		}
	}
}

function focusUserName(){
	var userName = $("#userName").val();
	if(userName=="用户名不能为空"){
		$("#userName").val("");
		$("#userName").css("color", "#555555");
	}
}

//验证用户名
function checkUserName(){
	var userName = $("#userName").val();
	if(userName==null||userName==""||userName=="用户名不能为空"){
		$("#userName").css("color","#E15748");
    	$("#userName").val("用户名不能为空");
    	return false;
	}
	else
		return true;
}

//验证密码
function checkPassword(){
	var password = $("#password").val();
	if(password==null||password==""){
    	alert("密码不能为空");
    	return false;
	}
	else
		return true;
}
</script>
<title>商家登录</title>
</head>
<body>
<div class="top_div">
	<span class="sjdl_span">商家登录</span>
</div>
<div class="back_div">
	<span class="back_span" onclick="goBack()">&lt;返回</span>
</div>
<div class="mlTab_div">
	<table class="ml_tab" cellspacing="0">
		<tr>
			<td class="tit_td">用户名</td>
			<td>
				<input type="text" class="userName_inp" id="userName" onfocus="focusUserName()" onblur="checkUserName()"/>
			</td>
		</tr>
		<tr>
			<td class="tit_td">密码</td>
			<td>
				<input type="password" class="password_inp" id="password" onblur="checkPassword()"/>
			</td>
		</tr>
	</table>
</div>
<div class="login_div" onclick="checkInfo()">
	登录
</div>
</body>
</html>