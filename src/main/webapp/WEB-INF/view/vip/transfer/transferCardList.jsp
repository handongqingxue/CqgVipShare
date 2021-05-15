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
<link rel="stylesheet" href="<%=basePath %>resource/css/vip/transfer/transferCardList.css"/>
<script type="text/javascript" src="<%=basePath %>resource/js/jquery-3.3.1.js"></script>
<script type="text/javascript">
var path='<%=basePath %>';
var openId='${param.openId}';
var myLatitude='${sessionScope.myLocation.latitude}';
var myLongitude='${sessionScope.myLocation.longitude}';
$(function(){
	initSXTradeDiv();
	initCardList(1,"asc",0,"",0,0);
});

function initCardList(orderFlag,order,likeFlag,tradeId,start,end){
	$.post("selectTransferCardList",
		{orderFlag:orderFlag,order:order,likeFlag:likeFlag,tradeId:tradeId,start:start,end:end,myLatitude:myLatitude,myLongitude:myLongitude},
		function(result){
			var lvListDiv=$("#lvList_div");
			lvListDiv.empty();
			if(result.status=="ok"){
				var lvList=result.data;
				for(var i=0;i<lvList.length;i++){
					var transferCard=lvList[i];
					var appendStr="<div class=\"item\"";
						if(openId!=transferCard.openId)
							appendStr+=" onclick=\"goDetail('"+transferCard.id+"','"+transferCard.shopId+"')\"";
						else
							appendStr+=" onclick=\"alert('不能接受自己发布的转让卡')\"";
						appendStr+=">";
							appendStr+="<img class=\"shopLogo_img\" src=\""+transferCard.shopLogo+"\"/>";
							var shopName=transferCard.shopName;
							appendStr+="<span class=\"shopName_span\">"+(shopName.length>12?shopName.substring(0,12)+"..":shopName)+"</span>";
							appendStr+="<div class=\"ccsd_div\">";
								appendStr+="<span class=\"consumeCount_span\">"+transferCard.name;
								if(transferCard.type==5)
									appendStr+="/剩余次数"+transferCard.consumeCount;
								appendStr+="</span>";
								var sdStr;
								var shopDistance=transferCard.shopDistance;
								if(shopDistance>=1000)
									sdStr=(shopDistance/1000).toFixed(0)+"km";
								else
									sdStr=shopDistance.toFixed(0)+"m";
								appendStr+="<span class=\"shopDistance_span\">"+sdStr+"</span>";
							appendStr+="</div>";
							appendStr+="<div class=\"smm_div\">";
								appendStr+="<span class=\"shareMoney_span\">价格￥"+transferCard.shareMoney;
								if(transferCard.type==5)
									appendStr+="元/次";
								else
									appendStr+="元";
								if(transferCard.discount!=null)
									appendStr+="&nbsp;&nbsp;折扣:"+transferCard.discount;
								appendStr+="</span>";
								var yysjStr=transferCard.startTime+"时-"+transferCard.endTime+"时";
								appendStr+="<span class=\"yysj_span\">"+yysjStr+"</span>";
							appendStr+="</div>";
							appendStr+="<div class=\"describe_div\">";
								var describe=transferCard.describe;
								appendStr+="<span class=\"describe_span\">"+(describe.length>20?describe.substring(0,20)+"...":describe)+"</span>";
							appendStr+="</div>";
						appendStr+="</div>";
					lvListDiv.append(appendStr);
				}
			}
			else{
				lvListDiv.append("<div style=\"font-size: 15px;text-align:center;\">暂无信息</div>");
			}
		}
	,"json");
}

function goDetail(id,shopId){
	var postParams={id:id,shopId:shopId,openId:openId};
	var urlParams="&page=tcDetail";
	updatePageValue(postParams,urlParams);
}

function initSXTradeDiv(){
	$.post("selectTrade",
		function(result){
			if(result.message=="ok"){
				var tradeList=result.data;
				var tradeListTab=$("#tradeList_tab");
				var tradeCount=0;
				for(var i=0;i<tradeList.length;i++){
					if(i%2==0){
						tradeListTab.append("<tr></tr>");
					}
					var trLength=tradeListTab.find("tr").length;
					var tr=tradeListTab.find("tr").eq(trLength-1);
					tr.append("<td style=\"width:48%;\" onclick=\"hideChooseBgDiv(1,'"+tradeList[i].id+"',0,0)\"><div style=\"width:130px;height:40px;line-height:40px;font-size:15px;color:#3C3C3C;margin:0 auto;border:#DEDEDE solid 1px;\">"+tradeList[i].name+"</div></td>");
					tradeCount++;
				}
				var yu=2-tradeCount;
				if(yu>0){
					for(var i=0;i<yu;i++){
						var trs=tradeListTab.find("tr");
						trs.eq(trs.length-1).append("<td style=\"width:48%;\"></td>");
					}
				}
			}
		}
	,"json");
}

