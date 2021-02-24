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
<link rel="stylesheet" href="<%=basePath %>resource/css/vip/mine/handleList.css"/>
<script type="text/javascript" src="<%=basePath %>resource/js/jquery-3.3.1.js"></script>
<script type="text/javascript">
var path='<%=basePath %>';
var vipPath=path+"vip/";
var openId='${param.openId}';
var type=parseInt('${param.type}');
$(function(){
	selectHandleListByOpenId(type);
});

function selectHandleListByOpenId(type){
	$("#all_div").attr("class","all_div unSelected");
	$("#dlq_div").attr("class","dlq_div unSelected");
	$("#ylq_div").attr("class","ylq_div unSelected");
	
	switch (type) {
		case 1:
			$("#all_div").attr("class","all_div selected");
			break;
		case 2:
			$("#dlq_div").attr("class","dlq_div selected");
			break;
		case 3:
			$("#ylq_div").attr("class","ylq_div selected");
			break;
	}
	
	$.post(vipPath+"selectHandleListByOpenId",
		{type:type,openId:openId},
		function(result){
			var handleListDiv=$("#handleList_div");
			handleListDiv.empty();
			if(result.message=="ok"){
				var handleList=result.data;
				for(var i=0;i<handleList.length;i++){
					var appendStr="";
					appendStr+="<div class=\"item_div\">";
					appendStr+="<div class=\"shopName_div\">"+handleList[i].shopName+"</div>";
					appendStr+="<img class=\"shopLogo_img\" src=\""+handleList[i].shopLogo+"\"/>";
					appendStr+="<div style=\"height:60px;margin-top:-100px;margin-left:110px;\">";
						appendStr+="<span class=\"mcName_span\">"+handleList[i].mcName+"</span>";
						if(handleList[i].scType!=5)
							appendStr+="<span class=\"consumeMoney\">余额：￥"+handleList[i].consumeMoney+"</span>";
						else
							appendStr+="<span class=\"shareMoney_span\">消费金额：￥"+handleList[i].shareMoney+"</span>";
					appendStr+="</div>";
					appendStr+="<div style=\"height:35px;margin-left:110px;\">";
						appendStr+="<span class=\"ygxfDate_span\">办卡时间："+handleList[i].createTime+"</span>";
					appendStr+="</div>";
					appendStr+="<div class=\"goBut_div\" onclick=\"goHRDetail('"+handleList[i].receive+"','"+handleList[i].uuid+"')\">查看详情</div>";
					appendStr+="</div>";
					handleListDiv.append(appendStr);
				}
			}
			else{
				handleListDiv.append("<div class=\"noData_div\">"+result.info+"</div>");
			}
		}
	,"json");
}

function goHRDetail(receive,uuid){
	location.href=vipPath+"goPage?page=mineHrDetail&receive="+receive+"&uuid="+uuid+"&openId="+openId;
}

function goBack(){
	location.href=vipPath+"goPage?page=mineInfo&openId="+openId;
}
</script>
<title>新卡</title>
</head>
<body>
<div class="top_div">
	<span>我的新卡</span>
</div>
<div class="back_div">
	<span class="back_span" onclick="goBack()">&lt;返回</span>
</div>
<div class="type_div">
	<div class="all_div selected" id="all_div" onclick="selectHandleListByOpenId(1)">全部</div>
	<div class="dlq_div unSelected" id="dlq_div" onclick="selectHandleListByOpenId(2)">待领取</div>
	<div class="ylq_div unSelected" id="ylq_div" onclick="selectHandleListByOpenId(3)">已领取</div>
</div>
<div class="handleList_div" id="handleList_div">
</div>
</body>
</html>