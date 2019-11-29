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
var path='<%=basePath %>';
var tradeId='${param.tradeId}';
$.post("selectVipList",
	{tradeId:tradeId},
	function(result){
		//console.log(result);
		var vipListDiv=$("#vipList_div");
		if(result.message=="ok"){
			var vipList=result.data;
			for(var i=0;i<vipList.length;i++){
				var shareVip=vipList[i];
				vipListDiv.append("<div class=\"item\">"
						+"<img class=\"shopLogo_img\" src=\""+shareVip.shopLogo+"\"/>"
						+"<span class=\"shopName_span\">"+shareVip.shopName+"</span>"
						+"<span class=\"consumeCount_span\">80次年卡/剩余次数"+shareVip.consumeCount+"</span>"
						+"<span class=\"shareMoney_span\">价格￥"+shareVip.shareMoney+"元/次</span>"
						+"<span class=\"describe_span\">"+shareVip.describe+"</span>"
						+"</div>");
			}
		}
		else{
			
		}
	}
,"json");

function goAddVip(){
	location.href=path+"vip/toAddVip";
}
</script>
<style type="text/css">
.vipList_div .item{
	width:100%;
	height:120px;
	border-bottom:#999 solid 1px;
}
.vipList_div .item .shopLogo_img{
	width:80px;
	height:80px;
	margin-top:10px;
	margin-left:10px;
}
.vipList_div .item .shopName_span{
	font-size:18px;
	margin-top:10px;
	margin-left:10px;
	position: absolute;
}
.vipList_div .item .consumeCount_span{
	font-size:15px;
	margin-top:40px;
	margin-left:10px;
	position: absolute;
}
.vipList_div .item .shareMoney_span{
	font-size:12px;
	margin-top:70px;
	margin-left:10px;
	position: absolute;
}
.vipList_div .item .describe_span{
	font-size:12px;
	margin-top:90px;
	margin-left:10px;
	color:#DE792B;
	background-color:#FEF4EB;
	position: absolute;
}
</style>
<title>行业内页</title>
</head>
<body style="margin: 0px;">
<div style="width: 100%;height: 40px;line-height: 40px;color:#fff;background-color: #EC4149;">
	<span style="margin-left: 10px;" onclick="history.go(-1)">&lt;返回</span>
	<span style="margin-left: 50px;">${param.tradeName }会员共享</span>
	<span style="margin-right: 15px;float: right;" onclick="goAddVip()">发布</span>
</div>
<div class="vipList_div" id="vipList_div">
	<!-- 
	<div class="item">
		<img class="shopLogo_img" src=""/>
		<span class="shopName_span">岳家庄</span>
		<span class="consumeCount_span">80次年卡/剩余次数56</span>
		<span class="shareMoney_span">价格￥10元/次</span>
		<span class="describe_span">aaaaaaaaaaa</span>
	</div>
	 -->
</div>
</body>
</html>