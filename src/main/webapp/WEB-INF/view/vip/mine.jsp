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
<link rel="stylesheet" href="<%=basePath %>resource/css/vip/mine.css"/>
<script type="text/javascript" src="<%=basePath %>resource/js/jquery-3.3.1.js"></script>
<script type="text/javascript">
var path='<%=basePath %>';
var openId='${param.openId}';
$(function(){
	$.post("queryUserFromDB",
		{openId:openId},
		function(data){
			var user=data.user;
			var nickNameSpan=$("#nickName_span");
			nickNameSpan.text("昵称："+user.nickName);
			$("#headImgUrl_img").attr("src",user.headImgUrl);
			
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
			
			$("#sscVal_span").text(user.sumShareCount);
			$("#ssmVal_span").text(user.sumShareMoney);
			$("#alpnVal_span").text(user.alipayNo);
			$("#rnVal_span").text(user.realName);
			$("#wdmVal_span").text(user.withDrawMoney);
			var reputation=user.reputation;
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
			
			if(user.userType==1){
				$("#changeShop_div").css("display","block");
				$("#shopInfo_div").css("display","none");
			}
			else{
				$("#changeShop_div").css("display","none");
				$("#shopInfo_div").css("display","block");
				
				$("#logo_img").attr("src",user.logo);
				$("#shopName_span").text(user.shopName);
				$("#shopAddress_span").text(user.shopAddress);
				$("#visitCount_span").text(user.visitCount);
			}
		}
	,"json");
});

function goEditMerchant(){
	location.href=path+"vip/toEditMerchant?openId="+openId;
}

function goBindAlipay(){
	location.href=path+"vip/toBindAlipay?openId="+openId;
}

function goTradeList(){
	location.href=path+"vip/toTradeList?action=addLeaseVip&openId="+openId;
}

function goDelLeaseList(){
	location.href=path+"vip/toDelLeaseList?openId="+openId;
}

function goShareList(type){
	location.href=path+"vip/toShareList?type="+type+"&openId="+openId;
}

function goMySubmit(type){
	var url="";
	switch(type){
		case 1:
			url="toMyShareVipList?openId="+openId;
			break;
	}
	location.href=path+"vip/"+url;
}

function userWithDraw(){
	var alipayNo=$("#alpnVal_span").text();
	var realName=$("#rnVal_span").text();
	var withDrawMoney=$("#wdmVal_span").text();
	copyStr(path+"vip/userWithDraw?alipayNo="+alipayNo+"&realName="+realName+"&withDrawMoney="+withDrawMoney+"&openId="+openId);
	//location.href=path+"vip/userWithDraw?alipayNo="+alipayNo+"&realName="+realName+"&withDrawMoney="+withDrawMoney+"&openId="+openId;
}

function copyStr(val) { //val 是要复制的字符串
    var input = document.createElement("input");
    input.value = val;
    input.readOnly = true
    document.body.appendChild(input);
    input.select();
    input.setSelectionRange(0, input.value.length)
    document.execCommand('Copy');
    document.body.removeChild(input);
    //window.scrollTo(0, 0);;
    alert("支付链接复制成功，请粘贴到浏览器里")
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
			<td>
				<div class="img_div">
					<img alt="" src="<%=basePath%>resource/image/020.png">
				</div>
				<div class="text_div">发布新卡</div>
			</td>
		</tr>
	</table>
</div>
<div class="shopInfo_div" id="shopInfo_div">
	<div class="sjxx_div">
		<span class="sjxx_span">商家信息</span>
	</div>
	<div class="logo_div">
		<img class="logo_img" id="logo_img" alt="" src=""/>
	</div>
	<div class="sjxx_div">
		<span class="sjmcTit_span">商家名称：</span>
		<span class="shopName_span" id="shopName_span"></span>
	</div>
	<div class="sjdz_div">
		<span class="sjdzTit_span">商家地址：</span>
		<span class="shopAddress_span" id="shopAddress_span"></span>
	</div>
	<div class="fwl_div">
		<span class="fwlTit_span">访问量：</span>
		<span class="visitCount_span" id="visitCount_span"></span>
	</div>
</div>
<div class="ssc_div">
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
<div class="alpn_div">
	<span class="alpnTit_span">
		支付宝账户：
	</span>
	<span class="alpnVal_span" id="alpnVal_span"></span>
</div>
<div class="rn_div">
	<span class="rnTit_span">
		真实姓名：
	</span>
	<span class="rnVal_span" id="rnVal_span"></span>
</div>
<div class="wdm_div">
	<span class="wdmTit_span">
		现金：
	</span>
	<span class="wdmVal_span" id="wdmVal_span"></span>
	<div class="wdBut_div" onclick="userWithDraw()">提现</div>
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
<div class="bindAlipay_div" onclick="goBindAlipay()">
	绑定支付宝
</div>
<div class="addLease_div" onclick="goTradeList()">
	发布租赁卡信息
</div>
<div class="delLease_div" onclick="goDelLeaseList()">
	删除租赁卡信息
</div>
<div class="changeShop_div" id="changeShop_div" onclick="goEditMerchant()">
	我要成为商家
</div>
<div class="qhzh_div" onclick="goDelLeaseList()">
	切换账号
</div>
<jsp:include page="foot.jsp"></jsp:include>
</body>
</html>