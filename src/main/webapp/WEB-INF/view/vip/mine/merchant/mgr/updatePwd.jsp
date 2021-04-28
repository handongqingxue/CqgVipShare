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
<link rel="stylesheet" href="<%=basePath %>resource/css/vip/mine/merchant/mgr/updatePwd.css"/>
<script type="text/javascript" src="<%=basePath %>resource/js/jquery-3.3.1.js"></script>
<script type="text/javascript" src="<%=basePath %>resource/js/MD5.js"></script>
<script type="text/javascript">
var path='<%=basePath%>';
var vipPath=path+"vip/";
var openId='${param.openId}';
var merchantId='${sessionScope.merchant.id}';

function checkEditPwd(){
	if(checkPassword()){
		if(checkNewPwd()){
			if(checkNewPwd2()){
				var password = $("#newPwd").val();
				$.post(vipPath+"updateMerPwdById",
					{password:MD5(password).toUpperCase(),merchantId:merchantId},
					function(result){
						var json=JSON.parse(result);
						if(json.status==1){
						    if(confirm(json.msg)){
						    	location.href=path+"vip/merchantExit?openId="+openId;
						    }
						}
						else{
							alert(json.msg);
						}
					}
				);
			}
		}
	}
}

//验证原密码
function checkPassword(){
	var flag=false;
	var password = $("#password").val();
	if(password==null||password==""){
		alert("原密码不能为空");
		flag=false;
	}
	else{
		$.ajaxSetup({async:false});
		$.post(vipPath+"checkMerPassword",
			{password:MD5(password).toUpperCase(),merchantId:merchantId},
			function(data){
				if(data.status=="ok"){
					flag=true;
				}
				else{
					alert(data.message);
					flag=false;
				}
			}
		,"json");
	}
	return flag;
}

//验证新密码
function checkNewPwd(){
	var password = $("#password").val();
	var newPwd = $("#newPwd").val();
	if(newPwd==null||newPwd==""){
	  	alert("新密码不能为空");
	  	return false;
	}
	if(newPwd==password){
		alert("新密码不能和原密码一致！");
		return false;
	}
	else
		return true;
}

//验证确认密码
function checkNewPwd2(){
	var newPwd = $("#newPwd").val();
	var newPwd2 = $("#newPwd2").val();
	if(newPwd2==null||newPwd2==""){
	  	alert("确认密码不能为空");
	  	return false;
	}
	else if(newPwd!=newPwd2){
		alert("两次密码不一致！");
		return false;
	}
	else
		return true;
}

function goBack(){
	location.href=path+"vip/goPage?page=mineMerInfo&openId="+openId;
}
</script>
<title>修改密码</title>
</head>
<body>
<div class="top_div">
	<span>修改密码</span>
</div>
<div class="back_div">
	<span class="back_span" onclick="goBack()">&lt;返回</span>
</div>
<div class="main_div" id="main_div">
	<div class="attr_div">
		<div class="key_div">原密码：</div>
		<input type="password" class="val_inp" id="password" placeholder="请输入原密码"/>
	</div>
	<div class="attr_div">
		<div class="key_div">新密码：</div>
		<input type="password" class="val_inp" id="newPwd" placeholder="请输入新密码"/>
	</div>
	<div class="attr_div">
		<div class="key_div">确认密码：</div>
		<input type="password" class="val_inp" id="newPwd2" placeholder="请输入确认密码"/>
	</div>
	<div class="confirmBut_div" onclick="checkEditPwd()">
		确定
	</div>
	<div class="warn_div">注意：密码修改后需要重新登录系统</div>
</div>
</body>
</html>