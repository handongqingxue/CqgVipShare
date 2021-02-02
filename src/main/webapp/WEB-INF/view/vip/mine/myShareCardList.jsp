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
<link rel="stylesheet" href="<%=basePath %>resource/css/vip/mine/myShareCardList.css"/>
<script type="text/javascript" src="<%=basePath %>resource/js/jquery-3.3.1.js"></script>
<script type="text/javascript">
var path='<%=basePath %>';
var openId='${param.openId}';
$(function(){
	initCardListDiv(1);
});

function initCardListDiv(type){
	$("#wxf_div").attr("class","wxf_div unSelected");
	$("#yxf_div").attr("class","yxf_div unSelected");
	$("#qxsq_div").attr("class","qxsq_div unSelected");
	var vipListDiv=$("#vipList_div");
	vipListDiv.empty();
	switch (type) {
	case 1:
		$("#wxf_div").attr("class","wxf_div selected");
		selectMyAddShareCardList(1);
		break;
	case 2:
		$("#yxf_div").attr("class","yxf_div selected");
		selectMyAddShareCardList(2);
		break;
	case 3:
		$("#qxsq_div").attr("class","qxsq_div selected");
		selectMyCancelSRList();
		break;
	}
	
}

function selectMyCancelSRList(){
	$.post("selectMyCancelSRList",
		{openId:openId},
		function(result){
			var vipListDiv=$("#vipList_div");
			if(result.message=="ok"){
				var cfrList=result.data;
				for(var i=0;i<cfrList.length;i++){
					var cfr=cfrList[i];
					var appendStr="<div class=\"item2_div\">";
						appendStr+="<img class=\"shopLogo_img\" src=\""+cfr.shopLogo+"\"/>";
						appendStr+="<span class=\"shopName_span\">"+cfr.shopName+"</span>";
						appendStr+="<span class=\"fxzNickName_span\">"+cfr.fxzNickName+"</span>";
						appendStr+="<span class=\"scName_span\">"+cfr.scName+"</span>";
						appendStr+="<span class=\"shareMoney_span\">价格￥"+cfr.shareMoney+cfr.scType;
						if(cfr.scType==1)
							appendStr+="元";
						else if(cfr.scType==2)
							appendStr+="元/次";
						appendStr+="</span>";
						appendStr+="<div class=\"confirmBut_div\" onclick=\"confirmCan('"+cfr.srUuid+"')\">确认取消</div>";
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

function confirmCan(srUuid){
	$.post("confirmCanShareVip",
		{srUuid:srUuid},
		function(data){
			if(data.status=="ok"){
				alert(data.message);
				location.href=location.href;
			}
		}
	,"json");
}

function selectMyAddShareCardList(type){
	$.post("selectMyAddShareCardList",
		{type:type,openId:openId},
		function(result){
			var vipListDiv=$("#vipList_div");
			if(result.message=="ok"){
				var vipList=result.data;
				for(var i=0;i<vipList.length;i++){
					var shareCard=vipList[i];
					var appendStr="<div class=\"item_div\">";
						appendStr+="<img class=\"shopLogo_img\" src=\""+shareCard.shopLogo+"\"/>";
						appendStr+="<span class=\"shopName_span\">"+shareCard.shopName+"</span>";
						if(type==1)
							appendStr+="<span class=\"consumeCount_span\">"+shareCard.name+"/未消费人数"+(shareCard.yxzCount-shareCard.yxfCount-shareCard.qxsqCount)+"</span>";
						else if(type==2)
							appendStr+="<span class=\"consumeCount_span\">"+shareCard.name+"/已消费人数"+shareCard.yxfCount+"</span>";
						appendStr+="<span class=\"shareMoney_span\">价格￥"+shareCard.shareMoney;
						if(shareCard.type==1)
							appendStr+="元";
						else if(shareCard.type==2)
							appendStr+="元/次";
						appendStr+="</span>";
						appendStr+="<span class=\"describe_span\">"+shareCard.describe+"</span>";
						if(type==1)
							appendStr+="<div class=\"shareBut_div\" onclick=\"goKzSRList('"+shareCard.id+"','"+shareCard.name+"')\">分享信息</div>";
						else if(type==2)
							appendStr+="<div class=\"shareBut_div\" onclick=\"goKzSHRList('"+shareCard.id+"','"+shareCard.name+"')\">分享信息</div>";
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

function goKzSRList(scId,scName){
	location.href=path+"vip/goPage?page=mineKzSRList&scId="+scId+"&scName="+scName+"&openId="+openId;
}

function goKzSHRList(scId,scName){
	location.href=path+"vip/goPage?page=mineKzSHRList&scId="+scId+"&scName="+scName+"&openId="+openId;
}

function goBack(){
	location.href=path+"vip/goPage?page=mySubmitMenu&openId="+openId;
}
</script>
<title>Insert title here</title>
</head>
<body>
<div class="top_div">
	<span class="wdhyfb_span">我的会员发布</span>
</div>
<div class="back_div">
	<span class="back_span" onclick="goBack()">&lt;返回</span>
</div>
<div class="type_div">
	<div class="wxf_div selected" id="wxf_div" onclick="initCardListDiv(1)">未消费</div>
	<div class="yxf_div unSelected" id="yxf_div" onclick="initCardListDiv(2)">已消费</div>
	<div class="qxsq_div unSelected" id="qxsq_div" onclick="initCardListDiv(3)">取消申请</div>
</div>
<div class="vipList_div" id="vipList_div">
</div>
</body>
</html>