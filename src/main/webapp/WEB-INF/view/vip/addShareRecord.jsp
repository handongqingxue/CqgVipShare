<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
<%@include file="../admin/js.jsp"%>
<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
<script type="text/javascript">
var path='<%=basePath %>';
var id='${param.id}';
var kzOpenId='${param.kzOpenId}';
var fxzOpenId='${param.fxzOpenId}';
$(function(){
	ygxfDB=$("#ygxfDate").datebox({});
});

function pay(){
	var phone=$("#phone").val();
	var ygxfDate=ygxfDB.datebox("getValue");
	var vipId='${param.vipId}';
	var shareMoney='${param.shareMoney}';
	$.post("addShareRecord",
		{kzOpenId:kzOpenId,fxzOpenId:fxzOpenId,phone:phone,ygxfDate:ygxfDate,vipId:vipId,shareMoney:shareMoney},
		function(data){
			if(data.status=="ok")
				$("#qrcodeUrl").attr("src",data.qrcodeUrl);
			else
				alert(data.message);
		}
	,"json");
}

function goBack(){
	location.href=path+"vip/toShare?id="+id+"&openId="+fxzOpenId;
}
</script>
</head>
<body style="margin: 0px;">
<div style="width: 100%;height: 40px;line-height: 40px;color:#fff;background-color: #EC4149;">
	<span style="margin-left: 10px;" onclick="goBack()">&lt;返回</span>
	<span style="margin-left: 50px;">分享会员</span>
</div>
<table style="margin-top: 10px;">
	<tr height="30">
		<td style="width:45%;padding-left: 10px;">手机号</td>
		<td>
			<input type="text" id="phone" style="width: 188px;"/>
		</td>
	</tr>
	<tr height="30">
		<td style="padding-left: 10px;">预估消费日期</td>
		<td>
			<input type="text" id="ygxfDate" style="width: 188px;"/>
		</td>
	</tr>
</table>
<div onclick="pay()" style="width:95%;height:40px;line-height:40px;margin:0 auto; margin-top: 10px;text-align:center;color:#fff;background-color: #f00;border-radius:5px;">
	支付
</div>
<div>
	<img id="qrcodeUrl" alt="" />
</div>
</body>
</html>