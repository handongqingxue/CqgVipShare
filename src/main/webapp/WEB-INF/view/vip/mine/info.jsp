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
<link rel="stylesheet" href="<%=basePath %>resource/css/vip/mine/info.css"/>
<script type="text/javascript" src="<%=basePath %>resource/js/jquery-3.3.1.js"></script>
<script type="text/javascript">
var path='<%=basePath %>';
var openId='${param.openId}';
$(function(){
	$.post("queryVipFromDB",
		{openId:openId},
		function(data){
			var vip=data.vip;
			var nickNameSpan=$("#nickName_span");
			nickNameSpan.text("昵称："+vip.nickName);
			$("#headImgUrl_img").attr("src",vip.headImgUrl);
			
			var qmValDiv=$("#qmVal_div");
			qmValDiv.text(vip.signTxt);

			$("#sscVal_span").text(vip.sumShareCount);
			$("#ssmVal_span").text(vip.sumShareMoney);
			//$("#alpnVal_span").text(vip.alipayNo);
			//$("#rnVal_span").text(vip.realName);
			//$("#wdmVal_span").text(vip.withDrawMoney);
			var reputation=vip.reputation;
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
		}
	,"json");
});

function goHandleList(type){
	var postParams={type:type,openId:openId};
	var urlParams="&page=mineHandleList";
	updatePageValue(postParams,urlParams);
}

function goShareList(type){
	var postParams={type:type,openId:openId};
	var urlParams="&page=mineShareList";
	updatePageValue(postParams,urlParams);
}

function goMySubmit(){
	location.href=path+"vip/goPage?page=mySubmitMenu&openId="+openId;
}

function goPage(page){
	var goPage;
	var postParams;
	var urlParams="";
	if(page=="mineChangeAccount"){
		postParams={from:"vip",openId:openId};
		var urlParams="&page="+page;
		updatePageValue(postParams,urlParams);
	}
	else{
		location.href=path+"vip/goPage?page="+page+"&openId="+openId;
	}
}

function editSignTxt(flag){
	var signTxt;
	if(flag){
		var qmValDiv=$("#qmVal_div");
		signTxt=qmValDiv.text();
		qmValDiv.replaceWith("<textarea class=\"qmVal_ta\" id=\"qmVal_ta\" onblur=\"editSignTxt(false)\">"+signTxt+"</textarea>");
		$("#qmVal_ta").focus();
	}
	else{
		var qmValTa=$("#qmVal_ta");
		signTxt=qmValTa.val();
		$.post("editVipSignTxt",
			{signTxt:signTxt,openId:openId},
			function(data){
				if(data.status=="ok"){
					qmValTa.replaceWith("<div class=\"qmVal_div\" id=\"qmVal_div\" onclick=\"editSignTxt(true)\">"+signTxt+"</div>");
				}
			}
		,"json");
	}
}

function getUrlParam(name){
	var reg = new RegExp("(^|&)"+ name +"=([^&]*)(&|$)"); //构造一个含有目标参数的正则表达式对象
	var r = window.location.search.substr(1).match(reg);  //匹配目标参数
	if (r!=null) return unescape(r[2]); return null; //返回参数值
} 
</script>
<title>我的</title>
</head>
<body>
<div class="personInfo_div" id="personInfo_div">
	<img class="headImgUrl_img" id="headImgUrl_img" alt="" src="">
	<span class="nickName_span" id="nickName_span"></span>
	<span class="qmTit_span">签名：</span>
	<div class="qmVal_div" id="qmVal_div" onclick="editSignTxt(true)"></div>
</div>
<div class="but_div newCard_s" onclick="goHandleList(1)">
	<img class="txt_img" alt="" src="<%=basePath %>resource/image/017.png">
	<span class="txt_span">
		我的新卡
	</span>
	<img class="goPage_img" alt="" src="<%=basePath %>resource/image/016.png">
</div>
<div class="but_div transferCard_s" onclick="goPage('mineTransferCard')">
	<img class="txt_img" alt="" src="<%=basePath %>resource/image/017.png">
	<span class="txt_span">
		我的转让卡
	</span>
	<img class="goPage_img" alt="" src="<%=basePath %>resource/image/016.png">
</div>
<div class="but_div wdfxd_s" onclick="goShareList(1)">
	<img class="txt_img" alt="" src="<%=basePath %>resource/image/018.png">
	<span class="txt_span">
		我支付的分享单
	</span>
	<img class="goPage_img" alt="" src="<%=basePath %>resource/image/016.png">
</div>
<div class="but_div" onclick="goMySubmit()">
	<img class="txt_img" alt="" src="<%=basePath %>resource/image/019.png">
	<span class="txt_span">
		我发布的分享单
	</span>
	<img class="goPage_img" alt="" src="<%=basePath %>resource/image/016.png">
</div>
<div class="but_div ssc_s">
	<img class="txt_img" alt="" src="<%=basePath %>resource/image/020.png">
	<span class="tit_span">
		累计分享次数：
	</span>
	<span class="val_span" id="sscVal_span"></span>
</div>
<div class="but_div">
	<img class="txt_img" alt="" src="<%=basePath %>resource/image/013.png">
	<span class="tit_span">
		累计分享金额：
	</span>
	<span class="val_span" id="ssmVal_span"></span>
</div>
<div class="but_div smallChange_s" onclick="goPage('mineSmallChange')">
	<img class="txt_img" alt="" src="<%=basePath %>resource/image/022.png">
	<span class="txt_span">
		零钱
	</span>
	<img class="goPage_img" alt="" src="<%=basePath %>resource/image/016.png">
</div>
<div class="but_div repu_div">
	<img class="txt_img" alt="" src="<%=basePath %>resource/image/023.png">
	<span class="tit_span">
		信誉度：
	</span>
	<div class="val_div repu_img_div">
		<img class="repu_img" id="repu_img1" alt="" src="<%=basePath%>resource/image/star_yellow.png">
		<img class="repu_img" id="repu_img1" alt="" src="<%=basePath%>resource/image/star_yellow.png">
		<img class="repu_img" id="repu_img1" alt="" src="<%=basePath%>resource/image/star_yellow.png">
		<img class="repu_img" id="repu_img1" alt="" src="<%=basePath%>resource/image/star_yellow.png">
		<img class="repu_img" id="repu_img1" alt="" src="<%=basePath%>resource/image/star_yellow.png">
	</div>
</div>
<!-- 
<div class="but_div" onclick="goPage('mineAlipay')">
	<span class="txt_span">
		支付宝
	</span>
	<span class="goPage_img">&gt;</span>
</div>
 -->
<div class="but_div qhzh_s" onclick="goPage('mineChangeAccount')">
	<img class="txt_img" alt="" src="<%=basePath %>resource/image/024.png">
	<span class="txt_span">
		切换账号
	</span>
	<img class="goPage_img" alt="" src="<%=basePath %>resource/image/016.png">
</div>
<jsp:include page="../foot.jsp"></jsp:include>
</body>
</html>