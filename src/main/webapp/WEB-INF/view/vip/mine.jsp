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
<script type="text/javascript" src="<%=basePath %>resource/js/jquery-3.3.1.js"></script>
<script type="text/javascript">
var path='<%=basePath %>';
var openId='${param.openId}';
$(function(){
	$.post("queryUserFromDB",
		{openId:openId},
		function(data){
			var user=data.user;
			$("#nickName_span").text("昵称："+user.nickName);
			$("#headImgUrl_img").attr("src",user.headImgUrl);
			$("#sscVal_span").text(user.sumShareCount);
			$("#ssmVal_span").text(user.sumShareMoney);
			var reputation=user.reputation;
			if(reputation==1){
				$("#repu_img1").attr("src",path+"resource/image/star_yellow.png");
			}
			else if(reputation==2){
				$("#repu_img1").attr("src",path+"resource/image/star_yellow.png");
				$("#repu_img2").attr("src",path+"resource/image/star_yellow.png");
			}
			else if(reputation==3){
				$("#repu_img1").attr("src",path+"resource/image/star_yellow.png");
				$("#repu_img1").attr("src",path+"resource/image/star_yellow.png");
				$("#repu_img1").attr("src",path+"resource/image/star_yellow.png");
			}
			else if(reputation==4){
				$("#repu_img1").attr("src",path+"resource/image/star_yellow.png");
				$("#repu_img1").attr("src",path+"resource/image/star_yellow.png");
				$("#repu_img1").attr("src",path+"resource/image/star_yellow.png");
				$("#repu_img1").attr("src",path+"resource/image/star_yellow.png");
			}
			else if(reputation==5){
				$("#repu_img1").attr("src",path+"resource/image/star_yellow.png");
				$("#repu_img1").attr("src",path+"resource/image/star_yellow.png");
				$("#repu_img1").attr("src",path+"resource/image/star_yellow.png");
				$("#repu_img1").attr("src",path+"resource/image/star_yellow.png");
				$("#repu_img1").attr("src",path+"resource/image/star_yellow.png");
			}
			
			if(user.userType==1){
				$("#changeShop_div").css("display","block");
				$("#shopInfo_div").css("display","none");
			}
			else{
				$("#changeShop_div").css("display","none");
				$("#shopInfo_div").css("display","block");
				
				$("#logo_img").attr("src",user.logo);
				$("#shopName_span").text(user.shopName);
				$("#shopAddress_span").text(user.shopAddress);
				$("#visitCount_span").text(user.visitCount);
			}
		}
	,"json");
});

function goEditMerchant(){
	location.href=path+"vip/toEditMerchant?openId="+openId;
}

function goTradeList(){
	location.href=path+"vip/toTradeList?action=addLeaseVip&openId="+openId;
}

function goDelLeaseList(){
	location.href=path+"vip/toDelLeaseList?openId="+openId;
}

function getUrlParam(name){
	var reg = new RegExp("(^|&)"+ name +"=([^&]*)(&|$)"); //构造一个含有目标参数的正则表达式对象
	var r = window.location.search.substr(1).match(reg);  //匹配目标参数
	if (r!=null) return unescape(r[2]); return null; //返回参数值
} 
</script>
<title>我的</title>
<style>
.space_div{
	width: 100%;
	height:60px;
}
</style>
</head>
<body style="margin: 0px;background-color: #F6F6F6;">
<div style="width: 100%;height: 140px;background-color: #fff;">
	<span style="width: 200px;margin-top: 20px;margin-left: 20px;font-size: 20px;position: absolute;">个人信息</span>
	<span id="nickName_span" style="width: 200px;margin-top: 55px;margin-left: 20px;font-size: 20px;position: absolute;"></span>
	<span style="width: 200px;margin-top: 90px;margin-left: 20px;font-size: 20px;position: absolute;">签名：aaaaaaaa</span>
	<img id="headImgUrl_img" alt="" src="" style="width:100px;height:100px;float: right;margin-top: 20px;margin-right: 20px;">
</div>
<div id="shopInfo_div" style="height:390px;margin-top: 10px;font-size: 20px;background-color: #fff;">
	<div style="height:40px;line-height:40px;">
		<span style="margin-left: 20px;">商家信息</span>
	</div>
	<div style="height:200px;text-align: center;">
		<img id="logo_img" alt="" src="" style="width: 200px;height:200px;margin: 0 auto;"/>
	</div>
	<div style="height:50px;line-height:50px;">
		<span style="margin-left: 20px;">商家名称：</span>
		<span id="shopName_span" style="float: right;margin-right: 20px;"></span>
	</div>
	<div style="height:50px;line-height:50px;">
		<span style="margin-left: 20px;">商家地址：</span>
		<span id="shopAddress_span" style="float: right;margin-right: 20px;"></span>
	</div>
	<div style="height:50px;line-height:50px;">
		<span style="margin-left: 20px;">访问量：</span>
		<span id="visitCount_span" style="float: right;margin-right: 20px;"></span>
	</div>
</div>
<div style="height:50px;line-height:50px; margin-top: 10px;font-size: 20px;background-color: #fff;">
	<span style="margin-left: 20px;">
		累计分享次数：
	</span>
	<span id="sscVal_span" style="float: right;margin-right: 20px;"></span>
</div>
<div style="height:50px;line-height:50px; margin-top: 10px;font-size: 20px;background-color: #fff;">
	<span style="margin-left: 20px;">
		累计分享金额：
	</span>
	<span id="ssmVal_span" style="float: right;margin-right: 20px;"></span>
</div>
<div style="height:50px;line-height:50px; margin-top: 10px;font-size: 20px;background-color: #fff;">
	<span style="margin-left: 20px;">
		信誉度：
	</span>
	<div style="float: right;margin-right: 20px;">
		<img id="repu_img1" alt="" src="<%=basePath%>resource/image/star_yellow.png" style="width: 20px;height: 20px;">
		<img id="repu_img1" alt="" src="<%=basePath%>resource/image/star_yellow.png" style="width: 20px;height: 20px;">
		<img id="repu_img1" alt="" src="<%=basePath%>resource/image/star_yellow.png" style="width: 20px;height: 20px;">
		<img id="repu_img1" alt="" src="<%=basePath%>resource/image/star_yellow.png" style="width: 20px;height: 20px;">
		<img id="repu_img1" alt="" src="<%=basePath%>resource/image/star_yellow.png" style="width: 20px;height: 20px;">
	</div>
</div>
<div onclick="goTradeList()" style="width:95%;height:50px;line-height:50px;margin:0 auto; margin-top: 10px;text-align:center;color:#fff; font-size: 20px;background-color: #f00;border-radius:5px;">
	发布租赁卡信息
</div>
<div onclick="goDelLeaseList()" style="width:95%;height:50px;line-height:50px;margin:0 auto; margin-top: 10px;text-align:center;color:#fff; font-size: 20px;background-color: #f00;border-radius:5px;">
	删除租赁卡信息
</div>
<div id="changeShop_div" onclick="goEditMerchant()" style="width:95%;height:50px;line-height:50px;margin:0 auto; margin-top: 10px;text-align:center;color:#fff; font-size: 20px;background-color: #00f;border-radius:5px;display: none;">
	我要成为商家
</div>
<jsp:include page="foot.jsp"></jsp:include>
</body>
</html>