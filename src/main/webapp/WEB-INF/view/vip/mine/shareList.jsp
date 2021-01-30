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
<link rel="stylesheet" href="<%=basePath %>resource/css/vip/mine/shareList.css"/>
<script type="text/javascript" src="<%=basePath %>resource/js/jquery-3.3.1.js"></script>
<script type="text/javascript">
var path='<%=basePath %>';
var vipPath=path+"vip/";
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
	$("#zrk_div").attr("class","zrk_div unSelected");
	
	$("#dataList_div").empty();
	var dataListDiv=$("#dataList_div");
	switch(type){
		case 1:
			$("#all_div").attr("class","all_div selected");
			dataListDiv.append("<div class=\"shareList_div\" id=\"shareList_div\"></div>");
			selectShareListByOpenId(type);
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
			dataListDiv.append("<div class=\"commentList_div\" id=\"commentList_div\"></div>");
			selectCommentListByOpenId();
			break;
		case 5:
			$("#yqx_div").attr("class","yqx_div selected");
			dataListDiv.append("<div class=\"shareList_div\" id=\"shareList_div\"></div>");
			selectShareListByOpenId(type);
			break;
		case 6:
			$("#zrk_div").attr("class","zrk_div selected");
			dataListDiv.append("<div class=\"transferList_div\" id=\"transferList_div\"></div>");
			selectTransferListByOpenId();
			break;
	}
}

function selectTransferListByOpenId(){
	$.post(vipPath+"selectTransferListByOpenId",
		{openId:openId},
		function(result){
			var transferListDiv=$("#transferList_div");
			if(result.message=="ok"){
				var transferList=result.data;
				for(var i=0;i<transferList.length;i++){
					var appendStr="";
					appendStr+="<div class=\"item_div\">";
					appendStr+="<div class=\"shopName_div\">"+transferList[i].shopName+"</div>";
					appendStr+="<img class=\"shopLogo_img\" src=\""+transferList[i].shopLogo+"\"/>";
					appendStr+="<div style=\"height:60px;margin-top:-100px;margin-left:110px;\">";
						appendStr+="<span class=\"scName_span\">"+transferList[i].scName+"</span>";
						appendStr+="<span class=\"shareMoney_span\">￥"+transferList[i].shareMoney+"</span>";
					appendStr+="</div>";
					appendStr+="<div style=\"height:35px;margin-left:110px;\">";
						appendStr+="<span class=\"createTime_span\">支付日期："+transferList[i].createTime+"</span>";
					appendStr+="</div>";
					appendStr+="<div class=\"goBut_div\" onclick=\"goLRDetail('"+transferList[i].id+"')\">查看详情</div>";
					appendStr+="</div>";
					transferListDiv.append(appendStr);
				}
			}
			else{
				transferListDiv.append("<div class=\"noData_div\">"+result.info+"</div>");
			}
		}
	,"json");
}

function selectCommentListByOpenId(){
	$.post(vipPath+"selectCommentListByOpenId",
		{openId:openId},
		function(result){
			console.log(result);
			var commentListDiv=$("#commentList_div");
			if(result.message=="ok"){
				var commentList=result.data;
				for(var i=0;i<commentList.length;i++){
					commentListDiv.append("<div class=\"item_div\">"
								+"<div class=\"createTime_div\">"+commentList[i].createTime+"</div>"
								+"<div class=\"content_div\">"+commentList[i].content+"</div>"
								+"<div class=\"vipInfo_div\">"
									+"<div class=\"shopName_div\">"+commentList[i].shopName+"</div>"
									+"<img class=\"shopLogo_img\" src=\""+commentList[i].shopLogo+"\"/>"
									+"<div style=\"height:60px;margin-top:-100px;margin-left:110px;\">"
										+"<span class=\"scName_span\">"+commentList[i].scName+"</span>"
										+"<span class=\"shareMoney_span\">￥"+commentList[i].shareMoney+"</span>"
									+"</div>"
									+"<div class=\"goBut_div\" onclick=\"goSRDetail('"+commentList[i].used+"','"+commentList[i].uuid+"')\">查看详情</div>"
								+"</div>"
								+"<div class=\"space_div\"></div>"
							+"</div>");
				}
			}
			else{
				commentListDiv.append("<div class=\"noData_div\">"+result.info+"</div>");
			}
		}
	,"json");
	//select m.id,m.createTime,m.content,md.shopName,s.name scName,sr.shareMoney from message m,share_record sr,share_card s,merchant md where m.srUuid=sr.uuid and sr.scId=s.id and s.shopId=md.id
}

