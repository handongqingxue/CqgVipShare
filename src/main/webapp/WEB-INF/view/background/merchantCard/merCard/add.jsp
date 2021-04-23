<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>添加会员</title>
<%@include file="../../js.jsp"%>
<style type="text/css">
.center_con_div{
	width: 88%;
	height: 90vh;
	margin-left:205px;
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
var ndNum=0;
$(function(){
	initNewDialog();

	initDialogPosition();//将不同窗体移动到主要内容区域
});

function initDialogPosition(){
	//基本属性组
	var ndpw=$("body").find(".panel.window").eq(ndNum);
	var ndws=$("body").find(".window-shadow").eq(ndNum);

	var ccDiv=$("#center_con_div");
	ccDiv.append(ndpw);
	ccDiv.append(ndws);
}

function initNewDialog(){
	dialogTop+=20;
	$("#new_div").dialog({
		title:"会员卡信息",
		width:setFitWidthInParent("body","new_div"),
		height:450,
		top:dialogTop,
		left:dialogLeft,
		buttons:[
           {text:"保存",id:"ok_but",iconCls:"icon-ok",handler:function(){
        	   checkAdd();
           }}
        ]
	});

	$("#new_div table").css("width",(setFitWidthInParent("body","new_div_table"))+"px");
	$("#new_div table").css("magin","-100px");
	$("#new_div table td").css("padding-left","50px");
	$("#new_div table td").css("padding-right","20px");
	$("#new_div table td").css("font-size","15px");
	$("#new_div table tr").each(function(i){
		$(this).css("height",(i==4?150:45)+"px");
	});

	$(".panel.window").eq(ndNum).css("margin-top","20px");
	$(".panel.window .panel-title").eq(ndNum).css("color","#000");
	$(".panel.window .panel-title").eq(ndNum).css("font-size","15px");
	$(".panel.window .panel-title").eq(ndNum).css("padding-left","10px");
	
	$(".panel-header, .panel-body").css("border-color","#ddd");
	
	//以下的是表格下面的面板
	$(".window-shadow").eq(ndNum).css("margin-top","20px");
	$(".window,.window .window-body").eq(ndNum).css("border-color","#ddd");

	$("#new_div #ok_but").css("left","45%");
	$("#new_div #ok_but").css("position","absolute");
	
	$(".dialog-button").css("background-color","#fff");
	$(".dialog-button .l-btn-text").css("font-size","20px");
	
	initTypeCBB();
}

function initTypeCBB(){
	$.post(merCardPath+"selectMerCardType",
		{shopId:shopId},
		function(result){
			var data=[];
			data.push({"value":"","text":"请选择会员卡类型"});
			if(result.message=="ok"){
				var mctList=result.data;
				for(var i=0;i<mctList.length;i++){
					var mct=mctList[i];
					data.push({value:mct.type,text:mct.name});
				}
			}
			typeCBB=$("#type_cbb").combobox({
				valueField:"value",
				textField:"text",
				data:data,
				onSelect:function(){
					$("#type").val($(this).combobox("getValue"));
				}
			});
		}
	,"json");
}

function checkAdd(){
	if(checkName()){
		if(checkType()){
			if(checkConsumeCount()){
				if(checkMoney()){
					if(checkSfbfb()){
						if(checkShopFC()){
							addMerCard();
						}
					}
				}
			}
		}
	}
}

function addMerCard(){
	var name=$("#name").val();
	var type=typeCBB.combobox("getValue");
	var consumeCount = $("#consumeCount").val();
	var money = $("#money").val();
	var discount = $("#discount").val();
	var sfbfb = $("#sfbfb").val();
	var shopFC = $("#shopFC").val();
	var describe = $("#describe").val();
	var gmxz = $("#gmxz").val();

	$.post(merCardPath+"addMerCard",
		{name:name,type:type,shopId:shopId,consumeCount:consumeCount,money:money,discount:discount,sfbfb:sfbfb,shopFC:shopFC,describe:describe,gmxz:gmxz},
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

//验证会员卡类型
function checkType(){
	var flag=false;
	var type=typeCBB.combobox("getValue");
	if(type==null||type==""){
	  	alert("请选择会员卡类型");
	  	flag=false;
	}
	else{
		$.ajaxSetup({async:false});
		$.post(merCardPath+"checkTypeExist",
			{type:type,shopId:shopId},
			function(data){
				if(data.state=="no"){
					alert(data.message);
					flag=false;
				}
				else
					flag=true;
			}
		,"json");
	}
	return flag;
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

//验证上浮百分比
function checkSfbfb(){
	var sfbfb = $("#sfbfb").val();
	if(sfbfb==null||sfbfb==""){
	  	alert("请输入上浮百分比");
	  	return false;
	}
	else
		return true;
}

//验证商家分成
function checkShopFC(){
	var shopFC = $("#shopFC").val();
	if(shopFC==null||shopFC==""){
	  	alert("请输入商家分成");
	  	return false;
	}
	else
		return true;
}

function setFitWidthInParent(parent,self){
	var space=0;
	switch (self) {
	case "new_div":
		space=340;
		break;
	case "new_div_table":
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
	<div class="page_location_div">添加会员卡</div>
	
	<div id="new_div">
		<table>
		  <tr style="border-bottom: #CAD9EA solid 1px;">
			<td align="right" style="width:15%;">
				会员卡名称
			</td>
			<td style="width:30%;">
				<input type="text" id="name" name="name" placeholder="请输入会员卡名称" style="width: 150px;height:30px;" onfocus="focusName()" onblur="checkName()"/>
			</td>
			<td align="right" style="width:15%;">
				会员卡类型
			</td>
			<td style="width:30%;">
				<input id="type_cbb"/>
				<input type="hidden" id="type" name="type"/>
			</td>
		  </tr>
		  <tr style="border-bottom: #CAD9EA solid 1px;">
			<td align="right" style="width:15%;">
				使用次数
			</td>
			<td style="width:30%;">
				<input type="number" id="consumeCount" name="consumeCount" placeholder="请输入使用次数" style="width: 150px;height:30px;"/>
			</td>
			<td align="right" style="width:15%;">
				金额
			</td>
			<td style="width:30%;">
				<input type="number" id="money" name="money" placeholder="请输入金额" style="width: 150px;height:30px;"/>
			</td>
		  </tr>
		  <tr style="border-bottom: #CAD9EA solid 1px;">
			<td align="right" style="width:15%;">
				折扣
			</td>
			<td style="width:30%;">
				<input type="number" id="discount" name="discount" placeholder="请输入折扣" style="width: 150px;height:30px;"/>%
			</td>
			<td align="right" style="width:15%;">
				上浮百分比
			</td>
			<td style="width:30%;">
				<input type="number" id="sfbfb" name="sfbfb" placeholder="请输入上浮百分比" style="width: 150px;height:30px;"/>%
			</td>
		  </tr>
		  <tr style="border-bottom: #CAD9EA solid 1px;">
			<td align="right" style="width:15%;">
				商家分成
			</td>
			<td style="width:30%;">
				<input type="number" id="shopFC" name="shopFC" placeholder="请输入商家分成" style="width: 150px;height:30px;"/>%
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
				<textarea rows="5" cols="20" id="describe" name="describe"></textarea>
			</td>
			<td align="right" style="width:15%;">
				购买须知
			</td>
			<td style="width:30%;">
				<textarea rows="5" cols="20" id="gmxz" name="gmxz"></textarea>
			</td>
		  </tr>
		</table>
	</div>
	<%@include file="../../foot.jsp"%>
	</div>
</div>
</body>
</html>