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
<link rel="stylesheet" href="<%=basePath %>resource/css/vip/mine/merchant/center.css"/>
<script type="text/javascript" src="<%=basePath %>resource/js/jquery-3.3.1.js"></script>
<title>商家中心</title>
<!--引用jQuery库-->
<!-- 
<script type="text/javascript" src="http://code.jquery.com/jquery-1.4.2.min.js"></script>
 -->
<script type="text/javascript">
var path='<%=basePath%>';
var openId='${param.openId}';
$(function(){
	merchantCheck();
});

function merchantCheck(){
	$.post("merchantCheck",
		{openId:openId},
		function(data){
			if(data.status=="no"){
			   alert(data.message);
			   //location.href=path+"vip/goPage?page=mineCenter&openId="+openId;
			}
			getMerchantInfo(data.merchant);
		}
	,"json");
}

function getMerchantInfo(merchant){
	$("#logo_img").attr("src",merchant.logo);
	$("#shopName_span").text(merchant.shopName);
	$("#shopAddress_div").text(merchant.shopAddress);
	$("#visitCount_span").text(merchant.visitCount);
}

function goChangeAccount(){
	var postParams={from:"merchant",openId:openId};
	var urlParams="&page=mineChangeAccount";
	updatePageValue(postParams,urlParams);
}

function goMerchantMgr(){
	location.href=path+"vip/goPage?page=mineMerchantMgr&openId="+openId;
}

function goCapMgr(){
	location.href=path+"vip/goPage?page=mineMerCfr&openId="+openId;
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

function goBack(){
	location.href=path+"vip/goPage?page=mineCenter&openId="+openId;
}

function exit(){
	location.href=path+"vip/merchantExit?openId="+openId;
}
</script>
</head>
<body>
<div class="top_div">
	<span>商家中心</span>
</div>
<div class="back_div">
	<span class="back_span" onclick="goBack()">&lt;返回</span>
</div>
<div class="shopInfo_div" id="shopInfo_div">
	<img class="logo_img" id="logo_img" alt="" src=""/>
	<span class="shopName_span" id="shopName_span"></span>
	<div class="shopAddress_div" id="shopAddress_div"></div>
</div>
<div class="but_div sjgl_div" onclick="goMerchantMgr()">
	<img class="txt_img" alt="" src="<%=basePath %>resource/image/022.png">
	<span class="txt_span">
		商家管理
	</span>
	<img class="goPage_img" alt="" src="<%=basePath %>resource/image/016.png">
</div>
<div class="but_div zjgl_div" onclick="goCapMgr()">
	<img class="txt_img" alt="" src="<%=basePath %>resource/image/022.png">
	<span class="txt_span">
		资金管理
	</span>
	<img class="goPage_img" alt="" src="<%=basePath %>resource/image/016.png">
</div>
<div class="but_div fwl_div">
	<img class="txt_img" alt="" src="<%=basePath %>resource/image/020.png">
	<span class="tit_span">
		访问量：
	</span>
	<span class="val_span" id="visitCount_span"></span>
</div>
<div class="but_div qhzh_div" onclick="goChangeAccount()">
	<img class="txt_img" alt="" src="<%=basePath %>resource/image/022.png">
	<span class="txt_span">
		切换账号
	</span>
	<img class="goPage_img" alt="" src="<%=basePath %>resource/image/016.png">
</div>
<div class="but_div exit_div" onclick="exit()">
	<img class="txt_img" alt="" src="<%=basePath %>resource/image/022.png">
	<span class="txt_span">
		退出商家
	</span>
</div>
</body>
</html>