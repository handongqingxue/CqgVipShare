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
<title>资金流水记录</title>
<%@include file="js.jsp"%>
<script type="text/javascript">
$(function(){
	$("#output_but").linkbutton({
		iconCls:"icon-back",
		onClick:function(){
			exportCapFlowRecList();
		}
	});
	
	tab1=$("#tab1").datagrid({
		title:"资金流水记录查询",
		url:"selectCapFlowRecList",
	    toolbar:"#toolbar",
		width:setFitWidthInParent("body"),
		pagination:true,
		pageSize:10,
		columns:[[
			{field:"no",title:"卡号",width:150},
			{field:"kzNickName",title:"卡主昵称",width:150},
			{field:"fxzNickName",title:"分享者昵称",width:150},
			{field:"shareMoney",title:"金额",width:150},
			{field:"phone",title:"分享者手机号",width:150},
			{field:"shopName",title:"门店名称",width:150},
			{field:"shopAddress",title:"门店地址",width:150},
			{field:"ygxfDate",title:"预估消费日期",width:150},
            {field:"createTime",title:"创建时间",width:150},
            {field:"state",title:"状态",width:80,formatter:function(value,row){
            	return (value==1?"已":"未")+"消费";
            }}
	    ]],
        onLoadSuccess:function(data){
			if(data.total==0){
				$(this).datagrid("appendRow",{no:"<div style=\"text-align:center;\">暂无信息<div>"});
				$(this).datagrid("mergeCells",{index:0,field:"no",colspan:10});
				data.total=0;
			}
			
			$(".panel-header").css("background","linear-gradient(to bottom,#F4F4F4 0,#F4F4F4 20%)");
			$(".panel-header .panel-title").css("color","#000");
			$(".panel-header .panel-title").css("font-size","15px");
			$(".panel-header .panel-title").css("padding-left","10px");
			$(".panel-header, .panel-body").css("border-color","#ddd");
		}
	});
});

function exportCapFlowRecList(){
	$.messager.confirm("提示","确定要更新吗？",function(r){
		if(r){
			location.href="exportCapFlowRecList";
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
	<%@include file="side.jsp"%>
	<div class="tab1_div" id="tab1_div">
		<div id="toolbar">
			<a id="output_but">导出Excel</a>
		</div>
		<table id="tab1">
		</table>
	</div>
	<%@include file="foot.jsp"%>
</div>
</body>
</html>