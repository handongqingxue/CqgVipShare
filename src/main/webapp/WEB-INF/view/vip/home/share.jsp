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
<link rel="stylesheet" href="<%=basePath %>resource/css/vip/home/share.css"/>
<script type="text/javascript" src="<%=basePath %>resource/js/jquery-3.3.1.js"></script>
<script type="text/javascript">
var path='<%=basePath%>';
var id='${param.id}';
var openId='${param.openId}';
var from='${param.from}';
$(function(){
	var reputation=${requestScope.shareInfo.reputation };
	if(reputation==1){
		$("#repu1_img").attr("src",path+"resource/image/star_yellow.png");
	}
	else if(reputation==2){
		$("#repu1_img").attr("src",path+"resource/image/star_yellow.png");
		$("#repu2_img").attr("src",path+"resource/image/star_yellow.png");
	}
	else if(reputation==3){
		$("#repu1_img").attr("src",path+"resource/image/star_yellow.png");
		$("#repu2_img").attr("src",path+"resource/image/star_yellow.png");
		$("#repu3_img").attr("src",path+"resource/image/star_yellow.png");
	}
	else if(reputation==4){
		$("#repu1_img").attr("src",path+"resource/image/star_yellow.png");
		$("#repu2_img").attr("src",path+"resource/image/star_yellow.png");
		$("#repu3_img").attr("src",path+"resource/image/star_yellow.png");
		$("#repu4_img").attr("src",path+"resource/image/star_yellow.png");
	}
	else if(reputation==5){
		$("#repu1_img").attr("src",path+"resource/image/star_yellow.png");
		$("#repu2_img").attr("src",path+"resource/image/star_yellow.png");
		$("#repu3_img").attr("src",path+"resource/image/star_yellow.png");
		$("#repu4_img").attr("src",path+"resource/image/star_yellow.png");
		$("#repu5_img").attr("src",path+"resource/image/star_yellow.png");
	}
});

function toAddShareRecord(){
	location.href=path+"vip/goPage?page=homeAsr&id="+id+"&vipId="+'${requestScope.shareInfo.id }'+"&kzOpenId="+'${requestScope.shareInfo.openId }'+"&fxzOpenId="+openId+"&shareMoney="+'${requestScope.shareInfo.shareMoney }'+"&from="+from;
}

function goBack(){
	var goPage;
	if(from=="index")
		goPage="homeIndex";
	else if(from=="vipList")
		goPage="homeVipList";
	location.href=path+"vip/goPage?page="+goPage+"&openId="+openId;
}
</script>
<title>分享</title>
</head>
<body>
<div class="top_div">
	<span>${requestScope.shareInfo.shopName }</span>
</div>
<div class="back_div">
	<span class="back_span" onclick="goBack()">&lt;返回</span>
	<span class="ruZhu_span">入驻</span>
</div>
<img class="logo_img" alt="" src="${requestScope.shareInfo.logo }">
<div class="shopName2_div">${requestScope.shareInfo.shopName }</div>
<div class="repuImg_div">
	<img class="repu1_img" id="repu1_img" alt="" src="<%=basePath%>resource/image/star_yellow.png">
	<img class="repu2_img" id="repu2_img" alt="" src="<%=basePath%>resource/image/star_yellow.png">
	<img class="repu3_img" id="repu3_img" alt="" src="<%=basePath%>resource/image/star_yellow.png">
	<img class="repu4_img" id="repu4_img" alt="" src="<%=basePath%>resource/image/star_yellow.png">
	<img class="repu5_img" id="repu5_img" alt="" src="<%=basePath%>resource/image/star_yellow.png">
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
	<span class="vipName_span">会员卡名称：${requestScope.shareInfo.svName }</span>
	<span class="consumeCount_span">剩余次数：${requestScope.shareInfo.consumeCount }</span>
	<div class="wyfx_div" onclick="toAddShareRecord()">我要分享</div>
</div>
<div class="vipType_div">
	<img class="vipType_img" alt="" src="<%=basePath%>resource/image/015.png">
	<span class="vipType_span">会员卡类型：</span>
</div>
<div class="vipPrice_div">
	<img class="vipPrice_img" alt="" src="<%=basePath%>resource/image/015.png">
	<span class="vipPrice_span">会员卡价格：${requestScope.shareInfo.shareMoney }</span>
</div>
<div class="line_div"></div>
<div class="describe_div">会员服务描述：${requestScope.shareInfo.describe }</div>
</body>
</html>