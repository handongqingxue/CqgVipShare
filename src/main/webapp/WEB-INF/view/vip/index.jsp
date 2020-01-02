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
<link rel="stylesheet" href="<%=basePath %>resource/css/vip/index.css"/>
<script type="text/javascript" src="<%=basePath %>resource/js/jquery-3.3.1.js"></script>
<script type="text/javascript">
var path='<%=basePath %>';
var openId='${param.openId}';
$(function(){
	initTradeTab();
	initSXTradeDiv();
	initVipList();
});

function initVipList(){
	$.post("selectVipList",
		function(result){
			var vipListDiv=$("#vipList_div");
			if(result.message=="ok"){
				var vipList=result.data;
				for(var i=0;i<vipList.length;i++){
					var shareVip=vipList[i];
					var appendStr="<div class=\"item\">";
						appendStr+="<img class=\"shopLogo_img\" src=\""+shareVip.shopLogo+"\"/>";
						appendStr+="<span class=\"shopName_span\">"+shareVip.shopName+"</span>";
						appendStr+="<span class=\"consumeCount_span\">"+shareVip.name+"/剩余次数"+shareVip.consumeCount+"</span>";
						appendStr+="<span class=\"shareMoney_span\">价格￥"+shareVip.shareMoney+"元/次</span>";
						appendStr+="<span class=\"describe_span\">"+shareVip.describe+"</span>";
						if(openId!=shareVip.openId)
							appendStr+="<div class=\"shareBut_div\" onclick=\"goShare('"+shareVip.id+"')\">点击分享</div>";
						appendStr+="<div class=\"line_div\"></div>";
						appendStr+="</div>";
					vipListDiv.append(appendStr);
				}
			}
			else{
				
			}
		}
	,"json");
}

function goShare(id){
	location.href=path+"vip/toShare?id="+id+"&openId="+openId;
}

function initTradeTab(){
	var name=$("#tradeName_inp").val();
	$.post("selectTrade",
		{name:name},
		function(result){
			var sliderListDiv=$("#slider-list");
			sliderListDiv.empty();
			var pagerDiv=$("#pager_div");
			pagerDiv.empty();
			
			if(result.message=="ok"){
				var tradeList=result.data;
				var marginTop=0;
				var marginLeft=0;
				var listLength=tradeList.length;
				var pageSize=10;
				var pageCount=0;
				var rowSize=5;
				var bw=$("body").css("width");
				bw=bw.substring(0,bw.length-2);
				for(var i=0;i<listLength;i++){
					var trade=tradeList[i];
					if(i%pageSize==0){
						if(i>0){
							marginTop=-170;
							marginLeft+=bw;
						}
						sliderListDiv.append("<div class=\"item\" style=\"margin-top:"+marginTop+"px;margin-left:"+marginLeft+"px;\"><table cellspacing=\"0\"></table></div>");
						pageCount++;
					}
					var table=sliderListDiv.find("table").last();
					if(i%5==0){
						console.log(i);
						table.append("<tr></tr>");
					}
					var tr=table.find("tr").last();
					tr.append("<td onclick=\"goVipList('"+trade.id+"','"+trade.name+"');\">"
								+"<img src=\""+path+trade.imgUrl+"\"/>"
								+"<div>"+trade.name+"</div>"
							+"</td>");
				}
				var yuShu=listLength%pageSize;
				for(var i=0;i<rowSize-yuShu;i++){
					var tr=sliderListDiv.find("table").last().find("tr").last();
					tr.append("<td></td>");
				}
				
				marginTop=0;
				marginLeft=0;
				sliderNumber=pageCount;
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
			}
			else{
				sliderList.append("<div style=\"height:170px;line-height:170px;text-align: center;\">暂无行业</div>");
			}
		}
	,"json");
}

