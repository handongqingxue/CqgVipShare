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
var path='<%=basePath %>';
var openId='${param.openId}';
function addLeaseRelation(){
	var zkPhone=$("#zkPhone").val();
	$.post("addLeaseRelation",
		{zkOpenId:openId,zkPhone:zkPhone},
		function(data){
			if(data.status=="ok"){
				alert(data.message);
				location.href=path+"vip/toLeaseList?openId="+openId;
			}
			else{
				alert(data.message);
			}
		}
	,"json");
}

function checkInfo(){
	if(checkZkPhone()){
		addLeaseRelation();
	}
}

function focusZkPhone(){
	var zkPhone = $("#zkPhone").val();
	if(zkPhone=="联系方式不能为空"){
		$("#zkPhone").val("");
		$("#zkPhone").css("color", "#555555");
	}
}

//验证联系方式
function checkZkPhone(){
	var zkPhone = $("#zkPhone").val();
	if(zkPhone==null||zkPhone==""||zkPhone=="联系方式不能为空"){
		$("#zkPhone").css("color","#E15748");
    	$("#zkPhone").val("联系方式不能为空");
    	return false;
	}
	else
		return true;
}

function goBack(){
	location.href=path+"vip/toMine?openId="+openId;
}
</script>
<title>Insert title here</title>
<style type="text/css">
.addLR_tab{
	width:95%;margin: 0 auto;margin-top: 10px;
}
.addLR_tab tr{
	height:65px;
}
.addLR_tab tr td{
	border-bottom: #999 solid 1px;
}
.addLR_tab tr .tit_td{
	width:35%;padding-left: 10px;
}
.zkPhone_inp{
	width: 222px;
	height: 25px;
    line-height: 25px;
    font-size: 18px;
}
</style>
</head>
<body style="margin: 0px;">
<div style="width: 100%;height: 40px;line-height: 40px;color:#fff;background-color: #EC4149;">
	<span style="margin-left: 10px;" onclick="goBack()">&lt;返回</span>
	<span style="margin-left: 50px;">发布租赁卡信息</span>
</div>
<table class="addLR_tab" cellspacing="0">
	<tr>
		<td class="tit_td">联系方式</td>
		<td>
			<input type="text" class="zkPhone_inp" id="zkPhone" onfocus="focusZkPhone()" onblur="checkZkPhone()"/>
		</td>
	</tr>
</table>
<div onclick="checkInfo()" style="width:95%;height:40px;line-height:40px;margin:0 auto; margin-top: 35px;text-align:center;color:#fff;background-color: #f00;border-radius:5px;">
	发布
</div>
</body>
</html>