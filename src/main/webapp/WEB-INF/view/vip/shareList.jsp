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
<link rel="stylesheet" href="<%=basePath %>resource/css/vip/shareList.css"/>
<script type="text/javascript" src="<%=basePath %>resource/js/jquery-3.3.1.js"></script>
<script type="text/javascript">
var path='<%=basePath %>';
var openId='${param.openId}';
var type=parseInt('${param.type}');
$(function(){
	initDataListDiv(type);
});

function initDataListDiv(type){
	$("#all_div").attr("class","all_div unSelected");
	$("#dxf_div").attr("class","dxf_div unSelected");
	$("#yxf_div").attr("class","yxf_div unSelected");
	$("#pj_div").attr("class","pj_div unSelected");
	$("#yqx_div").attr("class","yqx_div unSelected");
	$("#zlk_div").attr("class","zlk_div unSelected");
	
	$("#dataList_div").empty();
	var dataListDiv=$("#dataList_div");
	switch(type){
		case 1:
			$("#all_div").attr("class","all_div selected");
			dataListDiv.append("<div class=\"gxdTit_div\">会员共享单</div>");
			dataListDiv.append("<div class=\"shareList_div\" id=\"shareList_div\"></div>");
			dataListDiv.append("<div class=\"zldTit_div\">会员租赁单</div>");
			dataListDiv.append("<div class=\"leaseList_div\" id=\"leaseList_div\"></div>");
			selectShareListByOpenId(type);
			selectLeaseListByOpenId();
			break;
		case 2:
			$("#dxf_div").attr("class","dxf_div selected");
			dataListDiv.append("<div class=\"shareList_div\" id=\"shareList_div\"></div>");
			selectShareListByOpenId(type);
			break;
		case 3:
			$("#yxf_div").attr("class","yxf_div selected");
			dataListDiv.append("<div class=\"shareList_div\" id=\"shareList_div\"></div>");
			selectShareListByOpenId(type);
			break;
		case 4:
			$("#pj_div").attr("class","pj_div selected");
			break;
		case 5:
			$("#yqx_div").attr("class","yqx_div selected");
			dataListDiv.append("<div class=\"shareList_div\" id=\"shareList_div\"></div>");
			selectShareListByOpenId(type);
			break;
		case 6:
			$("#zlk_div").attr("class","zlk_div selected");
			dataListDiv.append("<div class=\"leaseList_div\" id=\"leaseList_div\"></div>");
			selectLeaseListByOpenId();
			break;
	}
}

function selectShareListByOpenId(type){
	$.post("selectShareListByOpenId",
		{type:type,openId:openId},
		function(result){
			var shareListDiv=$("#shareList_div");
			if(result.message=="ok"){
				var shareList=result.data;
				for(var i=0;i<shareList.length;i++){
					var appendStr="";
					appendStr+="<div class=\"item_div\">";
					appendStr+="<div class=\"shopName_div\">"+shareList[i].shopName+"</div>";
					appendStr+="<img class=\"shopLogo_img\" src=\""+shareList[i].shopLogo+"\"/>";
					appendStr+="<span class=\"vipName_span\">卡名："+shareList[i].vipName+"</span>";
					appendStr+="<span class=\"shareMoney_span\">金额："+shareList[i].shareMoney+"</span>";
					appendStr+="<span class=\"ygxfDate_span\">预估消费日期："+shareList[i].ygxfDate+"</span>";
					if(type==2)
						appendStr+="<div class=\"qxBut_div\" onclick=\"showCanncelVipDiv('"+shareList[i].uuid+"')\">取消会员</div>";
					else if(type==3)
						appendStr+="<div class=\"pjBut_div\" onclick=\"goSRDetail('"+shareList[i].uuid+"')\">评价</div>";
					appendStr+="<div class=\"goBut_div\" onclick=\"goSRDetail('"+shareList[i].uuid+"')\">查看详情</div>";
					//appendStr+="<div><img src=\""+shareList[i].qrcodeUrl+"\" style=\"width: 100px;height: 100px;\"/></div>";
					appendStr+="</div>";
					shareListDiv.append(appendStr);
				}
			}
			else{
				shareListDiv.append("<div class=\"noData_div\">"+result.info+"</div>");
			}
		}
	,"json");
}

