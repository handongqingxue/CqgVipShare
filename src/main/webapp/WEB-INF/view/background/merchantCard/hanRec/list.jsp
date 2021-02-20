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
</style>
<title>商家审核</title>
<%@include file="../../js.jsp"%>
<script type="text/javascript">
var merCardPath='<%=basePath%>'+"background/merchantCard/";
var shopId=null;
var userName='${sessionScope.merchant.userName}';
if(userName!="admin")
	shopId='${sessionScope.merchant.id}';
$(function(){
	initTypeCBB();
	initCTSDTB();
	initCTEDTB();
	initReceiveCBB();
	initSearchLB();
	initTab1();
});

function initTypeCBB(){
	$.post(merCardPath+"selectMerCardType",
		{shopId:shopId},
		function(result){
			var data=[];
			data.push({value:"",text:"请选择"});
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
				//multiple:true,
				data:data
			});
		}
	,"json");
}

function initCTSDTB(){
	ctsDTB=$('#cts_dtb').datetimebox({
        required:false
    });
}

function initCTEDTB(){
	cteDTB=$('#cte_dtb').datetimebox({
        required:false
    });
}

function initReceiveCBB(){
	receiveCBB=$("#receive_cbb").combobox({
		valueField:"value",
		textField:"text",
		//multiple:true,
		data:[{value:"",text:"请选择"},{value:"0",text:"未领取"},{value:"1",text:"已领取"}]
	});
}

function initSearchLB(){
	$("#search_but").linkbutton({
		iconCls:"icon-search",
		onClick:function(){
			var mcName=$("#toolbar #mcName").val();
			var mcType=typeCBB.combobox("getValue");
			var createTimeStart=ctsDTB.datetimebox("getValue");
			var createTimeEnd=cteDTB.datetimebox("getValue");
			var receive=receiveCBB.combobox("getValue");
			tab1.datagrid("load",{mcName:mcName,mcType:mcType,createTimeStart:createTimeStart,createTimeEnd:createTimeEnd,receive:receive,shopId:shopId});
		}
	});
}

function initTab1(){
	tab1=$("#tab1").datagrid({
		title:"办卡记录",
		url:merCardPath+"selectHanRecList",
		toolbar:"#toolbar",
		width:setFitWidthInParent("body"),
		queryParams:{shopId:shopId},
		pagination:true,
		pageSize:10,
		columns:[[
			{field:"realName",title:"办卡人姓名",width:100},
			{field:"phone",title:"手机号",width:150},
			{field:"qq",title:"qq",width:150},
			{field:"wxNo",title:"微信",width:150},
			{field:"mcName",title:"卡名",width:150},
			{field:"mcType",title:"类型",width:100,formatter:function(value){
				var str;
				switch (value) {
				case 1:
					str="金额卡";
					break;
				case 2:
					str="次卡";
					break;
				}
				return str;
			}},
			{field:"money",title:"金额",width:100},
            {field:"createTime",title:"办卡时间",width:150},
            {field:"receive",title:"状态",width:150,formatter:function(value,row){
            	return (value?"已":"未")+"领取";
            }},
            {field:"id",title:"操作",width:110,formatter:function(value,row){
            	var str="<a href=\"edit?id="+value+"\">编辑</a>";
            	return str;
            }}
	    ]],
        onLoadSuccess:function(data){
			if(data.total==0){
				$(this).datagrid("appendRow",{realName:"<div style=\"text-align:center;\">暂无信息<div>"});
				$(this).datagrid("mergeCells",{index:0,field:"realName",colspan:10});
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
	return width.substring(0,width.length-2)-210;
}
</script>
</head>
<body>
<div class="layui-layout layui-layout-admin">
	<%@include file="../../side.jsp"%>
	<div class="tab1_div" id="tab1_div">
		<div id="toolbar" style="height:32px;">
			<span style="margin-left: 13px;">卡名：</span>
			<input type="text" id="mcName" placeholder="请输入卡名" style="width: 120px;height: 25px;"/>
			<span style="margin-left: 13px;">类型：</span>
			<input id="type_cbb"/>
			<span style="margin-left: 13px;">办卡时间：</span>
			<input id="cts_dtb"/>
			-
			<input id="cte_dtb"/>
			<span style="margin-left: 13px;">状态：</span>
			<input id="receive_cbb"/>
			<a id="search_but" style="margin-left: 13px;">查询</a>
		</div>
		<table id="tab1">
		</table>
	</div>
	<%@include file="../../foot.jsp"%>
</div>
</body>
</html>