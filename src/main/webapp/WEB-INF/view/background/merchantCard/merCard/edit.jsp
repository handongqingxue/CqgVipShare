<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>编辑会员</title>
<%@include file="../../js.jsp"%>
<style type="text/css">
.center_con_div{
	width: 100%;
	height: 90vh;
	margin-left:205px;
	overflow-y: scroll;
	position: absolute;
}
.page_location_div{
	height: 50px;
	line-height: 50px;
	margin-left: 20px;
	font-size: 18px;
}
</style>
<script type="text/javascript">
var path='<%=basePath %>';
var merCardPath='<%=basePath%>'+"background/merchantCard/";
var shopId='${sessionScope.merchant.id }';
var dialogTop=10;
var dialogLeft=20;
var edNum=0;
$(function(){
	initEditDialog();

	initDialogPosition();//将不同窗体移动到主要内容区域
});

function initDialogPosition(){
	//基本属性组
	var edpw=$("body").find(".panel.window").eq(edNum);
	var edws=$("body").find(".window-shadow").eq(edNum);

	var ccDiv=$("#center_con_div");
	ccDiv.append(edpw);
	ccDiv.append(edws);
}

function initEditDialog(){
	dialogTop+=20;
	$("#edit_div").dialog({
		title:"会员卡信息",
		width:setFitWidthInParent("body","edit_div"),
		height:400,
		top:dialogTop,
		left:dialogLeft,
		buttons:[
           {text:"保存",id:"ok_but",iconCls:"icon-ok",handler:function(){
        	   checkEdit();
           }}
        ]
	});

	$("#edit_div table").css("width",(setFitWidthInParent("body","edit_div_table"))+"px");
	$("#edit_div table").css("magin","-100px");
	$("#edit_div table td").css("padding-left","50px");
	$("#edit_div table td").css("padding-right","20px");
	$("#edit_div table td").css("font-size","15px");
	$("#edit_div table tr").each(function(i){
		$(this).css("height",(i==3?150:45)+"px");
	});

	$(".panel.window").eq(edNum).css("margin-top","20px");
	$(".panel.window .panel-title").eq(edNum).css("color","#000");
	$(".panel.window .panel-title").eq(edNum).css("font-size","15px");
	$(".panel.window .panel-title").eq(edNum).css("padding-left","10px");
	
	$(".panel-header, .panel-body").css("border-color","#ddd");
	
	//以下的是表格下面的面板
	$(".window-shadow").eq(edNum).css("margin-top","20px");
	$(".window,.window .window-body").eq(edNum).css("border-color","#ddd");

	$("#edit_div #ok_but").css("left","45%");
	$("#edit_div #ok_but").css("position","absolute");
	
	$(".dialog-button").css("background-color","#fff");
	$(".dialog-button .l-btn-text").css("font-size","20px");
}

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

	$.post(merCardPath+"editMerCard",
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

function setFitWidthInParent(parent,self){
	var space=0;
	switch (self) {
	case "edit_div":
		space=340;
		break;
	case "edit_div_table":
	case "panel_window":
		space=355;
		break;
	}
	var width=$(parent).css("width");
	return width.substring(0,width.length-2)-space;
}
</script>
</head>
<body>
<div class="layui-layout layui-layout-admin">	
<%@include file="../../side.jsp"%>
<div class="center_con_div" id="center_con_div">
	<div class="page_location_div">编辑会员卡</div>
	
	<div id="edit_div">
		<input type="hidden" id="id" value="${requestScope.merchantCard.id }" />
		<table>
		  <tr style="border-bottom: #CAD9EA solid 1px;">
			<td align="right" style="width:15%;">
				会员卡名称
			</td>
			<td style="width:30%;">
				<input type="text" id="name" name="name" value="${requestScope.merchantCard.name }" placeholder="请输入会员卡名称" style="width: 150px;height:30px;" onfocus="focusName()" onblur="checkName()"/>
			</td>
			<td align="right" style="width:15%;">
				会员卡类型
			</td>
			<td style="width:30%;">
				<span>${requestScope.merchantCard.typeName }</span>
			</td>
		  </tr>
		  <tr style="border-bottom: #CAD9EA solid 1px;">
			<td align="right" style="width:15%;">
				使用次数
			</td>
			<td style="width:30%;">
				<input type="number" id="consumeCount" name="consumeCount" value="${requestScope.merchantCard.consumeCount }" placeholder="请输入使用次数" style="width: 150px;height:30px;"/>
			</td>
			<td align="right" style="width:15%;">
				金额
			</td>
			<td style="width:30%;">
				<input type="number" id="money" name="money" value="${requestScope.merchantCard.money }" placeholder="请输入金额" style="width: 150px;height:30px;"/>
			</td>
		  </tr>
		  <tr style="border-bottom: #CAD9EA solid 1px;">
			<td align="right" style="width:15%;">
				折扣
			</td>
			<td style="width:30%;">
				<input type="number" id="discount" name="discount" value="${requestScope.merchantCard.discount }" placeholder="请输入折扣" style="width: 150px;height:30px;"/>
			</td>
			<td align="right" style="width:15%;">
				
			</td>
			<td style="width:30%;">
				
			</td>
		  </tr>
		  <tr style="border-bottom: #CAD9EA solid 1px;">
			<td align="right" style="width:15%;">
				描述
			</td>
			<td style="width:30%;">
				<textarea rows="5" cols="20" id="describe" name="describe">${requestScope.merchantCard.describe }</textarea>
			</td>
			<td align="right" style="width:15%;">
				购买须知
			</td>
			<td style="width:30%;">
				<textarea rows="5" cols="20" id="gmxz" name="gmxz">${requestScope.merchantCard.gmxz }</textarea>
			</td>
		  </tr>
		</table>
	</div>
	<%@include file="../../foot.jsp"%>
	</div>
</div>
</body>
</html>