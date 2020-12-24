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
<link rel="stylesheet" href="<%=basePath %>resource/css/vip/share.css"/>
<script type="text/javascript" src="<%=basePath %>resource/js/jquery-3.3.1.js"></script>
<script type="text/javascript">
var path='<%=basePath%>';
var id='${param.id}';
var openId='${param.openId}';
$(function(){
	var reputation=${requestScope.shareInfo.reputation };
	if(reputation==1){
		$("#repu1_img1").attr("src",path+"resource/image/star_yellow.png");
		
		$("#repu1_img2").attr("src",path+"resource/image/star_yellow.png");
	}
	else if(reputation==2){
		$("#repu1_img1").attr("src",path+"resource/image/star_yellow.png");
		$("#repu2_img1").attr("src",path+"resource/image/star_yellow.png");
		
		$("#repu1_img2").attr("src",path+"resource/image/star_yellow.png");
		$("#repu2_img2").attr("src",path+"resource/image/star_yellow.png");
	}
	else if(reputation==3){
		$("#repu1_img1").attr("src",path+"resource/image/star_yellow.png");
		$("#repu2_img1").attr("src",path+"resource/image/star_yellow.png");
		$("#repu3_img1").attr("src",path+"resource/image/star_yellow.png");
		
		$("#repu1_img2").attr("src",path+"resource/image/star_yellow.png");
		$("#repu2_img2").attr("src",path+"resource/image/star_yellow.png");
		$("#repu3_img2").attr("src",path+"resource/image/star_yellow.png");
	}
	else if(reputation==4){
		$("#repu1_img1").attr("src",path+"resource/image/star_yellow.png");
		$("#repu2_img1").attr("src",path+"resource/image/star_yellow.png");
		$("#repu3_img1").attr("src",path+"resource/image/star_yellow.png");
		$("#repu4_img1").attr("src",path+"resource/image/star_yellow.png");
		
		$("#repu1_img2").attr("src",path+"resource/image/star_yellow.png");
		$("#repu2_img2").attr("src",path+"resource/image/star_yellow.png");
		$("#repu3_img2").attr("src",path+"resource/image/star_yellow.png");
		$("#repu4_img2").attr("src",path+"resource/image/star_yellow.png");
	}
	else if(reputation==5){
		$("#repu1_img1").attr("src",path+"resource/image/star_yellow.png");
		$("#repu2_img1").attr("src",path+"resource/image/star_yellow.png");
		$("#repu3_img1").attr("src",path+"resource/image/star_yellow.png");
		$("#repu4_img1").attr("src",path+"resource/image/star_yellow.png");
		$("#repu5_img1").attr("src",path+"resource/image/star_yellow.png");
		
		$("#repu1_img2").attr("src",path+"resource/image/star_yellow.png");
		$("#repu2_img2").attr("src",path+"resource/image/star_yellow.png");
		$("#repu3_img2").attr("src",path+"resource/image/star_yellow.png");
		$("#repu4_img2").attr("src",path+"resource/image/star_yellow.png");
		$("#repu5_img2").attr("src",path+"resource/image/star_yellow.png");
	}
});

function toAddShareRecord(){
	location.href=path+"vip/toAddShareRecord?id="+id+"&vipId="+'${requestScope.shareInfo.id }'+"&kzOpenId="+'${requestScope.shareInfo.openId }'+"&fxzOpenId="+openId+"&shareMoney="+'${requestScope.shareInfo.shareMoney }';
}

function goBack(){
	location.href=path+"vip/toIndex?openId="+openId;
}
</script>
<title>分享</title>
</head>
<body>
<div class="top_div">
	<span class="back_span" onclick="goBack()">&lt;返回</span>
	<span class="ruZhu_span">入驻</span>
	<div class="shopName1_div">
		<span>${requestScope.shareInfo.shopName }</span>
	</div>
</div>
<img class="logo_img" alt="" src="${requestScope.shareInfo.logo }">
<div class="shopName2_div">${requestScope.shareInfo.shopName }</div>
<div class="repuImg1_div">
	<img class="repu1_img1" id="repu1_img1" alt="" src="<%=basePath%>resource/image/star_yellow.png">
	<img class="repu2_img1" id="repu2_img1" alt="" src="<%=basePath%>resource/image/star_yellow.png">
	<img class="repu3_img1" id="repu3_img1" alt="" src="<%=basePath%>resource/image/star_yellow.png">
	<img class="repu4_img1" id="repu4_img1" alt="" src="<%=basePath%>resource/image/star_yellow.png">
	<img class="repu5_img1" id="repu5_img1" alt="" src="<%=basePath%>resource/image/star_yellow.png">
	<span class="score_span">5分</span>
</div>
<div class="line_div"></div>
<div class="shopAddress_div">
	<img class="shopAddress_img" alt="" src="<%=basePath%>resource/image/014.png">
	<span class="shopAddress_span">${requestScope.shareInfo.shopAddress }</span>
</div>
<div class="state_div">
	<img class="state_img" alt="" src="<%=basePath%>resource/image/015.png">
	<span class="state_span">营业</span>
</div>
<div class="line_div"></div>
<div class="gxhykxx_div">
	共享会员卡信息
</div>
<div class="vipName_div">
	<img class="vipName_img" alt="" src="<%=basePath%>resource/image/014.png">
	<span class="vipName_span">会员卡名称：${requestScope.shareInfo.vipName }</span>
	<span class="consumeCount_span">剩余次数：${requestScope.shareInfo.consumeCount }</span>
	<div class="wyfx_div" onclick="toAddShareRecord()">我要分享</div>
</div>
<div class="repuImg2_div">
	<img class="repu_img" alt="" src="<%=basePath%>resource/image/015.png">
	<span class="repu_span">卡主信誉度</span>
	<img class="repu1_img2" id="repu1_img2" alt="" src="<%=basePath%>resource/image/star_gray.png">
	<img class="repu2_img2" id="repu2_img2" alt="" src="<%=basePath%>resource/image/star_gray.png">
	<img class="repu3_img2" id="repu3_img2" alt="" src="<%=basePath%>resource/image/star_gray.png">
	<img class="repu4_img2" id="repu4_img2" alt="" src="<%=basePath%>resource/image/star_gray.png">
	<img class="repu5_img2" id="repu5_img2" alt="" src="<%=basePath%>resource/image/star_gray.png">
	<span class="score_span">5分</span>
</div>
<div class="line_div"></div>
<div class="describe_div">会员服务描述：${requestScope.shareInfo.describe }</div>
</body>
</html>