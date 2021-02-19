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
<link rel="stylesheet" href="<%=basePath %>resource/css/vip/home/shareTreaty.css"/>
<script type="text/javascript" src="<%=basePath %>resource/js/jquery-3.3.1.js"></script>
<script type="text/javascript">
var path='<%=basePath %>';
var id='${param.id}';
var scId='${param.scId}';
var kzOpenId='${param.kzOpenId}';
var fxzOpenId='${param.fxzOpenId}';
var shareMoney='${param.shareMoney}';
var scType='${param.scType}';
var from='${param.from}';

function toAddShareRecord(){
	location.href=path+"vip/goPage?page=homeAsr&id="+id+"&scId="+scId+"&kzOpenId="+kzOpenId+"&fxzOpenId="+fxzOpenId+"&shareMoney="+shareMoney+"&scType="+scType+"&from="+from;
}
</script>
<title>Insert title here</title>
</head>
<body>
<div class="top_div">
	<span>分享协议</span>
</div>
<div class="back_div">
	<span class="back_span" onclick="goBack()">&lt;返回</span>
</div>
<div class="menu_div" id="menu_div">
	<div class="item_div" id="fxxz_div">分享须知</div>
</div>
<div class="content_div" id="content_div">
	<div class="item_div" id="fxxz_div">aaaaaaaaaaaaa</div>
</div>
<div class="bottom_div">
	<span class="moneySign_span">￥</span>
	<span class="money_span">0.01</span>
	<div class="qrfxBut_div" onclick="toAddShareRecord()">确认分享</div>
</div>
</body>
</html>