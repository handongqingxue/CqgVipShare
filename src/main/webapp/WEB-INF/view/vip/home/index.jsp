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
<link rel="stylesheet" href="<%=basePath %>resource/css/vip/home/index.css"/>
<script type="text/javascript" charset="utf-8" src="./js/jquery.min.js"></script>
<script type="text/javascript" charset="utf-8" src="./js/fastclick.js"></script>
<script type="text/javascript" charset="utf-8" src="./js/global.js"></script>
<script type="text/javascript" src="<%=basePath %>resource/js/jquery-3.3.1.js"></script>
<script type="text/javascript">
var path='<%=basePath %>';
var openId='${param.openId}';
var myLatitude='${sessionScope.myLocation.latitude}';
var myLongitude='${sessionScope.myLocation.longitude}';

var width = document.documentElement.clientWidth;
var startX =0;
var index = 0;
var translateX = 0;
var startTime;
var startTranslate;
var isSlide = false;
var sliderNumber = 0;//滑块是数量，控制溢出不能滑动

$(function(){
	initTradeTab();
	//initActivityDiv();
	initSXTradeDiv();
	initShareCardList(1,"asc",0,"",0,0);
});

function initShareCardList(orderFlag,order,likeFlag,tradeId,start,end){
	$.post("selectShareCardList",
		{orderFlag:orderFlag,order:order,likeFlag:likeFlag,tradeId:tradeId,start:start,end:end,myLatitude:myLatitude,myLongitude:myLongitude},
		function(result){
			var vipListDiv=$("#vipList_div");
			vipListDiv.empty();
			if(result.message=="ok"){
				var vipList=result.data;
				for(var i=0;i<vipList.length;i++){
					var shareCard=vipList[i];
					var appendStr="<div class=\"item\"";
						if(openId!=shareCard.openId)
							appendStr+=" onclick=\"goShare('"+shareCard.id+"','"+shareCard.shopId+"')\"";
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
								console.log(shopDistance)
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
								if(shareCard.discount!=null)
									appendStr+="&nbsp;&nbsp;折扣:"+shareCard.discount;
								appendStr+="</span>";
								var yysjStr=shareCard.startTime+"-"+shareCard.endTime;
								appendStr+="<span class=\"yysj_span\">"+yysjStr+"</span>";
							appendStr+="</div>";
							appendStr+="<div class=\"describe_div\">";
								var describe=shareCard.describe;
								appendStr+="<span class=\"describe_span\">"+(describe.length>20?describe.substring(0,20)+"...":describe)+"</span>";
							appendStr+="</div>";
						appendStr+="</div>";
					vipListDiv.append(appendStr);
				}
			}
			else{
				vipListDiv.append("<div style=\"font-size: 15px;text-align:center;\">暂无共享信息</div>");
			}
		}
	,"json");
}

function goShare(id,shopId){
	var postParams={id:id,shopId:shopId,from:"index",openId:openId};
	var urlParams="&page=homeShare";
	updatePageValue(postParams,urlParams);
}

function initTradeTab(){
	var name=$("#tradeName_inp").val();
	$.post("selectTrade",
		{name:name},
		function(result){
			var sliderListTab=$("#trade_tab");
			sliderListTab.empty();
			
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
						//console.log(i);
						sliderListTab.append("<tr></tr>");
					}
					var tr=sliderListTab.find("tr").last();
					tr.append("<td onclick=\"goShareCardList('"+trade.id+"','"+trade.name+"');\">"
								+"<img src=\""+trade.imgUrl+"\"/>"
								+"<div>"+trade.name+"</div>"
							+"</td>");
					dataCount++;
				}
				if(dataCount%5==0)
					sliderListTab.append("<tr></tr>");
				sliderListTab.find("tr").last().append("<td onclick=\"goTradeList()\">"
						+"<img src=\""+path+"resource/image/trade/all.png\"/>"
						+"<div>全部</div>"
					+"</td>");
				dataCount++;
				var yuShu=dataCount%rowSize;
				if(yuShu>0){
					for(var i=0;i<rowSize-yuShu;i++){
						var tr=sliderListTab.find("tr").last();
						tr.append("<td></td>");
					}
				}
			}
			else{
				sliderList.append("<div style=\"height:170px;line-height:170px;text-align: center;\">暂无行业</div>");
			}
		}
	,"json");
}

