<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>商家审核</title>
<%@include file="js.jsp"%>
<script type="text/javascript">
$(function(){
	tab1=$("#tab1").datagrid({
		title:"商家审核查询",
		url:"selectShopCheckList",
		width:setFitWidthInParent("body"),
		pagination:true,
		pageSize:10,
		columns:[[
			{field:"tradeName",title:"行业",width:150},
			{field:"shopName",title:"商家名称",width:150},
			{field:"shopAddress",title:"商家地址",width:250},
            {field:"createTime",title:"创建时间",width:150},
            {field:"shopCheck",title:"状态",width:150,formatter:function(value,row){
            	var str;
            	switch (value) {
				case 0:
					str="待审核";
					break;
				case 2:
					str="审核未通过";
					break;
				}
            	return str;
            }},
            {field:"openId",title:"审核",width:110,formatter:function(value,row){
            	//var str="<a onclick=\"checkById('1','"+value+"')\">通过</a>&nbsp;&nbsp;"
            		//+"<a onclick=\"checkById('2','"+value+"')\">不通过</a>";
            	var str="<a href=\"toShopDetail?openId="+value+"\">详情</a>";
            	return str;
            }}
	    ]],
        onLoadSuccess:function(data){
			if(data.total==0){
				$(this).datagrid("appendRow",{tradeName:"<div style=\"text-align:center;\">暂无信息<div>"});
				$(this).datagrid("mergeCells",{index:0,field:"tradeName",colspan:6});
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
	<%@include file="side.jsp"%>
	<div id="tab1_div" style="margin-top:20px;margin-left: 200px;">
		<table id="tab1">
		</table>
	</div>
	<%@include file="foot.jsp"%>
</div>
</body>
</html>