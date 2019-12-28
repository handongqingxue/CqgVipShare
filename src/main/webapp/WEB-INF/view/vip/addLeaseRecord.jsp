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
<title>Insert title here</title>
<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
<script type="text/javascript" src="<%=basePath %>resource/js/jquery-3.3.1.js"></script>
<script type="text/javascript">
var path='<%=basePath %>';
var id='${param.id}';
var kzOpenId='${param.kzOpenId}';
var zlzOpenId='${param.zlzOpenId}';

function addLeaseRecord(){
	var phone=$("#phone").val();
	var vipId='${param.vipId}';
	var shareMoney='${param.shareMoney}';
	$.post("addLeaseRecord",
		{kzOpenId:kzOpenId,zlzOpenId:zlzOpenId,phone:phone,vipId:vipId,shareMoney:shareMoney},
		function(data){
			if(data.status=="ok"){
				alert(data.message);
				location.href=path+"vip/toShareList?openId="+zlzOpenId;
			}
			else
				alert(data.message);
		}
	,"json");
}

function checkInfo(){
	if(checkPhone()){
		addLeaseRecord();
	}
}

function focusPhone(){
	var phone = $("#phone").val();
	if(phone=="手机号不能为空"){
		$("#phone").val("");
		$("#phone").css("color", "#555555");
	}
}

//验证手机号
function checkPhone(){
	var phone = $("#phone").val();
	if(phone==null||phone==""||phone=="手机号不能为空"){
		$("#phone").css("color","#E15748");
    	$("#phone").val("手机号不能为空");
    	return false;
	}
	else
		return true;
}
</script>
<style type="text/css">
.addLR_tab{
	width:95%;margin: 0 auto;margin-top: 10px;
}
.addLR_tab tr{
	height:65px;
}
.addLR_tab tr td{
/*
	border-bottom: #999 solid 1px;
	*/
}
.addLR_tab tr .tit_td{
	width:35%;padding-left: 10px;
}
.phone_inp{
	width: 200px;
	height: 25px;
    line-height: 25px;
    font-size: 18px;
}
</style>
</head>
<body style="margin: 0px;">
<div style="width: 100%;height: 40px;line-height: 40px;color:#fff;background-color: #EC4149;">
	<span style="margin-left: 10px;" onclick="goBack()">&lt;返回</span>
	<span style="margin-left: 50px;">租赁会员</span>
</div>
<table class="addLR_tab">
	<tr>
		<td class="tit_td">手机号</td>
		<td>
			<input type="text" class="phone_inp" id="phone" onfocus="focusPhone()" onblur="checkPhone()"/>
		</td>
	</tr>
</table>
<div onclick="checkInfo()" style="width:95%;height:40px;line-height:40px;margin:0 auto; margin-top: 35px;text-align:center;color:#fff;background-color: #f00;border-radius:5px;">
	确认租赁
</div>
</body>
</html>