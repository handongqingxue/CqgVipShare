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
		title:"商家详情",
		width:setFitWidthInParent("body","detail_div"),
		height:500,
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
		$(this).css("height",(i==2?250:45)+"px");
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
		<input type="hidden" id="openId" name="openId" value="${requestScope.merchant.openId }"/>
		<table>
		  <tr style="border-bottom: #CAD9EA solid 1px;">
			<td align="right" style="width:15%;">
				商家名称
			</td>
			<td style="width:30%;">
				<span>${requestScope.merchant.shopName }</span>
			</td>
			<td align="right" style="width:15%;">
				商家地址
			</td>
			<td style="width:30%;">
				<span>${requestScope.merchant.shopAddress }</span>
			</td>
		  </tr>
		  <tr style="border-bottom: #CAD9EA solid 1px;">
			<td align="right" style="width:15%;">
				用户名
			</td>
			<td style="width:30%;">
				<span>${requestScope.merchant.userName }</span>
			</td>
			<td align="right" style="width:15%;">
				行业
			</td>
			<td style="width:30%;">
				<span>${requestScope.merchant.tradeName }</span>
			</td>
		  </tr>
		  <tr style="border-bottom: #CAD9EA solid 1px;">
			<td align="right" style="width:15%;">
				商家logo
			</td>
			<td style="width:30%;">
				<img style="width: 200px;height:200px;" src="${requestScope.merchant.logo }"/>
			</td>
			<td align="right" style="width:15%;">
				营业执照
			</td>
			<td style="width:30%;">
				<img style="width: 200px;height:200px;" src="${requestScope.merchant.yyzzImgUrl }"/>
			</td>
		  </tr>
		  <tr style="border-bottom: #CAD9EA solid 1px;">
			<td align="right" style="width:15%;">
				创建时间
			</td>
			<td style="width:30%;">
				<span>${requestScope.merchant.createTime }</span>
			</td>
			<td align="right" style="width:15%;">
				状态
			</td>
			<td style="width:30%;">
				<span>
					<c:if test="${requestScope.merchant.shopCheck eq 0 }">待审核</c:if>
					<c:if test="${requestScope.merchant.shopCheck eq 2 }">未通过</c:if>
				</span>
			</td>
		  </tr>
		</table>
	</div>
	<%@include file="foot.jsp"%>
</div>
</body>
</html>