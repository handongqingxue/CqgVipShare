<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
<%@include file="../admin/js.jsp"%>
<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
<link rel="stylesheet" href="<%=basePath %>resource/css/vip/addShareRecord.css"/>
<script type="text/javascript">
var path='<%=basePath %>';
var id='${param.id}';
var kzOpenId='${param.kzOpenId}';
var fxzOpenId='${param.fxzOpenId}';
$(function(){
	ygxfDB=$("#ygxfDate").datebox({
		height:30,
		editable:false
	});
});

function pay(){
	var phone=$("#phone").val();
	var ygxfDate=ygxfDB.datebox("getValue");
	var vipId='${param.vipId}';
	var shareMoney='${param.shareMoney}';
	$.post("addShareRecord",
		{kzOpenId:kzOpenId,fxzOpenId:fxzOpenId,phone:phone,ygxfDate:ygxfDate,vipId:vipId,shareMoney:shareMoney},
		function(data){
			if(data.status=="ok")
				$("#qrcodeUrl").attr("src",data.qrcodeUrl);
			else
				alert(data.message);
		}
	,"json");
}

function checkInfo(){
	if(checkPhone()){
		if(checkYgxfDate()){
			pay();
		}
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

//验证预估消费日期
function checkYgxfDate(){
	var ygxfDate=ygxfDB.datebox("getValue");
	if(ygxfDate==null||ygxfDate==""||ygxfDate=="预估消费日期不能为空"){
    	alert("预估消费日期不能为空");
    	return false;
	}
	else
		return true;
}

function goBack(){
	location.href=path+"vip/toShare?id="+id+"&openId="+fxzOpenId;
}
</script>
</head>
<body>
<div class="top_div">
	<span class="back_span" onclick="goBack()">&lt;返回</span>
	<span class="topTit_span">分享会员</span>
</div>
<table class="addSR_tab">
	<tr>
		<td class="tit_td">手机号</td>
		<td>
			<input type="text" class="phone_inp" id="phone" onfocus="focusPhone()" onblur="checkPhone()"/>
		</td>
	</tr>
	<tr>
		<td class="tit_td">预估消费日期</td>
		<td>
			<input type="text" class="ygxfDate_inp" id="ygxfDate"/>
		</td>
	</tr>
</table>
<div class="pay_div" onclick="checkInfo()">
	支付
</div>
<div>
	<img id="qrcodeUrl" alt="" />
</div>
</body>
</html>