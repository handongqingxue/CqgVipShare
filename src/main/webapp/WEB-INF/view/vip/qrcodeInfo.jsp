<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	String basePath=request.getScheme()+"://"+request.getServerName()+":"
	+request.getServerPort()+request.getContextPath()+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
<link rel="stylesheet" href="<%=basePath %>resource/css/vip/qrcodeInfo.css"/>
<script type="text/javascript" src="<%=basePath %>resource/js/jquery-3.3.1.js"></script>
<script type="text/javascript">
var uuid='${param.uuid}'
function confirm(action){
	var url;
	if(action=="share")
		url="confirmConsumeShare";
	else if(action=="handle")
		url="confirmHandleCard";
	$.post(url,
		{uuid:uuid},
		function(data){
			if(data.status=="ok"){
				alert(data.message);
				WeixinJSBridge.call('closeWindow');
			}
			else{
				alert(data.message);
			}
		}
	,"json");
}

function goBack(){
	WeixinJSBridge.call('closeWindow');
}
</script>
<title>Insert title here</title>
</head>
<body>
<div class="top_div">
	<span>二维码信息</span>
</div>
<div class="back_div">
	<span class="back_span" onclick="goBack()">&lt;返回</span>
</div>
<img class="logo_img" alt="" src="${requestScope.scMap.logo}">
<c:if test="${param.qrcType eq 'share' }">
	<div class="qrcodeInfo_div">
		<div class="svNo_div">
			<div class="tit_div">卡号</div>
			<div class="val_div">${requestScope.scMap.scNo }</div>
		</div>
		<div class="svName_div">
			<div class="tit_div">卡名</div>
			<div class="val_div">${requestScope.scMap.scName }</div>
		</div>
		<div class="shareMoney_div">
			<div class="tit_div">单次金额</div>
			<div class="val_div">${requestScope.scMap.shareMoney }</div>
		</div>
		<div class="phone_div">
			<div class="tit_div">卡主手机号</div>
			<div class="val_div">${requestScope.phone }</div>
		</div>
		<div class="nickName_div">
			<div class="tit_div">卡主昵称</div>
			<div class="val_div">${requestScope.nickName }</div>
		</div>
		<div class="ygxfDate_div">
			<div class="tit_div">预估消费日期</div>
			<div class="val_div">${requestScope.ygxfDate }</div>
		</div>
		<div class="describe_div">
			<div class="tit_div">会员服务描述</div>
			<div class="val_div">${requestScope.scMap.describe }</div>
		</div>
	</div>
	<div class="qrxfBut_div" onclick="confirm('share')">
		确认消费
	</div>
</c:if>
<c:if test="${param.qrcType eq 'handle' }">
	<div class="qrcodeInfo_div">
		<div class="mcName_div">
			<div class="tit_div">卡名</div>
			<div class="val_div">${requestScope.mcMap.mcName }</div>
		</div>
		<div class="money_div">
			<div class="tit_div">金额</div>
			<div class="val_div">${requestScope.mcMap.money }</div>
		</div>
		<div class="phone_div">
			<div class="tit_div">卡主手机号</div>
			<div class="val_div">${requestScope.phone }</div>
		</div>
		<div class="rn_div">
			<div class="tit_div">真实姓名</div>
			<div class="val_div">${requestScope.realName }</div>
		</div>
	</div>
	<div class="qrbkBut_div" onclick="confirm('handle')">
		确认办卡
	</div>
</c:if>
</body>
</html>