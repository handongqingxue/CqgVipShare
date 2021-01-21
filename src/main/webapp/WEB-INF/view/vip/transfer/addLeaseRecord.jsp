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
<link rel="stylesheet" href="<%=basePath %>resource/css/vip/transfer/addLeaseRecord.css"/>
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
				location.href=path+"vip/goPage?page=mineShareList&openId="+zlzOpenId;
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

function goBack(){
	location.href=path+"vip/goPage?page=transferLease&id="+id+"&openId="+zlzOpenId;
}
</script>
</head>
<body>
<div class="top_div">
	<span class="back_span" onclick="goBack()">&lt;返回</span>
	<span class="topTit_span">租赁会员</span>
</div>
<table class="addLR_tab">
	<tr>
		<td class="tit_td">手机号</td>
		<td>
			<input type="text" class="phone_inp" id="phone" onfocus="focusPhone()" onblur="checkPhone()"/>
		</td>
	</tr>
</table>
<div class="confirm_div" onclick="checkInfo()">
	确认租赁
</div>
</body>
</html>