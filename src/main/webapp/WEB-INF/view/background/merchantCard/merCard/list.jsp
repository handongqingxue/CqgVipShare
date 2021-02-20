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
<title>会员卡查询</title>
<%@include file="../../js.jsp"%>
<script type="text/javascript">
var merCardPath='<%=basePath%>'+"background/merchantCard/";
var shopId=null;
var userName='${sessionScope.merchant.userName}';
if(userName!="admin")
	shopId='${sessionScope.merchant.id}';
$(function(){
	initTypeCBB();
	initSearchLB();
	initAddLB();
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

function initSearchLB(){
	$("#search_but").linkbutton({
		iconCls:"icon-search",
		onClick:function(){
			var name=$("#toolbar #name").val();
			var type=typeCBB.combobox("getValue");
			tab1.datagrid("load",{name:name,type:type,shopId:shopId});
		}
	});
}

function initAddLB(){
	$("#add_but").linkbutton({
		iconCls:"icon-add",
		onClick:function(){
			location.href=merCardPath+"merCard/add";
		}
	});
}

function initTab1(){
	tab1=$("#tab1").datagrid({
		title:"会员卡查询",
		url:merCardPath+"selectMerCardList",
		toolbar:"#toolbar",
		width:setFitWidthInParent("body"),
		queryParams:{shopId:shopId},
		pagination:true,
		pageSize:10,
		columns:[[
			{field:"name",title:"卡名",width:150},
			{field:"typeName",title:"类型",width:100},
			{field:"consumeCount",title:"使用次数",width:100},
			{field:"money",title:"金额",width:100},
            {field:"createTime",title:"创建时间",width:150},
            {field:"enable",title:"状态",width:150,formatter:function(value,row){
            	return value?"已上架":"已下架";
            }},
            {field:"id",title:"操作",width:110,formatter:function(value,row){
            	var str="<a href=\"edit?id="+value+"\">编辑</a>";
            	if(row.enable)
            		str+="&nbsp;&nbsp;<a onclick=\"updateEnableById('"+value+"',false)\">下架</a>";
           		else
               		str+="&nbsp;&nbsp;<a onclick=\"updateEnableById('"+value+"',true)\">上架</a>";
            	return str;
            }}
	    ]],
        onLoadSuccess:function(data){
			if(data.total==0){
				$(this).datagrid("appendRow",{name:"<div style=\"text-align:center;\">暂无信息<div>"});
				$(this).datagrid("mergeCells",{index:0,field:"name",colspan:7});
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

function updateEnableById(id,enable){
	if(confirm("确认"+(enable?"上":"下")+"架")){
		$.post(merCardPath+"updateEnableById",
			{id:id,enable:enable},
			function(data){
				if(data.state=="ok"){
					alert(data.message);
					tab1.datagrid("load");
				}
				else{
					alert(data.message);
				}
			}
		,"json");
	}
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
			<input type="text" id="name" placeholder="请输入卡名" style="width: 120px;height: 25px;"/>
			<span style="margin-left: 13px;">类型：</span>
			<input id="type_cbb"/>
			<a id="search_but" style="margin-left: 13px;">查询</a>
			<a id="add_but">添加</a>
		</div>
		<table id="tab1">
		</table>
	</div>
	<%@include file="../../foot.jsp"%>
</div>
</body>
</html>