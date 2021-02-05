<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
	location.href=path+"vip/goPage?page=homeAsr&id="+id+"&scId="+'${requestScope.shareInfo.id }'+"&kzOpenId="+'${requestScope.shareInfo.openId }'+"&fxzOpenId="+openId+"&shareMoney="+'${requestScope.shareInfo.shareMoney }'+"&scType="+'${requestScope.shareInfo.scType }'+"&from="+from;
}

function goBack(){
	var goPage;
	if(from=="index")
		goPage="homeIndex";
	else if(from=="vipList")
		goPage="homeScl";
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
</div>
<div style="width: 95%;margin: 5px auto; ">
	<img class="logo_img" alt="" src="${requestScope.shareInfo.logo }">
</div>
<div class="shopName_div">${requestScope.shareInfo.shopName }</div>
<div class="repuImg_div">
	<img class="repu1_img" id="repu1_img" alt="" src="<%=basePath%>resource/image/star_yellow.png">
	<img class="repu2_img" id="repu2_img" alt="" src="<%=basePath%>resource/image/star_yellow.png">
	<img class="repu3_img" id="repu3_img" alt="" src="<%=basePath%>resource/image/star_yellow.png">
	<img class="repu4_img" id="repu4_img" alt="" src="<%=basePath%>resource/image/star_yellow.png">
	<img class="repu5_img" id="repu5_img" alt="" src="<%=basePath%>resource/image/star_yellow.png">
	<span class="score_span">5</span>
</div>
<div class="state_div">
	<span>营业中</span><span class="openTime_span">周二至周日 09:00-21:00</span>
</div>
<div class="line_div"></div>
<div class="shopAddress_div">
	${requestScope.shareInfo.shopAddress }
</div>
<div class="space_div"></div>
<div class="gxhykxx_div" style="font-weight: bold;">
	共享会员卡信息
</div>
<div class="scName_div">
	<span class="scName_span">${requestScope.shareInfo.scName }</span>
</div>
<div class="consume_div" style="color: #FD6104;font-weight: bold;">
	<span>
		<c:if test="${requestScope.shareInfo.scType eq '1' }">
			金额卡
		</c:if>
		<c:if test="${requestScope.shareInfo.scType eq '2' }">
			次卡
		</c:if>
	</span>
	<c:if test="${requestScope.shareInfo.discount ne null }">
		<span class="discPrice_span" style="margin-left: 65px;">${requestScope.shareInfo.discount }折</span>
	</c:if>
</div>
<div class="consume_div" style="color: #FD6104;font-weight: bold;">
	<c:if test="${requestScope.shareInfo.scType eq '1' }">
		<span>剩余金额：${requestScope.shareInfo.shareMoney }</span>
	</c:if>
	<c:if test="${requestScope.shareInfo.scType eq '2' }">
		<span>￥${requestScope.shareInfo.shareMoney }/次</span>
		<span class="consumeCount_span">剩余${requestScope.shareInfo.consumeCount }次</span>
	</c:if>
</div>
<div class="endTime_div" style="color: #FD6104;">
	到期时间：2021-12-31
	<div class="wyfx_div" onclick="toAddShareRecord()">我要分享</div>
</div>
<div class="line_div"></div>
<div class="describe_div">简介：${requestScope.shareInfo.describe }</div>
<div class="space_div"></div>
<div style="width: 95%;margin: auto;">
	<div style="width: 100%;height: 40px;line-height: 40px;font-weight: bold;margin: auto;">用户评价(0)</div>
</div>
</body>
</html>