function initActivityDiv(){
	document.getElementById('activity_div').addEventListener('touchstart',touchstart, false);
	document.getElementById('activity_div').addEventListener('touchmove',touchmove, false);
	document.getElementById('activity_div').addEventListener('touchend',touchend, false);
	
	var marginTop=0;
	var marginLeft=0;
	var pageCount=3;
	sliderNumber=pageCount;
	var pagerDiv=$("#pager_div");
	pagerDiv.empty();
	for(var i=0;i<pageCount;i++){
		if(i==0)
			pagerDiv.append("<div class=\"item selected\" style=\"border-radius:5px;\"></div>");
		else if(i==pageCount-1){
			marginTop=-8;
			marginLeft+=40;
			pagerDiv.append("<div class=\"item unSelected\" style=\"margin-top:"+marginTop+"px;margin-left:"+marginLeft+"px;border-radius:5px;\"></div>");
		}
		else{
			marginTop=-8;
			marginLeft+=40;
			pagerDiv.append("<div class=\"item unSelected\" style=\"margin-top:"+marginTop+"px;margin-left:"+marginLeft+"px;\"></div>");
		}
	}
	document.getElementById("activity_list_div").style.transform = "translateX(0px)";//必须加上这行代码，不然屏幕往左边拖，右边会出现空白
}

function goShareCardList(tradeId,tradeName){
	var postParams={from:"homeIndex",tradeId:tradeId,tradeName:tradeName,openId:openId};
	var urlParams="&page=homeScl";
	updatePageValue(postParams,urlParams);
}

function goTradeList(){
	var postParams={action:"addShareCard",from:"homeIndex",openId:openId};
	var urlParams="&page=tradeList";
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
	initShareCardList(orderFlag,order,likeFlag,tradeId,start,end);
}

function searchByLike(likeFlag,tradeId,start,end){
	$("#likeFlag_hid").val(likeFlag);
	$("#tradeId_hid").val(tradeId);
	$("#start_hid").val(start);
	$("#end_hid").val(end);
	searchByOrder(4);
}

function showWdkjjDiv(){
	var wdkjjDiv=$("#wdkjj_div");
	var display=wdkjjDiv.css("display");
	if(display=="none")
		wdkjjDiv.css("display","block");
	else
		wdkjjDiv.css("display","none");
}

function goMine(pageFlag){
	var postParams,urlParams;
	switch (pageFlag) {
	case "wdxk":
		postParams={type:1,openId:openId};
		urlParams="&page=mineHandleList";
		updatePageValue(postParams,urlParams);
		break;
	case "wdzrk":
		location.href=path+"vip/goPage?page=mineTransferCard&openId="+openId;
		break;
	case "wzfdfxd":
		var postParams={type:1,openId:openId};
		var urlParams="&page=mineShareList";
		updatePageValue(postParams,urlParams);
		break;
	case "wfbdfxd":
		location.href=path+"vip/goPage?page=mySubmitMenu&openId="+openId;
		break;
	case "lq":
		location.href=path+"vip/goPage?page=mineSmallChange&openId="+openId;
		break;
	}
}

function touchstart(e){
  startX = e.touches[0].clientX;
  startTime = new Date().getTime();
  startTranslate = translateX;
  isSlide = true;
}
 
function touchmove(e){
  if (!isSlide) return
  var currentX = e.touches[0].clientX
  //2端溢出不能滑动
  if (startTranslate == 0 && currentX > startX) return;
  if (Math.abs(startTranslate) == width * (sliderNumber - 1) && currentX < startX) return;
 
  // 向右滑动时， 没数据无法滑动
  if (currentX < startX) {
	  
  }
 
  distance = currentX - startX;
  translateX = currentX - startX + startTranslate;
 
  document.getElementById("activity_list_div").style.transform = "translateX("+translateX+"px)"
}

function touchend(){
   if (!isSlide) return
 
  var duration = +new Date() - startTime
  var newTranslateX
  if (translateX > startTranslate) {
    // 向左划
    if (distance > width / 3 || (distance > 40 && duration < 600)) {
      newTranslateX = startTranslate + width;
    } else {
      newTranslateX = startTranslate
    }
  } else {
    // 向右划
    if (Math.abs(distance) > width / 3 || (Math.abs(distance) > 40 && duration < 600)) {
      newTranslateX = startTranslate - width;
    } else {
      newTranslateX = startTranslate
    }
  }
 
  translateX = newTranslateX;
  isSlide = false;
  distance = 0;
  index = Math.abs(newTranslateX / width)
  
  //console.log(startX);
  $(".pager_div .item").each(function(i){
	  if(i==index)
	  	$(this).attr("class","item selected");
	  else
	  	$(this).attr("class","item unSelected");
  });
 
  document.getElementById("activity_list_div").style.transform = "translateX("+translateX+"px)"
}

