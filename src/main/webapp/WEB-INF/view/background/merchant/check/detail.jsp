<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>商家详情</title>
<%@include file="../../js.jsp"%>
<style type="text/css">
.center_con_div{
	width: 100%;
	height: 90vh;
	margin-left:205px;
	overflow-y: scroll;
	position: absolute;
}
.page_location_div{
	height: 50px;
	line-height: 50px;
	margin-left: 20px;
	font-size: 18px;
}

.sjsh_bg_div{
	width: 100%;
	height: 100%;
	background-color: rgba(0,0,0,.45);
	position: fixed;
	z-index: 9016;
	display:none;
}
.sjsh_div{
	width: 500px;
	height: 550px;
	margin: 100px auto 0;
	background-color: #fff;
	border-radius:5px;
	position: absolute;
	left: 0;
	right: 0;
}
.sjsh_div .title_div{
	width: 100%;
	height: 50px;
	line-height: 50px;
	border-bottom: #eee solid 1px;
}
.sjsh_div .title_span{
	margin-left: 30px;
}
.sjsh_div .close_span{
	float: right;margin-right: 30px;cursor: pointer;
}
.sjsh_dialog_div{
	width: 500px;
	height: 500px;
	position: absolute;
}
.sjsh_div .localtion_div{
	width: 100%;height: 50px;line-height: 50px;
}
.sjsh_div .localtion_span{
	margin-left: 30px;
}
</style>
<script type="text/javascript">
var path='<%=basePath %>';
var merchantPath='<%=basePath%>'+"background/merchant/";
var shopId='${requestScope.merchant.id }';
var dialogTop=10;
var dialogLeft=20;
var edNum=0;
var sjshjbsxzdNum=1;
$(function(){
	initDetailDialog();
	initSJSHJBSXZDialog();//审核不通过窗口

	initDialogPosition();//将不同窗体移动到主要内容区域
});

function initDialogPosition(){
	//基本属性组
	var edpw=$("body").find(".panel.window").eq(edNum);
	var edws=$("body").find(".window-shadow").eq(edNum);

	//修改运输商
	var eyssjbsxdpw=$("body").find(".panel.window").eq(sjshjbsxzdNum);
	var eyssjbsxdws=$("body").find(".window-shadow").eq(sjshjbsxzdNum);

	var ccDiv=$("#center_con_div");
	ccDiv.append(edpw);
	ccDiv.append(edws);

	var eyssdDiv=$("#sjsh_dialog_div");
	eyssdDiv.append(eyssjbsxdpw);
	eyssdDiv.append(eyssjbsxdws);
}

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
        	   checkByShopId(1,shopId);
           }},
           {text:"审核不通过",id:"cancel_but",iconCls:"icon-cancel",handler:function(){
        	   openEditYSSDialog(1);
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

function initSJSHJBSXZDialog(){
	editYSSDialog=$("#sjsh_jbsxz_dialog_div").dialog({
		title:"审核不通过",
		width:setFitWidthInParent("#sjsh_div","sjsh_jbsxz_dialog_div"),
		height:410,
		top:10,
		left:20,
		buttons:[
           {text:"取消",id:"cancel_but",iconCls:"icon-cancel",handler:function(){
        	   openEditYSSDialog(0);
           }},
           {text:"提交",id:"ok_but",iconCls:"icon-ok",handler:function(){
        	   checkByShopId(2,shopId);
           }}
        ]
	});
	
	$(".panel.window").eq(sjshjbsxzdNum).css("margin-top","40px");
	$(".panel.window .panel-title").eq(sjshjbsxzdNum).css("color","#000");
	$(".panel.window .panel-title").eq(sjshjbsxzdNum).css("font-size","15px");
	$(".panel.window .panel-title").eq(sjshjbsxzdNum).css("padding-left","10px");
	
	$(".panel-header, .panel-body").eq(sjshjbsxzdNum).css("border-color","#ddd");
	
	//以下的是表格下面的面板
	$(".window-shadow").eq(sjshjbsxzdNum).css("margin-top","40px");
	$(".window,.window .window-body").eq(sjshjbsxzdNum).css("border-color","#ddd");

	$("#sjsh_jbsxz_dialog_div #cancel_but").css("left","20%");
	$("#sjsh_jbsxz_dialog_div #cancel_but").css("position","absolute");

	$("#sjsh_jbsxz_dialog_div #ok_but").css("left","50%");
	$("#sjsh_jbsxz_dialog_div #ok_but").css("position","absolute");
	$(".dialog-button").css("background-color","#fff");
	$(".dialog-button .l-btn-text").css("font-size","20px");
	//openEditYSSJBSXZDialog(0);
}

function openEditYSSDialog(flag){
	if(flag==1){
		$("#sjsh_bg_div").css("display","block");
	}
	else{
		$("#sjsh_bg_div").css("display","none");
	}
	openEditYSSJBSXZDialog(flag);
}

function openEditYSSJBSXZDialog(flag){
	if(flag==1){
		editYSSDialog.dialog("open");
	}
	else{
		editYSSDialog.dialog("close");
	}
}

function checkByShopId(shopCheck,shopId){
	var content;
	if(shopCheck==2){
		content=$("#content").val();
	}
	$.post(merchantPath+"checkShopById",
		{shopCheck:shopCheck,content:content,shopId:shopId},
		function(data){
			if(data.status=="ok"){
				alert(data.message);
				location.href=merchantPath+"check/list";
			}
			else{
				alert(data.message);
			}
		}
	,"json");
}

function setFitWidthInParent(parent,self){
	var space=0;
	switch (self) {
	case "detail_div":
	case "sjsh_div":
		space=340;
		break;
	case "detail_div_table":
	case "panel_window":
		space=355;
		break;
	case "sjsh_jbsxz_dialog_div":
		space=50;
		break;
	}
	var width=$(parent).css("width");
	return width.substring(0,width.length-2)-space;
}
</script>
</head>
<body>
<div class="layui-layout layui-layout-admin">	
	<!-- 审核不通过 start -->
	<div class="sjsh_bg_div" id="sjsh_bg_div">
		<div class="sjsh_div" id="sjsh_div">
			<div class="title_div">
				<span class="title_span">审核商家</span>
				<span class="close_span" onclick="openEditYSSDialog(0)">X</span>
			</div>
			<div class="sjsh_dialog_div" id="sjsh_dialog_div">
				<div class="localtion_div">
					<span class="localtion_span">商家审核-商家详情-审核</span>
				</div>
				<div id="sjsh_jbsxz_dialog_div">
					<!-- 
					<table>
					  <tr style="border-bottom: #CAD9EA solid 1px;">
						<td align="right" style="width:15%;">
							名称
						</td>
						<td style="width:30%;">
							<input type="text" id="mc" placeholder="请输入名称" style="width: 150px;height:30px;"/>
						</td>
						<td align="right" style="width:15%;">
							编辑时间
						</td>
						<td style="width:30%;">
							<span id="bjsj"></span>
						</td>
					  </tr>
					</table>
					 -->
					 <div style="height:50px;line-height:50px;margin-left: 20px;">不通过原因</div>
					<textarea rows="5" cols="10" id="content" style="width: 380px;height:225px;margin-left: 20px;font-size:15px;"></textarea>
				</div>
			</div>
		</div>
	</div>

	<%@include file="../../side.jsp"%>
	<div class="center_con_div" id="center_con_div">
		<div class="page_location_div">商家详情</div>
		
		<div id="detail_div">
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
		<%@include file="../../foot.jsp"%>
	</div>
</div>
</body>
</html>