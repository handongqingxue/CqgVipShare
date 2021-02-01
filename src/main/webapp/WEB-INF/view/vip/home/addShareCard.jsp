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
<link rel="stylesheet" href="<%=basePath %>resource/css/vip/home/addShareCard.css"/>
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
var from='${param.from}';
var prePage='${param.prePage}';
$(function(){
	
});

function addShareCard(){
	var no=$("#no").val();
	var name=$("#name").val();
	var type=$("#type").val();
	var consumeCount=null;
	var shareMoney=null;
	if(type=="1"){
		shareMoney=$("#zje").val();
	}
	else{
		consumeCount=$("#consumeCount").val();
		shareMoney=$("#dcje").val();
	}
	var discount=$("#discount").val();
	var describe=$("#describe").val();
	var phone=$("#phone").val();
	
	$.post("addShareCard",
		{shopId:shopId,openId:openId,no:no,name:name,type:type,consumeCount:consumeCount,discount:discount,describe:describe,shareMoney:shareMoney,phone:phone},
		function(data){
			if(data.status==1){
				alert(data.msg);
				location.href=path+"vip/goPage?page=homeScl&tradeId="+tradeId+"&tradeName="+encodeURI(tradeName)+"&openId="+openId;
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
			if(checkType()){
				if(checkShareMoney()){
					if(checkDescribe()){
						if(checkPhone()){
							addShareCard();
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

//验证卡类型
function checkType(){
	var type = $("#type").val();
	if(type==null||type==""){
  	alert("请选择卡类型");
  	return false;
	}
	else
		return true;
}

//验证单次金额
function checkShareMoney(){
	var flag;
	var type=$("#type").val();
	var consumeCount=null;
	var shareMoney=null;
	if(type=="1"){
		shareMoney=$("#zje").val();
		if(shareMoney==null||shareMoney==""){
		  	alert("总金额不能为空");
		  	flag=false;
		}
		else
			flag=true;
	}
	else{
		shareMoney=$("#dcje").val();
		consumeCount=$("#consumeCount").val();
		if(shareMoney==null||shareMoney==""){
		  	alert("单次金额不能为空");
		  	flag=false;
		}
		else if(consumeCount==null||consumeCount==""){
			alert("剩余消费次数不能为空");
			flag=false;
		}
		else
			flag=true;
	}
	return flag;
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

function changeDivByType(){
	var type=$("#type").val();
	if(type=="1"){
		$("#dcje_div").css("display","none");
		$("#syxfcs_div").css("display","none");
		$("#zje_div").css("display","block");
	}
	else if(type=="2"){
		$("#dcje_div").css("display","block");
		$("#syxfcs_div").css("display","block");
		$("#zje_div").css("display","none");
	}
	else{
		$("#dcje_div").css("display","none");
		$("#syxfcs_div").css("display","none");
		$("#zje_div").css("display","none");
	}
}

function goBack(){
	location.href=path+"vip/goPage?page=shopList&tradeId="+tradeId+"&tradeName="+encodeURI(tradeName)+"&from="+from+"&prePage="+prePage+"&openId="+openId;
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
<div class="asc_div">
	<div class="attr_div">
		<div class="tit_div">卡号</div>
		<div class="attr_inp_div">
			<input type="text" class="attr_inp" id="no" placeholder="请输入卡号" onfocus="focusNo()" onblur="checkNo()"/>
		</div>
	</div>
	<div class="attr_div">
		<div class="tit_div">卡名</div>
		<div class="attr_inp_div">
			<input type="text" class="attr_inp" id="name" placeholder="请输入卡名" onfocus="focusName()" onblur="checkName()"/>
		</div>
	</div>
	<div class="attr_div">
		<div class="tit_div">卡类型</div>
		<div class="attr_inp_div">
			<select class="attr_sel" id="type" onchange="changeDivByType()">
				<option value="">请选择卡类型</option>
				<option value="1">金额卡</option>
				<option value="2">次卡</option>
			</select>
		</div>
	</div>
	<div class="attr_div dcje_div" id="dcje_div">
		<div class="tit_div">单次金额</div>
		<div class="attr_inp_div">
			<input type="number" class="attr_inp" id="dcje" placeholder="请输入单次金额"/>
		</div>
	</div>
	<div class="attr_div syxfcs_div" id="syxfcs_div">
		<div class="tit_div">剩余消费次数</div>
		<div class="attr_inp_div">
			<input type="number" class="attr_inp" id="consumeCount" placeholder="请输入剩余消费次数"/>
		</div>
	</div>
	<div class="attr_div zje_div" id="zje_div">
		<div class="tit_div">总金额</div>
		<div class="attr_inp_div">
			<input type="number" class="attr_inp" id="zje" placeholder="请输入总金额"/>
		</div>
	</div>
	<div class="attr_div">
		<div class="tit_div">折扣(%)</div>
		<div class="attr_inp_div">
			<input type="number" class="attr_inp disc_inp" id="discount" placeholder="请输入折扣"/>
		</div>
	</div>
	<div class="attr_div">
		<div class="tit_div">会员服务描述</div>
		<div class="attr_inp_div">
			<input type="text" class="attr_inp" id="describe" placeholder="请输入会员服务描述" onfocus="focusDescribe()" onblur="checkDescribe()"/>
		</div>
	</div>
	<div class="attr_div">
		<div class="tit_div">卡主手机号</div>
		<div class="attr_inp_div">
			<input type="text" class="attr_inp" id="phone" placeholder="请输入手机号" onfocus="focusPhone()" onblur="checkPhone()"/>
		</div>
	</div>
</div>
<div class="submit_div" onclick="checkInfo()">
	提交
</div>
</body>
</html>