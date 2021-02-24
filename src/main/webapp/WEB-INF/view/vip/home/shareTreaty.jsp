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
<link rel="stylesheet" href="<%=basePath %>resource/css/vip/home/shareTreaty.css"/>
<script type="text/javascript" src="<%=basePath %>resource/js/jquery-3.3.1.js"></script>
<script type="text/javascript">
var path='<%=basePath %>';
var id='${param.id}';
var scId='${param.scId}';
var kzOpenId='${param.kzOpenId}';
var fxzOpenId='${param.fxzOpenId}';
var shopId='${param.shopId}';
var shareMoney='${param.shareMoney}';
var discount='${param.discount}';
var scType='${param.scType}';
var from='${param.from}';
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
		$("#wqrBut_div").css("display","none");
		$("#qrfxBut_div").css("display","block");
	}
	else{
		$("#wqrBut_div").css("display","block");
		$("#qrfxBut_div").css("display","none");
	}
}

function toAddShareRecord(){
	location.href=path+"vip/goPage?page=homeAsr&id="+id+"&scId="+scId+"&kzOpenId="+kzOpenId+"&fxzOpenId="+fxzOpenId+"&shareMoney="+shareMoney+"&discount="+discount+"&scType="+scType+"&from="+from;
}

function goBack(){
	location.href=path+"vip/goPage?page=homeShare&id="+id+"&shopId="+shopId+"&openId="+fxzOpenId+"&from="+from;
}
</script>
<title>Insert title here</title>
</head>
<body>
<div class="top_div">
	<span>分享协议</span>
</div>
<div class="back_div">
	<span class="back_span" onclick="goBack()">&lt;返回</span>
</div>
<div class="fxxz_div">
	<div class="title_div">分享须知</div>
	<div class="content_div">
		我都不惜说你了我都不惜说你了我都不惜说你了我都不惜说你了我都不惜说你了我都不惜说你了我都不惜说你了我都不惜说你了我都不惜说你了我都不惜说你了我都不惜说你了我都不惜说你了
		我都不惜说你了我都不惜说你了我都不惜说你了我都不惜说你了我都不惜说你了我都不惜说你了我都不惜说你了我都不惜说你了我都不惜说你了我都不惜说你了我都不惜说你了我都不惜说你了
		我都不惜说你了我都不惜说你了我都不惜说你了我都不惜说你了我都不惜说你了我都不惜说你了我都不惜说你了我都不惜说你了我都不惜说你了我都不惜说你了我都不惜说你了我都不惜说你了
		我都不惜说你了我都不惜说你了我都不惜说你了我都不惜说你了我都不惜说你了我都不惜说你了我都不惜说你了我都不惜说你了我都不惜说你了我都不惜说你了我都不惜说你了我都不惜说你了
		我都不惜说你了我都不惜说你了我都不惜说你了我都不惜说你了我都不惜说你了我都不惜说你了我都不惜说你了我都不惜说你了我都不惜说你了我都不惜说你了我都不惜说你了我都不惜说你了
		我都不惜说你了我都不惜说你了我都不惜说你了我都不惜说你了我都不惜说你了我都不惜说你了我都不惜说你了我都不惜说你了我都不惜说你了我都不惜说你了我都不惜说你了我都不惜说你了
		我都不惜说你了我都不惜说你了我都不惜说你了我都不惜说你了我都不惜说你了我都不惜说你了我都不惜说你了我都不惜说你了我都不惜说你了我都不惜说你了我都不惜说你了我都不惜说你了
		我都不惜说你了我都不惜说你了我都不惜说你了我都不惜说你了我都不惜说你了我都不惜说你了我都不惜说你了我都不惜说你了我都不惜说你了我都不惜说你了我都不惜说你了我都不惜说你了
		我都不惜说你了我都不惜说你了我都不惜说你了我都不惜说你了我都不惜说你了我都不惜说你了我都不惜说你了我都不惜说你了我都不惜说你了我都不惜说你了我都不惜说你了我都不惜说你了
		我都不惜说你了我都不惜说你了我都不惜说你了我都不惜说你了我都不惜说你了我都不惜说你了我都不惜说你了我都不惜说你了我都不惜说你了我都不惜说你了我都不惜说你了我都不惜说你了
		我都不惜说你了我都不惜说你了我都不惜说你了我都不惜说你了我都不惜说你了我都不惜说你了我都不惜说你了我都不惜说你了我都不惜说你了我都不惜说你了我都不惜说你了我都不惜说你了
		我都不惜说你了我都不惜说你了我都不惜说你了我都不惜说你了我都不惜说你了我都不惜说你了我都不惜说你了我都不惜说你了我都不惜说你了我都不惜说你了我都不惜说你了我都不惜说你了
		我都不惜说你了我都不惜说你了我都不惜说你了我都不惜说你了我都不惜说你了我都不惜说你了我都不惜说你了我都不惜说你了我都不惜说你了我都不惜说你了我都不惜说你了我都不惜说你了
		我都不惜说你了我都不惜说你了我都不惜说你了我都不惜说你了我都不惜说你了我都不惜说你了我都不惜说你了我都不惜说你了我都不惜说你了我都不惜说你了我都不惜说你了我都不惜说你了
		我都不惜说你了我都不惜说你了我都不惜说你了我都不惜说你了我都不惜说你了我都不惜说你了我都不惜说你了我都不惜说你了我都不惜说你了我都不惜说你了我都不惜说你了我都不惜说你了
		我都不惜说你了我都不惜说你了我都不惜说你了我都不惜说你了我都不惜说你了我都不惜说你了我都不惜说你了我都不惜说你了我都不惜说你了我都不惜说你了我都不惜说你了我都不惜说你了
		我都不惜说你了我都不惜说你了我都不惜说你了我都不惜说你了我都不惜说你了我都不惜说你了我都不惜说你了我都不惜说你了我都不惜说你了我都不惜说你了我都不惜说你了我都不惜说你了
		我都不惜说你了我都不惜说你了我都不惜说你了我都不惜说你了我都不惜说你了我都不惜说你了我都不惜说你了我都不惜说你了我都不惜说你了我都不惜说你了我都不惜说你了我都不惜说你了
	</div>
</div>
<div class="space_div"></div>
<div class="bottom_div">
	<span class="moneySign_span">￥</span>
	<span class="money_span">0.01</span>
	<div class="wqrBut_div" id="wqrBut_div">确认分享</div>
	<div class="qrfxBut_div" id="qrfxBut_div" onclick="toAddShareRecord()">确认分享</div>
</div>
</body>
</html>