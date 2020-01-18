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
var myLatitude='${sessionScope.myLocation.latitude}';
var myLongitude='${sessionScope.myLocation.longitude}';
$(function(){
	initVipList(1,"asc",0,0,0);
});

function initVipList(orderFlag,order,likeFlag,start,end){
	$.post("selectVipList",
		{orderFlag:orderFlag,order:order,likeFlag:likeFlag,tradeId:tradeId,start:start,end:end,myLatitude:myLatitude,myLongitude:myLongitude},
		function(result){
			//console.log(result);
			var vipListDiv=$("#vipList_div");
			vipListDiv.empty();
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
							+"<div class=\"line_div\"></div>"
							+"</div>");
				}
			}
			else{
				vipListDiv.append("<div style=\"font-size: 15px;text-align:center;\">暂无共享信息</div>");
			}
		}
	,"json");
}

function showChooseBgDiv(){
	$("#chooseBg_div").css("display","block");
}

function hideChooseBgDiv(likeFlag,start,end){
	$("#chooseBg_div").css("display","none");
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
	initVipList(orderFlag,order,likeFlag,start,end);
}

function searchByLike(likeFlag,start,end){
	$("#likeFlag_hid").val(likeFlag);
	$("#start_hid").val(start);
	$("#end_hid").val(end);
	searchByOrder(4);
}

function goShopList(){
	location.href=path+"vip/toShopList?tradeId="+tradeId+"&tradeName="+encodeURI(tradeName)+"&prePage=vipList&action=addShareVip&openId="+openId;
}

function goBack(){
	location.href=path+"vip/toIndex?openId="+openId;
}
</script>
<style type="text/css">
.chooseBg_div{
	width: 100%;
	height: 100%;
	background-color: rgba(0,0,0,0.5);
	position: fixed;
	display: none;
	z-index: 1;
}
.choose_div{
	width: 300px;
	height: 100%;
	float:right;
	background-color: #fff;
}
.jlTit_div,.fxlTit_div{
	width: 100%;
	height: 30px;
	line-height: 30px;
	font-size: 15px;
	text-align: center;
}
.jlList_tab,.fxlList_tab{
	width: 100%;
	text-align: center;
}
.jlList_tab td,.fxlList_tab td{
	width:48%;
}
.jlList_tab .item_div,.fxlList_tab .item_div{
	width:130px;
	height:40px;
	line-height:40px;
	font-size:15px;
	color:#3C3C3C;
	margin:0 auto;
	border:#DEDEDE solid 1px;
}
.order_div{
	width:100%;
	height:30px;
	line-height:30px;
	font-size:14px;
	background-color: #fff;
}
.order_div .zhpx_span{
	margin-left:10px;
	color: #00a7ff;
}
.order_div .jl_span{
	margin-left:20px;
}
.order_div .fxl_span{
	margin-left:20px;
}
.order_div .sx_span{
	margin-right:20px;
	float: right;
}
.vipList_div .item{
	width:100%;
	height:120px;
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
.vipList_div .item .line_div{
	float: right;
	width: 76%;
	height:0.5px;
	background-color:#eee;
}
</style>
<title>行业内页</title>
</head>
<body style="margin: 0px;">
<div class="chooseBg_div" id="chooseBg_div">
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

<div style="width: 100%;height: 40px;line-height: 40px;color:#fff;background-color: #EC4149;">
	<span style="margin-left: 10px;" onclick="goBack()">&lt;返回</span>
	<span style="margin-left: 50px;">${param.tradeName }会员共享</span>
	<span style="margin-right: 15px;float: right;" onclick="goShopList()">发布</span>
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
	<span class="sx_span" onclick="showChooseBgDiv()">
		筛选
	</span>
</div>
<div class="vipList_div" id="vipList_div">
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