function showChooseBgDiv(show){
	if(show)
		$("#chooseBg_div").css("display","block");
	else
		$("#chooseBg_div").css("display","none");
}

function hideChooseBgDiv(likeFlag,tradeId,start,end){
	stopEvt();
	showChooseBgDiv(false);
	searchByLike(likeFlag,tradeId,start,end);
}

function searchByOrder(orderFlag){
	$(".order_div span").css("color","#000");
	switch(orderFlag){
		case 0:
		case 1:
			$(".order_div .zhpx_span").css("color","#00a7ff");
			break;
		case 2:
			$(".order_div .jl_span").css("color","#00a7ff");
			break;
		case 3:
			$(".order_div .fxl_span").css("color","#00a7ff");
			break;
		case 4:
			$(".order_div .sx_span").css("color","#00a7ff");
			break;
	}
	
	var order=$("#order_hid").val();
	if(order=="asc")
		order="desc";
	else
		order="asc";
	$("#order_hid").val(order);
	
	var likeFlag=$("#likeFlag_hid").val();
	var tradeId=$("#tradeId_hid").val();
	var start=$("#start_hid").val();
	var end=$("#end_hid").val();
	initCardList(orderFlag,order,likeFlag,tradeId,start,end);
}

function searchByLike(likeFlag,tradeId,start,end){
	$("#likeFlag_hid").val(likeFlag);
	$("#tradeId_hid").val(tradeId);
	$("#start_hid").val(start);
	$("#end_hid").val(end);
	searchByOrder(4);
}

//div 叠加,点击时只激发顶层div的js事件
//https://zhidao.baidu.com/question/264186043009275645.html
function stopEvt() {
	var ev = getEvent();
	if (ev.stopPropagation) {
		ev.stopPropagation();
	}
	else if (window.ev) {
		window.ev.cancelBubble = true;
	}
}

function getEvent() {
	if (document.all) {
		return window.event; //如果是ie
	}
	func = getEvent.caller;
	while (func != null) {
		var arg0 = func.arguments[0];
		if (arg0) {
			if ((arg0.constructor == Event || arg0.constructor == MouseEvent) || (typeof(arg0) == "object" && arg0.preventDefault && arg0.stopPropagation)) {
				return arg0;
			}
		}
		func = func.caller;
	}
	return null;
}
</script>
<title>实物卡转让</title>
</head>
<body>
<div class="chooseBg_div" id="chooseBg_div" onclick="showChooseBgDiv(false)">
	<div class="choose_div">
		<input type="hidden" id="likeFlag_hid"/>
		<input type="hidden" id="tradeId_hid"/>
		<input type="hidden" id="start_hid"/>
		<input type="hidden" id="end_hid"/>
		<div class="tradeTit_div">行业</div>
		<table class="tradeList_tab" id="tradeList_tab">
		</table>
		<div class="jlTit_div">距离（m）</div>
		<table class="jlList_tab" id="jlList_tab">
			<tr>
				<td onclick="hideChooseBgDiv(2,0,-1,100)">
					<div class="item_div">100以内</div>
				</td>
				<td onclick="hideChooseBgDiv(2,0,100,500)">
					<div class="item_div">100-500</div>
				</td>
			</tr>
			<tr>
				<td onclick="hideChooseBgDiv(2,0,500,1000)">
					<div class="item_div">500-1000</div>
				</td>
				<td onclick="hideChooseBgDiv(2,0,1000,-1)">
					<div class="item_div">1000以外</div>
				</td>
			</tr>
		</table>
		<div class="fxlTit_div">分享量</div>
		<table class="fxlList_tab" id="fxlList_tab">
			<tr>
				<td onclick="hideChooseBgDiv(3,0,-1,100)">
					<div class="item_div">100以下</div>
				</td>
				<td onclick="hideChooseBgDiv(3,0,100,500)">
					<div class="item_div">100-500</div>
				</td>
			</tr>
			<tr>
				<td onclick="hideChooseBgDiv(3,0,500,1000)">
					<div class="item_div">500-1000</div>
				</td>
				<td onclick="hideChooseBgDiv(3,0,1000,-1)">
					<div class="item_div">1000以上</div>
				</td>
			</tr>
		</table>
	</div>
</div>

<div class="order_div">
	<input type="hidden" id="order_hid" value="asc"/>
	<span class="zhpx_span" onclick="searchByOrder(1)">
		综合排序
	</span>
	<span class="jl_span" onclick="searchByOrder(2)">
		距离
	</span>
	<span class="fxl_span" onclick="searchByOrder(3)">
		分享量
	</span>
	<span class="sx_span" onclick="showChooseBgDiv(true)">
		筛选
	</span>
</div>
<div class="lvList_div" id="lvList_div">
</div>
<jsp:include page="../foot.jsp"></jsp:include>
</body>
</html>