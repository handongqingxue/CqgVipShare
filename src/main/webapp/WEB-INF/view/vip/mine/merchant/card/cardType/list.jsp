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
<link rel="stylesheet" href="<%=basePath %>resource/css/vip/mine/merchant/card/cardType/list.css"/>
<script type="text/javascript" src="<%=basePath %>resource/js/jquery-3.3.1.js"></script>
<script type="text/javascript">
var path='<%=basePath%>';
var vipPath='<%=basePath%>'+"vip/";
var shopId='${sessionScope.merchant.id}';
var openId='${param.openId}';

$(function(){
	initYsjListDiv();
	changeTabDiv(1);
});

function initYsjListDiv(){
	$.post(vipPath+"selectMerCardTypeList",
		{shopId:shopId},
		function(result){
			var ysjListDiv=$("#ysj_div #list_div");
			ysjListDiv.empty();
			if(result.message=="ok"){
				var list=result.data;
				for(var i=0;i<list.length;i++){
					var item=list[i];
					var appendStr="<div class=\"item_div\">";
					var typeName;
					switch (item.type) {
					case 1:
						typeName="年卡";
						break;
					case 2:
						typeName="季卡";
						break;
					case 3:
						typeName="月卡";
						break;
					case 4:
						typeName="充值卡";
						break;
					case 5:
						typeName="次卡";
						break;
					}
					appendStr+="<span class=\"name_span\">"+typeName+"</span>";
					appendStr+="<input class=\"downBut_inp\" id=\"downBut_inp"+item.type+"\" type=\"checkbox\" value=\"删除\"/>";
					appendStr+="<div class=\"line_div\"></div>";
					appendStr+="</div>";
					ysjListDiv.append(appendStr);
				}
			}
			else{
				ysjListDiv.append("<div class=\"noData_div\">"+result.info+"</div>");
			}
			initDsjListDiv();
		}
	,"json");
}

function initDsjListDiv(){
	var dsjList=[];
	var dataJA=[{type:1,name:"年卡"},{type:2,name:"季卡"},{type:3,name:"月卡"},{type:4,name:"充值卡"},{type:5,name:"次卡"}];
	//var tab1Rows=tab1.datagrid("getData").rows;
	for(var i=0;i<dataJA.length;i++){
		var add=true;
		/*
		for(var j=0;j<tab1Rows.length;j++){
			if(dataJA[i].type==tab1Rows[j].type){
				add=false;
			}
		}
		*/
		$("#ysj_div #list_div .item_div").each(function(j){
			var downButInp=$(this).find("input[id^='downBut_inp']");
			var id=downButInp.attr("id");
			var type=id.substring(11);
			if(dataJA[i].type==type){
				add=false;
			}
		});
		if(add)
			dsjList.push(dataJA[i]);
	}
	var dsjListDiv=$("#dsj_div #list_div");
	dsjListDiv.empty();
	if(dsjList.length==0){
		dsjListDiv.append("<div class=\"noData_div\">暂无信息</div>");
	}
	else{
		for(var i=0;i<dsjList.length;i++){
			var item=dsjList[i];
			var appendStr="<div class=\"item_div\">";
			appendStr+="<span class=\"name_span\">"+item.name+"</span>";
			appendStr+="<input class=\"upBut_inp\" id=\"upBut_inp"+item.type+"\" type=\"checkbox\" value=\"删除\"/>";
			appendStr+="<div class=\"line_div\"></div>";
			appendStr+="</div>";
			dsjListDiv.append(appendStr);
		}
	}
}

