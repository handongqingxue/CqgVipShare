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
<link rel="stylesheet" href="<%=basePath %>resource/css/vip/mine/merchant/card/merCard/edit.css"/>
<script type="text/javascript"
	src="<%=basePath %>resource/js/jquery-3.3.1.js"></script>
<script type="text/javascript">
var path='<%=basePath %>';
var vipPath='<%=basePath%>'+"vip/";
var openId='${param.openId}';
var shopId='${sessionScope.merchant.id }';
$(function(){
});

function checkEdit(){
	if(checkName()){
		if(checkConsumeCount()){
			if(checkMoney()){
				editMerCard();
			}
		}
	}
}

function editMerCard(){
	var id=$("#id").val();
	var name=$("#name").val();
	var consumeCount = $("#consumeCount").val();
	var money = $("#money").val();
	var discount = $("#discount").val();
	var describe = $("#describe").val();
	var gmxz = $("#gmxz").val();

	$.post(vipPath+"editMerCard",
		{id:id,name:name,shopId:shopId,consumeCount:consumeCount,money:money,discount:discount,describe:describe,gmxz:gmxz},
		function(data){
			if(data.message=="ok"){
				alert(data.info);
				history.go(-1);
			}
			else{
				alert(data.info);
			}
		}
	,"json");
}

function focusName(){
	var name = $("#name").val();
	if(name=="会员卡名称不能为空"){
		$("#name").val("");
		$("#name").css("color", "#555555");
	}
}

//验证会员卡名称
function checkName(){
	var name = $("#name").val();
	if(name==null||name==""||name=="会员卡名称不能为空"){
		$("#name").css("color","#E15748");
    	$("#name").val("会员卡名称不能为空");
    	return false;
	}
	else
		return true;
}

//验证使用次数
function checkConsumeCount(){
	var consumeCount = $("#consumeCount").val();
	if(consumeCount==null||consumeCount==""){
	  	alert("请输入使用次数");
	  	return false;
	}
	else
		return true;
}

//验证金额
function checkMoney(){
	var money = $("#money").val();
	if(money==null||money==""){
	  	alert("请输入金额");
	  	return false;
	}
	else
		return true;
}

function goBack(){
	location.href=path+"vip/goPage?page=mineMerCard&openId="+openId;
}
</script>
<title>编辑会员卡</title>
</head>
<body>
<div class="top_div">
	<span>编辑会员卡</span>
</div>
<div class="back_div">
	<span class="back_span" onclick="goBack()">&lt;返回</span>
</div>
<div class="main_div" id="main_div">
	<input type="hidden" id="id" value="${requestScope.merchantCard.id }" />
	<div class="attr_div">
		<div class="key_div">会员卡名称：</div>
		<input type="text" class="val_inp" id="name" name="name" value="${requestScope.merchantCard.name }" placeholder="请输入名称" onfocus="focusName()" onblur="checkName()"/>
	</div>
	<div class="attr_div">
		<div class="key_div">会员卡类型：</div>
		<div class="val_div">${requestScope.merchantCard.typeName }</div>
	</div>
	<div class="attr_div">
		<div class="key_div">使用次数：</div>
		<input type="number" class="val_inp" id="consumeCount" name="consumeCount" value="${requestScope.merchantCard.consumeCount }" placeholder="请输入使用次数"/>
	</div>
	<div class="attr_div">
		<div class="key_div">金额：</div>
		<input type="number" class="val_inp" id="money" name="money" value="${requestScope.merchantCard.money }" placeholder="请输入金额"/>
	</div>
	<div class="attr_div">
		<div class="key_div">折扣：</div>
		<input type="number" class="val_inp" id="discount" name="discount" value="${requestScope.merchantCard.discount }" placeholder="请输入折扣"/>
	</div>
	<div class="ms_div">
		<div class="key_div">描述：</div>
		<textarea class="ms_ta" id="describe" rows="6" cols="10">${requestScope.merchantCard.describe }</textarea>
	</div>
	<div class="gmxz_div">
		<div class="key_div">购买须知：</div>
		<textarea class="gmxz_ta" id="gmxz" rows="6" cols="10">${requestScope.merchantCard.gmxz }</textarea>
	</div>
	<div class="submitBut_div" onclick="checkEdit()">
		提交
	</div>
</div>
</body>
</html>