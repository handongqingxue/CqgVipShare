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
<link rel="stylesheet" href="<%=basePath %>resource/css/vip/home/shareCardList.css"/>
<script type="text/javascript" src="<%=basePath %>resource/js/jquery-3.3.1.js"></script>
<script type="text/javascript">
var path='<%=basePath %>';
var openId='${param.openId}';
var tradeId='${requestScope.pageValue.tradeId}';
var tradeName='${requestScope.pageValue.tradeName}';
var myLatitude='${sessionScope.myLocation.latitude}';
var myLongitude='${sessionScope.myLocation.longitude}';
$(function(){
	initList(1,"asc",0,0,0);
});

function initList(orderFlag,order,likeFlag,start,end){
	$.post("selectShareCardList",
		{orderFlag:orderFlag,order:order,likeFlag:likeFlag,tradeId:tradeId,start:start,end:end,myLatitude:myLatitude,myLongitude:myLongitude},
		function(result){
			//console.log(result);
			var scListDiv=$("#scList_div");
			scListDiv.empty();
			if(result.message=="ok"){
				var vipList=result.data;
				for(var i=0;i<vipList.length;i++){
					var shareCard=vipList[i];
					var appendStr="<div class=\"item\"";
						if(openId!=shareCard.openId)
							appendStr+=" onclick=\"goShare('"+shareCard.id+"')\"";
						else
							appendStr+=" onclick=\"alert('不能分享自己发布的会员')\"";
						appendStr+=">";
							appendStr+="<img class=\"shopLogo_img\" src=\""+shareCard.shopLogo+"\"/>";
							var shopName=shareCard.shopName;
							appendStr+="<span class=\"shopName_span\">"+(shopName.length>12?shopName.substring(0,12)+"..":shopName)+"</span>";
							appendStr+="<div class=\"ccsd_div\">";
								appendStr+="<span class=\"consumeCount_span\">"+shareCard.name;
								if(shareCard.type==5)
									appendStr+="/剩余次数"+shareCard.consumeCount;
								appendStr+="</span>";
								var sdStr;
								var shopDistance=shareCard.shopDistance;
								if(shopDistance>=1000)
									sdStr=(shopDistance/1000).toFixed(0)+"km";
								else
									sdStr=shopDistance.toFixed(0)+"m";
								appendStr+="<span class=\"shopDistance_span\">"+sdStr+"</span>";
							appendStr+="</div>";
							appendStr+="<div class=\"smm_div\">";
								appendStr+="<span class=\"shareMoney_span\">价格￥"+shareCard.shareMoney;
								if(shareCard.type==5)
									appendStr+="元/次";
								else
									appendStr+="元";
								appendStr+="</span>";
								var yysjStr=shareCard.startTime+"-"+shareCard.endTime;
								appendStr+="<span class=\"yysj_span\">"+yysjStr+"</span>";
							appendStr+="</div>";
							appendStr+="<div class=\"describe_div\">";
								var describe=shareCard.describe;
								appendStr+="<span class=\"describe_span\">"+(describe.length>20?describe.substring(0,20)+"...":describe)+"</span>";
							appendStr+="</div>";
						appendStr+="</div>";
					scListDiv.append(appendStr);
				}
			}
			else{
				scListDiv.append("<div style=\"font-size: 15px;text-align:center;\">暂无共享信息</div>");
			}
		}
	,"json");
}

function goShare(id){
	var postParams={id:id,from:"vipList",openId:openId};
	var urlParams="&page=homeShare";
	updatePageValue(postParams,urlParams);
}

function showChooseBgDiv(show){
	if(show)
		$("#chooseBg_div").css("display","block");
	else
		$("#chooseBg_div").css("display","none");
}

function hideChooseBgDiv(likeFlag,start,end){
	stopEvt();
	showChooseBgDiv(false);
	searchByLike(likeFlag,start,end);
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
	var start=$("#start_hid").val();
	var end=$("#end_hid").val();
	initList(orderFlag,order,likeFlag,start,end);
}

function searchByLike(likeFlag,start,end){
	$("#likeFlag_hid").val(likeFlag);
	$("#start_hid").val(start);
	$("#end_hid").val(end);
	searchByOrder(4);
}

function goShopList(){
	var postParams={prePage:"shareCardList",action:"addShareCard",openId:openId};
	var urlParams="&page=shopList";
	updatePageValue(postParams,urlParams);
}

function updatePageValue(postParams,urlParams){
	$.post("updatePageValue",
		postParams,
		function(data){
			if(data.status=="ok")
				location.href=path+"vip/goPage?openId="+openId+urlParams;
		}
	,"json");
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

function goBack(){
	location.href=path+"vip/goPage?page=homeIndex&openId="+openId;
}
</script>
<title>行业内页</title>
</head>
<body>
<div class="chooseBg_div" id="chooseBg_div" onclick="showChooseBgDiv(false)">
	<div class="choose_div">
		<input type="hidden" id="likeFlag_hid"/>
		<input type="hidden" id="start_hid"/>
		<input type="hidden" id="end_hid"/>
		<div class="jlTit_div">距离（m）</div>
		<table class="jlList_tab" id="jlList_tab">
			<tr>
				<td onclick="hideChooseBgDiv(2,-1,100)">
					<div class="item_div">100以内</div>
				</td>
				<td onclick="hideChooseBgDiv(2,100,500)">
					<div class="item_div">100-500</div>
				</td>
			</tr>
			<tr>
				<td onclick="hideChooseBgDiv(2,500,1000)">
					<div class="item_div">500-1000</div>
				</td>
				<td onclick="hideChooseBgDiv(2,1000,-1)">
					<div class="item_div">1000以外</div>
				</td>
			</tr>
		</table>
		<div class="fxlTit_div">分享量</div>
		<table class="fxlList_tab" id="fxlList_tab">
			<tr>
				<td onclick="hideChooseBgDiv(3,-1,100)">
					<div class="item_div">100以下</div>
				</td>
				<td onclick="hideChooseBgDiv(3,100,500)">
					<div class="item_div">100-500</div>
				</td>
			</tr>
			<tr>
				<td onclick="hideChooseBgDiv(3,500,1000)">
					<div class="item_div">500-1000</div>
				</td>
				<td onclick="hideChooseBgDiv(3,1000,-1)">
					<div class="item_div">1000以上</div>
				</td>
			</tr>
		</table>
	</div>
</div>

<div class="top_div">
	<span>${requestScope.pageValue.tradeName }会员共享</span>
</div>
<div class="back_div">
	<span class="back_span" onclick="goBack()">&lt;返回</span>
	<span class="fb_span" onclick="goShopList()">发布</span>
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
<div class="scList_div" id="scList_div">
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