<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%
	String basePath=request.getScheme()+"://"+request.getServerName()+":"
	+request.getServerPort()+request.getContextPath()+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<script type="text/javascript" src="<%=basePath %>resource/js/jquery-3.3.1.js"></script>
<script type="text/javascript">
var path='<%=basePath %>';
var openId='${param.openId}';
$(function(){
	var url=location.href;
	if(url.indexOf("toIndex")>-1){
		$("#index_img").attr("src",path+"resource/image/002.png");
		$(".index_div .text_div").css("color","#0091FE");
		
		$("#swk_img").attr("src",path+"resource/image/005.png");
		$(".swk_div .text_div").css("color","#808080");
		
		$("#fxk_img").attr("src",path+"resource/image/007.png");
		$(".fxk_div .text_div").css("color","#808080");
		
		$("#wd_img").attr("src",path+"resource/image/009.png");
		$(".wd_div .text_div").css("color","#808080");
	}
	else if(url.indexOf("toLeaseList")>-1){
		$("#index_img").attr("src",path+"resource/image/003.png");
		$(".index_div .text_div").css("color","#808080");
		
		$("#swk_img").attr("src",path+"resource/image/004.png");
		$(".swk_div .text_div").css("color","#0091FE");
		
		$("#fxk_img").attr("src",path+"resource/image/007.png");
		$(".fxk_div .text_div").css("color","#808080");
		
		$("#wd_img").attr("src",path+"resource/image/009.png");
		$(".wd_div .text_div").css("color","#808080");
	}
	else if(url.indexOf("toShareList")>-1){
		$("#index_img").attr("src",path+"resource/image/003.png");
		$(".index_div .text_div").css("color","#808080");
		
		$("#swk_img").attr("src",path+"resource/image/005.png");
		$(".swk_div .text_div").css("color","#808080");
		
		$("#fxk_img").attr("src",path+"resource/image/006.png");
		$(".fxk_div .text_div").css("color","#0091FE");
		
		$("#wd_img").attr("src",path+"resource/image/009.png");
		$(".wd_div .text_div").css("color","#808080");
	}
	else if(url.indexOf("toMine")>-1){
		$("#index_img").attr("src",path+"resource/image/003.png");
		$(".index_div .text_div").css("color","#808080");
		
		$("#swk_img").attr("src",path+"resource/image/005.png");
		$(".swk_div .text_div").css("color","#808080");
		
		$("#fxk_img").attr("src",path+"resource/image/007.png");
		$(".fxk_div .text_div").css("color","#808080");
		
		$("#wd_img").attr("src",path+"resource/image/008.png");
		$(".wd_div .text_div").css("color","#0091FE");
	}
});

function goNav(flag){
	var url;
	switch (flag) {
	case 1:
		url="toIndex?openId="+openId;
		break;
	case 2:
		url="toLeaseList?openId="+openId;
		break;
	case 3:
		url="toShareList?openId="+openId;
		break;
	case 4:
		url="toMine?openId="+openId;
		break;
	}
	location.href=path+"vip/"+url;
}
</script>
<link rel="stylesheet" href="<%=basePath %>/resource/css/vip/foot.css" />
<div class="bottom_div">
	<div class="item index_div" onclick="goNav(1)">
		<img id="index_img" class="img_div"/>
		<div class="text_div">首页</div>
	</div>
	<div class="item swk_div" onclick="goNav(2)">
		<img id="swk_img" class="img_div"/>
		<div class="text_div">租实物卡</div>
	</div>
	<div class="item fxk_div" onclick="goNav(3)">
		<img id="fxk_img" class="img_div"/>
		<div class="text_div">分享单</div>
	</div>
	<div class="item wd_div" onclick="goNav(4)">
		<img id="wd_img" class="img_div"/>
		<div class="text_div">我的</div>
	</div>
</div>