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
<link rel="stylesheet" href="<%=basePath %>resource/css/vip/transfer/tcDetail.css"/>
<script type="text/javascript" src="<%=basePath %>resource/js/jquery-3.3.1.js"></script>
<script type="text/javascript">
var path='<%=basePath%>';
var id='${param.id}';
var openId='${param.openId}';
$(function(){
	var reputation=${requestScope.transferInfo.reputation };
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

function addTransferRecord(){
	location.href=path+"vip/goPage?page=transferAtr&id="+id+"&scId="+'${requestScope.transferInfo.id }'+"&kzOpenId="+'${requestScope.transferInfo.openId }'+"&zrzOpenId="+openId+"&shareMoney="+'${requestScope.transferInfo.shareMoney }';
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
		<span>${requestScope.transferInfo.shopName }</span>
	</div>
</div>
<img class="logo_img" alt="" src="${requestScope.transferInfo.logo }">
<div class="shopName_div">${requestScope.transferInfo.shopName }</div>
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
	<span class="shopAddress_span">${requestScope.transferInfo.shopAddress }</span>
</div>
<div class="state_div">
	<img class="state_img" alt="" src="<%=basePath%>resource/image/015.png">
	<span class="state_span">营业</span>
</div>
<div class="line_div"></div>
<div class="gxhykxx_div">
	共享会员卡信息
</div>
<div class="tcName_div">
	<img class="tcName_img" alt="" src="<%=basePath%>resource/image/014.png">
	<span class="tcName_span">会员卡名称：${requestScope.transferInfo.tcName }</span>
	<c:if test="${requestScope.transferInfo.tcType eq '1' }">
		<span class="consumeMoney_span">剩余金额：${requestScope.transferInfo.shareMoney }</span>
	</c:if>
	<c:if test="${requestScope.transferInfo.tcType eq '2' }">
		<span class="consumeCount_span">剩余次数：${requestScope.transferInfo.consumeCount }</span>
	</c:if>
	<div class="wyzr_div" onclick="addTransferRecord()">我要转让</div>
</div>
<div class="vipType_div">
	<img class="vipType_img" alt="" src="<%=basePath%>resource/image/015.png">
	<span class="vipType_span">
		会员卡类型：
		<c:if test="${requestScope.transferInfo.tcType eq '1' }">
			金额卡
		</c:if>
		<c:if test="${requestScope.transferInfo.tcType eq '2' }">
			次卡
		</c:if>
	</span>
</div>
<div class="vipPrice_div">
	<img class="vipPrice_img" alt="" src="<%=basePath%>resource/image/015.png">
	<span class="vipPrice_span">会员卡价格：${requestScope.transferInfo.shareMoney }</span>
</div>
<c:if test="${requestScope.transferInfo.discount ne null }">
<div class="discPrice_div">
	<img class="discPrice_img" alt="" src="<%=basePath%>resource/image/015.png">
	<span class="discPrice_span">会员卡折扣：${requestScope.transferInfo.discount }</span>
</div>
</c:if>
<div class="line_div"></div>
<div class="describe_div">会员服务描述：${requestScope.transferInfo.describe }</div>
</body>
</html>