function changeTabDiv(flag){
	var tabItemDiv=$(".tab_div .item_div");
	tabItemDiv.removeClass("select");
	tabItemDiv.removeClass("unSelect");
	tabItemDiv.each(function(i){
		if(i==flag-1){
			tabItemDiv.eq(i).addClass("select");
		}
		else{
			tabItemDiv.eq(i).addClass("unSelect");
		}
	});
	if(flag==1){
		$("#allDown_inp").css("display","block");
		$("#allDown_span").css("display","block");
		$("#ysj_div").css("display","block");

		$("#allUp_inp").css("display","none");
		$("#allUp_span").css("display","none");
		$("#dsj_div").css("display","none");
	}
	else if(flag==2){
		$("#allDown_inp").css("display","none");
		$("#allDown_span").css("display","none");
		$("#ysj_div").css("display","none");
		
		$("#allUp_inp").css("display","block");
		$("#allUp_span").css("display","block");
		$("#dsj_div").css("display","block");
	}
}

function selectAllDownInp(){
	var checked=$("#allDown_inp").prop("checked");
	$("#ysj_div #list_div input[id^='downBut_inp']").prop("checked",checked);
}

function downAllSelected(){
	var types="";
	$("#ysj_div #list_div input[id^='downBut_inp']").each(function(){
		var checked=$(this).prop("checked");
		if(checked){
			var type=$(this).attr("id").substring(11);
			types+=","+type;
		}
	});
	types=types.substring(1);
	if(types==""){
		alert("请选择要下架的信息！");
		return false;
	}
	checkExistMerCardByType(types,shopId);
}

function checkExistMerCardByType(types,shopId){
	$.post(vipPath+"checkExistMerCardByType",
		{types:types,shopId:shopId},
		function(result){
			if(result.status==1){
				deleteByTypes(result.data);
			}
			else{
				if(result.data==null){
					alert(result.msg);
					return false;
				}
				else{
					if(confirm(result.msg))
						deleteByTypes(result.data);
				}
			}
		}
	,"json");
}

function deleteByTypes(types){
	$.post(vipPath+"deleteMerCardTypeByTypes",
		{types:types},
		function(result){
			if(result.status==1){
				alert(result.msg);
				initYsjListDiv();
			}
			else{
				alert(result.msg);
			}
		}
	,"json");
}

function selectAllUpInp(){
	var checked=$("#allUp_inp").prop("checked");
	$("#dsj_div #list_div input[id^='upBut_inp']").prop("checked",checked);
}

function upAllSelected(){
	var types="";
	$("#dsj_div #list_div input[id^='upBut_inp']").each(function(){
		var checked=$(this).prop("checked");
		if(checked){
			var type=$(this).attr("id").substring(9);
			types+=","+type;
		}
	});
	types=types.substring(1);
	if(types==""){
		alert("请选择要上架的信息！");
		return false;
	}
	addByTypes(types);
}

function addByTypes(types){
	$.post(vipPath+"addMerCardType",
		{shopId:shopId,types:types},
		function(data){
			if(data.message=="ok"){
				alert(data.info);
				initYsjListDiv();
			}
			else{
				alert(data.info);
			}
		}
	,"json");
}

function goBack(){
	location.href=path+"vip/goPage?page=mineMerCardMgr&openId="+openId;
}
</script>
<title>卡类型查询</title>
</head>
<body>
<div class="top_div">
	<span>卡类型</span>
</div>
<div class="back_div">
	<span class="back_span" onclick="goBack()">&lt;返回</span>
	<input class="allDown_inp" id="allDown_inp" type="checkbox" value="删除" onclick="selectAllDownInp()" />
	<span class="allDown_span" id="allDown_span" onclick="downAllSelected()">下架</span>
	<input class="allUp_inp" id="allUp_inp" type="checkbox" value="删除" onclick="selectAllUpInp()" />
	<span class="allUp_span" id="allUp_span" onclick="upAllSelected()">上架</span>
</div>
<div class="tab_div">
	<div class="item_div ysj_item_div" onclick="changeTabDiv(1);">已上架</div>
	<div class="item_div dsj_item_div" onclick="changeTabDiv(2);">待上架</div>
</div>
<div class="ysj_div" id="ysj_div">
	<div class="list_div" id="list_div">
	</div>
</div>
<div class="dsj_div" id="dsj_div">
	<div class="list_div" id="list_div">
	</div>
</div>
</body>
</html>