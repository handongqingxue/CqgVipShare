<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%
	String basePath=request.getScheme()+"://"+request.getServerName()+":"
	+request.getServerPort()+request.getContextPath()+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<link rel="stylesheet" href="<%=basePath %>/resource/css/vip/foot.css" />
<script type="text/javascript" src="<%=basePath %>resource/js/jquery-3.3.1.js"></script>
<script type="text/javascript">
var path='<%=basePath %>';
var openId='${param.openId}';
$(function(){
	var url=location.href;
	if(url.indexOf("page=homeIndex")>-1){
		$("#index_img").attr("src",path+"resource/image/002.png");
		$(".index_div .text_div").css("color","#0091FE");
		
		$("#add_img").attr("src",path+"resource/image/007.png");
		$(".add_div .text_div").css("color","#808080");
		
		$("#transfer_img").attr("src",path+"resource/image/005.png");
		$(".transfer_div .text_div").css("color","#808080");
		
		$("#mine_img").attr("src",path+"resource/image/009.png");
		$(".mine_div .text_div").css("color","#808080");
	}
	else if(url.indexOf("page=tradeList")>-1){
		$("#index_img").attr("src",path+"resource/image/003.png");
		$(".index_div .text_div").css("color","#808080");
		
		$("#add_img").attr("src",path+"resource/image/006.png");
		$(".add_div .text_div").css("color","#0091FE");
		
		$("#transfer_img").attr("src",path+"resource/image/005.png");
		$(".transfer_div .text_div").css("color","#808080");
		
		$("#mine_img").attr("src",path+"resource/image/009.png");
		$(".mine_div .text_div").css("color","#808080");
	}
	else if(url.indexOf("page=transferTcl")>-1){
		$("#index_img").attr("src",path+"resource/image/003.png");
		$(".index_div .text_div").css("color","#808080");
		
		$("#add_img").attr("src",path+"resource/image/007.png");
		$(".add_div .text_div").css("color","#808080");
		
		$("#transfer_img").attr("src",path+"resource/image/004.png");
		$(".transfer_div .text_div").css("color","#0091FE");
		
		$("#mine_img").attr("src",path+"resource/image/009.png");
		$(".mine_div .text_div").css("color","#808080");
	}
	else if(url.indexOf("page=mineInfo")>-1||url.indexOf("merchantExit")>-1){
		$("#index_img").attr("src",path+"resource/image/003.png");
		$(".index_div .text_div").css("color","#808080");
		
		$("#add_img").attr("src",path+"resource/image/007.png");
		$(".add_div .text_div").css("color","#808080");
		
		$("#transfer_img").attr("src",path+"resource/image/005.png");
		$(".transfer_div .text_div").css("color","#808080");
		
		$("#mine_img").attr("src",path+"resource/image/008.png");
		$(".mine_div .text_div").css("color","#0091FE");
	}
});

function goNav(flag){
	var urlParams;
	switch (flag) {
	case "index":
		urlParams="&page=homeIndex";
		location.href=path+"vip/goPage?openId="+openId+urlParams;
		break;
	case "transfer":
		urlParams="&page=transferTcl";
		location.href=path+"vip/goPage?openId="+openId+urlParams;
		break;
	case "handle":
		var postParams={from:'${param.page}',action:"handle",openId:openId};
		urlParams="&page=tradeList";
		updatePageValue(postParams,urlParams);
		break;
	case "mine":
		urlParams="&page=mineInfo";
		location.href=path+"vip/goPage?openId="+openId+urlParams;
		break;
	}
}

function updatePageValue(postParams,urlParams){
	$.post("updatePageValue",
		postParams,
		function(data){
			if(data.status=="ok")
				location.href=path+"vip/goPage?openId="+openId+urlParams;
		}
	,"json");
}
</script>
<div class="space_div"></div>
<div class="bottom_div">
	<div class="item index_div" onclick="goNav('index')">
		<img id="index_img" class="img_div"/>
		<div class="text_div">首页</div>
	</div>
	<div class="item add_div" onclick="goNav('handle')">
		<img id="add_img" class="img_div"/>
		<div class="text_div">办卡</div>
	</div>
	<div class="item transfer_div" onclick="goNav('transfer')">
		<img id="transfer_img" class="img_div"/>
		<div class="text_div">转让</div>
	</div>
	<div class="item mine_div" onclick="goNav('mine')">
		<img id="mine_img" class="img_div"/>
		<div class="text_div">我的</div>
	</div>
</div>