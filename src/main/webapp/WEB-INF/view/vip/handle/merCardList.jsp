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
<link rel="stylesheet" href="<%=basePath %>resource/css/vip/handle/merCardList.css"/>
<script type="text/javascript" src="<%=basePath %>resource/js/jquery-3.3.1.js"></script>
<script type="text/javascript">
var path='<%=basePath %>';
var openId='${param.openId}';
var shopId='${param.shopId}';
var logo='${param.logo}';
var shopName='${param.shopName}';
var shopAddress='${param.shopAddress}';
var tradeId='${param.tradeId}';
var tradeName='${param.tradeName}';
var from='${param.from}';
var prePage='${param.prePage}';
var action='${param.action}';
$(function(){
	initCardType();
	initList();
});

function initCardType(){
	$.post("selectMerCardTypeList",
		{shopId:shopId},
		function(result){
			var cardTypeDiv=$("#cardType_div");
			cardTypeDiv.append("<div class=\"item_div selected\" onclick=\"initList()\">全部</div>");
			if(result.message=="ok"){
				var cardTypeList=result.data;
				for(var i=0;i<cardTypeList.length;i++){
					var cardType=cardTypeList[i];
					var type=cardType.type;
					var marginLeft=100*(i+1);
					var typeName;
					switch (type) {
					case 1:
						typeName="年卡";
						break;
					case 2:
						typeName="季卡";
						break;
					case 3:
						typeName="月卡";
						break;
					case 4:
						typeName="充值卡";
						break;
					case 5:
						typeName="次卡";
						break;
					}
					cardTypeDiv.append("<div class=\"item_div unSelected\" id=\"item_div"+type+"\" style=\"margin-left: "+marginLeft+"px;margin-top: -27px;\" onclick=\"initList("+type+")\">"+typeName+"</div>");
				}
			}
		}
	,"json");
}

function initList(type){
	$.post("selectMerchantCardList",
		{shopId:shopId,type:type},
		function(result){
			$("#cardType_div div").attr("class","item_div unSelected");
			if(type==undefined)
				$("#cardType_div div").eq(0).attr("class","item_div selected");
			else
				$("#cardType_div #item_div"+type).attr("class","item_div selected");
			
			var mcListDiv=$("#mcList_div");
			mcListDiv.empty();
			if(result.message=="ok"){
				var mcList=result.data;
				for(var i=0;i<mcList.length;i++){
					var merchantCard=mcList[i];
					var appendStr="<div class=\"item\"";
						if(openId!=merchantCard.openId&type==undefined)
							appendStr+=" onclick=\"toAddHandleRecord('"+merchantCard.id+"','"+merchantCard.money+"')\"";
						appendStr+=">";
						appendStr+="<img class=\"shopLogo_img\" src=\""+merchantCard.shopLogo+"\"/>";
						appendStr+="<span class=\"shopName_span\">"+merchantCard.shopName+"</span>";
						appendStr+="<span class=\"consumeCount_span\">"+merchantCard.name;
						if(merchantCard.type==5)
							appendStr+="/次数"+merchantCard.consumeCount;
						appendStr+="</span>";
						appendStr+="<span class=\"shareMoney_span\">￥"+merchantCard.money;
						if(merchantCard.type==5)
							appendStr+="元/次";
						else
							appendStr+="元";
						if(merchantCard.discount!=null)
							appendStr+="&nbsp;&nbsp;"+merchantCard.discount+"折";
						appendStr+="</span>";
						appendStr+="<span class=\"describe_span\">"+merchantCard.describe+"</span>";
						appendStr+="</div>";
						
						if(openId!=merchantCard.openId&type!=undefined){
							appendStr+="<div class=\"banKa_div\" onclick=\"toAddHandleRecord('"+merchantCard.id+"','"+merchantCard.money+"')\">";
								appendStr+="<span class=\"tit_span\">办卡</span>";
								appendStr+="<span class=\"desc_span\">在线办卡，省时省心</span>";
								appendStr+="<div class=\"wybkBut_div\">我要办卡</div>";
							appendStr+="</div>";
						}
					mcListDiv.append(appendStr);
				}
			}
			else{
				mcListDiv.append("<div style=\"font-size: 15px;text-align:center;\">暂无会员信息</div>");
			}
		}
	,"json");
}

function toAddHandleRecord(id,money){
	location.href=path+"vip/goPage?page=handleAhr&tradeId="+tradeId+"&tradeName="+tradeName+"&shopId="+shopId+"&shopName="+shopName+"&shopAddress="+shopAddress+"&logo="+logo+"&prePage="+prePage+"&action="+action+"&from="+from+"&openId="+openId+"&mcId="+id+"&money="+money;
}

function goBack(){
	location.href=path+"vip/goPage?page=shopList&tradeId="+tradeId+"&tradeName="+tradeName+"&prePage="+prePage+"&action="+action+"&openId="+openId+"&from="+from;
}
</script>
<title>店铺会员卡</title>
</head>
<body>
<div class="top_div">
	<span>会员办理</span>
</div>
<div class="back_div">
	<span class="back_span" onclick="goBack()">&lt;返回</span>
</div>
<div class="logo_div">
	<img class="logo_img" alt="" src="${param.logo }">
</div>
<div class="row_div shopName_div">${param.shopName }</div>
<div class="repuImg_div">
	<img class="repu1_img" id="repu1_img" alt="" src="<%=basePath%>resource/image/star_yellow.png">
	<img class="repu2_img" id="repu2_img" alt="" src="<%=basePath%>resource/image/star_yellow.png">
	<img class="repu3_img" id="repu3_img" alt="" src="<%=basePath%>resource/image/star_yellow.png">
	<img class="repu4_img" id="repu4_img" alt="" src="<%=basePath%>resource/image/star_yellow.png">
	<img class="repu5_img" id="repu5_img" alt="" src="<%=basePath%>resource/image/star_yellow.png">
	<span class="score_span">5</span>
</div>
<div class="row_div state_div">
	<span>营业中</span><span class="openTime_span">周二至周日 09:00-21:00</span>
</div>
<div class="line_div"></div>
<div class="row_div shopAddress_div">
	${param.shopAddress }
</div>
<div class="space_div"></div>
<div class="row_div gxhykxx_div">
	会员卡
</div>
<div class="row_div cardType_div" id="cardType_div">
	<!-- 
	<div class="item_div selected">全部</div>
	<div class="item_div unSelected" style="margin-left: 100px;margin-top: -27px;">金额卡</div>
	<div class="item_div unSelected" style="margin-left: 200px;margin-top: -27px;">次卡</div>
	 -->
</div>
<div class="mcList_div" id="mcList_div">
</div>
<div class="space_div"></div>
<div class="yhpj_div">
	<div class="tit_div">用户评价(0)</div>
</div>
</body>
</html>