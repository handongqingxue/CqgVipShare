<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String basePath=request.getScheme()+"://"+request.getServerName()+":"
	+request.getServerPort()+request.getContextPath()+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
<link rel="stylesheet" href="<%=basePath %>resource/css/vip/home/share.css"/>
<script type="text/javascript" src="<%=basePath %>resource/js/jquery-3.3.1.js"></script>
<script type="text/javascript">
var path='<%=basePath%>';
var id='${requestScope.pageValue.id}';
var openId='${param.openId}';
var shopId='${requestScope.pageValue.shopId}';
var shopName='${requestScope.shareInfo.shopName }';
var logo='${requestScope.shareInfo.logo }';
var from='${requestScope.pageValue.from}';
$(function(){
	initRepuImg();
	initYYInfo();
	initMerCommList();
});

function initRepuImg(){
	var reputation=${requestScope.shareInfo.reputation };
	if(reputation==1){
		$("#repu1_img").attr("src",path+"resource/image/star_yellow.png");
	}
	else if(reputation==2){
		$("#repu1_img").attr("src",path+"resource/image/star_yellow.png");
		$("#repu2_img").attr("src",path+"resource/image/star_yellow.png");
	}
	else if(reputation==3){
		$("#repu1_img").attr("src",path+"resource/image/star_yellow.png");
		$("#repu2_img").attr("src",path+"resource/image/star_yellow.png");
		$("#repu3_img").attr("src",path+"resource/image/star_yellow.png");
	}
	else if(reputation==4){
		$("#repu1_img").attr("src",path+"resource/image/star_yellow.png");
		$("#repu2_img").attr("src",path+"resource/image/star_yellow.png");
		$("#repu3_img").attr("src",path+"resource/image/star_yellow.png");
		$("#repu4_img").attr("src",path+"resource/image/star_yellow.png");
	}
	else if(reputation==5){
		$("#repu1_img").attr("src",path+"resource/image/star_yellow.png");
		$("#repu2_img").attr("src",path+"resource/image/star_yellow.png");
		$("#repu3_img").attr("src",path+"resource/image/star_yellow.png");
		$("#repu4_img").attr("src",path+"resource/image/star_yellow.png");
		$("#repu5_img").attr("src",path+"resource/image/star_yellow.png");
	}
}

function initYYInfo(){
	var weekday='${requestScope.shareInfo.weekday}';
	var shopStartTime='${requestScope.shareInfo.shopStartTime }';
	var sstArr=shopStartTime.split(":");
	var ssth=sstArr[0];
	var sstm=sstArr[1];
	var shopEndTime='${requestScope.shareInfo.shopEndTime }';
	var setArr=shopEndTime.split(":");
	var seth=setArr[0];
	var setm=setArr[1];
	var weekdayArr=weekday.split(",");
	var weekdayTxt="";
	for(var i=1;i<=7;i++){
		if(weekdayArr[i-1]==0){
			if(weekdayTxt.substring(weekdayTxt.length-1).indexOf("至")!=-1){
				weekdayTxt+="周";
				switch (i-1) {
				case 3:
					weekdayTxt+="三";
					break;
				case 4:
					weekdayTxt+="四";
					break;
				case 5:
					weekdayTxt+="五";
					break;
				case 6:
					weekdayTxt+="六";
					break;
				case 7:
					weekdayTxt+="日";
					break;
				}
			}
			continue;
		}
		else{
			if(weekdayTxt.indexOf("周")!=-1)
				continue;
			else{
				weekdayTxt="周";
				switch (i) {
				case 1:
					weekdayTxt+="一至";
					break;
				case 2:
					weekdayTxt+="二至";
					break;
				case 3:
					weekdayTxt+="三至";
					break;
				case 4:
					weekdayTxt+="四至";
					break;
				case 5:
					weekdayTxt+="五至";
					break;
				case 6:
					weekdayTxt+="六至";
					break;
				case 7:
					weekdayTxt+="日至";
					break;
				}
			}
		}
	}
	var date=new Date();
	var hour=date.getHours();
	var minutes=date.getMinutes();
	var stateTxt;
	var stateFlag;
	if(hour>=ssth&hour<seth){
		if(sstm==0&setm==0){
			stateFlag=true;
		}
		else if(sstm>0&setm==0){
			if(minutes>=sstm)
				stateFlag=true;
			else
				stateFlag=false;
		}
		else if(sstm==0&setm>0){
			if(minutes<setm)
				stateFlag=true;
			else
				stateFlag=false;
		}
		else if(sstm>0&setm>0){
			if(minutes>=sstm&minutes<setm)
				stateFlag=true;
			else
				stateFlag=false;
		}
	}
	else
		stateFlag=false;
	
	stateTxt=stateFlag?"营业中":"休息中";
	$("#state_span").text(stateTxt);
	$("#openTime_span").text(weekdayTxt+shopStartTime+"-"+shopEndTime);
}

