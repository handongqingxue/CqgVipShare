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
var tradeId='${param.tradeId}';
var tradeName='${param.tradeName}';
var vipJO=JSON.parse('${param.vipJOStr}');
var fpyArr=["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"];
$(function(){
	$.post("selectShopList",
		{tradeId:tradeId},
		function(result){
			var hotList=result.hotList;
			initHotListDiv(hotList);
			var moreList=result.moreList;
			initMoreListDiv(moreList);
		}
	,"json");
});

function initHotListDiv(hotList){
	var hotListTab=$("#hotList_tab");
	var hotCount=0;
	for(var i=0;i<hotList.length;i++){
		if(i%2==0){
			hotListTab.append("<tr></tr>");
		}
		var trLength=hotListTab.find("tr").length;
		var tr=hotListTab.find("tr").eq(trLength-1);
		tr.append("<td style=\"width:48%;\" onclick=\"selectShop('"+hotList[i].id+"','"+hotList[i].shopName+"','"+hotList[i].shopAddress+"')\"><div style=\"width:150px;height:40px;line-height:40px;font-size:15px;color:#3C3C3C;margin:0 auto;border:#DEDEDE solid 1px;\">"+hotList[i].shopName+"</div></td>");
		hotCount++;
	}
	var yu=2-hotCount;
	if(yu>0){
		for(var i=0;i<yu;i++){
			var trs=hotListTab.find("tr");
			trs.eq(trs.length-1).append("<td style=\"width:48%;\"></td>");
		}
	}
}

function initMoreListDiv(moreList){
	var moreListDiv=$("#moreList_div");
	for(var i=0;i<fpyArr.length;i++){
		moreListDiv.append("<div style=\"width:100%;height:40px;line-height:40px;background-color:#F0F3F8;\"><span style=\"margin-left: 10px;\">"+fpyArr[i]+"</span></div>"
				+"<div id=\"list_div"+fpyArr[i]+"\"></div>");
	}
	
	moreListDiv.find("div[id^='list_div']").each(function(){
		var fpy=$(this).attr("id").substring(8);
		for(var i=0;i<moreList.length;i++){
			var shopFPY=moreList[i].shopFPY;
			if(fpy==shopFPY){
				$(this).append("<div class=\"item_div\" style=\"width:100%;height:50px;line-height:50px;color:#24292C;\" onclick=\"selectShop('"+moreList[i].id+"','"+moreList[i].shopName+"','"+moreList[i].shopAddress+"')\"><span style=\"margin-left: 10px;\">"+moreList[i].shopName+"</span></div>");
			}
		}
	});
	
	moreListDiv.find("div[id^='list_div']").each(function(){
		var itemLength=$(this).find(".item_div").length;
		if(itemLength==0){
			$(this).append("<div style=\"width:100%;height:50px;line-height:50px;color:#24292C;text-align:center;\">暂无门店</div>");
		}
	});
}

function selectShop(shopId,shopName,shopAddress){
	vipJO["shopId"]=shopId;
	vipJO["shopName"]=shopName;
	vipJO["shopAddress"]=shopAddress;
	location.href=path+"vip/toAddVip?vipJOStr="+encodeURI(JSON.stringify(vipJO))+"&tradeId="+tradeId+"&tradeName="+encodeURI(tradeName)+"&openId="+openId;
}

function goBack(){
	location.href=path+"vip/toAddVip?tradeId="+tradeId+"&tradeName="+tradeName+"&openId="+openId;
}
</script>
<title>门店选择</title>
</head>
<body style="margin: 0px;">
<div style="width: 100%;height: 40px;line-height: 40px;color:#fff;background-color: #EC4149;">
	<span style="margin-left: 10px;" onclick="goBack()">&lt;返回</span>
	<span style="margin-left: 50px;">${param.tradeName }门店选择</span>
</div>
<div style="width: 100%;height:40px;line-height:40px;color: #919191;font-size:13px;">
	<span style="margin-left: 10px;">热门门店</span>
</div>
<table id="hotList_tab" style="width: 100%;text-align: center;">
	<!-- 
	<tr>
		<td>aaa</td>
		<td>bbb</td>
		<td>bbb</td>
	</tr>
	<tr>
		<td>aaa</td>
		<td>bbb</td>
		<td>bbb</td>
	</tr>
	 -->
</table>
<div style="width: 100%;height:40px;line-height:40px;color: #919191;font-size:13px;">
	<span style="margin-left: 10px;">更多门店</span>
</div>
<div id="moreList_div">
</div>
</body>
</html>