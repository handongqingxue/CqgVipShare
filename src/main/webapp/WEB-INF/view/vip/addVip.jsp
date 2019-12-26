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
var vipJOStr='${param.vipJOStr}';
$(function(){
	if(vipJOStr!=""){
		reloadVipInfo();
	}
});

function reloadVipInfo(){
	var vipJO=JSON.parse(vipJOStr);
	$("#shopId").val(vipJO.shopId);
	$("#shopName").text(vipJO.shopName);
	$("#shopAddress").text(vipJO.shopAddress);
	$("#no").val(vipJO.no);
	$("#consumeCount").val(vipJO.consumeCount);
	$("#describe").val(vipJO.describe);
	$("#shareMoney").val(vipJO.shareMoney);
	$("#phone").val(vipJO.phone);
}

function addShareVip(){
	var shopId=$("#shopId").val();
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

function goShopList(){
	var no=$("#no").val();
	var consumeCount=$("#consumeCount").val();
	var describe=$("#describe").val();
	var shareMoney=$("#shareMoney").val();
	var phone=$("#phone").val();
	var vipJOStr="{\"no\":\""+no+"\",\"consumeCount\":\""+consumeCount+"\",\"describe\":\""+describe+"\",\"shareMoney\":\""+shareMoney+"\",\"phone\":\""+phone+"\"}";
	location.href=path+"vip/toShopList?vipJOStr="+encodeURI(vipJOStr)+"&tradeId="+tradeId+"&tradeName="+encodeURI(tradeName)+"&openId="+openId;
}

function checkInfo(){
	if(checkShopName()){
		if(checkShopAddress()){
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
	}
}

//验证实体店名
function checkShopName(){
	var shopName = $("#shopName").text();
	if(shopName==null||shopName==""||shopName=="实体店名不能为空"){
  		alert("实体店名不能为空");
  		return false;
	}
	else
		return true;
}

//验证实体店地址
function checkShopAddress(){
	var shopAddress = $("#shopAddress").text();
	if(shopAddress==null||shopAddress==""||shopAddress=="实体店地址不能为空"){
  		alert("实体店地址不能为空");
  		return false;
	}
	else
		return true;
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
	location.href=path+"vip/toVipList?tradeId="+tradeId+"&tradeName="+tradeName+"&openId="+openId;
}
</script>
<title>发布</title>
</head>
<body style="margin: 0px;">
<div style="width: 100%;height: 40px;line-height: 40px;color:#fff;background-color: #EC4149;">
	<span style="margin-left: 10px;" onclick="goBack()">&lt;返回</span>
	<span style="margin-left: 50px;">发布${param.tradeName }会员</span>
</div>
<table style="margin-top: 10px;">
	<tr height="30">
		<td style="width:45%;padding-left: 10px;">实体店名</td>
		<td>
			<input type="hidden" id="shopId"/>
			<span id="shopName"></span>
			<div style="width: 80px;height:30px;line-height:30px;margin-top:-3px;float:right; text-align:center;color:#fff;background-color: #EC4149;border-radius:5px;" onclick="goShopList()">选择门店</div>
		</td>
	</tr>
	<tr height="30">
		<td style="padding-left: 10px;">实体店地址</td>
		<td>
			<span id="shopAddress"></span>
		</td>
	</tr>
	<tr height="30">
		<td style="padding-left: 10px;">卡号</td>
		<td>
			<input type="text" id="no" style="width: 188px;" onfocus="focusNo()" onblur="checkNo()"/>
		</td>
	</tr>
	<tr height="30">
		<td style="padding-left: 10px;">卡名</td>
		<td>
			<input type="text" id="name" style="width: 188px;" onfocus="focusName()" onblur="checkName()"/>
		</td>
	</tr>
	<tr height="30">
		<td style="padding-left: 10px;">剩余消费次数</td>
		<td>
			<input type="number" id="consumeCount" style="width: 188px;"/>
		</td>
	</tr>
	<tr height="30">
		<td style="padding-left: 10px;">会员服务描述</td>
		<td>
			<input type="text" id="describe" style="width: 188px;" onfocus="focusDescribe()" onblur="checkDescribe()"/>
		</td>
	</tr>
	<tr height="30">
		<td style="padding-left: 10px;">单次金额</td>
		<td>
			<input type="number" id="shareMoney" style="width: 188px;"/>
		</td>
	</tr>
	<tr height="30">
		<td style="padding-left: 10px;">卡主手机号</td>
		<td>
			<input type="text" id="phone" style="width: 188px;" onfocus="focusPhone()" onblur="checkPhone()"/>
		</td>
	</tr>
</table>
<div onclick="checkInfo()" style="width:95%;height:40px;line-height:40px;margin:0 auto; margin-top: 10px;text-align:center;color:#fff;background-color: #f00;border-radius:5px;">
	提交
</div>
</body>
</html>