function selectLeaseListByOpenId(){
	$.post("selectLeaseListByOpenId",
		{openId:openId},
		function(result){
			var leaseListDiv=$("#leaseList_div");
			if(result.message=="ok"){
				var leaseList=result.data;
				for(var i=0;i<leaseList.length;i++){
					leaseListDiv.append("<div class=\"item_div\">"
								+"<div class=\"shopName_div\">"+leaseList[i].shopName+"</div>"
								+"<img class=\"shopLogo_img\" src=\""+leaseList[i].shopLogo+"\"/>"
								+"<span class=\"vipName_span\">卡名："+leaseList[i].vipName+"</span>"
								+"<span class=\"shareMoney_span\">金额："+leaseList[i].shareMoney+"</span>"
								+"<div class=\"goBut_div\" onclick=\"goLRDetail('"+leaseList[i].id+"')\">查看详情</div>"
							+"</div>");
				}
			}
			else{
				leaseListDiv.append("<div class=\"noData_div\">"+result.info+"</div>");
			}
		}
	,"json");
}

function showCanncelVipDiv(uuid){
	$("#canncelVipBg_div #uuid_hid").val(uuid);
	$("#canncelVipBg_div").css("display","block");
}

function hideCanncelVipDiv(){
	$("#canncelVipBg_div #uuid_hid").val("");
	$("#canncelVipBg_div #content_ta").val("");
	$("#canncelVipBg_div").css("display","none");
}

function confirmCanncelVip(){
	var uuid=$("#canncelVipBg_div #uuid_hid").val();
	var content=$("#canncelVipBg_div #content_ta").val();
	$.post("canncelShareVip",
		{srUuid:uuid,content:content,fxzOpenId:openId},
		function(data){
			if(data.status=="ok"){
				alert(data.message);
				location.href=location.href;
			}
		}
	,"json");
}

function goSRDetail(uuid){
	location.href=path+"vip/toSRDetail?uuid="+uuid+"&openId="+openId;
}

function goLRDetail(id){
	location.href=path+"vip/toLRDetail?id="+id+"&openId="+openId;
}

function goBack(){
	location.href=path+"vip/toMine?openId="+openId;
}
</script>
<title>分享单</title>
</head>
<body>
<div class="canncelVipBg_div" id="canncelVipBg_div">
	<div class="canncelVip_div">
		<input type="hidden" id="uuid_hid"/>
		<span class="close_span" onclick="hideCanncelVipDiv()">X</span>
		<div class="title_div">取消会员</div>
		<span class="tiShi_span">请填写取消会员的原因</span>
		<div class="space_div"></div>
		<div class="content_div">
			<textarea class="content_ta" id="content_ta" rows="8" cols="10"></textarea>
		</div>
		<div class="but_div">
			<div class="zbqx_div" onclick="hideCanncelVipDiv()">暂不取消</div>
			<div class="qdqx_div" onclick="confirmCanncelVip()">确定取消</div>
		</div>
	</div>
</div>
<div class="top_div">
	<span class="back_span" onclick="goBack()">&lt;返回</span>
	<span class="wdfxd_span">我的分享单</span>
</div>
<div class="type_div">
	<div class="all_div selected" id="all_div" onclick="initDataListDiv(1)">全部</div>
	<div class="dxf_div unSelected" id="dxf_div" onclick="initDataListDiv(2)">待消费</div>
	<div class="yxf_div unSelected" id="yxf_div" onclick="initDataListDiv(3)">已消费</div>
	<div class="pj_div unSelected" id="pj_div" onclick="initDataListDiv(4)">评价</div>
	<div class="yqx_div unSelected" id="yqx_div" onclick="initDataListDiv(5)">已取消</div>
	<div class="zlk_div unSelected" id="zlk_div" onclick="initDataListDiv(6)">租赁卡</div>
</div>
<div id="dataList_div">
	<div class="gxdTit_div">会员共享单</div>
	<div class="shareList_div" id="shareList_div">
	</div>
	<div class="zldTit_div">会员租赁单</div>
	<div class="leaseList_div" id="leaseList_div">
	</div>
</div>
</body>
</html>