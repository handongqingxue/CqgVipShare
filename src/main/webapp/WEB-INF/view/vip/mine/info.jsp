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
			
			var marginTop=0;
			var nnsh=nickNameSpan.css("height");
			nnsh=parseInt(nnsh.substring(0,nnsh.length-2));
			marginTop+=64+nnsh;
			var qmSpan=$("#qm_span");
			qmSpan.text("签名：青岛华凌科技有限公司");
			qmSpan.css("margin-top",marginTop+"px");

			var qmsh=qmSpan.css("height");
			qmsh=parseInt(qmsh.substring(0,qmsh.length-2));
			marginTop+=13+qmsh;
			var piDiv=$("#personInfo_div");
			piDiv.css("height",marginTop+"px");
			
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

function goShareList(type){
	location.href=path+"vip/goPage?page=mineShareList&type="+type+"&openId="+openId;
}

function goMySubmit(type){
	var url="";
	var params="";
	switch(type){
		case 1:
			url="goPage?page=mineMscl&openId="+openId;
			break;
		case 4:
			params="&from=mineInfo&action=addShareCard";
			url="goPage?page=tradeList&openId="+openId+params;
			break;
	}
	location.href=path+"vip/"+url;
}

function goPage(page){
	var goPage;
	var params="";
	if(page=="mineChangeAccount"){
		params="&from=vip";
	}
	location.href=path+"vip/goPage?page="+page+"&openId="+openId+params;
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
	<span class="grxx_span">个人信息</span>
	<span class="nickName_span" id="nickName_span"></span>
	<span class="qm_span" id="qm_span"></span>
	<img class="headImgUrl_img" id="headImgUrl_img" alt="" src="">
</div>
<div class="wdfxd_div">
	<div class="wdfxdTit_div">
		<span class="wdfxdTit_span">我的分享单</span>
		<span class="ckqbfxd_span" onclick="goShareList(1)">查看全部分享单></span>
	</div>
	<table class="wdfxd_tab">
		<tr>
			<td onclick="goShareList(2)">
				<div class="img_div">
					<img alt="" src="<%=basePath%>resource/image/017.png">
				</div>
				<div class="text_div">待消费</div>
			</td>
			<td onclick="goShareList(3)">
				<div class="img_div">
					<img alt="" src="<%=basePath%>resource/image/018.png">
				</div>
				<div class="text_div">已消费</div>
			</td>
			<td onclick="goShareList(4)">
				<div class="img_div">
					<img alt="" src="<%=basePath%>resource/image/019.png">
				</div>
				<div class="text_div">评价</div>
			</td>
			<td onclick="goShareList(5)">
				<div class="img_div">
					<img alt="" src="<%=basePath%>resource/image/020.png">
				</div>
				<div class="text_div">已取消</div>
			</td>
			<td onclick="goShareList(6)">
				<div class="img_div">
					<img alt="" src="<%=basePath%>resource/image/020.png">
				</div>
				<div class="text_div">租赁卡</div>
			</td>
		</tr>
	</table>
</div>
<div class="wdfb_div">
	<div class="wdfbTit_div">
		<span class="wdfbTit_span">我的发布</span>
	</div>
	<table class="wdfb_tab">
		<tr>
			<td onclick="goMySubmit(1)">
				<div class="img_div">
					<img alt="" src="<%=basePath%>resource/image/017.png">
				</div>
				<div class="text_div">会员</div>
			</td>
			<td>
				<div class="img_div">
					<img alt="" src="<%=basePath%>resource/image/018.png">
				</div>
				<div class="text_div">实物卡</div>
			</td>
			<td>
				<div class="img_div">
					<img alt="" src="<%=basePath%>resource/image/019.png">
				</div>
				<div class="text_div">已下架</div>
			</td>
			<td onclick="goMySubmit(4)">
				<div class="img_div">
					<img alt="" src="<%=basePath%>resource/image/020.png">
				</div>
				<div class="text_div">发布新卡</div>
			</td>
		</tr>
	</table>
</div>
<div class="ssc_div ssc_s">
	<span class="sscTit_span">
		累计分享次数：
	</span>
	<span class="sscVal_span" id="sscVal_span"></span>
</div>
<div class="ssm_div">
	<span class="ssmTit_span">
		累计分享金额：
	</span>
	<span class="ssmVal_span" id="ssmVal_span"></span>
</div>
<div class="smallChange_div smallChange_s" onclick="goPage('mineSmallChange')">
	<span class="smallChangeTxt_span">
		零钱
	</span>
	<span class="goPage_span">&gt;</span>
</div>
<div class="repu_div">
	<span class="repu_span">
		信誉度：
	</span>
	<div class="repuImg_div">
		<img class="repu_img" id="repu_img1" alt="" src="<%=basePath%>resource/image/star_yellow.png">
		<img class="repu_img" id="repu_img1" alt="" src="<%=basePath%>resource/image/star_yellow.png">
		<img class="repu_img" id="repu_img1" alt="" src="<%=basePath%>resource/image/star_yellow.png">
		<img class="repu_img" id="repu_img1" alt="" src="<%=basePath%>resource/image/star_yellow.png">
		<img class="repu_img" id="repu_img1" alt="" src="<%=basePath%>resource/image/star_yellow.png">
	</div>
</div>
<div class="leaseVip_div leaseVip_s" onclick="goPage('mineLeaseVip')">
	<span class="leaseVipTxt_span">
		租赁卡
	</span>
	<span class="goPage_span">&gt;</span>
</div>
<!-- 
<div class="alipay_div" onclick="goPage('mineAlipay')">
	<span class="alipayTxt_span">
		支付宝
	</span>
	<span class="goPage_span">&gt;</span>
</div>
 -->
<div class="qhzh_div qhzh_s" onclick="goPage('mineChangeAccount')">
	<span class="qhzhTxt_span">
		切换账号
	</span>
	<span class="goPage_span">&gt;</span>
</div>
<jsp:include page="../foot.jsp"></jsp:include>
</body>
</html>