<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%
	String basePath=request.getScheme()+"://"+request.getServerName()+":"
	+request.getServerPort()+request.getContextPath()+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
<link rel="stylesheet" href="<%=basePath %>resource/css/vip/handle/treaty.css"/>
<script type="text/javascript" src="<%=basePath %>resource/js/jquery-3.3.1.js"></script>
<script type="text/javascript">
var path='<%=basePath %>';
var openId='${param.openId}';
var shopId='${requestScope.pageValue.shopId}';
var logo='${requestScope.pageValue.logo}';
var shopName='${requestScope.pageValue.shopName}';
var shopAddress='${requestScope.pageValue.shopAddress}';
var mcId='${requestScope.pageValue.mcId}';
var money='${requestScope.pageValue.money}';
var tradeId='${requestScope.pageValue.tradeId}';
var tradeName='${requestScope.pageValue.tradeName}';
var from='${requestScope.pageValue.from}';
var prePage='${requestScope.pageValue.prePage}';
var action='${requestScope.pageValue.action}';
$(function(){
	addScrollListener();
});

function addScrollListener(){
	var bh=$("body").height();
	var wh = $(window).height(); //页面可视化区域高度 
	if(bh>wh){
		$(window).scroll(function(){ 
			var h=$(document.body).height();//网页文档的高度 
			var c = $(document).scrollTop();//滚动条距离网页顶部的高度 
			if (Math.ceil(wh+c)>=h){ 
				showAgreeBut(1);
			}
			else{
				showAgreeBut(0);
			}
		})
	}
	else{
		showAgreeBut(1);
	}
}

function showAgreeBut(show){
	if(show==1){
		$("#wtyBut_div").css("display","none");
		$("#tybgmBut_div").css("display","block");
	}
	else{
		$("#wtyBut_div").css("display","block");
		$("#tybgmBut_div").css("display","none");
	}
}

function toAddHandleRecord(){
	location.href=path+"vip/goPage?page=handleAhr&openId="+openId;
}

function goBack(){
	location.href=path+"vip/goPage?page=handleMcl&openId="+openId;
}
</script>
<title>购买须知</title>
</head>
<body>
<div class="top_div">
	<span>购买协议</span>
</div>
<div class="back_div">
	<span class="back_span" onclick="goBack()">&lt;返回</span>
</div>
<div class="hyxx_div">
	<div class="title_div">会员信息</div>
	<div class="content_div">${requestScope.merchantCard.describe }</div>
</div>
<div class="gmxz_div">
	<div class="title_div">购买须知</div>
	<div class="content_div">${requestScope.merchantCard.gmxz }</div>
</div>
<div class="space_div"></div>
<div class="bottom_div">
	<span class="moneySign_span">￥</span>
	<span class="money_span">${requestScope.merchantCard.money }</span>
	<div class="wtyBut_div" id="wtyBut_div">同意并购买</div>
	<div class="tybgmBut_div" id="tybgmBut_div" onclick="toAddHandleRecord()">同意并购买</div>
</div>
</body>
</html>