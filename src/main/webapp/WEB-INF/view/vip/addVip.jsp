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
var tradeId='${param.tradeId}';
var tradeName='${param.tradeName}';
var shopId='${param.shopId}';
var shopName='${param.shopName}';
var shopAddress='${param.shopAddress}';
var logo='${param.logo}';
$(function(){
	
});

function addShareVip(){
	var no=$("#no").val();
	var name=$("#name").val();
	var consumeCount=$("#consumeCount").val();
	var describe=$("#describe").val();
	var shareMoney=$("#shareMoney").val();
	var phone=$("#phone").val();
	
	$.post("addShareVip",
		{shopId:shopId,openId:openId,no:no,name:name,consumeCount:consumeCount,describe:describe,shareMoney:shareMoney,phone:phone},
		function(data){
			if(data.status==1){
				alert(data.msg);
				location.href=path+"vip/toVipList?tradeId="+tradeId+"&tradeName="+encodeURI(tradeName)+"&openId="+openId;
			}
			else{
				alert(data.msg);
			}
		}
	,"json");
}

function checkInfo(){
	if(checkNo()){
		if(checkName()){
			if(checkConsumeCount()){
				if(checkDescribe()){
					if(checkShareMoney()){
						if(checkPhone()){
							addShareVip();
						}
					}
				}
			}
		}
	}
}

function focusNo(){
	var no = $("#no").val();
	if(no=="卡号不能为空"){
		$("#no").val("");
		$("#no").css("color", "#555555");
	}
}

//验证卡号
function checkNo(){
	var no = $("#no").val();
	if(no==null||no==""||no=="卡号不能为空"){
		$("#no").css("color","#E15748");
    	$("#no").val("卡号不能为空");
    	return false;
	}
	else
		return true;
}

function focusName(){
	var name = $("#name").val();
	if(name=="卡名不能为空"){
		$("#name").val("");
		$("#name").css("color", "#555555");
	}
}

//验证卡名
function checkName(){
	var name = $("#name").val();
	if(name==null||name==""||name=="卡名不能为空"){
		$("#name").css("color","#E15748");
    	$("#name").val("卡名不能为空");
    	return false;
	}
	else
		return true;
}

//验证剩余消费次数
function checkConsumeCount(){
	var consumeCount = $("#consumeCount").val();
	if(consumeCount==null||consumeCount==""||consumeCount=="剩余消费次数不能为空"){
    	alert("剩余消费次数不能为空");
    	return false;
	}
	else
		return true;
}

function focusDescribe(){
	var describe = $("#describe").val();
	if(describe=="会员服务描述不能为空"){
		$("#describe").val("");
		$("#describe").css("color", "#555555");
	}
}

//验证会员服务描述
function checkDescribe(){
	var describe = $("#describe").val();
	if(describe==null||describe==""||describe=="会员服务描述不能为空"){
		$("#describe").css("color","#E15748");
    	$("#describe").val("会员服务描述不能为空");
    	return false;
	}
	else
		return true;
}

//验证单次金额
function checkShareMoney(){
	var shareMoney = $("#shareMoney").val();
	if(shareMoney==null||shareMoney==""||shareMoney=="单次金额不能为空"){
	  	alert("单次金额不能为空");
	  	return false;
	}
	else
		return true;
}

function focusPhone(){
	var phone = $("#phone").val();
	if(phone=="卡主手机号不能为空"){
		$("#phone").val("");
		$("#phone").css("color", "#555555");
	}
}

//验证卡主手机号
function checkPhone(){
	var phone = $("#phone").val();
	if(phone==null||phone==""||phone=="卡主手机号不能为空"){
		$("#phone").css("color","#E15748");
    	$("#phone").val("卡主手机号不能为空");
    	return false;
	}
	else
		return true;
}

function goBack(){
	location.href=path+"vip/toShopList?tradeId="+tradeId+"&tradeName="+encodeURI(tradeName)+"&openId="+openId;
}
</script>
<title>发布</title>
<style type="text/css">
.addVip_tab{
	width:95%;margin: 0 auto;margin-top: 10px;
}
.addVip_tab tr{
	height:50px;
}
.addVip_tab tr td{
	border-bottom: #999 solid 1px;
}
.addVip_tab tr .tit_td{
	width:35%;padding-left: 10px;
}
</style>
</head>
<body style="margin: 0px;">
<div style="width: 100%;height: 40px;line-height: 40px;color:#fff;background-color: #EC4149;">
	<span style="margin-left: 10px;" onclick="goBack()">&lt;返回</span>
	<span style="margin-left: 50px;">发布${param.tradeName }会员</span>
</div>
<img alt="" src="${param.logo}" style="width: 100%;height: 200px;">
<table class="addVip_tab" cellspacing="0">
	<tr>
		<td class="tit_td">实体店地址</td>
		<td>
			<span>${param.shopAddress}</span>
		</td>
	</tr>
	<tr>
		<td class="tit_td">卡号</td>
		<td>
			<input type="text" id="no" placeholder="请输入卡号" style="width: 222px;" onfocus="focusNo()" onblur="checkNo()"/>
		</td>
	</tr>
	<tr>
		<td class="tit_td">卡名</td>
		<td>
			<input type="text" id="name" placeholder="请输入卡名" style="width: 222px;" onfocus="focusName()" onblur="checkName()"/>
		</td>
	</tr>
	<tr>
		<td class="tit_td">剩余消费次数</td>
		<td>
			<input type="number" id="consumeCount" placeholder="请输入剩余消费次数" style="width: 222px;"/>
		</td>
	</tr>
	<tr>
		<td class="tit_td">会员服务描述</td>
		<td>
			<input type="text" id="describe" placeholder="请输入会员服务描述" style="width: 222px;" onfocus="focusDescribe()" onblur="checkDescribe()"/>
		</td>
	</tr>
	<tr>
		<td class="tit_td">单次金额</td>
		<td>
			<input type="number" id="shareMoney" placeholder="请输入单次金额" style="width: 222px;"/>
		</td>
	</tr>
	<tr>
		<td class="tit_td">卡主手机号</td>
		<td>
			<input type="text" id="phone" placeholder="请输入卡主手机号" style="width: 222px;" onfocus="focusPhone()" onblur="checkPhone()"/>
		</td>
	</tr>
</table>
<div onclick="checkInfo()" style="width:95%;height:40px;line-height:40px;margin:0 auto; margin-top: 10px;text-align:center;color:#fff;background-color: #f00;border-radius:5px;">
	提交
</div>
</body>
</html>