function goVipList(tradeId,tradeName){
	location.href=path+"vip/toVipList?tradeId="+tradeId+"&tradeName="+tradeName+"&openId="+openId;
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
					tr.append("<td style=\"width:48%;\" onclick=\"hideChooseBgDiv()\"><div style=\"width:130px;height:40px;line-height:40px;font-size:15px;color:#3C3C3C;margin:0 auto;border:#DEDEDE solid 1px;\">"+tradeList[i].name+"</div></td>");
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

function showChooseBgDiv(){
	$("#chooseBg_div").css("display","block");
}

function hideChooseBgDiv(){
	$("#chooseBg_div").css("display","none");
}

var deviveWidth = document.documentElement.clientWidth;
document.documentElement.style.fontSize = deviveWidth / 7.5 + 'px';
</script>
<title>Insert title here</title>
</head>
<body>
<div class="chooseBg_div" id="chooseBg_div">
	<div class="choose_div">
		<div class="tradeTit_div">行业</div>
		<table class="tradeList_tab" id="tradeList_tab">
		</table>
		<div class="jlTit_div">距离（m）</div>
		<table class="jlList_tab" id="jlList_tab">
			<tr>
				<td onclick="hideChooseBgDiv()">
					<div class="item_div">100以内</div>
				</td>
				<td onclick="hideChooseBgDiv()">
					<div class="item_div">100-500</div>
				</td>
			</tr>
			<tr>
				<td onclick="hideChooseBgDiv()">
					<div class="item_div">500-1000</div>
				</td>
				<td onclick="hideChooseBgDiv()">
					<div class="item_div">1000以外</div>
				</td>
			</tr>
		</table>
		<div class="fxlTit_div">分享量</div>
		<table class="fxlList_tab" id="fxlList_tab">
			<tr>
				<td onclick="hideChooseBgDiv()">
					<div class="item_div">100以下</div>
				</td>
				<td onclick="hideChooseBgDiv()">
					<div class="item_div">100-500</div>
				</td>
			</tr>
			<tr>
				<td onclick="hideChooseBgDiv()">
					<div class="item_div">500-1000</div>
				</td>
				<td onclick="hideChooseBgDiv()">
					<div class="item_div">1000以上</div>
				</td>
			</tr>
		</table>
	</div>
</div>

<div class="top_div">
	<span class="location_span">青岛</span>
	<div class="search_div">
		<img class="search_img" src="<%=basePath %>resource/image/001.png" onclick="initTradeTab()"/>
		<input type="text" class="tradeName_inp" id="tradeName_inp" placeholder="返场五折起，抢千万红包"/>
	</div>
	<img src="<%=basePath %>resource/image/011.png" style="width:30px;height:30px;margin-top: 5px;margin-right: 5px;float: right;"/>
</div>
<div class="slider" id="slider">
  <div class="slider-list flex" id="slider-list">
  </div>
  <div class="pager_div" id="pager_div">
  </div>
</div>
<div class="activity_div">
	<div class="left_div">
		<span class="qdljf_span">签到领积分</span>
		<span class="dhhl_span">兑换好礼</span>
	</div>
	<div class="right_div">
		<span class="mftyk_span">商家免费体验卡</span>
		<span class="mfdd_span">免费多多</span>
	</div>
</div>
<img class="activity_img" alt="" src="<%=basePath %>resource/image/016.png"/>
<div class="newShareInfo_div">
	<span class="newShareInfo_span">
		最新共享信息发布
	</span>
</div>
<div class="order_div">
	<span class="zhpx_span">
		综合排序
	</span>
	<span class="jl_span">
		距离
	</span>
	<span class="fxl_span">
		分享量
	</span>
	<span class="sx_span" onclick="showChooseBgDiv()">
		筛选
	</span>
</div>
<div class="vipList_div" id="vipList_div">
</div>
<jsp:include page="foot.jsp"></jsp:include>
<script type="text/javascript" charset="utf-8" src="./js/jquery.min.js"></script>
<script type="text/javascript" charset="utf-8" src="./js/fastclick.js"></script>
<script type="text/javascript" charset="utf-8" src="./js/global.js"></script>
<script type="text/javascript">
document.getElementById('slider').addEventListener('touchstart',touchstart, false);
document.getElementById('slider').addEventListener('touchmove',touchmove, false);
document.getElementById('slider').addEventListener('touchend',touchend, false);
 
var width = document.documentElement.clientWidth;
var startX =0;
var index = 0;
var translateX = 0;
var startTime;
var startTranslate;
var isSlide = false;
var sliderNumber = 0;//滑块是数量，控制溢出不能滑动
 
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
 
  document.getElementById("slider-list").style.transform = "translateX("+translateX+"px)"
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
  
  console.log(startX);
  $(".pager_div .item").each(function(i){
	  if(i==index)
	  	$(this).attr("class","item selected");
	  else
	  	$(this).attr("class","item unSelected");
  });
 
  document.getElementById("slider-list").style.transform = "translateX("+translateX+"px)"
}
</script>
</body>
</html>