function initMerCommList(){
	$.post("selectMerComment",
		{type:2,shopId:shopId},
		function(result){
			var yhpjListDiv=$("#yhpjList_div");
			yhpjListDiv.empty();
			if(result.message=="ok"){
				var mcList=result.list;
				var mcListLength=mcList.length;
				$("#yhpjc_span").text(mcListLength);
				for(var i=0;i<mcListLength;i++){
					var merComm=mcList[i];
					var appendStr="<div class=\"item_div\">";
							appendStr+="<img class=\"pjzhiu_img\" alt=\"\" src=\""+merComm.pjzHeadImgUrl+"\">";
							appendStr+="<span class=\"pjznn_span\">"+merComm.pjzNickName+"</span>";
							appendStr+="<span class=\"createTime_span\">"+merComm.createTime+"</span>";
							appendStr+="<div class=\"content_div\">"+merComm.content+"</div>";
						appendStr+="</div>";
					yhpjListDiv.append(appendStr);
				}
			}
			else{
				$("#yhpjc_span").text("0");
				yhpjListDiv.append("<div class=\"noData_div\">"+result.data+"</div>");
			}
		}
	,"json");
}

function toTreaty(){
	var scId='${requestScope.shareInfo.id }';
	var kzOpenId='${requestScope.shareInfo.openId }';
	var yj='${requestScope.shareInfo.yj }';
	var hyj='${requestScope.shareInfo.hyj }';
	var shareMoney='${requestScope.shareInfo.shareMoney }';
	var sfbfb='${requestScope.shareInfo.sfbfb }';
	var zdfxje='${requestScope.shareInfo.zdfxje }';
	var shopFC='${requestScope.shareInfo.shopFC }';
	var discount='${requestScope.shareInfo.discount }';
	var minDeposit='${requestScope.shareInfo.minDeposit }';
	var scType='${requestScope.shareInfo.scType }';
	var postParams={id:id,shopId:shopId,scId:scId,kzOpenId:kzOpenId,fxzOpenId:openId,yj:yj,hyj:hyj,shareMoney:shareMoney,sfbfb:sfbfb,
			zdfxje:zdfxje,shopFC:shopFC,discount:discount,minDeposit:minDeposit,scType:scType,from:from,openId:openId};
	var urlParams="&page=shareTreaty";
	updatePageValue(postParams,urlParams);
}

function toAddMerComment(){
	var postParams={id:id,shopId:shopId,shopName:shopName,logo:logo,fxzOpenId:openId,from:from,openId:openId};
	var urlParams="&page=shareAMC";
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

function goBack(){
	var goPage;
	if(from=="index")
		goPage="homeIndex";
	else if(from=="vipList")
		goPage="homeScl";
	location.href=path+"vip/goPage?page="+goPage+"&openId="+openId;
}
</script>
<title>分享</title>
</head>
<body>
<div class="top_div">
	<span>${requestScope.shareInfo.shopName }</span>
</div>
<div class="back_div">
	<span class="back_span" onclick="goBack()">&lt;返回</span>
</div>
<div class="logo_div">
	<img class="logo_img" alt="" src="${requestScope.shareInfo.logo }">
</div>
<div class="row_div shopName_div">${requestScope.shareInfo.shopName }</div>
<div class="repuImg_div">
	<img class="repu1_img" id="repu1_img" alt="" src="<%=basePath%>resource/image/star_yellow.png">
	<img class="repu2_img" id="repu2_img" alt="" src="<%=basePath%>resource/image/star_yellow.png">
	<img class="repu3_img" id="repu3_img" alt="" src="<%=basePath%>resource/image/star_yellow.png">
	<img class="repu4_img" id="repu4_img" alt="" src="<%=basePath%>resource/image/star_yellow.png">
	<img class="repu5_img" id="repu5_img" alt="" src="<%=basePath%>resource/image/star_yellow.png">
	<span class="score_span">5</span>
</div>
<div class="row_div state_div">
	<span id="state_span"></span><span class="openTime_span" id="openTime_span"></span>
</div>
<div class="line_div"></div>
<div class="shopAddress_div">${requestScope.shareInfo.shopAddress }</div>
<div class="space_div"></div>
<div class="row_div gxhykxx_div">
	共享会员卡信息
</div>
<div class="row_div scName_div">
	<span class="scName_span">${requestScope.shareInfo.scName }</span>
</div>
<div class="row_div scType_div">
	<span>
		<c:choose>
			<c:when test="${requestScope.shareInfo.scType eq '5' }">
				次卡
			</c:when>
			<c:otherwise>
				金额卡
			</c:otherwise>
		</c:choose>
	</span>
	<c:if test="${requestScope.shareInfo.discount ne null }">
		<span class="discPrice_span">${requestScope.shareInfo.discount }折</span>
	</c:if>
</div>
<div class="row_div scType_div">
	<c:choose>
		<c:when test="${requestScope.shareInfo.scType eq '5' }">
			<span>￥${requestScope.shareInfo.shareMoney }/次</span>
			<span class="consumeCount_span">剩余${requestScope.shareInfo.consumeCount }次</span>
		</c:when>
		<c:otherwise>
			<span>剩余金额：${requestScope.shareInfo.shareMoney }</span>
		</c:otherwise>
	</c:choose>
</div>
<div class="row_div endTime_div">
	到期时间：2021-12-31
	<div class="wyfx_div" onclick="toTreaty()">我要分享</div>
</div>
<div class="line_div"></div>
<div class="describe_div">简介：${requestScope.shareInfo.describe }</div>
<div class="space_div"></div>
<div class="yhpjTit_div">
	<span class="tit_span">用户评价(0)</span>
	<div class="pjBut_div" onclick="toAddMerComment()">评价</div>
</div>
<div class="yhpjList_div" id="yhpjList_div">
	<div class="item_div">
		<img class="pjzhiu_img" alt="" src="">
		<span class="pjznn_span"></span>
		<span class="createTime_span"></span>
		<div class="content_div"></div>
	</div>
</div>
</body>
</html>