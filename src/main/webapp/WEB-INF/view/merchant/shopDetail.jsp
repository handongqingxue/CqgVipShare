<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>商家详情</title>
<%@include file="js.jsp"%>
<script type="text/javascript">
var path='<%=basePath %>';
var dialogTop=40;
var dialogLeft=220;
var edNum=0;
$(function(){
	initDetailDialog();
});

function initDetailDialog(){
	dialogTop+=20;
	$("#detail_div").dialog({
		title:"磅单填报",
		width:setFitWidthInParent("body","detail_div"),
		height:385,
		top:dialogTop,
		left:dialogLeft,
		buttons:[
           {text:"审核通过",id:"ok_but",iconCls:"icon-ok",handler:function(){
        	   
           }},
           {text:"审核不通过",id:"cancel_but",iconCls:"icon-cancel",handler:function(){
        	   
           }}
        ]
	});

	$("#detail_div table").css("width",(setFitWidthInParent("body","detail_div_table"))+"px");
	$("#detail_div table").css("magin","-100px");
	$("#detail_div table td").css("padding-left","50px");
	$("#detail_div table td").css("padding-right","20px");
	$("#detail_div table td").css("font-size","15px");
	$("#detail_div table tr").each(function(i){
		$(this).css("height",(i==3?90:45)+"px");
	});

	$(".panel.window").eq(edNum).css("margin-top","20px");
	$(".panel.window .panel-title").eq(edNum).css("color","#000");
	$(".panel.window .panel-title").eq(edNum).css("font-size","15px");
	$(".panel.window .panel-title").eq(edNum).css("padding-left","10px");
	
	$(".panel-header, .panel-body").css("border-color","#ddd");
	
	//以下的是表格下面的面板
	$(".window-shadow").eq(edNum).css("margin-top","20px");
	$(".window,.window .window-body").eq(edNum).css("border-color","#ddd");

	$("#detail_div #ok_but").css("left","30%");
	$("#detail_div #ok_but").css("position","absolute");
	$("#detail_div #cancel_but").css("left","45%");
	$("#detail_div #cancel_but").css("position","absolute");
	
	$(".dialog-button").css("background-color","#fff");
	$(".dialog-button .l-btn-text").css("font-size","20px");
}

function setFitWidthInParent(parent,self){
	var space=0;
	switch (self) {
	case "detail_div":
		space=340;
		break;
	case "detail_div_table":
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
	<%@include file="side.jsp"%>
	<div id="detail_div">
		<input type="hidden" id="ddbm" name="ddbm" value="${requestScope.dd.wybm }"/>
		<table>
		  <tr style="border-bottom: #CAD9EA solid 1px;">
			<td align="right" style="width:15%;">
				对方过磅皮重
			</td>
			<td style="width:30%;">
				<span>${requestScope.bd.dfgbpz }</span>
			</td>
			<td align="right" style="width:15%;">
				对方过磅毛重
			</td>
			<td style="width:30%;">
				<span>${requestScope.bd.dfgbmz }</span>
			</td>
		  </tr>
		  <tr style="border-bottom: #CAD9EA solid 1px;">
			<td align="right" style="width:15%;">
				包数
			</td>
			<td style="width:30%;">
				<span>${requestScope.bd.bs }</span>
			</td>
			<td align="right" style="width:15%;">
				块数
			</td>
			<td style="width:30%;">
				<span>${requestScope.bd.ks }</span>
			</td>
		  </tr>
		  <tr style="border-bottom: #CAD9EA solid 1px;">
			<td align="right" style="width:15%;">
				对方过磅净重
			</td>
			<td style="width:30%;">
				<span>${requestScope.bd.dfgbjz }</span>
			</td>
			<td align="right" style="width:15%;">
				对方榜单照片
			</td>
			<td style="width:30%;">
				<span>${requestScope.bd.dfbdzp }</span>
			</td>
		  </tr>
		  <tr style="border-bottom: #CAD9EA solid 1px;">
			<td align="right" style="width:15%;">
				备注
			</td>
			<td style="width:30%;">
				<span>${requestScope.bd.bz }</span>
			</td>
			<td align="right" style="width:15%;">
				订单号
			</td>
			<td style="width:30%;">
				<span>${requestScope.dd.ddh }</span>
			</td>
		  </tr>
		  <tr style="border-bottom: #CAD9EA solid 1px;">
			<td align="right">
				编辑时间
			</td>
			<td>
				<span>${requestScope.dd.bjsj }</span>
			</td>
			<td align="right">
			</td>
			<td>
			</td>
		  </tr>
		</table>
	</div>
	<%@include file="foot.jsp"%>
</div>
</body>
</html>