<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<style type="text/css">
.tab1_div{
	margin-top:20px;
	margin-left: 220px;
}
.but_div{
	width:62px; 
	margin-top: -230px;
	margin-left: 550px;
}
.tab2_div{
	margin-top:-172px;
	margin-left: 650px;
}
</style>
<title>卡类型查询</title>
<%@include file="../../js.jsp"%>
<script type="text/javascript">
var merCardPath='<%=basePath%>'+"background/merchantCard/";
var shopId='${sessionScope.merchant.id}';
$(function(){
	initTab1();
	initAddBut();
	initRemoveBut();
});

function initTab1(){
	tab1=$("#tab1").datagrid({
		title:"已上架卡类型",
		url:merCardPath+"selectMerCardTypeList",
		width:300,
		height:300,
		queryParams:{shopId:shopId},
		pagination:true,
		pageSize:10,
		columns:[[
			{field:"type",title:"type",width:0,hidden:true},
			//{field:"type",title:"type",width:100},
			{field:"name",title:"类型",width:100}
	    ]],
        onLoadSuccess:function(data){
			if(data.total==0){
				$(this).datagrid("appendRow",{type:"<div style=\"text-align:center;\">暂无信息<div>"});
				$(this).datagrid("mergeCells",{index:0,field:"type",colspan:1});
				data.total=0;
			}
			
			$(".panel-header").css("background","linear-gradient(to bottom,#F4F4F4 0,#F4F4F4 20%)");
			$(".panel-header .panel-title").css("color","#000");
			$(".panel-header .panel-title").css("font-size","15px");
			$(".panel-header .panel-title").css("padding-left","10px");
			$(".panel-header, .panel-body").css("border-color","#ddd");
			initTab2();
		}
	});
}

function initAddBut(){
	$("#add_but").linkbutton({
		iconCls:"icon-back",
		onClick:function(){
			var rows=tab2.datagrid("getSelections");
			if (rows.length == 0) {
				$.messager.alert("提示","请选择要上架的信息！","warning");
				return false;
			}
			
			var types = "";
			for (var i = 0; i < rows.length; i++) {
				types += "," + rows[i].type;
			}
			types=types.substring(1);
			addByTypes(types);
		}
	});
}

function addByTypes(types){
	$.post(merCardPath+"addMerCardType",
		{shopId:shopId,types:types},
		function(data){
			if(data.message=="ok"){
				alert(data.info);
				tab1.datagrid("load");
			}
			else{
				alert(data.info);
			}
		}
	,"json");
}

function initRemoveBut(){
	$("#remove_but").linkbutton({
		iconCls:"icon-remove",
		onClick:function(){
			var rows=tab1.datagrid("getSelections");
			if (rows.length == 0) {
				$.messager.alert("提示","请选择要下架的信息！","warning");
				return false;
			}
			
			var types = "";
			for (var i = 0; i < rows.length; i++) {
				types += "," + rows[i].type;
			}
			types=types.substring(1);
			checkExistMerCardByType(types,shopId);
		}
	});
}

function checkExistMerCardByType(types,shopId){
	$.post(merCardPath+"checkExistMerCardByType",
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
	$.post(merCardPath+"deleteMerCardTypeByTypes",
		{types:types},
		function(result){
			if(result.status==1){
				alert(result.msg);
				tab1.datagrid("load");
			}
			else{
				alert(result.msg);
			}
		}
	,"json");
}

function initTab2(){
	var data=[];
	var dataJA=[{type:1,name:"年卡"},{type:2,name:"季卡"},{type:3,name:"月卡"},{type:4,name:"充值卡"},{type:5,name:"次卡"}];
	var tab1Rows=tab1.datagrid("getData").rows;
	for(var i=0;i<dataJA.length;i++){
		var add=true;
		for(var j=0;j<tab1Rows.length;j++){
			if(dataJA[i].type==tab1Rows[j].type){
				add=false;
			}
		}
		if(add)
			data.push(dataJA[i]);
	}
	tab2=$("#tab2").datagrid({
		title:"待上架卡类型",
		width:300,
		height:300,
		queryParams:{shopId:shopId},
		pagination:true,
		pageSize:10,
		columns:[[
			{field:"type",title:"type",width:0,hidden:true},
			{field:"name",title:"类型",width:100}
	    ]],
	    data:data,
        onLoadSuccess:function(data){
			if(data.total==0){
				$(this).datagrid("appendRow",{type:"<div style=\"text-align:center;\">暂无信息<div>"});
				$(this).datagrid("mergeCells",{index:0,field:"type",colspan:2});
				data.total=0;
			}
			
			$(".panel-header").css("background","linear-gradient(to bottom,#F4F4F4 0,#F4F4F4 20%)");
			$(".panel-header .panel-title").css("color","#000");
			$(".panel-header .panel-title").css("font-size","15px");
			$(".panel-header .panel-title").css("padding-left","10px");
			$(".panel-header, .panel-body").css("border-color","#ddd");
		}
	});
}

function setFitWidthInParent(o){
	var width=$(o).css("width");
	return width.substring(0,width.length-2)-250;
}
</script>
</head>
<body>
<div class="layui-layout layui-layout-admin">
	<%@include file="../../side.jsp"%>
	<div class="tab1_div">
		<table id="tab1">
		</table>
	</div>
	<div class="but_div">
		<a id="add_but">上架</a>
		<a id="remove_but" style="margin-top: 50px;">下架</a>
	</div>
	<div class="tab2_div">
		<table id="tab2">
		</table>
	</div>
	<%@include file="../../foot.jsp"%>
</div>
</body>
</html>