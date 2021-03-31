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
<link rel="stylesheet" href="<%=basePath %>resource/css/vip/transfer/tcDetail.css"/>
<script type="text/javascript" src="<%=basePath %>resource/js/jquery-3.3.1.js"></script>
<script type="text/javascript">
var path='<%=basePath%>';
var id='${requestScope.pageValue.id}';
var openId='${param.openId}';
var shopId='${requestScope.transferInfo.shopId }';
var shopName='${requestScope.transferInfo.shopName }';
var logo='${requestScope.transferInfo.logo }';
$(function(){
	initRepuImg();
	initYYInfo();
	initMerCommList();
});

function initRepuImg(){
	var reputation=${requestScope.transferInfo.reputation };
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
	var weekday='${requestScope.transferInfo.weekday}';
	var shopStartTime='${requestScope.transferInfo.shopStartTime }';
	var shopEndTime='${requestScope.transferInfo.shopEndTime }';
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
	var stateTxt;
	if(hour>=shopStartTime&hour<shopEndTime)
		stateTxt="营业中";
	else
		stateTxt="休息中";
	$("#state_span").text(stateTxt);
	$("#openTime_span").text(weekdayTxt+shopStartTime+":00-"+shopEndTime+":00");
}

function initMerCommList(){
	$.post("selectMerComment",
		{type:3,shopId:shopId},
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

function addTransferRecord(){
	var scId='${requestScope.transferInfo.id }';
	var kzOpenId='${requestScope.transferInfo.openId }';
	var shareMoney='${requestScope.transferInfo.shareMoney }';
	var postParams={scId:scId,kzOpenId:kzOpenId,zrzOpenId:openId,shareMoney:shareMoney,openId:openId};
	var urlParams="&page=transferAtr";
	updatePageValue(postParams,urlParams);
}

function toAddMerComment(){
	var postParams={shopId:shopId,shopName:shopName,logo:logo,openId:openId};
	var urlParams="&page=transferAMC";
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
	location.href=path+"vip/goPage?page=transferTcl&openId="+openId;
}
</script>
<title>${requestScope.transferInfo.shopName }</title>
</head>
<body>
<div class="top_div">
	<span>${requestScope.transferInfo.shopName }</span>
</div>
<div class="back_div">
	<span class="back_span" onclick="goBack()">&lt;返回</span>
</div>
<div class="logo_div">
	<img class="logo_img" alt="" src="${requestScope.transferInfo.logo }">
</div>
<div class="row_div shopName_div">${requestScope.transferInfo.shopName }</div>
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
<div class="row_div shopAddress_div">
	${requestScope.transferInfo.shopAddress }
</div>
<div class="space_div"></div>

<div class="line_div"></div>
<div class="row_div gxhykxx_div">
	共享会员卡信息
</div>
<div class="row_div tcName_div">
	<span class="tcName_span">${requestScope.transferInfo.tcName }</span>
</div>
<div class="row_div tcType_div">
	<span>
		<c:if test="${requestScope.transferInfo.tcType eq '1' }">
			金额卡
		</c:if>
		<c:if test="${requestScope.transferInfo.tcType eq '2' }">
			次卡
		</c:if>
	</span>
	<c:if test="${requestScope.transferInfo.discount ne null }">
		<span class="discPrice_span">${requestScope.transferInfo.discount }折</span>
	</c:if>
</div>
<div class="row_div tcType_div">
	<c:if test="${requestScope.shareInfo.tcType eq '1' }">
		<span>剩余金额：${requestScope.transferInfo.shareMoney }</span>
	</c:if>
	<c:if test="${requestScope.transferInfo.tcType eq '2' }">
		<span>￥${requestScope.transferInfo.shareMoney }/次</span>
		<span class="consumeCount_span">剩余${requestScope.transferInfo.consumeCount }次</span>
	</c:if>
	<div class="jszr_div" onclick="addTransferRecord()">接受转让</div>
</div>
<div class="line_div"></div>
<div class="describe_div">会员服务描述：${requestScope.transferInfo.describe }</div>
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