var deviveWidth = document.documentElement.clientWidth;
document.documentElement.style.fontSize = deviveWidth / 7.5 + 'px';

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
<title>华凌呦呦会员共享平台</title>
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
				<td onclick="hideChooseBgDiv(2,'',-1,100)">
					<div class="item_div">100以内</div>
				</td>
				<td onclick="hideChooseBgDiv(2,'',100,500)">
					<div class="item_div">100-500</div>
				</td>
			</tr>
			<tr>
				<td onclick="hideChooseBgDiv(2,'',500,1000)">
					<div class="item_div">500-1000</div>
				</td>
				<td onclick="hideChooseBgDiv(2,'',1000,-1)">
					<div class="item_div">1000以外</div>
				</td>
			</tr>
		</table>
		<div class="fxlTit_div">分享量</div>
		<table class="fxlList_tab" id="fxlList_tab">
			<tr>
				<td onclick="hideChooseBgDiv(3,'',-1,100)">
					<div class="item_div">100以下</div>
				</td>
				<td onclick="hideChooseBgDiv(3,'',100,500)">
					<div class="item_div">100-500</div>
				</td>
			</tr>
			<tr>
				<td onclick="hideChooseBgDiv(3,'',500,1000)">
					<div class="item_div">500-1000</div>
				</td>
				<td onclick="hideChooseBgDiv(3,'',1000,-1)">
					<div class="item_div">1000以上</div>
				</td>
			</tr>
		</table>
	</div>
</div>

<div class="top_div">
	<span class="location_span">${sessionScope.myLocation.city}</span>
	<div class="search_div">
		<img class="search_img" src="<%=basePath %>resource/image/001.png"/>
		<input type="text" class="tradeName_inp" id="tradeName_inp" placeholder="返场五折起，抢千万红包"/>
		<div class="searchBut_div" onclick="initTradeTab()">搜索</div>
	</div>
	<img class="wdkjj_img" src="<%=basePath %>resource/image/011.png" onclick="showWdkjjDiv()"/>
</div>
<div class="wdkjj_div" id="wdkjj_div">
	<div class="item_div" onclick="goMine('wdxk')">
		<img class="txt_img" alt="" src="<%=basePath %>resource/image/017.png">
		<span class="txt_span">我的新卡</span>
	</div>
	<div class="item_div" onclick="goMine('wdzrk')">
		<img class="txt_img" alt="" src="<%=basePath %>resource/image/017.png">
		<span class="txt_span">我的转让卡</span>
	</div>
	<div class="item_div" onclick="goMine('wzfdfxd')">
		<img class="txt_img" alt="" src="<%=basePath %>resource/image/018.png">
		<span class="txt_span">我支付的分享单</span>
	</div>
	<div class="item_div" onclick="goMine('wfbdfxd')">
		<img class="txt_img" alt="" src="<%=basePath %>resource/image/019.png">
		<span class="txt_span">我发布的分享单</span>
	</div>
	<div class="item_div" onclick="goMine('lq')">
		<img class="txt_img" alt="" src="<%=basePath %>resource/image/022.png">
		<span class="txt_span">零钱</span>
	</div>
</div>
<div class="trade_div flex">
	<table class="trade_tab" id="trade_tab" cellspacing="0"></table>
</div>
<!-- 
<div class="activity_div" id="activity_div">
	<div class="activity_list_div flex" id="activity_list_div">
		<div class="item_div" onclick="alert('未开通')">
			<div class="qdljf_span">签到领积分</div>
			<div class="dhhl_span">敬业签签到活动每天可签到1次，兑换好礼</div>
			<img class="right_img" alt="" src="<%=basePath %>resource/image/012.png">
		</div>
		<div class="item_div sjmfty_div" onclick="alert('未开通')">
			<div class="mftyk_span">VR体验馆</div>
			<div class="mfdd_span">虚拟现实 惊险刺激</div>
			<img class="right_img" alt="" src="<%=basePath %>resource/image/028.png">
		</div>
		<div class="item_div dzjk_div" onclick="alert('未开通')">
			<div class="mfdzjk_span">密室逃脱</div>
			<div class="dpfp_div">一款趣味刺激有挑战的情景体验</div>
			<img class="right_img" alt="" src="<%=basePath %>resource/image/027.png">
		</div>
	</div>
	<div class="pager_div" id="pager_div">
	</div>
</div>
 -->
<div class="newShareInfo_div">
	<span class="newShareInfo_span">
		最新共享信息发布
	</span>
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
<div class="vipList_div" id="vipList_div">
</div>
<jsp:include page="../foot.jsp"></jsp:include>
</body>
</html>