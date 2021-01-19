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
<title>行业抽成查询</title>
<%@include file="js.jsp"%>
<script type="text/javascript">
$(function(){
	tab1=$("#tab1").datagrid({
		title:"行业抽成查询",
		url:"selectTradeCCList",
		width:setFitWidthInParent("body"),
		pagination:true,
		pageSize:10,
		columns:[[
			{field:"name",title:"行业名称",width:150},
            {field:"ccPercent",title:"抽成",width:100,formatter:function(value,row){
            	return "<input type=\"number\" style=\"width:80px;\" value=\""+value+"\" onblur=\"updateCCPercent(this.value,'"+row.id+"')\"/>";
            }}
	    ]],
        onLoadSuccess:function(data){
			if(data.total==0){
				$(this).datagrid("appendRow",{name:"<div style=\"text-align:center;\">暂无信息<div>"});
				$(this).datagrid("mergeCells",{index:0,field:"name",colspan:2});
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

function updateCCPercent(ccPercent,id){
	$.post("updateCCPercentById",
		{ccPercent:ccPercent,id:id},
		function(data){
			if(data.status=="ok"){
				alert(data.message);
				tab1.datagrid("load");
			}
			else{
				alert(data.message);
			}
		}
	,"json");
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
		<table id="tab1">
		</table>
	</div>
	<%@include file="foot.jsp"%>
</div>
</body>
</html>