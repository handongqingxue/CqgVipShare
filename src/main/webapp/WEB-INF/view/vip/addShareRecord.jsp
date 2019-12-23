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
</script>
</head>
<body>
<div>
	手机号：<input type="text" id="phone"/>
</div>
<div>
	预估消费日期：<input type="text" id="ygxfDate"/>
</div>
<div>
	<input type="button" value="支付" onclick="pay()"/>
</div>
<div>
	<img id="qrcodeUrl" alt="" />
</div>
</body>
</html>