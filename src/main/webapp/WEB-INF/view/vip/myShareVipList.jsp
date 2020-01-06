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
<link rel="stylesheet" href="<%=basePath %>resource/css/vip/myShareVipList.css"/>
<script type="text/javascript" src="<%=basePath %>resource/js/jquery-3.3.1.js"></script>
<script type="text/javascript">
var path='<%=basePath %>';
var openId='${param.openId}';
$(function(){
	initVipListDiv(1);
});

function initVipListDiv(type){
	$("#wxf_div").attr("class","wxf_div unSelected");
	$("#yxf_div").attr("class","yxf_div unSelected");
	$("#qxsq_div").attr("class","qxsq_div unSelected");
	var vipListDiv=$("#vipList_div");
	vipListDiv.empty();
	switch (type) {
	case 1:
		$("#wxf_div").attr("class","wxf_div selected");
		selectMyAddShareVipList(1);
		break;
	case 2:
		$("#yxf_div").attr("class","yxf_div selected");
		selectMyAddShareVipList(2);
		break;
	case 3:
		$("#qxsq_div").attr("class","qxsq_div selected");
		break;
	}
	
}

function selectMyAddShareVipList(type){
	$.post("selectMyAddShareVipList",
		{type:type,openId:openId},
		function(result){
			var vipListDiv=$("#vipList_div");
			if(result.message=="ok"){
				var vipList=result.data;
				for(var i=0;i<vipList.length;i++){
					var shareVip=vipList[i];
					var appendStr="<div class=\"item_div\">";
						appendStr+="<img class=\"shopLogo_img\" src=\""+shareVip.shopLogo+"\"/>";
						appendStr+="<span class=\"shopName_span\">"+shareVip.shopName+"</span>";
						appendStr+="<span class=\"consumeCount_span\">"+shareVip.name+"/未消费人数"+shareVip.wxfCount+"</span>";
						appendStr+="<span class=\"shareMoney_span\">价格￥"+shareVip.shareMoney+"元/次</span>";
						appendStr+="<span class=\"describe_span\">"+shareVip.describe+"</span>";
						appendStr+="<div class=\"shareBut_div\" onclick=\"goShare('"+shareVip.id+"')\">分享信息</div>";
						appendStr+="<div class=\"line_div\"></div>";
						appendStr+="</div>";
					vipListDiv.append(appendStr);
				}
			}
			else{
				vipListDiv.append("<div style=\"font-size: 15px;text-align:center;\">暂无会员信息</div>");
			}
		}
	,"json");
}

function goBack(){
	location.href=path+"vip/toMine?openId="+openId;
}
</script>
<title>Insert title here</title>
</head>
<body>
<div class="top_div">
	<span class="back_span" onclick="goBack()">&lt;返回</span>
	<span class="wdhyfb_span">我的会员发布</span>
</div>
<div class="type_div">
	<div class="wxf_div selected" id="wxf_div" onclick="initVipListDiv(1)">未消费</div>
	<div class="yxf_div unSelected" id="yxf_div" onclick="initVipListDiv(2)">已消费</div>
	<div class="qxsq_div unSelected" id="qxsq_div" onclick="initVipListDiv(3)">取消申请</div>
</div>
<div class="vipList_div" id="vipList_div">
</div>
</body>
</html>