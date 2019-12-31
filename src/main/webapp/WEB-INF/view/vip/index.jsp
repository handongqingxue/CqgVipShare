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
					tr.append("<td style=\"width:48%;\" onclick=\"hideChooseDiv()\"><div style=\"width:130px;height:40px;line-height:40px;font-size:15px;color:#3C3C3C;margin:0 auto;border:#DEDEDE solid 1px;\">"+tradeList[i].name+"</div></td>");
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

function showChooseDiv(){
	$("#choose_div").css("display","block");
}

function hideChooseDiv(){
	$("#choose_div").css("display","none");
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
  	width: 100%;
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
	width:90px;
	height:90px;
	margin-top:10px;
	margin-left:10px;
}
.vipList_div .item .shopName_span{
	font-size:16px;
	font-weight:bold;
	margin-top:10px;
	margin-left:10px;
	position: absolute;
}
.vipList_div .item .consumeCount_span{
	font-size:13px;
	margin-top:40px;
	margin-left:10px;
	color:#7F7F7F;
	position: absolute;
}
.vipList_div .item .shareMoney_span{
	font-size:12px;
	margin-top:66px;
	margin-left:10px;
	color:#B1B1B1;
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
	float:right;
	margin-top:65px;
	margin-right:20px;
	text-align:center;
	color:#fff;
	background-color:#03A6FF;
	font-size:12px;
}
</style>
</head>
<body style="margin: 0px;">
<div id="choose_div" style="width: 100%;height: 100%;background-color: rgba(0,0,0,0.5);position: fixed;display: none;z-index: 1;">
	<div style="width: 300px;height: 100%;float:right;background-color: #fff;">
		<div style="width: 100%;height: 30px;line-height: 30px;font-size: 15px;text-align: center;">行业</div>
		<table id="tradeList_tab" style="width: 100%;text-align: center;">
		</table>
		<div style="width: 100%;height: 30px;line-height: 30px;font-size: 15px;text-align: center;">距离（m）</div>
		<table id="jlList_tab" style="width: 100%;text-align: center;">
			<tr>
				<td style="width:48%;" onclick="hideChooseDiv()">
					<div style="width:130px;height:40px;line-height:40px;font-size:15px;color:#3C3C3C;margin:0 auto;border:#DEDEDE solid 1px;">100以内</div>
				</td>
				<td style="width:48%;" onclick="hideChooseDiv()">
					<div style="width:130px;height:40px;line-height:40px;font-size:15px;color:#3C3C3C;margin:0 auto;border:#DEDEDE solid 1px;">100-500</div>
				</td>
			</tr>
			<tr>
				<td style="width:48%;" onclick="hideChooseDiv()">
					<div style="width:130px;height:40px;line-height:40px;font-size:15px;color:#3C3C3C;margin:0 auto;border:#DEDEDE solid 1px;">500-1000</div>
				</td>
				<td style="width:48%;" onclick="hideChooseDiv()">
					<div style="width:130px;height:40px;line-height:40px;font-size:15px;color:#3C3C3C;margin:0 auto;border:#DEDEDE solid 1px;">1000以外</div>
				</td>
			</tr>
		</table>
		<div style="width: 100%;height: 30px;line-height: 30px;font-size: 15px;text-align: center;">分享量</div>
		<table id="fxlList_tab" style="width: 100%;text-align: center;">
			<tr>
				<td style="width:48%;" onclick="hideChooseDiv()">
					<div style="width:130px;height:40px;line-height:40px;font-size:15px;color:#3C3C3C;margin:0 auto;border:#DEDEDE solid 1px;">100以下</div>
				</td>
				<td style="width:48%;" onclick="hideChooseDiv()">
					<div style="width:130px;height:40px;line-height:40px;font-size:15px;color:#3C3C3C;margin:0 auto;border:#DEDEDE solid 1px;">100-500</div>
				</td>
			</tr>
			<tr>
				<td style="width:48%;" onclick="hideChooseDiv()">
					<div style="width:130px;height:40px;line-height:40px;font-size:15px;color:#3C3C3C;margin:0 auto;border:#DEDEDE solid 1px;">500-1000</div>
				</td>
				<td style="width:48%;" onclick="hideChooseDiv()">
					<div style="width:130px;height:40px;line-height:40px;font-size:15px;color:#3C3C3C;margin:0 auto;border:#DEDEDE solid 1px;">1000以上</div>
				</td>
			</tr>
		</table>
	</div>
</div>
<div style="width:100%;height:40px;background-color:#1B82D1;">
	<span style="font-size:15px;color:#fff;margin-top: 10px;margin-left: 10px;position: absolute;">青岛</span>
	<div style="width:273px;height:30px;margin-top: 5px;margin-left: 60px;background-color:#fff;position: absolute;">
		<img src="<%=basePath %>resource/image/001.png" style="width:20px;height:20px;margin-top: 8px;margin-left: 5px;" onclick="initTradeTab()"/>
		<input type="text" id="tradeName_inp" placeholder="返场五折起，抢千万红包" style="width:239px;height:28px;margin-left: 5px;border:0px;position: absolute;"/>
	</div>
	<img src="<%=basePath %>resource/image/011.png" style="width:30px;height:30px;margin-top: 5px;margin-right: 5px;float: right;"/>
</div>
<div class="slider" id="slider">
  <div class="slider-list flex" id="slider-list">
  </div>
  <div class="pager_div" id="pager_div">
  </div>
</div>
<div style="width:362px;margin:0 auto;margin-top:10px;">
	<div style="width:175px;height:63px;background-image: url('../resource/image/012.png');background-repeat:no-repeat; background-size:100% 100%;-moz-background-size:100% 100%;">
		<span style="font-size:15px;margin-top: 10px;margin-left: 15px;font-weight:bold;position: absolute;">签到领积分</span>
		<span style="font-size:12px;margin-top: 37px;margin-left: 15px;color:#989898;position: absolute;">兑换好礼</span>
	</div>
	<div style="font-size:20px;width:175px;height:63px;margin-top:-63px;margin-left:187px;background-image: url('../resource/image/013.png');background-repeat:no-repeat; background-size:100% 100%;-moz-background-size:100% 100%;">
		<span style="font-size:15px;margin-top: 10px;margin-left: 15px;font-weight:bold;position: absolute;">商家免费体验卡</span>
		<span style="font-size:12px;margin-top: 37px;margin-left: 15px;color:#989898;position: absolute;">免费多多</span>
	</div>
</div>
<img alt="" src="<%=basePath %>resource/image/016.png" style="width: 100%;height: 130px;"/>
<div style="width:100%;height:50px;line-height:50px;font-size:16px;font-weight: bold;font-family:'Microsoft YaHei';">
	<span style="margin-left:10px;">
		最新共享信息发布
	</span>
</div>
<div style="width:100%;height:30px;line-height:30px;font-size:14px;">
	<span style="margin-left:10px;color: #00a7ff;">
		综合排序
	</span>
	<span style="margin-left:20px;">
		距离
	</span>
	<span style="margin-left:20px;">
		分享量
	</span>
	<span style="margin-right:20px;float: right;" onclick="showChooseDiv()">
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