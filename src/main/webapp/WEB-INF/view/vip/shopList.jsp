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
var vipJO=JSON.parse('${param.vipJOStr}');
var fpyArr=["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"];
$(function(){
	$.post("selectShopList",
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
		if(i%3==0){
			hotListTab.append("<tr></tr>");
		}
		var trLength=hotListTab.find("tr").length;
		var tr=hotListTab.find("tr").eq(trLength-1);
		tr.append("<td style=\"width:33%;\" onclick=\"selectShop('"+hotList[i].id+"','"+hotList[i].shopName+"','"+hotList[i].shopAddress+"')\">"+hotList[i].shopName+"</td>");
		hotCount++;
	}
	var yu=3-hotCount;
	if(yu>0){
		for(var i=0;i<yu;i++){
			var trs=hotListTab.find("tr");
			trs.eq(trs.length-1).append("<td style=\"width:33%;\"></td>");
		}
	}
}

function initMoreListDiv(moreList){
	var moreListDiv=$("#moreList_div");
	for(var i=0;i<fpyArr.length;i++){
		moreListDiv.append("<div>"+fpyArr[i]+"</div>"
				+"<div id=\"list_div"+fpyArr[i]+"\"></div>");
	}
	
	moreListDiv.find("div[id^='list_div']").each(function(){
		var fpy=$(this).attr("id").substring(8);
		for(var i=0;i<moreList.length;i++){
			var shopFPY=moreList[i].shopFPY;
			if(fpy==shopFPY){
				$(this).append("<div onclick=\"selectShop('"+moreList[i].id+"','"+moreList[i].shopName+"','"+moreList[i].shopAddress+"')\">"+moreList[i].shopName+"</div>");
			}
		}
	});
}

function selectShop(shopId,shopName,shopAddress){
	vipJO["shopId"]=shopId;
	vipJO["shopName"]=shopName;
	vipJO["shopAddress"]=shopAddress;
	location.href=path+"vip/toAddVip?vipJOStr="+JSON.stringify(vipJO);
}
</script>
<title>门店选择</title>
</head>
<body>
<div>热门门店</div>
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
<div>更多门店</div>
<div id="moreList_div">
	<!-- 
	<div>A</div>
	<div>
		<div>aaa1</div>
		<div>aaa2</div>
	</div>
	 -->
</div>
</body>
</html>