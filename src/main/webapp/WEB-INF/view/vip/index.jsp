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
$(function(){
	initTradeTab();
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
					vipListDiv.append("<div class=\"item\">"
							+"<img class=\"shopLogo_img\" src=\""+shareVip.shopLogo+"\"/>"
							+"<span class=\"shopName_span\">"+shareVip.shopName+"</span>"
							+"<span class=\"consumeCount_span\">80次年卡/剩余次数"+shareVip.consumeCount+"</span>"
							+"<span class=\"shareMoney_span\">价格￥"+shareVip.shareMoney+"元/次</span>"
							+"<span class=\"describe_span\">"+shareVip.describe+"</span>"
							+"<div class=\"shareBut_div\" onclick=\"goShare('"+shareVip.id+"')\">点击分享</div>"
							+"</div>");
				}
			}
			else{
				
			}
		}
	,"json");
}

function goShare(id){
	location.href=path+"vip/toShare?id="+id;
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
				for(var i=0;i<listLength;i++){
					var trade=tradeList[i];
					if(i%pageSize==0){
						if(i>0){
							marginTop=-170;
							marginLeft+=375;
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
				for(var i=0;i<yuShu;i++){
					var tr=sliderListDiv.find("table").last().find("tr").last();
					tr.append("<td></td>");
				}
				
				marginTop=0;
				marginLeft=0;
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
	location.href=path+"vip/toVipList?tradeId="+tradeId+"&tradeName="+tradeName;
}

var deviveWidth = document.documentElement.clientWidth;
document.documentElement.style.fontSize = deviveWidth / 7.5 + 'px';
</script>
<title>Insert title here</title>
<style>
.slider{
    overflow: hidden;
    flex:1;
  	height: 200px;
}
.slider-list{
    transition:all .6s;
  	height: 170px;
  	font-size:12px;
}
.slider-list table{
	width:100%;
	text-align:center;
}
.slider-list table tr{
	height:80px;
}
.slider-list table td{
	width:20%;
}
.slider-list table img{
	width:30px;
	height:30px;
	margin-left: -15px;
	position: absolute;
}
.slider-list table div{
	margin-top:35px;
	text-align:center;
}
.slider-list .item{
  	height: 170px;
  	text-align: center;
  	flex:none;
  	width: 375px;
} 
.slider-list .item1{
	/*
    background-color: red;
	*/
}
.slider-list .item2{
    background-color: yellow;
	margin-top:-170px;
	margin-left:375px;
}
.slider-list .item3{
    background-color: green;
	margin-top:-170px;
	margin-left:750px;
}
.slider-list .item4{
    background-color: blue;
	margin-top:-170px;
	margin-left:1125px;
}
.pager_div{
	width: 80px;
	height: 8px;
	margin-top:10px;
	margin:0 auto;
}
.pager_div .item{
	width: 40px;
	height: 8px;
}
.pager_div .selected{
	background-color: #1B81D3;
}
.pager_div .unSelected{
	background-color: #EEEEEE;
}
.vipList_div .item{
	width:100%;
	height:120px;
	border-bottom:#999 solid 1px;
}
.vipList_div .item .shopLogo_img{
	width:80px;
	height:80px;
	margin-top:10px;
	margin-left:10px;
}
.vipList_div .item .shopName_span{
	font-size:18px;
	margin-top:10px;
	margin-left:10px;
	position: absolute;
}
.vipList_div .item .consumeCount_span{
	font-size:15px;
	margin-top:40px;
	margin-left:10px;
	position: absolute;
}
.vipList_div .item .shareMoney_span{
	font-size:12px;
	margin-top:70px;
	margin-left:10px;
	position: absolute;
}
.vipList_div .item .describe_span{
	font-size:12px;
	margin-top:90px;
	margin-left:10px;
	color:#DE792B;
	background-color:#FEF4EB;
	position: absolute;
}
.vipList_div .item .shareBut_div{
	width:60px;
	height:20px;
	line-height:20px;
	margin-top:-60px;
	margin-left:280px;
	text-align:center;
	color:#fff;
	background-color:#03A6FF;
	font-size:12px;
}
.bottom_div{
	width:100%;
	height:60px;
	font-size:15px;
	background-color:#F6F6F6;
	bottom:0px;
	position:fixed;
}
.bottom_div .item{
	width:25%;
	height:60px;
	line-height:60px;
	text-align:center;
}
.bottom_div .img_div{
	width:30px;
	height:30px;
	margin-top: 5px;
}
.bottom_div .text_div{
	margin-top:-19px;
	text-align:center;
}
.bottom_div .index_div{
	color:#0091FE;
}
.bottom_div .swk_div{
	margin-top:-60px;
	margin-left:25%;
	color:#808080;
}
.bottom_div .fxk_div{
	margin-top:-60px;
	margin-left:50%;
	color:#808080;
}
.bottom_div .wd_div{
	margin-top:-60px;
	margin-left:75%;
	color:#808080;
}
</style>
</head>
<body style="margin: 0px;">
<div style="width:100%;height:40px;background-color:#1B82D1;">
	<span style="font-size:15px;color:#fff;margin-top: 10px;margin-left: 10px;position: absolute;">青岛</span>
	<div style="width:200px;height:30px;margin-top: 5px;margin-left: 60px;background-color:#fff;position: absolute;">
		<img src="<%=basePath %>resource/image/001.png" style="width:30px;height:30px;" onclick="initTradeTab()"/>
		<input type="text" id="tradeName_inp" style="width:140px;height:25px;position: absolute;"/>
	</div>
	<img src="<%=basePath %>resource/image/011.png" style="width:30px;height:30px;margin-top: 5px;margin-right: 5px;float: right;"/>
	<img src="<%=basePath %>resource/image/010.png" style="width:30px;height:30px;margin-top: 5px;margin-right: 20px;float: right;"/>
</div>
<div class="slider" id="slider">
  <div class="slider-list flex" id="slider-list">
  	<!-- 
    <div class="item item1">
		<table cellspacing="0">
			<tr>
				<td>
					<img src="<%=basePath %>resource/image/trade/xiche.png"/>
					<div>洗车</div>
				</td>
				<td>
					<img src="<%=basePath %>resource/image/trade/jianshen.png"/>
					<div>健身</div>
				</td>
				<td>
					<img src="<%=basePath %>resource/image/trade/xiyu.png"/>
					<div>洗浴</div>
				</td>
				<td>
					<img src="<%=basePath %>resource/image/trade/meirongmeifa.png"/>
					<div>美容美发</div>
				</td>
				<td>
					<img src="<%=basePath %>resource/image/trade/zuliao.png"/>
					<div>足疗</div>
				</td>
			</tr>
			<tr>
				<td>
					<img src="<%=basePath %>resource/image/trade/baojianyangsheng.png"/>
					<div>保健养生</div>
				</td>
				<td>
					<img src="<%=basePath %>resource/image/trade/ktv.png"/>
					<div>KTV</div>
				</td>
				<td>
					<img src="<%=basePath %>resource/image/trade/sheying.png"/>
					<div>摄影</div>
				</td>
				<td>
					<img src="<%=basePath %>resource/image/trade/jingqu.png"/>
					<div>景区</div>
				</td>
				<td>
					<img src="<%=basePath %>resource/image/trade/dianying.png"/>
					<div>电影</div>
				</td>
			</tr>
		</table>
	</div>
    <div class="item item2">滑块2</div>
    <div class="item item3">滑块3</div>
    <div class="item item4">滑块4</div>
     -->
  </div>
  <div class="pager_div" id="pager_div">
  	 <!-- 
  	 <div style="width: 40px;height: 8px;background-color: #1B81D3;border-radius:5px;"></div>
  	 <div style="width: 40px;height: 8px;margin-top:-8px;margin-left:40px;background-color: #EEEEEE;"></div>
  	  -->
  </div>
</div>
<div style="width:350px;margin:0 auto;margin-top:10px;">
	<div style="width:170px;height:75px;border:#989898 solid 0.1px;">
		<span style="font-size:15px;margin-top: 10px;margin-left: 15px;font-weight:bold;position: absolute;">签到领积分</span>
		<span style="font-size:12px;margin-top: 37px;margin-left: 15px;color:#989898;position: absolute;">兑换好礼</span>
		<img src="<%=basePath %>resource/image/012.png" style="width:40px;height:40px;margin-top: 20px;margin-left: 120px;"/>
	</div>
	<div style="font-size:20px;width:170px;height:75px;margin-top:-75px;margin-left:180px;border:#989898 solid 0.1px;">
		<span style="font-size:15px;margin-top: 10px;margin-left: 15px;font-weight:bold;position: absolute;">商家免费体验卡</span>
		<span style="font-size:12px;margin-top: 37px;margin-left: 15px;color:#989898;position: absolute;">免费多多</span>
		<img src="<%=basePath %>resource/image/013.png" style="width:40px;height:40px;margin-top: 20px;margin-left: 120px;"/>
	</div>
</div>
<div style="font-size:18px;">
最新共享信息发布
</div>
<div class="vipList_div" id="vipList_div">
	<!-- 
	<div class="item">
		<img class="shopLogo_img" src=""/>
		<span class="shopName_span">岳家庄</span>
		<span class="consumeCount_span">80次年卡/剩余次数56</span>
		<span class="shareMoney_span">价格￥10元/次</span>
		<span class="describe_span">aaaaaaaaaaa</span>
		<div class="shareBut_div">点击分享</div>
	</div>
	 -->
</div>
<div class="bottom_div">
	<div class="item index_div">
		<img class="img_div" src="<%=basePath %>resource/image/002.png"/>
		<div class="text_div">首页</div>
	</div>
	<div class="item swk_div">
		<img class="img_div" src="<%=basePath %>resource/image/005.png"/>
		<div class="text_div">租实物卡</div>
	</div>
	<div class="item fxk_div">
		<img class="img_div" src="<%=basePath %>resource/image/007.png"/>
		<div class="text_div">分享单</div>
	</div>
	<div class="item wd_div">
		<img class="img_div" src="<%=basePath %>resource/image/009.png"/>
		<div class="text_div">我的</div>
	</div>
</div>
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
var sliderNumber = 4;//滑块是数量，控制溢出不能滑动
 
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
  
  console.log(index);
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