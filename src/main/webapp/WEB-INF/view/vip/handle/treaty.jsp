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
$(function(){
	changeMenu("hyxx");
});

function changeMenu(flag){
	$(".menu_div .item_div").removeClass("selected");
	$(".menu_div .item_div").addClass("unSelected");
	$(".content_div .item_div").css("display","none");
	
	if(flag=="hyxx"){
		$("#menu_div #hyxx_div").removeClass("unSelected");
		$("#menu_div #hyxx_div").addClass("selected");
		
		$("#content_div #hyxx_div").css("display","block");
	}
	else if(flag=="gmxz"){
		$("#menu_div #gmxz_div").removeClass("unSelected");
		$("#menu_div #gmxz_div").addClass("selected");
		
		$("#content_div #gmxz_div").css("display","block");
	}
}
</script>
<title>购买须知</title>
</head>
<body>
<div class="top_div">
	<span>购买须知</span>
</div>
<div class="back_div">
	<span class="back_span" onclick="goBack()">&lt;返回</span>
</div>
<div class="menu_div" id="menu_div">
	<div class="item_div" id="hyxx_div" onclick="changeMenu('hyxx')">会员信息</div>
	<div class="item_div gmxz_div" id="gmxz_div" onclick="changeMenu('gmxz')">购买须知</div>
</div>
<div class="content_div" id="content_div">
	<div class="item_div" id="hyxx_div">16周岁及60岁以上用户不能使用</div>
	<div class="item_div" id="gmxz_div">购买店铺会员。。。。</div>
</div>
<div class="bottom_div">
	<span class="moneySign_span">￥</span>
	<span class="money_span">0.01</span>
	<div class="wygmBut_div">我要购买</div>
</div>
</body>
</html>