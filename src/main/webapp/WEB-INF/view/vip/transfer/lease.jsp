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
<link rel="stylesheet" href="<%=basePath %>resource/css/vip/transfer/lease.css"/>
<script type="text/javascript" src="<%=basePath %>resource/js/jquery-3.3.1.js"></script>
<script type="text/javascript">
var path='<%=basePath%>';
var id='${param.id}';
var openId='${param.openId}';
$(function(){
	var reputation=${requestScope.leaseInfo.reputation };
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

function addLeaseRecord(){
	location.href=path+"vip/goPage?page=transferAlr&id="+id+"&scId="+'${requestScope.leaseInfo.id }'+"&kzOpenId="+'${requestScope.leaseInfo.openId }'+"&zrzOpenId="+openId+"&shareMoney="+'${requestScope.leaseInfo.shareMoney }';
}

function goBack(){
	location.href=path+"vip/goPage?page=transferTcl&openId="+openId;
}
</script>
<title>Insert title here</title>
</head>
<body>
<div class="top_div">
	<span class="back_span" onclick="goBack()">&lt;返回</span>
	<div class="topTit_div">
		<span>${requestScope.leaseInfo.shopName }</span>
	</div>
</div>
<img class="logo_img" alt="" src="${requestScope.leaseInfo.logo }">
<div class="shopName_div">${requestScope.leaseInfo.shopName }</div>
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
	<span class="shopAddress_span">${requestScope.leaseInfo.shopAddress }</span>
</div>
<div class="state_div">
	<img class="state_img" alt="" src="<%=basePath%>resource/image/015.png">
	<span class="state_span">营业</span>
</div>
<div class="line_div"></div>
<div class="gxhykxxTit_div">
	共享会员卡信息
</div>
<div class="gxhykxx_div">
	<img class="gxhykxx_img" alt="" src="<%=basePath%>resource/image/014.png">
	<span class="scName_span">会员卡名称：消费次卡</span>
	<span class="consumeCount_span">剩余次数：${requestScope.leaseInfo.consumeCount }</span>
	<div class="wyzl_div" onclick="addLeaseRecord()">我要租赁</div>
</div>
<div class="kzxyd_div">
	<img class="kzxyd_img" alt="" src="<%=basePath%>resource/image/015.png">
	<span class="kzxyd_span">卡主信誉度</span>
	<img class="repu1_img2" id="repu1_img2" alt="" src="<%=basePath%>resource/image/star_gray.png">
	<img class="repu2_img2" id="repu2_img2" alt="" src="<%=basePath%>resource/image/star_gray.png">
	<img class="repu3_img2" id="repu3_img2" alt="" src="<%=basePath%>resource/image/star_gray.png">
	<img class="repu4_img2" id="repu4_img2" alt="" src="<%=basePath%>resource/image/star_gray.png">
	<img class="repu5_img2" id="repu5_img2" alt="" src="<%=basePath%>resource/image/star_gray.png">
	<span class="score_span">5分</span>
</div>
<div class="line_div"></div>
<div class="describe_div">会员服务描述：${requestScope.leaseInfo.describe }</div>
</body>
</html>