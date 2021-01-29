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
var from='${param.from}';
$(function(){
	initTradeTab();
});

function initTradeTab(){
	$.post("selectTrade",
		function(result){
			var tradeTab=$("#trade_tab");
			tradeTab.empty();
			if(result.message=="ok"){
				var tradeList=result.data;
				var marginTop=0;
				var marginLeft=0;
				var listLength=tradeList.length;
				var pageSize=14;
				var dataCount=0;
				var rowSize=5;
				var bw=$("body").css("width");
				bw=bw.substring(0,bw.length-2);
				for(var i=0;i<listLength;i++){
					var trade=tradeList[i];
					if(i==pageSize){
						break;
					}
					if(i%5==0){
						console.log(i);
						tradeTab.append("<tr></tr>");
					}
					var tr=tradeTab.find("tr").last();
					tr.append("<td onclick=\"goShopList('"+trade.id+"','"+trade.name+"');\">"
								+"<img src=\""+trade.imgUrl+"\"/>"
								+"<div>"+trade.name+"</div>"
							+"</td>");
					dataCount++;
				}
				var yuShu=dataCount%rowSize;
				for(var i=0;i<rowSize-yuShu;i++){
					var tr=tradeTab.find("tr").last();
					tr.append("<td></td>");
				}
			}
			else{
				tradeList.append("<div style=\"height:170px;line-height:170px;text-align: center;\">暂无行业</div>");
			}
		}
	,"json");
}

function goShopList(tradeId,tradeName){
	location.href=path+"vip/goPage?page=shopList&tradeId="+tradeId+"&tradeName="+encodeURI(tradeName)+"&prePage=tradeList&action="+action+"&openId="+openId+"&from="+from;
}

function goBack(){
	if(from=="wxMenu")
		WeixinJSBridge.call('closeWindow');
	else
		location.href=path+"vip/goPage?page="+from+"&openId="+openId;
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
<table class="trade_tab" id="trade_tab" cellspacing="0"></table>
<div id="moreList_div">
</div>
</body>
</html>