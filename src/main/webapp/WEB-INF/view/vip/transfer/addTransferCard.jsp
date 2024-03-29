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
<link rel="stylesheet" href="<%=basePath %>resource/css/vip/transfer/addTransferCard.css"/>
<script type="text/javascript" src="<%=basePath %>resource/js/jquery-3.3.1.js"></script>
<script type="text/javascript">
var path='<%=basePath %>';
var openId='${param.openId}';
var tradeId='${requestScope.pageValue.tradeId}';
var tradeName='${requestScope.pageValue.tradeName}';
var shopId='${requestScope.pageValue.shopId}';
var shopName='${requestScope.pageValue.shopName}';
var shopAddress='${requestScope.pageValue.shopAddress}';
var logo='${requestScope.pageValue.logo}';
var from='${requestScope.pageValue.from}';
var prePage='${requestScope.pageValue.prePage}';
var action='${requestScope.pageValue.action}';
$(function(){
	initMerCardType();
});

function initMerCardType(){
	$.post("selectMerCardType",
		{shopId:shopId},
		function(result){
			var typeSel=$("#type");
			typeSel.empty();
			typeSel.append("<option value=\"\">请选择卡类型</option>");
			if(result.message=="ok"){
				var mctList=result.data;
				for(var i=0;i<mctList.length;i++){
					var mct=mctList[i];
					typeSel.append("<option value=\""+mct.type+"\">"+mct.name+"</option>");
				}
			}
		}
	,"json");
}

function addTransferCard(){
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
	$.post("addTransferCard",
		{no:no,name:name,type:type,shopId:shopId,openId:openId,consumeCount:consumeCount,shareMoney:shareMoney,discount:discount,describe:describe},
		function(data){
			if(data.status=="ok"){
				alert(data.message);
				location.href=path+"vip/goPage?page=transferTcl&openId="+openId;
			}
			else{
				alert(data.message);
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
						addTransferCard();
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
	if(type=="5"){
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
	else{
		shareMoney=$("#zje").val();
		if(shareMoney==null||shareMoney==""){
		  	alert("总金额不能为空");
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

function changeDivByType(){
	var type=$("#type").val();
	switch (type) {
	case "1":
	case "2":
	case "3":
	case "4":
		$("#dcje_div").css("display","none");
		$("#syxfcs_div").css("display","none");
		$("#zje_div").css("display","block");
		break;
	case "5":
		$("#dcje_div").css("display","block");
		$("#syxfcs_div").css("display","block");
		$("#zje_div").css("display","none");
		break;
	default:
		$("#dcje_div").css("display","none");
		$("#syxfcs_div").css("display","none");
		$("#zje_div").css("display","none");
		break;
	}
}

function updatePageValue(postParams,urlParams){
	$.post("updatePageValue",
		postParams,
		function(data){
			if(data.status=="ok")
				location.href=path+"vip/goPage?openId="+openId+urlParams;
		}
	,"json");
}

function goBack(){
	var postParams,urlParams;
	if(prePage=="tradeList"){
		postParams={prePage:"mineTransferCard",openId:openId};
		urlParams="&page=tradeList";
	}
	else if(prePage=="shopList"){
		postParams={prePage:"tradeList",openId:openId};
		urlParams="&page=shopList";
	}
	updatePageValue(postParams,urlParams);
}
</script>
<title>发布转让卡信息</title>
</head>
<body>
<div class="top_div">
	<span>发布转让卡信息</span>
</div>
<div class="back_div">
	<span class="back_span" onclick="goBack()">&lt;返回</span>
</div>
<img class="logo_img" alt="" src="${requestScope.pageValue.logo}">
<div class="shopName_div">${requestScope.pageValue.shopName}</div>
<div class="shopAddress_div">
	地址：${requestScope.pageValue.shopAddress}
</div>
<div class="atc_div">
	<div class="attr_div">
		<div class="tit_div">卡号</div>
		<div class="attr_inp_div">
			<input type="text" class="attr_inp" id="no" placeholder="请输入卡号" onfocus="focusNo()" onblur="checkNo()"/>
			<span class="biTian_span">*</span>
		</div>
	</div>
	<div class="attr_div">
		<div class="tit_div">卡名</div>
		<div class="attr_inp_div">
			<input type="text" class="attr_inp" id="name" placeholder="请输入卡名" onfocus="focusName()" onblur="checkName()"/>
			<span class="biTian_span">*</span>
		</div>
	</div>
	<div class="attr_div">
		<div class="tit_div">卡类型</div>
		<div class="attr_inp_div">
			<select class="attr_sel" id="type" onchange="changeDivByType()">
			</select>
			<span class="biTian_span">*</span>
		</div>
	</div>
	<div class="attr_div dcje_div" id="dcje_div">
		<div class="tit_div">单次金额</div>
		<div class="attr_inp_div">
			<input type="number" class="attr_inp" id="dcje" placeholder="请输入单次金额"/>
			<span class="biTian_span">*</span>
		</div>
	</div>
	<div class="attr_div syxfcs_div" id="syxfcs_div">
		<div class="tit_div">剩余消费次数</div>
		<div class="attr_inp_div">
			<input type="number" class="attr_inp" id="consumeCount" placeholder="请输入剩余消费次数"/>
			<span class="biTian_span">*</span>
		</div>
	</div>
	<div class="attr_div zje_div" id="zje_div">
		<div class="tit_div">总金额</div>
		<div class="attr_inp_div">
			<input type="number" class="attr_inp" id="zje" placeholder="请输入总金额"/>
			<span class="biTian_span">*</span>
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
			<span class="biTian_span">*</span>
		</div>
	</div>
</div>
<div class="add_div" onclick="checkInfo()">
	发布
</div>
</body>
</html>