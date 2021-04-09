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
<title>消息中心</title>
<%@include file="../../js.jsp"%>
<script type="text/javascript">
var merchantPath='<%=basePath%>'+"background/merchant/";
var openId='${sessionScope.merchant.openId}';
$(function(){
	initIsReadCBB();
	initSearchLB();
	initTab1();
});

function initIsReadCBB(){
	var data=[];
	data.push({"value":"","text":"请选择"});
	data.push({"value":"0","text":"未读"});
	data.push({"value":"1","text":"已读"});
	isReadCBB=$("#isRead_cbb").combobox({
		valueField:"value",
		textField:"text",
		data:data
	});
}

function initSearchLB(){
	$("#search_but").linkbutton({
		iconCls:"icon-search",
		onClick:function(){
			var title=$("#toolbar #title").val();
			var isRead=isReadCBB.combobox("getValue");
			tab1.datagrid("load",{title:title,isRead:isRead,openId:openId});
		}
	});
}

function initTab1(){
	tab1=$("#tab1").datagrid({
		title:"消息查询",
		url:merchantPath+"selectMessageList",
		toolbar:"#toolbar",
		width:setFitWidthInParent("body"),
		queryParams:{openId:openId},
		pagination:true,
		pageSize:10,
		columns:[[
			{field:"title",title:"标题",width:150},
			{field:"content",title:"内容",width:400},
            {field:"createTime",title:"创建时间",width:150},
            {field:"isRead",title:"状态",width:80,formatter:function(value,row){
            	return (value==1?"已":"未")+"读";
            }},
            {field:"id",title:"操作",width:110,formatter:function(value,row){
            	return "";
            }}
	    ]],
        onLoadSuccess:function(data){
			if(data.total==0){
				$(this).datagrid("appendRow",{title:"<div style=\"text-align:center;\">暂无信息<div>"});
				$(this).datagrid("mergeCells",{index:0,field:"title",colspan:5});
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
	<div class="tab1_div" id="tab1_div">
		<div id="toolbar" style="height:32px;">
			<span style="margin-left: 13px;">标题：</span>
			<input type="text" id="title" placeholder="请输入标题" style="width: 120px;height: 25px;"/>
			<span style="margin-left: 13px;">状态：</span>
			<input id="isRead_cbb"/>
			<a id="search_but" style="margin-left: 13px;">查询</a>
		</div>
		<table id="tab1">
		</table>
	</div>
	<%@include file="../../foot.jsp"%>
</div>
</body>
</html>