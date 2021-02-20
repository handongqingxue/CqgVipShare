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
	<span>${requestScope.transferInfo.shopName }</span>
</div>
<div class="back_div">
	<span class="back_span" onclick="goBack()">&lt;返回</span>
</div>
<div class="logo_div">
	<img class="logo_img" alt="" src="${requestScope.transferInfo.logo }">
</div>
<div class="row_div shopName_div">${requestScope.transferInfo.shopName }</div>
<div class="repuImg_div">
	<img class="repu1_img" id="repu1_img" alt="" src="<%=basePath%>resource/image/star_yellow.png">
	<img class="repu2_img" id="repu2_img" alt="" src="<%=basePath%>resource/image/star_yellow.png">
	<img class="repu3_img" id="repu3_img" alt="" src="<%=basePath%>resource/image/star_yellow.png">
	<img class="repu4_img" id="repu4_img" alt="" src="<%=basePath%>resource/image/star_yellow.png">
	<img class="repu5_img" id="repu5_img" alt="" src="<%=basePath%>resource/image/star_yellow.png">
	<span class="score_span">5</span>
</div>
<div class="row_div state_div">
	<span>营业中</span><span class="openTime_span">周二至周日 09:00-21:00</span>
</div>
<div class="line_div"></div>
<div class="row_div shopAddress_div">
	${requestScope.transferInfo.shopAddress }
</div>
<div class="space_div"></div>

<div class="line_div"></div>
<div class="row_div gxhykxx_div">
	共享会员卡信息
</div>
<div class="row_div tcName_div">
	<span class="tcName_span">${requestScope.transferInfo.tcName }</span>
</div>
<div class="row_div tcType_div">
	<span>
		<c:if test="${requestScope.transferInfo.tcType eq '1' }">
			金额卡
		</c:if>
		<c:if test="${requestScope.transferInfo.tcType eq '2' }">
			次卡
		</c:if>
	</span>
	<c:if test="${requestScope.transferInfo.discount ne null }">
		<span class="discPrice_span">${requestScope.transferInfo.discount }折</span>
	</c:if>
</div>
<div class="row_div tcType_div">
	<c:if test="${requestScope.shareInfo.tcType eq '1' }">
		<span>剩余金额：${requestScope.transferInfo.shareMoney }</span>
	</c:if>
	<c:if test="${requestScope.transferInfo.tcType eq '2' }">
		<span>￥${requestScope.transferInfo.shareMoney }/次</span>
		<span class="consumeCount_span">剩余${requestScope.transferInfo.consumeCount }次</span>
	</c:if>
	<div class="jszr_div" onclick="addTransferRecord()">接受转让</div>
</div>
<div class="line_div"></div>
<div class="describe_div">会员服务描述：${requestScope.transferInfo.describe }</div>
<div class="space_div"></div>
<div class="yhpj_div">
	<div class="tit_div">用户评价(0)</div>
</div>
</body>
</html>