function selectShareListByOpenId(type){
	$.post(vipPath+"selectShareListByOpenId",
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
					appendStr+="<div style=\"height:60px;margin-top:-100px;margin-left:110px;\">";
						appendStr+="<span class=\"scName_span\">"+shareList[i].scName+"</span>";
						appendStr+="<span class=\"shareMoney_span\">￥"+shareList[i].shareMoney+"</span>";
					appendStr+="</div>";
					appendStr+="<div style=\"height:35px;margin-left:110px;\">";
						appendStr+="<span class=\"ygxfDate_span\">预估消费日期："+shareList[i].ygxfDate+"</span>";
					appendStr+="</div>";
					if(type==2){
						if(shareList[i].scType==1)
							appendStr+="<div class=\"qrxfBut_div\" onclick=\"confirmConsumeShare('"+shareList[i].uuid+"','"+shareList[i].scType+"')\">确认消费</div>"
						appendStr+="<div class=\"qxBut_div\" onclick=\"showCanncelVipDiv('"+shareList[i].uuid+"')\">取消会员</div>";
					}
					else if(type==3)
						appendStr+="<div class=\"pjBut_div\" onclick=\"goAddComment('"+shareList[i].uuid+"','"+shareList[i].shopName+"','"+shareList[i].shopLogo+"','"+shareList[i].scName+"')\">评价</div>";
					else if(type==5)
						appendStr+="<div class=\"delBut_div\" onclick=\"deleteCFRByUuid('"+shareList[i].uuid+"')\">删除</div>";
					appendStr+="<div class=\"goBut_div\" onclick=\"goSRDetail('"+shareList[i].used+"','"+shareList[i].uuid+"')\">查看详情</div>";
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

function deleteCFRByUuid(srUuid){
	$.post("deleteCFRByUuid",
		{srUuid:srUuid},
		function(data){
			if(data.status=="ok"){
				location.href=location.href;
			}
		}
	,"json");
}

function confirmConsumeShare(uuid,scType){
	$.post("confirmConsumeShare",
		{uuid:uuid,scType:scType},
		function(data){
			if(data.status=="ok"){
				alert(data.message);
				location.href=location.href;
			}
			else{
				alert(data.message);
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
	$.post(vipPath+"canncelShareVip",
		{srUuid:uuid,content:content,fxzOpenId:openId},
		function(data){
			if(data.status=="ok"){
				alert(data.message);
				location.href=location.href;
			}
		}
	,"json");
}

function goSRDetail(used,uuid){
	location.href=vipPath+"goPage?page=srDetail&used="+used+"&uuid="+uuid+"&openId="+openId;
}

function goLRDetail(id){
	location.href=vipPath+"goPage?page=mineLRDetail&id="+id+"&openId="+openId;
}

function goAddComment(srUuid,shopName,shopLogo,scName){
	location.href=vipPath+"goPage?page=mineAddComment&srUuid="+srUuid+"&shopName="+shopName+"&shopLogo="+encodeURIComponent(shopLogo)+"&scName="+scName+"&type="+type+"&openId="+openId;
}

function goBack(){
	location.href=vipPath+"goPage?page=mineInfo&openId="+openId;
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
	<span>我的分享单</span>
</div>
<div class="back_div">
	<span class="back_span" onclick="goBack()">&lt;返回</span>
</div>
<div class="type_div">
	<div class="all_div selected" id="all_div" onclick="initDataListDiv(1)">全部</div>
	<div class="dxf_div unSelected" id="dxf_div" onclick="initDataListDiv(2)">待消费</div>
	<div class="yxf_div unSelected" id="yxf_div" onclick="initDataListDiv(3)">已消费</div>
	<div class="pj_div unSelected" id="pj_div" onclick="initDataListDiv(4)">评价</div>
	<div class="yqx_div unSelected" id="yqx_div" onclick="initDataListDiv(5)">已取消</div>
	<div class="zrk_div unSelected" id="zrk_div" onclick="initDataListDiv(6)">转让卡</div>
</div>
<div id="dataList_div">
	<div class="shareList_div" id="shareList_div">
	</div>
</div>
</body>
</html>