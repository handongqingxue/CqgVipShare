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
	location.href=path+"vip/toAddLeaseRecord?id="+id+"&vipId="+'${requestScope.leaseInfo.id }'+"&kzOpenId="+'${requestScope.leaseInfo.openId }'+"&zlzOpenId="+openId+"&shareMoney="+'${requestScope.leaseInfo.shareMoney }';
}

function goBack(){
	location.href=path+"vip/toLeaseVipList?openId="+openId;
}
</script>
<title>Insert title here</title>
</head>
<body style="margin: 0px;">
<div style="width: 100%;height: 40px;line-height: 40px;color:#fff;background-color: #EC4149;">
	<span style="margin-left: 10px;" onclick="goBack()">&lt;返回</span>
	<div style="text-align:center;width: 200px;height: 40px;line-height: 40px;margin: 0 auto;margin-top: -40px;">
		<span>${requestScope.leaseInfo.shopName }</span>
	</div>
</div>
<img alt="" src="${requestScope.leaseInfo.logo }" style="width: 100%;height: 200px;">
<div style="width: 100%;height: 40px;line-height: 40px;font-weight: bold;text-align: center;">${requestScope.leaseInfo.shopName }</div>
<div style="width: 100%;height: 25px;line-height: 25px;">
	<img id="repu1_img1" alt="" src="<%=basePath%>resource/image/star_yellow.png" style="width: 20px;height: 20px;margin-left: 100px;">
	<img id="repu2_img1" alt="" src="<%=basePath%>resource/image/star_yellow.png" style="width: 20px;height: 20px;">
	<img id="repu3_img1" alt="" src="<%=basePath%>resource/image/star_yellow.png" style="width: 20px;height: 20px;">
	<img id="repu4_img1" alt="" src="<%=basePath%>resource/image/star_yellow.png" style="width: 20px;height: 20px;">
	<img id="repu5_img1" alt="" src="<%=basePath%>resource/image/star_yellow.png" style="width: 20px;height: 20px;">
	<span style="color:#666;margin-top: -3px;margin-left: 5px;position: absolute;">5分</span>
</div>
<div style="width: 90%;height: 1px;margin:0 auto;margin-top:5px;background-color: #F2F2F2;"></div>
<div style="width: 100%;height: 40px;line-height: 40px;">
	<img alt="" src="<%=basePath%>resource/image/014.png" style="width: 20px;height: 25px;margin-top: 10px;margin-left: 8px;position: absolute;">
	<span style="color: #656565;margin-left: 35px;">${requestScope.leaseInfo.shopAddress }</span>
</div>
<div style="width: 100%;height: 40px;line-height: 40px;">
	<img alt="" src="<%=basePath%>resource/image/015.png" style="width: 25px;height: 25px;margin-top: 10px;margin-left: 5px;position: absolute;">
	<span style="color: #999;margin-left: 35px;">营业</span>
</div>
<div style="width: 90%;height: 1px;margin:0 auto;margin-top:5px;background-color: #F2F2F2;"></div>
<div style="width: 100%;height: 40px;line-height: 40px;margin-left: 8px;">
	共享会员卡信息
</div>
<div style="width: 100%;height: 30px;line-height: 30px;">
	<img alt="" src="<%=basePath%>resource/image/014.png" style="width: 20px;height: 25px;margin-top: 3px;margin-left: 8px;position: absolute;">
	<span style="color: #656565;margin-left: 35px;font-size: 12px;">会员卡名称：消费次卡</span>
	<span style="color: #656565;margin-left: 15px;font-size: 12px;">剩余次数：${requestScope.leaseInfo.consumeCount }</span>
	<div style="width:60px;height:20px;line-height:20px;margin-top:-25px;margin-left:280px;text-align:center;color:#fff;background-color:#03A6FF;font-size:12px;" onclick="addLeaseRecord()">我要租赁</div>
</div>
<div style="width: 100%;height: 30px;line-height: 30px;">
	<img alt="" src="<%=basePath%>resource/image/015.png" style="width: 25px;height: 25px;margin-top: 3px;margin-left: 5px;position: absolute;">
	<span style="color: #999;margin-left: 35px;font-size: 12px;">卡主信誉度</span>
	<img id="repu1_img2" alt="" src="<%=basePath%>resource/image/star_gray.png" style="width: 20px;height: 20px;margin-top: 5px;margin-left: 20px;position: absolute;">
	<img id="repu2_img2" alt="" src="<%=basePath%>resource/image/star_gray.png" style="width: 20px;height: 20px;margin-top: 5px;margin-left: 40px;position: absolute;">
	<img id="repu3_img2" alt="" src="<%=basePath%>resource/image/star_gray.png" style="width: 20px;height: 20px;margin-top: 5px;margin-left: 60px;position: absolute;">
	<img id="repu4_img2" alt="" src="<%=basePath%>resource/image/star_gray.png" style="width: 20px;height: 20px;margin-top: 5px;margin-left: 80px;position: absolute;">
	<img id="repu5_img2" alt="" src="<%=basePath%>resource/image/star_gray.png" style="width: 20px;height: 20px;margin-top: 5px;margin-left: 100px;position: absolute;">
	<span style="color:#666;margin-left: 125px;position: absolute;">5分</span>
</div>
<div style="width: 90%;height: 1px;margin:0 auto;margin-top:5px;background-color: #F2F2F2;"></div>
<div style="margin-left: 5px;color: #999;font-size: 12px;margin-top: 10px;">会员服务描述：${requestScope.leaseInfo.describe }</div>
</body>
</html>