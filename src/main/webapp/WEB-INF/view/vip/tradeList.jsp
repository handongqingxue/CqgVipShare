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
<link rel="stylesheet" href="<%=basePath %>resource/css/vip/tradeList.css"/>
<script type="text/javascript" src="<%=basePath %>resource/js/jquery-3.3.1.js"></script>
<script type="text/javascript">
var path='<%=basePath %>';
var openId='${param.openId}';
var action='${param.action}';
var fpyArr=["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"];
$(function(){
	$.post("selectTrade",
		function(result){
			if(result.message=="ok"){
				var moreList=result.data;
				initMoreListDiv(moreList);
			}
		}
	,"json");
});

function initMoreListDiv(moreList){
	var moreListDiv=$("#moreList_div");
	for(var i=0;i<fpyArr.length;i++){
		moreListDiv.append("<div style=\"width:100%;height:40px;line-height:40px;background-color:#F0F3F8;\"><span style=\"margin-left: 10px;\">"+fpyArr[i]+"</span></div>"
				+"<div id=\"list_div"+fpyArr[i]+"\"></div>");
	}
	
	moreListDiv.find("div[id^='list_div']").each(function(){
		var fpy=$(this).attr("id").substring(8);
		for(var i=0;i<moreList.length;i++){
			var tradeFPY=moreList[i].fPY;
			if(fpy==tradeFPY){
				$(this).append("<div class=\"item_div\" style=\"width:100%;height:50px;line-height:50px;color:#24292C;\" onclick=\"goShopList('"+moreList[i].id+"','"+moreList[i].name+"')\"><span style=\"margin-left: 10px;\">"+moreList[i].name+"</span></div>");
			}
		}
	});
	
	moreListDiv.find("div[id^='list_div']").each(function(){
		var itemLength=$(this).find(".item_div").length;
		if(itemLength==0){
			$(this).append("<div style=\"width:100%;height:50px;line-height:50px;color:#24292C;text-align:center;\">暂无行业</div>");
		}
	});
}

function goShopList(tradeId,tradeName){
	location.href=path+"vip/toShopList?tradeId="+tradeId+"&tradeName="+encodeURI(tradeName)+"&prePage=tradeList&action="+action+"&openId="+openId;
}

function goBack(){
	WeixinJSBridge.call('closeWindow');
}
</script>
<title>Insert title here</title>
</head>
<body>
<div class="top_div">
	<span>行业选择</span>
</div>
<div class="back_div">
	<span class="back_span" onclick="goBack()">&lt;返回</span>
</div>
<div style="width: 100%;height:40px;line-height:40px;color: #919191;font-size:13px;">
	<span style="margin-left: 10px;">更多行业</span>
</div>
<div id="moreList_div">
</div>
</body>
</html>