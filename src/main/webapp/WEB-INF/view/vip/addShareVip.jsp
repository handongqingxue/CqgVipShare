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
<link rel="stylesheet" href="<%=basePath %>resource/css/vip/addShareVip.css"/>
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
var prePage='${param.prePage}';
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
				location.href=path+"vip/goPage?page=homeVipList&tradeId="+tradeId+"&tradeName="+encodeURI(tradeName)+"&openId="+openId;
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
	location.href=path+"vip/goPage?page=homeShopList&tradeId="+tradeId+"&tradeName="+encodeURI(tradeName)+"&prePage="+prePage+"&openId="+openId;
}
</script>
<title>发布</title>
</head>
<body>
<div class="top_div">
	<span>发布${param.tradeName }会员</span>
</div>
<div class="back_div">
	<span class="back_span" onclick="goBack()">&lt;返回</span>
</div>
<img class="logo_img" alt="" src="${param.logo}">
<div class="shopName_div">${param.shopName}</div>
<div class="shopAddress_div">
	<span class="shopAddress_span">地址：${param.shopAddress}</span>
</div>
<div class="asv_div">
	<div class="no_div">
		<div class="tit_div">卡号</div>
		<div class="no_inp_div">
			<input type="text" class="no_inp" id="no" placeholder="请输入卡号" onfocus="focusNo()" onblur="checkNo()"/>
		</div>
	</div>
	<div class="name_div">
		<div class="tit_div">卡名</div>
		<div class="name_inp_div">
			<input type="text" class="name_inp" id="name" placeholder="请输入卡名" onfocus="focusName()" onblur="checkName()"/>
		</div>
	</div>
	<div class="consumeCount_div">
		<div class="tit_div">剩余消费次数</div>
		<div class="cc_inp_div">
			<input type="number" class="consumeCount_inp" id="consumeCount" placeholder="请输入剩余消费次数"/>
		</div>
	</div>
	<div class="describe_div">
		<div class="tit_div">会员服务描述</div>
		<div class="describe_inp_div">
			<input type="text" class="describe_inp" id="describe" placeholder="请输入会员服务描述" onfocus="focusDescribe()" onblur="checkDescribe()"/>
		</div>
	</div>
	<div class="shareMoney_div">
		<div class="tit_div">单次金额</div>
		<div class="sm_inp_div">
			<input type="number" class="shareMoney_inp" id="shareMoney" placeholder="请输入单次金额"/>
		</div>
	</div>
	<div class="phone_div">
		<div class="tit_div">卡主手机号</div>
		<div class="phone_inp_div">
			<input type="text" class="phone_inp" id="phone" placeholder="请输入手机号" onfocus="focusPhone()" onblur="checkPhone()"/>
		</div>
	</div>
</div>
<div class="submit_div" onclick="checkInfo()">
	提交
</div>
</body>
</html>