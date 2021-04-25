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
var uuid='${param.uuid}';
var discount='${requestScope.scMap.discount }';
var sfbfb='${requestScope.scMap.sfbfb }';
var deposit='${requestScope.scMap.minDeposit }';
var scType='${requestScope.scMap.scType}';
function confirm(action){
	var url;
	var params;
	if(action=="share"){
		var scType='${requestScope.scMap.scType}';
		var shopId='${requestScope.scMap.shopId}';
		switch (scType) {
		case "4":
			var xfje=$("#xfje").val();
			if(xfje==null||xfje==""){
				alert("请输入消费金额");
				return false;
			}
			var shareMoney=$("#shareMoney").text();
			if(shareMoney>deposit){
				alert("优惠价多于押金，请交"+(shareMoney-deposit)+"元现金");
			}
			url="confirmConsumeMoney";
			params={uuid:uuid,shareMoney:shareMoney};
			break;
		case "5":
			url="confirmConsumeShare";
			params={uuid:uuid,scType:scType,shopId:shopId};
			break;
		}
	}
	else if(action=="handle"){
		url="confirmHandleCard";
		params={uuid:uuid};
	}
	$.post(url,
		params,
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

function jiSuanYHJ(){
	var shareMoney;
	var yj=$("#xfje").val();
	if(xfje==null||xfje==""){
		alert("请输入消费金额");
		return false;
	}
	
	if(discount==null||discount=="")
		shareMoney=yj;
	else{
		var hyj=yj*discount/100;
		if(scType=="4")
			shareMoney=hyj;
		else if(scType=="5")
			shareMoney=hyj*(1+sfbfb/100);
	}
	$("#shareMoney").text(shareMoney);
}

function goBack(){
	WeixinJSBridge.call('closeWindow');
}
</script>
<title>二维码信息</title>
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
		<div class="attr_div">
			<div class="tit_div">卡号</div>
			<div class="val_div">${requestScope.scMap.scNo }</div>
		</div>
		<div class="attr_div">
			<div class="tit_div">卡名</div>
			<div class="val_div">${requestScope.scMap.scName }</div>
		</div>
		<c:if test="${requestScope.scMap.scType eq '4' }">
			<div class="attr_div">
				<div class="tit_div">
					消费金额
				</div>
				<div class="val_div">
					<input type="number" class="val_inp" id="xfje" placeholder="请输入消费金额" onblur="jiSuanYHJ()"/>
				</div>
			</div>
		</c:if>
		<c:if test="${requestScope.scMap.scType eq '5' }">
			<div class="attr_div">
				<div class="tit_div">
					原价
				</div>
				<div class="val_div">${requestScope.scMap.yj }</div>
			</div>
		</c:if>
		<div class="attr_div">
			<div class="tit_div">折扣</div>
			<div class="val_div">${requestScope.scMap.discount }</div>
		</div>
		<div class="attr_div">
			<div class="tit_div">会员价</div>
			<div class="val_div">${requestScope.scMap.hyj }</div>
		</div>
		<c:if test="${requestScope.scMap.scType eq '5' }">
			<div class="attr_div">
				<div class="tit_div">上浮(%)</div>
				<div class="val_div">${requestScope.scMap.sfbfb }</div>
			</div>
		</c:if>
		<c:if test="${requestScope.scMap.scType eq '4' }">
			<div class="attr_div">
				<div class="tit_div">优惠价</div>
				<div class="val_div">
					<span id="shareMoney"></span>
				</div>
			</div>
			<div class="attr_div">
				<div class="tit_div">押金</div>
				<div class="val_div">${requestScope.scMap.minDeposit }</div>
			</div>
		</c:if>
		<c:if test="${requestScope.scMap.scType eq '5' }">
			<div class="attr_div">
				<div class="tit_div">消费金额</div>
				<div class="val_div">${requestScope.scMap.shareMoney }</div>
			</div>
		</c:if>
		<div class="attr_div">
			<div class="tit_div">卡主手机号</div>
			<div class="val_div">${requestScope.phone }</div>
		</div>
		<div class="attr_div">
			<div class="tit_div">卡主昵称</div>
			<div class="val_div">${requestScope.nickName }</div>
		</div>
		<div class="attr_div">
			<div class="tit_div">预估消费日期</div>
			<div class="val_div">${requestScope.ygxfDate }</div>
		</div>
		<div class="attr_div">
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
		<div class="attr_div">
			<div class="tit_div">卡名</div>
			<div class="val_div">${requestScope.mcMap.mcName }</div>
		</div>
		<div class="attr_div">
			<div class="tit_div">金额</div>
			<div class="val_div">${requestScope.mcMap.money }</div>
		</div>
		<div class="attr_div">
			<div class="tit_div">卡主手机号</div>
			<div class="val_div">${requestScope.phone }</div>
		</div>
		<div class="attr_div">
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