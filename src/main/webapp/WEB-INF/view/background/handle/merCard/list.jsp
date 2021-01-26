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
var handlePath='<%=basePath%>'+"background/handle/";
var shopId=null;
var userName='${sessionScope.merchant.userName}';
if(userName!="admin")
	shopId='${sessionScope.merchant.id}';
$(function(){
	tab1=$("#tab1").datagrid({
		title:"会员卡查询",
		url:handlePath+"selectMerCardList",
		width:setFitWidthInParent("body"),
		queryParams:{shopId:shopId},
		pagination:true,
		pageSize:10,
		columns:[[
			{field:"name",title:"卡名",width:150},
			{field:"type",title:"类型",width:100,formatter:function(value){
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
			{field:"consumeCount",title:"使用次数",width:100},
			{field:"money",title:"金额",width:100},
            {field:"createTime",title:"创建时间",width:150},
            {field:"enable",title:"状态",width:150,formatter:function(value,row){
            	return value?"已上架":"已下架";
            }},
            {field:"id",title:"操作",width:110,formatter:function(value,row){
            	var str="<a href=\"edit?id="+value+"\">编辑</a>";
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
});

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
		<table id="tab1">
		</table>
	</div>
	<%@include file="../../foot.jsp"%>
</div>
</body>
</html>