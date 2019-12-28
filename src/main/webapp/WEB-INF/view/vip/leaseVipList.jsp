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
var openId='${param.openId}';
$(function(){
	$.post("selectLeaseVipList",
		function(result){
			if(result.status=="ok"){
				var lvListDiv=$("#lvList_div");
				var lvList=result.data;
				for(var i=0;i<lvList.length;i++){
					var leaseVip=lvList[i];
					var appendStr="<div class=\"item\">";
						appendStr+="<img class=\"shopLogo_img\" src=\""+leaseVip.shopLogo+"\"/>";
						appendStr+="<span class=\"shopName_span\">"+leaseVip.shopName+"</span>";
						appendStr+="<span class=\"consumeCount_span\">"+leaseVip.name+"/剩余次数"+leaseVip.consumeCount+"</span>";
						appendStr+="<span class=\"shareMoney_span\">价格￥"+leaseVip.shareMoney+"元/次</span>";
						appendStr+="<span class=\"describe_span\">"+leaseVip.describe+"</span>";
						//if(openId!=leaseVip.openId)
							appendStr+="<div class=\"shareBut_div\" onclick=\"goShare('"+leaseVip.id+"')\">点击分享</div>";
						appendStr+="</div>";
					lvListDiv.append(appendStr);
				}
			}
		}
	,"json");
});
</script>
<title>租实物卡</title>
<style>
.lvList_div .item{
	width:100%;
	height:120px;
	border-bottom:#999 solid 1px;
}
.lvList_div .item .shopLogo_img{
	width:90px;
	height:90px;
	margin-top:10px;
	margin-left:10px;
}
.lvList_div .item .shopName_span{
	font-size:20px;
	margin-top:10px;
	margin-left:10px;
	position: absolute;
}
.lvList_div .item .consumeCount_span{
	font-size:15px;
	margin-top:40px;
	margin-left:10px;
	color:#7F7F7F;
	position: absolute;
}
.lvList_div .item .shareMoney_span{
	font-size:12px;
	margin-top:70px;
	margin-left:10px;
	color:#B1B1B1;
	position: absolute;
}
.lvList_div .item .describe_span{
	font-size:12px;
	margin-top:90px;
	margin-left:10px;
	color:#DE792B;
	background-color:#FEF4EB;
	position: absolute;
}
.lvList_div .item .shareBut_div{
	width:60px;
	height:20px;
	line-height:20px;
	float:right;
	margin-top:65px;
	margin-right:20px;
	text-align:center;
	color:#fff;
	background-color:#03A6FF;
	font-size:12px;
}
</style>
</head>
<body style="margin: 0px;background-color: #F6F6F6;">
<div class="lvList_div" id="lvList_div">
</div>
<jsp:include page="foot.jsp"></jsp:include>
</body>
</html>